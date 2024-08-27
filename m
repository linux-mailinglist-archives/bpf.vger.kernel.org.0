Return-Path: <bpf+bounces-38167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B9960D60
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 16:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16E4B2486E
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF21C4601;
	Tue, 27 Aug 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DS4OTaxG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658051C0DE7
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768174; cv=none; b=lNBmM1m6JivXsi5YYzp19kjQf+b8KWkdXn5T06QKWAiRROOjUAiW9u7TRTI4C/IAuuAUf13GuScgsgxxN48LS0wlqwXauTdVJrkm8336TvuHck4IJl8VCtCzM6wGHd+j/XhycUxSDVrLHeUi7/DEwdNrRtld/5RBVdp5kpjDfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768174; c=relaxed/simple;
	bh=XXmbb0t7y0c4oZ7Xu9QG0xMGo+5vUrt+cGWNQunXL/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmhwzBUjd0EKZL0uhbGPP7653M6TWqVvIhfa2nT7ZkWAO4+R33WoyjHsduaVeKOYB2OfXXtsyohvsURwjbZjlAETGg5CaUAKrANaKpKghh9WJ36W5lQN/n1ZmdDFRdfPC9JzKd3vjIVlRK61hLO/mv8qp03OzSuxeHsnkUQpVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DS4OTaxG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724768172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XAb/pp4q4FbprZjC7JXIKvxzAlOoqRRApsF46Uml7Y=;
	b=DS4OTaxGUSg3PbCYt77Q0tw7mZ0nSd7lot5DKAoiHSgatMJUdtnbaxsvagF6uslw+q7yMW
	1rgYOzoZWR8BvG/OToe6yRxCm5BdXYFx1JjDj2FvDm442UmJK63vv5pqKYsq9ZH45KkK+w
	gEX39gAze9+XqXpLICtOO2pfHxJKjKA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-v2PZo_STNEOGgE4zKAC2mw-1; Tue, 27 Aug 2024 10:16:10 -0400
X-MC-Unique: v2PZo_STNEOGgE4zKAC2mw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3718baf35e0so3062400f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 07:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768170; x=1725372970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XAb/pp4q4FbprZjC7JXIKvxzAlOoqRRApsF46Uml7Y=;
        b=efoFPkepgkoYZWrH3K3cNl0lShk44IovpI+h3yEhpT2DESx9ZGVdLHxnTDSqVn5rgr
         jgFcRIEuuHprG7zR+80be1Ye6zBdvRtpAp0q5H9n59wUTZgRDEv9u54ytwFQ6fFABuaz
         2g7OVhyhhzP56o2+w+pL+TRiM17iWeKLEZAd8GmkJYGZpmYkb6CavN9e8fApOZWzMP62
         nIinGLDHX41FMBuiSnVtaE2Ppi9bmIe8Kfy4yswq4nnSVUUGUjSLUtlor7GA6vCZ/Rd3
         IJNy136NfMfzxScGFwsFwy0GpSCJ6RfJZSdMbjl46RTXEord9mfYowtd+DX577DM54uf
         eHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoULxOk6EMmrEruGqpHDrKTlZkrzZIyYd15Sfm9KW+RyET8VFYTt/6yMgVZpdvwiJYyIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/vuNcch3HLsO8V6XvrJIqtrjJ9/D1+PLlQx1xLcS4B2S0NSru
	0wuAR6/JCe73KklSZM9vANSa+8VjhDBgrV84BFfrk6UEyPSp/moBkvwA6LPDuKUQCI3HqQxmN0L
	Bl93Jlz3UPorAdP3fUxcSR6R+BrD/QEzw1GpmqVuq0vXPbh03kA==
X-Received: by 2002:adf:e244:0:b0:367:8876:68e6 with SMTP id ffacd0b85a97d-373118d099dmr7827767f8f.48.1724768169702;
        Tue, 27 Aug 2024 07:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFzL0sCktsHBR3BS7aVVD4sDlVTgMk+MinAaNmqlsQPaLUyr+x5t75wMdmr6hJy9S+FYgU/g==
X-Received: by 2002:adf:e244:0:b0:367:8876:68e6 with SMTP id ffacd0b85a97d-373118d099dmr7827733f8f.48.1724768168935;
        Tue, 27 Aug 2024 07:16:08 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37307c0c9c7sm13389909f8f.0.2024.08.27.07.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:16:08 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:16:06 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/12] ipv4: icmp: Unmask upper DSCP bits in
 icmp_route_lookup()
Message-ID: <Zs3fpuuLDo7vPBQq@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-4-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:04PM +0300, Ido Schimmel wrote:
> The function is called to resolve a route for an ICMP message that is
> sent in response to a situation. Based on the type of the generated ICMP
> message, the function is either passed the DS field of the packet that
> generated the ICMP message or a DS field that is derived from it.
> 
> Unmask the upper DSCP bits before resolving and output route via
> ip_route_output_key_hash() so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


