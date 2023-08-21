Return-Path: <bpf+bounces-8197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76478360B
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 01:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9480D280F6A
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 23:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E03174E8;
	Mon, 21 Aug 2023 23:00:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EF1172B
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 23:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01A47C433C9;
	Mon, 21 Aug 2023 23:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692658835;
	bh=cnfuqKXDFBomHhVePj2n0keDZtn1cBu3e65NT7XHbrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cKI89gqyOMTtdsGsNmtofW4+qvNNBEDXhq4KTas+47+PKPd7jKlgS2T73+dAx96qy
	 Bk7Xj3avc4eUMy0DpUIYCiZxf9cpcE+446Nn15Lau63u2wtgxrFIwUeGZb1sNC1YWO
	 BGZTdpC4gEMmuUEB6ltngxRsljbQHhAwSS1FiKLUuUCQ3b3qKFcc9mDfTmvCKS0kKl
	 encwoxnykEKxI0mRKji8H5WGPipQ7RT/u3xhoW3m5zk22n6ZRLlz1Z/TXLvgkwGZjB
	 kwNJIdKX0ozdj+uqj7mBZLV9DxMwdshRmIDVHRw3DglPurnNnJgD+/N6PdLmTvjYjN
	 bbTASzzuraq1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D93ADE4EAFB;
	Mon, 21 Aug 2023 23:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv7 bpf-next 00/28] bpf: Add multi uprobe link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169265883488.23782.9616148124710372571.git-patchwork-notify@kernel.org>
Date: Mon, 21 Aug 2023 23:00:34 +0000
References: <20230809083440.3209381-1-jolsa@kernel.org>
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, laoar.shao@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  9 Aug 2023 10:34:12 +0200 you wrote:
> hi,
> this patchset is adding support to attach multiple uprobes and usdt probes
> through new uprobe_multi link.
> 
> The current uprobe is attached through the perf event and attaching many
> uprobes takes a lot of time because of that.
> 
> [...]

Here is the summary with links:
  - [PATCHv7,bpf-next,01/28] bpf: Switch BPF_F_KPROBE_MULTI_RETURN macro to enum
    https://git.kernel.org/bpf/bpf-next/c/c5487f8d9186
  - [PATCHv7,bpf-next,02/28] bpf: Add attach_type checks under bpf_prog_attach_check_attach_type
    https://git.kernel.org/bpf/bpf-next/c/3505cb9fa26c
  - [PATCHv7,bpf-next,03/28] bpf: Add multi uprobe link
    https://git.kernel.org/bpf/bpf-next/c/89ae89f53d20
  - [PATCHv7,bpf-next,04/28] bpf: Add cookies support for uprobe_multi link
    https://git.kernel.org/bpf/bpf-next/c/0b779b61f651
  - [PATCHv7,bpf-next,05/28] bpf: Add pid filter support for uprobe_multi link
    https://git.kernel.org/bpf/bpf-next/c/b733eeade420
  - [PATCHv7,bpf-next,06/28] bpf: Add bpf_get_func_ip helper support for uprobe link
    https://git.kernel.org/bpf/bpf-next/c/686328d80c43
  - [PATCHv7,bpf-next,07/28] libbpf: Add uprobe_multi attach type and link names
    https://git.kernel.org/bpf/bpf-next/c/8097e460cabd
  - [PATCHv7,bpf-next,08/28] libbpf: Move elf_find_func_offset* functions to elf object
    https://git.kernel.org/bpf/bpf-next/c/5c742725045a
  - [PATCHv7,bpf-next,09/28] libbpf: Add elf_open/elf_close functions
    https://git.kernel.org/bpf/bpf-next/c/f90eb70d4489
  - [PATCHv7,bpf-next,10/28] libbpf: Add elf symbol iterator
    https://git.kernel.org/bpf/bpf-next/c/3774705db171
  - [PATCHv7,bpf-next,11/28] libbpf: Add elf_resolve_syms_offsets function
    https://git.kernel.org/bpf/bpf-next/c/7ace84c68929
  - [PATCHv7,bpf-next,12/28] libbpf: Add elf_resolve_pattern_offsets function
    https://git.kernel.org/bpf/bpf-next/c/e613d1d0f7d4
  - [PATCHv7,bpf-next,13/28] libbpf: Add bpf_link_create support for multi uprobes
    https://git.kernel.org/bpf/bpf-next/c/5054a303f896
  - [PATCHv7,bpf-next,14/28] libbpf: Add bpf_program__attach_uprobe_multi function
    https://git.kernel.org/bpf/bpf-next/c/3140cf121c25
  - [PATCHv7,bpf-next,15/28] libbpf: Add support for u[ret]probe.multi[.s] program sections
    https://git.kernel.org/bpf/bpf-next/c/5bfdd32dd575
  - [PATCHv7,bpf-next,16/28] libbpf: Add uprobe multi link detection
    https://git.kernel.org/bpf/bpf-next/c/7e1b46812345
  - [PATCHv7,bpf-next,17/28] libbpf: Add uprobe multi link support to bpf_program__attach_usdt
    https://git.kernel.org/bpf/bpf-next/c/5902da6d8a52
  - [PATCHv7,bpf-next,18/28] selftests/bpf: Move get_time_ns to testing_helpers.h
    https://git.kernel.org/bpf/bpf-next/c/3830d04a7401
  - [PATCHv7,bpf-next,19/28] selftests/bpf: Add uprobe_multi skel test
    https://git.kernel.org/bpf/bpf-next/c/75b3715720d7
  - [PATCHv7,bpf-next,20/28] selftests/bpf: Add uprobe_multi api test
    https://git.kernel.org/bpf/bpf-next/c/ffc68903617a
  - [PATCHv7,bpf-next,21/28] selftests/bpf: Add uprobe_multi link test
    https://git.kernel.org/bpf/bpf-next/c/a93d22ea6092
  - [PATCHv7,bpf-next,22/28] selftests/bpf: Add uprobe_multi test program
    https://git.kernel.org/bpf/bpf-next/c/519dfeaf5119
  - [PATCHv7,bpf-next,23/28] selftests/bpf: Add uprobe_multi bench test
    https://git.kernel.org/bpf/bpf-next/c/3706919ee05f
  - [PATCHv7,bpf-next,24/28] selftests/bpf: Add uprobe_multi usdt test code
    https://git.kernel.org/bpf/bpf-next/c/4cde2d8aa7f7
  - [PATCHv7,bpf-next,25/28] selftests/bpf: Add uprobe_multi usdt bench test
    https://git.kernel.org/bpf/bpf-next/c/85209e839fc2
  - [PATCHv7,bpf-next,26/28] selftests/bpf: Add uprobe_multi cookie test
    https://git.kernel.org/bpf/bpf-next/c/e7cf9a48f8d6
  - [PATCHv7,bpf-next,27/28] selftests/bpf: Add uprobe_multi pid filter tests
    https://git.kernel.org/bpf/bpf-next/c/d571efae0f1d
  - [PATCHv7,bpf-next,28/28] selftests/bpf: Add extra link to uprobe_multi tests
    https://git.kernel.org/bpf/bpf-next/c/8909a9392b41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



