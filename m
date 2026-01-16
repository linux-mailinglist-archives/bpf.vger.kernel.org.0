Return-Path: <bpf+bounces-79194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FE7D2CC71
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C37E3037512
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 06:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549234EF06;
	Fri, 16 Jan 2026 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SVVwXrbJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775A34E764
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546449; cv=none; b=P6MLLZYIeF+p65+lyp7w8scGy3gBJoybktvHaAMXGWXif88DWts+6NpjxVLmJ6Q/++L+BYyye/sVxmBBObCp+TP+UQVlEhayZts05evwroOO+PZqA8JBGDVpHCN2LYL26ra3Z+fBlIFqMgPH1f8blJx7LJXGDouC1TSkw6ZvaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546449; c=relaxed/simple;
	bh=iNXSVtXVGwVcIzlCczPYO67hJ+0mDEcHtiHXdsTpaWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbaIF1yJf8O+HFWtMIHPSAg+rdBxsBy7mpHkkU6jvu50Aml1gtzKAL1QQs+8x3DebVXgW+5HLsePA3Sv+5jX1ewSbcWCXDDZJberZkAW0boptkBTC83rrejxmu2pl9WrbtgVnFqU5i16us/p3pvkv2CkFtGKpsX4+p3isHnIy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SVVwXrbJ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768546445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVZbVkStdM/Vi4xRUe/yLCSuJE5YhqrOOiVWak7xjA4=;
	b=SVVwXrbJIagWmkqrWVjUgnjGvKh2SWbDHv1EwVEeMJz8dNyokR0szeJtRzoVPgeWUbiOj5
	aJqQ/6rdOhKtbSUEY3MDnEl502zYNhaWCrnScBA1EwXR+VSkpb6QdmWncvcl8Vgg/YFL1G
	TBZ7fGIyTN5bry+YkgqXH9/cYj30uyw=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, ast@kernel.org, bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next 2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
Date: Fri, 16 Jan 2026 14:53:47 +0800
Message-ID: <5957081.DvuYhMxLoT@7940hx>
In-Reply-To:
 <379dc407b6e024b766ad40bfb899f8f6ce92e869d23c748275d0c054d62a569a@mail.kernel.org>
References:
 <20260116035024.98214-3-dongml2@chinatelecom.cn>
 <379dc407b6e024b766ad40bfb899f8f6ce92e869d23c748275d0c054d62a569a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/16 12:09 bot+bpf-ci@kernel.org write:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> > index 64a9c95d4acf..848fab952719 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> > @@ -33,6 +33,7 @@ void test_get_func_args_test(void)
> >
> >  	ASSERT_EQ(topts.retval >> 16, 1, "test_run");
> >  	ASSERT_EQ(topts.retval & 0xffff, 1234 + 29, "test_run");
> > +	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
> >
> >  	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
> >  	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
> >  	ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
> >  	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
> 
> The trigger_module_test_read() call fires the new tracepoints which run the
> tp_test1 and tp_test2 BPF programs. These programs set test5_result and
> test6_result respectively. However, there are no assertions here to verify
> that test5_result and test6_result equal 1.
> 
> Should there be:
> 
>     ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
>     ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
> 
> Without these assertions, the test will pass even if the tp_btf
> bpf_get_func_arg() functionality is broken.

You are totally right, my bad :/

> 
> > diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> 
> [ ... ]
> 
> > +__u64 test5_result = 0;
> > +SEC("tp_btf/bpf_testmod_fentry_test1_tp")
> > +int BPF_PROG(tp_test1)
> > +{
> 
> [ ... ]
> 
> > +__u64 test6_result = 0;
> > +SEC("tp_btf/bpf_testmod_fentry_test2_tp")
> > +int BPF_PROG(tp_test2)
> > +{
> 
> These result variables are set by the BPF programs but never checked in the
> test driver, as noted above.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21055137351
> 





