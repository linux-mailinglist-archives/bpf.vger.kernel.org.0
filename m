Return-Path: <bpf+bounces-39123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B43CB96F3F0
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 14:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD07B235C6
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5371CC888;
	Fri,  6 Sep 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCbbTZ4Y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5791CBE99
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624183; cv=none; b=XUfvv3d2CzcGhO8X2Fl5v9nDb09FZHn+9PonPZlZeRDkA5CwxaD5ux/ZTry1gdnc/VGnrEFNoU7kmc4+cxu82Q0MFqZ+d533psgOonxba+o0QabaJMaoeOtZbfQLitJU+vpI5HzV18xp8A4tZ2IV19Nx5CRKFH1R8+xqfJ5B384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624183; c=relaxed/simple;
	bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEL1G5gDeP05xlCuXvQuj0waOPWhO5TXt8JL+NqaOF2fGFtA8K1wcC0VzR47BYv03nfrvO6zTh7gtFfyoI9FsUKart1G52h9iRM4m9Chh4AZz1lRwv0BlZs8mHKv6NcjNyYXp/o+5bXhL9yBTB4aNqNWI7DPiGG+yBPY2yTBm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCbbTZ4Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725624180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
	b=cCbbTZ4Ypxqo5mGp+SjgEHdXAov3on4FYCa67PLCOq8NNDQLZYEPWrYjWOrtaIiP4VvtZy
	CXyRurLUNibPRU8z7erevNXQ1MdGNo9cX/JwF15MpqGtSRxWSEmhvfQGRJaG+riUmx/+D6
	FBKhjmRp7LU/XMAhYd5qn+9uP2VNqVI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ITJNa9qaMHaMc5bJ7BTCkA-1; Fri, 06 Sep 2024 08:02:59 -0400
X-MC-Unique: ITJNa9qaMHaMc5bJ7BTCkA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bbd062ac1so15994115e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 05:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725624178; x=1726228978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
        b=g8hsh1iICkg2SIt+Qyu80vjWqysRpdbhkXEprLJ2TttS/RZqjp0GajWHz4//vmtSvs
         YM3fkJG2mgLnVO1fBXBCIaeUgoDJcPVtZl70ci63G+eNNysU0Y5KWRs/doGQO930e6h8
         nekeNUzbHz3zIxepjk+xwPQEenxeNiA4fyVSfgQ9o2bdh2lgds9jRZpVMje/aDS33r3A
         nU/Squh3T0gTWTB8iYAYzu4Ry+7up7GJGsFb1zgOc/n+xe6DMW95FcnUmZ3fS9GcAWeN
         JhUo4+rvzW9vQiC9b1B0+p5IWLQRzkyVWYn+uly5BjZ25O22n5wkSHH1OUlInZswgOpv
         GXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDkwwmJlVWY7NyUrvHyyf+zVTbYIv+dmr7X6i7ShLOGDx/NZJ2DFyPdCLFs55IwrUrmBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM6rO13r5MxSKWjQTr0mjq4dE3f83/pM1rLlOrqQORIJWoY5kz
	amcU15LfWGJ+5afkXC78QPhOGkoTQiZVlDzmDDA5njrKJC0MhxDbzzatXitRXoup2x372mZjqhG
	cwHjNHX0CSfnOTNaHKdPm/pJYuJdb2hi83IStdNJH5h/uG+NTYA==
X-Received: by 2002:a05:600c:4e8c:b0:426:6921:e3e5 with SMTP id 5b1f17b1804b1-42c9f9d6a97mr14855375e9.24.1725624177993;
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoI0DxPX/u6R3aYPAJ18qh/X+91B4iTbd+r7c0r2GHaqUyL4q8mSemuf8LpPqF1l3DBpiAhg==
X-Received: by 2002:a05:600c:4e8c:b0:426:6921:e3e5 with SMTP id 5b1f17b1804b1-42c9f9d6a97mr14855095e9.24.1725624177430;
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3788dea8eabsm1004604f8f.114.2024.09.06.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:02:55 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] ipv4: udp_tunnel: Unmask upper DSCP bits
 in udp_tunnel_dst_lookup()
Message-ID: <Ztrvbx3qzXI2VCN8@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-12-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-12-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:39PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


