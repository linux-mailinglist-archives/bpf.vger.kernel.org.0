Return-Path: <bpf+bounces-55344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D5A7C1A2
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAAD189CC14
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D528C20CCDB;
	Fri,  4 Apr 2025 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LaHIuD19"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C572154C0D;
	Fri,  4 Apr 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784673; cv=none; b=qbAyxi4O96t/De8qgHLmW9uYI/ECmr6Xwx+aU9EHVBlLqNWwJpcuj6bTVD4FxRqqzAR8flRSQO0S5BCOrPV/gTizNwSZELXG3HhGN57YxjAhG2cjjuhjMrwhrcKgwHCUofcMEk0z14uK2DAyheyoTK4wXtLpDNcY1P1SZFE7ZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784673; c=relaxed/simple;
	bh=rRoLnolncHmePR/dDpHsSC2EmhJT64V5SPShOlncaY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSc5twYrtwNVztEFGTyiUs4U6iA3FdVoCkpAVzd2R2I/58XUEB8mqL8mSyS6TNzFhyzyXlsEKm89kJ4iJ60ETAUsu49X70EcFRbo0oW9AvTPmCqZx+pxj9HaoqzPUfY3B3CIVDoQNOeM74NgEo+iO1sBa0DchV5KimCE5kfqU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LaHIuD19; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ENuoaEgh9uyc2IrxK0yKzzOvrotjm82t0h3DCK6jUY4=; b=LaHIuD19EpkCFrpFSIrSIEHD0P
	N9cDu5ce0S5pXrwW6qvJ8GAcpcz8guIla1awWlR3swLG4sSKDySwizBQP5MR2sahWu0gvHywsTR5w
	gjq4f9Z44E2uPuGb0WEOG7XFxvXPTnylCh8CzY/xwTteasBSyURfVVAWnAwwh1Gb2Ij+JLvKwjjBY
	K+jyLV6ZyTOui78n0pAIyWSS8ylUOeBS2KgXcBat/TUCYz5JfFytMrB+q5SC1+E01OR2sHtDS2glM
	RMIUafoDtbPJbTCdTjur9D49l++jJT7DyWs8xC1H5wS55heBl7FhrCgPhIDBeXQ+M4VbhnGY37udg
	Iu7HwVqw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1u0jds-000Loq-0y;
	Fri, 04 Apr 2025 18:11:40 +0200
Received: from [178.197.249.21] (helo=[192.168.1.114])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1u0jdr-000Hd3-2c;
	Fri, 04 Apr 2025 18:11:39 +0200
Message-ID: <584071a3-10df-443a-ad8c-1fa7bc82d821@iogearbox.net>
Date: Fri, 4 Apr 2025 18:11:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb
 frags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, ast@kernel.org, john.fastabend@gmail.com,
 Willem de Bruijn <willemb@google.com>, Matt Moeller
 <moeller.matt@gmail.com>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>
References: <20250404142633.1955847-1-willemdebruijn.kernel@gmail.com>
 <20250404142633.1955847-2-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <20250404142633.1955847-2-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27598/Fri Apr  4 10:40:10 2025)

Hi Willem,

On 4/4/25 4:23 PM, Willem de Bruijn wrote:
[...]
> v1->v2
>    - introduce bfp_skb_load_helper_convert_offset to avoid open coding
> ---
>   include/linux/filter.h |  3 --
>   kernel/bpf/core.c      | 21 -----------
>   net/core/filter.c      | 80 +++++++++++++++++++++++-------------------
>   3 files changed, 44 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5cf4d35d83e..708ac7e0cd36 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1496,9 +1496,6 @@ static inline u16 bpf_anc_helper(const struct sock_filter *ftest)
>   	}
>   }
>   
> -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
> -					   int k, unsigned int size);
> -
>   static inline int bpf_tell_extensions(void)
>   {
>   	return SKF_AD_MAX;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ba6b6118cf50..0e836b5ac9a0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -68,27 +68,6 @@
>   struct bpf_mem_alloc bpf_global_ma;
>   bool bpf_global_ma_set;
>   
> -/* No hurry in this branch
> - *
> - * Exported for the bpf jit load helper.
> - */
> -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, unsigned int size)
> -{
> -	u8 *ptr = NULL;
> -
> -	if (k >= SKF_NET_OFF) {
> -		ptr = skb_network_header(skb) + k - SKF_NET_OFF;
> -	} else if (k >= SKF_LL_OFF) {
> -		if (unlikely(!skb_mac_header_was_set(skb)))
> -			return NULL;
> -		ptr = skb_mac_header(skb) + k - SKF_LL_OFF;
> -	}
> -	if (ptr >= skb->head && ptr + size <= skb_tail_pointer(skb))
> -		return ptr;
> -
> -	return NULL;
> -}

Wouldn't this break sparc 32bit JIT which still calls into this?

arch/sparc/net/bpf_jit_asm_32.S :

#define bpf_negative_common(LEN)                        \
         save    %sp, -SAVE_SZ, %sp;                     \
         mov     %i0, %o0;                               \
         mov     r_OFF, %o1;                             \
         SIGN_EXTEND(%o1);                               \
         call    bpf_internal_load_pointer_neg_helper;   \
          mov    (LEN), %o2;                             \
         mov     %o0, r_TMP;                             \
         cmp     %o0, 0;                                 \
         BE_PTR(bpf_error);                              \
          restore;

Thanks,
Daniel

