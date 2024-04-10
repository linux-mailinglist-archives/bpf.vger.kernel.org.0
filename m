Return-Path: <bpf+bounces-26458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2258A03D8
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 01:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E68A1C21250
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 23:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5032E40E;
	Wed, 10 Apr 2024 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCRXNlYD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478FF28370;
	Wed, 10 Apr 2024 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789913; cv=none; b=BCcMG4Qz3nPGGw2BTyaY/oj9Pkko1qPxe1maWA8WV0XW4AeY6iZ0HLT1Lr6OrlgHcFNQz/3ADOeoSLJk3b6jmfHom/Th6/oDFoQ5hI/oaCsdorqZ1U5ULBNNgyCmgs0lW0g/pK8OSKxFyttANDkvKUyDVdQgqFsrBVU9B2PrkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789913; c=relaxed/simple;
	bh=GpA3MXV9KDuIyE3HA9j3en+1d7Qfyz4YD1gbt7MOmnM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L5sl2oxKFTKC/r+PUoK/Jgt67KRh+ib2hk6Eq5jbs7EwVLG55XZO0TBz2gKG/9Edsr0nmuEbp1Gg1sSKrCq/wQXetl4+zm38Fb6wi4Nq6qr4rSk8IAVANiT8G1Cs/2DMWsCquDuVErtJjqNxl3aahxTejFVKd4fIQ3bhAp0xD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCRXNlYD; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-699320fcbc1so44049656d6.3;
        Wed, 10 Apr 2024 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712789911; x=1713394711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfbxzgfJR0MsMDY1vQLFHodv9yObaq7ZXxu6POH4CEo=;
        b=LCRXNlYDPvRTbe9smefcqjG3SfbMtwM+OqdMPGvfy+fI1GAwz3r13kHAr5MNhInwWL
         d3hscZtfvd38610k5iqdDOCfkPV0N+djeymfaak/0xi5uCLdPJrsssSmDHYLUFGw5XLr
         ee4VAFnQVMODLxqq1A6HaucBThcK1DIc9KerCRXE19Nx7ZdH4DtBG9ebJp/J2qHFt2YC
         L9KvAA0uVcbL80aoj91OWY3bnxgnrLyrABxN6EebgzIUihpY31Yi9BI6HoUqcEnsgPFO
         nT3+hie5EusFwyzfhsBIzWu6sNeWSb7+iMIbiK2ok7wrFnSu5E4xILFzmKOFoRae0Dcn
         ARlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712789911; x=1713394711;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xfbxzgfJR0MsMDY1vQLFHodv9yObaq7ZXxu6POH4CEo=;
        b=cbV/0lABHVS8Lqu9G2OkrJ+h6oQHitj3aCAj5s0g61Zu1xsydG6XFzKc4ynjnnZ4ol
         fYeR7JLeJbHjBQgV88KMaLBOaWVPIa0ekRnbdwdnf2zmNt68ek4U4uASb+fvv+/4C54Q
         LpbyNXryhP2PjBW4IxIcFbtkcSFA2vSGBREBYUkRh6UcdFoucwzr75WuOhhEXDaU3pIU
         A9VoA2sxmmQtv/6ZMzkeIcnM9ZpMwIZyXInMLIFvdsE+mZCO2nVih0FqHqrP8mIeuN8c
         u+Hp9fIx3yqwKdkLHZSa1YWOZPTMlET+iWzranFGFaw9pQx0zXumwmkXeFjbQJNZ9mOp
         fanA==
X-Forwarded-Encrypted: i=1; AJvYcCUm/05nX7zFZkGAL1WN2soX7Q0aNLBWtFFNZFwHk5yeUrqQhf6goaQEoHOSwtx6WMMBZdjoBBKgsNLtsQr28sZ3WeRJaIAxPE1X8pUzuDvNNMZ6IDTH+IRSM7MmQvLZO3mNjvBq0pwsw9COnnzD1IWrdd4mpfBUaKcZ
X-Gm-Message-State: AOJu0YyjRomWo5SeAJUv6TtSfpBysSdmD/wKdwi5VHZtNu+vrvfIhDun
	gwTXf2DUlPFf4PK2waJXrRl1bzKi57KnBRDo3mPeyWLhNVdmkfT4
