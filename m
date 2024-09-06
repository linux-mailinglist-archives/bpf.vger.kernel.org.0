Return-Path: <bpf+bounces-39140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61B096F632
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 16:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA611F2429D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978541799F;
	Fri,  6 Sep 2024 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSARpZmJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57631EA65
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631472; cv=none; b=q0g4R58h2Vj4Z67DMQD/K9s5C584qr5S7ToxujQiHFMfaC3BHJkCrBndLB7V+gAjd41u9vppV/oPvntFnJk85CuuXc8OXkIGa2QdkV/ezPCSvZPBxz+F4oE6+B9VvGfFtcogdPmp6Gi3//FHDn7SToRkxBbH3LONivYXXsbnYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631472; c=relaxed/simple;
	bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrqknjMelKSuUtsuojh7Fb0BOLyXKsYFQ2mxyafWxhdldb0L/sY11m7L5wwaj8hlDDe7Qo/8jSCQsmIAHbroxX2gl5v8t3Aogsd10b50ionWbfUtef/SygYzYkKXvBi60WUuqRWLLvReZ1IaGxjhVBdHGc0Tz1HUVrzJfaIJmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSARpZmJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725631469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
	b=OSARpZmJh8s/+HgNmTjPYnoSNuGqiX2CkEB5HlJbXnQ/c+v485bwHUKDjp5YXFjjA3huZB
	ciZ7i1N9dAD+H4OSOi24pV5dkzQcqw37JSvxPnVBUCPO/9yzgGKLX1zqwf2TFP4/R85nUw
	5AMZHWkoDb5to5X2cODV7bjLO28C8y8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-c8XSzW21NYO_51Y8rMwXXg-1; Fri, 06 Sep 2024 10:04:28 -0400
X-MC-Unique: c8XSzW21NYO_51Y8rMwXXg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53349795d48so1922286e87.0
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 07:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631467; x=1726236267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
        b=tkiPjIfVl2HOyScRjO8cDhi01P65d1goB1WmZvRH8rFoNiANzmOwMXSiof9Sve4xrF
         OoFrJHa8xdKUa1NBIxJqBqwBafdpcNh1gbOQA62JiDvRZ1yy5ne7S4WgCBNfqRukwoB2
         dfMKJAW+FtvDWgvd/Udtg4PN44ISDevhDkxn/KFNulw+12ubf+I4RWC2Z5lZrqGmRF0i
         HfDKxdfGpUliUFyroIwUBoIYxf1T3mGjfvubNNpjOqXh+TaSAz/4mCg60hV7GSHvoNVS
         P2Dcvt94CLUeaF+UwutdghUWbrKlB2aGHmMPX50BKylNII3yJu5xQutM5chs2hDYgrvG
         PBrA==
X-Forwarded-Encrypted: i=1; AJvYcCUllRytb4la/lQSTVgBsf+qXUUa1skvG/AkK66nU1SZa9S7CjSAPI9P8PSVJ4fuSHHe6d8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys22sVcyYI7WKQR86zz7PsYhcLMx6JW/ZEyZvbtE+TJLuyGBrh
	gKvd4+hbx+Q7vTALSVz0h7SUikG+Rd1O7wYq2eu9kKWngHNwa/ZnOcQMwZkbhU7k/zdOfOMkuyS
	JmZcr+JQ4zyZ9fBBvia7ca899nawobgIv/gos3xQFExyfXfa1pQ==
X-Received: by 2002:a05:6512:224f:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-536587fa8e4mr1676570e87.38.1725631467070;
        Fri, 06 Sep 2024 07:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKQ5/38TKV/Y2UqEsgT1myno6QGvAIBzgZWsQu6maWs8a2tVqrqi7GmjJ3p9IQvBhwQGLDzg==
X-Received: by 2002:a05:6512:224f:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-536587fa8e4mr1676511e87.38.1725631466186;
        Fri, 06 Sep 2024 07:04:26 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05cee8csm21366785e9.21.2024.09.06.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:04:25 -0700 (PDT)
Date: Fri, 6 Sep 2024 16:04:23 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 07/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_tunnel_xmit()
Message-ID: <ZtsL5+/aztO2HBuR@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-8-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-8-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:35PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


