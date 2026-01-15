Return-Path: <bpf+bounces-79104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D1D273E4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54D063021948
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C233D5221;
	Thu, 15 Jan 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAvR6Kv+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124803C0093
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499600; cv=none; b=MsxBQSQLrwOyYXe3qhAjUO1uK/CHCO0m3bG3ch+jjagQA4+ZvH5rPdfdIVsDVXS62e4xVGrukcA7wu6SDOWPH2Ftc8LYeFKHSxQxWE4RSM7JhokFK9inJIV951DLMjVEAXw7yzO1voDpL1nRgthj3QFJveOdxuZVjYeg43Hsun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499600; c=relaxed/simple;
	bh=nPG5yXJfz2Agy5znRvAPxsl9vqeLh4ZpWqffckBOuj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJROvnJYl+8nOckfPCYPfl4mJvh1mBh50bm88FGEdXsZiqnelajSSrV1CA5vqu6omSFUTynYPg24EAj/JhSxoLuIn+32xxyAMYsC1LE/IoUmnQ+yaSnSmMxxnm16rfNMDGF4XdfTxI+urbW2hvP69H27/WQQU4FTcZ1dlumNhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAvR6Kv+; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4327555464cso678813f8f.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768499597; x=1769104397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4mMVo9S2RYUGlBhey+x1Qw17Bc3i8C5ddylnQrDDufU=;
        b=nAvR6Kv++S5V0G5ouzkjOA8WooSfhQ/hFNWeZv4RmZhKHvDbcSEDHwZkIoIuSEj2xu
         WqDEimA9uBxGYgiceOhqKm+clIampK/7EArekA2blDmkwQy5eEjIdUtwj8zUHQ6Q7PQJ
         //r3HpfKXUVC+LIOSRgqmDWjM5SRAJGng6sVw/CBLJTdB+Jg3EpbFC0/ruSvJGbUgBcf
         Om5jOHwopGwQszkIfeRjXGYquwYJ8KadeNos9hHq2QZ8x20kqOkGem51HmoAUbVsh5rY
         yExy7fGIKQlZEYWyhp1BAJ7TX4uK5DP/34A8zXlnEa4dOx0qeCDOYdqjv8TDiNE/WjB4
         mxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768499597; x=1769104397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mMVo9S2RYUGlBhey+x1Qw17Bc3i8C5ddylnQrDDufU=;
        b=NaShhH5QXDoUeWhp9k1c+1tOVETcT9++TIOVCiie1pbvJFZV/qgCUzxLyRV5NlV01J
         hvr/5TzXNWhkZFta+fKPZx+kjzYp4tnW++9CmF72XqzUWMMNZ1w7Vu72RVd/KuqYdLAQ
         RsNyp0WsML64SaOWZLk/o3hsFDtQ0ReMYAHEb36pN86YVmMWNvaYfjRpG/D1eq2kvg/n
         9ZVK0w04UTxyNKz2KT1JSIc0REru7WV1e8UsQHV9KREMUb87D/RmDnGMsJRrbRQDXEKm
         u4UPLKCJMpXORBNKM4jLE8G4ez5oy1s2jdEDjX9sJCe3WxXUOLjRWxetH2DpBNXsiRUW
         PIWA==
X-Gm-Message-State: AOJu0YyVYy8hA9aeWIUAB5qWaiDhWK1fJ2QqlSsxzguonDTefXSqjfL0
	cMOC2DiZlbr05kzs/+rtqQluGeRXMCKE6HNBfNC+wzbI6kdCuaMCFvgsKSs/Jk1bn0XuiaAjfi2
	NuH5T0uMZi2xFrdg8s48fnnJx58NpK5c=
X-Gm-Gg: AY/fxX5kGeXVbPkKeT6pTT3RqyuQg3bgq8VaPD1jjk+MTHtvgipcMk0GQtpd4ne+rx/
	j58QL1zgGpvHcJIj/iKHkeSTxQ895lM1/oCXleWk6GvAIxDLIDe4JFJM0tTKafqDuy6Fn7TQL0y
	vHM+JhKX1HQSr8tlRTQ2n2Xdp/NMCqp6DleSKgQKyMKVLpE5ssZny1/HVr4DfZ7NHQ2NUCXW//D
	irpCSqwO3ktw6QlWKRCTB8XKNeU9N/E49BFbPjFBVOC/V56pTnunGsz/kg9DeNa/nFuHpkCkNVr
	Nj6QxQS/uWCWVI6uP3lvzbMqphX2tO/FZu2++DDPVqKT2+xRWNVSIE6IBRqt
