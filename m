Return-Path: <bpf+bounces-43724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE89B908B
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 12:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D83282429
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E2A19B5AC;
	Fri,  1 Nov 2024 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWyn/klj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7215852E
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461604; cv=none; b=MtN3rtmyTncv8fEgGEMSiRyj29aI9NdtaVTncedCiTigFlBuzZRfCICA6Itu1m1myHV3LzcTgrDbo1ExHVLUtJIKRs3VEUxDPZPq/tFIkcBQvop2NM4W1h4bMmxFBSxxIzUy8vvNZcsQiA5Nh4zaWk2yx5R3TtIYqZO4CfMY1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461604; c=relaxed/simple;
	bh=Ao7+jhiwR7VMIsjhTd++zXohFMFnpGuaBIUcGCft5Cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C0AURI+7jU0Cg+9ymcBoaRNmcMNfoA4/R2iwdNHi9GDgiyROtuxamvqa6SS8q/4U5G7JWyLYBngKli9I7aTUbJkSzGtKrYhc0RxktWwYPHzVUI3nFumiC2lr2nsYrYVnHNl2H+JgZb+0k3+DQKSX3Pn+HyzkC0k1KXTv9ccQedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWyn/klj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730461601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao7+jhiwR7VMIsjhTd++zXohFMFnpGuaBIUcGCft5Cc=;
	b=QWyn/kljIP3JnXLIqW8bvXc0L5vud+QW7vYu7Y5fCF25xLc7kuGJZbAI92thJFAjbDobts
	OPB4VGg5ZuZp81zPSY2gHFOJ8rD1QKlm3oP5UjNVhCgAZZQjDqfHwuAVd0nn0s9VNT8xrB
	m1E79o2s3UR+MpiISIdB3xmvz0AN0D0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-DI35avyTN9i6UdNfnFVWmA-1; Fri, 01 Nov 2024 07:46:40 -0400
X-MC-Unique: DI35avyTN9i6UdNfnFVWmA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315c1b5befso11702915e9.1
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 04:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730461599; x=1731066399;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao7+jhiwR7VMIsjhTd++zXohFMFnpGuaBIUcGCft5Cc=;
        b=u6uM/moG9AvMxbgd128Eks4mxqF1dphl6QUhX5MZkPcQk/NiELHpcg9B5sjGgllBBy
         NPhShaIIS6IHWQWJt7sZA6f8kmvxPA9SdHWmpy1RjtJS+5z42uaNujv1Bl6ZfL29wLDC
         m72ci83P2D9lQAwWn0BIHcsWh+ElvZicPTEZPg32CRjJE2vCZGiLF4v3Fyk1ozENqIre
         fnvsDOXUB+xbyLqpc/Pre8pjX5L1qcUQKpptTjiy81W/CyYfJ4ywGUUkRp/UMlsW3Byy
         +qB19yU6Tc+ICiIF7P8h42DvN5UapqNPCUsPNAMHhL6oyIjfPUD3uHEx59fJM3oQmOZb
         NPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmsRta0noO45lGNYBV25XbkOwC+/uV2KKyYn1tKWDgn5exIkqiLsHliwWD484FF61tuL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Pel+z2vvwLrwp7EowuDOWAghEMjzI7a7D5w8OTi+ij8WRo5L
	Rs9j1tYUUYgnhAHoZ+DZFEF2ImNZPacNb+VSShI+rkLjZ05aZ3hSFP9R8ZLzdcHvpIGWOTqZj3R
	iV3YqVsxhlFHXy30HatvlrKwriapHDdK33JKoez7ZRtihYxWi5Q==
X-Received: by 2002:a05:600c:1548:b0:42f:80f4:ab31 with SMTP id 5b1f17b1804b1-4319acadc1emr190571975e9.18.1730461599304;
        Fri, 01 Nov 2024 04:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpDaFcEn6EWvQmh/U5bQPmg4IvB1Z9BcupW5ULubk3inI7A9bmwOF6H9T18cXj699H1zpfAQ==
X-Received: by 2002:a05:600c:1548:b0:42f:80f4:ab31 with SMTP id 5b1f17b1804b1-4319acadc1emr190571655e9.18.1730461598850;
        Fri, 01 Nov 2024 04:46:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e853esm90363425e9.8.2024.11.01.04.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:46:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CE513164B94C; Fri, 01 Nov 2024 12:46:36 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/18] bpf, xdp: constify some bpf_prog *
 function arguments
In-Reply-To: <20241030165201.442301-5-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-5-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 12:46:36 +0100
Message-ID: <87y1239nxf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> In lots of places, bpf_prog pointer is used only for tracing or other
> stuff that doesn't modify the structure itself. Same for net_device.
> Address at least some of them and add `const` attributes there. The
> object code didn't change, but that may prevent unwanted data
> modifications and also allow more helpers to have const arguments.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


