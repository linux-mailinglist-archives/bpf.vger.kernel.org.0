Return-Path: <bpf+bounces-28707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67B8BD51F
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFF91F2285C
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97F158DD9;
	Mon,  6 May 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPmSv+6l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86064AECA;
	Mon,  6 May 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022262; cv=none; b=WgjmmOiWFHV6rT13JHIj705Bv3+8ba5EHAqMH/U9vOtXQ1gnxGaJbo0NJTrJM0e2dwc831B63Bg4m5VUC46Tkd6Z/ViRGT4ddxn+rJpik/CgjXt4SlYh9Ablj5+/3YPgP+UoDBISv8AB+8TzvUOdnOpKYCjezXNdlOxnIsc5FCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022262; c=relaxed/simple;
	bh=ZBkZQJfG24VT0gMtEpunLMAC3DvYlEFcqF28aOs/ym0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FHWDUwnsgIezQsGqsh70gxYizyHWofr2D0BQKojBjgiKDckhX/RTkEZ32dk7MN22Li9zc9oJdIO+QD3REqEppiWKKeTg5MPWtaeplEyXq1PGU+KOKN0sNUa1ZzoQwNQXq59aBmh+B/ImNuhv3MaEYJ8qbO73zyfaOxELbyVEPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPmSv+6l; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c956282db1so1403585b6e.3;
        Mon, 06 May 2024 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715022260; x=1715627060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2SKIsnNha+W0GLT3IWBOtCj1J+elwjzbYWssl7a500=;
        b=GPmSv+6lVI0q7AvAZ3rXpE158iCrOIVi0wuGgXGiE4bHp+eNwH/oVz/AwKI8iwoRwp
         e/f0JXezIpy5bKvoRZopUJpBqjadPnuBt2PXLOIKkNmf93NNG1HjWyYu3xAtMKjxOlRn
         xKMlM7oeOX6JUE+ax6A7MUkXkIfdFiT0YccQM+x5V8RU1jaXjxmCc0iFpFAIKXo/hZ7X
         xD2E7o9UD/GOsFaFeenntUpf9/AyMCOlVizI8FrKnNlFCVMN1nxvJMXDq3QdbNkI4dXj
         iMT3VWDiPK/v77ewHfTl68z1XYoaRaxkXyAWLYFUIWdedcPsLFWuBsztqS8neAeVSCeK
         g1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715022260; x=1715627060;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I2SKIsnNha+W0GLT3IWBOtCj1J+elwjzbYWssl7a500=;
        b=QhqNzXsWT4JEm9uDyTl4QCz6cpRjKBPhj5kxfsxMlyjGZ8ChCyYYXezLl7SDw9w0Tr
         gFaHxYBRDoeUIZGRi9Q+gKCHDWrVvq4aUoq5yQ7mFFGa00NZPpOVL909/dxZM/VgE/1q
         JTeTBQRqnbs4w0p9ZXXGdWCGxzyjP9sTiKvhycVce4tCUfapnzyqT1fpN5ouPNKliOCC
         XZ6dKkyRI969HVBkOYwRzrOJEjrS7j8MR7XuxR/Bjmx3JHLt/7NB5LDEVSTFkJMIv0CW
         oMcduU0fJUei6ozbEi1JGSh65VpM8njLQXe37GIFlkMECI6n1Z0dlv22kxtd1wgNUUNx
         gsbg==
X-Forwarded-Encrypted: i=1; AJvYcCWTA7G4y/QJZUDEUGxMv99hwAJruGqvECELXyp5wb0UtWBk62xw51FlwqcIAXhYwJi+h7fIkcfzoCdS9L8/1lSMqp0W7U9R0UHeP7luseNkuGfksfPTSgzxvSyXgHJOGqdqhAkpbkLr+QfBHaSRE5pNPgQt8HUMcnDo
X-Gm-Message-State: AOJu0Yxq2Y+dT0O6m+sgkT4CdeIAo4KR57uRI0g2CUwAuZ94xjab0LA8
	9hfsP132NEOfSAHvT/8Ei1+hhK5I0wanKJf3/u++EDsS2blwTCMn1NO89A==
X-Google-Smtp-Source: AGHT+IG+ItiPikNVgc60CKoxgDT2mczHR44xfpbOaKQ+c8xKiffqwj7KHe/G3zMInjuugVbY/pdMQg==
X-Received: by 2002:a05:6808:1b24:b0:3c9:5c7c:89f6 with SMTP id bx36-20020a0568081b2400b003c95c7c89f6mr12848857oib.16.1715022259741;
        Mon, 06 May 2024 12:04:19 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id j3-20020a056214032300b006a0e86b3f65sm3972744qvu.38.2024.05.06.12.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:04:19 -0700 (PDT)
Date: Mon, 06 May 2024 15:04:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <663929b249143_516de2945@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240504031331.2737365-4-quic_abchauha@quicinc.com>
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-4-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v6 3/3] selftests/bpf: Handle forwarding of
 UDP CLOCK_TAI packets
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> With changes in the design to forward CLOCK_TAI in the skbuff
> framework,  existing selftest framework needs modification
> to handle forwarding of UDP packets with CLOCK_TAI as clockid.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
>  tools/include/uapi/linux/bpf.h                | 15 ++++---
>  .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 +++--
>  .../selftests/bpf/prog_tests/tc_redirect.c    |  3 --
>  .../selftests/bpf/progs/test_tc_dtime.c       | 39 +++++++++----------
>  4 files changed, 34 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 90706a47f6ff..25ea393cf084 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6207,12 +6207,17 @@ union {					\
>  	__u64 :64;			\
>  } __attribute__((aligned(8)))
>  
> +/* The enum used in skb->tstamp_type. It specifies the clock type
> + * of the time stored in the skb->tstamp.
> + */
>  enum {
> -	BPF_SKB_TSTAMP_UNSPEC,
> -	BPF_SKB_TSTAMP_DELIVERY_MONO,	/* tstamp has mono delivery time */
> -	/* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
> -	 * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
> -	 * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
> +	BPF_SKB_TSTAMP_UNSPEC = 0,		/* DEPRECATED */
> +	BPF_SKB_TSTAMP_DELIVERY_MONO = 1,	/* DEPRECATED */
> +	BPF_SKB_CLOCK_REALTIME = 0,
> +	BPF_SKB_CLOCK_MONOTONIC = 1,
> +	BPF_SKB_CLOCK_TAI = 2,
> +	/* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
> +	 * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
>  	 */
>  };
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> index 3b7c57fe55a5..71940f4ef0fb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> @@ -69,15 +69,17 @@ static struct test_case test_cases[] = {
>  	{
>  		N(SCHED_CLS, struct __sk_buff, tstamp),
>  		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
> -			 "w11 &= 3;"
> -			 "if w11 != 0x3 goto pc+2;"
> +			 "if w11 == 0x4 goto pc+1;"
> +			 "goto pc+4;"
> +			 "if w11 == 0x3 goto pc+1;"
> +			 "goto pc+2;"

Not an expert on this code, and I see that the existing code already
has this below, but: isn't it odd and unnecessary to jump to an
unconditional jump statement?

>  			 "$dst = 0;"
>  			 "goto pc+1;"
>  			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
>  		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
> -			 "if w11 & 0x2 goto pc+1;"
> +			 "if w11 & 0x4 goto pc+1;"
>  			 "goto pc+2;"
> -			 "w11 &= -2;"
> +			 "w11 &= -3;"
>  			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
>  			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
>  	},

