Return-Path: <bpf+bounces-70297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F36BB6957
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 14:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32A743455A0
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12CC2EC572;
	Fri,  3 Oct 2025 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="A6ic5k8z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD82E8DE3
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493035; cv=none; b=j/rUh5zVHNYq6eC6UySt6VFFuwzzLaNdE9/uIFEXaYI0DmCSZyVUhvx2sJdqCSsfClZyh10Yt8A0X+YpPj4ny6miVDa87KPsJlBKFefC3DFA6NZNWvBQQPKTPN9KgtVi3PZraj5VWSKafTKJhSH+fcznu3PuHhR0uT7JKnqdXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493035; c=relaxed/simple;
	bh=TKJ68FQzM4OxoqzPD1unNLoApkMeRnB7fJR+0WinljE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OK6CbTSO5S+bweuY99zrg71PeQ/iN/VDKPgfJPcccJta+ElQKZa95TRN/Qwl0xB1/+LXCngxtgMdOjW3Ns3OEBu5adLnWeLl4vvn087X1jgVbZoUwyBCW9pMrlS5pkrLluk2ASGIkTNShOPRHaPJ7Mrz/9cRHl5D0iIWKbE2Bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=A6ic5k8z; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6394b4ff908so1390871a12.3
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759493031; x=1760097831; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7EUW43HWolyI7T5LSzYWxB/vbzNla21nNsPp9mz+OZo=;
        b=A6ic5k8z7XJBy13VqJMYMttQy54y34Q46MyX++5vj0WvkgXfhwKNVU/EBdnJpMH2t7
         SEiYkp8wdNSI6Cp+0sZJpCczgSXv1aKZJCPWiJHk2w/9tcNWXoJ0X2BW3jOe3xEWCCQc
         ne6TExW7IzmCaQusiTOrbDJZd+7K1v2fRh9roXUPG2i/y6xay9qZ7y4h+yD1XdS047Ox
         Jj1nXOC6Jmopx7aoSYpV3nkZxMja5Yrwva1/WByxdLaQRpPb9dwjo21JxCg3RdgRg8Wx
         LmrANYRVOR/vtABl5tKy7XxmQ5lT0+Bs1kenJ6vdBAmsvVs7r6yraoK1Gm6ocDH6/51F
         98Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759493031; x=1760097831;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EUW43HWolyI7T5LSzYWxB/vbzNla21nNsPp9mz+OZo=;
        b=W0KtNt3RWCy2bJYR1HW2VLNO1BBr9sLuRLPgRnhWMl5wMFYV6wCYbHE93pEbXoviRO
         e0b6b1TiQwKFC9yw78vVvJ415En6N8fB9JCac59UjTDGhcqqhHDANW/k2lbGc9lfnfIG
         Inm3Df/UNlDrNYGDC+poUopwEwjrVzzkHFccxL9+Tl+w5OKNcPm1z86fo7rCbgvO0NG4
         WCIAZGQRkbuLIC9X4Lode33uZNEZ/GoyusYS07Cw4uuPY4+YViW//zyZsxaO9WniXc9T
         ATndMGXm1MRc4mr+EUREG+gvdIrOkZCn34vDbTeErKli3d4jRRcrUW3/lkiGpa3w9BDa
         s3hg==
X-Gm-Message-State: AOJu0YwIgwGjl0YEGATPsnFVoQvjhkooz9km8mjU12b2XvemRXxyJyGs
	TE+wxcq+F8PaFPAebw4n4Ve2qKDSQDv/dGBfU09LZvfvC8AktjPgHUuySDQ+ZOLI09YVXMurtMP
	7VkLz
X-Gm-Gg: ASbGnctu88QPXCCsTQ1ynkZyi/ELINxPEDWaEhpavKIHYAN4yz2jCwZl0FgGDFlCLDy
	p1KS8dJilCVB2qKOHRV6e3qG8ccvPEY/a/GFO0uaRqNAWgexu5GnVnLS3OiThV5nKclYOQ2TgW5
	I1KzgTzWJW9ipLg4T7/M+VAFD6O9qZPllsb/8vDP25kNiYIwN1AZzLaJSnUNPrUSYL7KH7Y0Xpr
	4YoJSqABtn07G7L3/T8pfCnRWn8H2ekg4LHfq16pn51a+foW6/CMYlwuTsfb/7XlzuD8aq/PZvV
	0wGDfznthvvvvc5j3I3p3PH7HaomQZ2hP3sMZ6NW/AgCVg8uQGDhzUI5wpltfcgfYebFUftgdAK
	9sbLTd0sKZBlbvlQtu20oj5wUA8BhvqAv+gfodc8DzktzC/+1
X-Google-Smtp-Source: AGHT+IHgY7YMNMn1KWKsL3AP2dmLTqwcNzT1KzlBF2R4fZUXm4QNPcsYDW6TGFHfq2FabuVmsQODEQ==
X-Received: by 2002:a05:6402:2793:b0:62f:ce89:606f with SMTP id 4fb4d7f45d1cf-63934900286mr2753027a12.12.1759493031527;
        Fri, 03 Oct 2025 05:03:51 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378811ef5esm3893480a12.43.2025.10.03.05.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:03:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next 5/9] bpf: Make bpf_skb_vlan_push helper
 metadata-safe
In-Reply-To: <20250929-skb-meta-rx-path-v1-5-de700a7ab1cb@cloudflare.com>
	(Jakub Sitnicki's message of "Mon, 29 Sep 2025 16:09:10 +0200")
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
	<20250929-skb-meta-rx-path-v1-5-de700a7ab1cb@cloudflare.com>
Date: Fri, 03 Oct 2025 14:03:48 +0200
Message-ID: <87cy742nvf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 29, 2025 at 04:09 PM +02, Jakub Sitnicki wrote:
> Use the metadata-aware helper to move packet bytes after skb_push(),
> ensuring metadata remains valid after calling the BPF helper.
>
> Also, take care to reserve sufficient headroom for metadata to fit.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/linux/if_vlan.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index 4ecc2509b0d4..b0e1f57d51aa 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -355,16 +355,17 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
>  					  __be16 vlan_proto, u16 vlan_tci,
>  					  unsigned int mac_len)
>  {
> +	const u8 meta_len = mac_len > ETH_HLEN ? skb_metadata_len(skb) : 0;

This is a typo. Should be:

+       const u8 meta_len = mac_len > ETH_TLEN ? skb_metadata_len(skb) : 0;
                                      ^^^^^^^^
>  	struct vlan_ethhdr *veth;
>  
> -	if (skb_cow_head(skb, VLAN_HLEN) < 0)
> +	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
>  		return -ENOMEM;
>  
>  	skb_push(skb, VLAN_HLEN);
>  
>  	/* Move the mac header sans proto to the beginning of the new header. */
>  	if (likely(mac_len > ETH_TLEN))
> -		memmove(skb->data, skb->data + VLAN_HLEN, mac_len - ETH_TLEN);
> +		skb_postpush_data_move(skb, VLAN_HLEN, mac_len - ETH_TLEN);
>  	if (skb_mac_header_was_set(skb))
>  		skb->mac_header -= VLAN_HLEN;

