Return-Path: <bpf+bounces-61293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5F9AE46E8
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FB3189776E
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE82E25E81D;
	Mon, 23 Jun 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C60vzs05"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D025E823;
	Mon, 23 Jun 2025 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689351; cv=none; b=Kc9RncpFl1w7DAFreDLEmZa1OKNOdhsuq4440C7XSwNlG9fGcpk/c18KkqttpiNDQjJoMxUlmFhE+XdHbTRhlDa1+HK1hqeDBdjLZBYy92VRZVH88Fva21FLIemqmeRq6wm8A4a70FsvK8PZmVOGYUkoe5UcTOgjpMAMFZ0gO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689351; c=relaxed/simple;
	bh=8uFwwxuVhPfrVi45vOPS7eeLXU0rYURRDF6U6BXgiug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEEijhS8KNtzkxYLJHvpNrtNbYzB/u+RI/D6UihuaXTFd7sIuWIJw5G+SiC9jDKgJyx9eCj+iuQepMWODQ8BCNDUSKBkHCzZT3hfmsyqzBiJ23KnjH8t6sgGSHA99A8HZHYPwcX5R6kwODCYgxGctSf/fT3AOMaeYySDNhmLiB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C60vzs05; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236377f00a1so38796915ad.3;
        Mon, 23 Jun 2025 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750689349; x=1751294149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=le4M6xt0anI1cGfEup0uN9VydUsywZE0Uzdamf2pdRk=;
        b=C60vzs05ChOAbuwVqpiEo6Dy+IUf5AaNALmktKlI9/iMKQb6faEfTZW8LzZP67LqcT
         mTEMGPFclYscUZR6xKWh9fMOpnRAbfAg4oOiqg1hOG9BOB8J8O0wWlp1cnqqJ+t9LQrr
         QyrWuGI46E9783D/H87yUrNR3bSmUJoMOwHpEGn+uA7R77utpLWL+wHaF2NNK/apI434
         RaA7klHNYrSiSBM+gvXs+2I7nT3m+5KB1hFSPVkqpKlb/KqW2OaW7BezJsT3GmjgyyDr
         rIWgK+eRJl0OYkuzpbT8lPNNF17K54+5BuWIcr7lKiHroUxvh4rtpiciB8kBhpXi7Ar2
         wKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750689349; x=1751294149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=le4M6xt0anI1cGfEup0uN9VydUsywZE0Uzdamf2pdRk=;
        b=NMl5DPvynDlD0wz25hiZd7dlEo4lQvebUBxCY3vVZ4KeXWTQngYrcXA+CVEgzxy54V
         nmX/OvWEmgnciyO5klO8AHWaolOJKvTS9LXo8xKy4mmD8mv12tKLGV7CuNd4IgDc36Ec
         Le4sm74zpWG65+PNnuhkEX3PgcfbbXepOArN4TkDLWpog9jT35+UKV8S2liMRJX1yqZL
         /okMDVAykGLGZtmSIVkupNo0EQk/NZZ24gKIQ1AQa70S1bap92IqRkcAwc0zhxG74Kzs
         5di63VW92FPpWCVmM16MOwpX6qCWgOwqWyz14kwMI/5MZ3Z1sC2hccY5xOSodLCB+jM8
         8RPg==
X-Forwarded-Encrypted: i=1; AJvYcCUC93SlNNYQavtuQpke7Nkl+xzJ9Eg1i3IuwpuLuXkJLcxqfl3JpmvbHAY0LeY8lU7iCVk=@vger.kernel.org, AJvYcCVKBh5jIXMXs3UPbnG/oIksyFIzUfUP2kFP4/fRI9FE85jmmR4/YTQU6jsaTFNdxW1WAKPULTxl@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNqUT2eb/OOoKs11PupI1mzYkKYjwW2m9D0OL2JBIzkj/v+4t
	2NaOXvOkFAxBrDmUj7YD9nJkrzwjh7m3n+834kF+bpv7xeuQw8cvZHA=
