Return-Path: <bpf+bounces-38165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD740960CBA
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DA6280FF0
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387619DF5F;
	Tue, 27 Aug 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLVNO2En"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8FE1C460F
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767048; cv=none; b=WAGzMmlc/8YsZkqFdya/oJ7E02fpSvqq2F0tjAgjxS3t7PT46jkKu9mir1JnTDFOxu/fidoNPkKYiZTy4Y2WOLOpGSGZIR0u+R2bIt+InyNKbgq1v4dOVBG4uPA0lau45oUZsqG+Q+Gqk9Yx04H2yz1+N8U89C8TAUmnNYBiH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767048; c=relaxed/simple;
	bh=50VGgfJ39Vn095GKRLqCQYnG9dPP7cqRS8ayEwj0x0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1glXwzqwX+JMnkba82hhRlufdxiaeBhuUDpZaDVjT+xH/Bg93yDiFcaOvtx8eW1yz5HgtFY/FAp3k0jU9befkktaksAM7PUiZfjBTYALm5dS35bdDzeIwYf471Ri0NQzZ1Z5b5V5QZwqYu2knDXu97t7D9UxRubgnMGT+nyHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLVNO2En; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724767045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50VGgfJ39Vn095GKRLqCQYnG9dPP7cqRS8ayEwj0x0k=;
	b=bLVNO2Enpb8/X9gFSrfjyYv3zm8P8kNnzkjlTY+lUfyfj//7P61Gwsf27XPyx1h5ZQNC40
	NQNpOShyV3tJJ1gJ0T9JLAEOsiFXGd+1r/K13g9Z/JwS0Uz0gXJc2KRQG7QIooiJS91SJg
	w2oiA4lz241xrVOcV4eZzDFSH0B5xh0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-kwQq4NVpNxSv0Xq-iqUO-A-1; Tue, 27 Aug 2024 09:57:23 -0400
X-MC-Unique: kwQq4NVpNxSv0Xq-iqUO-A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42aa70df35eso60685465e9.2
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 06:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767043; x=1725371843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50VGgfJ39Vn095GKRLqCQYnG9dPP7cqRS8ayEwj0x0k=;
        b=VEpVeZpBvQ8ggRikgCWlnrae9zUUkmkTPT3HMUXUmF3h27Gzzfi+KYJHdFMc4CWZSt
         G90mJuZVPZb/1fhK3H2hMI+sBF1nlbdUYm8VGccOzsHy/f3bx8d7Ju9qDEumlfapGVt3
         COV0aT1sAO3aDNk83V5rDcAXvy/PREZU2D127y0Jr/GC0rRfTvqndxCV6ZdnIdxYBsUM
         P8reQKK6ZMs4jYSUtV5NAFBAh/5N4gh8a0yvY/9Q9yqQXWMFnQeIXohnigV3ieDgs+w+
         hvWPGzrVQCTL/71s6Y2//wMqflQZiseYKJAawoDlUQDL4CCfzDIk6QUBtifbgybdJ9pn
         H34Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/AkL3jDj2ZOQmoEJvGUjuHAU8D7zXh0oHbocCMQOojEgNnvEfkrNFut37TJ3SptgCIsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymtFNPhwrOJHbs/nuVzNB1FslL/S/xqOghmd9WllIYfi0dOWt0
	9l4Wr/DY/kU7HkXBPAMpeKd8ahy/RR7PhIaHtb3AUqZ2bPOV3s7Q7FcgvQCv5CT188YVcLqh3oj
	RbmV6FAY3JIDjKM+mvrvxUQeM0veSHY7VcXTYKsXdhWdEDCtYxg==
X-Received: by 2002:a05:600c:354a:b0:429:d43e:dbc3 with SMTP id 5b1f17b1804b1-42acd5e7513mr114491005e9.34.1724767042676;
        Tue, 27 Aug 2024 06:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxpsjaqSyA5LuzkxA9XJ4emA+wSpbmgWayC6kww92lxBE+u93eN4thaAxJMWp0dXVk3KhlTQ==
X-Received: by 2002:a05:600c:354a:b0:429:d43e:dbc3 with SMTP id 5b1f17b1804b1-42acd5e7513mr114490465e9.34.1724767041926;
        Tue, 27 Aug 2024 06:57:21 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817a5acsm13174367f8f.64.2024.08.27.06.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:57:21 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:57:19 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 02/12] ipv4: Unmask upper DSCP bits in
 ip_route_output_key_hash()
Message-ID: <Zs3bP9fFt1z4RJek@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-3-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:03PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits so that in the future output routes could be
> looked up according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