X-Google-Smtp-Source: AGHT+IHBSFLHjjycCIIAsxM/ABxRRdEot2M1br7wj5xDBky81kr0vf47L+9VoGp55kpHjre2Jt4PIA==
X-Received: by 2002:a05:6214:20eb:b0:699:16a7:7b2e with SMTP id 11-20020a05621420eb00b0069916a77b2emr4072785qvk.19.1712789911111;
        Wed, 10 Apr 2024 15:58:31 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cea52000000b0069b192e63bfsm121104qvp.91.2024.04.10.15.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 15:58:30 -0700 (PDT)
Date: Wed, 10 Apr 2024 18:58:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <66171996a10d2_2d123b29418@willemb.c.googlers.com.notmuch>
In-Reply-To: <f28de1e7-4a9b-4a97-b4f9-723425725b58@quicinc.com>
References: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
 <20240409210547.3815806-4-quic_abchauha@quicinc.com>
 <6616b3587520_2a98a5294db@willemb.c.googlers.com.notmuch>
 <f28de1e7-4a9b-4a97-b4f9-723425725b58@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v1 3/3] net: Add additional bit to support
 userspace timestamp type
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan (ABC) wrote:
> 
> 
> On 4/10/2024 8:42 AM, Willem de Bruijn wrote:
> > Abhishek Chauhan wrote:
> >> tstamp_type can be real, mono or userspace timestamp.
> >>
> >> This commit adds userspace timestamp and sets it if there is
> >> valid transmit_time available in socket coming from userspace.
> >>
> >> To make the design scalable for future needs this commit bring in
> >> the change to extend the tstamp_type:1 to tstamp_type:2 to support
> >> userspace timestamp.
> >>
> >> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

> > With pahole, does this have an effect on sk_buff layout?
> > 
> I think it does and it also impacts BPF testing. Hence in my cover letter i have mentioned that these
> changes will impact BPF. My level of expertise is very limited to BPF hence the reason for RFC. 
> That being said i am actually trying to understand/learn BPF instructions to know things better. 
> I think we need to also change the offset SKB_MONO_DELIVERY_TIME_MASK and TC_AT_INGRESS_MASK
> 
> 
> #ifdef __BIG_ENDIAN_BITFIELD
> #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7) //Suspecting changes here too
> #define TC_AT_INGRESS_MASK		(1 << 6) // and here 
> #else
> #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
> #define TC_AT_INGRESS_MASK		(1 << 1) (this might have to change to 1<<2 )
> #endif
> #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
> 
> Also i suspect i change in /selftests/bpf/prog_tests/ctx_rewrite.c 
> I am trying to figure out what this part of the code is doing.
> https://lore.kernel.org/all/20230321014115.997841-4-kuba@kernel.org/
> 
> Please correct me if i am wrong here.

I broadly agree. We should convert all references to
SKB_MONO_DELIVERY_TIME_MASK to an skb_tstamp_type equivalent.

> 
> >> @@ -4274,7 +4280,16 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
> >>  					enum skb_tstamp_type tstamp_type)
> >>  {
> >>  	skb->tstamp = kt;
> >> -	skb->tstamp_type = kt && tstamp_type;
> >> +
> >> +	if (skb->tstamp_type)
> >> +		return;
> >> +
> > 
> I can put a warn on here incase if both MONO and TAI are set. 
> OR 
> Rather make it simple as you have mentioned below.

When might skb->tstamp_type already be non-zero when
skb_set_deliver_type is called?

In most cases, this is called for a fresh skb.

In br_ip6_fragment, it is called with a previous value. But this is
the value of skb->tstamp_type. It just clears it if kt is 0.

If skb->tstamp_type != tstamp_type is not a condition that can be
forced by an unprivileged user, then we can warn.

