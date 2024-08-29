Return-Path: <bpf+bounces-38390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCAF964301
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 13:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC98428417B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37F1922D0;
	Thu, 29 Aug 2024 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmTTTECi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20A1922DF
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931066; cv=none; b=A51HDENYE7ZZVWC7toIjp0uEsE2NQsdFlyyIYSwxrLfluyyRh6PfSlsqzRCStNyqMQmUS0rKX09J1EPC6tAtMQbd1pBCP7ws528IxT+U5uqKlHfSJpXrio/x8d86GmgAe3S0vq7fO4f+fqxfY7ixbNFtXJYeAa/QnGeS8S5wkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931066; c=relaxed/simple;
	bh=eOZwUW7bVg4MTUT97X3TewcSmnaCDNxiPVMHc6d3AGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhEVNNXTIdi5mf9Jf0ZAPHVOkDH0l+8mhTEn7GgZA4ltURPzBxuQGy2EewjVDhXaYR0E9E2qBG49F8LOCepB8EpFYgcXu8EKc4wDSpcdSdHMoAZTMeq65SfqqKp8rkhNE2FnK14WmvQUU2WimucCJH0XrzGNZqLWU9yFOqtTSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmTTTECi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724931064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuutfVkQalVR3gb1Y/tF8qqD58gp2KUX9Q94SB95tKo=;
	b=XmTTTECifHu/y3Q2A2JWv626h27zk/Sdn0EtXS2+/XFqZx+uTR2Uu1Y4ywHUnutA+Wj1Ex
	kKOaIdAhH7d06dCb5/LXwt/6U8YDhqSkHXQX4+MLDgTc5gL+kNuQhD6VtQlLla2gOhMW9C
	jtrJo1nrikNh2qd2Hc4rTM+sCvStPP8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-CCnn83JFPJmFIWKj9zb-Xg-1; Thu, 29 Aug 2024 07:31:02 -0400
X-MC-Unique: CCnn83JFPJmFIWKj9zb-Xg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4281d0d1c57so8538515e9.1
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 04:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931061; x=1725535861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuutfVkQalVR3gb1Y/tF8qqD58gp2KUX9Q94SB95tKo=;
        b=eG2yGiaaIxkgGWMqoMlIRpO31SYHTvNgGxexFgVsCZJ/km6Ej8IcHIRBEKbN1f1IXA
         7IIzBv+fqZogZYJqQMnd3OXzxla5HazkTlKtzahekPsv5McKFWLG4z6PpbguGRY4IcO1
         1Lo0fsv6ARdr72hQg8jiPlurK0jSlN1qDyV9y0QoTrQlEfEoMYt9DAL8bbkwK1CZx562
         g3M7lg0akgKs6XAo0AkZpmB5Esmyz7q9BkvR8/c0Wr8cosUbZkuUwzR/BgjxqPaPoJjv
         APG7qc2sXUyv7R9Jst49/udPJoE6b8zbQuQcO6PgEQFFKMiQ/DS5YLy6wW8NTFo427Zq
         3aqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbW6HDgT5he7UP7NGkv38qbDdDkcEdUXOHPQkBtt79dgT/EUf2IN0F/I0ibfVr4f5/qZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xKiY7zPceBs9IwajExjWt82hAhAYE18yF/Lw5RfnWDfaczLh
	QiC85JCOGdfLc4eQXAOyhiGrFd+4yFs3sYG8FL4yVBhG8NKM9iB0UcV2xCiO4E/VPED7HNf3DUv
	xf4AG847Me4PwbBISEH9AoCIHT/OeYP86t58j++KdwM3LgBJShQ==
X-Received: by 2002:a05:600c:5025:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-42bb7461abdmr9822575e9.17.1724931061563;
        Thu, 29 Aug 2024 04:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPME53hL82GM8H8LokgUzxp/LSU12f+u9KnvmGUUqGM/HrGuBXBQ+st0DboWPrFJUuEu8yiA==
X-Received: by 2002:a05:600c:5025:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-42bb7461abdmr9821385e9.17.1724931060619;
        Thu, 29 Aug 2024 04:31:00 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4a0afsm1175689f8f.8.2024.08.29.04.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:31:00 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:30:58 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Message-ID: <ZtBb8sl1JnMHZ5az@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <Zs3Y2ehPt3jEABwa@debian>
 <Zs30sZynSw53zQfW@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs30sZynSw53zQfW@shredder.mtl.com>

On Tue, Aug 27, 2024 at 06:45:53PM +0300, Ido Schimmel wrote:
> On Tue, Aug 27, 2024 at 03:47:05PM +0200, Guillaume Nault wrote:
> > On Tue, Aug 27, 2024 at 02:18:01PM +0300, Ido Schimmel wrote:
> > > tl;dr - This patchset continues to unmask the upper DSCP bits in the
> > > IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> > > DSCP. No functional changes are expected. Part 1 was merged in commit
> > > ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> > > 
> > > The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> > > lookup to match against the TOS selector in FIB rules and routes.
> > > 
> > > It is currently impossible for user space to configure FIB rules that
> > > match on the DSCP value as the upper DSCP bits are either masked in the
> > > various call sites that initialize the IPv4 flow key or along the path
> > > to the FIB core.
> > > 
> > > In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> > 
> > Hum, do you plan to add a DSCP selector for IPv6? That shouldn't be
> > necessary as IPv6 already takes all the DSCP bits into account. Also we
> > don't need to keep any compatibility with the legacy TOS interpretation,
> > as it has never been defined nor used in IPv6.
> 
> Yes. I want to add the DSCP selector for both families so that user
> space would not need to use different selectors for different families.
> It's implemented in the patches I previously shared:

Hum, I guess that was a misunderstanding on my side. I read
"adding a DSCP selector to [IPv4 and] IPv6 FIB rules" as "adding the
possibility to match only the 3-bits TOS in fib6_rules". But your
fib6_rule.c patch doesn't modify fib6_rule_match(), so I believe that
what you really meant was just to add the new FRA_DSCP netlink
attribute to IPv6. Am I getting it right?

> https://github.com/idosch/linux/commit/a3289a6838a0d0e6e0a30a61132bdce3d2f71a3c.patch
> https://github.com/idosch/linux/commit/ff5dd634fb278431b58437654d7f65b57fd4ae4b.patch
> https://github.com/idosch/linux/commit/3060ecb534475eadabfa1d419dd64804f0bd0148.patch
> https://github.com/idosch/linux/commit/12ddbce4f519b42477ea1e130b6d2bab1cca137c.patch


> > > need to make sure the entire DSCP value is present in the IPv4 flow key.
> > > This patchset continues to unmask the upper DSCP bits, but this time in
> > > the output route path.
> > 
> 


