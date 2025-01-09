Return-Path: <bpf+bounces-48422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6463EA07EDC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEC6161F9F
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C00191F68;
	Thu,  9 Jan 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EzCvHiCT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E62018C91F
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444181; cv=none; b=Dc76YbG90bjXk7CP8qP5yakO5iW5pbKaMpb4cFQt9pT9+E/aeIIwI5/RTY6KX7e/prnKQQGxQcXZxGXCVfJFdChP6shALVvEPsb/xIRL/IBgzcqENTQOsCtLI2MtAXiDQGpZzZyv/hjQtbDXdxn68YdRwwnehIVCTnIoqB8DiZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444181; c=relaxed/simple;
	bh=x3uYksfOoCqvS4XniyEV29UETSR2DPCFoV/TeVAweyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COUEXMCqWPyFVExUI7s1uZYU4gHaBEgKUn3Kt7mxSHZt1NGi9oo61xWC+6zhDYUul6TUyHwA2qHFTgVi1hsXMmRABzP3dAz0YOlMdsJ/SMPun0VQ1dW1f84mize91RzbHVj5enChGUb+CZliPLqNEuGq3cAXFTr0KXksPajBmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EzCvHiCT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21649a7bcdcso18910055ad.1
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 09:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736444179; x=1737048979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZHhPMMDgJMypLywgbNALwEdp/HyHOu1g/oZooCDLms=;
        b=EzCvHiCTSE28neDl9j/D9H7k4H+oLv393N904jPbz2MkF9ndMSDAsffGPSTmjOJr8C
         9ssl7AvcQSrhKfiEmrcWE+lkGXs+XFHUgf1EB3w/WTAX3WzrsSrecGWl843Rw38TsG0T
         jUeEclRUXeq+8wQCT2vJkoTXiXsX1W4uHMWYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736444179; x=1737048979;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZHhPMMDgJMypLywgbNALwEdp/HyHOu1g/oZooCDLms=;
        b=to4PO6uelp+smaWxTeIqk8AntrbdubZ6pFApMqLNEBO2e/oTrpKnAhxF2zXD0D0mlM
         cM4+mmkGLokGamfwCpXQ6kuY28v3n9Gi8sJyd4rGTb8HUNvQ46yTuwwHr2qwXvEjCjhS
         V1WvsZbcEBGkk0eQGpEpo86bCQIjWOjbKy9mpr5ur39QK9JPJ6TyysX4cMdSop5KDJNG
         dSrcX4AlT593z3Dlo+0HZPKHL+AYv+YKqry3OHmghsObDXLSHT5QDpJ+q/8pkAjrG7iz
         SFD9uQGRnKE0jgcckaaVzSpeRIjSz/9QiCkO0eAAvS2CUuCY6izy6ubqjqy0OpCngRt6
         TIdw==
X-Forwarded-Encrypted: i=1; AJvYcCUOPMsamgukDMB5/4Slf0f74XeBTv97uLzql9WeuxCZ0Qufp6xsYzH6EoW/g9xopzIbC/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmDKYJj7HBdFxmO/UMcnYDLxbYbqsaOk+gVJ+ye1cD+dKx2KT
	Bv75arFEPdG9iQXMGuBwJ0FDmW9G1qGqnRMp4R/RPkpZfynaDJOU4xy9ZCi0JIE=
X-Gm-Gg: ASbGnctsr6vl4R6u6Hib3fophPy71OO+gFq6roIQk7NWQMwO0R2BDpQCIjAMlZ30Kar
	abKH0U6b/qBJi3/CdqjY3TBD9SrKm80pjiqJr2IzMGaOFQTs1WuJs1HCSkYMPNeTaTsykexGGnZ
	CTIorVNwdDFL78Q85vsPaO9Y6JSu/1T8D6DtXWGc++nrrks9ADn0m+Q1GO+AxidOK0WVne3lBKy
	yjfL/+LXgjK/EdUkXBAJSq5VYNzfCIdmK1e1q63I028ophQ6i9uaE9CG2JGLKANcop1LHh/TgXN
	sliyUrZ+7Kz03w92NxDsJTw=
X-Google-Smtp-Source: AGHT+IEa3zYxpMXCXFOwlLMPkEEXePt9PsXFMZbJIFnWJoslOR8muwkSZIVXyD3D5iar6ke0LsXsVw==
X-Received: by 2002:a05:6a20:2591:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1e88d0e2320mr11880124637.16.1736444178914;
        Thu, 09 Jan 2025 09:36:18 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405489fbsm59505b3a.24.2025.01.09.09.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:36:18 -0800 (PST)
Date: Thu, 9 Jan 2025 09:36:15 -0800
From: Joe Damato <jdamato@fastly.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	mkarsten@uwaterloo.ca
Subject: Re: [PATCH net] xsk: Bring back busy polling support
Message-ID: <Z4AJD97LFmjfCrc2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	mkarsten@uwaterloo.ca
References: <20250109003436.2829560-1-sdf@fomichev.me>
 <CAJ8uoz3bMk_0bbtGdEAkbXNHu0c5Zr+-sAUyqk2M84VLE4FtpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ8uoz3bMk_0bbtGdEAkbXNHu0c5Zr+-sAUyqk2M84VLE4FtpQ@mail.gmail.com>

On Thu, Jan 09, 2025 at 04:22:16PM +0100, Magnus Karlsson wrote:
> On Thu, 9 Jan 2025 at 01:35, Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Commit 86e25f40aa1e ("net: napi: Add napi_config") moved napi->napi_id
> > assignment to a later point in time (napi_hash_add_with_id). This breaks
> > __xdp_rxq_info_reg which copies napi_id at an earlier time and now
> > stores 0 napi_id. It also makes sk_mark_napi_id_once_xdp and
> > __sk_mark_napi_id_once useless because they now work against 0 napi_id.
> > Since sk_busy_loop requires valid napi_id to busy-poll on, there is no way
> > to busy-poll AF_XDP sockets anymore.
> >
> > Bring back the ability to busy-poll on XSK by resolving socket's napi_id
> > at bind time. This relies on relatively recent netif_queue_set_napi,
> > but (assume) at this point most popular drivers should have been converted.
> > This also removes per-tx/rx cycles which used to check and/or set
> > the napi_id value.
> >
> > Confirmed by running a busy-polling AF_XDP socket
> > (github.com/fomichev/xskrtt) on mlx5 and looking at BusyPollRxPackets
> > from /proc/net/netstat.
> 
> Thanks Stanislav for finding and fixing this. As a bonus, the
> resulting code is much nicer too.
> 
> I just took a look at the Intel drivers and some of our drivers have
> not been converted to use netif_queue_set_napi() yet. Just ice, e1000,
> and e1000e use it. But that is on us to fix.

igc also supports it ;)

I tried to add support to i40e some time ago, but ran into some
issues and didn't hear back, so I gave up on i40e.

In case my previous attempt is helpful for anyone at Intel, see [1].

[1]: https://lore.kernel.org/lkml/20240410043936.206169-1-jdamato@fastly.com/

