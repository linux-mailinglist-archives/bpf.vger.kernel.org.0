Return-Path: <bpf+bounces-38409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CAD964980
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01892284677
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F071B14F6;
	Thu, 29 Aug 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPryKAdA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513DD18A924
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944220; cv=none; b=awc8Gjg1uzfC9C/LZTLDzRHV4tg0441e0Rs2jgVgP15f/OkL93rd97WxaHNjjFKdZmuJ7yZz4DqmXmfoCKizN2ijqdGxsQmCyMMl/FDhjgnUyblHwG5N8VVCbdoLMxz7hgvwg1YTxg7H4fcZ2weL7SjX27zAkHeknWzunsLrYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944220; c=relaxed/simple;
	bh=n6dwzWYVTL3iDL6YSAs6u/7LDAM66hgfqVG7DKNtsoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jyw/n+C2nRbu7NVJJC/GqK8LwvTaN3yvcU/5+iV+21J13dFKJC/evujqiJuizt/euu1EdBHtWNC13XljKcUvOjlAzPtaKNCM490+RUn7bbRSKvTtPv02rR8hVf2CFpp3+JsYv2wMAHuHpaM898P73cJ5zTGh6OnIe/n7pcUS7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPryKAdA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao+a8Xxh4C4YfbR/QvB4MFXxEO7ry5mYZebysEnEllQ=;
	b=CPryKAdALgUi3PfNiCHg0/brpyVQvPlLL4zDuFqL0L+0KKDrWjy6ioIzt7VLDBKAnxogHk
	xqoadxjpJXXQPpEHOPWfCQukMKZQ359BhbVFleInP0I70Wtz4i1S79SB27GNFhrU5f9tw7
	G4fTwPrhp34kbU5IFNw2Vnd0Swvesg4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-40YJqOIyOR6XMWpqb0fM5g-1; Thu, 29 Aug 2024 11:10:16 -0400
X-MC-Unique: 40YJqOIyOR6XMWpqb0fM5g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4282164fcbcso8042185e9.2
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 08:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944215; x=1725549015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao+a8Xxh4C4YfbR/QvB4MFXxEO7ry5mYZebysEnEllQ=;
        b=V7EKVFm4PhDE017MfGAJ44t04/6n02SqhW2DxJkUs8Ji8ug4d6Bbm47aRLSfcIe+RK
         tvQfVe62AEYJ00dN3oK/sCVKkPc8dbQmdh4QzxrMXoQE5r5q7GRTVT9I4yfbGQc3j2zD
         EQ8vnqRt4qJaGMO+Ewn53ITvlHNgJhTRXKYyLX7X60fX79HC6w2KpezmZfEUMhPwjlMP
         gqnCZGst76E+yH77z4x64GrMTdKH3Gm4649uM7TPGdqBtvECU2L5l61+RkajGM8Wngpa
         lobdEI8q1G6S5oySAEMeVF0IX04S8QiiD0fOzw+2WlHsHWclj21ZeuJXJI0k0VN1Azg0
         k05A==
X-Forwarded-Encrypted: i=1; AJvYcCV82vDGnxuK7Gysab04/QEW/xqqbveuoPMI6tKhchphvhms9N1q4bM5MCK/Zh67sm1AEGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp25hP2/Uen8f2e3KkpfcsCdaETt1u6HKF/AgjwvKQGY2qnPd5
	pIX6ymodHBITleCJLHmMCdST7DeVBTObLK8XZZwTX31S52JYh8Co2KF+Z5vXRDC/ZiCndZ1neIY
	Pu/v40XvqAOgncVs+G1xxtXtw17j+pbEauUNEUKYCmAtFth2AcQ==
X-Received: by 2002:a05:600c:5110:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-42bb01fb87cmr23527695e9.37.1724944215472;
        Thu, 29 Aug 2024 08:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQK15mXlYCsrEnxCrHV0cVlBaBr7pufMo9a8oWHKcRLt/GBpWhVQ8lsJsMKcWU2QqSUcdYZw==
