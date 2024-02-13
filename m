Return-Path: <bpf+bounces-21916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CED854020
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0563B28586F
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EC363103;
	Tue, 13 Feb 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAK+mWNo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60663101
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866984; cv=none; b=psceDguyrlCM88of6tJk4DtHEthaCO/enzxy0VJDMhWQdUc6OBeZZm96r8qhw7CLkdVRNwhOxAH7AIsRo91p3SDyJrFb6GcaxwAlmEJD0LC5C1vKsj7yn0WxBgORXBL2flIDZKNBH52oTifDPZYJ/hIG5X9QNkg+pUKIUvN1r2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866984; c=relaxed/simple;
	bh=jaJl9E/pKE+nIfVX/LQWU5t6SbE2wwyuZ5Ek5RzAg9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rkke51dY8ED+Tf/+xkq5WY0wiiZNCfdS1Syh3mG5NwPtloqBcNRayWsa9T+PkrJGqPhPMmxQOoyuOemndKFx7DjnIFHLnXRbr9uF8VwusSl0sDQIl5kHVkECqAcapSYZijwEdgck/y+5aoE9L9gvQdM8Q2YeIVvhhF/LorEzCOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAK+mWNo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33cd57b86bfso879025f8f.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866981; x=1708471781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCDCdziaJNYcsPW+dg1aPSPYuXZtY/TZgMOBo/l3pIA=;
        b=NAK+mWNo0W2PYjIK7Ok6TpXNskl/bHIG8qoeCN3FtNQMS6Y6EdLoMSqPgOA2MNBEpX
         UdcAK6A/lzBymBPFbx2FZjIhrIKAPJw/Z4N3NQQv8wiIQb2X5WqqzHSndH46VzPwHhWl
         D3RqnitvDznUt2g7n28afRIv8Z1tXbKd+4qIKXiBeT6cnBlBx8UMXpefiJXIULnJyHoT
         1Xue+vcg5XSMsqI9aQajzOWtOdbaCF1lfA/Ibd6HPTwAy5tAvfyDQRN3YjPbATC3bhG1
         bPm4jVSZe7z6aNeLcFmEfXC2BBJifbEQ+S+jHXrAw5FvUiMjn4GoThBwEPjsSfJcO6J8
         hE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866981; x=1708471781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCDCdziaJNYcsPW+dg1aPSPYuXZtY/TZgMOBo/l3pIA=;
        b=VBZ0I26lPyNFmQvNAqgGoKwayGcTU2xnByZqc6ezhTG+MjSr+JYYpEdWwl6FIpzCJD
         qPM0+Hb+d0WSgBtvkSWAmZ+xprx4zd9DUV7RwIRvu2qXVK7kJ9mrAwhu2iKiLxg08tQV
         AejaLQbGJ8TmFZTYgQXWFTaUJocB7+Zw5e7htZyjyR899DM9J1KCkw/V8pHo50QiTLyp
         QXk2Lbgxxm+6Ci0SyKTWa2NqDPaYOVXiq5vm5pscdZTJdWq1ZaZ/D8FAZ2ows4LGeXC0
         MpA0ryNdLsBKbT9fbaa+s5SSXmqw6OvIXm3vtJ3meZOGuk6qCCualaHCI7a8JFXHmFSO
         LpKg==
X-Gm-Message-State: AOJu0Yx9F6fhBG/+t5OqH5k3Kbn+Me9EvvlZ1TqSDYCoadRsjDtQt0Gf
	faXeejqNFkt9d/t4qi+nBuz7BqrZOBKRnyKrWGMITj1cVX0+hvNFjDcczz2EMP9KBv/El23vlUt
	mYYRd1dfLKJ48p1nKuFHD0nY54h4=
X-Google-Smtp-Source: AGHT+IE7azLBt384K3kq2KzpnE8Mi2pct/k7bfY5SVuVw39XgvuBirY6J/YCAM393HXouXYB5NAKLAeiz7KqhtCCKdY=
X-Received: by 2002:adf:e64c:0:b0:33a:ffeb:8531 with SMTP id
 b12-20020adfe64c000000b0033affeb8531mr395828wrn.61.1707866981080; Tue, 13 Feb
 2024 15:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-6-alexei.starovoitov@gmail.com> <CAEf4BzaGT3cSVo=XsD6d4bgR-8JVx8z=Pgi9RkdHseui9MPMvw@mail.gmail.com>
In-Reply-To: <CAEf4BzaGT3cSVo=XsD6d4bgR-8JVx8z=Pgi9RkdHseui9MPMvw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 15:29:29 -0800
Message-ID: <CAADnVQL_92=DQovMhcgjjN-aaLVERU9HGd1i=aGfkxe2pfSveg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/20] bpf: Introduce bpf_arena.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:14=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> here we can then use MAX_ARENA_SZ

I thought about it, but decided against it, since it will be
too tempting to change it without understanding the consequences.
Like...

> > +       if ((attr->map_extra >> 32) !=3D ((attr->map_extra + vm_range -=
 1) >> 32))
> > +               /* user vma must not cross 32-bit boundary */
> > +               return ERR_PTR(-ERANGE);

here >> 32 is relevant to size and pretty much every such shift.
Hence 1ull << 32 matches all those shifts.
And they have to be analyzed together.

> > +       apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_st=
art(arena),
> > +                                    KERN_VM_SZ - GUARD_SZ / 2, for_eac=
h_pte, NULL);
>
> I'm still reading the rest (so it might become obvious), but this
> KERN_VM_SZ - GUARD_SZ / 2 is a bit surprising. I understand that
> kern_vm_start is shifted by GUARD_SZ/2, but is the intent here is to
> actually go beyond maximum 4GB by GUARD_SZ/2, or the intent was to
> unmap 4GB (MAX_ARENA_SZ)?

here it's just the range for apply_to_existing_page_range() to walk.
There are no pages mapped into the lower GUARD_SZ / 2 and upper GUARD_SZ / =
2.
So no reason to ask apply_to_existing_page_range() to walk
the whole KERN_VM_SZ.

> > +       ret =3D current->mm->get_unmapped_area(filp, addr, len * 2, 0, =
flags);
> > +       if (IS_ERR_VALUE(ret))
> > +                return 0;
>
> Can you leave a comment why we are swallowing errors, if this is intentio=
nal?

argh. good catch. it's a bug.

> > +       if ((ret >> 32) =3D=3D ((ret + len - 1) >> 32))
> > +               return ret;
> > +       if (WARN_ON_ONCE(arena->user_vm_start))
> > +               /* checks at map creation time should prevent this */
> > +               return -EFAULT;
> > +       return round_up(ret, 1ull << 32);
>
> this is still probably MAX_ARENA_SZ, no?

and here it would be wrong to do that.
This line has to match the logic with 'if' few lines above.
Hiding behind macro is a dangerous obfuscation.

