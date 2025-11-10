Return-Path: <bpf+bounces-74108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E388BC497DB
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 23:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 712704E7A1F
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 22:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E252FF662;
	Mon, 10 Nov 2025 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVkrl/PV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735F2F60D1;
	Mon, 10 Nov 2025 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812749; cv=none; b=qBrTYYNVxK2V4rhsdM5Xtxz1SiwGj/d/94q16b4fQN3Ka512kiHya1rD638camTttxk5U4WKuWVS3XjvYTnaRQtspYP6nlntHxHuVxoA25Zc0SBL8YfNd+NxFjTb20Lha2h1KMN0ecwbrnBHNHJYoSH2Kletv08m3Vy4lAJL5Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812749; c=relaxed/simple;
	bh=iy5kMaaeHl6VSN+jlhG/NqPo3TCL0ASyH7OyGSMw9lA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VYJbNj1yvUHksHyR47kJeAUWi8dH/9q22hPLKzEzPoZzojmOLzLW0TYKaVaUlq8xzYTaIwjsvuhUb+4LbiYiqvOLeH0JJ64JursQYvhfp1MjK3jx3DLnmvRPJUv/h9NY/Jy9xw/LCYxriRPrDPqqxZOtzlTSXZyHByIv8ZIHwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVkrl/PV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467CCC4AF0B;
	Mon, 10 Nov 2025 22:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762812748;
	bh=iy5kMaaeHl6VSN+jlhG/NqPo3TCL0ASyH7OyGSMw9lA=;
	h=Date:From:To:Cc:Subject:From;
	b=nVkrl/PVVPxAsLFk7JCIzcInUKR6DLaCNhhFQy3d1Dkby1BF0XHCGJPjqFu3ikvMW
	 ofaCkL/c3da9Ev5KbiDoh6UHUkW62VvQfKcKM1EFY3aMgysUXOp1BxAmV7qUtOAWEx
	 LHyRdjcvSQFXSJxJtZu5P0qKsyKt+Rwx/AB4rTuR4mXCO7sbA0yK65PNw+nJfSVp8U
	 F+iqDnqoJ3pR1wmvd0GDqbkmtzqglCQgwzudG1xPyDxUkrZG3YikN1Des1tcjHpOBb
	 4x+LH4JQDbNW6Pd6u+fy/C4UWwxTuzQ1yT7r1AQwHh5rMjn3eAWxC2d2cDQJSC03jt
	 7X8xZFh5q9g+Q==
Date: Mon, 10 Nov 2025 19:12:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Viktor Malik <vmalik@redhat.com>, Peter Frost <mail@pfrost.me>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Ben Olson <matthew.olson@intel.com>,
	Antoine Tenart <atenart@kernel.org>,
	Paolo Valerio <pvalerio@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: ANNOUNCE: pahole v1.31 (BTF function encoding, BTF alignment
 inference, more CI)
Message-ID: <aRJjSfT-PZXayd5S@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
 
	The v1.31 release of pahole is out with a reworked selection of
functions to encode in BTF, improvements in the inference of alignment
when loading from BTF, where this isn't explicitely encoded, and more CI
tests.

Main git repo:

   https://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.31.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.31.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.31.tar.sign

	Thanks a lot to all the contributors and distro packagers,
you're on the CC list, we appreciate a lot the work you put into these
tools,

Best Regards,

- Arnaldo & Alan

BTF encoder:

- Rework the selection of functions to represent in BTF, for instance:

  - Skip functions that passes values thru the stack when those structs don't
    have expected alignment due to some attribute usage that then causes
    problems with BTF trampolines due to lack of expressiveness in BTF to
    signal such special cases.

- Skip objects (compile units) without DWARF: don't stop a multi object
  encoding session just because one doesn't have any DWARF in it.

- Fix BTF dedup by updating libbpf. 

BTF loader:

- Fix the inference of the explicit alignment attribute of zero length arrays,
  like struct skb_ext->data[] in the Linux kernel. Important as BTF has no no
  explicit alignment attribute encoding.

- Fix the inference of alignments after bitfields, such as in struct
  nft_rule_dp->data[] after ->handle:42, also in the Linux kernel.
    
pahole:

- Fix segfault with --show_reorg_steps option, e.g. pahole -R -S -C task_struct.

CI:

- Add comparision of functions encoded in BTF between baseline 'master' branch
  and current branch, i.e. 'next'.

