Return-Path: <bpf+bounces-67123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E72B3EE64
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 21:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBE5488162
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E33305078;
	Mon,  1 Sep 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9BDDEbU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC045C0B
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756754539; cv=none; b=KJ8h/Ub5Ob9YyyTfsi2XBTz1ToCv9LNYbk/rxmVjgssULOD86v+eaSkR5xwbsz3ECiyZxHU3qdmD4QhI+4OJ4qkgAgkbnunGyRGsYP6XGZylqE2a6O42btIXykLvwk+FLofJ0WQ/3VJ2jSpEBWKo5VGXDUCHfeu2jvJfD8qtal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756754539; c=relaxed/simple;
	bh=EmKXJLPeyXoTEp6OD2u2+72ASygyQdHiVy5tr5CbRB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D7YDfTkIoO5o57bmL6q+hYqlJUk5jgc2OCYS89TbTBtvyNYOLyU+hLwXDi4lKSJ0DqHsRvxwG2D5tEYKt+/H7Ct13VTnKT1y0/5E//Y4wUOq/AHyWGGoc75+4UiFDetGaDZt3t0+Xb1SvlFDbyYZ+xGsLaTCYhgqedJMN1Ioyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9BDDEbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D63C4CEF0;
	Mon,  1 Sep 2025 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756754538;
	bh=EmKXJLPeyXoTEp6OD2u2+72ASygyQdHiVy5tr5CbRB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=P9BDDEbUPXGSJyzNxZceQVICh4zrCadMnSal9KpZRrvh6HeTeQ6V0EUEamzaHm2/l
	 wDNwDjWwuaGBnuSH7PM+uMup5MkHK/z36RGDaqTVkAQ/W/GW6CEAn8s9DNOKcupEZO
	 P5WJFDcMIADjvJbgXa0tKDmZHx/+TQ12GYYjknWc+WWHTAwhbfVEwvd35WpBARff4f
	 mH0tPQs09/KgXe/q61skK58pnzheL5M3cLzQG14Y2anIZp5Kf/NheZcdqhkjK7zlNS
	 0A1+lAJb78taBisYR0ZUyOYAeF5Gq9fefHJrZ3VxDyKTRXD4HujbT731Qi8p9/uekS
	 /Z7Vnb+UomvSg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Report arena faults to BPF stderr
In-Reply-To: <CAADnVQKPLwGF25YOzA=a4Vr==0UZFycv6GkLbwszkFrBiHGCcw@mail.gmail.com>
References: <20250827153728.28115-1-puranjay@kernel.org>
 <20250827153728.28115-3-puranjay@kernel.org>
 <99bb1aa8-885b-4819-beb3-723a73960f67@huaweicloud.com>
 <CAADnVQKp-FXhVtxCSE8rako8BBnAU4Qt-dxviqrJUr-Fpfm+4w@mail.gmail.com>
 <mb61p4itmjnze.fsf@kernel.org>
 <CAADnVQKPLwGF25YOzA=a4Vr==0UZFycv6GkLbwszkFrBiHGCcw@mail.gmail.com>
Date: Mon, 01 Sep 2025 19:22:14 +0000
Message-ID: <mb61p1poqj7vd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Sep 1, 2025 at 6:34=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Fri, Aug 29, 2025 at 3:30=E2=80=AFAM Xu Kuohai <xukuohai@huaweiclou=
d.com> wrote:
>> >>
>> >> > +
>> >> > +void bpf_prog_report_arena_violation(bool write, unsigned long add=
r)
>> >> > +{
>> >> > +     struct bpf_stream_stage ss;
>> >> > +     struct bpf_prog *prog;
>> >> > +     u64 user_vm_start;
>> >> > +
>> >> > +     prog =3D bpf_prog_find_from_stack();
>> >>
>> >> bpf_prog_find_from_stack depends on arch_bpf_stack_walk, which isn't =
available
>> >> on all archs. How about switching to bpf_prog_ksym_find with the faul=
t pc?
>> >
>> > Out of archs that support bpf arena only riscv doesn't
>> > support arch_bpf_stack_walk(), which is probably fixable.
>> > But I agree that direct bpf_prog_ksym_find() is cleaner here.
>> > We need to make sure it works for subprogs, since streams[2] are
>> > valid only for main prog.
>> > I think we can add:
>> > struct bpf_prog_aux {
>> >   ...
>> >   struct bpf_prog_aux *main_prog;
>> > };
>> > init it during jit_subprogs() and use it for stream access.
>> > We can also remove skipping of subprogs in find_from_stack_cb() then.
>> >
>> > Kumar, wdyt?
>>
>> So, IIUC, after adding struct bpf_prog_aux *main_prog_aux in struct
>> bpf_prog_aux,
>>
>> We can do in bpf_prog_alloc_no_stats():
>>    fp->aux->main_prog_aux =3D aux;
>>
>> and in jit_subprogs():
>>     func[i]->aux->main_prog_aux =3D prog->aux;
>>
>> and then all users of bpf_stream_get() can do
>>     bpf_stream_get(stream_id, prog->aux->main_prog_aux);
>>
>> with above we can allow find_from_stack_cb() to return subprogs.
>> and bpf_prog_ksym_find() can be used in
>> bpf_prog_report_arena_violation() without any other changes.
>
> Yes. That's exactly the proposal.

I think we should go ahead with this approach but also divide
bpf_prog_aux into two as you suggested. I will send a follow-up set for
that.

Thanks,
Puranjay

