Return-Path: <bpf+bounces-43566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D879B6800
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AE6281541
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1E0213143;
	Wed, 30 Oct 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAWSTV5C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDAF1EB9F4
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302698; cv=none; b=huRsj5pkpqMxEPVWJFrdbQ50LsiKgZFKlNChyEQp7Q1ReOhTUKLPI6K5dgPXCEHIdPta66V2lRNqA83bkbGv80htpiexhnBnQTn+sQLrF0+hTn/t3qCsMhgNUs7vhMdqcfQKngGc0a/KxGrv4/BPI9KBy6L/eRGhhVc3ycoTPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302698; c=relaxed/simple;
	bh=2F3wGOJ1MKmKd68F0aormlnRtr6ijmBTOJIGqm58uVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXj5f9SNX15oObGjnVLw02A09u2tALnQftqrC6nN8aM0haTrTIDLpzdOb9sa6G2W5ldkmvayFnyr5L5Fuw8/vLDVGeh/nzSppQHFEY5RmUK+omqTImEdMoAtxNfaEIrNtVFtaddO2C4GQqoc8l86DwdICeFn/qGm7cnt45l50No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAWSTV5C; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso5217309a91.3
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730302696; x=1730907496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfGlDT1gnigasMyZRH28681KtzsK2fGMRatfhyGX1iA=;
        b=HAWSTV5C6La2mggLMqnsrfVpUljRzdsS+aVntj2dbDFJHV75A48ucKe2wPCok2mKo/
         u0ZtP9e25ZwwRvnOLhpqq8KL8CpeoIttfvFGcAYnbsfABRqzyz91/UboaGKnhO/JpYyV
         l8it4+KtABsImtpCeX/9xroUvo7MHBftCRIppWMQeQb0wpJJ5yxVp2NhkXySVplR7bij
         AhKTG7DYdc3/+h7ASoEwsI9jGK7UkRahUbOCKY2y4RSdowyKtcVQs1IW4Cr2/CVEA/D/
         N7pDz8CelFHcGIQEYNEekEkhyOd7dxJn2hIc9h/c+/mtKywxaG2iaPkhRpiAgR95W1D8
         Qj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302696; x=1730907496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfGlDT1gnigasMyZRH28681KtzsK2fGMRatfhyGX1iA=;
        b=Wwwd3HU5uq1ke5esJvwcTHWbTwhJ2RR4HY0JZ1NH9uqBRnI+J+LyJ/LY59FPOinLhV
         SB1+SdRZezvMVIaxrDZiOfBPzWooMX8q3vKjAgPwdk8ymH9WBxONQ0xxLWC7OpjqOKzw
         UQsdsJUcwHP4snpHBy4QzFLP8ODvey7Q4449jSneoH1DpR8BUUQl4XNabHTvKG4rn7sX
         Pqx7ABN7664izvQIY+dvRoWcTRa8JKBDjttM6vGkZfIevawKxKGzgFvjA/kZ4XgZPwHy
         Y8sk/I5SUHdspywobc9sNwHnYr7H8coVQQJ9731eIAO1Cj5kU5FZqI8HQyX5tmS2ergr
         9dgg==
X-Gm-Message-State: AOJu0Yzaz7I93KLKaOmcwtrSL1PwcT9sG5fr+DL8esnGQaSRdTAlEdze
	5epGnFha+IOw65gDSWR7M3/R3K8yI1PqW6U2OI7lREXHbsHk0cQ=
X-Google-Smtp-Source: AGHT+IGPORnd4riZLfgl5l1IiA/niqSve9wJIaLxldVUb4gVUpUaF3wVUr6EMBxfgLYzkxrD8zsFvA==
X-Received: by 2002:a17:90a:d913:b0:2e2:c15f:1ffe with SMTP id 98e67ed59e1d1-2e8f0d62e7bmr16929622a91.0.1730302696066;
        Wed, 30 Oct 2024 08:38:16 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbfa8a4sm1877337a91.53.2024.10.30.08.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:38:14 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:38:13 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, cong.wang@bytedance.com
