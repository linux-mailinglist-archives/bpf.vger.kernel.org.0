Return-Path: <bpf+bounces-9838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CFB79DCB8
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC9D2817AC
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D243115AC5;
	Tue, 12 Sep 2023 23:32:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779E11CAD
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:29 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBC510FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-99bcf2de59cso786870266b.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561547; x=1695166347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8RcyRlAcTVPnJQprPVDfbaGCP2e90Do5WdsC5vuOCQ=;
        b=q4t06F97YddbwMyjpC4kPdLtW2ssw6xdPQ4ywFQxqpYocgrQ8yiOKxlbKQ0grZQccW
         UbZSZ0SdR1ca662OkPuFdGaflzm9O9oH+J7/gHqDTT0/wNjmiRWY1Iw0cFjLNqOruC9h
         9gBu92CQyoWH9bDea5qizTgouJIWezxHNMCZ2IK5k6eP/DOZt8rkegAt7xABpK0hCUK2
         A2LwmkGgyonLZ3vzw+qhgjqw3qD0EYCp/0rY4nbfe+xIA2JQZq6hYv0EPeOGM+Ef03S/
         LQjwEBGFHjmRZfES2jP2++KCk1f27XQSvcYCfU2nyEaXkW4+yRYJyOiU/PoxCIvpecHA
         XwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561547; x=1695166347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8RcyRlAcTVPnJQprPVDfbaGCP2e90Do5WdsC5vuOCQ=;
        b=VOHyxSzpR3YqMk7kCFF+wTU41hKWxk7LNn2Vdr9SO/AWfc7Z5WJ+FmyoGIPQGkQOrM
         +PYyKlmKLgotNOlqe++gAHe3vNRKVVjgZCyX1lFAmrKkcAEuJkenyU8VFFLeQ1Qxj+rR
         dM7tzCUDupyCXvQtVF9ss0lOmGxW+joj1bKQbbvEPQvPPVmNkzoWjPbsJwbAc3E1x7zU
         6q4SJltli3JFkFVYxNEgIDrhH3uMmOw2aQTXtgzBiOLNLAhJohN+nhXnaUANFcvFF2m+
         S0yahGOSEObFo5LBQRX875R+0IRLebvsX8zejw7LYROJoTYHs1hVmMANKVqCG/VcODRR
         RXNA==
X-Gm-Message-State: AOJu0YyVciRD3Lc3cmvrPDrRe6s3bJZajLxr+0EWkiqRt5AuqeL0j0Sf
	FPq2MGxHZqPFrBK0B2Uf2giQd1qnECpeKw==
X-Google-Smtp-Source: AGHT+IEUaaIHmtXQHJmVxTEP9Hbe6bYToDQnqgepC2vthuESsBCsu0Tm7afIcUubNJ7E8af1qqfcCQ==
X-Received: by 2002:a17:906:20d6:b0:99b:4ed4:5527 with SMTP id c22-20020a17090620d600b0099b4ed45527mr574932ejc.25.1694561547127;
        Tue, 12 Sep 2023 16:32:27 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id a26-20020a170906369a00b0099cc1ffd8f5sm7444912ejc.53.2023.09.12.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 14/17] libbpf: Refactor bpf_object__reloc_code
Date: Wed, 13 Sep 2023 01:32:11 +0200
Message-ID: <20230912233214.1518551-15-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3020; i=memxor@gmail.com; h=from:subject; bh=FSoeykkEjhk1rfwOQVrvkuG8ZCFZK7m17K028PQKB7o=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSt//1GlxwfkJsBA2MkN7m6I42SSs1stWqRE 9s2abm4EnOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rQAKCRBM4MiGSL8R ymuCEACltpqPCjzhqBMn9EPDpegA5v9c0hdmAE6k62agzEXHSc1/Er2bkuw44jA8QRmAKDb0NRv dGZdxDy+esejEXmmyRub64/Dfwu63gqT93XysGYUceHxarlETL7q5goTJYtZUna6h/8WLjUKPuV 8nCjA60mN2f5YfNb4KGznG6h62sMAJXaIcUW4QsskQiUPb3xbu5kwIENhHyLSXjx1BZwPeFBvYR w2N6LFtR60SnJkVouucU370sAn2SuorZkH4608obv8cB8C22Vcc4D1KRC0TjXEuKZF8+Kllx3gx g8PT1pnRjOJeNbBe/YUwRy4nR1ZS7yC0egqXscSvG2hlL5p6HfTfagnfFpKurlckNMxgx7UhsjA HRmu8S5gdgfzantzRVMXbJUMpDwTt2TcOPNYckEtGnnuVtE8vgQsv3jt5O9EMiLPp2icxwR2AFz k3vI0LQj7eigRURgBCxlP0v1Cymafmhm1ekdoVLWoy5AFKDTw2YraeGI/ZwueQcJRLl5tgBJUSc sdvokI4tZxm6CP2XhthUGtuW9rEy7Qya883D9XzzayyXAp5qo8LNbhvyFGSRxpitgN57Xql49hv fRY9xwyHQLikO37pZkni3kM+5dtTqpuPva0T/0XuGP2vWrVCf7maL3H3YPrEPBjDZ5WDpw0+Mvj UKgVb05oBolh/KA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Refactor bpf_object__append_subprog_code out of bpf_object__reloc_code
to be able to reuse it to append subprog related code for the exception
callback to the main program.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.c | 52 +++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 96ff1aa4bf6a..afc07a8f7dc7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6234,6 +6234,38 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
 	return 0;
 }
 
+static int
+bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
+				struct bpf_program *subprog)
+{
+       struct bpf_insn *insns;
+       size_t new_cnt;
+       int err;
+
+       subprog->sub_insn_off = main_prog->insns_cnt;
+
+       new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
+       insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
+       if (!insns) {
+               pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
+               return -ENOMEM;
+       }
+       main_prog->insns = insns;
+       main_prog->insns_cnt = new_cnt;
+
+       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
+              subprog->insns_cnt * sizeof(*insns));
+
+       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
+                main_prog->name, subprog->insns_cnt, subprog->name);
+
+       /* The subprog insns are now appended. Append its relos too. */
+       err = append_subprog_relos(main_prog, subprog);
+       if (err)
+               return err;
+       return 0;
+}
+
 static int
 bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 		       struct bpf_program *prog)
@@ -6316,25 +6348,7 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 		 *   and relocate.
 		 */
 		if (subprog->sub_insn_off == 0) {
-			subprog->sub_insn_off = main_prog->insns_cnt;
-
-			new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
-			insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
-			if (!insns) {
-				pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
-				return -ENOMEM;
-			}
-			main_prog->insns = insns;
-			main_prog->insns_cnt = new_cnt;
-
-			memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
-			       subprog->insns_cnt * sizeof(*insns));
-
-			pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
-				 main_prog->name, subprog->insns_cnt, subprog->name);
-
-			/* The subprog insns are now appended. Append its relos too. */
-			err = append_subprog_relos(main_prog, subprog);
+			err = bpf_object__append_subprog_code(obj, main_prog, subprog);
 			if (err)
 				return err;
 			err = bpf_object__reloc_code(obj, main_prog, subprog);
-- 
2.41.0


