Return-Path: <bpf+bounces-33506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAB191E452
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 17:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85231F24379
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090D16D325;
	Mon,  1 Jul 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="reo0iNVl"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52C16D300
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848382; cv=none; b=c13L2xr9QnYt0thyYT0d94qXKe4gN/xfj7peE2x+VLUdWEAov73BPxYTNtrLArxjWhsUoMOxmofOjLdBqns3PhsdMTmSUSztJkrnWw02lMiV6TkpDk1xDR0MA3lA9u80xnjSmTOIlmA5qiSFgPUxYAHSY+kYQgMzE6MMPcOgwPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848382; c=relaxed/simple;
	bh=fE9oCfUBxifD2aSlM//aQmeHbzeMPAigdxBq955CN6g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T0PMDN/dJnygLnH43UNo6uhmt8llKKl81gCldoOpkJCnxWajT/WrYmq0/UUgfnS9FZ8IR6Rm06OEiHJWO95IoIgZ+uTPX9cc0X1Pk6Se9sbj19S/bGhhIfjAEPQLZ+R/JQQCATeVfs97NHJIsvDvq6JXdblX3VQqzVd/ID8d91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=reo0iNVl; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JIEpLHfFWdLpMXP2s6ZgtLz6mqDT4WlJVckVptRCY2g=; b=reo0iNVlhuloKDZoWu8BxcBp/M
	TLFq/7ZypzBYxIUpwxBlKWTyFQDgGBSV6IRfGU/eN3c45ERWdAMNpNfTR/ERjaDqBxhGuZx+gygJc
	M7Z0T66CNq/9qGWhs0TRAPb9iGvZftjEockPKalvyWXC+AnKL0tcb8ffsfVNIJiuOztm+PLhJHjN5
	JB/gOayGvZXNNjDggYgh0OZk1Our3eRQn9lO/gJMtABpmaOMV7r+N9RIpjyaN4Od+DZww6VrpDjjC
	e9EXoBaniPCt/nv/9fStVSuL6ykaRa07kr7srx7GZYjd7PE8ZtasDaSXQTsyOaegaKO/VyzXZ/K71
	TnbdZrNA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sOJ7v-000GlS-Vj; Mon, 01 Jul 2024 17:39:36 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sOJ7u-0005IL-26;
	Mon, 01 Jul 2024 17:39:35 +0200
Subject: Re: [PATCH bpf v2] bpf: Fix null pointer dereference in
 resolve_prog_type() for BPF_PROG_TYPE_EXT
To: Tengda Wu <wutengda@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 hffilwlqm@gmail.com
References: <20240624120533.873789-1-wutengda@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3e35e433-4941-1432-6dd9-685b89f3aa15@iogearbox.net>
Date: Mon, 1 Jul 2024 17:39:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624120533.873789-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27323/Mon Jul  1 10:40:06 2024)

On 6/24/24 2:05 PM, Tengda Wu wrote:
> When loading a EXT program without specifying `attr->attach_prog_fd`,
> the `prog->aux->dst_prog` will be null. At this time, calling
> resolve_prog_type() anywhere will result in a null pointer dereference.
> 
> Example stack trace:
> 
> [    8.107863] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> [    8.108262] Mem abort info:
> [    8.108384]   ESR = 0x0000000096000004
> [    8.108547]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    8.108722]   SET = 0, FnV = 0
> [    8.108827]   EA = 0, S1PTW = 0
> [    8.108939]   FSC = 0x04: level 0 translation fault
> [    8.109102] Data abort info:
> [    8.109203]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    8.109399]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    8.109614]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    8.109836] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101354000
> [    8.110011] [0000000000000004] pgd=0000000000000000, p4d=0000000000000000
> [    8.112624] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    8.112783] Modules linked in:
> [    8.113120] CPU: 0 PID: 99 Comm: may_access_dire Not tainted 6.10.0-rc3-next-20240613-dirty #1
> [    8.113230] Hardware name: linux,dummy-virt (DT)
> [    8.113390] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    8.113429] pc : may_access_direct_pkt_data+0x24/0xa0
> [    8.113746] lr : add_subprog_and_kfunc+0x634/0x8e8
> [    8.113798] sp : ffff80008283b9f0
> [    8.113813] x29: ffff80008283b9f0 x28: ffff800082795048 x27: 0000000000000001
> [    8.113881] x26: ffff0000c0bb2600 x25: 0000000000000000 x24: 0000000000000000
> [    8.113897] x23: ffff0000c1134000 x22: 000000000001864f x21: ffff0000c1138000
> [    8.113912] x20: 0000000000000001 x19: ffff0000c12b8000 x18: ffffffffffffffff
> [    8.113929] x17: 0000000000000000 x16: 0000000000000000 x15: 0720072007200720
> [    8.113944] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> [    8.113958] x11: 0720072007200720 x10: 0000000000f9fca4 x9 : ffff80008021f4e4
> [    8.113991] x8 : 0101010101010101 x7 : 746f72705f6d656d x6 : 000000001e0e0f5f
> [    8.114006] x5 : 000000000001864f x4 : ffff0000c12b8000 x3 : 000000000000001c
> [    8.114020] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
> [    8.114126] Call trace:
> [    8.114159]  may_access_direct_pkt_data+0x24/0xa0
> [    8.114202]  bpf_check+0x3bc/0x28c0
> [    8.114214]  bpf_prog_load+0x658/0xa58
> [    8.114227]  __sys_bpf+0xc50/0x2250
> [    8.114240]  __arm64_sys_bpf+0x28/0x40
> [    8.114254]  invoke_syscall.constprop.0+0x54/0xf0
> [    8.114273]  do_el0_svc+0x4c/0xd8
> [    8.114289]  el0_svc+0x3c/0x140
> [    8.114305]  el0t_64_sync_handler+0x134/0x150
> [    8.114331]  el0t_64_sync+0x168/0x170
> [    8.114477] Code: 7100707f 54000081 f9401c00 f9403800 (b9400403)
> [    8.118672] ---[ end trace 0000000000000000 ]---
> 
> Fix this by adding dst_prog non-empty check in BPF_PROG_TYPE_EXT case
> when calling bpf_prog_load().
> 
> Note the BPF_PROG_TYPE_EXT type detection in libbpf also needs to be
> adapted by passing a valid attach_prog_fd, since an empty attach_prog_fd
> is no longer allowed when loading EXT program.
> 
> Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> Cc: stable@vger.kernel.org # v5.18+
> ---
> v2: Fix libbpf_probe_prog_types test failure reported by CI by adapting
> libbpf code. (thanks for jirka's reminder)
> 
> v1: https://lore.kernel.org/all/20240620060701.1465291-1-wutengda@huaweicloud.com/
> 
>   kernel/bpf/syscall.c          |  5 ++++-
>   tools/lib/bpf/libbpf_probes.c | 13 ++++++++++++-
>   2 files changed, 16 insertions(+), 2 deletions(-)

Could you pls make this a 3-patch series against bpf?

First patch is the kernel-only fix, 2nd patch is the libbpf one, and 3rd patch adds
a small BPF selftest for the BPF CI.

Thanks a lot,
Daniel

