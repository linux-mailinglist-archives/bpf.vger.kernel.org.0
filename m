Return-Path: <bpf+bounces-21586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C5484EF84
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F4628D619
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DD75227;
	Fri,  9 Feb 2024 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzRy/tdW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A85663
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451584; cv=none; b=QnfHwackh1jUknLwpVEbp6Suoz2plHywgtw1eYMxH+Oq3FvVzb9I3W+hI5Py5ItuZRVkwKblCygD61TLrABRJ5LnyqZv/R9E9SsYz3Si+BGUM4mAE7ax0pnuIizTxD9k7ofh/hdZq6bWOnzKc4xklFzYj6tQgs5grKbj95Wy0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451584; c=relaxed/simple;
	bh=y/WnPpS5v7h0NAuexgmi/BtX46N+W3zY7R6LeqdxZUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PECwXfLu1I2C78AjDC2N/nVFcZ++nmcXazlthC4ZQSvplPxnK1GFI1GxZLcSLjRgVRkeQWg9PfP6Vw0kwlt5QNucgrBR9Bnn5dzAHeN8pvWmUcxj5PeqPZ2qgakXnaFNiouK1z374LNL96xS01U6OE0bjlQD78IJvuilZ04riVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzRy/tdW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d8aadc624dso4523495ad.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451582; x=1708056382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYMIDAZLgBUgMpP99zrxeTSMtNJZxQwPNyQYFWZYzso=;
        b=JzRy/tdWUKq4FelyAmDU1OIiVqCW6x6CEpn2bnukElnIiJoq6Lk4R442wYrKxxuOfU
         cRvRNJg5rW4optmubwiTocz+khGN2CGJtoWrqoAa5iYHqP5TXb5NbeoQoEfgdTt3wZSW
         jtyRtoVlmiGtgS0XAW0aQjIGQ2NxXm3V+HGPIQxv/EH8F4S24xsxcV42F89MSjvZzDlN
         FYB0DyVxakFu6kGdRZHZf+YCgbonL4eo2ows5u7qAynKvo9IC73p8QqbI/hcu0XGq7zI
         4x1/iN2PvUibxR3Wvalj/nFANQcT1Gg4OuAtKE87dBrcxD3r3Y7BggAIIZj5HYKeMQ6t
         UEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451582; x=1708056382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYMIDAZLgBUgMpP99zrxeTSMtNJZxQwPNyQYFWZYzso=;
        b=nLu5qlicTOArk9DZ19n9kOKPZZcxzAUgGGDoDR/p5bJdTp4h4xZrm298T/xGAi+aVy
         LvwJdn2UWiS0d5VBms3qxB/mK+tNsW13k2g58RKtvkArNw8n9eXh1MKPmK594AoAVCcd
         8JSQFBGYGhzbFtSeal6pNv3uSFGKcEZq+TXxEHyZBfmmdcyfLngf0agU0w4QSWHTQNac
         ZWmh8N9KQqv14iUGvy3LHo4wyTKAfU0wxbdK1AslRY8X0n9Ua43nOVmBQQYqyd5W/yI+
         3e6DyCjCyiNbuWLWcnKWNdzxtiQ9kNgXzuGqFofJVhHI6JxNKiq8mzfMw06FHlMYu616
         aqdQ==
X-Gm-Message-State: AOJu0YyVlC4qd/HzJT69UH7NBkZuHXNyZgBQwz3TwpAR9YcrXaDFfgUQ
	Tp5A+v6slaNRTu+IhR9F4jIEknB8CZZENG+63H88lCd0lwnJupRvMlidj61y
X-Google-Smtp-Source: AGHT+IG7W4w6iclNa9lFghGZkrapWzAeDlADw31sucf55LWFs70wKngA8+n/+OS3WjIjVQMSK9dgJA==
X-Received: by 2002:a17:902:e549:b0:1d9:6dc8:b44f with SMTP id n9-20020a170902e54900b001d96dc8b44fmr349803plf.1.1707451581624;
        Thu, 08 Feb 2024 20:06:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9TUB8D0L6Glwm5xlI3JvnBt7zEVn8IOywhbt58OfQBsWE4k4qMGs4CWoKHxyxuTzW1lD9onprEAHbY/BQVbHwXNg9VmhIZInBkRh8ifJLD08aWjb3T+K0tDAVFrboxdJ+d8n2YA52cdz0aPx0veAq9E4y39FA4QYAbouAb2omG9KISCOMfSfKL6a8oDHvwuifT9JSGK4q6WX0S4EqCjbHGubv+u7IqGmSdLK7SIiYC28SWmhCj/ydGdJrKud4QkLYUh1W+4dZWd/d9cSw1xwgy0LsiufRVZBXcgKL3wjIvYg5eJlRcFjB7OjTKhqUSIarEy3JRhCDPQNO/jtaRfHoaboeoMjjcVd7WbWx0EEabK2p/ysZuw==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id ku6-20020a170903288600b001d8f82f90ccsm538134plb.199.2024.02.08.20.06.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 02/20] bpf: Recognize '__map' suffix in kfunc arguments
Date: Thu,  8 Feb 2024 20:05:50 -0800
Message-Id: <20240209040608.98927-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Recognize 'void *p__map' kfunc argument as 'struct bpf_map *p__map'.
It allows kfunc to have 'void *' argument for maps, since bpf progs
will call them as:
struct {
        __uint(type, BPF_MAP_TYPE_ARENA);
	...
} arena SEC(".maps");

bpf_kfunc_with_map(... &arena ...);

Underneath libbpf will load CONST_PTR_TO_MAP into the register via ld_imm64 insn.
If kfunc was defined with 'struct bpf_map *' it would pass
the verifier, but bpf prog would need to use '(void *)&arena'.
Which is not clean.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d9c2dbb3939f..db569ce89fb1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10741,6 +10741,11 @@ static bool is_kfunc_arg_ignore(const struct btf *btf, const struct btf_param *a
 	return __kfunc_param_match_suffix(btf, arg, "__ign");
 }
 
+static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__map");
+}
+
 static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct btf_param *arg)
 {
 	return __kfunc_param_match_suffix(btf, arg, "__alloc");
@@ -11064,7 +11069,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		return KF_ARG_PTR_TO_CONST_STR;
 
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
-		if (!btf_type_is_struct(ref_t)) {
+		if (!btf_type_is_struct(ref_t) && !btf_type_is_void(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
 				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
@@ -11660,6 +11665,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
+		if (is_kfunc_arg_map(btf, &args[i])) {
+			/* If argument has '__map' suffix expect 'struct bpf_map *' */
+			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
+			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
+			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+		}
+
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_NULL:
 			continue;
-- 
2.34.1


