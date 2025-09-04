Return-Path: <bpf+bounces-67438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC954B43B43
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7C0563491
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3941D2D8777;
	Thu,  4 Sep 2025 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmq5tU5q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4EC2C21C0
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987998; cv=none; b=WrwQzR4eVtOs0rCE4SXukEejrsBqeEpLpPye59ckYibvTf38RT2VCaab0MZZ3M8YVvwNZWLM9fkHdGtiAoBJDmm6DMBl3SWtNWXJRnoaL1MDfeP+nnYLNi2DtmWxea1EtwCedXV6EPF9DXhrEXNXf2v3vp8jHRs7Ve/F9y0Q/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987998; c=relaxed/simple;
	bh=il35HovrBubMxwgeX3RKDLcu129Twp2W6sXn0GSuAio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSUGbtng04YB5f8Az6Q0pHZqTIXKsUb1OudCrUvJzITtZk8n+jv7pmLrpe49GRWgtb/ZI2YP+gaLVUDk9skbL5Qdz/7dKPY8lH42dr/zzuSNYR0WS040Dpl3HcNsOQzsysrrdydkapZYOLCUyKpOpdRBV5tgKmG25lXeIzr/AwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmq5tU5q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso7294285e9.2
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 05:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756987993; x=1757592793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmVwy8YodB+lP59g8H9z4b87/eGCjglymZoa22CljA0=;
        b=Rmq5tU5ql3kn/4/s4WRNhYKsMO6oxIhWOAt+TNO2p0dttt/eliulHY3l0Yx2wVeX37
         Y2G2pbAF/2VqnrmxbEDp/zurR9MMUHh6hXei1id6qgVLzS1ul6DTt8/RAs9n3QBNJTZE
         KlKGBiFiGl5gBbDx3CvHz45mes+te1DQlcvEdhPGu+rm9FN3lnRxzYMKR4TK/rw79O8a
         XCvZCyX34IHfXoRfS64TJqphQQ8zukbqaryHjJuRd9mUkPNwHeGeGLZ2i7CJtxQEyAjG
         tnTSZ9kihvuO2YoSv3l5otaVTuOnZ7cSFgrZX2MzseIe8OiLJxnLbcDytUG35U59ILiy
         haRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756987993; x=1757592793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmVwy8YodB+lP59g8H9z4b87/eGCjglymZoa22CljA0=;
        b=SCMpHe72MMELNICDDDzJSVc7B/znjCun2+y4OjrRLlynFS+OYFX4nkBFbt0SKXuNUM
         rDSHGKVjG1US7vQDEDmXgrO66mPcW0sxmFl5k7oogNxf+uEcBzjR47bjr+Yh0dcfdJG8
         6YYSynaBUtxtbyPoHx1mF6zjL4ErhCtvW1pihKg7v4VE5DjJBN8qR+DYKIubo6DvDHy8
         lwDBhDuyqCFcYrqyaW1It30c2is0n7RVFTQr9RJUTw9GqkqD50DR+lb7eZ+sLsFc45yH
         xgkilty5e/48acHosSJ3EfLIGc+SPkIbuk1v34xGwjZpj9GYBp3tRPOfqpbhubKawA2j
         ++lw==
X-Gm-Message-State: AOJu0YyWmDaTgkzGE5kRyQaYCXDLPh51G9u89BNSR0XzNmHnB2cW7IHW
	Tg+bWlXXn8b9dHFGc0rxsrUu9KryzB+jJpahAJvgew7hFq2vjV5jfJPtBR/yPi+bOj0=