X-Received: by 2002:a05:600c:5110:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-42bb01fb87cmr23526675e9.37.1724944214555;
        Thu, 29 Aug 2024 08:10:14 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df92f1sm20178375e9.25.2024.08.29.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:10:14 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:10:12 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Message-ID: <ZtCPVKTnkvTZVTBQ@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <Zs3Y2ehPt3jEABwa@debian>
 <Zs30sZynSw53zQfW@shredder.mtl.com>
 <Zs8Tb2HXO7b9BbYn@shredder.mtl.com>
 <ZtBhhhBeKj82CkYR@debian>
 <ZtCLFYdbw6rPinwS@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCLFYdbw6rPinwS@shredder.mtl.com>

On Thu, Aug 29, 2024 at 05:52:05PM +0300, Ido Schimmel wrote:
> On Thu, Aug 29, 2024 at 01:54:46PM +0200, Guillaume Nault wrote:
> > On Wed, Aug 28, 2024 at 03:09:19PM +0300, Ido Schimmel wrote:
> > > On Tue, Aug 27, 2024 at 06:45:53PM +0300, Ido Schimmel wrote:
> > > > On Tue, Aug 27, 2024 at 03:47:05PM +0200, Guillaume Nault wrote:
> > > > > On Tue, Aug 27, 2024 at 02:18:01PM +0300, Ido Schimmel wrote:
> > > > > > tl;dr - This patchset continues to unmask the upper DSCP bits in the
> > > > > > IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> > > > > > DSCP. No functional changes are expected. Part 1 was merged in commit
> > > > > > ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> > > > > > 
> > > > > > The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> > > > > > lookup to match against the TOS selector in FIB rules and routes.
> > > > > > 
> > > > > > It is currently impossible for user space to configure FIB rules that
> > > > > > match on the DSCP value as the upper DSCP bits are either masked in the
> > > > > > various call sites that initialize the IPv4 flow key or along the path
> > > > > > to the FIB core.
> > > > > > 
> > > > > > In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> > > > > 
> > > > > Hum, do you plan to add a DSCP selector for IPv6? That shouldn't be
> > > > > necessary as IPv6 already takes all the DSCP bits into account. Also we
> > > > > don't need to keep any compatibility with the legacy TOS interpretation,
> > > > > as it has never been defined nor used in IPv6.
> > > > 
> > > > Yes. I want to add the DSCP selector for both families so that user
> > > > space would not need to use different selectors for different families.
> > > 
> > > Another approach could be to add a mask to the existing tos/dsfield. For
> > > example:
> > > 
> > > # ip -4 rule add dsfield 0x04/0xfc table 100
> > > # ip -6 rule add dsfield 0xf8/0xfc table 100
> > > 
> > > The default IPv4 mask (when user doesn't specify one) would be 0x1c and
> > > the default IPv6 mask would be 0xfc.
> > > 
> > > WDYT?
> > 
> > For internal implementation, I find the mask option elegant (to avoid
> > conditionals). But I don't really like the idea of letting user space
> > provide its own mask. This would let the user create non-standard
> > behaviours, likely by mistake (as nobody seem to ever have requested
> > that flexibility).
> > 
> > I think my favourite approach would be to have the new FRA_DSCP
> > attribute work identically on both IPv4 and IPv6 FIB rules and keep
> > the behaviour of the old "tos" field of struct fib_rule_hdr unchanged.
> > 
> > This "tos" field would still work differently for IPv4 and IPv6, as it
> > always did, but people wanting consistent behaviour could just use
> > FRA_DSCP instead. Also, FRA_DSCP accepts real DSCP values as defined in
> > RFCs, while "tos" requires the 2 bits shift. For all these reasons, I'm
> > tempted to just consider "tos" as a legacy option used only for
> > backward compatibility, while FRA_DSCP would be the "clean" interface.
> > 
> > Is that approach acceptable for you?
> 
> Yes. The patches I shared implement this approach :)

Thanks for confirming. And sorry for the misunderstanding in v1.


