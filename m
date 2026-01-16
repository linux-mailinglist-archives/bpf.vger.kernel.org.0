Return-Path: <bpf+bounces-79342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BABD3883C
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 22:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1CDA303490D
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ECD2FB09A;
	Fri, 16 Jan 2026 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I9rQHYWH"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121C286D5D
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598292; cv=none; b=o5qY0V9X/ZRH9u0n6j/T05SVTp7KBPD93X9bJet0vqaNszXKaREUwcUHx5m1onNXw1nLBiW3zw3EQmbeXamcEzWpQeI70iTtd18rRTcsPnjZjPU+2rv2U+8UyPEFG9iUDQQdhoxAKM6SBWuKXP/5NQR5NDDtBsv0Ds/TSmWIYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598292; c=relaxed/simple;
	bh=HAHiIl2jNrhC5hc5QL6D3q9jjBG3PTH2NaOK/wX8RuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QpF+IRsPcSpZxoUKLtmTCR0uO/5u4U0Iii2/c+n7qMadW043kUJxmkE+xNPA1BC7luZOZAEIVA3pZM3Mm21zHQIo+PxhU60eKDeZWVO8YZFl7taUDtiTh3RsVYYpSzXO2b4M8HsRQ0ja/VxqujDqJ1UPLfkaQhcM+mmVhHZuUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I9rQHYWH; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768598289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fIDHZTLCHe/bajC18/peDAHRSXDESLQ9QSFkCkrL/k=;
	b=I9rQHYWHcTJDT9aUag93ADbbTeSiXNbylUMI/REH6Y6OxQ2Qn3rrqdWqannqUf2nph5Zlt
	hxCAKnfUVbuIMSGxpbgzw1qcsZWLWy48qCsaqgBbpHrRlPif/39oBXGPocABdX3CTus1Fn
	n4r1dSV3L5zgu32WZKgrtAUgqTKGKgM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  ohn Fastabend
 <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Jiri Olsa <jolsa@kernel.org>,  Kumar
 Kartikeya Dwivedi <memxor@gmail.com>,  bpf <bpf@vger.kernel.org>
Subject: Re: Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()
In-Reply-To: <CAADnVQ+45MorO=pODKOEVXhpY1skVy1tPkkABPAxDJGx4vOijg@mail.gmail.com>
	(Alexei Starovoitov's message of "Fri, 16 Jan 2026 08:12:19 -0800")
References: <20260113083949.2502978-2-mattbobrowski@google.com>
	<87y0lyxilp.fsf@linux.dev> <aWnu-b0dlm0xZFDS@google.com>
	<CAADnVQKd-yu=bZjx+3=QKLq+26wcGJtJSrZoQh8b8ByKSPEXcQ@mail.gmail.com>
	<CAADnVQ+45MorO=pODKOEVXhpY1skVy1tPkkABPAxDJGx4vOijg@mail.gmail.com>
Date: Fri, 16 Jan 2026 13:18:02 -0800
Message-ID: <878qdx6yut.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Jan 16, 2026 at 7:22=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, Jan 15, 2026 at 11:55=E2=80=AFPM Matt Bobrowski
>> <mattbobrowski@google.com> wrote:
>> >
>> > On Thu, Jan 15, 2026 at 08:54:42PM -0800, Roman Gushchin wrote:
>> > >
>> > > > With the BPF verifier now treating pointers to struct types return=
ed
>> > > > from BPF kfuncs as implicitly trusted by default, there is no need=
 for
>> > > > bpf_get_root_mem_cgroup() to be annotated with the KF_ACQUIRE flag.
>> > >
>> > > > bpf_get_root_mem_cgroup() does not acquire any references, but rat=
her
>> > > > simply returns a NULL pointer or a pointer to a struct mem_cgroup
>> > > > object that is valid for the entire lifetime of the kernel.
>> > >
>> > > > This simplifies BPF programs using this kfunc by removing the
>> > > > requirement to pair the call with bpf_put_mem_cgroup().
>> > >
>> > > It's actually the opposite: having the get semantics (which is also
>> > > suggested by the name) allows to treat the root memory cgroup exactly
>> > > as any other. And it makes the code much simpler, otherwise you
>> > > need to have these ugly checks across the codebase:
>> > >       if (memcg !=3D root_mem_cgroup)
>> > >               css_put(&memcg->css);
>> >
>> > I mean, you're certainly not forced to do this. But, I do also see
>> > what you mean.
>> >
>> > > This is why __all__ memcg && cgroup code follows this principle and =
the
>> > > hides the special handling of the root memory cgroup within
>> > > css_get()/css_put().
>> > >
>> > > I wasn't cc'ed on this series, otherwise I'd nack this patch.
>> > > If the overhead of an extra kfunc call is a concern here (which I
>> > > doubt), we can introduce a non-acquire bpf_root_mem_cgroup()
>> > > version.
>> > >
>> > > And I strongly suggest to revert this change.
>> >
>> > Apologies, I honestly thought I did CC you on this series. Don't know
>> > what happened with that. Anyway, I'm totally OK with reverting this
>> > patch and keeping bpf_get_root_mem_cgroup() with KF_ACQUIRE
>> > semantics. bpf_get_root_mem_cgroup() was selected as it was the very
>> > first BPF kfunc that came to mind where implicit trusted pointer
>> > semantics should be applied by the BPF verifier.
>> >
>> > Notably, the follow up selftest patch [0] will also need to be
>> > reverted if so as it relies on bpf_get_root_mem_cgroup() without
>> > KF_ACQUIRE. We can probably
>> >
>> > [0] https://lore.kernel.org/bpf/20260113083949.2502978-2-mattbobrowski=
@google.com/T/#mfa14fb83b3350c25f961fd43dc4df9b25d00c5f5
>>
>> Instead of revert of two patches, let's revert one and replace
>> with test kfunc that 2nd patch can use.
>>
>> tbh I don't think it's a big deal in practice.
>> Kernel code working with cgroups might be different than bpf.
>> I'm not sure what was the use case for bpf_get_root_mem_cgroup().
>>
>> Roman,
>> please share your protype bpf code for oom, so it's easier to see
>> why non-acquire semantics for bpf_get_root_mem_cgroup() are problematic.
>
> Actually, thinking more about it, bpf_get_root_mem_cgroup() should NOT ha=
ve
> an acquire semantics, otherwise you cannot even implement:
>
> static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
> {
>         return (memcg =3D=3D root_mem_cgroup);
> }

