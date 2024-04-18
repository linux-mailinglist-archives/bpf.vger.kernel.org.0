Return-Path: <bpf+bounces-27159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F488AA281
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 21:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9981F20F53
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 19:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A735917AD9D;
	Thu, 18 Apr 2024 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G40GGDi5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681217AD78;
	Thu, 18 Apr 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467202; cv=none; b=U4iaJujLXSVlVOmZQy0lESTC1jxrapRr705D7LF8WcJuPnIJeh/KYxMhfmLn6r+El8mxhPtyJSFsJEMMrQHqTalHj5RlBeriRF9riB+KLeY47yavG7sviIN24tee7WjujU6Pe34D8+ClnlcVsP0KmwwtIYgd/pWoaA4JcCy0Pfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467202; c=relaxed/simple;
	bh=YGIZ+d0L0SuRHQG4KwI0493GgtgyoyP/mv/msh871T8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YUOhmNXKbAKY9N59hRK5yku6PpmYoPDlAwaqPT6Sqz9rP8ICpzFIchTpusa23RturT5Ubxk7wSuLPwBOlBn6j4yet741/yog+mbdOLuvXD/TxR2KHI7hopi3AquQUYUy8aLWo08jhD+CrgDlQoH3JtOnUJAyXWX1nJWTM2Fv3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G40GGDi5; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f05341128so86295785a.0;
        Thu, 18 Apr 2024 12:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713467199; x=1714071999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cylJJyjp4ApqCAmhCidTb54Q0SW7nx1kM7yf/pZYdbI=;
        b=G40GGDi5l/DoVrAaZ46jwvxGAdzjMwsMIJSEtMdjoVD5WtZqFte3uOxxjS7bX0ryTK
         COir42y8fTJVYXVcH+vuFTAJ5otQLQtaSRFOpACOrrLnbnVHMm6VRgXE4O0FZ7QenGHh
         sYVAdU7xsuvIUL3I6u6VnfFBzjpiu3uL8J7wPK7ZiyCsTSuZuCw6uOWaj5VRwz6lX9y5
         uK6VhUzqGB1VL/xMiTb/zFxzddxtimVkIq41XvhHOopJJJevhwUTpJfs2vozaP3FymZ8
         4dPShQges4EZz63dquuSLReemGU6ZQtmuWBOPig4kupIIvKvfi2FUJCYF0pWRvE++Mld
         +cSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713467199; x=1714071999;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cylJJyjp4ApqCAmhCidTb54Q0SW7nx1kM7yf/pZYdbI=;
        b=cuMxaGc5Ei+3xZ3YR8Cr6biRFmr+1ZmiLA/V0Ngla1IoovXF0bhmtvwsmcEVcDh0sg
         0IBoWyttib4iViUwsqMJ631923cWLg2B00mhhcAm+oC1hgslw5QB/bwJvd3mE0efhGDC
         jEGu1PffGcORUiaWM2nmX9URIxku/+Si4Mmou0LaDiBL8ucS3IRMW8m5PRqZWhTxa/m4
         1shzYTyZLolkEET+DvfkhWG0551HwFOQUIdOoVEDGY+B1hDYvWbeXT4zVPB3OfrtmcKO
         OsioQAvEIcvC3IoTIUKT/aXK4ZPAdVLBC8GRySbuoukBy5agBedJNnewwM1kcltZ8OYx
         61Cg==
X-Forwarded-Encrypted: i=1; AJvYcCW8dthfZPrul3AhYIcODZoLVkNuFflCIVEV5NifhDUBoVBkfwk5/4SYjsxnVO0lstc9GWcB4Y2qiBqogIjLYtc/kovFSB18WQsVeCh5xocTtM76kn0/JxIEADY61mwBhP3W1NoLGT+e28GagiraKhZza7VO2+Y70FIp
X-Gm-Message-State: AOJu0YwZlfnptnDyq8Rjd4bw1cqGmn+OcnZkDtm5N11DF9i3Cm1dx56e
	9lgCA13TLM7/UbjBq/PC9Az/tFG4+RNAw+8XCIBqRN5+F+a/LMaq
