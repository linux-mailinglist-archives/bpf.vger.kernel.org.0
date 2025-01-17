Return-Path: <bpf+bounces-49188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F3A14FAE
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27E1188AFED
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6907D1FF1B1;
	Fri, 17 Jan 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ais6Urze"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866E1FCCEE
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118390; cv=none; b=OjL21ChDIG0X7r2ASgx30jIjOvdXlYNJNpmA7KTyAXH/uU1iwD1JzeGI+3nNxeER99A2RHhghmVE3h9aihRziJkbcnSMinJNIoRroRmUb87WJBZE4uDtNOzH21tYES1zTM8OwSOw88wfYpsvuX7tFEVdo+had/TebzDELEjIbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118390; c=relaxed/simple;
	bh=qN6oQdM0gmq9bZuCu0hFeMmKij2Q4XKghqJIhff84jU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b0eFiJdoAjb+Egp7IDSu63f/I+NHREE7tNasfSGyAUzoI1GuwmFQ90vHUTkB0cnsXzPntM9U+bhyBbsDS2OWCq7wJKkw8K4q3DJzN2it28JPbOoen949TFmabYHFcWDWblviDpC7VMl+EDjGpBvJ1zrjx/xjLRQtpzz5RY38MgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ais6Urze; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qN6oQdM0gmq9bZuCu0hFeMmKij2Q4XKghqJIhff84jU=;
	b=ais6Urze9Hz61k47VIL93sPL3uGdTbsrTIfI7DZobbHIpiVnYr+thJmcj+d7SsIySvYoWt
	zwZmcjytQ70EQi8j56t3agoylIkv2YYEk7sIBUmJ3ufJk6SOrr/ZgTP5HRQXC7nlqnHPX0
	6JBMieRBQyJV3I5uS1EXRTiuRBW+JMQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-3QlyB1O9MYur4pi8FlS06w-1; Fri, 17 Jan 2025 07:53:06 -0500
X-MC-Unique: 3QlyB1O9MYur4pi8FlS06w-1
X-Mimecast-MFC-AGG-ID: 3QlyB1O9MYur4pi8FlS06w
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa69c41994dso147987366b.0
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 04:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118385; x=1737723185;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qN6oQdM0gmq9bZuCu0hFeMmKij2Q4XKghqJIhff84jU=;
        b=WE2Ai6hBTkyZb7WOJbdB9VuBSiPIFAtQuA7vaJd3gTTgRaR+LAy0U3lhRsnHj0WIqs
         sy5zAJPslDOYzz5G6jSrWV5x8guQtd4mWGElef6uqqB50dmEr8CuP9jBlCmDc7N13Gxq
         2yLwz1qkDvlDeM3ylxw4bUtEsSIphQ8GwNkhhmfi9BjRmK7ntb4dkyqQ9NFGo7MZeXG3
         8FdwHxeK+v+O/DVruuUpPaiSz6taD/0NVfDWbKTvj0ejt62w30IzG4G5AyYC3NFceO7G
         M1rwpZ8bSTpurajcGk5eSbhGBdEaYjQT4BjfP6vl+VLJgGN4TPCER+gdIe8R5+amzBXy
         svjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHMgHkvxReY42w2hDJo7Ci4WJ54yCXMaitXOtThWl3hSx4vb+ll7/+zwgaPGDJZgBVxqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTX2fBfCvL3GjDrPaqZclhhY33P5zbiLftModixdLeFws3YPk9
	/Ol0SMQNVgZEYhOSm+6OpeNwymCgBEizUWVwTTR101eCBqG9zAZn36Osp42V8hJfg5dvH+qNTcK
	zllzPc0zQWd/r3z6aX6J2kDAn12tGbKfnL6Rx3frb6758wW+XAQ==
X-Gm-Gg: ASbGnctSGK446I40D+zZ2ooS6O3S9XzgBOWjBbgsbo7bgqaphBs4Q6XynY1D+n9Sf5y
	rgF34VKHHz/K6CWUgDRc7CcGrYpK7WT1LK4vEWStfpk757b9aZBN922+Io/uxezhPbNrQbIUt80
	f4x0pyAwZFyiwIAkXyvBulb5Uvj+GN2lOfYcO2VePcpVJN1MP9949+nv5UwuvE+3e3nqsPfEEzZ
	GVkoVPRIcAdArXXvfqSd37Ar1DMkFHCpG9nX5uh3qpPwYR7+dR+gw==
X-Received: by 2002:a05:6402:518d:b0:5d0:ed92:cdf6 with SMTP id 4fb4d7f45d1cf-5db7d30114amr5261871a12.19.1737118384725;
        Fri, 17 Jan 2025 04:53:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECEDgqEa9N1u7Nf9uT2ewMSMFMEzvISL0C0K2RPIRXP5iZTwga5ZJuTpP90f83OYACuxDQZQ==
X-Received: by 2002:a05:6402:518d:b0:5d0:ed92:cdf6 with SMTP id 4fb4d7f45d1cf-5db7d30114amr5261800a12.19.1737118384305;
        Fri, 17 Jan 2025 04:53:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670d52sm1471453a12.24.2025.01.17.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:53:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4674017E786F; Fri, 17 Jan 2025 13:53:02 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] bpf: cpumap: reuse skb array instead of
 a linked list to chain skbs
In-Reply-To: <20250115151901.2063909-5-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-5-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:53:02 +0100
Message-ID: <87a5bpob4h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> cpumap still uses linked lists to store a list of skbs to pass to the
> stack. Now that we don't use listified Rx in favor of
> napi_gro_receive(), linked list is now an unneeded overhead.
> Inside the polling loop, we already have an array of skbs. Let's reuse
> it for skbs passed to cpumap (generic XDP) and keep there in case of
> XDP_PASS when a program is installed to the map itself. Don't list
> regular xdp_frames after converting them to skbs as well; store them
> in the mentioned array (but *before* generic skbs as the latters have
> lower priority) and call gro_receive_skb() for each array element after
> they're done.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Clever approach. A little hard to follow all the memmoves, but I think
it checks out given the description above :)

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


