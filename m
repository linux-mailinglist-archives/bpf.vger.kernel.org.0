Return-Path: <bpf+bounces-68523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C8DB59BEF
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498D4580BFB
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226834575A;
	Tue, 16 Sep 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvAz+c1x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E421FF26
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035971; cv=none; b=adRy9C74u9NIq2K/SUAFf7/36Vwyrj62xuY0cRs1qpY9+yawQ+0SPONEHbpKq1igNGSBfomSMvNe3UGBqbw7io45HG5Si5XWXVF0brtLbxhn91qDZ6BYlvrKdEbPZxIa8zmUQ/Xa7BPTibXqTRr3i2syKE5UjC6kakeME3OcgQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035971; c=relaxed/simple;
	bh=bWoMX3AirWtNozVBotgKi/ONaIkNxVrFy4ozjyIuQws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEeP8GnVK5PVkJ19pEJcqFdKQVYMB6hn9TyzkD/GXzPyToyS9kH7Q/U6vtKw4dHzUrY2kX7P8FJxTZkveCEwhTvdCPV4T9Z2yV1tL5QpWVMQ/K0Mo+QxGWDarEByHFPmR7v9m8F0N60cef1MC+TC/OyHWvGI2VnBf07tUarZVnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvAz+c1x; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so18645675e9.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758035968; x=1758640768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Gym6vufRe/KAA2TgMX86Ey8Q4DUK6LsCTD5lopRcaE=;
        b=VvAz+c1x7DKPzagi8oNwcEwQEm/HgxKi6ndU129P8aGgTK9F9Lpq5Qa/DxHtEhV6k8
         1o+8fkLy9+46pv9oOo9QIZgfOs5P6dxmHmHLCojJXeO+enyFk17XbPttBWmo8kCjNalf
         IukyL0XXAoAYVCx3zxvTy4HHsHicDA7WnoTX1XyW9rehqOPCoVA3FvFFMO9VGWTDv5GX
         pRQR3vmEVBIhUwuPiEu7tdtVgNdWU9Ut6UJrIF3k4eTOOCig1Lda8PL1/XgBK4r7OMB6
         kBuQFWv8Rgiaw1Fnjb94sZYYRCmm/BC01VgkKCdaGMHnN2epxBO7YU4j0tyV0/WSkVFO
         zVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035968; x=1758640768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Gym6vufRe/KAA2TgMX86Ey8Q4DUK6LsCTD5lopRcaE=;
        b=QkV92ig6hEHZn4h5IPX5t056NG92fM4iQ7di4UtRLPY8bXzL+ZopCnTC0t4RzuoqW0
         xdUcbJJFeSgaJ5sUs8/mZsqrC10VFu3n+YU7EiTaQ4OCC85sYVnkNGuo1zoEPfhVQsUV
         IX9eVKdCc06Acmn8dTbb1Sbn6Dt0ZYJPFjc99UzzkKqwiS6BTImPXvgmA/BQBwBqfklQ
         IjbfsAsF/2/8u7LSa98RnyeLTapj6I8Qys0T6cZjhnuo7IHvNmVd4n0TTQhQXI4Iex5p
         UuCZ97TJm3375FROO3TtEPGot0WDSSwBKAN8PXsHXiLK2l376J1dcvZdTp/fKnZx8Cv2
         9j8g==
X-Gm-Message-State: AOJu0YxtJz5IU6vjbklYNkerWunU9lxGuTIToN7gHuL6bOT6ITian24G
	JA4BZMBPz4n9CNyEn2M+HB+N4gdvFnvJeYqCYW5lshoeN8rndILqYtvryOIaFAlk
X-Gm-Gg: ASbGnct+IvMitt948V/tGn0CefQKJMDKpJeoMVnjkEYYXOLL8xm6YkToq1jZfulbskh
	vzfr+wROryzXQ3DTvGoEc+KwXtThdDX8Hj8e/EbyyVzHL7O+X9Ye1GBkMPrN5ZVFMR01RX/QETk
	GsYAyPCNCXk1//BJq8m2Dn8gt/wDmEmRZGgoSj3znDvIVtjd8lGlnvCc+xS9dbpHkN3O1fUzVDn
	XjGkPniLIuFreXdYJ82ZhBVc5YoAGrfCCnD4nzVqoQfvGxAzqStm8vquwbSLiaFJjUs8TtBJc12
	0FOo+uTw4Do1O/rIpSQmwKIGjF56EMbpgPomlW2l1cFpEzbdSR6a1NPxUySZDcvHMRUQva1f+Lz
	/y7DmYS3jsgJFo0XKh0n8xFxwXqzKdUKx0v7KmcXJ/qKsVRN6eNv9+kKSOMPX6hotcZ3hb3+azN
	PnPDlFuN7kfqPB5av5nfkJ
X-Google-Smtp-Source: AGHT+IHwIXWdZXFv+vYS1iawPj7rIPi+rdq5HWspBhezFCMAn3huef0vmP4vxfv7asrFMDV9Y0ZO1w==
X-Received: by 2002:a05:600c:840f:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-45f32d173d5mr31273985e9.6.1758035968123;
        Tue, 16 Sep 2025 08:19:28 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b660ca331402f663.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b660:ca33:1402:f663])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e98b439442sm11784367f8f.38.2025.09.16.08.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:19:27 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:19:26 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 3/3] selftest/bpf: Test accesses to ctx padding
Message-ID: <6efe1666f4747c2c0da87467cf1c61910f64a687.1758032885.git.paul.chaignon@gmail.com>
References: <f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>

This patch adds tests covering the various paddings in ctx structures.
In case of sk_lookup BPF programs, the behavior is a bit different
because accesses to the padding are explicitly allowed. Other cases
result in a clear reject from the verifier.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_ctx.c        | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index b927906aa305..93d4b4d14dca 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -262,4 +262,28 @@ narrow_load("sockops", bpf_sock_ops, skb_hwtstamp);
 unaligned_access("flow_dissector", __sk_buff, data);
 unaligned_access("netfilter", bpf_nf_ctx, skb);
 
+#define padding_access(type, ctx, prev_field, sz)			\
+	SEC(type)							\
+	__description("access on " #ctx " padding after " #prev_field)	\
+	__naked void padding_ctx_access_##ctx(void)			\
+	{								\
+		asm volatile ("						\
+		r1 = *(u%[size] *)(r1 + %[off]);			\
+		r0 = 0;							\
+		exit;"							\
+		:							\
+		: __imm_const(size, sz * 8),				\
+		  __imm_const(off, offsetofend(struct ctx, prev_field))	\
+		: __clobber_all);					\
+	}
+
+__failure __msg("invalid bpf_context access")
+padding_access("cgroup/bind4", bpf_sock_addr, msg_src_ip6[3], 4);
+
+__success
+padding_access("sk_lookup", bpf_sk_lookup, remote_port, 2);
+
+__failure __msg("invalid bpf_context access")
+padding_access("tc", __sk_buff, tstamp_type, 2);
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


