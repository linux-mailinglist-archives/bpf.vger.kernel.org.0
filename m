Return-Path: <bpf+bounces-37735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB57195A2D3
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BA3B244EA
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA791531EA;
	Wed, 21 Aug 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abCL3cR+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0B52F6F
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257837; cv=none; b=D6OHm5eSlWlCQJ5xYlRi5Jdk+kLj64JxVcyC6aGx8ptYI/9IsvAX3+mngZI9tjJkNiD16uqCgWhnHFxE+HO45glp+pZ9ugjFqDTSkf77H1UJ4YbLxNXjHjfbtLJ5bYyXhIzjw/Mt55K+1MVki5C4sMEDxig0KQ3ghdIZ3IAgazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257837; c=relaxed/simple;
	bh=eh2CaO7SLxneqTXJ0tkAYdS7T534jswugaRRjc4wKyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc5tduD2xCHy30B8F0uRddwmrnH98jckFqTukY5mdj46T1Dqt9KYKy8n6vfUt8sZwWtuImum9rtH6XtoHbgdAfd3c298C2SlpwyafLXTcbgIVsLR2l6Izd5y0eeAxObd5FBHFJO0mowNmcFGq8OQJ+pJ2yWhrsQxZwENBG8WkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abCL3cR+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724257834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh2CaO7SLxneqTXJ0tkAYdS7T534jswugaRRjc4wKyU=;
	b=abCL3cR+6H/U8/nScNj6+ik+qEc9mBFkC6fMMDuX0NX0pl2qxoNmEmob5tqQukb2bXy/vu
	9TDzdMw/kuUgwpjCjX6egjXkLxxCXUpHtlJopfqaWD8vgS5wxo2LKpNKrEKbjQsJYZ/9mH
	O7eeBm4FJzxrBpVYvPz/9rHyroiF1s8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-mohTDApeP-mqZUHmXzxm8w-1; Wed, 21 Aug 2024 12:30:33 -0400
X-MC-Unique: mohTDApeP-mqZUHmXzxm8w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3717ddcae71so3661622f8f.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 09:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257832; x=1724862632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh2CaO7SLxneqTXJ0tkAYdS7T534jswugaRRjc4wKyU=;
        b=fjS8kdoKM2mJbPsAjP1ZTsmV7Ika/7xxs9DR2qYwyyLBRe0X4WlLyXewgdaIzkN9aK
         4lAyZglTL4iENpQ/bDw+dc62b/e0lSRC6g/ciYe1alpI4/az68+n9AF1pMmIHPRJh5WQ
         qjJtoCPZSWeCdXAJC+Yu7XxWvUycxOV2M4lGKvDYAzZwGv/uWZDQYzkk/knnTmF747Sw
         rOGvCcSlbLb0qya+KwLG8hApn1TYS3/dVGAiDS2EFmC4H1aBngV18Dnwe4Lb5CcsuS9a
         f0hRRFZhHCsEJk4OkDBZx1xM3PUu2+FLutxPy/5yllbJAMbmeI5QeCIUupEfCr7dB3Tk
         eF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxZvZYcT2g9KbKP3wqX2PlJyUB/3WMgQCm1LmC3FFn0ORRhN2p7K5jN2eyrZ++1UopWqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUe+4HOnEWEAOfX+sz7FD3gRBoMwhyb50PX5ELB8Z8/6i1YtEI
	KRrbptyp7AXwO7SWtmVRUHZmxDbkn2AZ2tI1gkPBdhUEFk1HmZPFrL7XC7kv2oxq4G6me5OXORQ
	6pO/PSfhcd+l7l1sNRdDT77nHW6FIzZFuTKUz6U0wns6QynGoJw==
X-Received: by 2002:a5d:4608:0:b0:368:71bc:2b0c with SMTP id ffacd0b85a97d-372fd5bbe67mr1762298f8f.10.1724257832016;
        Wed, 21 Aug 2024 09:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFHiwWQuwcb9FY723vZUjnvJiZ+wXV01CzfS27CAuf6/lQRnbvysDeH7IR7ggmior2kIS68w==
X-Received: by 2002:a5d:4608:0:b0:368:71bc:2b0c with SMTP id ffacd0b85a97d-372fd5bbe67mr1762272f8f.10.1724257831193;
        Wed, 21 Aug 2024 09:30:31 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aab44sm16105552f8f.91.2024.08.21.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:30:30 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:30:28 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 09/12] ipv4: Unmask upper DSCP bits in
 RTM_GETROUTE input route lookup
Message-ID: <ZsYWJE7iTXu4jbN/@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-10-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-10-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:48PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when looking up an input route via the
> RTM_GETROUTE netlink message so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


