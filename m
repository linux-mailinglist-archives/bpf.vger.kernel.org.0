Return-Path: <bpf+bounces-7176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B867729DF
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960A9281371
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBEF111AA;
	Mon,  7 Aug 2023 15:54:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DB111A1
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 15:54:52 +0000 (UTC)
Received: from out-112.mta0.migadu.com (out-112.mta0.migadu.com [IPv6:2001:41d0:1004:224b::70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4600410F0
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 08:54:49 -0700 (PDT)
Message-ID: <eeb4290b-e2b1-b123-e6a8-583c5d9db73e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691423687; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hhvz+MWzCWvA9/WvuNFCNlsC8DVef+xspw0bNhOGg1c=;
	b=WGCAHoeJhdAni3B1Sw62fNg04SfCg36Nz+dhTAs5bOBfJQzWz1zyCyLfJw60wf+gnyuEyI
	SgB9ofWc7nys1gzgxYzBbS9z4MplYy4raOuAfLbm/6lg0TvIhB40ucT4UFgs3qzesjZVOm
	PvDJeb/gXPgeSBnLhByomeRsVsfrg8Y=
Date: Mon, 7 Aug 2023 08:54:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv3 bpf-next 1/3] bpf: Add support for bpf_get_func_ip
 helper for uprobe program
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20230807085956.2344866-1-jolsa@kernel.org>
 <20230807085956.2344866-2-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230807085956.2344866-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/7/23 1:59 AM, Jiri Olsa wrote:
> Adding support for bpf_get_func_ip helper for uprobe program to return
> probed address for both uprobe and return uprobe.
> 
> We discussed this in [1] and agreed that uprobe can have special use
> of bpf_get_func_ip helper that differs from kprobe.
> 
> The kprobe bpf_get_func_ip returns:
>    - address of the function if probe is attach on function entry
>      for both kprobe and return kprobe
>    - 0 if the probe is not attach on function entry
> 
> The uprobe bpf_get_func_ip returns:
>    - address of the probe for both uprobe and return uprobe
> 
> The reason for this semantic change is that kernel can't really tell
> if the probe user space address is function entry.
> 
> The uprobe program is actually kprobe type program attached as uprobe.
> One of the consequences of this design is that uprobes do not have its
> own set of helpers, but share them with kprobes.
> 
> As we need different functionality for bpf_get_func_ip helper for uprobe,
> I'm adding the bool value to the bpf_trace_run_ctx, so the helper can
> detect that it's executed in uprobe context and call specific code.
> 
> The is_uprobe bool is set as true in bpf_prog_run_array_sleepable, which
> is currently used only for executing bpf programs in uprobe.
> 
> Renaming bpf_prog_run_array_sleepable to bpf_prog_run_array_uprobe
> to address that it's only used for uprobes and that it sets the
> run_ctx.is_uprobe as suggested by Yafang Shao.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> [1] https://lore.kernel.org/bpf/CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

