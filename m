Return-Path: <bpf+bounces-38171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1468E960E05
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A8B2856F2
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D3E1C6899;
	Tue, 27 Aug 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmmOJ+ew"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11419EEA2
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769843; cv=none; b=u2LWIfxAqcdrHHJsAMEzuIYQCEAda+GSqMtCxWElnR5xOF2qUKOLAprfmNZYIHCm/lvjNioPIYs4sHZ6lKrpfzfrKY1Ji/pqQKigluBJoOZ4Cz3TkglKlXWhdP1eYb6/H2M3areaMBgEEmpZYScIWqz8zypN0cJN9ftOkzZF0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769843; c=relaxed/simple;
	bh=oM2brBtGt+OphQ+ukuvC5IAHcPMIa5JteDm7eIPlEsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcvPzM+xdDGINySRaHlCIteogwrfZAfL68+c8m6Wp+Uv1uRR7Izva0ZQhr7C3DQdPe9MBN/aRz9WbZ7dWORfWEKHRO5QGP5G5rfGyQk/l9qqCO13J2CXADY+Y9Cv5iNhiQS8Zo6ySoqjd865LT5hg4aC8Hh9BGR0ElYGx6DRK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmmOJ+ew; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724769840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJBAd+Vbv/uzFpiXGoe8X70Z6GCJY3PwLwfnLtqWRa4=;
	b=hmmOJ+ew0q5qg1SUPlpDA8AtdgDgnFKQ0k0Fg66atDu2houURh2a6U1pHcfRxUBZ5ur9WR
	/OdiLdxNSvc56y9iAMQSXwT3a8OKnQTfemFyoXNSA3CXK8e83UCV3TErm+CuGDQwivievn
	D8w3QD/+lEdxWnLY3hPzDFBkfwanA7I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-XFjlRPYPNBSz1xUTK-1yrg-1; Tue, 27 Aug 2024 10:43:58 -0400
X-MC-Unique: XFjlRPYPNBSz1xUTK-1yrg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42808efc688so49322615e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 07:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769837; x=1725374637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJBAd+Vbv/uzFpiXGoe8X70Z6GCJY3PwLwfnLtqWRa4=;
        b=LGhaAKnbDkkHMbqM5anVwWkhtbUEIS3cfHb/SLvFBIGJnXMnUC9p3NBcaBO2MXh3uX
         bt3FTOpbUGhczCGnINCd/x9S4Wg2RB92mI+fudr2lxuQhxeIT972CMC+kcBj9gh4OfL/
         SHqwRx1JsreDDYZKOMFAM4Yx6ttIo/5NUDnVzD65IRqCg0mDRD77nuZ1bsI6fVPwWkry
         ALB+lZLEmPoaJJzUagi0sSSdTejeTT2MOy0+7iH391ogKGJ/6Z+VzrowTv/iwdmUpzrV
         n+YDET/iFxLcZ0/twWC0r1v5lZbEI8R/VzUWjCt8wor3gN+4VjtHQIId9cv6qc2UJv6+
         bmKA==
X-Forwarded-Encrypted: i=1; AJvYcCXT5mYpbu6MMWP+K9pmQ6WO/7ZeP5HUXprgwbb12oRxw14IpPW3+LdP9RzG5LU2ggUZZk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CvxUc+E6I5Ck+rRhha5L/J1uDmdCsneq9PXu7mf08z0BZvts
	QgA5JtjHnNZgnKl9l5K55F/P4e9vO8GsQe8dLl4wx2g0quEYDi1Jwd3i12uYw29rK8es1pcotwm
	aiGHjysdnkqMRIG/oTzHZT4PwoVy6UKcF5wAco0IOXW7nlpybqw==
X-Received: by 2002:a05:6000:b88:b0:371:8af5:473d with SMTP id ffacd0b85a97d-37311840cb5mr8212462f8f.12.1724769836862;
        Tue, 27 Aug 2024 07:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVRRVuCCRt+5gQlt7iq7J/T6VTyjoxl5THgBfg7ATi95knELtLhdYqaWbZyCGmR1TU7wFeiA==
X-Received: by 2002:a05:6000:b88:b0:371:8af5:473d with SMTP id ffacd0b85a97d-37311840cb5mr8212432f8f.12.1724769836185;
        Tue, 27 Aug 2024 07:43:56 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514de6fsm192830515e9.9.2024.08.27.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:43:55 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:43:53 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] ipv4: Unmask upper DSCP bits in
 get_rttos()
Message-ID: <Zs3mKW5twrchCk4g@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-6-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:06PM +0300, Ido Schimmel wrote:
> The function is used by a few socket types to retrieve the TOS value
> with which to perform the FIB lookup for packets sent through the socket
> (flowi4_tos). If a DS field was passed using the IP_TOS control message,
> then it is used. Otherwise the one specified via the IP_TOS socket
> option.
> 
> Unmask the upper DSCP bits so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


