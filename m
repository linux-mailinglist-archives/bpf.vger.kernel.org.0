Return-Path: <bpf+bounces-48153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E568CA04935
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A257A264C
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC801F03C5;
	Tue,  7 Jan 2025 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vfSpNxBJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969E1F37BC
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274561; cv=none; b=o8Sqzqf+3gSoLPGE67iUKmpk/K3uj8V7G8qnMRR2d6gejaEjEr9ZZX8ztmnRMhnMxJJpSPU7u6ay5BI/91xYjxm1dF6xB+LB17Rt018CrCoH46tcgTEHsA2LpZMC7gS+E3XGM/UlXuaVobkL1OLVZB9Gkpxjb0oR18ZnrNmxpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274561; c=relaxed/simple;
	bh=5oMwt8MqHzoaGlSoK7LJTBv01YeyvD62Wahn82nfuHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pp6m2s8Jxbt5xCkyyjYWrD1G0YLvyCfxf9pysFq2uitAKfjByZNPNrHi3ptfxIAlTswuGx+bIB//ZHcpOqxQWSzHTKG46RnRIJ04PTI9PP5TrpD3S6S+4NoCijumU9cBAzJL7ur1rK2G+LTYq1138VpZq7u3RdY0IYZ+5lqde5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vfSpNxBJ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fcb4cbb5-d9b7-47fb-b300-e2227223e882@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736274555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tv3UyEYHyZHZTg32H2UgwakeJv09LkurzQja7F+O5X4=;
	b=vfSpNxBJMgfUym57P4jZzKYApOOugkmNJk9rJ+cINFMrTJ9Uu4BJrqU/9ibnLyvazS3TN1
	9dlfqaH9e4zcU0qyOKYafnGdivZo0Zr8edS+JZfU3j8JcdDaBu4GYm/5VupODAkN5fVGNR
	mCS8HUdjRiEyGTvZTMNwwkx7binTGWg=
Date: Tue, 7 Jan 2025 10:29:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add unique_match option for multi
 kprobe
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Jordan Rome <linux@jordanrome.com>
References: <20241218225246.3170300-1-yonghong.song@linux.dev>
 <CAEf4BzaJ3cF+StkPoANKDY3q-5Y-vuvEpcWVTq0zvom1mmFbaw@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaJ3cF+StkPoANKDY3q-5Y-vuvEpcWVTq0zvom1mmFbaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 1/6/25 4:24 PM, Andrii Nakryiko wrote:
> On Wed, Dec 18, 2024 at 2:53 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Jordan reported an issue in Meta production environment where func
>> try_to_wake_up() is renamed to try_to_wake_up.llvm.<hash>() by clang
>> compiler at lto mode. The original 'kprobe/try_to_wake_up' does not
>> work any more since try_to_wake_up() does not match the actual func
>> name in /proc/kallsyms.
>>
>> There are a couple of ways to resolve this issue. For example, in
>> attach_kprobe(), we could do lookup in /proc/kallsyms so try_to_wake_up()
>> can be replaced by try_to_wake_up.llvm.<hach>(). Or we can force users
>> to use bpf_program__attach_kprobe() where they need to lookup
>> /proc/kallsyms to find out try_to_wake_up.llvm.<hach>(). But these two
>> approaches requires extra work by either libbpf or user.
>>
>> Luckily, suggested by Andrii, multi kprobe already supports wildcard ('*')
>> for symbol matching. In the above example, 'try_to_wake_up*' can match
>> to try_to_wake_up() or try_to_wake_up.llvm.<hash>() and this allows
>> bpf prog works for different kernels as some kernels may have
>> try_to_wake_up() and some others may have try_to_wake_up.llvm.<hash>().
>>
>> The original intention is to kprobe try_to_wake_up() only, so an optional
>> field unique_match is added to struct bpf_kprobe_multi_opts. If the
>> field is set to true, the number of matched functions must be one.
>> Otherwise, the attachment will fail. In the above case, multi kprobe
>> with 'try_to_wake_up*' and unique_match preserves user functionality.
>>
>> Reported-by: Jordan Rome <linux@jordanrome.com>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c | 10 +++++++++-
>>   tools/lib/bpf/libbpf.h |  4 +++-
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 66173ddb5a2d..649c6e92972a 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -11522,7 +11522,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>>          struct bpf_link *link = NULL;
>>          const unsigned long *addrs;
>>          int err, link_fd, prog_fd;
>> -       bool retprobe, session;
>> +       bool retprobe, session, unique_match;
>>          const __u64 *cookies;
>>          const char **syms;
>>          size_t cnt;
>> @@ -11558,6 +11558,14 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>>                          err = libbpf_available_kallsyms_parse(&res);
>>                  if (err)
>>                          goto error;
>> +
>> +               unique_match = OPTS_GET(opts, unique_match, false);
>> +               if (unique_match && res.cnt != 1) {
>> +                       pr_warn("prog '%s': failed to find unique match: cnt %lu\n",
>> +                               prog->name, res.cnt);
>> +                       return libbpf_err_ptr(-EINVAL);
> goto error, leaking resources here

Ack. Will fix.

>
>
> we should also think about interaction of unique_match interaction for
> !pattern case, and either reject it (if it makes no sense), or enforce
> it (if it does, I haven't really thought about which case do we have)

The unique_match only makes sense for pattern case. So I suggest to
reject the case unique_match && !pattern. WDYT?

>
> pw-bot: cr
>
>> +               }
>> +
>>                  addrs = res.addrs;
>>                  cnt = res.cnt;
>>          }
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index d45807103565..3020ee45303a 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -552,10 +552,12 @@ struct bpf_kprobe_multi_opts {
>>          bool retprobe;
>>          /* create session kprobes */
>>          bool session;
>> +       /* enforce unique match */
>> +       bool unique_match;
>>          size_t :0;
>>   };
>>
>> -#define bpf_kprobe_multi_opts__last_field session
>> +#define bpf_kprobe_multi_opts__last_field unique_match
>>
>>   LIBBPF_API struct bpf_link *
>>   bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>> --
>> 2.43.5
>>


