Return-Path: <bpf+bounces-43663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67E9B805D
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 17:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DAA1C21C65
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF201BDA87;
	Thu, 31 Oct 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNwZNBA8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFAC1BBBE5
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392795; cv=none; b=s/ufbOhD27B0vPxLjrak9Hiii5TKBJ7qsnCWuwR4NiENEWmy2fe94Z2SVP/VMfnaz3hbwV7hRD4xqU+fUMifw+CTgZjSbg9u17vaCw8UAA3JnlBC90oFXJk7fWL7ko6K0MbHoJOgtrsHkaIKpIoSJ8ItSsdE/B3JqnZ5pfWjnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392795; c=relaxed/simple;
	bh=oPKcVovIwyv911ES8QytJ8gejHHhjfxglIweyvnQvY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtysmqsKab+oAwAEL6OvbDbz/l4aXbu74L89uRwwkoxOyU+Rb3zUvU25R1+PG8wkWZ5TmMdNJd1emrkGHCyBBAo0OhqOg3Qz2zvcL7iVH+ZWKTPpZnfM2BcYzuVTHVBbHMH4A14JMoTaz6+pkZfUqa9EXEVc1YNqTWNxo6XFc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNwZNBA8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so1035874a12.0
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730392792; x=1730997592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BbLPPJs0YwbZw5OmrEL6Edm1Apus+AFx9oKF0QsVJ24=;
        b=dNwZNBA8WUa689Hfeci4BGYlwIG08yi0A/gn1JQgsMR51K7at1EsHhXMw/ECx4XGcm
         RJdeYA78oTpZcqlnycqYvDLpPxVnhIATtbhvym+/3MabsacvIH50TWfn0Lds+7RCaOGw
         LC5PeZiMMJnG6Bdcpvy51SzhbW+7UCthqh/xc7wBwX6DqNT01cusdcBgc9GSXjmZFmcx
         XyZTvEWMfpmXJHiWd7iiC95YWB9aWmW/sRjquFQGCT+6GKfhKKXyEcKVASkhm279Vek3
         GZ+Nvo/iv9wwFsZjuhP9l/qLLOToYALREwvla6fVVejg5c3BWNISqHEAAxtcPKwjIP/4
         pPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392792; x=1730997592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbLPPJs0YwbZw5OmrEL6Edm1Apus+AFx9oKF0QsVJ24=;
        b=lCD2CVe61dlMz9byfbZyII8jgUP5CAVTCmq95xGJo5uxs6MaVdhY+clBGDh3E91gR0
         ve4cL+s0UxkpnuXQvM9Vd9F2Xs0jz0zBMLy1vBhK6+YCHAYZy4A3JlyxB1vVrRMoqfvs
         mUCPDBmxEhai10dY8g+dXybuyfdYUnIojxCyj/z/vLZ7aGYO5Pg4rBIDQ1zIBhdfuSdv
         36sAGPFG9GeY94ZUQ0GRYxunX/99MWotY0nKRQ9RkuRptKAkQ6YrlW/qtfcA1uH6N0XS
         jQPXdzeO07AaYV5pYJ/c5+Tpqa9wsfDwlLDJrjzSOsL4fJjy2naalnxP4gXWwLClSJWI
         vZ/A==
X-Gm-Message-State: AOJu0Yxd5/e/h+0vUW+54klo7/06obyAoLXrOmgvIc802EbY3BvDjTqJ
	TWW3bHvWKkLZZN4iqiC3WXYRN/cy7rVcFl6TSjCjPZQF3BQ39sE=
X-Google-Smtp-Source: AGHT+IH0NlM7UcnAmTOEAkDBTFYJX8xnUc75SH/wTrqvQ0LZT+0MiTbqezA5A3/kMs4+XQZ4r9jzLQ==
X-Received: by 2002:a17:90b:4d06:b0:2e2:a2f0:e199 with SMTP id 98e67ed59e1d1-2e94c29ec6fmr726615a91.8.1730392792163;
        Thu, 31 Oct 2024 09:39:52 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db18717sm1351559a91.35.2024.10.31.09.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:39:51 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:39:50 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, cong.wang@bytedance.com
