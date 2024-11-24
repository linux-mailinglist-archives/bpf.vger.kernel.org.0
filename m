Return-Path: <bpf+bounces-45548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD129D782A
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 21:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6718B21684
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E5E15DBB3;
	Sun, 24 Nov 2024 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PJ8s9/cj"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8102500BA;
	Sun, 24 Nov 2024 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732481883; cv=none; b=dcv2uu/0MUY4Kykz0csh7TepylEwi9Zc4LbSyHd+oCA7KM0xr1T5IWI5Cp3aRth8XlzHUdj5Yg3OlhKcKtLEP8a8Pq94Cj5axmLeLhLjT5ATZFR15Nv9vIH6K0Dmz1j/bqsI87MaIdI6IzgwovoQ0irx2EkuVQobpKGjBBlmTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732481883; c=relaxed/simple;
	bh=abYCQw+xKYPcs5818rEBfwSaq8CEsFH/3v7kq6LLNuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQlhH0Bjn9LPVQPtuguRpU6dlDgDY59N/WEdgq+H29/6/H2QsSlbbftXhH1OeL/6sMq1Pwkfd5Sg7S2Q3oxY0WlqOx/12ZYkKcRQktjihI6XtvTDrA2qqkXxqvI0YNtZLQWydkUGGJeZUw6ARGLdeX0aEdEYPM8Murn96/WCs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PJ8s9/cj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732481878;
	bh=abYCQw+xKYPcs5818rEBfwSaq8CEsFH/3v7kq6LLNuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJ8s9/cjk/4eFww3lb/egksExnFl7gKb1tDhCkvL1Lb3O0yA2yfS8aZVx+tSqbdcJ
	 1ZPC3/E4cqa7vfbGdGBWcj6s1Jdz9K9erH9HIyMXLKiU5+h1zmOd2kfrOH7QkOch/8
	 KYpL8g/+vplC6Hxy9ldSahfXf2TNdiBTP8TArlmM=
Date: Sun, 24 Nov 2024 21:57:57 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/3] kbuild: add dependency from vmlinux to resolve_btfids
Message-ID: <fa77c47c-b9c7-4013-8ccf-7ee7773c0c2d@t-8ch.de>
References: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
 <20241123-resolve_btfids-v1-1-927700b641d1@weissschuh.net>
 <Z0ONnhIVK1Sj9J09@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0ONnhIVK1Sj9J09@krava>

On 2024-11-24 21:33:34+0100, Jiri Olsa wrote:
> On Sat, Nov 23, 2024 at 02:33:37PM +0100, Thomas Weißschuh wrote:
> > resolve_btfids is used by link-vmlinux.sh.
> > In contrast to other configuration options and targets no transitive
> > dependency between resolve_btfids and vmlinux.
> > Add an explicit one.
> 
> hi,
> there's prepare dependency in root Makefile, isn't it enough?

It doesn't seem for me.
If the source of resolve_btfids is changed, it itself is recompiled as
per the current Makefile, but vmlinux is not relinked/BTFID'd.

> ifdef CONFIG_BPF
> ifdef CONFIG_DEBUG_INFO_BTF
> prepare: tools/bpf/resolve_btfids
> endif
> endif
> 
> thanks,
> jirka
> 
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  scripts/Makefile.vmlinux | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> > index 1284f05555b97f726c6d167a09f6b92f20e120a2..599b486adb31cfb653e54707b7d77052d372b7c1 100644
> > --- a/scripts/Makefile.vmlinux
> > +++ b/scripts/Makefile.vmlinux
> > @@ -32,6 +32,9 @@ cmd_link_vmlinux =							\
> >  targets += vmlinux
> >  vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
> >  	+$(call if_changed_dep,link_vmlinux)
> > +ifdef CONFIG_DEBUG_INFO_BTF
> > +vmlinux: $(RESOLVE_BTFIDS)
> > +endif
> >  
> >  # module.builtin.ranges
> >  # ---------------------------------------------------------------------------
> > 
> > -- 
> > 2.47.0
> > 

