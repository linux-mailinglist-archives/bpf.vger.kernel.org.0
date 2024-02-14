Return-Path: <bpf+bounces-21924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A60854098
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61101F22D49
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82963623;
	Wed, 14 Feb 2024 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnpOk4dE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D98F40
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869012; cv=none; b=DOatNZDCThNmbqefzK2AvnJfFKKq2JkNzY9TnELMTSGfPH+1x9A9xezmvxXlf0a8fMrnpVTolb9gNo7CZ9bERmTB/HphM0EDRPpPd1e7uf1cgbXo1pU3NPGLjdKU/+al5KwRRhuWMomA1L27vp5oPUyWfsk6kuasfHQrLhOamik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869012; c=relaxed/simple;
	bh=ybYjYogkmaT4k+JFivElwa/OtfTH1CHUDfKpCW+C/kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nohPiaYwXKED7X2d7qS30aCLha8sXt0DqTTYhkj4ariV7ej7OAUdsTOSMazC+4ZlJjG3NI9sj0JGkGE/H/R8fk4xNM+QZ1SjpJ3owTz/CcJZs5mDV2bR4AMMq9ykflkNGzpgC+74fq/wVuz4b7R08uSYp8Unt2TAndLYqL2xhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnpOk4dE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29041136f73so3075901a91.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707869010; x=1708473810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HRh9bAwavfRq+lhQucvADryfECxZnwFas/BvlAUBZg=;
        b=XnpOk4dEHcbZa8f8EtHgXu5zZLe1lVq6A7Kp8NdwbiUv47LG0ipM1Ps5O1JlCJUHHQ
         CNCngPrFDJQaDH39I5pKte7v1G884Z/oaFqH4+YRIhUYwF6jlyY4GG+g7jWl3EmhgSPQ
         jc+N60xR4LzIK0QQLAzLfNvX60gNVk9so5Hs0k7s+AsPHi14x29GK+us/o/Wgy5jxoSM
         f3BG7llpqRbYjNWZALvk4yK50c0wBY5gtO4w6m1wo24/iyoe88OPYzHW014K2m6wdB5b
         ILFhSPhR39+7Wxayhv/RhkI1g0JAmJril/wE2nw3MXoFW3Wc2PtIjV2dWyG54i8FXe+B
         U8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869010; x=1708473810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HRh9bAwavfRq+lhQucvADryfECxZnwFas/BvlAUBZg=;
        b=BbXUJyt18FVp3Ck/DdMoPj7H6oZxDEeKxl3CW8rdLbccpKxyXZD9CnnWvzDPZqFn9+
         gLocO0U8jEa1Q/X+fyLPg2qi3s8277pvybokXU/wjNbcqrDAa10asjg+Y9ruGdBKEIGJ
         2EPr+PSKuV5W2+sqHDI4DrgtwgGInStxuyX8xQcXoyEGE7iQICAms+i8SvTRoaMsd2qN
         Rhxspi+qPFFFlUeCePeoeoMViZEzW8ar9hLRBLCUjV1OdandyLDIS3Zl/8avgnOubakb
         03e514chqj8uFwlQtmbVtr4yhHBd5SDzDTw0QFnDhHF7BosSbnFfzSL2eCkcORc1E6MP
         w6jQ==
X-Gm-Message-State: AOJu0YzeQCDZCDscIDNdQXJbEErFb6djrrItXZPfQCLratn+EA31axR4
	ZJ1jhzRFR3bbrm6imzoY4PW3FT/564bVnotFK0XkwuAC08yyo9QNRrXF5oSuxbOj7e5Xo17PSc2
	DgAP/z1gI7q64Gm6M5rd8jKIeCQ8=
X-Google-Smtp-Source: AGHT+IG9fmgQBEWLXwPPFHNaogYA9vESRTSsibzjEvlSkg/g/KbIx4M4/h+iYUMEbdUboEvHa5FFeGsJfWv7VcXejIg=
X-Received: by 2002:a17:90b:1043:b0:298:c5f6:edf8 with SMTP id
 gq3-20020a17090b104300b00298c5f6edf8mr1184019pjb.0.1707869009825; Tue, 13 Feb
 2024 16:03:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-6-alexei.starovoitov@gmail.com> <CAEf4BzaGT3cSVo=XsD6d4bgR-8JVx8z=Pgi9RkdHseui9MPMvw@mail.gmail.com>
 <CAADnVQL_92=DQovMhcgjjN-aaLVERU9HGd1i=aGfkxe2pfSveg@mail.gmail.com>
In-Reply-To: <CAADnVQL_92=DQovMhcgjjN-aaLVERU9HGd1i=aGfkxe2pfSveg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 16:03:17 -0800
Message-ID: <CAEf4BzYX8=nYcJQEuz2L2X3+vQKDezRGyJM4wVQaXyLbhLuZYQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/20] bpf: Introduce bpf_arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:29=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 13, 2024 at 3:14=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> >
> > here we can then use MAX_ARENA_SZ
>
> I thought about it, but decided against it, since it will be
> too tempting to change it without understanding the consequences.
> Like...
>
> > > +       if ((attr->map_extra >> 32) !=3D ((attr->map_extra + vm_range=
 - 1) >> 32))
> > > +               /* user vma must not cross 32-bit boundary */
> > > +               return ERR_PTR(-ERANGE);
>
> here >> 32 is relevant to size and pretty much every such shift.
> Hence 1ull << 32 matches all those shifts.
> And they have to be analyzed together.
>
> > > +       apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_=
start(arena),
> > > +                                    KERN_VM_SZ - GUARD_SZ / 2, for_e=
ach_pte, NULL);
> >
> > I'm still reading the rest (so it might become obvious), but this
> > KERN_VM_SZ - GUARD_SZ / 2 is a bit surprising. I understand that
> > kern_vm_start is shifted by GUARD_SZ/2, but is the intent here is to
> > actually go beyond maximum 4GB by GUARD_SZ/2, or the intent was to
> > unmap 4GB (MAX_ARENA_SZ)?
>
> here it's just the range for apply_to_existing_page_range() to walk.
> There are no pages mapped into the lower GUARD_SZ / 2 and upper GUARD_SZ =
/ 2.
> So no reason to ask apply_to_existing_page_range() to walk
> the whole KERN_VM_SZ.

right, so I expected to see KERN_VM_SZ - GUARD_SZ, but instead we have
KERN_VM_SZ - GUARD_SZ/2 (so we'll iterate GUARD_SZ/2 too much, into
upper guard pages which are supposed to be not allocated), which is
why I'm asking. It's minor, I was probing if I'm missing something
subtle.

>
> > > +       ret =3D current->mm->get_unmapped_area(filp, addr, len * 2, 0=
, flags);
> > > +       if (IS_ERR_VALUE(ret))
> > > +                return 0;
> >
> > Can you leave a comment why we are swallowing errors, if this is intent=
ional?
>
> argh. good catch. it's a bug.
>
> > > +       if ((ret >> 32) =3D=3D ((ret + len - 1) >> 32))
> > > +               return ret;
> > > +       if (WARN_ON_ONCE(arena->user_vm_start))
> > > +               /* checks at map creation time should prevent this */
> > > +               return -EFAULT;
> > > +       return round_up(ret, 1ull << 32);
> >
> > this is still probably MAX_ARENA_SZ, no?
>
> and here it would be wrong to do that.
> This line has to match the logic with 'if' few lines above.
> Hiding behind macro is a dangerous obfuscation.

ok, no big deal

