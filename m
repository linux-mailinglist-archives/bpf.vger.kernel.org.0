Return-Path: <bpf+bounces-13258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD8D7D7288
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 19:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EF01C20E47
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C287430F90;
	Wed, 25 Oct 2023 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTQGkKEo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B81C6B0
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 17:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7980CC433C7;
	Wed, 25 Oct 2023 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698255784;
	bh=b1DjQy3lEaeOIpv5cQZRCDMWXJpUQ4duVn3/jtNOE8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTQGkKEo7USsr427arlVKUkxC77ua+U5OutE5jISCzeih2HClsR6dM0rm0J/WMsfM
	 EM8+M+8HKhin5Gsm6yvqNC61kdfzyYqvV6tInJ1AvYDpEfSbmLcgahKYFZja9g2qVt
	 VAqSViX8WGTZN97tEDkoa5cEI33TvP0CEdeoYJhkzOGI+1XhiApjgBm5ZlblKendLl
	 D0LDFL9zVLK89EOiJjvELQm2DWvZxfcQNbW1fWTHeKgecR+Nrx9NE0GaKIILzPkgKB
	 43UOkFAcJoPHggBXTY1SgpNqkkze7J5phpZcTCZfIKWLYJb/U9Hw+LaDkYiXjSztrS
	 /8arBsGfC5GMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id ECF744035D; Wed, 25 Oct 2023 14:43:01 -0300 (-03)
Date: Wed, 25 Oct 2023 14:43:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii.nakryiko@gmail.com, jolsa@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v4 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
Message-ID: <ZTlTpYYVoYL0fls7@kernel.org>
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023095726.1179529-1-alan.maguire@oracle.com>
X-Url: http://acmel.wordpress.com

Em Mon, Oct 23, 2023 at 10:57:21AM +0100, Alan Maguire escreveu:
> Currently, the kernel uses pahole version checking as the way to
> determine which BTF encoding features to request from pahole.  This
> means that such features have to be tied to a specific version and
> as new features are added, additional clauses in scripts/pahole-flags.sh
> have to be added; for example

Finally trying to test this:

I started with a random vmlinux file, already with BTF:

$ bpftool btf dump file vmlinux.v5.19.0-rc5+ format raw > vmlinux.v5.19.0-rc5+.dump.original
$ wc -l vmlinux.v5.19.0-rc5+.dump.original
291961 vmlinux.v5.19.0-rc5+.dump.original
$ grep -i enum64 vmlinux.v5.19.0-rc5+.dump.original | wc -l
0
$

$ grep -i enum vmlinux.v5.19.0-rc5+.dump.original | wc -l
2175
$

Ok, now I want to encode just with enum64, i.e. all the other features
will not be enabled via this new option and only the enum64 will, if
present in the DWARF info:

$ cp vmlinux.v5.19.0-rc5+ vmlinux.v5.19.0-rc5+.enum64 ; pahole --btf_encode --btf_features=enum64 vmlinux.v5.19.0-rc5+.enum64 
$

I tried using --btf_encode_detached=file but then couldn't find a way to
make 'bpftool btf' to consume detached BTF, it seems that "file" means
"ELF file containing BTF" so I copied the original file to then reencode
BTF selecting just the enum64 feature, the resulting file continues to
have the original DWARF and the BTF using that --btf_features set:

[acme@quaco pahole]$ pahole -F btf vmlinux.v5.19.0-rc5+.enum64 | wc -l
143161
[acme@quaco pahole]$ pahole -F dwarf vmlinux.v5.19.0-rc5+.enum64 | wc -l
143589
[acme@quaco pahole]$

[acme@quaco pahole]$ pahole --expand_types -F btf vmlinux.v5.19.0-rc5+.enum64 -C spinlock
struct spinlock {
	union {
		struct raw_spinlock {
			/* typedef arch_spinlock_t */ struct qspinlock {
				union {
					/* typedef atomic_t */ struct {
						int            counter;                                       /*     0     4 */
					} val;                                                                /*     0     4 */
					struct {
						/* typedef u8 -> __u8 */ unsigned char  locked;               /*     0     1 */
						/* typedef u8 -> __u8 */ unsigned char  pending;              /*     1     1 */
					};                                                                    /*     0     2 */
					struct {
						/* typedef u16 -> __u16 */ short unsigned int locked_pending; /*     0     2 */
						/* typedef u16 -> __u16 */ short unsigned int tail;           /*     2     2 */
					};                                                                    /*     0     4 */
				};                                                                            /*     0     4 */
			} raw_lock;                                                                           /*     0     4 */
		}rlock;                                                                                       /*     0     4 */
	};                                                                                                    /*     0     4 */

	/* size: 4, cachelines: 1, members: 1 */
	/* last cacheline: 4 bytes */
};

[acme@quaco pahole]$

But 'bpftool bpf' doesn't like it:

  $ bpftool btf dump file vmlinux.v5.19.0-rc5+.enum64 raw
  Error: failed to load BTF from vmlinux.v5.19.0-rc5+.enum64: Invalid argument
  $

But it doesn't like it even when not using --btf_features :-\

  $ cp vmlinux.v5.19.0-rc5+ vmlinux.v5.19.0-rc5+.default_btf_encode ; pahole --btf_encode vmlinux.v5.19.0-rc5+.default_btf_encode
  $ bpftool btf dump file vmlinux.v5.19.0-rc5+.default_btf_encode raw | wc -l
  Error: failed to load BTF from vmlinux.v5.19.0-rc5+.default_btf_encode: Invalid argument
  0
  $ 

I'll try to root cause this problem...

- Arnaldo

