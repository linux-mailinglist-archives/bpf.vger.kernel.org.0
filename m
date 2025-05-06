Return-Path: <bpf+bounces-57544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C072DAACBD2
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 19:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34C23A24F8
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B327875C;
	Tue,  6 May 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOXsczV4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF571F4C85
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550878; cv=none; b=YhDwtXg22qnvIw43cwKWAl0KhqaR4Zp4QIbOXTSUkOPsGijzngFF7eX13EdLspdfBnwxyiv1pi7muVIE7bQzdo2sIJejaB2L/MSn4dw0HCsfS1G6CqsyFZhJtZ5n31b4yXoTgwy7tF0Es3Z4NTDYvPVodc5YmpJEVn+J4qOIVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550878; c=relaxed/simple;
	bh=Ku4+hTuz/0xxlLJfbDtwSkjN7ZsYx+mhOP8ReA593Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVYkOyh1+G9nQwuruN4Dtqs1ejPlmg74m4VVhs1SEBxCX82dLMFZ7y1JTI9p5AdFbtckB9KY3NtGa7sEhvVQnb5Ub/Mbj7ARov/wIz574qWm3rBdHO65WwwJqowBxv0cpcvdkfjQQ4QZ3tldcJBGydwktB9PZWV6DD1a8IXzS+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOXsczV4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a0ac853894so878368f8f.3
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746550875; x=1747155675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Usq1gGyTgYwvp43AWpc6WW9cyc7qenhW0cCwuLdu/00=;
        b=VOXsczV4Vkq6EsU0hE8Jsinq/1qGu8mcc5gKgxXeXZeny7r0Haq0Be+zAMq0DBqtzo
         b1SHJHYgJK47OjQXMfatcNsQugA3QE2qcqFdxeWylg8XVx+VVJ2MFbaFMg6pBV3aSWgJ
         7fnPVpFqVcgVDh5YmLHEzWVJda7z+C6nAqydtf3u4CkvQxpC2ztFnJYhkRWMbTdn6aWj
         bmaeAkuGv/fo8pAPZV3+ciryKbwrGPwOZuIMlK/aMOAGoLHl8V7HFsa1UVFYv22iA7st
         rLBgFv8+Xg20XpeZIUKK34C4Q1I/fbVdlKHwELfljV+8B0nVqYdDKe9VzDQyVJS0+d3Z
         tKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550875; x=1747155675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Usq1gGyTgYwvp43AWpc6WW9cyc7qenhW0cCwuLdu/00=;
        b=Nt/d4lvPkEGe7GPXCwC4XMnpue6B/dZtUWtASNBnQ0+epSwEYvCyECItPS8AeQIZ1Q
         QyVY6xK1LHgzZb2kAtYbr/Wvx3bsQj1c8wqL4LgiF0U90OpEobTwjAKS00n99zpFpS6B
         waJ0fTqqk9QZavesU74IcCIoxT4IoppOryH6cNnDNOgTG2Y8QmTvi7gzcVZMF34EFu8e
         zGT6Vj1rls5VNYWUDDeTkQedetDhC/jobn0iGa4fJNw3lBYCXJ9EKA9PGef4nctY5MtC
         o3WKkYfwfATxLpi5DAKqIzYc+LgqsAqqSYmqnh7KLvcADjFwn6w08oYxFei27vfDxVRm
         DYXg==
X-Forwarded-Encrypted: i=1; AJvYcCXI9jZNqF3LVYWiPRojWwH0xRuJuh4OszZvgN6xhwl7I1T8MEcDGdREpmgRk82rbWIQcVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEu2Qo8/KZwC6HokUJbqCahh4LwKqlxFa0BTb+GIh/CbY4TQr
	ztQwWYi3lLI01+9LbBXaR3BItljWUKJh/K1CfG6VrQb6j2FZpSjQy5ZY3vzcWK4scRtgraEsQzu
	y6DxN73OaffjvyEx2lzBqL5RVE9M=
X-Gm-Gg: ASbGncs4pp9I4TekCLwy++jB1nC0mg3pAVZvOcycNdgGw4WWwMs/9vn6XLJsuT7qFKl
	bHAA7SI6Vy357bPaLyDaQvVaee5wd5GGHftakhXHJpSOQRxT1IMJGRQDWVWi7YkEYqMusXNgTqx
	LlXYVoMwRQP9478+8M+jEr5j2BfRXjY5yTGm0liA==
X-Google-Smtp-Source: AGHT+IFTaOGu0/JriUpk9HbzIhZRbRY5Sb566tQ9uGhelswmXUKed3TPcGrykhB/bqUY8Px0P0eCOxOoi73ua+sbyEM=
X-Received: by 2002:a05:6000:2403:b0:3a0:89ec:d398 with SMTP id
 ffacd0b85a97d-3a0b49a48b3mr170032f8f.17.1746550874894; Tue, 06 May 2025
 10:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
 <729dc77d091967d9496abda4ab793033f3979b2681da287f8bbf2df3de705dbf@mail.kernel.org>
 <CAN+4W8hDMdUnXitHuqUxA=mFOb=-QRQrejY8Koqb5mk0z-q9zQ@mail.gmail.com>
