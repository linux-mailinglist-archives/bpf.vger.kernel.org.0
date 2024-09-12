Return-Path: <bpf+bounces-39780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219679775B8
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 01:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BFB28602C
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 23:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6BA1C2DC2;
	Thu, 12 Sep 2024 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHAOBOZt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CB18891D
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726185247; cv=none; b=HvBbItay70LL2TSVXsoMpHk41wcnFrRzeFC+j9FIeNKhwmKs5GkLBEYr7Hv/lVA1lElaswVdHOIkUKAtgQAiemTulGLqn43MuVWWKfjdBiSH49gW0RoMLpmI+pIpzZFs9V9c74iD98ZuZWDJP8QubqQhRvTQSwQA9e/MH18PTyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726185247; c=relaxed/simple;
	bh=z5djP4fmdHMvifKs2U3p7Sua9IHiAaY9SAwNM7dxI64=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U4tdBEbLokMWkBynbL5JdNRr55yMXWZNLuqd4ImVFbox8GOXbAY8kEZm7+O1qYLieVnuH5l4szYUU1RyQwo4eZyPQ4SAAymffw2zRA+K6znH5gXEUAc9EMzYyR445w78l5/N3c3fKF3QTgbEsRjZB6Uf2vg6YECNqop6zWizrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHAOBOZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4FAC4CEC3;
	Thu, 12 Sep 2024 23:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726185246;
	bh=z5djP4fmdHMvifKs2U3p7Sua9IHiAaY9SAwNM7dxI64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dHAOBOZtt+FvWHt32qo2dVtHbtc47x23AnW78/vxw1ywWSmZQP2ptCnojqS+FGe0o
	 R/jVUd5s+1vrWPMDOU3I5XywpnWVksPXBrVHdNHGq7bPFEFI4uVy0XBWCYD4It+LMj
	 4iVs19FBsp3rtAnLvL/oQKYjexerTCCMKHYfOqDQUAL6RnVACbSpN5dZ9g+vjWQNX2
	 2zvbSO5VMruPiAPHXvoHjWH5MzyqZvAFZsSpIZA2i8OcoKsZeJjDEvlsnfMdX5qBQk
	 6Yeg7wJloyAQ1xVxpbDVLaAJps5k/o5/nPHnRArx2iOibbMcLBYZt5HjmFeMoQryiN
	 DOGvgfCHZHKJw==
Date: Fri, 13 Sep 2024 08:54:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: kernel-ci@meta.com, bot+bpf-ci@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v14 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240913085402.9e5b2c506a8973b099679d04@kernel.org>
In-Reply-To: <CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
	<CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 12 Sep 2024 11:41:17 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> + BPF ML
> 
> On Thu, Sep 12, 2024 at 8:35 AM <bot+bpf-ci@kernel.org> wrote:
> >
> > Dear patch submitter,
> >
> > CI has tested the following submission:
> > Status:     FAILURE
> > Name:       [v14,00/19] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
> > Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=889822&state=*
> > Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10833792984
> >
> > Failed jobs:
> > test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10833792984/job/30061791397
> > test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10833792984/job/30061791836
> > test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10833792984/job/30061757062
> > test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10833792984/job/30061757809
> >
> > First test_progs failure (test_progs-aarch64-gcc):
> > #132 kprobe_multi_testmod_test
> > serial_test_kprobe_multi_testmod_test:PASS:load_kallsyms_local 0 nsec
> > #132/1 kprobe_multi_testmod_test/testmod_attach_api_syms
> > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe_test1_result: actual 0 != expected 1
> > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe_test2_result: actual 0 != expected 1
> > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe_test3_result: actual 0 != expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kretprobe_test1_result: actual 0 != expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kretprobe_test2_result: actual 0 != expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretprobe_test3_result: actual 0 != expected 1
> > #132/2 kprobe_multi_testmod_test/testmod_attach_api_addrs
> > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe_test1_result: actual 0 != expected 1
> > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe_test2_result: actual 0 != expected 1
> > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe_test3_result: actual 0 != expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kretprobe_test1_result: actual 0 != expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kretprobe_test2_result: actual 0 != expected 1
> > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretprobe_test3_result: actual 0 != expected 1
> >
> 
> Seems like this selftest is still broken. Please let me know if you
> need help with building and running BPF selftests to reproduce this
> locally.

Thanks, It will be helpful. Also I would like to know, is there any 
debug mode (like print more debug logs)?

Thank you,

> 
> >
> > Please note: this email is coming from an unmonitored mailbox. If you have
> > questions or feedback, please reach out to the Meta Kernel CI team at
> > kernel-ci@meta.com.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

