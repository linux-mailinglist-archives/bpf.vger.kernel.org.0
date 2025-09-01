Return-Path: <bpf+bounces-67072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03C1B3D6B8
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 04:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54133BA333
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4811DF26B;
	Mon,  1 Sep 2025 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cnsb7636"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521422301
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756694331; cv=none; b=kU7ICxP51vn4yk9A7DdI4vCv/6Q5AdOAEHsp3+XY+FJbV7jigMFyRbwVxV1u+HbCjkHB9o7pHhqSDv/JeE31iGKL5JiBSeO/fJTKJbR2/OsV+6gc70105EtkKMmslD/WsphVGdf4whrndqEDLmv023Ohn3KO5mBveuZxzkiOzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756694331; c=relaxed/simple;
	bh=gn828wWDLw2jhxPs6te5MWoCfNRpQhTwNDR3AWQg700=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QymM3uLFJyeUzU/jDZWf039ILnwxW5Z6PrXh4J6+N21/IgOnQ+hx6Fi32Lr1ZXojCNN4/qzgg+89FDprdFJ4BEmRYD4eU4SI7fMb4LfE1jxt9CAs2IP1LffoDfL18q0O9tgBGtYM4W3rPs1qw10y6LMcwWoYStOTu3rUfiKV+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cnsb7636; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f024210f-88f6-45db-a562-4a35ec0056e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756694327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9M0qT6iiTLhoE8/5LIztWiaxc29Qy3RwYuOUEALl04=;
	b=Cnsb7636crrNxOrFp6GLmqP6wQ6Q4BWEi9/jHtQnZWSBmTGtYQunHscFJK6QyAY5Yzy+z9
	+bkZ2ZuJoQat4xI3ncPz76YWMskPgW9Y9KsLpnv0s+aDwipYuyrCGR7e/d+muXXooEj4e6
	5T9NNlk0zINRO0umDru8LCtzpNmbha8=
Date: Mon, 1 Sep 2025 10:38:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leon Hwang <hffilwlqm@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
 <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
 <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev>
 <CAADnVQLDG=Oavh9He=ivXm9MPwsqWHttbTYQh1-EZuHpwujaBA@mail.gmail.com>
 <b3463ffa-c2cb-43c8-a0d2-92bad49e3c23@linux.dev>
 <93e75cff-871f-4b49-868c-11fea0eec396@paulmck-laptop>
 <DCE3PPX8IFF4.FE1BC8HMP4Y7@linux.dev>
 <CAADnVQ+G73vyC77tSo3AFcBT5FiBFbojfddnpYi5yRcqOxQiDQ@mail.gmail.com>
 <8ab6e14b-e639-413e-91cc-56dc02d1a4fb@paulmck-laptop>
 <42f91ff0-b7bf-4ab8-90fe-4ce42eb6bb75@gmail.com>
 <CAADnVQL=c4B3yT18DfFP9ecgd3BL6HvnUU31Wcn0in_3+a--=g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQL=c4B3yT18DfFP9ecgd3BL6HvnUU31Wcn0in_3+a--=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 30/8/25 02:08, Alexei Starovoitov wrote:
> On Thu, Aug 28, 2025 at 7:21 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>>
>>>> Independently it would be good to make noinstr/notrace to include __cpuidle
>>>> functions. I think right now it's allowed to attach to default_idle()
>>>> which is causing issues.
>>
>> Nope.
>> ./bpfsnoop -k 'default_idle' -k '__cpuidle' --show-func-proto
>> void default_idle();
> 
> hmm. indeed.
> 
> Jiri,
> 
> why do we still have this in selftest ?
> 
> static bool skip_entry(char *name)
> {
>         /*
>          * We attach to almost all kernel functions and some of them
>          * will cause 'suspicious RCU usage' when fprobe is attached
>          * to them. Filter out the current culprits - arch_cpu_idle
>          * default_idle and rcu_* functions.
>          */
>         if (!strcmp(name, "arch_cpu_idle"))
>                 return true;
>         if (!strcmp(name, "default_idle"))
>                 return true;

After removing "arch_cpu_idle" and "default_idle", it's OK to run the
selftest:

./test_progs -t kprobe_multi_test
#155/1   kprobe_multi_test/skel_api:OK
#155/2   kprobe_multi_test/link_api_addrs:OK
#155/3   kprobe_multi_test/link_api_syms:OK
#155/4   kprobe_multi_test/attach_api_pattern:OK
#155/5   kprobe_multi_test/attach_api_addrs:OK
#155/6   kprobe_multi_test/attach_api_syms:OK
#155/7   kprobe_multi_test/attach_api_fails:OK
#155/8   kprobe_multi_test/attach_override:OK
#155/9   kprobe_multi_test/session:OK
#155/10  kprobe_multi_test/session_cookie:OK
#155/11  kprobe_multi_test/unique_match:OK
#155/12  kprobe_multi_test/kprobe_session_return_0:OK
#155/13  kprobe_multi_test/kprobe_session_return_1:OK
#155/14  kprobe_multi_test/kprobe_session_return_2:OK
#155     kprobe_multi_test:OK
#156/1   kprobe_multi_testmod_test/testmod_attach_api_syms:OK
#156/2   kprobe_multi_testmod_test/testmod_attach_api_addrs:OK
#156     kprobe_multi_testmod_test:OK
Summary: 2/16 PASSED, 0 SKIPPED, 0 FAILED

Thanks,
Leon


