Return-Path: <bpf+bounces-52014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9AA3CE5F
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10374176101
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9B2AEFE;
	Thu, 20 Feb 2025 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkA8Y+YP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68028F5
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 01:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013369; cv=none; b=XMoN2XxD0IHNCWYpyyxLHZnvXFQPOow52ilUFz30mMS/HxpMVSf+3UcogYvYkaivlJMBBMRDzyBmcv4UYcmdplwJmYYS8TDA1DGB5huwdlrNk4WPHzsDakFSFEdCelxfOxpDWhtKsnfrWkzYLpfiHsSqSrAlfng3EaDDGDW6lNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013369; c=relaxed/simple;
	bh=BrPU3AK+6i35kflpHZ5r3QMB42cdq4kRHSEtwcKgbQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tirV4FbKf5CDhf/foIWTXAPXqiEomCTDm+DA92wG3Gv8mUzhDhFFl3xs9SCBW/wJKFzQM7jcLCHRV7DcfmqLMwk8e6ojdQpP45f1Vxy14kkLucaYeiRyBiXZA6ERhTRgePZXzbRlCSsgdM4H/y/Xb5vk3w5iL6CMJeeW2ek5Wbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkA8Y+YP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso638592a91.1
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 17:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740013367; x=1740618167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVTcMOsra+Zlj/NG7dWllagtUZ69SiTounS3LmJQVIo=;
        b=YkA8Y+YPgokpueG2EzlrZH3y2nXN6zyGDXc1ngnf8ej5QDgthgCQiTNB7aCB3yQzHX
         BG7sxGFkuLAEQM0VuPRD5qb7OTQvY0W/3kD5OmiiEoJtEJ/W++4q/vMZRLqS5emKyWEm
         BNvgtEHbwMul33dV4ECsW91dRAHrQ/qge4/tA7Jn0VViADlXtXwzwMYQ/n/n0zDifQd0
         eAEfkpyiRuFXbfRepv1fsj1WMc2ytunBAl6peAfwWsqfoZdajMluM+hb+WGPGgMnoVYc
         AQ0PAjvp9QkJU9hyo2ij6lsntnyzmuvyX0y64vKHX8UpOpqdCmGC31ThYkoNpWfDipqf
         IcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013367; x=1740618167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVTcMOsra+Zlj/NG7dWllagtUZ69SiTounS3LmJQVIo=;
        b=THmHqhgWCztkVPPc2M5Sw3dYIha1Dygn+ac7GaebjmsGUopNR93iERCDwGDMVzHxwb
         piA9zs0dFlNDYbnqq2ycLxMAYgF5KaEIZaewwet5RzrBDb95VvochIMbN+FK5V2FAAZJ
         EqFxyvvefpmPPVbVJybeFBGZb30CCLCCbP5beMkbZFWDE5cy+W51ZmOjhC75+8Sv4Mst
         R+cfQ4o1rfz/88SyndslHYDjs/hvKyBbjx/wKxIhNhVvod27U85Sm5yO+6LKNO7kHKeX
         GTB0lK2MaW0sTU9Oyps2073w2V0Sq1SNQSGxgPAgz0XLYLmBGHvDO51RmoUTTWd5acf8
         Xb1A==
X-Forwarded-Encrypted: i=1; AJvYcCVWauQONOjbfiXINvGALg2pzIJ41GGtM2++MKtP5s8QtJaKq51Nxuz31XCL4/xRT9NidZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLc8hHl6LXdH72EGfCTOlp8SWE1fjHGjg1YERtACEmgvMtKs3Y
	9z022pX0NJY8h53fUzQg/b34fo/UKQ4pAtWI1Gmb7+5U8T8cH42x/7so3Hk2sQOrsBEyesLmCLR
	8eoH8h9Npuu7rTpt2Bxc14p+RChM=
X-Gm-Gg: ASbGnct6HYTWqaD9SCM92eyE+t7f351UwDfoTAuVNF25zEw1nhZM68QM59iHXzGQSzl
	u2FiGEy5XcpfXm7T1LpYkVYViywqAmJdWAhioGzUqMDTeAntE1MT1bugGhCCvB3uKrkM+U3ewEo
	NYm8/0Y9xYeBl0
X-Google-Smtp-Source: AGHT+IFqcbKwoplFU/mD7j1kk+bDxgBsJghwRlT7khsWXCOjWNsO9utyBNm7gxLGUJtVgN+dObdECRi/pIgCJ96d6V8=
X-Received: by 2002:a17:90b:33d2:b0:2fc:2a9c:21de with SMTP id
 98e67ed59e1d1-2fcb5abe20dmr9040184a91.35.1740013366909; Wed, 19 Feb 2025
 17:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213152125.1837400-1-linux@jordanrome.com> <20250219161821.6f05272f1a3131ddfe978865@linux-foundation.org>
