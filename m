Return-Path: <bpf+bounces-38174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC08961079
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 17:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60911B22E9A
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD61C57B3;
	Tue, 27 Aug 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWu9QQm6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C41E520
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771353; cv=none; b=Vyoovq6xmLuQjH0yKH2zhbBvbJxy+djTjo7zbZp/xVMRf4jCIx2q2Y+SrHs+F2iGgFzv2vJvIMBHZItrr9Mzw68ne3b6fyPjTagpB8NaRU3gZml62H4XsS0Jk37lRXf7NPfFWiH9PtJO6cMwyOfRdxj/8TBzaiOamF88FdrJLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771353; c=relaxed/simple;
	bh=sbYHocYuDiWoFpMIwmfYHT3Lra5AGZauU1LdBps54Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuBZgyFvS13qLSSA1UoZSlBS0kMiOnitUTNp2MkXHc3APC+XeVet/IIzhUNQ0p+yibdFI3hB5wL8Tn8DZtVkk8zwkabOI3IfWETclmxDF9wtAe3A6ZFonv1Uz6j8T7/2UelMDH6hpzBNa2Yk42i/akF8h6+okI2Njofisvgjx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWu9QQm6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724771350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yg51UQEdNrHqPKausCCH24BO5x8BzlOc9BYF/ReK8EE=;
	b=gWu9QQm6ZSkiatsMhzvUPs49bVeVhdCGjnh7lu/YT7EG64zJSQOAV5img/yNkHopXKgRuk
	dtGNzmGm5sFBvX6hpz288A4dQI+ulVrPTmyVZDulHwUVEAWfotYRcGn/gv+bfcOw1S/fgh
	hTAqC7lO6gmeydodyy5q/srtw8pnMpg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-bUi04C26PgKBe-MsIbsyIA-1; Tue, 27 Aug 2024 11:09:08 -0400
X-MC-Unique: bUi04C26PgKBe-MsIbsyIA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-371845055aaso3270659f8f.3
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 08:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771347; x=1725376147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg51UQEdNrHqPKausCCH24BO5x8BzlOc9BYF/ReK8EE=;
        b=SAM7RbyjXCu3Z8mcLaTDMfyz9lbVOEXHdXNLuSXhymapz+jOgKukLGMUMkNaiX0XJq
         A2ibrEG5JCkBb/luxQpxib3ZgMq2jLBkDmK8w8tlBhCkc9fhSl5Ri2StHr7QpAxy3Xbl
         n33KqjIOZTBGJX4qbSaifbndDcZwEIClU9PEeYNTsriIuSYlxBqFLZZStPYVN2HuSMxK
         daB1BjBmkH8RBSfxBACq1RAu1hnL1w0drsKHfnXHdRnO6XAKGO6SJ4/lCocujQQB6HOX
         vF++wQvu80sbuOPrl8r0PGzvOvFeGucKTH1yLCwtMD7nq3IrnY1n+eYDCVgGRXWrhCNW
         2QZg==
X-Forwarded-Encrypted: i=1; AJvYcCV95sOUHWf5mlHWuAP1UKuoitR+P54QkLx5kd9rurrOcbXQ7sQaAEkifMhchLh0++F+DJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+yfrxx0K+66pFO2wHHzyGAszZ5iv25zIDx52nKS/xZih4dVN7
	guQmhaJGYHrbKKGotNKBkrknpBaV2YqA8VjiIllwpYnbyKYMURldgYbF+TLMFGJ3ZAVO0sXFFy2
	+Xe0JEEruqptN+dHa+cHsAlNNZDv83wASr3rkmebiLA5fKPpiBw==
X-Received: by 2002:a5d:522c:0:b0:366:e7aa:7fa5 with SMTP id ffacd0b85a97d-3731187e538mr9224867f8f.1.1724771347217;
        Tue, 27 Aug 2024 08:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY41EHXwRcF9MYj3dYFX6oAp9OXMv/6nLWdnYYYk5WThZ3Z+GfFjwbuvWSSFeuWlVaykrtqw==
X-Received: by 2002:a5d:522c:0:b0:366:e7aa:7fa5 with SMTP id ffacd0b85a97d-3731187e538mr9224835f8f.1.1724771346333;
        Tue, 27 Aug 2024 08:09:06 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff5d0sm13451519f8f.72.2024.08.27.08.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:09:05 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:09:04 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] ipv4: Unmask upper DSCP bits in
 ip_send_unicast_reply()
Message-ID: <Zs3sEHhFKIyyY9NJ@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-9-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-9-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:09PM +0300, Ido Schimmel wrote:
> The function calls flowi4_init_output() to initialize an IPv4 flow key
> with which it then performs a FIB lookup using ip_route_output_flow().
> 
> 'arg->tos' with which the TOS value in the IPv4 flow key (flowi4_tos) is
> initialized contains the full DS field. Unmask the upper DSCP bits so
> that in the future the FIB lookup could be performed according to the
> full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


