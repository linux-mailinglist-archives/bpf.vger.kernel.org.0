Return-Path: <bpf+bounces-39122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A456096F3E2
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8601F22FCC
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8815D1CC882;
	Fri,  6 Sep 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brcktI3L"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF61CBEA6
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623963; cv=none; b=FrYRct5LBDS8CdjZkBi9mCiDpF5mwPGsZow0HEBoBZUQaiSWxNQ5He74cM1uPMrEwgMtuLqqB2DbtTjgYolbjLu7QUbI0MKIICsHUGArE9zKYR5NCTwKqUz72j8kG8mWcZpZco6Q4OgIVUMH18khL6NX+hw0WNY8hGkAKT8Pcd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623963; c=relaxed/simple;
	bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM3jgEbUpCNCPGnikGbNFckNrmpXDJq9+Bxn77t9aoBFlEmp92YYloJZzB7ZefHn+JhNHPC7llIXw7KXc9NLniKBmbWEk0vqQLlhpxcXWMdVBLS2/4alwqiG12JFadQyKEjaQ9ohEmuZjoE+8s4EH6BC6rb1qPADrhAQHbsvo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brcktI3L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725623960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
	b=brcktI3L/v+0qOMPUvqNHUXIzdLyDy/NxqPUhjyObczPAbNxhbyRIclRDW57WBfD64rI35
	fnuoIxh95pwkApZBK9vNoceHfpGF3AoIb4O4REz6ga6/SdOGC8BjOjkF3N+RrGeTfSaTod
	1hubBoqxghfmv8vzV8VXUjADdrJgAQs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-qQH3tns9My6Yjra2-uys1w-1; Fri, 06 Sep 2024 07:59:19 -0400
X-MC-Unique: qQH3tns9My6Yjra2-uys1w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42c827c4d3aso15598825e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 04:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623957; x=1726228757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
        b=Cui89ui+wlAkgpjBv0Qi2xqvhBMbRBS9Crh+4zUquHx76aG6b56H0AAUDK3XBv5De6
         n+gLyZkgJaqkwYn3hlXkpOX8u1nPFIZ+IbOUhjKSJOdZTjtYubwQSp7LC7dQkGLPC1pN
         3KfEBAZ2ZaptZOTl6dojpyw4HFXYAT9Js2kah40DF1vbWTb0bPPTVMAzxtBSXhaiAJ1D
         dYln+UiBjqQwGqLI3VhosWcNPGaDtmPuTHJeJGa99f0J3+3eFQPjU3j3NK2zLipPMza/
         hEKvmybiEo4/HvQBCvrfaaWXrdlVgDaZgkS+sqQ2p0DJYwrIJAQziHHkwL2ANcME70yt
         CIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJq3Zo+kn3vkF3wFto2x73/1TMvrjrmRbAzeE1uIbxaFxD4am5PrdpVQ3QWj/vIpHopv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCriuPAw2R9razL11jev71gl+UT6/RB05egvkEJKNA2Dt238KI
	XOvVp4UGrLTUOFfQh6pFsHiX47PbEJUGyJ1iWZVKmn0CEkfk3Q+gTieqkV2RfBYXBemDxMuwD6Y
	snZtFLFaRfOh8zSBriagBg4+RK5Pb8xehskHi5E4RMwNxV5FYng==
X-Received: by 2002:a05:600c:3c88:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42c9f9e0d14mr18589775e9.29.1725623957340;
        Fri, 06 Sep 2024 04:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYA3WJyXIhIIDEVufGNxXIOM6KJ1IZ7nsonG5drAh9teOtbcCOcgYplQPKS/qfufalrdR4OA==
X-Received: by 2002:a05:600c:3c88:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42c9f9e0d14mr18589465e9.29.1725623956763;
        Fri, 06 Sep 2024 04:59:16 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d351bsm18481815e9.30.2024.09.06.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:59:16 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:59:14 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] netfilter: nf_dup4: Unmask upper DSCP
 bits in nf_dup_ipv4_route()
Message-ID: <ZtruknlefVpreVRQ@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-11-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-11-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:38PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


