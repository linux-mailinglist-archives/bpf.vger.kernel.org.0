Return-Path: <bpf+bounces-43730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843439B91D6
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 14:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F00281A7A
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1821A08A3;
	Fri,  1 Nov 2024 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9ucX+Gr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1F1E4A4
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467099; cv=none; b=QRMGaRipcLrpm2EaFAqfmPRyzKX69SyVP/pDMYSwGxTYfVB74lxT/AznlkSEo0FDFmILRTW5gBbcBxKHq8UUQ2bYkgQgeogCDkpNpF2kMu5qLwvETMFcFeUsQ9WKtl5MA8DjVS4FBEMIKeAGuab1EFmkIDjZv996j2zgMaMh1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467099; c=relaxed/simple;
	bh=RdxH1k0Ii8oRON4S/9EyXeN10ibRW1RJYi7koqpVzMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mlN5gG45/UTL0pjmkwk4a3RXmrdQwjgaJH5aQcbtqKZV+v97XznmKOiRyAqOz6y4XoZ6cnUF7jtmW5IDcTlXObC8GIKkdtrdQOTGaHVDWjAdepKr0ubHQVlr1obH8CbRuOAtMBFG0a9AB1Pme9EEttDeYoU5qIm5JOAgkeLKUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9ucX+Gr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730467096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdxH1k0Ii8oRON4S/9EyXeN10ibRW1RJYi7koqpVzMw=;
	b=g9ucX+GrvQgWIHI3MVY0xVq74/D14MriYDh+Eo28ibIXzLGsqCfZ4Bn+Pv00MPx+vtNlds
	TkuKIEE/U5eMZI9dttOUg/laDpKtv11nC+/c6xrSq7VWs9HJCn72XgJGlR1slPKy8BsuIS
	7KvjLMSyZUechdvBj1YZ5eDvPeIFSHw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-J37fe0iyPzyNvn2nDDNxcg-1; Fri, 01 Nov 2024 09:18:13 -0400
X-MC-Unique: J37fe0iyPzyNvn2nDDNxcg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539f49f2443so2155348e87.2
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467091; x=1731071891;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdxH1k0Ii8oRON4S/9EyXeN10ibRW1RJYi7koqpVzMw=;
        b=t32wRBRXdQ6a+CIiJGY1lRhbWGtGoG5DewMGCKrl7FFQml3O+l5ZhKDpdy0fu9Natz
         Z25fiKfNtcMkx1Q9AgeBTQ66kUxvb2JjxU05slIE537uXK9ElqV9M3Tc3L1wRH3HO41Q
         QlCgj82B4ap4xhYtV1x6TvFQtgG5wFLQV89ubgvu7KoCrGZGw/AvM5l1Z683HtKQjAq9
         7bKIlkP2bmPl0SSBIoLwfwF8vdIitScdSHVh9S2yZxjKJpXjhLHvtJ4WUs8qBTYYo+we
         uouaMpUFRHP+p2FBY2jKlZYlRmTtWJAAi/xlkTZNjIXEMRqGW3aTHc74iYABVCYFQald
         Hdfw==
X-Forwarded-Encrypted: i=1; AJvYcCXNaz1J9IMK4JIHrJmbszpB5J2YJ/FxiGtNXxle2a4LQpRkJHFue2TtpZeuZZ62MB3xK3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlw+JD8uqWMD2QyQ7cIRbjijefSyYuSQUp0A2fkyU3cqqw1E4
	2SAvj9pT3EhhbxVglhI/67TpY7/7CTMg8NpyS139iSNGvtk7L/FZ1CgHAS2/qw8C5uTvoJkrTWo
	HaYzFefuopD49Gp35k4sal5lgpK3RVYSri4PtLxBrxmHK/8mOIw==
X-Received: by 2002:a05:6512:2243:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-53d65e0a8d4mr3212618e87.41.1730467091610;
        Fri, 01 Nov 2024 06:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJNVGRmbx39lG0hrP6GbSN+xYWdg5dI0TkiCnLiw1oNape2uMbIqGq3hW8ch9y34gU6zJIuQ==
X-Received: by 2002:a05:6512:2243:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-53d65e0a8d4mr3212579e87.41.1730467091191;
        Fri, 01 Nov 2024 06:18:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56681a03sm177661866b.197.2024.11.01.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:18:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A10EE164B96A; Fri, 01 Nov 2024 14:18:04 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 12/18] xdp: add generic
 xdp_build_skb_from_buff()
In-Reply-To: <20241030165201.442301-13-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-13-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 14:18:04 +0100
Message-ID: <87frob9joz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> The code which builds an skb from an &xdp_buff keeps multiplying itself
> around the drivers with almost no changes. Let's try to stop that by
> adding a generic function.
> There's __xdp_build_skb_from_frame() already, so just convert it to take
> &xdp_buff instead, while making the original one a wrapper.

This does not seem to be what the patch actually does? :)

-Toke


