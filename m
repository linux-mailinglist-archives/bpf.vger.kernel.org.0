Return-Path: <bpf+bounces-31891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B6F90463F
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 23:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192DD1C2365A
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 21:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5871153580;
	Tue, 11 Jun 2024 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt37lus7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC9BA34;
	Tue, 11 Jun 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718141218; cv=none; b=HHzPaJ0mM57PqMHPgp97rmVYG0LCnllk0BlGINoiMj24Ao6Hza0rYTWJYDTMZXRlP7oqA/bxiNkxqdyaW7Qrb/HddKms6WtneFJ1RoHNu6ecTMO2PQaWkyD97wyeoZ/Hq9L0jxtK0alf9kPbifOFa2D3R/E+02FHfKqQM602QCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718141218; c=relaxed/simple;
	bh=l/slOwUbIQjq2IvyCrFSxlG82jUdCK9N4vGo107GLYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mKwBg000o1g6LNgmBCJPMnmBaQp6BRwsCcYZeK+QSfG3osHJpxYi8ry8vczOUimElCNHTmAjBku1PAxFUHtp4qPP+Gwo/f/kV91Fpw7LmCyyv7Pvdbg23zxcyHDu3hQ3NCS9sBIagUzkskzO0v3JbGeeoAFa0C6daPXiJoFww+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt37lus7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31733C2BD10;
	Tue, 11 Jun 2024 21:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718141216;
	bh=l/slOwUbIQjq2IvyCrFSxlG82jUdCK9N4vGo107GLYY=;
	h=Date:From:To:Cc:Subject:From;
	b=dt37lus7snItxzKmWYgcdGBV42ZD/gGxHjIdjOx8ffwSExMY8uRmTB4dZc0uz7vGl
	 HO5uPbatJv06//E91ULoMem1+EJxuL4yuAwn08gY+DOG1FCaKVjirKlI1sKULcXUJO
	 me4452LoQSXYMfrQAREX6xF4sICrP4640QzXKTN9m+DtHSneE7Iu2OqcjSc3wYNSXC
	 ZIslyrX1bewsd8oTTPtY4JTokLz++c8BvDES3dSVLjW+1jt+5xBe+CdmljumekzVVa
	 elkXDNisXWslp/luWgx5q7MoCZyki898hdstg3DZxzExec8sXr1T4bIOA8NW5x1wKc
	 MyFxmGbBj9klQ==
Date: Tue, 11 Jun 2024 18:26:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>
Subject: ANNOUNCE: pahole v1.27 (reproducible builds, BTF kfuncs)
Message-ID: <ZmjBHWw-Q5hKBiwA@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com

Hi,
 
	The v1.27 release of pahole and its friends is out, supporting
parallel reproducible builds and encoding kernel kfuncs in BTF, allowing
tools such as bpftrace to enumerate the available kfuncs and obtain its
function signatures and return types.

Main git repo:

   https://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.27.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.27.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.27.tar.sign

	Thanks a lot to all the contributors and distro packagers, you're on the
CC list, I appreciate a lot the work you put into these tools,

Best Regards,

- Arnaldo

BTF encoder:

- Inject kfunc decl tags into BTF from the BTF IDs ELF section in the Linux
  kernel vmlinux file.

  This allows tools such as bpftools and pfunct to enumerate the available kfuncs
  and to gets its function signature, the type of its return and of its
  arguments. See the example in the BTF loader changes description, below.

- Support parallel reproducible builds, where it doesn't matter how many
  threads are used, the end BTF encoding result is the same.

- Sanitize unsupported DWARF int type with greater-than-16 byte, as BTF doesn't
  support it.

BTF loader:

- Initial support for BTF_KIND_DECL_TAG:

  $ pfunct --prototypes -F btf vmlinux.btf.decl_tag,decl_tag_kfuncs | grep ^bpf_kfunc | head
  bpf_kfunc void cubictcp_init(struct sock * sk);
  bpf_kfunc void cubictcp_cwnd_event(struct sock * sk, enum tcp_ca_event event);
  bpf_kfunc void cubictcp_cong_avoid(struct sock * sk, u32 ack, u32 acked);
  bpf_kfunc u32 cubictcp_recalc_ssthresh(struct sock * sk);
  bpf_kfunc void cubictcp_state(struct sock * sk, u8 new_state);
  bpf_kfunc void cubictcp_acked(struct sock * sk, const struct ack_sample  * sample);
  bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css * it, struct cgroup_subsys_state * start, unsigned int flags);
  bpf_kfunc struct cgroup_subsys_state * bpf_iter_css_next(struct bpf_iter_css * it);
  bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css * it);
  bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map  * map);
  $ pfunct --prototypes -F btf vmlinux.btf.decl_tag,decl_tag_kfuncs | grep ^bpf_kfunc | wc -l
  116
  $

pretty printing:

- Fix hole discovery with inheritance in C++.

