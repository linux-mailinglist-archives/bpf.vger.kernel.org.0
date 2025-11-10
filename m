Return-Path: <bpf+bounces-74061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB1C468BF
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 13:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8A9C4EB0D6
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 12:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FEC17B43F;
	Mon, 10 Nov 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JFwayQSD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D7D17BA6
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777073; cv=none; b=YgStjavlkw2EUcxddvMii4bN0VNt3alWXtxJHdY+007eHFime22ss3eBNN2HwJuXINBe/gvImcKbYNOXUW3oBawH0a/fCzH/MJxGub0F3lIVpbkfFbM/PrW3RwIxZWhaot3OKFL/xwMUkJy+pdSX7/pKk/nE5Q6LL5/agKvYkQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777073; c=relaxed/simple;
	bh=x30oLxU9HmV/Il4EwmoaWXxL/qsnd4mDnpMr5mGkzsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ACG/b7e2wQpYkToeaB0gtKSbIj1XCETHbm98Q1X7LLjH7Vk+0xc2mtoH2k3p/cAcgLkRwzVkOqdR5xmTsnRWnkco3EnS6IfcuQ+dswfFhvWwQiJLCYbw432maD2gVw0OlzTas4KQVGuBCWoUO/vy4GMyyKAiDbm4rFpJo0Ad/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JFwayQSD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b72e43405e2so273479466b.0
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 04:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762777069; x=1763381869; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0158B5PEE13qHTCWtnff3hPAcsBc/ztcbY+33+pkdE=;
        b=JFwayQSDROs6O52F/Wmi8JT9LkOcrvtwNS58s5AywsfHJARMXuSr7CPCsi2dv+jakM
         zm3/2RxvfzRkGjrf4bSRwfwRqljV10vmNsfUEOpLb1FJHSAoSf8vCGgZxtKe2cK4hyb4
         MaE2QtflqTIEeM1owfIzi5LdGNHhGojAqt+gD30sMFtBdzEqE6OB+qKJZbI2qANdixcb
         i72KfbNkAdCNRDpPIBDnGn+51dAKGKFFGj6rTjZyQT3qQHbfceRXbiXHoP5ZksdK/RHd
         pmxTZ5OQvLXXACX3PEMwB57MwXPbIaIMpZpF0yPS2JLTgGFQwkr9M9EsvdOF28CvQuvi
         2r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777069; x=1763381869;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0158B5PEE13qHTCWtnff3hPAcsBc/ztcbY+33+pkdE=;
        b=DjH5mzDjWdJ0CjtnBaSqDkN8rnghQ03Pu0og/JkkIWvAW5dwHRrCzTOacZisCAcDCM
         6g4jDZMDOYWHyKyOyjzHvPjYo7LelbdfjXbSZ517kaA/IsR7nss/03jeiEk9/vJHUVFn
         aWf+atyGMQY/sBhWv2qnNO4pRqvnjUYWcfm7khbx7hoNAdnRhuaHF4MPiYevxsL5rlzE
         2ZyKT0XSxBjWJqgrACkbrGrkbzs/D7IZGd1KuyEblZVw6Mv23fEuTsM9NblB3C2Txi1l
         B9n+jXWoCREzFdBThAsNc+k5beEh0jdUJEh/Ijy2nXkcte4VWa0pNcw2/rpLPF+ZliEc
         Ypxw==
X-Gm-Message-State: AOJu0YxvclQIPA6IOU1JjASUrNZcf+aigbcDE83iS+M/USrlzxcR2y9T
	sOy5FxHTsruuUBmugWoV9EKguchmcxkuBlV9HNM+fQcAVUC9hlbYjLHeP4cdAS8hKhA=
X-Gm-Gg: ASbGncu/Ik3AkF1avgfscucYEuLuaOjeh0VlHzDA09AMIC4AK9wH7/18r+vR7bkSo7C
	VORBL36LTu+KvhmXb28aadjcR4IZj8sXNAp+k08FiddkO+/OzmpwwRMFkCdokArHnxFG6CeFW6C
	Hm+e3IiAPKLB+xAZeVMqEDILyZ1Hlr1Uw/WLGQSPF9bD8r+BX2gLxXFQ/40nw8p+lyuGI4nv9aj
	TQxmxYtVNKK1C33APf+CYvplNkCVu1XKmTfypeo92ZUiKtN6UFtIN1rforAt0oMP3pSxXnoPAVR
	QkAB9hGpeyW4EW5jWl3Vwtf9sBlakipiCx9flETvq/zQAgH/UEXLhieUiA7aH4Jz61bLg/NIRu5
	ikdatZ6VuknY3Ju/wp+UST2wRNVj2w3rtzqVQVXMWrK1pGZ6YECuPDCUKbcoDnxOANmUlE1XFpw
	E8YTI=
X-Google-Smtp-Source: AGHT+IECCKaLcKBY/MM0m4Eszl3cAn0BtYgSFLjttdAAn1/dYj799+6saR7RH4VK6qqLCBl6bcCgHA==
X-Received: by 2002:a17:906:dc8d:b0:afe:159:14b1 with SMTP id a640c23a62f3a-b72df987f81mr836964966b.9.1762777069511;
        Mon, 10 Nov 2025 04:17:49 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbca75bsm1107983266b.14.2025.11.10.04.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:17:49 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,  davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, arthur@arthurfabre.com,
 hawk@kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v4 07/16] bpf: Make bpf_skb_adjust_room
 metadata-safe
In-Reply-To: <9b3ca8c01aac5510f1ff8738b3856e5e2bbe43075333c27642eb69a6847a50ef@mail.kernel.org>
	(bot's message of "Wed, 5 Nov 2025 20:42:03 +0000 (UTC)")
References: <20251105-skb-meta-rx-path-v4-7-5ceb08a9b37b@cloudflare.com>
	<9b3ca8c01aac5510f1ff8738b3856e5e2bbe43075333c27642eb69a6847a50ef@mail.kernel.org>
Date: Mon, 10 Nov 2025 13:17:48 +0100
Message-ID: <87bjlaf5eb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 05, 2025 at 08:42 PM GMT, bot+bpf-ci@kernel.org wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 96714eab9..370ddc61b 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3260,11 +3260,11 @@ static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
>>
>>  static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
>>  {
>> -	/* Caller already did skb_cow() with len as headroom,
>> +	/* Caller already did skb_cow() with meta_len+len as headroom,
>>  	 * so no need to do it here.
>>  	 */
>>  	skb_push(skb, len);
>> -	memmove(skb->data, skb->data + len, off);
>> +	skb_postpush_data_move(skb, len, off);
>>  	memset(skb->data + off, 0, len);
>
> The comment update says callers provide meta_len+len as headroom, but
> is this true for all callers?
>
> bpf_skb_proto_4_to_6() calls skb_cow(skb, len_diff) then calls
> bpf_skb_net_hdr_push()->bpf_skb_generic_push(). Similarly,
> bpf_lwt_seg6_adjust_srh() calls skb_cow_head(skb, len) then calls
> bpf_skb_net_hdr_push()->bpf_skb_generic_push().
>
> Neither accounts for meta_len in their headroom calculation. When
> skb_postpush_data_move()->skb_data_move() runs, if meta_len >
> skb_headroom(skb) after the push, the metadata gets silently cleared
> (see the WARN_ON_ONCE check in skb_data_move() at skbuff.h).
>
> Can the metadata be lost when these functions are called on skbs with
> metadata?

bpf_skb_proto_4_to_6() is handled by the next patch (8/16).

LWT and other encap facilities are out of scope for this series.
bpf_lwt_seg6_adjust_srh() is on my todo list.

[...]

