Return-Path: <bpf+bounces-43460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC69B5882
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7032836DA
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FE11187;
	Wed, 30 Oct 2024 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lErBZuTw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F52C9D
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247728; cv=none; b=UWt6kaWuRwpkapb/Dj8m415cQmE8ilSE9k7W8Kkb1YTmSMM8zB2pDGm85lAev2RhZ0UCBiDU/hnx3Rxt07J4hWqFbBuzyOjXWZmNgslcFi1G6Q81EuZGrBFdzMjJaZxcicmqnLrgn0yDd2biaXXp+2T77y+1exN04wcq0zu2jDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247728; c=relaxed/simple;
	bh=5KK5BwOVk4nZXPqG2HyNlEwTFySftAghQQLTw5Bcehk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJKfIyCN3QYELu0DaGD7s1bhs61pyeVByDeyeIyxLuYkuGzlp10NiA1Ee6lDsf0sFI0tabNgSy6GBVPCUAomH0TB1nYBTvUnM3x7ManCZx32rWzV++RU5LxuioqCB8FVJZ+XjkDB1flpgPm5cwWZqru90nDhLbNHfWzo2Qzc5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lErBZuTw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so4945347a91.2
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730247725; x=1730852525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qd+q//U18ZbqoaQ87tVKQvEEV2BeNCWaPA9LlfEaR0=;
        b=lErBZuTwJx9HYs3HFyqyG4BD/rkUJq8CzwPKE9j2tu1lk6GLG4YhgLt7xSKub6GzJr
         KFa1ukUut6fDqE1i1QhPdA9PSeOHBcwZHszJNf02PfZ3c/eUUz4q0VKS9c5ghw+hUqVH
         cwSSjPsfN+iOamheTsS7bBPDpYWb5ORXkek3Ptk9kDxamOFHMNWw7ZWb+iZMjskBnZ5z
         9zlDZ83Uw/BwdG1ekGVls9Nc2+xl49PCzYiMsA0esGtxy2Fm11J/aqos3sCdJ5ahSi6x
         2Gkm2mIcZHKaLsWJIOOooGaJnXw5GpCj72qI4SVUilaXQREzuEDG7P/EjwKPb/XVP7z+
         Mmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247725; x=1730852525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qd+q//U18ZbqoaQ87tVKQvEEV2BeNCWaPA9LlfEaR0=;
        b=dKymk00WqxLNnGYGbUQ9dM7MNgHmM3ue8sFkm8G5yYSL7QbENFY4E3CfRoJEnlkkOU
         I7YLlqJhr3A/jS0CqD6X+4gzterhtkEVSSWhp5IrXXhSVyy0MbfWE4o9eyeKtQPO9WHL
         RxdcWCIQ7TnPMKfgCr4O1xkZP3acs90seesrq5+psE3cDHANhcZkPUsABN+Bllo5c/kW
         3CuFhAppDm8V+8thJWwIczdhG/8xD9Cb4AMWPVnCqVtez/t/BqN3rpcvud1/CESPojpV
         9Aocqx4SJ9XYjOTN2jYJ9X1TRYG+h7uwg91QXtHq2apMtEptjy8QW6sD3a+a0qYA4Qxw
         9DHA==
X-Gm-Message-State: AOJu0Yxce/TxWdby435MK1EZDJzuMzErIR/9cvlsGlhn0M6Gky9fHcHc
	u2ssl/r9gCDRHag4qhPg2s60VUVbVAV7p6hVAoqrx/zBmpVY8rM=
X-Google-Smtp-Source: AGHT+IGglVOwvfQ4eEVlFvnpZ24E2e4d+Wdq/XnuuZN3JJsMSyOG2DUpTWzBylSlEYIjrcgzmjKcEg==
X-Received: by 2002:a05:6a21:38a:b0:1d8:a9c0:8853 with SMTP id adf61e73a8af0-1d9a8402d9dmr17862033637.23.1730247725382;
        Tue, 29 Oct 2024 17:22:05 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931cd4sm8211378b3a.70.2024.10.29.17.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:22:04 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:22:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, cong.wang@bytedance.com
Subject: Re: [PATCH bpf] bpf: Add sk_is_inet check in tls_sw_has_ctx_tx/rx
Message-ID: <ZyF8LA6v9iAuxNXi@mini-arch>
References: <20241029202830.3121552-1-zijianzhang@bytedance.com>
 <ZyFquswggZxKCYGH@mini-arch>
 <abc69614-869d-42d8-be8e-b4573029611b@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abc69614-869d-42d8-be8e-b4573029611b@bytedance.com>

