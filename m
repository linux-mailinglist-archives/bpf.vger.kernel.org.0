Return-Path: <bpf+bounces-67439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06921B43B45
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C70542AA5
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 12:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1002A2C21C0;
	Thu,  4 Sep 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP1FL7G5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32042C21D8
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988028; cv=none; b=aKa8SKW5BaBofbXKypyDfIglDhW6GCWMgEOoO7Qq+sULBnxCoO/D0aX/LGsiBHxXL9vInRcOuKOmn7DDNcYcZ3VDDQOvQjOSrQQtbFICLF6wokYh7+31Dyc3pjr4DtZhuNRtp+Wrtq8BJXZTktLf+afC1Bmu5GMXsXT3UriicSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988028; c=relaxed/simple;
	bh=VmM5XaSpZ0gG6/uKebT39sEIErD1uc1tNhYkjFmnLjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgEAFyxOIVovlF0RQHlW2DmXiYhBbrqfWFbzTt8wsMB6IoDelds2plQZvHKTfaxAobDm/D0+KeOK7cbEZB3/+q6biV0HKMa2Zk6An4DrXmwCdcMEp9BdclZGPVcVmmEGY+eMfeEhRsGhMI7lFYalFjnTm6FzzjNOryr66XcoDVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP1FL7G5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso6936745e9.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756988025; x=1757592825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L83Yog7IscJfo8Au5EMALfkTwEItJVjqoIkK1sTMV8Q=;
        b=UP1FL7G5k+lKgdKncTYqToFlAZYriTU37h2IfSknFcvTTXI9Bg9feuV35fir4J7wgX
         seEmtD1TL0usseHo29++GPIGReCGUdhW9aiPq2Tw1RZmvHuc1AQ6g/kvPz+fJCiBrO/g
         YT5WF8T7Zq2kxpoUUJmQluRHdU45HGEyYH9Q7x1mQKOGTXq1ROH6XG2x9Q2AJjxhkG1G
         cdBiIQJ+R5Tt96ji7k1kRkLDEUHgUBH+yvJ7HHDOzABY409Ip3YdDzruC2tk95VnQows
         zGzdJxAPPt1IQ2Kted82sLKGrKgjyVQe1Ejix3PhubZe4xtR10oAy2ApuM+i9Na68iFn
         yiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756988025; x=1757592825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L83Yog7IscJfo8Au5EMALfkTwEItJVjqoIkK1sTMV8Q=;
        b=dSOJETV5YM4buwPnkhliZLFXBD9WZKPSvLWp5gHxgC6fqsST+k69Hf9acPtSiCm1jZ
         GNt+onYRrWY9h5P54ha5Qt1a+MguY0DrhNmQxh8jdd3nSO+WEm4HE8EfnnqK94PFtDNA
         iU7x+mPKHczg8MkPQuvdZPlAXXah+tls3ew12zQrhtcLPxDgB/eicv0x7SATr6Wdlxm2
         pKOhL27Sjcf6sOLBV5dSp8Z9oMztJVmvXE9atAnkxo9Qp33TjwYutObQoYaGGbQl/PrW
         3ePIcvK3o2imcjzaeUlcXScCPRxLbavdejSFeCQNBnYaMW3rHGEqSoLQeNJ3dqp2kyfw
         5wlA==
X-Gm-Message-State: AOJu0YzcqatLnRYqVQLXd3Rr3XwRfHmil98IljW25djfmxaBCGT7jIm7
	DEUWaubl8bPrhFQOEdMsrgQeLG8cHqV4/vNz7Ee++RvX6Fl5VPxZIRErcDc3KKIDt+A=
X-Gm-Gg: ASbGncvCqrNTPvN1z2DjgBpPq/a4LmoHNk4Gdun7IqaILden6fVr7r3l84xM4K3fnJw
	wmogw5fkjs5Q3XHQzzTGgxumGWK/U9jfpKXzeDOXXuy+aSSM0+Kyq4vcBdPn7utQHVidJT1XTFk
	vw8TmVj9GkPs7XfYGxRbYDj+w0IFQ4chgVP2ODB6my7RMsMCbytnejb1a9faCBM88XcZ1C3o3Ec
	bxF994OsPyrSwlxKkgq4fi6+4tmsiQdwr1wiJd4khoays/IpuQDrCttGWRpV1wye56DeqtQIZjD
	hR/NRkY6xS/J4M3fIhqshVyJZeeACgP1uBf3Njq4gXdneZEIPcW+yXWzKjpTR9jUwUdD9EeGySz
	pMCmXVnPlytaF81V5e1jD3rqwIy4Q+SY38cFEvusDcT4dWVUL2S8ghfPprCMQArUzF+9XpdMh2p
	1Z10SMoHz6hsx4JsGfkmO/qyr2wXcTp4V4h5pLmzsz9Q==
X-Google-Smtp-Source: AGHT+IFCtHRa3WcSbONC0AQvQ3uUgHzAokNuWbTIDUxDi/bwNy2gQgNlcjci68fvU91lIMZ6hZuSaw==
X-Received: by 2002:a05:6000:2c02:b0:3dc:178f:2f with SMTP id ffacd0b85a97d-3dc178f00b7mr5978570f8f.11.1756988024967;
        Thu, 04 Sep 2025 05:13:44 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0084ffa21ee1457b9b.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:84ff:a21e:e145:7b9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm275495755e9.10.2025.09.04.05.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:13:44 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:13:42 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Test direct packet access on
 non-linear skbs
Message-ID: <632221c971697c8e338e9fdce45322cff0d0c5ec.1756983952.git.paul.chaignon@gmail.com>
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

This patch adds two new selftests in the direct packet access suite, to
cover the non-linear case with BPF_F_TEST_SKB_NON_LINEAR. The first
tests the behavior of the bounds check with a non-linear skb. The second
extends the first with a call to bpf_skb_pull_data() to be able to
access the packet.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../bpf/progs/verifier_direct_packet_access.c | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 28b602ac9cbe..fe06d7323f2f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -800,4 +800,52 @@ l0_%=:	/* exit(0) */					\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("direct packet access: test31 (non-linear, bad access)")
+__success __retval(1)
+__flag(BPF_F_TEST_SKB_NON_LINEAR)
+__naked void access_test31_non_linear_bad_access(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 22;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r0 - 1);				\
+	exit;						\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: test32 (non-linear, good access)")
+__success __retval(0)
+__flag(BPF_F_TEST_SKB_NON_LINEAR)
+__naked void access_test32_non_linear_good_access(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r2 = 22;					\
+	call %[bpf_skb_pull_data];			\
+	r2 = *(u32*)(r6 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r6 + %[__sk_buff_data_end]);	\
+	r0 = r2;					\
+	r0 += 22;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r0 - 1);				\
+	exit;						\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_skb_pull_data),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


