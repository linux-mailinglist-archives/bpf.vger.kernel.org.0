Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1108E674DB1
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjATHEp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjATHEo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:04:44 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962A530D7
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:43 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d9so4559440pll.9
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyTWOZilBFDAJAIdzvGkhUiQOCd5v7yklxBaXynN35o=;
        b=T1y1G6871uDzt9PPygMPduYST6f5C4V9yqZrJDfNs4SYywD2qY3NoMa5yS0NX4yNY2
         p4w6EmjMcs7a6Y0ENSDAOY0oNs+E3lgUfT23JCnacoeIZ8SnwjlcFzQgN4j+PxAFALZq
         7HO+ktUa5RHBtaDkcZNoqhIWn9pwcFAbGrIzCO4sHlBXfpr5I0iOOZrf0+f1YjcikdrN
         AAkV4W6OeEXqve/plCI4NvodrX/WfbAbZcgc9yTISC2pTrZUn3q47pcqEhAvB/pFFyuv
         6ZAOvRhSQdyhsM5enKImUtK9qb7Ak5z/Yl2Ce1cDjfxOgzZ0NzxVsFOyqKW0o8h0r18W
         NZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyTWOZilBFDAJAIdzvGkhUiQOCd5v7yklxBaXynN35o=;
        b=HPWWwAPo53MLW/Sv6sou/O07QOWy06YWeeKqLBMAyeuoyH2cZYYVRZb/DIoPqP59jI
         SZqW88m4vhKFJRktul2u8loQ9GzvOqwF+El98AQwLGEGhmasRLTe423erfF8d0C0/jae
         GnZDPXv1rXk+Nhn63ce48yQlipPT+tAf3nF6fljjxKbxGRCzKEyGfMzM2Y7Hok7Z7yFi
         Fw+Vrv2pY3A/KABCHhTT1obyALzPQlBs9qb2hm4GQt+W9OVbKy1KrGylBOA9EW+8crPb
         7YJ4AyOERP4cND7iumGRfn5clT/D+5HEvY/d93qpl5+XF32iJoLV5upcCw+2C9oD/yJA
         CmNQ==
X-Gm-Message-State: AFqh2krPUbH903bOjSk797DlDfaI9ZJ7v5baURlTBbjx6xuzK5nHzgE9
        w+G9En8StHCwnbZ3CnluqzvXzzFG4nE=
X-Google-Smtp-Source: AMrXdXvctzyr80C+xnoA7AxnmV3JFBhr1Tthefh4TvYkblcA3n5VJmIR58W3ZF+zCtPEkXm3XX9Qmg==
X-Received: by 2002:a17:90a:f30e:b0:229:27a2:d80f with SMTP id ca14-20020a17090af30e00b0022927a2d80fmr14584940pjb.23.1674198282228;
        Thu, 19 Jan 2023 23:04:42 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b00194ab9a4febsm6309823plf.74.2023.01.19.23.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:04:41 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 12/12] selftests/bpf: Add dynptr helper tests
