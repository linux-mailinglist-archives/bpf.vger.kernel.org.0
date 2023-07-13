Return-Path: <bpf+bounces-4888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB7751550
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2684280BF1
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 00:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A280A;
	Thu, 13 Jul 2023 00:31:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A737E3
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 00:31:37 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C57D1FF0
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 17:31:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so115676b3a.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 17:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689208295; x=1691800295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKrz1A0vGFtHcHg3EaeYTb9Cdgqp8lyQvCacQQZZF1I=;
        b=ckfBG7Ukq2Z0ufwLTcBqwZvfhKwb74XLBmLBN03GP07TaKUW5nlfoPC02Dx1ZKMNvj
         duOBbuxwL/7NsC6hpub6q6XERaSde02XwRK/QukM2Ecfuvq1JKc4AiqhhHoV6AlsibKb
         Inju8goWqoc/vCtXaDzhRP8o8X8vICQvXSNx/CxD8UePm4yLnmSuPQtmE2a6o1HHfcos
         BW0kBAfT/XgHq5KHEqF6GQtt37lI2BJ/qRme8F2bGQG38zMb8cpAGpHHc8O5RnIzLcQL
         Rchbmq7sJuK/LSPW0wNN9UOOANPbWEQus8ZPxe8kCVICb7jL405YkKlvgKGnoQpdBXrp
         39iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689208295; x=1691800295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKrz1A0vGFtHcHg3EaeYTb9Cdgqp8lyQvCacQQZZF1I=;
        b=dJ6k6NQKQXyc/WkcmJOZXUXg7PYxj+WTfvmX+YaDVfx9vD/QjKEpUn3pAipKPvJtCs
         7Qok+KeIi94N/UxF+n/NTRXzKUpOsGK0aqpeclvv18+YrwDbFaKHGTLH9XIGY42ugv10
         oWx3XmBpKanPMVk9DDDG5D3TV/vdyYKxybg5SdAEWTujZagpT4R/LKBSEGQu9vlDrCUm
         7mIce/94K/5MGC9cYVAXpA19JZ0e40mY06Cpj6kF94Bl7qNqfm5pnVOFzrn7fi3RAwjz
         zdaweVgW5srFPn7hTe+Nq6M3cYWgVSx8NUg30EQPubxo5T+pvEM5goBqFzZE9MZcIlEs
         yjOA==
X-Gm-Message-State: ABy/qLZzV/dBphFsjZjjYRJE4C4dND4VwqtPbGPYft5mZGML4b1KfTn8
	Z4M4dpeLzACOCb3utUBivEmKha9KX98eZQ==
X-Google-Smtp-Source: APBJJlELCR1ZKIbhIpkRs9j6LkJAtU9E73n+TSWmLGAXlsvIqysBdR8RSAysXmah3bmdVYzd/APf0A==
X-Received: by 2002:a05:6a00:2443:b0:682:4b93:a4d3 with SMTP id d3-20020a056a00244300b006824b93a4d3mr195844pfj.1.1689208295208;
        Wed, 12 Jul 2023 17:31:35 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id g13-20020a62e30d000000b0064398fe3451sm4135650pfh.217.2023.07.12.17.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 17:31:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v1 3/3] selftests/bpf: Add more tests for check_max_stack_depth bug
Date: Thu, 13 Jul 2023 06:01:18 +0530
Message-Id: <20230713003118.1327943-4-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713003118.1327943-1-memxor@gmail.com>
References: <20230713003118.1327943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=memxor@gmail.com; h=from:subject; bh=wYIJHcKzPwNySuFQ464kcwZ+uH75u3RqpKzcvaAjzn0=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr0XRiG8xYHfHEx8yN0IsiLmd5Nz/Sv7V4l/fO BuCz7QK+TKJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9F0QAKCRBM4MiGSL8R yqmDD/90tfgYrmToRzeeX010/uRHkDpmhj89qLlul1ckRCkNzZAFQyquj2SqM6+r+oK/GIao1s1 ZIgWiU8vfe+QT0VWfF1BuhuDVjtbInLf4r4616TGsX9B/CbwSC+akR5VCZ2W2pr5hks9bTDtWau SDNyWTYbfl0gZdA+/hctcUKiFkUTSbz8Wj/KsD4gLZlL8qMTADZ/uHqrE8z8Af+deJxAzcp8d9N gqlCASOGGGQckYBIrqEir4zsKlcavcrzDn99AxHezbrF9DrwQRokxP6xZ2DTPEkpdH2plQeX67x B+uf1zQc+q4hNlMnqpk9EteFNjs2iAfUhyJmuV48RoMiEn9/SquY9KwfBWIJ3LlKfllN0NQkeQM svCwPardazdBJqgAgKUkd2V+3K456yefA+kzT9S/RKX4+dgDaCn1HJIDcK4AMfquQLeFJOftKbq XVVPGAPyO0a9WJnWoP24Sw/JRPGoacunkfW8F8sddkcXbi/R6lLqM4+g14M6urLt4tN0KOlg9Kz OskCMtYtKCIDEn6xaCv+4ZbfhM7avCCRCPYnbrkDkhilFSXthTtqaX6GZw7U+fhWthXqrmj/aAu EuyWT1rOHC4p5wYlILhFk/HJmxXUQnIO2QaJRF1ZHGKq19warV5FbYxHVCM8ycm0cxOd+Xj/R3O Wo5bFVb1Y8boy5Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Another test which now exercies the path of the verifier where it will
explore call chains rooted at the async callback. Without the prior
fixes, this program loads successfully, which is incorrect.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/async_stack_depth.c   | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/async_stack_depth.c b/tools/testing/selftests/bpf/progs/async_stack_depth.c
index 477ba950bb43..3517c0e01206 100644
--- a/tools/testing/selftests/bpf/progs/async_stack_depth.c
+++ b/tools/testing/selftests/bpf/progs/async_stack_depth.c
@@ -22,9 +22,16 @@ static int timer_cb(void *map, int *key, struct bpf_timer *timer)
 	return buf[69];
 }
 
+__attribute__((noinline))
+static int bad_timer_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	volatile char buf[300] = {};
+	return buf[255] + timer_cb(NULL, NULL, NULL);
+}
+
 SEC("tc")
-__failure __msg("combined stack size of 2 calls")
-int prog(struct __sk_buff *ctx)
+__failure __msg("combined stack size of 2 calls is 576. Too large")
+int pseudo_call_check(struct __sk_buff *ctx)
 {
 	struct hmap_elem *elem;
 	volatile char buf[256] = {};
@@ -37,4 +44,18 @@ int prog(struct __sk_buff *ctx)
 	return bpf_timer_set_callback(&elem->timer, timer_cb) + buf[0];
 }
 
+SEC("tc")
+__failure __msg("combined stack size of 2 calls is 608. Too large")
+int async_call_root_check(struct __sk_buff *ctx)
+{
+	struct hmap_elem *elem;
+	volatile char buf[256] = {};
+
+	elem = bpf_map_lookup_elem(&hmap, &(int){0});
+	if (!elem)
+		return 0;
+
+	return bpf_timer_set_callback(&elem->timer, bad_timer_cb) + buf[0];
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.40.1


