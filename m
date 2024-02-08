Return-Path: <bpf+bounces-21563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040884EDEF
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 00:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D901F26595
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0FF50A91;
	Thu,  8 Feb 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa5TgNl5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA7524A9
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435428; cv=none; b=OJa4m+WbjzZq1VVGd0jdWYrdNaIBA7q57QOOZ7yFyzjjxivOPlf/lu/iD3F26zysj2R8H0aK/jtBLrRS7xIkgfgPa0rGHwtqoauIkypMl6sgwrmCBSFt3tBiUlRii3ttVCA1iWMYjK/QfZ+1FVu9Z7fWjhtTTpzybCwAlMZIU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435428; c=relaxed/simple;
	bh=yUrx8i4nOMyyKseKQaGTxDePLaBkc6/45A/Uf0iKAp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCReidh85oy3DlKwTCQTgcDZkEobuwEnyibi1TTotchc1kpee/PxoTeckRWHXbuWNqZpM0L2LINBOUjd/Ff9g1hrk7gvCRW9a8BLvaUrsq+3TxNJ/cDg7dB9q3f5MGTe57yNgD1FQXWHrl4VDGrdivyhOCk2c1sdb4akNcwW6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa5TgNl5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3394ca0c874so157701f8f.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 15:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707435425; x=1708040225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASkD7a4Oh5bNhTtaP4HZDzX3Az+lgvtErIFoGDbNuCM=;
        b=Wa5TgNl532Z0FJXfCNhShlNpB23vNAb24y1denmc2PDO+w4NZPfN7va5LaNYx5KlyX
         gahZcOHnKVBvCkD2UY6DGrqNuXLvicHt4LsZ6bXk/qe8lfySl1QXWEYJUx6atqOURojC
         QBOSRGFAbT/AV+zAPzjcTDljHvD+2ZVBsx5e/6LRXmx2HWVND4jDkFJxd0quX+JbEiBL
         nMZz67utJVRqqB9sh4LYG+mbNBWjCXul1Hq1/j5m98xw5yiawy7DwSdfFBklEwIBvoed
         FGhyozgqPkjvzajcfdzl1OH/yyMRmOvHRFpgagGkTc7j/lVXPzlK80rm5rKbkNCJ23Vx
         eHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707435425; x=1708040225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASkD7a4Oh5bNhTtaP4HZDzX3Az+lgvtErIFoGDbNuCM=;
        b=iG+sU3iRKqN5cswH031xh5eWKiEzKBXfE13+Plwc98IgE1QB9dnlNkSVsvuN5aepeC
         kAg9lJixJ8mMDwjpqw1qPcDU48GZS3BEUCp4emMOfq7J94XqsAfrTyL99RT8NRbVfUMQ
         Z9Tn+m52UGiqhZ/Eq3FEi3Vk2aBW3zb3hwBkCkDOAWE5JFkAxHapcSq/AaeExPBErC2E
         WfYrSo6jZAXEwLBUuiDBXtLd5rYDQeGt7c6aZ6MX57kpZ9KgiwyLRYxA0ze/EdTUsaXK
         GdjIDAScN5+JlFuw732fYxzk5ywiILlp7Dx53Qfgil/RMelQwrnC+ZQ+JEhno2Y86scc
         1KyA==
X-Gm-Message-State: AOJu0YxEqw5cDBtj9xdWCicaTD1W1ohLmfzjC+sR7YTxcoNvA/ISEVs2
	YbLpYLrjLxsw33mlvJvVLWjJdUWfu18pZINlKtvFVrvqvKH9sQLH8z1P3r/quyB8eL8q1FFQSET
	ZHgJWC9sIonzxaFrKqeSq0bsFc/w=