X-Gm-Gg: ASbGncv9ughiNi4jylZwG1TpHs5ZhfjvrYhU/B0T24wPCza5UJ+imo0P35n82hfNYAh
	X/RlJLRQB1EogSW3/NKKi+oq0A8IjkgwfJdCocXIiO1MOZbfwOJY2KnZpVykA9S6eWJi3AhC3j8
	dXIK6lXbkvi4H5NVQXGJBbSm7m4WRbHSRkOCyjZUVPYlmzd/m06chWDLKVTJxRjldFRC5GNUEAK
	btIpRQJgAR0yNuNFlj5tylAl2aDQs+7fpXafJhiI+/KNOg09OeNgXXZRMVI6U0w7akKy5J1TsV4
	011iBKqvI6eGDZbml2GzLmYzuEVHw2xfgJuKE71AaIkshEo2GIWnnr2EW8/JDSKRVjEQAAph/SE
	JiLnRrQW9IzZZq4fwNpVMJdI=
X-Google-Smtp-Source: AGHT+IFiD1i0PThNFD33u8HNG3UK6b0XRr/FDgwkWC1gH6MYD1iM6N3CbaW/z9O1vOX4dsKBEPe1fg==
X-Received: by 2002:a17:903:2445:b0:234:c5c1:9b73 with SMTP id d9443c01a7336-237d989d06emr192991835ad.36.1750689349085;
        Mon, 23 Jun 2025 07:35:49 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d871f011sm87634705ad.235.2025.06.23.07.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:35:48 -0700 (PDT)
Date: Mon, 23 Jun 2025 07:35:47 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] net: xsk: update tx queue consumer
 immediately after transmission
Message-ID: <aFlmQ94TeHb9v-OC@mini-arch>
References: <20250623073129.23290-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623073129.23290-1-kerneljasonxing@gmail.com>

On 06/23, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> For afxdp, the return value of sendto() syscall doesn't reflect how many
> descs handled in the kernel. One of use cases is that when user-space
> application tries to know the number of transmitted skbs and then decides
> if it continues to send, say, is it stopped due to max tx budget?
> 
> The following formular can be used after sending to learn how many
> skbs/descs the kernel takes care of:
> 
>   tx_queue.consumers_before - tx_queue.consumers_after
> 
> Prior to the current patch, in non-zc mode, the consumer of tx queue is
> not immediately updated at the end of each sendto syscall when error
> occurs, which leads to the consumer value out-of-dated from the perspective
> of user space. So this patch requires store operation to pass the cached
> value to the shared value to handle the problem.
> 
> More than those explicit errors appearing in the while() loop in
> __xsk_generic_xmit(), there are a few possible error cases that might
> be neglected in the following call trace:
> __xsk_generic_xmit()
>     xskq_cons_peek_desc()
>         xskq_cons_read_desc()
> 	    xskq_cons_is_valid_desc()
> It will also cause the premature exit in the while() loop even if not
> all the descs are consumed.
> 
> Based on the above analysis, using 'cached_prod != cached_cons' could
> cover all the possible cases because it represents there are remaining
> descs that are not handled and cached_cons are not updated to the global
> state of consumer at this time.

> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> V2
> Link: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
> 1. filter out those good cases because only those that return error need
> updates.
> Side note:
> 1. in non-batched zero copy mode, at the end of every caller of
> xsk_tx_peek_desc(), there is always a xsk_tx_release() function that used
> to update the local consumer to the global state of consumer. So for the
> zero copy mode, no need to change at all.
> 2. Actually I have no strong preference between v1 (see the above link)
> and v2 because smp_store_release() shouldn't cause side effect.
> Considering the exactitude of writing code, v2 is a more preferable
> one.
> ---
>  net/xdp/xsk.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 5542675dffa9..b9223a2a6ada 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -856,6 +856,9 @@ static int __xsk_generic_xmit(struct sock *sk)
>  	}
>  
>  out:
> +	if (xs->tx->cached_prod != xs->tx->cached_cons)

Can we use xskq_has_descs() here instead?

And still would be nice to verify this with a test. Should not be much work,
most of the things (setup/etc) are already there, so you won't have
to write everything from scratch...

