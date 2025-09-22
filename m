Return-Path: <bpf+bounces-69168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63182B8EC22
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 04:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BE417BA2B
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 02:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EFA2EF653;
	Mon, 22 Sep 2025 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LV1B0/r9"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53632EDD53;
	Mon, 22 Sep 2025 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507393; cv=none; b=kuYmIA7IdgSo5ATX9tqiqq7gZCtsdycyGDOyfn0Oh/CgO0OE8J+uGVZo2ENErd8yNe+4I/ccnh2TFu+soNGHV5OgANNY9KLCEJ+PXOmMEJkSdFUo0HOdwT7yKCgVl+mRz5rvonvGuHGte8ozdzrVCtp2tqCByb73VAvOuuJCOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507393; c=relaxed/simple;
	bh=S+MrxK+D7iPGMmAzNAjmCE60veWJAjG6P4Xgv8bSqOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gK0vgAxXuVWxf6Ra8keXwYb+SzpKZscBnl+h96xuGZWzOu8uIYjh0mR/CdlFwmXRI9Y/YM2W02qtA9gDvckVZNb5dzurVCr/lDODJvePjowfLMuYyGcl93XWbUoJyQQkiUPVWlC0O2hyAp5YELz00wGIFdDlje5qaNVZk4S0rE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LV1B0/r9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GI
	Nukv/QL9unHjw23yOGGLZ/mpVpJgP94ErHeVgoy0A=; b=LV1B0/r9o066QDOKKX
	vJrOUr+lmS3cUYjHSB8kvc/prrZKQmHwILPgunEMHjWG3BVf6j3nddYRoIZlATld
	qk/npg8pxD6CiVAbBOFusXb1ddYmgAvlPRuYPJFcka3h1o7wY2QFzWJooUqIdClI
	NqqW5iDWnjDw41J0VC4gAQgjk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3PyFDsdBo1NKIDw--.13102S2;
	Mon, 22 Sep 2025 10:15:33 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: mhiramat@kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64 architecture
Date: Mon, 22 Sep 2025 10:15:31 +0800
Message-Id: <20250922021531.105670-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250921223037.f8df26b59d60b8b3f7cf2d53@kernel.org>
References: <20250921223037.f8df26b59d60b8b3f7cf2d53@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3PyFDsdBo1NKIDw--.13102S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4fJFWDAFy8Kr1xCFW7Arb_yoW5XrWrpF
	n0yF1ayrs5Zr47t3sFgr45XF1S9rs3ZryUCFyrKr1akFnrXr93XFyxKF1Y9Fn3urs09w4a
	y3W2y3sIk395Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pROeOLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbipQzPeGjP9KL64AABs0

On Sun, 21 Sep 2025 22:30:37 +0900 Masami Hiramatsu wrote:

> On Fri, 19 Sep 2025 19:56:20 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > On Fri, Sep 19, 2025 at 12:19 AM Feng Yang <yangfeng59949@163.com> wrote:
> > >
> > > When I use bpf_program__attach_kprobe_multi_opts to hook a BPF program that contains the bpf_get_stackid function on the arm64 architecture,
> > > I find that the stack trace cannot be obtained. The trace->nr in __bpf_get_stackid is 0, and the function returns -EFAULT.
> > >
> > > For example:
> > > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > index 9e1ca8e34913..844fa88cdc4c 100644
> > > --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > @@ -36,6 +36,15 @@ __u64 kretprobe_test6_result = 0;
> > >  __u64 kretprobe_test7_result = 0;
> > >  __u64 kretprobe_test8_result = 0;
> > >
> > > +typedef __u64 stack_trace_t[2];
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > > +       __uint(max_entries, 1024);
> > > +       __type(key, __u32);
> > > +       __type(value, stack_trace_t);
> > > +} stacks SEC(".maps");
> > > +
> > >  static void kprobe_multi_check(void *ctx, bool is_return)
> > >  {
> > >         if (bpf_get_current_pid_tgid() >> 32 != pid)
> > > @@ -100,7 +109,9 @@ int test_kretprobe(struct pt_regs *ctx)
> > >  SEC("kprobe.multi")
> > >  int test_kprobe_manual(struct pt_regs *ctx)
> > >  {
> > > +       int id = bpf_get_stackid(ctx, &stacks, 0);
> > 
> > ftrace_partial_regs() supposed to work on x86 and arm64,
> > but since multi-kprobe is the only user...
> 
> It should be able to unwind stack. It saves sp, pc, lr, fp.
> 
> 	regs->sp = afregs->sp;
> 	regs->pc = afregs->pc;
> 	regs->regs[29] = afregs->fp;
> 	regs->regs[30] = afregs->lr;
> 
> > I suspect the arm64 implementation wasn't really tested.
> > Or maybe there is some other issue.
> 
> It depends on how bpf_get_stackid() works. Some registers for that
> function may not be saved.
> 
> If it returns -EFAULT, the get_perf_callchain() returns NULL.
> 

During my test, the reason for returning -EFAULT was that trace->nr was 0.

static long __bpf_get_stackid(struct bpf_map *map,
			      struct perf_callchain_entry *trace, u64 flags)
{
	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
	u32 hash, id, trace_nr, trace_len;
	bool user = flags & BPF_F_USER_STACK;
	u64 *ips;
	bool hash_matches;

	if (trace->nr <= skip)
		/* skipping more than usable stack trace */
		return -EFAULT;
	......
}

thanks


