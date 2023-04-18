Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118C46E6FB0
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 00:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjDRWxz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 18:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjDRWxy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 18:53:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2327A49C6
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63b57ad54a1so1635435b3a.3
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681858432; x=1684450432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcTzD+ou3EW7Lw9ylc6tvLwQ/+is1njQ+SAvZ8e1ozo=;
        b=F2uJTlUKBR39aPuUDPULObflN/ETYnupGXMJppPvECdpzp8t6aOEPDBfxWXggxCf+6
         eOpVm+dBdrQemWmApwt3cmz1TVPiFkJHmznBzSofeIZHXcustFWHg6ZvrRbjSjjExYWi
         KTCs9hluDJl5i0xh9ADx8zJHvpqkGWY7DdkgFrbOEMBjBNoMaPJDWcI8IYUQLZcWY37h
         vZWobjMRkXLtvc2pu2Mt/IHfWAX+qwpmT59Rm/qnlONoADBFAp9v09J33ya11fWOwtgj
         TtJipGvvml3y+jz6ZuzyRIIbr3rUFVNVF9GEKNRcBc5pxdtvOBrlNfn2NwyOvydfuS6u
         AqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858432; x=1684450432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcTzD+ou3EW7Lw9ylc6tvLwQ/+is1njQ+SAvZ8e1ozo=;
        b=lCKjnHM4WFJYrUqgrPZ52l/YtjZ6b/87WojmjYPlocWRgFbGqJzwUBVw66wrj519zg
         e74LnsjTri3IAbVhpvXXqda1Lh1wiIEYK4Ro4MJXI70FVTXgvqLYtwifvZrmoioq1Jn5
         Vt4T2AxVSDQhDlBv8EDPR55Ypkco0Q3rL+9Tb1y4fptQUpVRNw/OgT5Y1pAEc0L8w1F7
         rkjjI9700N1+uxgbyjUP6pD2ehG0Goz09k7vigOlEuygFiApADdC0TDjsjQkKKkKMrpA
         +X3xHilY1cjAmqo6dv75PHOYKrL3UYtLYAxRrJpOFkdzE1RN8RZ1s7ZgRSSu8YLwyMYt
         aYnw==
X-Gm-Message-State: AAQBX9f2RadRigTfKKaRSREEX96X3T0o9F7fqP9tKvhbBGMtQGlVgZsy
        FQ6FyhKQ/Hflxqrp7tjyYCBuq3lTIe+pXCUtmom5dICziXa9D7aTEmkGrP/DO8WX9S82nNqkKpp
        lIX3VdPLh0d13B22tEY+dGMq9HYg1uiXgmj59dYOx+oNIxapyJw==
X-Google-Smtp-Source: AKy350ZNbox8LqIixuIUWYtDLr22Ez3Ycon5DyEyqHfaI9Y+A3StCGkMNuzc6LqZHQqmmsXHk5R+mSs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1782:b0:63d:2cff:bfad with SMTP id
 s2-20020a056a00178200b0063d2cffbfadmr685270pfg.6.1681858432354; Tue, 18 Apr
 2023 15:53:52 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:53:41 -0700
In-Reply-To: <20230418225343.553806-1-sdf@google.com>
Mime-Version: 1.0
References: <20230418225343.553806-1-sdf@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418225343.553806-5-sdf@google.com>
Subject: [PATCH bpf-next 4/6] selftests/bpf: Update EFAULT {g,s}etsockopt selftests
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of assuming EFAULT, let's assume the BPF program's
output is ignored.

Remove "getsockopt: deny arbitrary ctx->retval" because it
was actually testing optlen. We have separate set of tests
for retval.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/sockopt.c        | 42 ++++++-------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index aa4debf62fc6..bff7d91d1e1d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -249,7 +249,7 @@ static struct sockopt_test {
 		.get_optlen = 64,
 	},
 	{
-		.descr = "getsockopt: deny bigger ctx->optlen",
+		.descr = "getsockopt: ignore bigger ctx->optlen",
 		.insns = {
 			/* ctx->optlen = 65 */
 			BPF_MOV64_IMM(BPF_REG_0, 65),
@@ -268,28 +268,10 @@ static struct sockopt_test {
 		.attach_type = BPF_CGROUP_GETSOCKOPT,
 		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
 
-		.get_optlen = 64,
-
-		.error = EFAULT_GETSOCKOPT,
-	},
-	{
-		.descr = "getsockopt: deny arbitrary ctx->retval",
-		.insns = {
-			/* ctx->retval = 123 */
-			BPF_MOV64_IMM(BPF_REG_0, 123),
-			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
-				    offsetof(struct bpf_sockopt, retval)),
-
-			/* return 1 */
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.attach_type = BPF_CGROUP_GETSOCKOPT,
-		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
-
-		.get_optlen = 64,
-
-		.error = EFAULT_GETSOCKOPT,
+		.get_level = SOL_IP,
+		.get_optname = IP_TOS,
+		.get_optval = {},
+		.get_optlen = 4,
 	},
 	{
 		.descr = "getsockopt: support smaller ctx->optlen",
@@ -627,9 +609,10 @@ static struct sockopt_test {
 		.attach_type = BPF_CGROUP_SETSOCKOPT,
 		.expected_attach_type = BPF_CGROUP_SETSOCKOPT,
 
-		.set_optlen = 4,
-
-		.error = EFAULT_SETSOCKOPT,
+		.set_level = SOL_IP,
+		.set_optname = IP_TOS,
+		.set_optval = { 1 << 3 },
+		.set_optlen = 1,
 	},
 	{
 		.descr = "setsockopt: deny ctx->optlen > input optlen",
@@ -644,9 +627,10 @@ static struct sockopt_test {
 		.attach_type = BPF_CGROUP_SETSOCKOPT,
 		.expected_attach_type = BPF_CGROUP_SETSOCKOPT,
 
-		.set_optlen = 64,
-
-		.error = EFAULT_SETSOCKOPT,
+		.set_level = SOL_IP,
+		.set_optname = IP_TOS,
+		.set_optval = { 1 << 3 },
+		.set_optlen = 1,
 	},
 	{
 		.descr = "setsockopt: allow changing ctx->optlen within bounds",
-- 
2.40.0.634.g4ca3ef3211-goog

