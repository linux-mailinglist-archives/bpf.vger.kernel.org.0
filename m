Return-Path: <bpf+bounces-4896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B8751654
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF5280C18
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20977FC;
	Thu, 13 Jul 2023 02:32:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA817C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:32:43 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1F9100
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:42 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 5614622812f47-3a3b7fafd61so220123b6e.2
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215560; x=1691807560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ropIrAVLQYm2YcXI4bbAuo3188dUL4M6GB0nJbYk2BI=;
        b=EbHyplpluHX9s9Et4ahtFaZhsYAwnYKMVaDo2xTnh+CvW7KSCxI3IBR8xkYrpsQSvU
         DW/BfDpLgsUSFyJcaKjM/7XHkSNI376wwvkTC2h1D0K4xdlddlhxWubsGfg0uJhhcSA0
         DMqwje/9PRI6xTSMos+5Vx539i3fHG9U6uKP4KIUyt4f4Sqs24S80lI0fPUrC1kwu9M1
         pD84Y7QUaQkEU8WpfqAM06MVcgBeTiQWUvCkpvVWXzUY+vliTzkiHV8IC3Li5H5QakgF
         cef+Qvl0+J26B8sH3+zN8pn6BsCccMM1Okjk23QEhyPcZMV1GixdHgVdRodaT5U2R/n3
         4hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215560; x=1691807560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ropIrAVLQYm2YcXI4bbAuo3188dUL4M6GB0nJbYk2BI=;
        b=b6C84O4EBNZMUlw8d+zNs1zwExwd8J8NwMJTgj0VU4ONV6/+GRYFc5513HZLJpieXb
         2AweLTLIZ2GpgL3lzRxRXjrtLo3sh7rUMl2l4rILQ1EptneqMDv9LOLRmA2QABNLaJdZ
         l6CyOeIPSsjgojg6/psZ5YoiZ7lau7Ji6HRg3x2GHAzyxsIb8jzg1+ldoSOp3BKeRy6+
         PXL9jwdfJ392CJggkBxd8o1gyMdUn8loNrriiEBdFROUvI7mOkKzRosD5o8PJdgsVpBf
         W4O4B+dA0aqKY/1/mjJ3LEB2pqFN+D+Mzviublve4HpgnefuOrbJNJdumXxr3FuJZIaf
         +Jrw==
X-Gm-Message-State: ABy/qLZz3uFxCMBWOcln5bT46/ryutLUQM/85PQNzS60bGAdiCrpTKir
	K/qw9YxDb0JeY3JOrgJQfbEA/Vi3xmN+Bg==
X-Google-Smtp-Source: APBJJlHhAzMUZ1goOxwLurGbT99RoiYVY88ghtzVknyFdVfoTQTp8pgtGiyputs+ihexQg6kj+4Fnw==
X-Received: by 2002:a05:6808:159f:b0:3a3:ed1f:6376 with SMTP id t31-20020a056808159f00b003a3ed1f6376mr373652oiw.43.1689215560499;
        Wed, 12 Jul 2023 19:32:40 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78c04000000b0063afb08afeesm4241984pfd.67.2023.07.12.19.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:32:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Dave Marchevsky <davemarchevsky@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 01/10] bpf: Fix kfunc callback register type handling
Date: Thu, 13 Jul 2023 08:02:23 +0530
Message-Id: <20230713023232.1411523-2-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713023232.1411523-1-memxor@gmail.com>
References: <20230713023232.1411523-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=memxor@gmail.com; h=from:subject; bh=n4c3/yhJhcy+RNsNpcu+6ta3NIE0EeM/R9cVgNtvyQc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr2HFyrdtws6Bqly2KXgnQNteG3/Z++JnivfB9 g+gdHyjHrSJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9hxQAKCRBM4MiGSL8R ynjwD/9Or+Cm1mfmRmc6Uf1ATncFQhN/XgaiNNKzppSDit+VBVkfn5zoKI7Radu1kncvD1vDZIH g/P3r1h8GSLIlrAywosDuGfzqwE6SjBXwkkXXcoBay5nawLR9dw15dHp2HC3LJYloyXpXqOnzgc 2m6rHVvWzEcYOfqbC7Or22bL7mWBooDe3pcjvlnLgbgwxvBMTay3yXPx7JGG0hMZc0PTCl3Ifl2 Oijv3ozgzVVSqhz3LAycvVG764HX9e8tNoG+eoMjwN1iQ3AMvNHC4kD2ih/jobJr6d0bIT1M7PQ obLRUKZXY3OvmWPI7QQKXzI96Vn3CQCjbSuc3nCnKXDQL+tJLuzTjWkcn5VzGoSlo+fCgXwMhDI plZz2h4M+8IkS8tTnTaDReEsUwudS8rJREh6c7q2PFxNtJmURpoyzJuOdDPxdCZ+JuLdjAErPH0 tCfuHH7ilOHDXaDgYmj54Ex6wswaKpErZHH/8EaYfyZExWJR8Gyxt5S+KPom77l1c6t2OislX3V Kf9jS+QZrbrZZyQZ1536AApxbCfkXNSXkxv7/FDoUQthtJ6HaLLQEZb223BMX7OUvcfFFzIEvaJ COFaKJSn/FEtcu1VC41nF51qfg9jdpXq60LKI4t31HdbfXRTm/2mbANGUZ8eO4h6WqfyIzHPeeJ ottdqwwgkfvdn8A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The kfunc code to handle KF_ARG_PTR_TO_CALLBACK does not check the reg
type before using reg->subprogno. This can accidently permit invalid
pointers from being passed into callback helpers (e.g. silently from
different paths). Likewise, reg->subprogno from the per-register type
union may not be meaningful either. We need to reject any other type
except PTR_TO_FUNC.

Cc: Dave Marchevsky <davemarchevsky@fb.com>
Fixes: 5d92ddc3de1b ("bpf: Add callback validation to kfunc verifier logic")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 81a93eeac7a0..7a00bf69bff8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11023,6 +11023,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		}
 		case KF_ARG_PTR_TO_CALLBACK:
+			if (reg->type != PTR_TO_FUNC) {
+				verbose(env, "arg%d expected pointer to func\n", i);
+				return -EINVAL;
+			}
 			meta->subprogno = reg->subprogno;
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
-- 
2.40.1