In-Reply-To: <20250219161821.6f05272f1a3131ddfe978865@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 19 Feb 2025 17:02:35 -0800
X-Gm-Features: AWEUYZmGu7u0zYNUgfweDK5lveU6SluqZCoNdu4Xwgaq-JX0mEaOJ5M-NzYN9-8
Message-ID: <CAEf4BzaqOzCaaU+M2wPDbrCq9L4Tf6RwRgY3iVv91mMstOzByQ@mail.gmail.com>
Subject: Re: [bpf-next v8 1/3] mm: add copy_remote_vm_str
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:18=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 13 Feb 2025 07:21:23 -0800 Jordan Rome <linux@jordanrome.com> wro=
te:
>
> > Similar to `access_process_vm` but specific to strings.
> > Also chunks reads by page and utilizes `strscpy`
> > for handling null termination.
> >
> > The primary motivation for this change is to copy
> > strings from a non-current task/process in BPF.
> > There is already a helper `bpf_copy_from_user_task`,
> > which uses `access_process_vm` but one to handle
> > strings would be very helpful.
> >
> > ...
> >
> >  include/linux/mm.h |   3 ++
> >  mm/memory.c        | 122 +++++++++++++++++++++++++++++++++++++++++++++
> >  mm/nommu.c         |  76 ++++++++++++++++++++++++++++
>
> Is there any way in which we can avoid adding all this to vmlinux if
> it's unneeded?
>
> Any such ifdeffery would of course need removal or alteration if
> callers other than BPF emerge.
>

yeah, it's a straightforward #ifdef CONFIG_BPF_SYSCALL guard, I'll add
it while applying

> > ...
> >
> > +/*
> > + * Copy a string from another process's address space as given in mm.
> > + * If there is any error return -EFAULT.
> > + */
> > +static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long ad=
dr,
> > +                           void *buf, int len, unsigned int gup_flags)
> > +{
> > +     void *old_buf =3D buf;
> > +     int err =3D 0;
> > +
> > +     *(char *)buf =3D '\0';
> > +
> > +     if (mmap_read_lock_killable(mm))
> > +             return -EFAULT;
> > +
> > +     /* Untag the address before looking up the VMA */
> > +     addr =3D untagged_addr_remote(mm, addr);
>
> Well that's a crappy little comment which you copied-n-pasted.  It
> tells us "what" (which is utterly obvious) but not "why".  whodidthat.

:) dropped the comment, but yeah, it's coming from
__access_remote_vm(), of course. Seems other users of
untagged_addr_remote() don't bother leaving comment, so dropping the
comment seems appropriate (and anyone can actually read more expanded
comment in include/linux/uaccess.h, if curious)

>
> > +/**
> > + * copy_remote_vm_str - copy a string from another process's address s=
pace.
> > + * @tsk:     the task of the target address space
> > + * @addr:    start address to read from
> > + * @buf:     destination buffer
> > + * @len:     number of bytes to copy
> > + * @gup_flags:       flags modifying lookup behaviour
> > + *
> > + * The caller must hold a reference on @mm.
> > + *
> > + * Return: number of bytes copied from @addr (source) to @buf (destina=
tion);
> > + * not including the trailing NUL. Always guaranteed to leave NUL-term=
inated
> > + * buffer. On any error, return -EFAULT.
> > + */
> > +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> > +             void *buf, int len, unsigned int gup_flags)
> > +{
> > +     struct mm_struct *mm;
> > +     int ret;
> > +
> > +     if (unlikely(len < 1))
> > +             return 0;
>
> I wonder if this can ever happen.  And if it does, should it WARN?  And
> returen -Efoo?

so this was not meant to catch negative len (that's assumed invalid
API usage), it was more about handling len =3D=3D 0 case, which is legal
for access_remote_vm(). So I fixed it up to `if (unlikely(len =3D=3D 0))
return 0;`  explicitly to keep behavior consistent with
access_remote_vm().

>
> > +     mm =3D get_task_mm(tsk);
> > +     if (!mm) {
> > +             *(char *)buf =3D '\0';
> > +             return -EFAULT;
> > +     }
> > +
> > +     ret =3D __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> > +
> > +     mmput(mm);
> > +
> > +     return ret;
> > +}
>