Subject: Re: [PATCH bpf] bpf: Add sk_is_inet check in tls_sw_has_ctx_tx/rx
Message-ID: <ZyJS5UCJu1YlsrJr@mini-arch>
References: <20241029202830.3121552-1-zijianzhang@bytedance.com>
 <ZyFquswggZxKCYGH@mini-arch>
 <abc69614-869d-42d8-be8e-b4573029611b@bytedance.com>
 <ZyF8LA6v9iAuxNXi@mini-arch>
 <08853817-921b-4595-a7d5-67007bf21500@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08853817-921b-4595-a7d5-67007bf21500@bytedance.com>

On 10/29, Zijian Zhang wrote:
> 
> On 10/29/24 5:22 PM, Stanislav Fomichev wrote:
> > On 10/29, Zijian Zhang wrote:
> > > 
> > > 
> > > On 10/29/24 4:07 PM, Stanislav Fomichev wrote:
> > > > On 10/29, zijianzhang@bytedance.com wrote:
> ...
> > > > > diff --git a/include/net/tls.h b/include/net/tls.h
> > > > > index 3a33924db2bc..a65939c7ad61 100644
> > > > > --- a/include/net/tls.h
> > > > > +++ b/include/net/tls.h
> > > > > @@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
> > > > >    static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
> > > > >    {
> > > > > -	struct tls_context *ctx = tls_get_ctx(sk);
> > > > > +	struct tls_context *ctx;
> > > > > +
> > > > > +	if (!sk_is_inet(sk))
> > > > > +		return false;
> > > > > +	ctx = tls_get_ctx(sk);
> > > > >    	if (!ctx)
> > > > >    		return false;
> > > > >    	return !!tls_sw_ctx_tx(ctx);
> > > > > @@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
> > > > >    static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
> > > > >    {
> > > > > -	struct tls_context *ctx = tls_get_ctx(sk);
> > > > > +	struct tls_context *ctx;
> > > > > +
> > > > > +	if (!sk_is_inet(sk))
> > > > > +		return false;
> > > > > +	ctx = tls_get_ctx(sk);
> > > > >    	if (!ctx)
> > > > >    		return false;
> > > > >    	return !!tls_sw_ctx_rx(ctx);
> > > > 
> > > > This seems like a strange place to fix it. Why does tls_get_ctx return
> > > > invalid pointer for non-tls/ulp sockets? Shouldn't it be NULL?
> > > > Is sockmap even supposed to work with vsock?
> > > 
> > > Here is my understanding, please correct me if I am wrong :)
> > > ```
> > > static inline struct tls_context *tls_get_ctx(const struct sock *sk)
> > > {
> > > 	const struct inet_connection_sock *icsk = inet_csk(sk);
> > > 	return (__force void *)icsk->icsk_ulp_data;
> > > }
> > > ```
> > > tls_get_ctx assumes the socket passed is icsk_socket. However, unix
> > > and vsock do not have inet_connection_sock, they have unix_sock and
> > > vsock_sock. The offset of icsk_ulp_data are meaningless for them, and
> > > they might point to some other values which might not be NULL.
> > > 
> > > Afaik, sockmap started to support vsock in 634f1a7110b4 ("vsock: support
> > > sockmap"), and support unix in 94531cfcbe79 ("af_unix: Add
> > > unix_stream_proto for sockmap").
> > > 
> > > If the above is correct, I find that using inet_test_bit(IS_ICSK, sk)
> > > instead of sk_is_inet will be more accurate.
> > 
> > Thanks for the context, makes sense. And consolidating this sk_is_inet
> > check inside tls_get_ctx is worse because it gets called outside of
> > sockmap?
> 
> Yes, tls_get_ctx is invoked in multiple locations, and I want to only
> fix sockmap related calls.

Sounds convincing. Unless John/Jakub have better suggestions:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

