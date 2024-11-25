Return-Path: <bpf+bounces-45564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDDD9D7CCF
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 09:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAEA4B22474
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C211187FFA;
	Mon, 25 Nov 2024 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="p0bGCS2L"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27CE1A296;
	Mon, 25 Nov 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522847; cv=none; b=rQocgxcJaVDlv63+MKgGzSFTPcZpA8BdAGHVValem7O153IFtJeWoDY+xaDEB8fympJqTaiREl5aImxwbb+3Xl77PqPUyLaZQharhjeH+hNv3LbjVU9At68ZplgzuqAgk1KzGCp4QcPcJjN7lVvzumrZVshiXD4vXj5XNsdAGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522847; c=relaxed/simple;
	bh=tuFGzuKT9Kp+P4m5tTUOZPtcMxp0g2nRys84C2P3StE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0BjAQMuyBqvvrIrOaPBco4JDINmC64RafvlRnSc0Rl4UD4QqQmZMWuJ7RcX4OhgBujT7WcFCMsblt/YN35zRnuvUZuWhG8dJFUESRLoFFxiS8ENs8vNVUDVkE3YUzLKI6nIQPPJpr84IvWC2vjm5xNeeX+NkJ2WbTkPEAd7ejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=p0bGCS2L; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732522839;
	bh=tuFGzuKT9Kp+P4m5tTUOZPtcMxp0g2nRys84C2P3StE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0bGCS2LNemliJfdmxMqG9vlusdYA7kTxyNQaWFWmsCVbYVnbVpOFCxkHXUg0uaVC
	 CQUyna8F5V6HlTf0Uc7dCxD2AsUi8JT7jXdcwy6cYDo/N0pH2Y/2W8XzTlgbuXLrjJ
	 jSmZBju27GRXD4w5l7yo81d4b6CFkDkx4/o1bJ1g=
Date: Mon, 25 Nov 2024 09:20:37 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 3/3] kbuild: propagate CONFIG_WERROR to resolve_btfids
Message-ID: <f7764e9b-6254-42af-94b8-41562a18b58b@t-8ch.de>
References: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
 <20241123-resolve_btfids-v1-3-927700b641d1@weissschuh.net>
 <CAADnVQL4_8-Y0O3Gar-+q7XKMU6_tY8atEddWB2KsR+DCUZ7WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL4_8-Y0O3Gar-+q7XKMU6_tY8atEddWB2KsR+DCUZ7WQ@mail.gmail.com>

On 2024-11-24 15:38:40-0800, Alexei Starovoitov wrote:
> On Sat, Nov 23, 2024 at 5:33 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
> > Allow the CI bots to prevent the introduction of new warnings.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  scripts/link-vmlinux.sh | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index a9b3f34a78d2cd4514e73a728f1a784eee891768..61f1f670291351a276221153146d66001eca556c 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -274,7 +274,11 @@ vmlinux_link vmlinux
> >  # fill in BTF IDs
> >  if is_enabled CONFIG_DEBUG_INFO_BTF; then
> >         info BTFIDS vmlinux
> > -       ${RESOLVE_BTFIDS} vmlinux
> > +       RESOLVE_BTFIDS_ARGS=""
> > +       if is_enabled CONFIG_WERROR; then
> > +               RESOLVE_BTFIDS_ARGS=" --fatal-warnings "
> > +       fi
> > +       ${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} vmlinux
> 
> I'm not convinced we need to fail the build when functions are renamed.
> These warns are eventually found and fixed.

The same could be said for most other build warnings.
CONFIG_WERROR is a well-known opt-in switch for exactly this behavior.

Fixing these warnings before they hit mainline has various
advantages. The author introducing the warning knows about the full
impact of their change, discussions can be had when everybody still
has the topic fresh on their mind and other unrelated people don't get
confused, like me or [0].

The "eventually fixed" part seems to have been me the last two times :-)

Given the fairly simple implementation, in my opinion this is worth doing.

Please note that I have two fairly trivial changes for a v2 and would
also like to get some feedback from Masahiro, especially for patch 1.


Thomas

[0] https://lore.kernel.org/lkml/20241113093703.9936-1-laura.nao@collabora.com/

