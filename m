Return-Path: <bpf+bounces-67110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C5B3E51F
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 15:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A9B163F73
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3C2D663B;
	Mon,  1 Sep 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7v2XnNP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7384039
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733658; cv=none; b=Lx3cskdjI3GYWRe/YvTgsIDr9F/QW+5cFknL83nrjWgKxbF/JOog5ko9p9mQdXrpy/MwWN2XJ+0mA6XZnf+qYPs8RXoNddfP0/NIF9yrw0AlKofVF8HLly/WMrw/jYn7gg8QV41YWZzzJgIcyFHJWGx9vkPzWz9/HfkZcLeU27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733658; c=relaxed/simple;
	bh=kfcXpnV8TnOg8jTwVxV6GHrUpgd/Y/6ViFRuQ+4iEQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sEBU24VPVeNxyCmuXxKDLRfAv3E0oh2eoy5UkTnVDqou2+Deb6cOVda6yFXcKqEMHaGlvhmzBaPV3+IDwp7Z63GsHNjI4BnpTFzklPzwI9Gb58GkANK5J5MijjAbjl0IOmtFuPv1VasY0yxvOSndJ7D+fdCN+oKyyaAebmD4zFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7v2XnNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F63C4CEF1;
	Mon,  1 Sep 2025 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756733657;
	bh=kfcXpnV8TnOg8jTwVxV6GHrUpgd/Y/6ViFRuQ+4iEQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C7v2XnNPksUZfdiRpyujtTslqcwJeDrG8wxlwyt/s9Y35qO+K9M9vUeSFwdFmZ7I6
	 kWhGT6EI1xmk6vbPGvx3mBdGE9RvpRkwRq1tT+0P/KEm34/kTp20ubeMZ54exY21xj
	 Xo46qToyEoDbjB8pR+XUQQGXqZBSbdgoSp/VbRdVBouK3zpmhhKLg0/znL+nVOpJC3
	 tRnvq07KHr+boaGj9ogp6QM19OF5z1sBoLioavdEJ3j0DTu1+AdGhG6AwRbVEoiox6
	 dL/MQw2Tc7goA/Qy2xVl/efjGhrRkq9HML9c4Va78IHBhK/Z23l6whh3iAjNFOpXBM
	 xwHYEanJIOnow==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Xu Kuohai
 <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Report arena faults to BPF stderr
In-Reply-To: <CAADnVQKp-FXhVtxCSE8rako8BBnAU4Qt-dxviqrJUr-Fpfm+4w@mail.gmail.com>
References: <20250827153728.28115-1-puranjay@kernel.org>
 <20250827153728.28115-3-puranjay@kernel.org>
 <99bb1aa8-885b-4819-beb3-723a73960f67@huaweicloud.com>
 <CAADnVQKp-FXhVtxCSE8rako8BBnAU4Qt-dxviqrJUr-Fpfm+4w@mail.gmail.com>
Date: Mon, 01 Sep 2025 13:34:13 +0000
Message-ID: <mb61p4itmjnze.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Aug 29, 2025 at 3:30=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.c=
om> wrote:
>>
>> > +
>> > +void bpf_prog_report_arena_violation(bool write, unsigned long addr)
>> > +{
>> > +     struct bpf_stream_stage ss;
>> > +     struct bpf_prog *prog;
>> > +     u64 user_vm_start;
>> > +
>> > +     prog =3D bpf_prog_find_from_stack();
>>
>> bpf_prog_find_from_stack depends on arch_bpf_stack_walk, which isn't ava=
ilable
>> on all archs. How about switching to bpf_prog_ksym_find with the fault p=
c?
>
> Out of archs that support bpf arena only riscv doesn't
> support arch_bpf_stack_walk(), which is probably fixable.
> But I agree that direct bpf_prog_ksym_find() is cleaner here.
> We need to make sure it works for subprogs, since streams[2] are
> valid only for main prog.
> I think we can add:
> struct bpf_prog_aux {
>   ...
>   struct bpf_prog_aux *main_prog;
> };
> init it during jit_subprogs() and use it for stream access.
> We can also remove skipping of subprogs in find_from_stack_cb() then.
>
> Kumar, wdyt?

So, IIUC, after adding struct bpf_prog_aux *main_prog_aux in struct
bpf_prog_aux,

We can do in bpf_prog_alloc_no_stats():
   fp->aux->main_prog_aux =3D aux;

and in jit_subprogs():
    func[i]->aux->main_prog_aux =3D prog->aux;

and then all users of bpf_stream_get() can do
    bpf_stream_get(stream_id, prog->aux->main_prog_aux);

with above we can allow find_from_stack_cb() to return subprogs.
and bpf_prog_ksym_find() can be used in
bpf_prog_report_arena_violation() without any other changes.

Thanks,
Puranjay