X-Google-Smtp-Source: AGHT+IFfg6MsxTjsNBbm4JJvCIa0LaciZioK1DcnMZT9RzlZi0kv0bekKeoWdIbijzTIhzaD4rX4uVbtmzRee8BPtRk=
X-Received: by 2002:adf:ce09:0:b0:336:6a76:40cd with SMTP id
 p9-20020adfce09000000b003366a7640cdmr628892wrn.62.1707435424744; Thu, 08 Feb
 2024 15:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-5-alexei.starovoitov@gmail.com> <c9001d70-a6ae-46b1-b20e-1aaf4a06ffd1@google.com>
 <CAADnVQJJ7M+OHnygbuN4qapCS8_r-mimM6CLw5oee8ixvmqg4Q@mail.gmail.com>
 <d4024acf-97c9-4a16-ac70-739d0bf81a45@google.com> <CAADnVQKejmHGDUAuRA+G2Ex0=+FcmTpVZ67DEZJHLjCMckx2xw@mail.gmail.com>
 <b1fe20c8-cd97-4ffc-8043-7fe42bf18c77@google.com>
In-Reply-To: <b1fe20c8-cd97-4ffc-8043-7fe42bf18c77@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Feb 2024 15:36:53 -0800
Message-ID: <CAADnVQJsbZeJCmyQbL-CAX7b4KgBtw_carPihOV_tG7nna=W4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/16] bpf: Introduce bpf_arena.
To: Barret Rhoden <brho@google.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:58=E2=80=AFPM Barret Rhoden <brho@google.com> wrot=
e:
>
> On 2/8/24 01:26, Alexei Starovoitov wrote:
> > Also I believe I addressed all issues with missing mutex and wrap aroun=
d,
> > and pushed to:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=
=3Darena&id=3De1cb522fee661e7346e8be567eade9cf607eaf11
> > Please take a look.
>
> LGTM, thanks.
>
> minor things:
>
> > +static void arena_vm_close(struct vm_area_struct *vma)
> > +{
> > +     struct vma_list *vml;
> > +
> > +     vml =3D vma->vm_private_data;
> > +     list_del(&vml->head);
> > +     vma->vm_private_data =3D NULL;
> > +     kfree(vml);
> > +}
>
> i think this also needs protected by the arena mutex.  otherwise two
> VMAs that close at the same time can corrupt the arena vma_list.  or a
> VMA that closes while you're zapping.

Excellent catch.

