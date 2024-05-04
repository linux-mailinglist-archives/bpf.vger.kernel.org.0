Return-Path: <bpf+bounces-28575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871DB8BBCB2
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 17:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290D91F21D55
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879FD4122C;
	Sat,  4 May 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ckHyTXnQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D81EF15;
	Sat,  4 May 2024 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714836592; cv=none; b=bPvn2qd+ajXb5Rrh0BTQFkwBLwJ/4yM2E8jtZYEhwreu1PWJUu4fxCzAUVyluZT2htHUCC7GcIVoq38TLmNcuaTfHf/2iQuD3yTYv0I29Mdv2WfvbnNqb3v4EEF7oZ42RzSCIO4grQo/aBOVyhTKnph4yUe+XgT4V+IEhgQ8aI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714836592; c=relaxed/simple;
	bh=02pleUcf8dXK4cmRCtM627DBPUH9ytcp+zcd8Xdh+ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td/oIUl2YgDR76vPFX3cYnFdLxR/Vxnt08sbMeJvSXHFwABVIopz7IN0JNA4VCc9VZzdx6EJOgAbQzjICB/zmNv9Tjdg+BJxhB/u130d2/x/IENJ5tfz2LNF3F8zusWnNAivYr8zdd7pFhiwti6agmyW+KzRJZ3vDVgC/XdlATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ckHyTXnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE77DC072AA;
	Sat,  4 May 2024 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714836591;
	bh=02pleUcf8dXK4cmRCtM627DBPUH9ytcp+zcd8Xdh+ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckHyTXnQ2pTe5wxPLHsCP4m8XHGFsYaY2MhWKDcggC4eVCa1EdYYGONIZZviVJ59L
	 ck6wZ4xkLMPGAPrEYdJhNkWurKID3hzx1R/NKEPbDWHBkiSqQo3pzio/sKEuB/rPI8
	 MZ8pU2ZtOP7qhop8G4J4GcLJmZli+xecnpPY+sKA=
Date: Sat, 4 May 2024 17:29:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
Message-ID: <2024050404-rectify-romp-4fdb@gregkh>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504003006.3303334-6-andrii@kernel.org>

On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> Implement a simple tool/benchmark for comparing address "resolution"
> logic based on textual /proc/<pid>/maps interface and new binary
> ioctl-based PROCFS_PROCMAP_QUERY command.

Of course an artificial benchmark of "read a whole file" vs. "a tiny
ioctl" is going to be different, but step back and show how this is
going to be used in the real world overall.  Pounding on this file is
not a normal operation, right?

thanks,

greg k-h

