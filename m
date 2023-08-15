Return-Path: <bpf+bounces-7801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B411277C9D8
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 10:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B211C20C49
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360DFCA69;
	Tue, 15 Aug 2023 08:59:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081D7AD5F
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 08:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C15C433C7;
	Tue, 15 Aug 2023 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692089969;
	bh=MArXAIr8c9w9SGHAmRMmXFdx0pibI2BQaL9ZvGmfZ+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5eMKztoKIGPUroWlu0kDWQckmc28nItr01rFT5I4CClgh1M1uBGGsZnH0LVIWtxQ
	 qbyNyWmOigSmPPXS//NsFqZ9z6h+6rRzHjkCFmltOp/mkVdE2AzNOBZUgCaIrPJu+r
	 t5DXUaKuPLwXWbvbt2oDhXLrx1ief2b1C0jrRI9DQ9WUBxNdcwtLDipJ3GH9bMJgQM
	 fylZxEdJM8GgdaLe3wW0HTPWleupgJAT4B6d5eGuxRTVkc4uyMvaeRpJbJJjLfBl6M
	 RiNcn4YA86xiFhW6ycuJCQ+Xt9h3rNTaqz3fqPDb+/mnBoD5TArukWBsYwS9HDsJJg
	 Is5XzyeFf2jLA==
Date: Tue, 15 Aug 2023 10:59:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gyroidos@aisec.fraunhofer.de
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
Message-ID: <20230815-feigling-kopfsache-56c2d31275bd@brauner>
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>

On Mon, Aug 14, 2023 at 04:26:09PM +0200, Michael Weiß wrote:
> Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
> which allows to set a cgroup device program to be a device guard.

Currently we block access to devices unconditionally in may_open_dev().
Anything that's mounted by an unprivileged containers will get
SB_I_NODEV set in s_i_flags.

Then we currently mediate device access in:

* inode_permission()
  -> devcgroup_inode_permission()
* vfs_mknod()
  -> devcgroup_inode_mknod()
* blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block devices and friends
  -> devcgroup_check_permission()
* drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu info afaict
  -> devcgroup_check_permission()

All your new flag does is to bypass that SB_I_NODEV check afaict and let
it proceed to the devcgroup_*() checks for the vfs layer.

But I don't get the semantics yet.
Is that a flag which is set on BPF_PROG_TYPE_CGROUP_DEVICE programs or
is that a flag on random bpf programs? It looks like it would be the
latter but design-wise I would expect this to be a property of the
device program itself.

