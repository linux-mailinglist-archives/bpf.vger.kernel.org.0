Return-Path: <bpf+bounces-61207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66832AE231A
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 21:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE881896636
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD81F22B8BE;
	Fri, 20 Jun 2025 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VgxayH6b"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833602E06C7
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449292; cv=none; b=tpFriZvvy92Wmu536gCiRdIHJ4Tu37VUPMKZgyqDYKsyKobnJLYkIaG0ViYUNApTXVsHYc6t7MCsSb3rFVWZ7W55UUYEB8Uj4s/KlMhEbYOYcEYvlXCmeynscLbKcCcj4ietg8cOE5bcesAcEB3IhlUBDNDEEklFkwSxvgFmV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449292; c=relaxed/simple;
	bh=gwW/ZJH1VLIkz6MGwVX4aHnvXoTlVx/vj9jo9qbl9zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3qXNBb1JvRVv2ut913bA/NI1EGkAzF4w3nmk9pM4R4hyIDcYbxBBYLModsGz4Fvko+QGuxPbKj6n/AVV5H6DF2LlOx4fonS1AieStLJ63/y2t5ZBcd8SDhP4ux9vMlBYwH37nV6E1czg2/VK6YHWGxyy0Yv2sRrxRVcA5/uFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VgxayH6b; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ff84c99-46a2-4dde-a1f4-f49b09b0b15f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750449278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9890C/fAgtvvt0ndaoyPFp5S+6tCMCjaOU36i0zlJk=;
	b=VgxayH6bRXn9jSnHSGefKyUi69i6ZbZ1L2hKf+wfXjXRHL5Peg5g2TxObTti+rt28g2NUr
	BRiLjX9Ne+JoQOQy0iykdbVrDVjTb9fVLsqrTxwC0pFXvDJS8S/cX1rnb53Bmfh4gxSqwI
	S6a6ddIFT7t8OsyGaKDNe6uhnID9Jf8=
Date: Sat, 21 Jun 2025 03:54:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add load_time in bpf_prog fdinfo
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250620051017.111559-1-chen.dylane@linux.dev>
 <CAADnVQLd9Z1nfp+WBdMLaZ7EP-+A9QEDdOhZaL0YTaygtKD2Hg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQLd9Z1nfp+WBdMLaZ7EP-+A9QEDdOhZaL0YTaygtKD2Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/21 02:27, Alexei Starovoitov 写道:
> On Thu, Jun 19, 2025 at 10:10 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> The field run_time_ns can tell us the run time of the bpf_prog,
>> and load_time_s can tell us how long the bpf_prog loaded on the
>> machine.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/syscall.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 51ba1a7aa43..407841ea296 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -2438,6 +2438,7 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
>>          const struct bpf_prog *prog = filp->private_data;
>>          char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
>>          struct bpf_prog_kstats stats;
>> +       u64 now = ktime_get_boottime_ns();
>>
>>          bpf_prog_get_stats(prog, &stats);
>>          bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
>> @@ -2450,7 +2451,8 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
>>                     "run_time_ns:\t%llu\n"
>>                     "run_cnt:\t%llu\n"
>>                     "recursion_misses:\t%llu\n"
>> -                  "verified_insns:\t%u\n",
>> +                  "verified_insns:\t%u\n"
>> +                  "load_time_s:\t%llu\n",
>>                     prog->type,
>>                     prog->jited,
>>                     prog_tag,
>> @@ -2459,7 +2461,8 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
>>                     stats.nsecs,
>>                     stats.cnt,
>>                     stats.misses,
>> -                  prog->aux->verified_insns);
>> +                  prog->aux->verified_insns,
>> +                  (now - prog->aux->load_time) / NSEC_PER_SEC);
> 
> I don't like where it's going.
> Soon fdinfo will be printing the xlated insns of the prog too,
> since why not?
> Let's stop here. We have syscall query api-s for that and
> bpftool to print such things.
> No more fdinfo "improvements".

Got it, Alexei, thanks for your patient explanation.

-- 
Best Regards
Tao Chen