X-Google-Smtp-Source: AGHT+IE00AXXYAP5nkLMcqwPiY4GYXdv7JxisqWiVNOAWGmGV0gfeCRGQ1i6Raef8M+un/yiOg7r2A==
X-Received: by 2002:a05:620a:298c:b0:78d:733e:7b2b with SMTP id r12-20020a05620a298c00b0078d733e7b2bmr7172qkp.40.1713467199346;
        Thu, 18 Apr 2024 12:06:39 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a034300b0078ef13a3d9csm894762qkm.39.2024.04.18.12.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:06:39 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:06:38 -0400
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
Message-ID: <66216f3ec638b_f648a294ec@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240418004308.1009262-3-quic_abchauha@quicinc.com>
References: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
 <20240418004308.1009262-3-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v4 2/2] net: Add additional bit to support
 clockid_t timestamp type
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
> tstamp_type is now set based on actual clockid_t compressed
> into 2 bits.
> 
> To make the design scalable for future needs this commit bring in
> the change to extend the tstamp_type:1 to tstamp_type:2 to support
> other clockid_t timestamp.
> 
> We now support CLOCK_TAI as part of tstamp_type as part of this
> commit with exisiting support CLOCK_MONOTONIC and CLOCK_REALTIME.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>  
>  /**
> - * tstamp_type:1 can take 2 values each
> + * tstamp_type:2 can take 4 values each
>   * represented by time base in skb
>   * 0x0 => real timestamp_type
>   * 0x1 => mono timestamp_type
> + * 0x2 => tai timestamp_type
> + * 0x3 => undefined timestamp_type

Same point as previous patch about comment that repeats name.

> @@ -833,7 +836,8 @@ enum skb_tstamp_type {
>   *	@tstamp_type: When set, skb->tstamp has the
>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>   *		skb->tstamp has the (rcv) timestamp at ingress and
> - *		delivery_time at egress.
> + *		delivery_time at egress or skb->tstamp defined by skb->sk->sk_clockid
> + *		coming from userspace

I would simplify the comment: clock base of skb->tstamp.
Already in the first patch.

>   *	@napi_id: id of the NAPI struct this skb came from
>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>   *	@alloc_cpu: CPU which did the skb allocation.
> @@ -961,7 +965,7 @@ struct sk_buff {
>  	/* private: */
>  	__u8			__mono_tc_offset[0];
>  	/* public: */
> -	__u8			tstamp_type:1;	/* See SKB_CLOCK_*_MASK */
> +	__u8			tstamp_type:2;	/* See skb_tstamp_type enum */

Probably good to call out that according to pahole this fills a hole.

>  #ifdef CONFIG_NET_XGRESS
>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>  	__u8			tc_skip_classify:1;
> @@ -1096,10 +1100,12 @@ struct sk_buff {
>   */
>  #ifdef __BIG_ENDIAN_BITFIELD
>  #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
> -#define TC_AT_INGRESS_MASK		(1 << 6)
> +#define SKB_TAI_DELIVERY_TIME_MASK	(1 << 6)

SKB_TSTAMP_TYPE_BIT2_MASK?

> +#define TC_AT_INGRESS_MASK		(1 << 5)
>  #else
>  #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
> -#define TC_AT_INGRESS_MASK		(1 << 1)
> +#define SKB_TAI_DELIVERY_TIME_MASK	(1 << 1)
> +#define TC_AT_INGRESS_MASK		(1 << 2)
>  #endif
>  #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>  
> @@ -4206,6 +4212,11 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>  	case CLOCK_MONOTONIC:
>  		skb->tstamp_type = SKB_CLOCK_MONO;
>  		break;
> +	case CLOCK_TAI:
> +		skb->tstamp_type = SKB_CLOCK_TAI;
> +		break;
> +	default:
> +		WARN_ONCE(true, "clockid %d not supported", tstamp_type);

and set to 0 and default tstamp_type?

>  	}
>  }

>  >
 @@ -9372,10 +9378,16 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>  	*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
>  			      SKB_BF_MONO_TC_OFFSET);
>  	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
> -				SKB_MONO_DELIVERY_TIME_MASK, 2);
> +				SKB_MONO_DELIVERY_TIME_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
> +	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
> +				SKB_MONO_DELIVERY_TIME_MASK, 3);
> +	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
> +				SKB_TAI_DELIVERY_TIME_MASK, 4);
>  	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
>  	*insn++ = BPF_JMP_A(1);
>  	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
> +	*insn++ = BPF_JMP_A(1);
> +	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_TAI);
>  
>  	return insn;
>  }
> @@ -9418,10 +9430,26 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>  		__u8 tmp_reg = BPF_REG_AX;
>  
>  		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
> +		/*check if all three bits are set*/
>  		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
> -					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
> -		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
> -					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
> +					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
> +					SKB_TAI_DELIVERY_TIME_MASK);
> +		/*if all 3 bits are set jump 3 instructions and clear the register */
> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
> +					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
> +					SKB_TAI_DELIVERY_TIME_MASK, 4);
> +		/*Now check Mono is set with ingress mask if so clear */
> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
> +					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 3);
> +		/*Now Check tai is set with ingress mask if so clear */
> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
> +					TC_AT_INGRESS_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
> +		/*Now Check tai and mono are set if so clear */
> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
> +					SKB_MONO_DELIVERY_TIME_MASK |
> +					SKB_TAI_DELIVERY_TIME_MASK, 1);

This looks as if all JEQ result in "if so clear"?

Is the goal to only do something different for the two bits being 0x1,
can we have a single test with a two-bit mask, rather than four tests?



