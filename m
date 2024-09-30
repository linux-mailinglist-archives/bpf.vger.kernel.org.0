Return-Path: <bpf+bounces-40622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4956598B0A9
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 01:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC562834BA
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A869318754F;
	Mon, 30 Sep 2024 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgxIH8pm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D104183CA4
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738024; cv=none; b=oBtqeQBl1JvVJY00HKoePD83/2+urENm8BwJvFWqH27B1kzsE3MdiJroYPg8ja7IyjqteUlF+PRm9NGuc3OCz3Yut4vnRawkSpGsIxLNs2qXrVhdYutAtL+xLMXCPXtaATP4a/RS/wNIPtS7XoNFcf2nOvZ/vLA/3vtO5EtfXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738024; c=relaxed/simple;
	bh=t3kavuk2bk2E/MDxMgtMreajeW67uJ1/5YRb/UNG1r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxzdNhSSNwgPByETWZj3avzCAejZuvoyCqVQ0kVL82KV4DG/iTjPMvkle/xVuvlKBXnx63h0v+HcFBqkDMbBZrQ4te04e0VZtfgrNJ4iITtLJAghoZBfqotd/9X+GTAQqmivgd0vJ4rRgRFotI36e5Qfz5z6HFL2EX2LUTjvWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgxIH8pm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db174f9050so1093349a12.3
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727738022; x=1728342822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuH3fuo2ce0A/koosjNDUiu4Hm46ie1xuYJvbKElY1w=;
        b=CgxIH8pm+8JtGbtEeT7cOIeOx8s+CItHwByGNJMTHpa0NSvbwPLbVHCpDpRWLAgZE3
         9fZVpb7TFLkS/vueladD+wSM6pKT8hAypw9eJm2hNeDKR1Ayuxnx0vSmAvg1S/uLMiWQ
         PVXMa7Itt3zZtMLPaz1fXXQa7Xz4EeF+Pta6zQ8k14wA+meCJmB96x0CnNnLimOAaE7g
         OrYKTm2cA8NRm2RI7JLhV0V9+Gd9lHs8eMEZd3RCAHCcdkB56N0fOHkErER6Ixrqg3Hv
         6WW9HILZrXIiGXXrt7pNdNuZgy6LRv/FDG3FM8W0CljU+2TxrZzawcktdDCEZZPwwXD/
         mSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738022; x=1728342822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuH3fuo2ce0A/koosjNDUiu4Hm46ie1xuYJvbKElY1w=;
        b=lkRg/wFKq66kz31xiw9OVkoBNwY6iXmoBW2pg5cgyByHKGc/Jy0g9Gtby1+LI1DMTK
         v028KU7DcQVo+A1Jm47zmr+3xyr7NvkP1DSU1NheSvdqpgccepKBJ+2HCyxKvdb5I9Lj
         9LoZAiKRsnokpiaFlrhxASISm6B85DKh7hnhbEclej5GvZESNMC8GXI/t3JCqt2Yt4BZ
         eWEQ6exzhWBHHOPaTbYPAlG2vrZ6gVg5ihj/75YAoqi5cvdmbVNUYdxQOpFAtGuMc7GN
         vvRlkhX/roAuASK24cWkjSuJ4cngae/gl8tn6n3UnjESKSGuruLNb0JIe2w8M28Otibv
         mbVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwdrBFtzAzSpqgNzd9lz7NQfYFy0y7rr3EdQGufyof7R3EiZ8rfsG2uf4+6TP2+jcvUsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Eobs4dJ1UmkFoOQ8ap3LElhEt6vA+Bkrqj6Gtgl3EQ41aGCd
	EG62s6Amron65m3HjMSz2fUnr3vgMlirfEmrgC5jzv1lu8wCu/zbKj63xKKHTH9g6LIzP+Dn5gF
	6S7nCe9x5rl7/yr5iwCIjVTCx6Lo=
X-Google-Smtp-Source: AGHT+IG9xOkwXLCrT6CGgLxFGakCfLp1+YvFE2nDyBHGAlVnD4DSBYD8mkg2nA2m8+y//qAEucxEyNwYW2DO4hyhzVY=
X-Received: by 2002:a17:90a:134d:b0:2d3:d8ae:67e1 with SMTP id
 98e67ed59e1d1-2e0b8e8b889mr15418741a91.26.1727738021771; Mon, 30 Sep 2024
 16:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xru56ozvb4mrphuqt53tvbsiv3n3wfcknme663zcxefayx3re@oq5xnb3o3fec> <pxhmdzeguovh77x7vjkbwxi2r4nthre6n7w2u63j3frvsediu4@x45otw5mpjq4>
In-Reply-To: <pxhmdzeguovh77x7vjkbwxi2r4nthre6n7w2u63j3frvsediu4@x45otw5mpjq4>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 16:13:29 -0700
Message-ID: <CAEf4BzY7L3fBVMiPJze0JY68Z62UvXTw=LMZGrgZMTMWs4VB-A@mail.gmail.com>
Subject: Re: Good first-time BPF tasks
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Hemanth Malla <hemanth.malla@datadoghq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 11:30=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> Hi Andrii and Eduard,
>
> On Sun, Sep 22, 2024 at 02:41:08AM GMT, Shung-Hsi Yu wrote:
> > A topic that came up several times off-list at LPC was how to start
> > contributing to the BPF subsystem. One of the thing that would probably=
 help
