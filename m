Return-Path: <bpf+bounces-70913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BF2BDAB67
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 18:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFEE18874EA
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 16:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5208C3043AC;
	Tue, 14 Oct 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JznmYc7t"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CD28150F
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460799; cv=none; b=GPvGkkM2ZjNLJdryKA+E1D32b4Id6uf8QbYmBnYPvblXZQf8cy7XyEwtZND3/ch02Hd5VnQYvLmvnkipZxN5OQmyBhrEoK+mcbu/Un0U3/z9RG3X2jtRFkci9J4gvm09esT0SFcPM29ixGLf5K7gjrnGZcAsJscwRkHbHVRTgAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460799; c=relaxed/simple;
	bh=IjSEs5UDstWgk3sazx+/L1A6xCj9XyekBAS4mMZ3jPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SBfAdmKgcYUbXZMm2dyYpRqUs/i9vZhHaFqypJ1zvb9NtT0D5jgIFBmbu5Q+qssptAEgf3AIkUyCDlpn/+Y/Kw6wHW0LDeu35QT4w/zAfrlNw0PiRLQbIgSFqSmf4MDtPbKHKN9NxCiGn1PA0O7C19aWedIoQhTOV5WLrqIjX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JznmYc7t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760460797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/4kVeAo0V1Wd9MyzWaBsN4+1ag8AoVte3K6v/U9rb8=;
	b=JznmYc7tJk38u6unSkgPeYpujW4SL2zmVGeFapOZKO+DvmKrMIRuWxcRhdD30XA/Y5+5+h
	htunQ9JGS1PykdcOlDo2uz6yKOdTY4T8Wgv6ChJ7m1lc55WiW4MNqwC8Nw7LrUVzAWP7ox
	ij5kedAfNCpcrwHmL1UDdSKSuY8NUE8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-gHRM85Z1OlO5oZADsy5L3A-1; Tue, 14 Oct 2025 12:53:15 -0400
X-MC-Unique: gHRM85Z1OlO5oZADsy5L3A-1
X-Mimecast-MFC-AGG-ID: gHRM85Z1OlO5oZADsy5L3A_1760460794
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b2f9dc3264bso1010487666b.1
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 09:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760460794; x=1761065594;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/4kVeAo0V1Wd9MyzWaBsN4+1ag8AoVte3K6v/U9rb8=;
        b=DVft4bCdz/fx6MZkhabLm7mbJ6Mh85aujd0DWBX8EAkNIGy5+y12dBLNdOMVPpBi4L
         pfPn3N+EOaMPUmGOnAx0N3XSrs5nS9N6g81cOxs2EcmwBcv+ZZuU61DMUFDiBQjJsHC3
         8kq/KrCwq5Yh235rhQHPfdcItPxLeYw0jiLWuJfw63NcEwoGM3akkI2EnN4Zkuj/VjQu
         B2sdVWdRMwS8IyRnmFeGd2ckTqi+7x36S+J7Lq3abtb8hIn12ydmn4BtLT4V/mBvzY2N
         WtoUa0hbve6a2MB7ilBb8KnqBCSQTCuYwiFmuIeiP5Cd/Folu1imH11GDlsh/egw4wke
         WPxw==
X-Gm-Message-State: AOJu0Yzpxv5bDsxYvsfPD4rIpR/TOlEItiBBO98+TujF9gjQ1DAE2cmy
	4AO/Zd61d/iK8YOVgnYsJwlyjcPiIo/dsvNa1vbaR3Ey5cjfGf3OR8BSkex1zOM2NjLRMxbl+zU
	XkRBm7/MKIrkc6A5Y7a0SeZ5fHDdvq/5krCUHBdVBRBFpQeBo7zr/mA==
X-Gm-Gg: ASbGncuwRq3pIn0nspzwcNcuzN/yvuz9HVqZlHmRgjNz+HOxSjdm8dJ0uQL7O4GtvU5
	JP0krE+fxt0K3iEVBrR/J0rBnjSp9RmW+ONBF2Mn6HoRw0JzK23k4J3IIBR4zSpk2bzUHVKvRmX
	283jbB2Vhldw2isogXHtuSULE+cHEwURX6IHw0qG6jLiZ+CjYuI8U0/Q4M0c4d7wfW8g5xR7WxQ
	QY6tuuNoFKdbeh+qkIiiEObF2RMjQhqQTzOmcJZEyRIiwNE52i8uID6LBcKMn+iGoMXkmr2TwbY
	0ctJCkJNiIL9IXkOcdxGai6yJB6g10t45nBWaZDx+5jTU3WGMH3Pp8/5UFL9UMEGJ8E=
X-Received: by 2002:a17:907:7fa4:b0:b47:70bf:645 with SMTP id a640c23a62f3a-b50ac5d1dfbmr2897740266b.58.1760460794419;
        Tue, 14 Oct 2025 09:53:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE72MbITs6aqq1b0ioYKB4ybW/wbW9L4R5RQuxA3PGjn0GXoyF08d49eY/9ah1CliNG8B+5Yg==
X-Received: by 2002:a17:907:7fa4:b0:b47:70bf:645 with SMTP id a640c23a62f3a-b50ac5d1dfbmr2897735866b.58.1760460793954;
        Tue, 14 Oct 2025 09:53:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd2a63b1sm18729366b.66.2025.10.14.09.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:53:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6C30C278B98; Tue, 14 Oct 2025 18:53:12 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, ilias.apalodimas@linaro.org, lorenzo@kernel.org,
 netdev@vger.kernel.org, magnus.karlsson@intel.com, andrii@kernel.org,
 stfomichev@gmail.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH bpf 2/2] veth: update mem type in xdp_buff
In-Reply-To: <20251013162408.76200e17@kernel.org>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
 <20251003140243.2534865-3-maciej.fijalkowski@intel.com>
 <20251003161026.5190fcd2@kernel.org> <aOUqyXZvmxjhJnEe@boxer>
 <20251007181153.5bfa78f8@kernel.org> <aOYtUmUiplUpj2Pj@boxer>
 <aOY+4qpQ+tzIWS5Q@boxer> <20251013162408.76200e17@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 14 Oct 2025 18:53:12 +0200
Message-ID: <87v7kh4e87.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 8 Oct 2025 12:37:22 +0200 Maciej Fijalkowski wrote:
>> > > I guess we're slipping into a philosophical discussion but I'd say 
>> > > that the problem is that rxq stores part of what is de facto xdp buff
>> > > state. It is evacuated into the xdp frame when frame is constructed,
>> > > as packet is detached from driver context. We need to reconstitute it
>> > > when we convert frame (skb, or anything else) back info an xdp buff.  
>> > 
>> > So let us have mem type per xdp_buff then. Feels clunky anyways to change
>> > it on whole rxq on xdp_buff basis. Maybe then everyone will be happy?  
>> 
>> ...however would we be fine with taking a potential performance hit?
>
> I'd think the perf hit will be a blocker, supposedly it's in rxq for
> a reason. We are updating it per packet in the few places that are
> coded up correctly (cpumap) so while it is indeed kinda weird we're
> not making it any worse?
>
> Maybe others disagree. I don't feel super strongly. My gut feeling is
> what I drafted is best we can do in a fix.

I'd tend to agree, although I don't have a good intuition for how much
of a performance hit this would end up being.

-Toke