X-Gm-Gg: ASbGncv5vWMmx04rJzAbUM7yX21gO0UYSxsQTe1Edjl/NSZuVomxmik+Kk57AjyGEno
	4+XykyO/HEePjjhkNFlGnLPp7cIyFXmnfd+C8e0H5jDUwfju4UtMZiVhyFZYgB2aWpN0PRzqdGO
	Mn7wNovg3fihvIiACYHEBFAJ+E9UItMosPOUpKmG6ii/N9PZXx/NaNzdsSiRzswdWbpf9sq4UGi
	mJJv3ObqbAc+YH2AKPrd8I1uzjAwg4EYlcoI5UEXQn0MCipuTwwbYBxyDVlQf3Rbqdllfwm/l2W
	LtczqdUl/duEFEioHGRYRDbw3AvCTk+7hrJ272O1Co03WobQCijX6AWyfuLpXDxSCC8c+2yPasu
	M1SzOGB16AhVsDUSqpzvKzeCxxGx4BpCP1cGfBXUHGeKikwRQ/T/LmRbcVMl3QXnqRvyFQ4AAyB
	zcIfJ6TJmiRwOkWEXx7mnA
X-Google-Smtp-Source: AGHT+IGibuFhlK4Uon9iGFEdyp284D1AyNtOGqxmUhu7hpumzegjGniZVyPoUug4ToB/52G3lFPwug==
X-Received: by 2002:a05:600c:45c9:b0:458:bbed:a81a with SMTP id 5b1f17b1804b1-45b877be05bmr171536085e9.10.1756987993220;
        Thu, 04 Sep 2025 05:13:13 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0084ffa21ee1457b9b.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:84ff:a21e:e145:7b9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45c6faad9cfsm95546865e9.0.2025.09.04.05.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:13:12 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:13:11 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: Support non-linear flag in test
 loader
Message-ID: <b2bd8feae12ec264c5441c1aa873e903ebd54d32.1756983952.git.paul.chaignon@gmail.com>
References: <cover.1756983951.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756983951.git.paul.chaignon@gmail.com>

Contrary to most flags currently used in selftests, the
BPF_F_TEST_SKB_NON_LINEAR flag is not passed at program loading time,
but when calling BPF_PROG_TEST_RUN. This patch updates the test loader
to support it.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index a9388ac88358..4e0a03276f6b 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -91,6 +91,7 @@ struct test_spec {
 	const char *btf_custom_path;
 	int log_level;
 	int prog_flags;
+	int run_flags;
 	int mode_mask;
 	int arch_mask;
 	int load_mask;
@@ -554,6 +555,8 @@ static int parse_test_spec(struct test_loader *tester,
 				update_flags(&spec->prog_flags, BPF_F_XDP_HAS_FRAGS, clear);
 			} else if (strcmp(val, "BPF_F_TEST_REG_INVARIANTS") == 0) {
 				update_flags(&spec->prog_flags, BPF_F_TEST_REG_INVARIANTS, clear);
+			} else if (strcmp(val, "BPF_F_TEST_SKB_NON_LINEAR") == 0) {
+				update_flags(&spec->run_flags, BPF_F_TEST_SKB_NON_LINEAR, clear);
 			} else /* assume numeric value */ {
 				err = parse_int(val, &flags, "test prog flags");
 				if (err)
@@ -854,7 +857,7 @@ static bool is_unpriv_capable_map(struct bpf_map *map)
 	}
 }
 
-static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
+static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts, int run_flags)
 {
 	__u8 tmp_out[TEST_DATA_LEN << 2] = {};
 	__u8 tmp_in[TEST_DATA_LEN] = {};
@@ -864,6 +867,7 @@ static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
 		.data_size_in = sizeof(tmp_in),
 		.data_out = tmp_out,
 		.data_size_out = sizeof(tmp_out),
+		.flags = run_flags,
 		.repeat = 1,
 	);
 
@@ -1103,7 +1107,8 @@ void run_subtest(struct test_loader *tester,
 		}
 
 		err = do_prog_test_run(bpf_program__fd(tprog), &retval,
-				       bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false);
+				       bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false,
+				       spec->run_flags);
 		if (!err && retval != subspec->retval && subspec->retval != POINTER_VALUE) {
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
 			goto tobj_cleanup;
-- 
2.43.0


