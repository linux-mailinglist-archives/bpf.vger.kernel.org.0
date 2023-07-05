Return-Path: <bpf+bounces-4047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C274842E
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D5A280F9F
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F9E6AB1;
	Wed,  5 Jul 2023 12:30:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F28BF9
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 12:30:57 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5059B0;
	Wed,  5 Jul 2023 05:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GVi1TMS//j0R9x4YBSPDer5nc/raADNyI7IoydbL/fs=; b=M/Uy5L1o50GeUIq3U1CAOXU3ST
	zebSjQq41yXqSiDy7W2y6tghGOak7DN6iJaq4lABzNwuzlHYGdMXY/mPe86XCpUAeZJAcTpUbrMT3
	AZTe4kEN++xlrbSfXEaKJiWDi0B/E6CKJ0zaQWVs+iGnLKmrvNdHFPT/3Vzq3HIVClUGFu98c0R30
	HI0qGBmYNc0/o7b+fITNPkZ/8onnfY42Tp6tt7WxjuBDrpowNXv0A3XxqVRvoDe5h1FdD1iuwFS1l
	XBEaIogF7vWJAsKOGyVLnbIk8GdJiBtiHcYEWcuVTen+m+fEkQj1AmiN9FabeIkjG0VITTYgg56R9
	QvP6whNA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH1ef-000IqT-HP; Wed, 05 Jul 2023 14:30:45 +0200
Received: from [178.197.249.31] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH1ee-000VT9-UI; Wed, 05 Jul 2023 14:30:44 +0200
Subject: Re: [PATCH v6 bpf-next 09/11] bpf: Support ->fill_link_info for
 perf_event
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
 rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20230628115329.248450-1-laoar.shao@gmail.com>
 <20230628115329.248450-10-laoar.shao@gmail.com>
 <e06b149e-2bcc-6a83-ef23-6216c7267632@iogearbox.net>
 <CALOAHbBhxF8S2x8h1b-2otu31u-eg3BuUHyMW3VWBezy6AgMtg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <941cbfe1-3284-fdea-6920-fcb251ba1c84@iogearbox.net>
Date: Wed, 5 Jul 2023 14:30:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALOAHbBhxF8S2x8h1b-2otu31u-eg3BuUHyMW3VWBezy6AgMtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/5/23 12:08 PM, Yafang Shao wrote:
> On Wed, Jul 5, 2023 at 4:47 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 6/28/23 1:53 PM, Yafang Shao wrote:
>>> By introducing support for ->fill_link_info to the perf_event link, users
>>> gain the ability to inspect it using `bpftool link show`. While the current
>>> approach involves accessing this information via `bpftool perf show`,
>>> consolidating link information for all link types in one place offers
>>> greater convenience. Additionally, this patch extends support to the
>>> generic perf event, which is not currently accommodated by
>>> `bpftool perf show`. While only the perf type and config are exposed to
>>> userspace, other attributes such as sample_period and sample_freq are
>>> ignored. It's important to note that if kptr_restrict is not permitted, the
>>> probed address will not be exposed, maintaining security measures.
>>>
>>> A new enum bpf_perf_event_type is introduced to help the user understand
>>> which struct is relevant.
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
[...]
>>>
>>> +enum bpf_perf_event_type {
>>> +     BPF_PERF_EVENT_UNSPEC = 0,
>>> +     BPF_PERF_EVENT_UPROBE = 1,
>>> +     BPF_PERF_EVENT_URETPROBE = 2,
>>> +     BPF_PERF_EVENT_KPROBE = 3,
>>> +     BPF_PERF_EVENT_KRETPROBE = 4,
>>> +     BPF_PERF_EVENT_TRACEPOINT = 5,
>>> +     BPF_PERF_EVENT_EVENT = 6,
>>
>> Why explicitly defining the values of the enum?
> 
> With these newly introduced enums, the user can easily identify what
> kind of perf_event link it is
> See also the discussion:
> https://lore.kernel.org/bpf/CAEf4BzYEwCZ3J51pFnUfGykEAHtdLwB8Kxi0utvUTVvewz4UCg@mail.gmail.com/

No objections to that. I was more wondering why explicitly stating the
numbers here, but I presume it's for quick readability.. looks like in
some of the uapi enums we do it, in some others we don't; fair enough.

Thanks,
Daniel

