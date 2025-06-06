Return-Path: <bpf+bounces-59842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B039AACFC79
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 08:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA81E7A76D9
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 06:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6842D24E4C4;
	Fri,  6 Jun 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NG6VHckx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A920E1A275;
	Fri,  6 Jun 2025 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749190819; cv=none; b=Wxb2d3xfYL7DH9ALJRrxHA04bbgqBnEIrg+wHjfsqoefvNq5KcwgXLyfzDegNFB1I3nbQFTtayxsL9sjrx4G3jRy1lFi/XaEXQdErLGhXRrcpM/2LOZUrhP94Cy/FJvbEraeMJaL4/yFATdKtE5rFIRAjvY6gpMR4f/TleAJbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749190819; c=relaxed/simple;
	bh=GGMZQDha5MME4iV+ZVJ8ZscSVZP5hFu772k1h5zEqCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFhRr5VTH94VwkjP85saH5UFhQCbmipU3HxoCNUaDg/JFsiVTXmtTGSt37H0lvakXliPsgiUElBnv/HEEMgcUaykA0+fzDQyheKUr9WxgCx/uxsG1iQTFI6HAOogFwha8FtDendO9tdrhSOelN4BBjxwxkq7kYPEzGEotXh0FIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NG6VHckx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F566C4CEEB;
	Fri,  6 Jun 2025 06:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749190815;
	bh=GGMZQDha5MME4iV+ZVJ8ZscSVZP5hFu772k1h5zEqCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NG6VHckx30kUej5V4Kr04DCOHZwDL00/lv96YfccQDVPxGLnVxnN19fkpd06Q7z+W
	 +wSkJKSmIJ+jovm1QJZswbkVpKJq7g1WRyepEFe5L6FqckgJKJ9Dx/nadmXuyTHVhK
	 14PhjdFAFLkspzBpmqz08re85GhPrGk9uSE21BYA=
Date: Fri, 6 Jun 2025 08:20:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suleiman Souhlal <suleiman@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ian Rogers <irogers@google.com>, ssouhlal@freebsd.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [RESEND][PATCH] tools/resolve_btfids: Fix build when cross
 compiling kernel with clang.
Message-ID: <2025060620-stainless-unedited-ddfc@gregkh>
References: <20250606052301.810338-1-suleiman@google.com>
 <20250606053650.863215-1-suleiman@google.com>
 <2025060650-detached-boozy-8716@gregkh>
 <CABCjUKA-ghX8MHPai5mfC4dZgS8pxi3LAvh3Wnm0VCt4QmU2Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCjUKA-ghX8MHPai5mfC4dZgS8pxi3LAvh3Wnm0VCt4QmU2Hw@mail.gmail.com>

On Fri, Jun 06, 2025 at 03:08:09PM +0900, Suleiman Souhlal wrote:
> On Fri, Jun 6, 2025 at 3:05 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jun 06, 2025 at 02:36:50PM +0900, Suleiman Souhlal wrote:
> > > When cross compiling the kernel with clang, we need to override
> > > CLANG_CROSS_FLAGS when preparing the step libraries for
> > > resolve_btfids.
> > >
> > > Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
> > > when building tools in parallel"), MAKEFLAGS would have been set to a
> > > value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
> > > fact that we weren't properly overriding it.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
> > > Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> > > ---
> > >  tools/bpf/resolve_btfids/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > You forgot to say why this is a resend :(
> 
> I wasn't sure how to say it. It didn't occur to me that I could have
> replied to it with the reason.

That goes below the --- line and it would be a v2, not a RESEND as you
changed something:

> It was because I had "Signed-of-by:" instead of "Signed-off-by:".

Which means it was not identical to the first version (a RESEND means a
maintainer can take either as they are the same).

thanks,

greg k-h

