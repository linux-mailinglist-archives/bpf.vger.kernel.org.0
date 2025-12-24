Return-Path: <bpf+bounces-77396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC6ECDB1CA
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 02:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48872303059E
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 01:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3012853E9;
	Wed, 24 Dec 2025 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHNPeR1f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOyPIJtj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A8225A3D
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540880; cv=none; b=usZ93ztiORYbhWgIdo79HcGLr7Cietd0Ikv6vtUjtcW+AJMIEDglJDW5nTr65Kx3mJzkhaL4KwWh/UzLDa5MDA/23CcqHHbCq8WXyy/sQkDl39QApx/RP+gzLVZEYtqG/ekewJKvOjHs931jQGsOm7T5sQ2E0wNGtUrsIRQspn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540880; c=relaxed/simple;
	bh=rlBORRVqCuCCDKKTRMpReJJ+tKBroym5f9pOqNZrTI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0hjIDkvH27gYhRVYGMmmpphErveakid41NMXD1VArT9x0jTURpvLukwi3iflxa39BQy8AsbfVajcrh4iQzBiwwkKb+nXD9xiEIc7MyGthNkKItRX4FWIgjaT+lJLbc4ciq5oyd97iXqu3Z/LgsyABjvdCfseI3kn+DAPbsGJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHNPeR1f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOyPIJtj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766540877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfLuOi85d1FraY7+0q787i/gVvs6BEvd92Xlu3j3K0Q=;
	b=bHNPeR1f296Ak5MkB/ES6sgm4BTQZnF6lSl8cQSLEy+hUmnhfhmPb8bWmYftFjKMPoipr4
	j468vAAbvP5yuLHdIp8jiMrMdS2b8ddyl8pQm+2XrcUMMT7qyzf+lcQBgNawadyt9t+fPk
	NZl8c/Fw3n8OLIImRR3CPbfv3A/ryJ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-FtJBnyneM62CAGap4_ml4Q-1; Tue, 23 Dec 2025 20:47:56 -0500
X-MC-Unique: FtJBnyneM62CAGap4_ml4Q-1
X-Mimecast-MFC-AGG-ID: FtJBnyneM62CAGap4_ml4Q_1766540875
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f433419aso5341342f8f.0
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 17:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766540875; x=1767145675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EfLuOi85d1FraY7+0q787i/gVvs6BEvd92Xlu3j3K0Q=;
        b=bOyPIJtjHQrXBSMYwqGZgR3N5yIKaTh+qSdhPNKF5FMgpymdc854lHm7HNoUY8Fni/
         dt79Yg/vt3DxoEfgCA/VHrubKzUL6Dv0VDfPvwZnPQF35W4DhyxxaC2xDT2/fkwzg9HL
         vH7+sIILWX6RvBQ9q6KHt2fWzZO8kGy6ueuderXEyjYVE6YGpZAdjnC+8wzt9mtgJryv
         JGax1cT/V0e/RGiezEz5oOqmS+GhrRzfH7cgnP06txF45spneLGkG2aFcnQYs0qxR0XD
         oNxJFBPjipMN0D7tor4vbvhyaUbI3z2gf8nfUuAy1ghAP8oCBHUj5GbCScTA+Pt6o76K
         rOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766540875; x=1767145675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfLuOi85d1FraY7+0q787i/gVvs6BEvd92Xlu3j3K0Q=;
        b=Zf34Db0OJSbk/TuXgLbLdqn/RjlaD3HU8a867XY2nBmgSg3YVZ+Wg64vIwAQH3dLCB
         cUdehMy8N+g08K8nwsK3+DNt7trbxYx7iWGNFRmzRhywrgwShHD8eF4vESx5vuvhFVoJ
         WTSBMBHV2i1dZi8tesCi2A5Ywn2O440XnyaCOiFNaizGBG97/n/jzXsYhZ7VrlGDeUNW
         Tn69+PwAG3UO6y91+gyCWzOvPb42qSHSm01y7timJ4BPZ2fRjNmr3yUm8I1L68d0/YhS
         wd0h8Dj8pZphnXBvCZoHTodibA/v5SSkPY9cSz/vM5igtsKJq83yB6weStB8CTVE5RWm
         B1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWZsIzFYmiu07j/WkqvkL8THBSTmvV4nE56uHN2BNwZDFJiEcx1z4WUm1/5LHwVxRWGAEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycGiEpy7xsh/1ePPVPwyLLJH1aCwBSiR2aUG4tFj3/a47TNVTe
	ygq7Q4KNE/jXjm+16SSY8u/JtpmMRZX/sUrlfyIu0KELhuqK3MnKCz9DwOWXHOswhK3NQ/uMBcb
	c+XTFWVe/Wxl0M5gtZqqWn4zcWLn/upmLgTupxJZudyXHZszp/xdbFQ==
X-Gm-Gg: AY/fxX6eSkqjecKbooqLNcfhGQhoT3g/d2CNuyY8UkBTkVu4kTtXvkEF5UXKGTZ9OBe
	PP7DK7ksppxC5mh1s38L0fYTh8weqicz7WJ/OjjWgrlldEOhWye3N0YGKs3PQYMOv8kSXzvoJ5d
	cDpay6T6r6kAwXqOpwvfZSG5cG8fs2vsh83+WP66CVrDFMX5AYEERuncSg9BXZuTdo8M93E4xfT
	AC0wsVrQkjCqrUJNosA+MGYBFC/MDR+gGfnt3mUWqi5sqJOvVAMtK98KaRlzRFnna66iitEb2kw
	uQdXt/Ssb6k3OTT4uNRnjWMrAjbxZiHaKE/PPPFCL0QJyFfF1eBSY8ZhWLkdkwjg2VifhFhT4Tb
	l
X-Received: by 2002:a05:6000:26c3:b0:42f:b581:c69a with SMTP id ffacd0b85a97d-4324e4c3e13mr17469854f8f.5.1766540875196;
        Tue, 23 Dec 2025 17:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxAidHJN/0HxTdnoimsgwBvjgcKtPCXXltUV2xjreKTHHI6FxPbiJNRx2xvom7ebYh/UDBIw==
X-Received: by 2002:a05:6000:26c3:b0:42f:b581:c69a with SMTP id ffacd0b85a97d-4324e4c3e13mr17469842f8f.5.1766540874789;
        Tue, 23 Dec 2025 17:47:54 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea8311fsm31060662f8f.28.2025.12.23.17.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:47:54 -0800 (PST)
Date: Tue, 23 Dec 2025 20:47:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251223204555-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>

On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> 
> Hi Jason,
> 
> I'm wondering why we even need this refill work. Why not simply let NAPI retry
> the refill on its next run if the refill fails? That would seem much simpler.
> This refill work complicates maintenance and often introduces a lot of
> concurrency issues and races.
> 
> Thanks.

refill work can refill from GFP_KERNEL, napi only from ATOMIC.

And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.

Not saying refill work is a great hack, but that is the reason for it.
-- 
MST