Date:   Fri, 20 Jan 2023 12:33:55 +0530
Message-Id: <20230120070355.1983560-13-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120070355.1983560-1-memxor@gmail.com>
References: <20230120070355.1983560-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3628; i=memxor@gmail.com; h=from:subject; bh=KrTMop4yccSalaFbkhQLR70jCCGcHJeO+aSXiPpo0lA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyjzMJ5kE1rcwnr3HwfkUejt1ifNTCMP0HJbgxP48 p5T38yeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8o8zAAKCRBM4MiGSL8RylxLEA CpxqIv0gutmrt8bnDHFI1StkTS4+jClyK0gTAi6VLPH5BwlPUyHMZfe9/pafsUPwg3AJWHziqWhJ0e VM8jLzrRbyd9ol2IEUVJjgDoGEqtaX/UPWGV0V5vr8UX0ARa8YmL85SVlIDqyqKVRT2SOzeNiLIioK /c6sw/UI01Kn1YuIpI7UQw6bsGfnZoeNUhVHtA+lt9DaJwDenb88nLUNJ+0DuEtSYb+0KjUzcfporl 3MNJbdNtBLQopchNBGIpyZVdO8Ld81hsusU3t7W/xACwLi3yEyHqMPnE7s4M3vI9pTWVbRBUf4DBYQ +/2SLaWauIKKyCO4ghAgLRiztXEnaI3l22iIWfgtpO2bH1s2qxsksytSOWjV7P5UIPfszJ39MbOtpq k1gnfL9Zc/E1GhgYOYYErYzRKMGMw8bVsHbq6GjXdgnjMxg4YG01PAFAMaoc9Vux3JpRISciBcx+ke fR9ADycoC1UNRb6mITk6chIiZ+XzQavAqPR+xsRwQnp4qE7U/ywAmYLo4dgDK08ToCr4oS5TwCc4A6 Yv/2dzcM/1AIq9Qr/6GUAlhBEoW+m0tZG2YcKgYC+z04fosbg0qfmz5ehtK7CPdBOETH4W5pFsuq19 8LYf4RukK+HGF69WGG84+17vJVaNjhczfUB6iKkYQHirhPy3DH67QroMpV2Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First test that we allow overwriting dynptr slots and reinitializing
them in unreferenced case, and disallow overwriting for referenced case.
Include tests to ensure slices obtained from destroyed dynptrs are being
invalidated on their destruction. The destruction needs to be scoped, as
in slices of dynptr A should not be invalidated when dynptr B is
destroyed. Next, test that MEM_UNINIT doesn't allow writing dynptr stack
slots.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 1cbec5468879..c10abb98e47d 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -900,3 +900,132 @@ int dynptr_partial_slot_invalidate(struct __sk_buff *ctx)
 	);
 	return 0;
 }
+
+SEC("?raw_tp")
+__success
+int dynptr_overwrite_unref(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("R1 type=scalar expected=percpu_ptr_")
+int dynptr_invalidate_slice_or_null(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u8 *p;
+
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+
+	p = bpf_dynptr_data(&ptr, 0, 1);
+	*(__u8 *)&ptr = 0;
+	bpf_this_cpu_ptr(p);
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("R7 invalid mem access 'scalar'")
+int dynptr_invalidate_slice_failure(void *ctx)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+	__u8 *p1, *p2;
+
+	if (get_map_val_dynptr(&ptr1))
+		return 0;
+	if (get_map_val_dynptr(&ptr2))
+		return 0;
+
+	p1 = bpf_dynptr_data(&ptr1, 0, 1);
+	if (!p1)
+		return 0;
+	p2 = bpf_dynptr_data(&ptr2, 0, 1);
+	if (!p2)
+		return 0;
+
+	*(__u8 *)&ptr1 = 0;
+	return *p1;
+}
+
+SEC("?raw_tp")
+__success
+int dynptr_invalidate_slice_success(void *ctx)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+	__u8 *p1, *p2;
+
+	if (get_map_val_dynptr(&ptr1))
+		return 1;
+	if (get_map_val_dynptr(&ptr2))
+		return 1;
+
+	p1 = bpf_dynptr_data(&ptr1, 0, 1);
+	if (!p1)
+		return 1;
+	p2 = bpf_dynptr_data(&ptr2, 0, 1);
+	if (!p2)
+		return 1;
+
+	*(__u8 *)&ptr1 = 0;
+	return *p2;
+}
+
+SEC("?raw_tp")
+__failure __msg("cannot overwrite referenced dynptr")
+int dynptr_overwrite_ref(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+	if (get_map_val_dynptr(&ptr))
+		bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+/* Reject writes to dynptr slot from bpf_dynptr_read */
+SEC("?raw_tp")
+__failure __msg("potential write to dynptr at off=-16")
+int dynptr_read_into_slot(void *ctx)
+{
+	union {
+		struct {
+			char _pad[48];
+			struct bpf_dynptr ptr;
+		};
+		char buf[64];
+	} data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &data.ptr);
+	/* this should fail */
+	bpf_dynptr_read(data.buf, sizeof(data.buf), &data.ptr, 0, 0);
+
+	return 0;
+}
+
+/* Reject writes to dynptr slot for uninit arg */
+SEC("?raw_tp")
+__failure __msg("potential write to dynptr at off=-16")
+int uninit_write_into_slot(void *ctx)
+{
+	struct {
+		char buf[64];
+		struct bpf_dynptr ptr;
+	} data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 80, 0, &data.ptr);
+	/* this should fail */
+	bpf_get_current_comm(data.buf, 80);
+
+	return 0;
+}
-- 
2.39.1

