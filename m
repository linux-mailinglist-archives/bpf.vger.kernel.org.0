Return-Path: <bpf+bounces-49362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BAA17DC8
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 13:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724C61887105
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEF21F191A;
	Tue, 21 Jan 2025 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doFpnkvz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5D1F1517;
	Tue, 21 Jan 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737462548; cv=none; b=dA3BtECpZ8w1ggFWFYN41/FIYClEpCOS0LSo+VxMt0FWX3rv3iFlGMz6IHAuHTXnjfOf3v9s0k+zrE7vydtSpw1YqDUT4Rc0buGBRytj9ZDp+eDse4RUsdaRcFzKWu3RSg9TpMsCmTy5cUuUdNSDz8pKs1+zFxntL/cLIXYNrko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737462548; c=relaxed/simple;
	bh=/gJad0hzVC6gdQi0Vrylz5MVKI4Be2IkWe0CLAVCmEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eQ6B/MNjMdLHwxKKm2YLeamlruFgh+3dpzLbeTdGmUCu966JBTW3I5QkNxyn6e9PWFASFwCfnxMR4FDnIXiZtRtRyIvWsf2YtPDd/Z4dDj0CEGb74YsmWF76IuW6GJm8SFEku+57iBwW28t8zss/Q+/YFlsDTWvLsgouW5C/zkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doFpnkvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFC2C4CEDF;
	Tue, 21 Jan 2025 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737462547;
	bh=/gJad0hzVC6gdQi0Vrylz5MVKI4Be2IkWe0CLAVCmEY=;
	h=Date:From:To:Cc:Subject:From;
	b=doFpnkvzq21Sy68Mh7sADg6g95cc5xgRZyJ8YjycDgHO7Vwrp61htEpvQ+qkT1UqF
	 78a89bjEJQCo7AYCR55B4g0OmSQMBwI6+YGquksKp6SJN3SRM8K6Fp5TlkwolOiB8q
	 fI0Au9O9EICBh02YsobF7vEVeTRnMWbF9EPKd0c6oaRdMN/ICYRpb+VmIgMXWN6GPv
	 9Bk3Nlk5WXk2gPHTEZWgkIog+toKqO4pndte+O2iOVvTkLzeg/rjsX29O4G9SllpwJ
	 5k+DoXUj3EJBhNgEGeyt0ThUhP4hva4fjWDMOsI1XWI7SDSlAWO5riHdgAf1If8VqI
	 jg1iF0V+FDK3A==
Date: Tue, 21 Jan 2025 13:29:02 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Viktor Malik <vmalik@redhat.com>,
	Tom Stellard <tstellar@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: ANNOUNCE: pahole v1.29 (Better DWARF loading & BTF encoding)
Message-ID: <Z4-TDt42dTKZvCo6@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
 
	The v1.29 release of pahole is out with more efficient
multithreaded DWARF loading and BTF encoding, that is now always
reproducible, multiple decl tags are supported in the BTF loader and
thus pfunct can pretty print the full function prototype.

Main git repo:

   https://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.29.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.29.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.29.tar.sign

	Thanks a lot to all the contributors and distro packagers,
you're on the CC list, we appreciate a lot the work you put into these
tools,

Best Regards,

- Arnaldo

DWARF loader:

- Multithreading is now contained in the DWARF loader using a jobs queue and a
  pool of worker threads.

BTF encoder:
    
- The parallel reproducible BTF generation done using the new DWARF loader
  multithreading model is as fast as the old non-reproducible one and thus is
  now always performed, making the "reproducible_build" flag moot.

  The memory consumption is now greatly reduced as well.

BTF loader:

- Support for multiple BTF_DECL_TAGs pointing to same tag.

  Example:
    
      $ pfunct vmlinux -F btf -f bpf_rdonly_cast
      bpf_kfunc bpf_fastcall void *bpf_rdonly_cast(const void *obj__ign, u32 btf_id__k);

Regression tests:

- Verify that pfunct prints btf_decl_tags read from BTF.

pfunct:

- Don't print functions twice when using -f.