In-Reply-To: <CAN+4W8hDMdUnXitHuqUxA=mFOb=-QRQrejY8Koqb5mk0z-q9zQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 10:01:01 -0700
X-Gm-Features: ATxdqUFM38i6QReiakULIuDlcSaZ7xORYBHeu5c2MRkyG-z0HGh8w2ofupJ9gGU
Message-ID: <CAADnVQK8c+kM+j_YU3o61gdbfY3fH5N0i5h_Mef1Rb9j+pSYVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Allow mmap of /sys/kernel/btf/vmlinux
To: Lorenz Bauer <lmb@isovalent.com>, Xu Kuohai <xukuohai@huawei.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 9:20=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wro=
te:
>
> On Mon, May 5, 2025 at 8:01=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >
> > Dear patch submitter,
> >
> > CI has tested the following submission:
> > Status:     FAILURE
> > Name:       [bpf-next,v3,0/3] Allow mmap of /sys/kernel/btf/vmlinux
> > Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=
=3D959736&state=3D*
> > Matrix:     https://github.com/kernel-patches/bpf/actions/runs/14843811=
424
> >
> > Failed jobs:
> > sched_ext-aarch64-gcc-14: https://github.com/kernel-patches/bpf/actions=
/runs/14843811424/job/41673133374
> > test_maps-aarch64-gcc-14: https://github.com/kernel-patches/bpf/actions=
/runs/14843811424/job/41673133358
> > test_progs-aarch64-gcc-14: https://github.com/kernel-patches/bpf/action=
s/runs/14843811424/job/41673133413
> > test_progs_cpuv4-aarch64-gcc-14: https://github.com/kernel-patches/bpf/=
actions/runs/14843811424/job/41673133375
> > test_progs_no_alu32-aarch64-gcc-14: https://github.com/kernel-patches/b=
pf/actions/runs/14843811424/job/41673133323
> > test_verifier-aarch64-gcc-14: https://github.com/kernel-patches/bpf/act=
ions/runs/14843811424/job/41673133333
>
> The failure on aarch64 is the following:
>
> Unable to handle kernel paging request at virtual address ffffffffc2058b8=
8
> Mem abort info:
> ESR =3D 0x0000000096000006
> EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> SET =3D 0, FnV =3D 0
> EA =3D 0, S1PTW =3D 0
> FSC =3D 0x06: level 2 translation fault
> Data abort info:
> ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
> CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000041c91000
> [ffffffffc2058b88] pgd=3D0000000000000000, p4d=3D000000004250f403,
> pud=3D0000000042510403, pmd=3D0000000000000000
> Internal error: Oops: 0000000096000006 [#1] SMP
> Modules linked in: bpf_testmod(OE)
> CPU: 0 UID: 0 PID: 105 Comm: test_progs Tainted: G OE
> 6.15.0-rc4-gcf5bf38d19e3-dirty #2 NONE
> Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : validate_page_before_insert+0xc/0xf0
> lr : insert_page+0x54/0x160
> sp : ffff800084e4b7e0
> x29: ffff800084e4b7f0 x28: 0000000000000000 x27: ffff0000c0ca5500
> x26: ffffc1ffc0000000 x25: 0000000000001000 x24: 0000000000000458
> x23: 0000000000000000 x22: 0060000000000fc3 x21: 0000ffff8cfe6000
> x20: ffff0000c26a1f00 x19: ffffffffc2058b80 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: ffff800082a651d0
> x11: 0000000000000323 x10: 0000000000000323 x9 : ffff80008037d21c
> x8 : 0000000000040324 x7 : 000000002193fe5d x6 : ffff80008231b0b8
> x5 : ffff0000c1fa2f80 x4 : ffff0000c26a1f00 x3 : 0060000000000fc3
> x2 : ffffffffc2058b80 x1 : ffffffffc2058b80 x0 : ffff0000c26a1f00
> Call trace:
> validate_page_before_insert+0xc/0xf0 (P)
> vm_insert_page+0xc0/0x130
> btf_sysfs_vmlinux_mmap+0xec/0x1a0
>
> Clearly I'm doing something which is ok on x86_64, but not on aarch64.
> Any hints how to fix this would be much appreciated.

Not sure how arm64 maps loadable data sections.
Could you check what virt_addr_valid() returns ?
I'm guessing it's false.
I guess we can try to go back to remap_pfn_range(),
but it may succeed, but the data will be wrong.

Xu,
could you help us ?