> > is to have a list of todos that are nice to have and can be implemented=
 in a
> > relatively self-contained set of patches. Here's things that I've gathe=
red.
> >
> > On the more concrete task sides (easy to hard):
> >
> > - Check return value of btf__align_of() in btf_dump_emit_struct_def()
>
> The above task is currently being worked on. But I though its better to
> ask you both for opinion before I lead anyone astray.
>
> My understanding is that btf__align_of() could return an error, thus all
> caller should check for its return value, for example:
>
>         static void btf_dump_emit_struct_def(...)
>         {
>                 ...
>                 align =3D btf__align_of(d->btf, id);
>
>                 for (i =3D 0; i < vlen; i++, m++) {
>                         const char *fname;
>                         int m_off, m_sz, m_align;
>                         ...
>                         m_align =3D packed ? 1 : btf__align_of(d->btf, m-=
>type);
>
>                         in_bitfield =3D prev_bitfield && m_sz !=3D 0;
>
>                         btf_dump_emit_bit_padding(d, off, m_off, m_align,=
 in_bitfield, lvl + 1);
>                         btf_dump_printf(d, "\n%s", pfx(lvl + 1));
>                         ...
>                 }
>
>                 /* pad at the end, if necessary */
>                 if (is_struct)
>                         btf_dump_emit_bit_padding(d, off, t->size * 8, al=
ign, false, lvl + 1);
>                 ...
>         }
>
> Should check whether align or m_align is 0 before moving forward.
>
> The reason I looked into this was because I ran into floating point
> exception a while back when trying to dump C-style header file out of a
> kernel module while mistakenly using the wrong base BTF, which crashed
> inside btf_dump_emit_bit_padding() at
>
>         roundup(cur_off, next_align * 8)
>
> Because roundup() requires the second argument to be positive, yet
> next_align that came from a btf__align_of() call was 0. I believe this
> still may happen with basic BTF validation[1] added.

TBH, I'd rather improve sanity checking to prevent invalid INT/FLOAT
definitions that don't have size.

>
> So, questions:
> - Is checking return value of btf__align_of() in
>   btf_dump_emit_struct_def() wanted? And if so:

The assumption is that you are dumping a well-formed BTF, so, barring
bugs, align_of() should always be valid and well-defined. So I'd leave
it as is, but, improve sanity checking, if that's the concern.

>   - What's the preferable action to take when it returns an error?
>         According to the comment for btf_dump_emit_type() it seems like t=
he
>         best thing to do is simply return in btf_dump_emit_struct_def()?
>   - Should we add a pr_* to report such error?
> - Any place that skipping the return value check of btf__align_of() is
>   fine?

All those btf_dump_emit_*() functions are void-returning, and so they
basically expect valid BTF. In the case of invalid BTF, that's a)
user's problem ;) but also b) those functions generally will just
either produce a bit of garbage output or exit early, resulting in
incomplete/clobbered vmlinux.h output, but other than that should be
fine.

If you provide invalid base BTF, way more than btf__align_of() would
cause problems.

>
> 1: https://lore.kernel.org/bpf/20230825202152.1813394-1-andrii@kernel.org=
/
>
> (One more question below)
>
> ...
> > - Replace open-coded & PTR_MAYBE_NULL checks with type_may_be_null()
> > - Implement tnum_scast(), and use that to simply var_off induction in
> >   coerce_reg_to_size_sx()
> > - Better error message when BTF generation failed, or at least fail ear=
lier
> > - Refactor to use list_head to create a linked-list of bpf_verifier_sta=
te
> >   instead of using bpf_verifier_state_list
> >
> > On the more general side of things:
> >
> > - Improve the documentation
> >   - add the missing pieces (e.g. document all BPF_PROG_TYPE_*)
> >   - update the out-date part (admittedly quite hard)
> > - Improve the BPF selftests coverage
> >   - add test for fixes that have been merged but does not come with a
> >     corresponding test case to prevent regression
> >
> > I want to keep the list from being too verbose, so I won't go into too
> > much detail in this email. But feel free to reply to this thread and
> > ask. You might want to use https://github.com/sjp38/hackermail to reply
> > if you're not familiar with mailing lists.
> > (I know mailing list don't have the best UX, is a scary place, and also
> > not the best issue tracker, we'll see how this works out and change if
> > needed)
> >
> > Also If anyone has other things they want to add to the list that will
> > be great.
>
> Is there any libbpf task(s) that you think that might be good for
> first-time contributors? I see there are issues tracker for the
> libbpf/libbpf project on GitHub[2], but wonder if there's specific ones
> that are suggested for first time contributor to tackle.
>
> 2: https://github.com/libbpf/libbpf/issues

I'd appreciate any help with handling these issues and helping users
with their problems and/or fixing OSS Fuzz issues (or at least
triaging them).

That would be a good start.

>
> ...
> > Resources
> >
> > - Introduction to BPF selftests
> >   https://lore.kernel.org/bpf/62b54401510477eebdb6e1272ba4308ee121c215.=
camel@gmail.com/

