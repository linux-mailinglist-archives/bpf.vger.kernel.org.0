Return-Path: <bpf+bounces-27817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894FC8B2424
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99161C22BB5
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E118F14A4FB;
	Thu, 25 Apr 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/aJSmad"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5899149DF3;
	Thu, 25 Apr 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055498; cv=none; b=Y6uOePbehr5+DnIAtO1cBXDY5RoyBLRuCewy/ymm7arEz4TpS20FN0UD+NYScVn20NBFEwjuhi3yuOays/xCCBYBBgDWhvIP88qyXMLWyK6FAvSD7gCAqnyEhDtMjwOnjAGCrGjSEnXL/OwchWzH9yP/8noeEAl18rrSc3pAAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055498; c=relaxed/simple;
	bh=ecmt6fSKfVNHiV7pzewakbSpUymI5dTI7iLU+un23hU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MJy0lLN86zT+SPfWC2pGJLXqkkRxFz4Q346EA18HsBIf6tiyS8FAnKw9QAoL5ewoSUWHiipNn7pK58E1p4KMOAuiHL9ePwsy+E0O41Udl6Oxd/Z2veduxy8vt1ATBnXPXKr9r/hVLmrqK6J7SqdiBRrX+V4DHLX/ssDRQlOFhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/aJSmad; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78ef59a369bso72896785a.2;
        Thu, 25 Apr 2024 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714055496; x=1714660296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHBuZMjN5QrOr2xxJTwOccHd/HM7ozS9zvz5VbClYLs=;
        b=Z/aJSmadDKVKhnO9bfwoVsondBhzi5rhyGB72bAwQlbRt3P04rloXoy4VJKoqRFSyz
         S+MCQL2PPzzjFOPz7KsEs0tWsq6WwqcoWBmRZMON/efTsyHHVEVeVzGCg5VtQx39+Phi
         94JbhwmoPGDJL1UkFS8LkrMXE4aqzxBKz8Uylp2R7esBKwrM7e+K+dJKwjeWGO+jkRMS
         +VbibBs0bWNR8RX7aAkXLtDaVVXrCho5Cj131rliRCqqSdSyHCvyH8UkR9Wvo4KkCeXU
         LB/OvG+HeQYBj9ECVhKPxgrteqLYXS2MTYdwc3dXLgU6bzzVrZtAgfnxHku/EiLy4UA8
         NDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714055496; x=1714660296;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jHBuZMjN5QrOr2xxJTwOccHd/HM7ozS9zvz5VbClYLs=;
        b=eAXE4baJNkNTLQmDZ2Cge8g7eNFdXXIdb2g1fK8+DLAcFKGebLuzDZrTBYKbTxmOxe
         m/YPhX4G0dkxJqc5S9m9x/tPK3yfAmHQpQr1o579TpvfFPq7l5kfjNtRdQ2GqSR2vap1
         EoC17DBIRbF6Tf3TdgVC9BUVTCvdXNhq1UWGJ0mr/OZBsBgXhV6e565uN/7ohDrLiA04
         wmUwOPXHtsBSC9RxRVJnVZxCHE5hHTs+t3pIzRUBEC1Nwgcl/svDz71fXTLWuK9rhAF+
         wgV0T2hI7AFUq3+j+ErVqVU6erzxRqyiTxnMeRc7WVOahKz3SI6LFTikAQjaxbelNpa+
         mXzg==
X-Forwarded-Encrypted: i=1; AJvYcCXYsfkCiZpvrBoGIddS/kDs3UekmxRhw7I5PEi965AucM9GZ6iIPNuxQ4FP7JdD4UcCKggcfTPCrT5vswwZcDop9zY5ZlUf/DcH62D1v5djONrym/8hQq813wjl7QlCI+lySyi4EVrVkx6sYZMYpVL91S0qsRxcSpD5
X-Gm-Message-State: AOJu0Yxc0D7cYVABtkvxocE6/j0esh6UBti0VXqw5x/kgITSVopMgnTW
	B5Wf08kVOdfr5SZgTrkjDF2mV/bDHR0sBznNZ1l2FLb8ZDh9kOlR
X-Google-Smtp-Source: AGHT+IFhj2fzglKIYnI7HOQcCMnfJdrG3yZskBunJyTySdFaOsqQ/0OiuCKLYNFN9h0S3oFYGXU/kQ==
X-Received: by 2002:a05:620a:46a3:b0:790:9976:797f with SMTP id bq35-20020a05620a46a300b007909976797fmr3704511qkb.13.1714055495697;
        Thu, 25 Apr 2024 07:31:35 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id i19-20020ae9ee13000000b0078eca9de099sm7030903qkg.134.2024.04.25.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:31:35 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:31:35 -0400
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
Message-ID: <662a69475869_1de39b29415@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240424222028.1080134-2-quic_abchauha@quicinc.com>
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-2-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v5 1/2] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
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
> mono_delivery_time was added to check if skb->tstamp has delivery
> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
> timestamp in ingress and delivery_time at egress.
> 
> Renaming the bitfield from mono_delivery_time to tstamp_type is for
> extensibilty for other timestamps such as userspace timestamp
> (i.e. SO_TXTIME) set via sock opts.
> 
> As we are renaming the mono_delivery_time to tstamp_type, it makes
> sense to start assigning tstamp_type based on enum defined
> in this commit.
> 
> Earlier we used bool arg flag to check if the tstamp is mono in
> function skb_set_delivery_time, Now the signature of the functions
> accepts tstamp_type to distinguish between mono and real time.
> 
> Introduce a new function to set tstamp_type based on clockid. 
> 
> In future tstamp_type:1 can be extended to support userspace timestamp
> by increasing the bitfield.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

> +static inline void skb_set_tstamp_type_frm_clkid(struct sk_buff *skb,
> +						  ktime_t kt, clockid_t clockid)
> +{

Please don't garble words to save a few characters: .._from_clockid.

And this is essentially skb_set_delivery_type, just taking another
type. So skb_set_delivery_type_(by|from)_clockid.

Also, instead of reimplementing the same logic with a different
type, could implement as a conversion function that calls the main
function. It won't save lines. But will avoid duplicate logic that
needs to be kept in sync whenever there are future changes (fragile).

static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
						    ktime_t kt, clockid_t clockid)
{
	u8 tstamp_type = SKB_CLOCK_REAL;

	switch(clockid) {
	case CLOCK_REALTIME:
		break;
	case CLOCK_MONOTONIC:
		tstamp_type = SKB_CLOCK_MONO;
		break;
	default:
		WARN_ON_ONCE(1);
		kt = 0;
	};

	skb_set_delivery_type(skb, kt, tstamp_type);
}


> +	skb->tstamp = kt;
> +
> +	if (!kt) {
> +		skb->tstamp_type = SKB_CLOCK_REALTIME;
> +		return;
> +	}
> +
> +	switch (clockid) {
> +	case CLOCK_REALTIME:
> +		skb->tstamp_type = SKB_CLOCK_REALTIME;
> +		break;
> +	case CLOCK_MONOTONIC:
> +		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
> +		break;
> +	}
> +}
> +
>  static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
> -					 bool mono)
> +					  u8 tstamp_type)

Indentation change: error?

> @@ -9444,7 +9444,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>  					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>  		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
>  					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
> -		/* skb->tc_at_ingress && skb->mono_delivery_time,
> +		/* skb->tc_at_ingress && skb->tstamp_type:1,

Is the :1 a stale comment after we discussed how to handle the 2-bit
field going forward? I.e., not by ignoring the second bit.



