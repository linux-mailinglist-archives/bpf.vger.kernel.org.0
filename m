Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C95FCED9
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 01:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJLXUb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 19:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJLXUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 19:20:30 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772A8B8C0E;
        Wed, 12 Oct 2022 16:20:29 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id z8so67985qtv.5;
        Wed, 12 Oct 2022 16:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9b28V7P/p+ltszS+L5057qYj43+A9hBHY9xbUGqv+o=;
        b=yv1OaDzw5DkrGqsmOQApbeWlNd73zvUkSDGuOt2cWE9bAoEWMgijgQuobmQYte+A2C
         1BYKFLC/F7+rf+ztRU+LNLKc6G3TCxEbrh03/++FKUJj4+b5KGuPlylfgSRY7knTQL+4
         lOLxoy+6fvF1HdQFg28chV3f2JfeDC59H3pusEkAH2JV/thTp8jUulAsnUMOPn+hW7Ba
         PSCd+nTpIYH8vaKKLkafOzmLZvdmx6EqmQmmgv2OtcHDNqKtQPu8FRN3rB51DBMqpcTO
         qkigFuDdUPGVXHWjmeEGaWr9V+YQusb1wf015bsLWteIh85uWBxToC3Pxolf5eeEp0OT
         Fa4A==
X-Gm-Message-State: ACrzQf1+efxgCn1XmYoAZswLNhIEZ+TEFT2iSb198RS9FCmx/dfQN/SJ
        jbWqAvnGhUJAAA6Wlu6kk5/FCN9VWzPiFQ==
X-Google-Smtp-Source: AMsMyM7FEK8MYS+xJIppJ6NGURsKtXSO8Fz1EqGg29JqrkiB7B73plRSv1iXRxm6XT9/Iy7Miggmcw==
X-Received: by 2002:a05:622a:1047:b0:35c:c042:194c with SMTP id f7-20020a05622a104700b0035cc042194cmr25971495qte.484.1665616828428;
        Wed, 12 Oct 2022 16:20:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1a0b])
        by smtp.gmail.com with ESMTPSA id l13-20020ac84ccd000000b00399edda03dfsm7856014qtv.67.2022.10.12.16.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 16:20:28 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, martin.lau@linux.dev,
        daniel@iogearbox.net, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/2] bpf: Allow bpf_user_ringbuf_drain() callbacks to return 1
Date:   Wed, 12 Oct 2022 18:20:14 -0500
Message-Id: <20221012232015.1510043-2-void@manifault.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221012232015.1510043-1-void@manifault.com>
References: <20221012232015.1510043-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_user_ringbuf_drain() helper function allows a BPF program to
specify a callback that is invoked when draining entries from a
BPF_MAP_TYPE_USER_RINGBUF ring buffer map. The API is meant to allow the
callback to return 0 if it wants to continue draining samples, and 1 if
it's done draining. Unfortunately, bpf_user_ringbuf_drain() landed shortly
after commit 1bfe26fb0827 ("bpf: Add verifier support for custom
callback return range"), which changed the default behavior of callbacks
to only support returning 0.

This patch corrects that oversight by allowing bpf_user_ringbuf_drain()
callbacks to return 0 or 1. A follow-on patch will update the
user_ringbuf selftests to also return 1 from a bpf_user_ringbuf_drain()
callback to prevent this from regressing in the future.

Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f6d2d511c06..9ab7188d8f68 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6946,6 +6946,7 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 
 	callee->in_callback_fn = true;
+	callee->callback_ret_range = tnum_range(0, 1);
 	return 0;
 }
 
-- 
2.38.0