On 10/29, Zijian Zhang wrote:
> 
> 
> On 10/29/24 4:07 PM, Stanislav Fomichev wrote:
> > On 10/29, zijianzhang@bytedance.com wrote:
> > > From: Zijian Zhang <zijianzhang@bytedance.com>
> > > 
> > > As the introduction of the support for vsock and unix sockets in sockmap,
> > > tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be inet.
> > > Otherwise, tls_get_ctx may return an invalid pointer and result in page
> > > fault in function tls_sw_ctx_rx.
> > > 
> > > BUG: unable to handle page fault for address: 0000000000040030
> > > Workqueue: vsock-loopback vsock_loopback_work
> > > RIP: 0010:sk_psock_strp_data_ready+0x23/0x60
> > > Call Trace:
> > >   ? __die+0x81/0xc3
> > >   ? no_context+0x194/0x350
> > >   ? do_page_fault+0x30/0x110
> > >   ? async_page_fault+0x3e/0x50
> > >   ? sk_psock_strp_data_ready+0x23/0x60
> > >   virtio_transport_recv_pkt+0x750/0x800
> > >   ? update_load_avg+0x7e/0x620
> > >   vsock_loopback_work+0xd0/0x100
> > >   process_one_work+0x1a7/0x360
> > >   worker_thread+0x30/0x390
> > >   ? create_worker+0x1a0/0x1a0
> > >   kthread+0x112/0x130
> > >   ? __kthread_cancel_work+0x40/0x40
> > >   ret_from_fork+0x1f/0x40
> > > 
> > > Fixes: 0608c69c9a80 ("bpf: sk_msg, sock{map|hash} redirect through ULP")
> > > Fixes: e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")
> > > 
> > > Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> > > ---
> > >   include/net/tls.h | 12 ++++++++++--
> > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/net/tls.h b/include/net/tls.h
> > > index 3a33924db2bc..a65939c7ad61 100644
> > > --- a/include/net/tls.h
> > > +++ b/include/net/tls.h
> > > @@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
> > >   static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
> > >   {
> > > -	struct tls_context *ctx = tls_get_ctx(sk);
> > > +	struct tls_context *ctx;
> > > +
> > > +	if (!sk_is_inet(sk))
> > > +		return false;
> > > +	ctx = tls_get_ctx(sk);
> > >   	if (!ctx)
> > >   		return false;
> > >   	return !!tls_sw_ctx_tx(ctx);
> > > @@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
> > >   static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
> > >   {
> > > -	struct tls_context *ctx = tls_get_ctx(sk);
> > > +	struct tls_context *ctx;
> > > +
> > > +	if (!sk_is_inet(sk))
> > > +		return false;
> > > +	ctx = tls_get_ctx(sk);
> > >   	if (!ctx)
> > >   		return false;
> > >   	return !!tls_sw_ctx_rx(ctx);
> > 
> > This seems like a strange place to fix it. Why does tls_get_ctx return
> > invalid pointer for non-tls/ulp sockets? Shouldn't it be NULL?
> > Is sockmap even supposed to work with vsock?
> 
> Here is my understanding, please correct me if I am wrong :)
> ```
> static inline struct tls_context *tls_get_ctx(const struct sock *sk)
> {
> 	const struct inet_connection_sock *icsk = inet_csk(sk);
> 	return (__force void *)icsk->icsk_ulp_data;
> }
> ```
> tls_get_ctx assumes the socket passed is icsk_socket. However, unix
> and vsock do not have inet_connection_sock, they have unix_sock and
> vsock_sock. The offset of icsk_ulp_data are meaningless for them, and
> they might point to some other values which might not be NULL.
> 
> Afaik, sockmap started to support vsock in 634f1a7110b4 ("vsock: support
> sockmap"), and support unix in 94531cfcbe79 ("af_unix: Add
> unix_stream_proto for sockmap").
> 
> If the above is correct, I find that using inet_test_bit(IS_ICSK, sk)
> instead of sk_is_inet will be more accurate.

Thanks for the context, makes sense. And consolidating this sk_is_inet
check inside tls_get_ctx is worse because it gets called outside of
sockmap?