Subject: Re: [PATCH bpf] bpf: Add sk_is_inet check in tls_sw_has_ctx_tx/rx
Message-ID: <ZyOy1lbttxzP87KQ@mini-arch>
References: <20241029202830.3121552-1-zijianzhang@bytedance.com>
 <ZyFquswggZxKCYGH@mini-arch>
 <abc69614-869d-42d8-be8e-b4573029611b@bytedance.com>
 <ZyF8LA6v9iAuxNXi@mini-arch>
 <08853817-921b-4595-a7d5-67007bf21500@bytedance.com>
 <ZyJS5UCJu1YlsrJr@mini-arch>
 <0e609f5d-ebee-46f8-b3c6-69672495b4a4@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e609f5d-ebee-46f8-b3c6-69672495b4a4@bytedance.com>

On 10/30, Zijian Zhang wrote:
> On 10/30/24 8:38 AM, Stanislav Fomichev wrote:
> > On 10/29, Zijian Zhang wrote:
> > > 
> > > On 10/29/24 5:22 PM, Stanislav Fomichev wrote:
> > > > On 10/29, Zijian Zhang wrote:
> > > > > 
> > > > > 
> > > > > On 10/29/24 4:07 PM, Stanislav Fomichev wrote:
> > > > > > On 10/29, zijianzhang@bytedance.com wrote:
> > > ...
> > > > > > > diff --git a/include/net/tls.h b/include/net/tls.h
> > > > > > > index 3a33924db2bc..a65939c7ad61 100644
> > > > > > > --- a/include/net/tls.h
> > > > > > > +++ b/include/net/tls.h
> > > > > > > @@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
> > > > > > >     static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
> > > > > > >     {
> > > > > > > -	struct tls_context *ctx = tls_get_ctx(sk);
> > > > > > > +	struct tls_context *ctx;
> > > > > > > +
> > > > > > > +	if (!sk_is_inet(sk))
> > > > > > > +		return false;
> > > > > > > +	ctx = tls_get_ctx(sk);
> > > > > > >     	if (!ctx)
> > > > > > >     		return false;
> > > > > > >     	return !!tls_sw_ctx_tx(ctx);
> > > > > > > @@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
> > > > > > >     static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
> > > > > > >     {
> > > > > > > -	struct tls_context *ctx = tls_get_ctx(sk);
> > > > > > > +	struct tls_context *ctx;
> > > > > > > +
> > > > > > > +	if (!sk_is_inet(sk))
> > > > > > > +		return false;
> > > > > > > +	ctx = tls_get_ctx(sk);
> > > > > > >     	if (!ctx)
> > > > > > >     		return false;
> > > > > > >     	return !!tls_sw_ctx_rx(ctx);
> > > > > > 
> > > > > > This seems like a strange place to fix it. Why does tls_get_ctx return
> > > > > > invalid pointer for non-tls/ulp sockets? Shouldn't it be NULL?
> > > > > > Is sockmap even supposed to work with vsock?
> > > > > 
> > > > > Here is my understanding, please correct me if I am wrong :)
> > > > > ```
> > > > > static inline struct tls_context *tls_get_ctx(const struct sock *sk)
> > > > > {
> > > > > 	const struct inet_connection_sock *icsk = inet_csk(sk);
> > > > > 	return (__force void *)icsk->icsk_ulp_data;
> > > > > }
> > > > > ```
> > > > > tls_get_ctx assumes the socket passed is icsk_socket. However, unix
> > > > > and vsock do not have inet_connection_sock, they have unix_sock and
> > > > > vsock_sock. The offset of icsk_ulp_data are meaningless for them, and
> > > > > they might point to some other values which might not be NULL.
> > > > > 
> > > > > Afaik, sockmap started to support vsock in 634f1a7110b4 ("vsock: support
> > > > > sockmap"), and support unix in 94531cfcbe79 ("af_unix: Add
> > > > > unix_stream_proto for sockmap").
> > > > > 
> > > > > If the above is correct, I find that using inet_test_bit(IS_ICSK, sk)
> > > > > instead of sk_is_inet will be more accurate.
> > > > 
> > > > Thanks for the context, makes sense. And consolidating this sk_is_inet
> > > > check inside tls_get_ctx is worse because it gets called outside of
> > > > sockmap?
> > > 
> > > Yes, tls_get_ctx is invoked in multiple locations, and I want to only
> > > fix sockmap related calls.
> > 
> > Sounds convincing. Unless John/Jakub have better suggestions:
> > 
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Thanks for the Ack and reviewing!
> 
> In order to make it more accurate, I added inet_test_bit(IS_ICSK, sk)
> check in version2. I just found that sk_is_inet only cannot assure
> inet_csk is valid. For example, udp_sock does not have inet_connection_sock.

Instead of testing IS_ICSK bit, will inet_csk_has_ulp helper work?

