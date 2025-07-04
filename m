Return-Path: <bpf+bounces-62452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E4BAF9CA8
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBE3487052
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33895289808;
	Fri,  4 Jul 2025 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV9mQxpO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE42CCDB
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751670249; cv=none; b=I66ZZvD2QhTYukfOdBIBEs0n7veMd90JfmASa5ry81+yKMGNpY+1yxVuzusXIcBPVADTMeOjqvmgh7JA1+dxlRCTwADAlN7AZ+2XldwmRbV/C5ChQ5+PFJM25+vZzJG6zFb6B5FjGmjdxyfgcPJAzEP2MP6Ac8TBHn123YLVeb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751670249; c=relaxed/simple;
	bh=uOIK7lVQqUD+70Iy4+sXCFiV5DyUbROTVCAFfk6BaIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOS+3KjyRsH/k7qzKxdaCFLo3m2i4qZSmuY7dcg0ZSwUsV4R1Kx/Bn6I9h7DXCj+yF4o1G5iALDJ0d703CGq2CFVUkRGU5y/rCqora0zfZ/Qe1gNqiJeeWekowI3YzsBW9WQtmM1R3o4mGnbqWKKWUNl3ucF8rVbi2SRf15q/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV9mQxpO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747e41d5469so1555667b3a.3
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751670247; x=1752275047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GfoaJLYqV1a821naXeUgTiVngX4hLmi/uM1dLwSeos=;
        b=kV9mQxpOlOH69HwX5fN+uTDOlNOb4EO339xuHqUBRAfnmxT2U33Nd4lVtbNAOJwqRp
         JrNN6ycm+DTwUyD3ZYAT8eLlQ9SDwhcZertFWKEx2TcDhLKqI4yVRQBE1dgL8tnxW1zD
         kFSlUmy27PTBJL76NiC4SMCTucrdJvXDhmSDLQZSZwNYDSZmqz8gakKrlnzUP9vJiRUO
         bnjEgLIrWixZ/QuZmUHL6Zz+JcDpqZiIQdyT3GUIKc//PRHhvq+yoXgxXv6Oq5QeBqnc
         qlDeiF7YINQRnmIlWQxHJ5vFNnStsFx9mIFfbpBQj+wt/vyAJAAq90eKmLERl++TL7tq
         GWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751670247; x=1752275047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GfoaJLYqV1a821naXeUgTiVngX4hLmi/uM1dLwSeos=;
        b=BzGLqvJMGHG/XxE7enMpSYrrLl4WeYR8d23upZ30rNB39pfr+uR5/ECbnT/o9pXuvx
         jY3YO5D3LthGvgX9Rs/ma8twCZ6eD9v1yv3gx3Cddnodu0ynIEY1fDJRJ3UwqhxYcYVK
         rSWCq2Mb4A//PD6kr3l7fF8h9q1Oq1InOBOI+FPds3mvFfoEtLAechQcIHvFasYdzeBS
         F1s62UWnbo4SB1YwU3DV8B0CxwlEfloJhdC7F4BntVIUWE5Dc5IG5Vltx9Wn7loSWRh4
         Q11wO3276szNhj0Qt8XN04DqwjSzKcIv4AU6cRxezHkQstHSbKpcsiBh3Cb5BbmZUtP0
         Yrnw==
X-Gm-Message-State: AOJu0YyGx+e3vaAlSdKWB0HLKCpwrfDJ+dZLYMMVj/taqHL5UG8BkkUl
	uOTSNiop9+wFB3j92bQxEydlKGUFbrXIMfLMbvnN4AkD34/usNjgOuasAfNwvg==
X-Gm-Gg: ASbGncugiJoSnA2ny0+P+yEyZp7w15JbVsfUFiTNlMFez2n4UVXSe2/vMe9c78QN2VY
	2ytTUgafb/gSXI7ySQyr5jjg4hmls2os2IKeqd4Xxe3d+66E3t+hezRP6sMXA9Hv6QVZvOMxdYH
	1OHLGI2sCfEIg4DuMMy6opPmCiILCMflQ0vJPCZI1nT8EtYKjiRvknnZudUjHTuwc5CYSeuGLJh
	BWJFMs4J2BcfU5ar8C7Rp8pBZphfRVIwE0oQjfVMVj0cST2QVQx+1juurRUJL5lqAmUyz7MwmEA
	o6O+T04Xc0KUJo5hb/+KOEx7An6a7ZIWLzz8wNEZN0LUKEkZ8TqyB4gAhQ==
X-Google-Smtp-Source: AGHT+IHaWw0W66aF+Y7a1UGKhJCvRYmYSPb0akWjC9CXrnm4wjSBPMH/wq2PA8GHNdbbG5/CfIpYkw==
X-Received: by 2002:a05:6a21:7a44:b0:215:efe1:a680 with SMTP id adf61e73a8af0-2260a795654mr4764087637.16.1751670247318;
        Fri, 04 Jul 2025 16:04:07 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f879d040sm1764447a12.44.2025.07.04.16.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:04:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 3/8] selftests/bpf: ptr_to_btf_id struct walk ending with primitive pointer
Date: Fri,  4 Jul 2025 16:03:49 -0700
Message-ID: <20250704230354.1323244-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704230354.1323244-1-eddyz87@gmail.com>
References: <20250704230354.1323244-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate that reading a PTR_TO_BTF_ID field produces a value of type
PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED, if field is a pointer to a
primitive type.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/mem_rdonly_untrusted.c          | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 8185130ede95..4f94c971ae86 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -5,6 +5,37 @@
 #include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+SEC("tp_btf/sys_enter")
+__success
+__log_level(2)
+__msg("r8 = *(u64 *)(r7 +0)          ; R7_w=ptr_nameidata(off={{[0-9]+}}) R8_w=rdonly_untrusted_mem(sz=0)")
+__msg("r9 = *(u8 *)(r8 +0)           ; R8_w=rdonly_untrusted_mem(sz=0) R9_w=scalar")
+int btf_id_to_ptr_mem(void *ctx)
+{
+	struct task_struct *task;
+	struct nameidata *idata;
+	u64 ret, off;
+
+	task = bpf_get_current_task_btf();
+	idata = task->nameidata;
+	off = bpf_core_field_offset(struct nameidata, pathname);
+	/*
+	 * asm block to have reliable match target for __msg, equivalent of:
+	 *   ret = task->nameidata->pathname[0];
+	 */
+	asm volatile (
+	"r7 = %[idata];"
+	"r7 += %[off];"
+	"r8 = *(u64 *)(r7 + 0);"
+	"r9 = *(u8 *)(r8 + 0);"
+	"%[ret] = r9;"
+	: [ret]"=r"(ret)
+	: [idata]"r"(idata),
+	  [off]"r"(off)
+	: "r7", "r8", "r9");
+	return ret;
+}
+
 SEC("socket")
 __success
 __retval(0)
-- 
2.49.0


