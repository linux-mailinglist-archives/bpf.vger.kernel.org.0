Return-Path: <bpf+bounces-39117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF896F2EF
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9B31F2536A
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1ED1CB306;
	Fri,  6 Sep 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZ1MUDLb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582E1CB157
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621799; cv=none; b=tZXrdZdBDIhOtV3Qs7E+mmDltPVn2uwPPNNwRjcvLqPQ4Xzis8nNCwjY60lxW3vSKc+cdGR11157BFyKJOC44h8IDvZ/Fu1zd/DbfiaZLBO4EpwXC9HZCsnh5m1xHv+KaDT/KIew9gvgKM3FD2iSz0ztA7BMEc6UyGfcdONN01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621799; c=relaxed/simple;
	bh=ppjXtJ7gs7W9QUgkDi7uSrA4aZ6/Z9GMvpuugQHfWxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx7FlAn0BwKLhxPoffQhjMsWSa5eK2BroMHlAnF0+eNpUuspCR+fwsoxclfrOWtGDGqax75oLD2UOAsPPD/RQJpAoiQKYk0rVfLvoZivkpRA1PWbE1Mnm4skfRCnOVm2v8Y2f2Q8aV7jt0sM3MCh2mpRFxT5kFP0kBvb3GqOpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZ1MUDLb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppjXtJ7gs7W9QUgkDi7uSrA4aZ6/Z9GMvpuugQHfWxc=;
	b=BZ1MUDLb5f+CKw6+G0w40+dAR+p2e5DyUKhKlMpKA4gtGVOJl2K3hjnAevTsN4M5Eyjiat
	Ohl/ftk7ZU3TVcDCjHkcyaEtjsWiM+MTadTm6W7m4zWm0vlq0nzXwfFww1K9np24KHGGqQ
	uW1NJaW2tc7yw80/anOrUtAY+Lr7258=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-MAG5AdAvOP2Q7ubhvsSfdg-1; Fri, 06 Sep 2024 07:23:15 -0400
X-MC-Unique: MAG5AdAvOP2Q7ubhvsSfdg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb8610792so15479455e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 04:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621795; x=1726226595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppjXtJ7gs7W9QUgkDi7uSrA4aZ6/Z9GMvpuugQHfWxc=;
        b=I/OEjUtYQFxuzSVZjZN1Wi0LCZvcDmclvunpbruRfQTEESnyT7V8KNp2KvDScgpjcV
         4V/rEhuBBP+xrjyKXjn38RZa8M3uE9IsHE22fZiVIwTiRT7QwcZxImdu8zMd2AW+jkNR
         Lo30MuDs64eG1Yd7kpMAeTTYbbOJhZH7qsfgXI8fzrAr9i8T5cH2vChaGN8+Eono3aIc
         72q5hVVfF81xjULlUA7y1DquqnvOxTa73NoiQduvNfAEOXYgzqSs5tQqHKMLFOwE7tcv
         q3VwTK/FpPh8P0KmTpdLnwNcaxewQg5ATlTCiU1jdUAJRwcb2+beMRiue84SJOiajS4E
         fUPg==
X-Forwarded-Encrypted: i=1; AJvYcCUTwupUkYH06IGeCbiLVuDb7RTRVl/ql1TYDANpHPSl5/SZWxk3ICfan0Sb1QFe6GUnsDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIwZ/oHxhMlPHbqaM+eMNRJ80B8dR73276t9EWHNbDggCuhyH
	+TRMpmia87cjaV+n7VtV2AfFepTOujjjP3PkguPw6/7vxv9oCRXyeueLv68ngKJ6TiJxihkgDnS
	MT3JTb755w5QaIGhTfZ5ieIGdnra1kjeo4ANToATD++oB3vchlA==
X-Received: by 2002:a05:600c:1914:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-42bb27a9eedmr205061655e9.29.1725621794773;
        Fri, 06 Sep 2024 04:23:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDWt5S+yLwjHr+CBf53VWDHiFksVfZtQBazKOXS3AJWWvyxr4Lz9xJ3DkOyXs6TcqBtg77Kw==
X-Received: by 2002:a05:600c:1914:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-42bb27a9eedmr205061375e9.29.1725621794156;
        Fri, 06 Sep 2024 04:23:14 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05f847fsm17687305e9.41.2024.09.06.04.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:23:12 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:23:10 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 04/12] ipv4: icmp: Unmask upper DSCP bits in
 icmp_reply()
Message-ID: <ZtrmHrAC40k4hpxe@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-5-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-5-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:32PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


