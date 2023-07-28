Return-Path: <bpf+bounces-6159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD66276636F
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFEF1C217C4
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 04:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921225245;
	Fri, 28 Jul 2023 04:53:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E95666
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 04:53:50 +0000 (UTC)
X-Greylist: delayed 37822 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 21:53:48 PDT
Received: from out-82.mta0.migadu.com (out-82.mta0.migadu.com [IPv6:2001:41d0:1004:224b::52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21292733
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 21:53:48 -0700 (PDT)
Message-ID: <63b0b09e-6c9c-e8b8-e652-3025752ede4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690520026; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InqwdIcfVAyYuJ+K9Kdq0oEqvoqECYToKPzQzvOM1TU=;
	b=qxgwLfvYO0UIjS2jf1xsZ7KghfNQuwkO4PKG1PA2vf4hmg6P3esPpBa1Op3eIC0aLJZqFc
	jZJDMLyuaCX9GJuB7bDLZOEIXq35LcYzDM7FidvmEwll04iGoiZsacZ2kOBvX/+9wsGG/b
	1uriK3lxd3HeMrcJh4Baz/WtH9PTUgo=
Date: Thu, 27 Jul 2023 21:53:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next] bpf/memalloc: Non-atomically allocate
 freelist during prefill
Content-Language: en-US
To: YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Hou Tao <houtao@huaweicloud.com>
References: <20230728043359.3324347-1-zhuyifei@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230728043359.3324347-1-zhuyifei@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/27/23 9:33 PM, YiFei Zhu wrote:
> In internal testing of test_maps, we sometimes observed failures like:
>    test_maps: test_maps.c:173: void test_hashmap_percpu(unsigned int, void *):
>      Assertion `bpf_map_update_elem(fd, &key, value, BPF_ANY) == 0' failed.
> where the errno is ENOMEM. After some troubleshooting and enabling
> the warnings, we saw:
>    [   91.304708] percpu: allocation failed, size=8 align=8 atomic=1, atomic alloc failed, no space left
>    [   91.304716] CPU: 51 PID: 24145 Comm: test_maps Kdump: loaded Tainted: G                 N 6.1.38-smp-DEV #7
>    [   91.304719] Hardware name: Google Astoria/astoria, BIOS 0.20230627.0-0 06/27/2023
>    [   91.304721] Call Trace:
>    [   91.304724]  <TASK>
>    [   91.304730]  [<ffffffffa7ef83b9>] dump_stack_lvl+0x59/0x88
>    [   91.304737]  [<ffffffffa7ef83f8>] dump_stack+0x10/0x18
>    [   91.304738]  [<ffffffffa75caa0c>] pcpu_alloc+0x6fc/0x870
>    [   91.304741]  [<ffffffffa75ca302>] __alloc_percpu_gfp+0x12/0x20
>    [   91.304743]  [<ffffffffa756785e>] alloc_bulk+0xde/0x1e0
>    [   91.304746]  [<ffffffffa7566c02>] bpf_mem_alloc_init+0xd2/0x2f0
>    [   91.304747]  [<ffffffffa7547c69>] htab_map_alloc+0x479/0x650
>    [   91.304750]  [<ffffffffa751d6e0>] map_create+0x140/0x2e0
>    [   91.304752]  [<ffffffffa751d413>] __sys_bpf+0x5a3/0x6c0
>    [   91.304753]  [<ffffffffa751c3ec>] __x64_sys_bpf+0x1c/0x30
>    [   91.304754]  [<ffffffffa7ef847a>] do_syscall_64+0x5a/0x80
>    [   91.304756]  [<ffffffffa800009b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> This makes sense, because in atomic context, percpu allocation would
> not create new chunks; it would only create in non-atomic contexts.
> And if during prefill all precpu chunks are full, -ENOMEM would
> happen immediately upon next unit_alloc.
> 
> Prefill phase does not actually run in atomic context, so we can
> use this fact to allocate non-atomically with GFP_KERNEL instead
> of GFP_NOWAIT. This avoids the immediate -ENOMEM.
> 
> GFP_NOWAIT has to be used in unit_alloc when bpf program runs
> in atomic context. Even if bpf program runs in non-atomic context,
> in most cases, rcu read lock is enabled for the program so
> GFP_NOWAIT is still needed. This is often also the case for
> BPF_MAP_UPDATE_ELEM syscalls.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