> remember_vma() already has the mutex held, since it's called from mmap.
>
> > +static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, lon=
g page_cnt, int node_id)
> > +{
> > +     long page_cnt_max =3D (arena->user_vm_end - arena->user_vm_start)=
 >> PAGE_SHIFT;
>
> this function and arena_free_pages() are both using user_vm_start/end
> before grabbing the mutex.  so need to grab the mutex very early.
>
> alternatively, you could make it so that the user must set the
> user_vm_start via map_extra, so you don't have to worry about these
> changing after the arena is created.

Looks like I lost the diff hunk where verifier checks that
arena has user_vm_start set before loading the prog.
And for some reason forgot to remove
if (!arena->user_vm_start) return..
in bpf_arena_alloc/free_page().
I'll remove the latter and add the verifier enforcement back.
The intent was to never call arena_alloc/free_pages when the arena is
not fully formed.
Once it's fixed there will be no race in arena_alloc_pages().
user_vm_end/start are fixed before the program is loaded.

One more thing.
The vmap_pages_range_wrap32() fix that you saw in that commit is not
enough.
Turns out that [%r12 + src_reg + off] in JIT asm doesn't
fully conform to "kernel bounds all access into 32-bit".
That "+ off" part is added _after_ src_reg is bounded to 32-bit.
Remember, that was the reason we added guard pages before and after
kernel 4Gb vm area.
It's working as intended, but for this wrap32 case we need to
map one page into the normal kernel vma _and_ into the guard page.
Consider your example:
user_start_va =3D 0x1,fffff000
user_end_va =3D   0x2,fffff000

the pgoff =3D 0 is uaddr 0x1,fffff000.
It's kaddr =3D kern_vm_start + 0xfffff000
and kaddr + PAGE_SIZE is kern_vm_start + 0.

When bpf prog access an arena pointer it can do:
dst_reg =3D *(u64 *)(src_reg + 0)
and
dst_reg =3D *(u64 *)(src_reg + 4096)

the first LDX is fine, but the 2nd will be faulting
when src_reg is fffff000.
From user space pov it's a virtually contiguous address range.
For bpf prog it's also contiguous when src_reg is 32-bit bounded,
but "+ 4096" breaks that.
The 2nd load becomes:
kern_vm_start + 0xfffff000 + 4096
and it faults.
Theoretically a solution is to do:
kern_vm_start + (u32)(0xfffff000 + 4096)
in JIT, but that is too expensive.

Hence I went with arena fix (ignore lack of error checking):
static int vunmap_guard_pages(u64 kern_vm_start, u64 start, u64 end)
{
        end =3D (u32)end;
        if (start < S16_MAX) {
                u64 end1 =3D min(end, S16_MAX + 1);

                vunmap_range(kern_vm_start + (1ull << 32) + start,
                             kern_vm_start + (1ull << 32) + end1);
        }

        if (end >=3D U32_MAX - S16_MAX + 1) {
                u64 start2 =3D max(start, U32_MAX - S16_MAX + 1);

                vunmap_range(kern_vm_start - (1ull << 32) + start2,
                             kern_vm_start - (1ull << 32) + end);
        }
        return 0;
}
static int vmap_pages_range_wrap32(u64 kern_vm_start, u64 uaddr, u64 page_c=
nt,
                                   struct page **pages)
{
        u64 start =3D kern_vm_start + uaddr;
        u64 end =3D start + page_cnt * PAGE_SIZE;
        u64 part1_page_cnt, start2, end2;
        int ret;

        if (page_cnt =3D=3D 1 || !((uaddr + page_cnt * PAGE_SIZE) >> 32)) {
                /* uaddr doesn't overflow in 32-bit */
                ret =3D vmap_pages_range(start, end, PAGE_KERNEL, pages,
PAGE_SHIFT);
                if (ret)
                        return ret;
                vmap_guard_pages(kern_vm_start, uaddr, uaddr +
page_cnt * PAGE_SIZE, pages);
                return 0;
        }

        part1_page_cnt =3D ((1ull << 32) - (u32)uaddr) >> PAGE_SHIFT;
        end =3D start + part1_page_cnt * PAGE_SIZE;
        ret =3D vmap_pages_range(start, end,
                               PAGE_KERNEL, pages, PAGE_SHIFT);
        if (ret)
            return ret;

        vmap_guard_pages(kern_vm_start, uaddr, uaddr + part1_page_cnt
* PAGE_SIZE, pages);

        start2 =3D kern_vm_start;
        end2 =3D start2 + (page_cnt - part1_page_cnt) * PAGE_SIZE;
        ret =3D vmap_pages_range(start2, end2,
                               PAGE_KERNEL, &pages[part1_page_cnt], PAGE_SH=
IFT);
        if (ret) {
                vunmap_range(start, end);
                return ret;
        }

        vmap_guard_pages(kern_vm_start, 0, (page_cnt - part1_page_cnt)
* PAGE_SIZE,
                         pages + part1_page_cnt);
        return 0;
}

It's working, but too complicated.
Instead of single vmap_pages_range()
we might need to do up to 4 calls and map certain pages into
two places to make both 64-bit virtual addresses:
kern_vm_start + 0xfffff000 + 4096
and
kern_vm_start + (u32)(0xfffff000 + 4096)
point to the same page.

I'm inclined to tackle wrap32 issue differently and simply
disallow [user_vm_start, user_vm_end] combination
where lower 32-bit can wrap.

In other words it would mean that mmap() of len=3D4Gb will be
aligned to 4Gb,
while mmap() of len=3D1M will be offsetted in such a way
that both addr and add+1M have the same upper 32-bit.
(It's not the same as 1M aligned).

With that I will remove vmap_pages_range_wrap32() and
do single normal vmap_pages_range() without extra tricks.

wdyt?

