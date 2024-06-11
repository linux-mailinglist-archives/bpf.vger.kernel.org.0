Return-Path: <bpf+bounces-31896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49B5904733
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 00:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E650284D9C
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 22:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA3A155739;
	Tue, 11 Jun 2024 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQgWri4u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF49475;
	Tue, 11 Jun 2024 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146336; cv=none; b=qSuf0jDINXTC4qualrKGiqlgiGM+PTqPWJlF1F0AqF6+3mE57x5N2u25kFqv46C73kBNTL9ioKeINAXdy3/pvxfMXC/1TTm2/qhuiB07ARK9s7fu0O3rl3x1rCGfG4Kk3zLspGTKRD+5K1OYytwvVx5NhQUEBLkoI88XjUxWR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146336; c=relaxed/simple;
	bh=zW6zU8woHSujRDru/K7WaWs9kXaIVX09P/gjbKgambA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6+5Oqr8Tu3vuoOOTQHwJN5pltX8Li0Xzv2Pw6yiG6jo8gxinxbsc2tV9iyK/JzNU/f118aVr39g1ubW6LshDeMfToAFy8kzB7Opi+jEAzhcdmY532hyStUAhJkw9k5pSrVzIUH7ZGMOtjPc7iGo+SoKW19mhxuipSrKkWjIzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQgWri4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9A0C2BD10;
	Tue, 11 Jun 2024 22:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718146335;
	bh=zW6zU8woHSujRDru/K7WaWs9kXaIVX09P/gjbKgambA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQgWri4u6xC3HNFBoO/QuYYWFChrygZbVKuv12KI9ErGVk3EQAXeM52KI4G3skTdk
	 I6t7XH5t+RlsvvUtph0omUYesTHgCbxYfwWB5CsnQOtHXiOLLTLcZhhxVN+W5CBm+X
	 uLnXM+G0LIl9d/4rnPoVWgjTYz6nfVS0FcEhXAit3uF1VQHC+3N0TcY3ywrRuF0w4D
	 +HhRq3ZZhgUJF5SIOaKU2Or2/RPuhbOWaXZuH2aDyF7XSreHbNzoFOzuCyj19Je6/D
	 WstjxNOPzpzHrFP/v8e9oeOHWZeY51zo99Idh1k+d3Vf1u8CKfn9j8P0PKuWAb4PRE
	 Vra45qppC9E+g==
Date: Tue, 11 Jun 2024 19:52:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: ANNOUNCE: pahole v1.27 (reproducible builds, BTF kfuncs)
Message-ID: <ZmjVHKLTP4_hnzug@x1>
References: <ZmjBHWw-Q5hKBiwA@x1>
 <ZmjDuv_zuhA3Xp2m@codewreck.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmjDuv_zuhA3Xp2m@codewreck.org>

On Wed, Jun 12, 2024 at 06:38:02AM +0900, Dominique Martinet wrote:
> It looks like the v1.27 tag has not been pushed to the git repos (either
> this or github), we're using git snapshots for nixpkgs, so it'd be great
> if a tag could be pushed out.

Done.

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tag/?h=v1.27
https://github.com/acmel/dwarves/releases/tag/v1.27

> (I think some release monitoring tools left and right also use tags,
> even if that's less important if you Cc other distro maintainers... I
> just happened to see the mail on bpf@vger.)

May I add your e-mail here:

acme@x1:~/git/pahole$ cat PKG-MAINTAINERS 
# Please let me know if I should remove/update/add more distro package maintainers here
# I'm keeping this so that I CC them when releasing new versions, thanks!

Jan Alexander Steffens <heftig@archlinux.org>
Domenico Andreoli <cavok@debian.org>
Matthias Schwarzott <zzam@gentoo.org>
Dominique Leuenberger <dimstar@opensuse.org>
acme@x1:~/git/pahole$

So that on the next release I CC you?

Thanks for reporting!

- Arnaldo

