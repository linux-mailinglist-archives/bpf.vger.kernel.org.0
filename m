Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6267DA23
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 01:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjA0ACo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 19:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjA0ACn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 19:02:43 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106945BB3
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 16:02:41 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id 5D2644BA36B2; Thu, 26 Jan 2023 15:38:30 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        ast@kernel.org, netdev@vger.kernel.org, memxor@gmail.com,
        kernel-team@fb.com, Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v8 bpf-next 1/5] bpf: Allow "sk_buff" and "xdp_buff" as valid kfunc arg types
Date:   Thu, 26 Jan 2023 15:34:35 -0800
Message-Id: <20230126233439.3739120-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126233439.3739120-1-joannelkoong@gmail.com>
References: <20230126233439.3739120-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf mirror of the in-kernel sk_buff and xdp_buff data structures are
__sk_buff and xdp_md. Currently, when we pass in the program ctx to a
kfunc where the program ctx is a skb or xdp buffer, we reject the
program if the in-kernel definition is sk_buff/xdp_buff instead of
__sk_buff/xdp_md.

This change allows sk_buff and __sk_buff, and xdp_buff and xdp_md to be
valid matches. The user program may pass in their program ctx as a
__sk_buff or xdp_md, and the in-kernel definition of the kfunc may
define this arg as a sk_buff or xdp_buff. Please note that the
__sk_buff/xdp_md -> sk_buff/xdp_buff conversion happens in
convert_ctx_accesses() in the verifier.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/btf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 47b8cb96f2c2..b4da17688c65 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5606,6 +5606,10 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log=
, const struct btf *btf,
 	 * int socket_filter_bpf_prog(struct __sk_buff *skb)
 	 * { // no fields of skb are ever used }
 	 */
+	if (strcmp(ctx_tname, "__sk_buff") =3D=3D 0 && strcmp(tname, "sk_buff")=
 =3D=3D 0)
+		return ctx_type;
+	if (strcmp(ctx_tname, "xdp_md") =3D=3D 0 && strcmp(tname, "xdp_buff") =3D=
=3D 0)
+		return ctx_type;
 	if (strcmp(ctx_tname, tname))
 		return NULL;
 	return ctx_type;
--=20
2.30.2