You can check memcg->css.parent =3D=3D NULL instead.

>
> without ugliness:
>
> static inline bool bpf_mem_cgroup_is_root(struct mem_cgroup *memcg)
> {
>         struct mem_cgroup *root_memcg =3D bpf_get_root_mem_cgroup();
>         bool ret =3D memcg =3D=3D root_memcg;
>
>         bpf_put_mem_cgroup(root_memcg);
>         return ret;
> }

Maybe we need both, but if root_mem_cgroup is handled different, you
can't do a very natural thing like:

some_func (struct *mem_cgroup subtree_root) {
          struct mem_cgroup *memcg =3D subtree_root ?  subtree_root : bpf_g=
et_root_mem_cgroup();

          // iterate over subtree


or you can't pass a pointer (with a reference) to a function or a work
with the assumption that it should drop the reference at the end.

Basically you can't easily mix the root_mem_cgroup pointer with normal
memcg pointers.

E.g. in my bpfoom case:

SEC("struct_ops.s/handle_out_of_memory")
int BPF_PROG(test_out_of_memory, struct oom_control *oc, struct bpf_struct_=
ops_link *link)
{
	struct task_struct *task;
	struct mem_cgroup *root_memcg =3D oc->memcg;
	struct mem_cgroup *memcg, *victim =3D NULL;
	struct cgroup_subsys_state *css_pos, *css;
	unsigned long usage, max_usage =3D 0;
	unsigned long pagecache =3D 0;
	int ret =3D 0;

	if (root_memcg)
		root_memcg =3D bpf_get_mem_cgroup(&root_memcg->css);
	else
		root_memcg =3D bpf_get_root_mem_cgroup();

	if (!root_memcg)
		return 0;

	css =3D &root_memcg->css;
	if (css && css->cgroup =3D=3D link->cgroup)
		goto exit;

	bpf_rcu_read_lock();
	bpf_for_each(css, css_pos, &root_memcg->css, BPF_CGROUP_ITER_DESCENDANTS_P=
OST) {
		if (css_pos->cgroup->nr_descendants + css_pos->cgroup->nr_dying_descendan=
ts)
			continue;

		memcg =3D bpf_get_mem_cgroup(css_pos);
		if (!memcg)
			continue;

                < ... >

		bpf_put_mem_cgroup(memcg);
	}
	bpf_rcu_read_unlock();

        < ... >

	bpf_put_mem_cgroup(victim);
exit:
	bpf_put_mem_cgroup(root_memcg);

	return ret;
}

--

How to write it without get semantics?

Thanks!

