Return-Path: <bpf+bounces-37729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045BB95A0DF
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374F61C21DB1
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8EA13049E;
	Wed, 21 Aug 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPQ/8Lxs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCDF2AD31
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252716; cv=none; b=Gek8Holl1g48DzzQK1JXm3Rqfu5Bs8ofEpLwxdhNzu4449T28V9aFaMMebaQuj0IUUYgk63j2t369VgIrIuxLZfmVWPH8+gTUqAJBO/YNWbYOHm7gYwoPDzx54eRM/NWYmSMFHjlj0JT8jGDDuem+6vdU2QTGi4snxu5sk/euKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252716; c=relaxed/simple;
	bh=ZV76DnlRgRuVCMPNFKzemZfCcklx29bWsEEtGUWse5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCR+i78bRsh1kxJ0BcUhH4VMgSumICgpI7YyPANjBN2yuLeKLI3xmwGLfWtyPxxnbFgrYlT75FU/QqTS+nD/FPPsviH+6RjDIV2eBK9p+IgnSaf+WvMMzT67zNZHYCm3uhMUfk1NIrQTP3RDTRhpC+eAwUijNhC0t+msSBbBE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPQ/8Lxs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724252713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mtPyNhdXIXz4+vJglLOBphOc3sqQoJSYIIHv/Qiktbs=;
	b=jPQ/8Lxslc6DjWAqchNr3vnG+EjgOtm0nuRoQTgC+m0hLJEdd0ljxAqVA8ezPLCJvq7fKT
	/zyp3WK6xa5acvKIiFEWHVL1MVg7SvPoaEhexg+gPBemg2Kkg0sezhwRfQv5PU74CRh7OL
	dTA8m9urjpKGwUsYNx9yrJKiYI7sWRw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-hNBKlCTnOrCTBeibzsSBkg-1; Wed, 21 Aug 2024 11:05:12 -0400
X-MC-Unique: hNBKlCTnOrCTBeibzsSBkg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52efd58cc5dso6877330e87.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 08:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252711; x=1724857511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtPyNhdXIXz4+vJglLOBphOc3sqQoJSYIIHv/Qiktbs=;
        b=Fp+Ubptdoau4NpgiVjSJ/v2PmUqkqsopzrn7+L/qfWoVnGCosPLODH+iWxprN2SeO+
         YjhUJg1VeGbuGc7nv+6Zn3kQcGeM56cRleXHqFfHTOXO6tvr0xJeJo9zt2f9Qmke2deI
         tEjeabF40L25PXqDYH8ixwISYG5mGz/wrBQe5E7rKtqEA+dGD5W5bxtLUK8rhUCeNUAM
         GYo5SJgAhAeA0UVg+3vq889PYStSZvbRGd8C4uLEGQ5dyq7kc8dnaOOngCcFqWoh0ln8
         s4o9ETkSMi557WosCBqt3r8OSbTaNRpOtF2a9x3zuOQolJknFa7YprXUrNgHS4Fpj2Wi
         Karg==
X-Forwarded-Encrypted: i=1; AJvYcCVI5BnoEDkgxp4QjZ+7n6rMwtvkQ4y0NsMtBgCp6qQyfiJKwBwn8NZghqdIS4l5sBWQYa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8LR41hbloTkHL2q79/ksPk1cwWFfY6bU7S/qOmEHrnin6xp3
	9ZqxsDpptjNNpD9nlolMMuZN1tHCkH1aIVpJiqpPsG6Jr7AO10aDr1BJO0A7g8U9S3SPVFwttsw
	/dnzCvcQI2BB0P0z8+utVIWATlNCzqbLD/tM4iHrClKHn+DOE1w==
X-Received: by 2002:a05:6512:3da8:b0:52c:cc2e:1c45 with SMTP id 2adb3069b0e04-53348550ff0mr1593652e87.15.1724252710966;
        Wed, 21 Aug 2024 08:05:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6O4yAiGQzDHr19kMW1ONwMm7G4w+8mhSrKkiGWmZtlL6oFvJTyJGuNvSyfSkYEw1bs9fvxw==
X-Received: by 2002:a05:6512:3da8:b0:52c:cc2e:1c45 with SMTP id 2adb3069b0e04-53348550ff0mr1593598e87.15.1724252709931;
        Wed, 21 Aug 2024 08:05:09 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed912c2sm28426245e9.5.2024.08.21.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:05:09 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:05:07 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 06/12] ipv4: ipmr: Unmask upper DSCP bits in
 ipmr_rt_fib_lookup()
Message-ID: <ZsYCIwtVxvRhzJs/@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-7-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:45PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ipmr_fib_lookup() so that in the
> future it could perform the FIB lookup according to the full DSCP value.
> 
> Note that ipmr_fib_lookup() performs a FIB rule lookup (returning the
> relevant routing table) and that IPv4 multicast FIB rules do not support
> matching on TOS / DSCP. However, it is still worth unmasking the upper
> DSCP bits in case support for DSCP matching is ever added.

Indeed,

Reviewed-by: Guillaume Nault <gnault@redhat.com>