X-Received: by 2002:adf:cf07:0:b0:42f:bbc6:edaf with SMTP id
 ffacd0b85a97d-43569bc02a4mr187188f8f.37.1768499597259; Thu, 15 Jan 2026
 09:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115061319.2895636-1-yonghong.song@linux.dev>
 <CAP01T75HfwbrZkRouGiuhfbFqMS4-LXh-nQ7ho=rJ-DZ44vCDA@mail.gmail.com> <be872fd4-479e-45e6-8832-9bfe560bced1@linux.dev>
In-Reply-To: <be872fd4-479e-45e6-8832-9bfe560bced1@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 15 Jan 2026 18:52:40 +0100
X-Gm-Features: AZwV_QgDKChsVkdWX4DQ-IMRIOYpEzwBLkRRXk5-bP-UQQLrQ79ENuTX-_kac8U
Message-ID: <CAP01T76Mamajg7HqF3rrUof-DMFLwgSaW5rTEUSyZ7rp2TsgVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix map_kptr test failure
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 18:19, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
>
> On 1/14/26 11:54 PM, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 15 Jan 2026 at 07:16, Yonghong Song <yonghong.song@linux.dev> wrote:
> >> On my arm64 machine, I get the following failure:
> >>    ...
> >>    tester_init:PASS:tester_log_buf 0 nsec
> >>    process_subtest:PASS:obj_open_mem 0 nsec
> >>    process_subtest:PASS:specs_alloc 0 nsec
> >>    serial_test_map_kptr:PASS:rcu_tasks_trace_gp__open_and_load 0 nsec
> >>    ...
> >>    test_map_kptr_success:PASS:map_kptr__open_and_load 0 nsec
> >>    test_map_kptr_success:PASS:test_map_kptr_ref1 refcount 0 nsec
> >>    test_map_kptr_success:FAIL:test_map_kptr_ref1 retval unexpected error: 2 (errno 2)
> >>    test_map_kptr_success:PASS:test_map_kptr_ref2 refcount 0 nsec
> >>    test_map_kptr_success:FAIL:test_map_kptr_ref2 retval unexpected error: 1 (errno 2)
> >>    ...
> >>    #201/21  map_kptr/success-map:FAIL
> >>
> >> In serial_test_map_kptr(), before test_map_kptr_success(), one
> >> kern_sync_rcu() is used to have some delay for freeing the map.
> >> But in my environment, one kern_sync_rcu() seems not enough and
> >> caused the test failure.
> >>
> >> In bpf_map_free_in_work() in syscall.c, the queue time for
> >>    queue_work(system_dfl_wq, &map->work)
> >> may be longer than expected. This may cause the test failure
> >> since test_map_kptr_success() expects all previous maps having been freed.
> >>
> >> In stead of one kern_sync_rcu() before test_map_kptr_success(),
> >> I added two more kern_sync_rcu() to have a longer delay and
> >> the test succeeded.
> >>
> >> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> > This is still not a proper fix, right? Maybe two works in this case,
> > but it isn't guaranteed to be enough either.
> > RCU gp wait won't have any synchronization with when wq items are executed.
> > I forgot why I used kern_sync_rcu() originally, but I feel the right
> > way to fix this would be to count when all maps have finished their
> > bpf_map_free through an fexit hook. Thoughts?
>
> Agree that this is still not to guarantee it won't break due to queue_work().
> One possibility is to count the references in a separate bpf program and until
> all references are gone then we can do subsequent test_map_kptr_success().
> Let me give a try.

That seems better actually, and probably less code too.

>
> >
> >>   tools/testing/selftests/bpf/prog_tests/map_kptr.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> >> index 8743df599567..f9cfc4d3153c 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> >> @@ -148,11 +148,15 @@ void serial_test_map_kptr(void)
> >>
> >>                  ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
> >>                  ASSERT_OK(kern_sync_rcu(), "sync rcu");
> >> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
> >> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
> >>                  /* Observe refcount dropping to 1 on bpf_map_free_deferred */
> >>                  test_map_kptr_success(false);
> >>
> >>                  ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
> >>                  ASSERT_OK(kern_sync_rcu(), "sync rcu");
> >> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
> >> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
> >>                  /* Observe refcount dropping to 1 on synchronous delete elem */
> >>                  test_map_kptr_success(true);
> >>          }
> >> --
> >> 2.47.3
> >>
> >>
>

