Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A34958CA20
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiHHOHn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbiHHOHm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:07:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85282677
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 617EFB80EAF
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB084C433D6;
        Mon,  8 Aug 2022 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967659;
        bh=42IpPeJC0f9IzSX4fKvJWlllc4pn4JGafRldGuu6ebQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JyZyS5bhmiwllF1ee969z9a1ADguqdovyHpOmwv5krRB0IXJaTD3nISeFWKq2fKRv
         F4KKun/tlpxtPyR5+bDs8mkEKF8DJ8+k4+XvmM2RDDfD03Hla3pw2fmODd/x8nOhzs
         ySx8lLl6ESvDNHTkagoHM8y7IpUAR6sAJHT0a5nMSgl4jOyZ+1x2cJywUDYEWlcBJt
         O/CwLRV/FAwKrQKT3AK1P8ZcnqFrxbllSjqrnwH+CkB070AtQEUxH9DfHBNB/ttTHS
         bnY9aDo5jvnWavGQghSoivQQCDI0QQrQ1XTXyBDQ18X7Fm2iUbkIzZo8fXP3F8BrkE
         bgf8LKO4ceSKQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH bpf-next 06/17] bpf: Pass image struct to reg/unreg/modify fentry functions
Date:   Mon,  8 Aug 2022 16:06:15 +0200
Message-Id: <20220808140626.422731-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
References: <20220808140626.422731-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Passing image struct to reg/unreg/modify fentry functions
as a preparation for following change, where we need to
use the whole image in the update logic.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index c0983ff5aa3a..d28070247fa3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -244,8 +244,9 @@ static void bpf_trampoline_module_put(struct bpf_trampoline *tr)
 	tr->mod = NULL;
 }
 
-static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
+static int unregister_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im)
 {
+	void *old_addr = im->image;
 	void *ip = tr->func.addr;
 	int ret;
 
@@ -259,9 +260,11 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	return ret;
 }
 
-static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_addr,
+static int modify_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im,
 			 bool lock_direct_mutex)
 {
+	void *old_addr = tr->cur_image->image;
+	void *new_addr = im->image;
 	void *ip = tr->func.addr;
 	int ret;
 
@@ -277,8 +280,9 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 }
 
 /* first time registering */
-static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
+static int register_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im)
 {
+	void *new_addr = im->image;
 	void *ip = tr->func.addr;
 	unsigned long faddr;
 	int ret;
@@ -486,7 +490,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		return PTR_ERR(tprogs);
 
 	if (total == 0) {
-		err = unregister_fentry(tr, tr->cur_image->image);
+		err = unregister_fentry(tr, tr->cur_image);
 		bpf_tramp_image_put(tr->cur_image);
 		tr->cur_image = NULL;
 		tr->selector = 0;
@@ -532,10 +536,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	WARN_ON(!tr->cur_image && tr->selector);
 	if (tr->cur_image)
 		/* progs already running at this address */
-		err = modify_fentry(tr, tr->cur_image->image, im->image, lock_direct_mutex);
+		err = modify_fentry(tr, im, lock_direct_mutex);
 	else
 		/* first time registering */
-		err = register_fentry(tr, im->image);
+		err = register_fentry(tr, im);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	if (err == -EAGAIN) {
-- 
2.37.1

