Return-Path: <bpf+bounces-45016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5929CFF81
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 16:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF23B263F1
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0D72A1D8;
	Sat, 16 Nov 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i20LXlj8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E815E97;
	Sat, 16 Nov 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771072; cv=none; b=SPkje/y6uu+MPpVi3jX2TeJrqo9BYpoC+kvz+m5K2QR4TDjgOE2hukNK5A06JZ7F0QHPwPvy4kFmqfDUUbm08rl9x74SCc+8lrFP3lHk/HpnJC606cZnwKBIUh/PeWi6t72F2ABDI+YirYJ874eK7uLc5+Gw0i7mVAUhJTuIs08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771072; c=relaxed/simple;
	bh=yQYdgCpNEMtF0HNTBzAA+71DuzYd+VQ2Rqp+ru9TBB0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QAzzLwGPAooRE2vbNlqzquPjNJ8mZOE7oaZBZsqfj7x/taxkRO51YhE1cmfAJD90Va+cKlBWTtuH3/MAGQfJFYjbgCIl/Qc9jbARoVqzTnopfV8h8S7nmVwepBS5aP3NY/2nWaR4/rhQMYfBn/VfY7oht5ORpmJ2XYSho2lQ21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i20LXlj8; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b14554468fso169989185a.1;
        Sat, 16 Nov 2024 07:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771069; x=1732375869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffp/2XHswsX4GIfB6X17WYFirgSky6aZSjqbMLRIuB0=;
        b=i20LXlj88z4Sy2qfYjPRU0G7Qg4I29PT0ytoqlj4TZAHQIZItvJ7NgYmpG0Y+czlZt
         7ItoJ3lUDFWns8RHWxqWTkx4C2gJH0kG4quNnbYIMUckFWr5wQMlzKTcOWaXLhnEcw68
         a+3hBgDBU1XzbU4hsDCwYWXCzKc3MBuEj9roKlNl8WzZA9Y1yTDlTy55sdZjD+vAQJsf
         6D+V5O+NrN1EEhZizNZl+BdF+IiuEcWXU7kk+kn27adexWj3YhGXAiTk2QxnE6fy4u3m
         WrXPkbi082reEsVQPpmZOYmD/Qb8WlEXq0LYfyf3Tf8suPsAzrsTckuMG9ezT7smM3r4
         f/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771069; x=1732375869;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffp/2XHswsX4GIfB6X17WYFirgSky6aZSjqbMLRIuB0=;
        b=CA6HBdMjFzIMD35lmFBAh/c3fxhykr8qgdJRfu7hOhjTTTZtk9Wd4srrlXY54mAAFS
         XRUrl+JHTsewbodr/fO1Eo9qaen1wQ0yVDNjZCOey2Sdw3QXSCuc6wpXuTw90HI1V9YK
         fBr0DB3Zg/smupqaCZsVXQSWh6rlJhY1svyU+U2fiNje5CliZ0vdLfBewgUGapMl27V+
         5ofXa7IHpqDONo+4nqNBOeRJrC+5povnbxvkoF9PXzCe6o2pz3FCWXQJZ/+F2X3gJIEL
         whDhaEk3MmIEplVgC7gyKuY8z5nKwrN5cf8XqRPHtMH6GSaHAZeLZ7+AyYFZglkKlR6/
         qA8A==
X-Forwarded-Encrypted: i=1; AJvYcCWZpuesIBfxIkW0dUrzbMyKR4kPclDlQLap72JmHSNBrUQPbfK7JFo/AFPIA7FmfTB/jOXaFXOo@vger.kernel.org, AJvYcCWfzE4s7dqhJ9ud/B6kX2SOKCyyztxztEFux+mi/g17wsA8w7+qKPaotgImuZqk/XAEnL8=@vger.kernel.org, AJvYcCWgYk7645W1tFVau5nP2YiavAAobfWHEe8t+I6XxUn7aUjsW/29u+tby+ZXh0Vn4Vvy8HgFZWZMv41jKahQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhkb7JsDlyB4hWZXWg2DhHKKqBEDccGHJS6jZWAFYqbXSrR4So
	iPysMWI0qG893nregAkbrojyIzbWbDrKi5VVczaJ/CfRVAGE9nV/
X-Google-Smtp-Source: AGHT+IGzJiXel5I/BzErwJFKRsN4haga5+vVh6h48bwOnnM6wNuhTqevKYwU6qC0aF/ISDj4a7QqsA==
X-Received: by 2002:a05:620a:1996:b0:7b1:3f19:b81a with SMTP id af79cd13be357-7b3623678aemr876423485a.53.1731771069231;
        Sat, 16 Nov 2024 07:31:09 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635aa3ab71sm32480391cf.49.2024.11.16.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 07:31:08 -0800 (PST)
Date: Sat, 16 Nov 2024 10:31:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6738babc4165e_747ce29446@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241115184301.16396cfe@kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241115184301.16396cfe@kernel.org>
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 16:24:23 +0100 Alexander Lobakin wrote:
> > Part III does the following:
> > * does some cleanups with marking read-only bpf_prog and xdp_buff
> >   arguments const for some generic functions;
> > * allows attaching already registered XDP memory model to Rxq info;
> > * allows mixing pages from several Page Pools within one XDP frame;
> > * optimizes &xdp_frame structure and removes no-more-used field;
> > * adds generic functions to build skbs from xdp_buffs (regular and
> >   XSk) and attach frags to xdp_buffs (regular and XSk);
> > * adds helper to optimize XSk xmit in drivers;
> > * extends libeth Rx to support XDP requirements (headroom etc.) on Rx;
> > * adds libeth_xdp -- libeth module with common XDP and XSk routines.
> 
> This clearly could be multiple series, please don't go over the limit.

Targeting different subsystems and thus reviewers. The XDP, page_pool
and AF_XDP changes might move faster on their own.

If pulling those out into separate series, that also allows splitting
up the last patch. That weighs in at 3481 LoC, out of 4400 for the
series.

The first 3 patches are not essential to IDFP XDP + AF_XDP either.
The IDPF feature does not have to not depend on them.

Does not matter for upstream, but for the purpose of backporting this
to distro kernels, it helps if the driver feature minimizes dependency
on core kernel API changes. If patch 19 can be made to work without
some of the changes in 1..18, that makes it more robust from that PoV.

