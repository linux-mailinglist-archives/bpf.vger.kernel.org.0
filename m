Return-Path: <bpf+bounces-58213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B209AB71EF
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 18:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C4C3BC165
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8327C844;
	Wed, 14 May 2025 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwhKtINW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E12749EA;
	Wed, 14 May 2025 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241583; cv=none; b=ouaAH4I31+JTaZmbPIp8+2Ru0hDV6VCAzXrKI3fNkUAl5T/QpmnCF7eboDKbFhyIAGskMCvAVfX6E6KAU9HSYYIw8ayg2I0hSsVyqJMFFpEvDUrhfSX48N/TVrVzpQpMmKXr/SG6KN1Xx6NVsqNi9SjL8dlcdFNGoFBYF7j2e68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241583; c=relaxed/simple;
	bh=vFdlox5AM+LRnrs46sUSTn+lfv0I1rvpENIBrB2qpS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1KKenVNSJu6C53bjOEZVgQBhzGRVUi9v0bOvadHkyWOLjNpDmPdm2o4t4vIYvido8St0q7r7OGbwPPCrR6BylaiR+TYbXwRMqku5BzOo+WSMpNOj71VUFcXKuyCU9fwe8QI6Y0AwIUhHpGE8piEmSMsQxn+mZavS2V68hZCk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwhKtINW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C9C4CEE3;
	Wed, 14 May 2025 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747241583;
	bh=vFdlox5AM+LRnrs46sUSTn+lfv0I1rvpENIBrB2qpS4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NwhKtINWiGKm/FmoQsmoQiLsSbU1VzPaDLrY5G9r8Oj54eGpxDwBTBGrgLsRgisYN
	 qy94qJhbfAEFIzgeRrnaYcgFjDldLuhYNuth3bGx/3Gv4MiFIfAxCeufZsK53/con4
	 n2CS4dCtUshiogqe51ILj77ue6xVfY5Qh0npM5M3AKPNr3dT4BtKxLpYRfwyxsEIET
	 d01DV9nSqV8HUIKYDr6joxuZiHkhtC472OTgSdex34fJm+fD6R5Eutl+aaM1/hJw5/
	 Sj3wxubxd2031SpSjz3VlOmRWw96urklxN930guk7zqDjeNwirYMXh0MBRmc0fHIxH
	 iTuupvVZQYJPQ==
Message-ID: <988679f5-12ac-4288-87a9-bc0259bd0280@kernel.org>
Date: Wed, 14 May 2025 17:52:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for custom BTF path in
 prog load/loadall
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250513035853.75820-1-jiayuan.chen@linux.dev>
 <CAADnVQJJ7pLsm0UTzPOj1H+rdaaY7Lv0As0Te-b+7zieQbntkw@mail.gmail.com>
 <4741dfb9fa4cf32cef28d9f2b7e7c2e788430800@linux.dev>
 <CAEf4BzZdAft9HUc2MOoQqC_SwkiBQgRTPZHB8MJmwVTY8N=sWQ@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEf4BzZdAft9HUc2MOoQqC_SwkiBQgRTPZHB8MJmwVTY8N=sWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-05-14 09:39 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Tue, May 13, 2025 at 6:51 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>
>> 2025/5/14 05:19, "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
>>
>>>
>>> On Mon, May 12, 2025 at 8:59 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>>
>>>>
>>>> This patch exposes the btf_custom_path feature to bpftool, allowing users
>>>>
>>>>  to specify a custom BTF file when loading BPF programs using prog load or
>>>>
>>>>  prog loadall commands. This feature is already supported by libbpf, and
>>>>
>>>>  this patch makes it accessible through the bpftool command-line interface.
>>>>
>>>>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>>>
>>>>  ---
>>>>
>>>>  tools/bpf/bpftool/prog.c | 11 ++++++++++-
>>>>
>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>>  diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>>>>
>>>>  index f010295350be..63f84e765b34 100644
>>>>
>>>>  --- a/tools/bpf/bpftool/prog.c
>>>>
>>>>  +++ b/tools/bpf/bpftool/prog.c
>>>>
>>>>  @@ -1681,8 +1681,17 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>>>>
>>>>  } else if (is_prefix(*argv, "autoattach")) {
>>>>
>>>>  auto_attach = true;
>>>>
>>>>  NEXT_ARG();
>>>>
>>>>  + } else if (is_prefix(*argv, "custom_btf")) {
>>>>
>>>>  + NEXT_ARG();
>>>>
>>>>  +
>>>>
>>>>  + if (!REQ_ARGS(1))
>>>>
>>>>  + goto err_free_reuse_maps;
>>>>
>>>>  +
>>>>
>>>>  + open_opts.btf_custom_path = GET_ARG();
>>>>
>>>
>>> I don't see a use case yet.
>>>
>>> What exactly is the scenario where it's useful ?
>>>
>>
>> This patch just exposes the btf_custom_path feature of libbpf to bpftool.
>> The argument 'btf_custom_path' in libbpf is used for those kernes that
>> don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform CO-RE
>> relocations. Specifically for older kernels, separate BTF files are already
>> provided: https://github.com/aquasecurity/btfhub-archive/.
>> If we want load prog using bpftool on those systems, we have to hack
>> btf__load_vmlinux_btf() before or write custom loader with libbpf and specify
>> 'btf_custom_path'.
>>
>> I also found a the similar topic:
>> https://lore.kernel.org/bpf/20220215225856.671072-1-mauricio@kinvolk.io/
>>
>> Additionally, pwru supports "--kernel-btf" which serves the same purpose as
>> this patch.
>>
>> Therefore, using an external BTF file is a common practice.
> 
> I think it's fine to expose this to bpftool. But maybe call the option
> "kernel_btf" to make it more obvious that this is BTF representing
> kernel types, as opposed to program BTF itself.


Hi Jiayuan, we'll also need to update the documentation (the man page,
in the summary at the top and in the subcommand description), the
interactive help message at the bottom of bpftool's prog.c, and the bash
completion (I can help with it if necessary), please.

Thanks,
Quentin

