Return-Path: <bpf+bounces-49805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46BA1C3AB
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 15:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11434168F5D
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 14:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D7C2C1A2;
	Sat, 25 Jan 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="13DxjDJC"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B812208D0
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737813735; cv=none; b=qbIGGReu8Z6vrC4mKJ9Vx0wrzyBRkWnc03Me+zl93sciO+E1JhBf7izDf3KFzW+XgDoNtDFbIcoEV9uRSazBo5Z5SvXDvm/FJFg2o3tbzhFisP+UIj+TwRpyn3bUbu6qKrS3rdUtOEyYbEYBMJeCNBTa9TvOMXubgB3JYLizeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737813735; c=relaxed/simple;
	bh=Z7KW7hGpC/vEHRFvXd1cQKpvirnueSbzXHCCQEkOjbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXIekD+DgBN4iUInjhB34XtzeM9UjmcOI4hA0RElU4p2CV9Cez6qknc2VqIhK6ZCT3viubJoest5fSyDij00s4G3DoDR0RKXnl3wSQdC+tdlX3pS2iN70WYcMY7aSqrZNjGy4+lAOw+WxWg6CBki2x6vH9xI0P8jQUk+yeZGwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=13DxjDJC; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1737813731; x=1738418531; i=linux@jordanrome.com;
	bh=rYf1KXUNG30BcbFQzSpNBwFqJgAn9teGb0jTJqlGBfg=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=13DxjDJCYipi/k6vbTRJG7A7xWgcd56z8C9a2WbWegtxouvQpCKoq/+wnU2v6HBq
	 VzimlDbspMfh2E/54VWPP7qCQ7pZ1pDeietwLIOLdepcTSpbjoxCSeEI5Lj0d0VRJ
	 t0wms8B4BFxKI6Iq/ebtgi78t652877j4jpoXs+7BflYtkKShbcW/I/GmfApeWxOu
	 +ioAhj+WeIMMsQakJCdXkvj0QPtIZ9IyjsWER5YxJoYlUP7W3JAi71uzVLEO5A+Mp
	 /IlQNq1Ji56J8OXVwAp8wBH/dcLlj6MXbR4ZNz/Lsv1HqRZ3h5Ow4ie99pwicVT4Y
	 7R+vC6KXcDZf4PIOFQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f177.google.com ([209.85.166.177]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Me96G-1tqTEr0kVa-00RfZf for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 15:02:11
 +0100
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so3678775ab.2
        for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 06:02:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yw1fO9K0yX8ZvlMA43MIyr2c6oBksUCklZl5CGnIq14OykvHxUx
	t5I5AxYbu2zk92HCCOfsmcipUU7+B5yVWDy4oVXZXRkOWCcMMRvpNXh09wu5O9Tf/mmP4Zudze4
	JxM79iK2viZSOaXOxJkZwxPfLDtU=
X-Google-Smtp-Source: AGHT+IE5GrCHOzylD7RLBeNyEdIR9FJzPs5p/pyF2/z1RwtKgiEmMbCj6K0TFEd/nTQODRRPSQ5UH2wseoHxEnWuA6c=
X-Received: by 2002:a05:6e02:1d88:b0:3a7:e452:db5 with SMTP id
 e9e14a558f8ab-3cf744788cfmr290655085ab.15.1737813730652; Sat, 25 Jan 2025
 06:02:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124181602.1872142-1-linux@jordanrome.com> <CAEf4Bzb9EOwQnzCL4j6vGFdJ-hgPXif5Z8iXUT-sKvf+bgTfEg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb9EOwQnzCL4j6vGFdJ-hgPXif5Z8iXUT-sKvf+bgTfEg@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Sat, 25 Jan 2025 09:01:59 -0500
X-Gmail-Original-Message-ID: <CA+QiOd7i7xjQhyjfaOfTMhZZ=x_-kpdDaA7pvcs1ZuEFgErFcQ@mail.gmail.com>
X-Gm-Features: AWEUYZlmuiSI9JYAQZJlAfxa8d14eIKfXKn-YrZ4ah-wQ5bmO4uRGJZWzsMzhFA
Message-ID: <CA+QiOd7i7xjQhyjfaOfTMhZZ=x_-kpdDaA7pvcs1ZuEFgErFcQ@mail.gmail.com>
Subject: Re: [bpf-next v3 1/3] mm: add copy_remote_vm_str
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K58to31bYV0jTxbYp+FiACOKPZC+p62SQL9ox26xX75eo0MurOw
 iHxSz7Ddl2673nMo4LuM0MQ0SaEMwQwkjgek9+23JRNz6q8Ga7NwvqbhgVABTDKXou2y8yH
 o54MEhThol9mPyTSrBmoB1SKzvE6A/8U2kBwU1AG8DUCrC4ItMugJGemMxxC3dnNUrD2GqI
 ZMu1nBCPVMPRXKnoZyJwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hzWOnCmSb/M=;iabz7Mqwa75417KqSuHMBcosD9g
 oifQXqPe5ZRVCuXA0526uSKTuf7q09RjvFyet5Nu9XrlQ4X5PNxOryPp8pfS+ucHzHkWA8GCn
 vMSfHUJRY9jpDzvCQmPLEogZdNApcwcCejo4ALXqp/MFjWx7mggmXqdrFg8lQlDIpvi8SEEwi
 dqHF6dSAGUqbjjceo5Zz7TQW0TTkrRNkQ+F3iDz+UbPls8rcfwX/uewJZQr7V+aFz41oESLdB
 hdav9+TpS+tMLUiCzNCXAxbaCZzgp05zpLEIabcB/bgpHmjhy7H7VhB3gXtxQ3V06n2XEeim0
 kzbTFMOqPPSBtGZCq4+10AWFH/eg74OfGXQjxOHDNU8Z22rNaHHMwQR9L6j4iyvoz7ZIYJo3+
 8g7XrPVyJbgw4u4jNF5dOw6HN58QcNQh5YZ9aTREOjfU86WRUthqs7OeL7778FOs/L8/N+2d8
 gpCNIt7MwrcUDIoYHE1z+O4RSFHjblsaGcc8MCI193AuAKoaNzoddXTV/TBFxHoidOJr9DZEv
 ZkvS42SDYM0VqTB6Gki+/vekNnmA1fowaobSo/KfTb/fgIxDgPXM/70GQ05ukgY20ALlYWwar
 gw9YChmpd1FTn2EZRlnx0vH2z3ARiL9geK/sr3vLhN7RXcg3tZHnO48OX+hfPjjSjhoT8Pj8+
 v/au4rynNGGMIfPLzxMBY75rjIpeHhm4mwdsifpVaJPsYDwEQkRWqv0IJcZYV4o2IOHaI3H8S
 EWaxJ/6VHb2yIOvFSPHYkLtCx9hGWIZlzFUz510rXUEZEGvpzpx9i94wga060kJPOxjOaz3+Y
 5wn8QxGddQ2sa3bu2XBgKPpGFzzzJ7h2/c6KY3N7qZ9+gypD9cXMnXImw86/Q1kmMgQM14eT8
 ONy7J3cpeeuNgrYQT6c8nTyGpkx4cHZolrKntN8lgfGKjpUYJllKEgzDCMMiKl9rqt6qp+bon
 tmNkLOp/MWkNJ2L1WMyMswH6fPqnBZ8cTHjIGd5KCDB3tPR6RbQGpuHJFH28KQY8ZZjddg/la
 jivcqlIJ9C+jowhCZI+R6odwqooR3mVoxVHIIrhRcfD4d/E1nbM2GAjsnfkd7IJeT4wxZ/Lfu
 mBYchivTiQcEgjcCRzEtN7fb0iYBk75WZWg3vZOkvX2pcWC4Y1e94Eo7qxpVE1wlpwgcc5sYl
 e7QdqFyIrhx3flpadOrDI55+oCBGsLBFR+M1k42LATXumP4m8PXH0W6zLO5hZgeemZ/1sYqoV
 comYj3b8yJcKDKgzQDIqhI0tupFSgqmy9g==

On Fri, Jan 24, 2025 at 7:09=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 24, 2025 at 10:22=E2=80=AFAM Jordan Rome <linux@jordanrome.co=
m> wrote:
> >
> > Similar to `access_process_vm` but specific to strings.
> > Also chunks reads by page and utilizes `strscpy`
> > for handling null termination.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  include/linux/mm.h |   3 ++
> >  mm/memory.c        | 119 +++++++++++++++++++++++++++++++++++++++++++++
> >  mm/nommu.c         |  68 ++++++++++++++++++++++++++
> >  3 files changed, 190 insertions(+)
> >
>
> [...]
>
> > +               maddr =3D kmap_local_page(page);
> > +               retval =3D strscpy(buf, maddr + offset, bytes);
> > +               unmap_and_put_page(page, maddr);
> > +
> > +               if (retval > -1 && retval < bytes) {
> > +                       /* found the end of the string */
> > +                       buf +=3D retval;
> > +                       goto out;
> > +               }
> > +
> > +               if (retval =3D=3D -E2BIG) {
>
> nit: strscpy() can't return any other error, so I'd structure result
> handling as:
>
> if (retval < 0) {
>   /* that annoying last byte copy */
>   retval =3D bytes;
> }
> if (retval < bytes) {
>     /* "we are done" handling */
> }
>
> /* common len, buf, addr adjustment logic stays here */
>

Ack. Actually, I thought of a way to make this cleaner
and correct.

>
> but also here's the question. If we get E2BIG, while bytes is exactly
> how many bytes we have left in the buffer, the last byte should be
> zero, no? So this should be cleanly handled, right? Or do we have a
> test for that and it works already?
>

Ok, I found an inconsistency that gets handled in the BPF helper
`bpf_copy_from_user_task_str`, which I'm going to fix in the next
version of this patch.

Let me explain how this function is SUPPOSED to work
and enumerate some different test cases (a lot of which are in commit 3).

Note1: all of the target strings
are null terminated (if you try to copy a string that's not null terminated
you may accidentally copy junk).

Note2: strscopy returns E2BIG if the len requested isn't as long
as the string INCLUDING the nul terminator. So if you want to copy
"test_data\0" you need to request 10 bytes not 9. And if you request
10 or anything greater it returns 9.

Note3: This function, as opposed to the bpf helper calling
this function, returns the number copied NOT including the nul terminator.

So... the target string is "test_data".

Request 10 bytes, return 9.
Request 2 bytes, return 1.
Request 20 bytes, return 9.

Now, let's say this string falls across a page boundary
where "_" is the last character in the page.

Request 10 bytes, which becomes a request
for 5 bytes for the first page. strscopy returns E2BIG
and copies "test\0" into the buffer. We copy the last
bytes of the page into the buffer, which is the "_",
and then  request 5 more bytes on the next page,
copying "data\0" and strscopy returns 4. Return 9.

Now let's say the last "a" is the last character on the page.
Request 10 bytes, which becomes a request
for 9 bytes. strscopy returns E2BIG and copies "test_dat\0"
into the buffer. Once again we copy the last byte
of the page into the buffer, which is "a"
and we request 1 more byte of the next page, which
is the nul terminator. strscopy returns 0 and this
function returns 9.

Again note, that this version of the code has a bug
that is "handled" by the bpf helper and I'm going to fix.

> > +                       retval =3D bytes;
> > +                       /*
> > +                        * Because strscpy always null terminates we ne=
ed to
> > +                        * copy the last byte in the page if we are goi=
ng to
> > +                        * load more pages
> > +                        */
> > +                       if (bytes < len) {
> > +                               end =3D bytes - 1;
> > +                               copy_from_user_page(vma,
> > +                                               page,
> > +                                               addr + end,
> > +                                               buf + end,
>
> you don't need the `end` variable, just use `bytes - 1` twice?
>
> > +                                               maddr + (PAGE_SIZE - 1)=
,
> > +                                               1);
> > +                       }
> > +               }
> > +
> > +               len -=3D retval;
> > +               buf +=3D retval;
> > +               addr +=3D retval;
> > +       }
> > +
> > +out:
> > +       mmap_read_unlock(mm);
> > +       if (err)
> > +               return err;
> > +
> > +       return buf - old_buf;
> > +}
> > +
> > +/**
> > + * copy_remote_vm_str - copy a string from another process's address s=
pace.
> > + * @tsk:       the task of the target address space
> > + * @addr:      start address to read from
> > + * @buf:       destination buffer
> > + * @len:       number of bytes to transfer
> > + * @gup_flags: flags modifying lookup behaviour
> > + *
> > + * The caller must hold a reference on @mm.
> > + *
> > + * Return: number of bytes copied from @addr (source) to @buf (destina=
tion).
> > + * If the source string is shorter than @len then return the length of=
 the
> > + * source string. If the source string is longer than @len, return @le=
n.
> > + * On any error, return -EFAULT.
>
> strncpy_from_user_nofault() doc says:
>
>   On success, returns the length of the string INCLUDING the trailing NUL
>
> Is this the case with copy_remote_vm_str() as well? I.e., if the
> source string is 5 bytes + NUL, dst buf is 10. Will we get 5 or 6
> returned? We should be very careful with all this +/- 1 business in
> corner cases, too easy to mess this up.
>

Explained above.

> > + */
> > +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> > +               void *buf, int len, unsigned int gup_flags)
> > +{
> > +       struct mm_struct *mm;
> > +       int ret;
> > +
> > +       mm =3D get_task_mm(tsk);
> > +       if (!mm)
> > +               return -EFAULT;
> > +
> > +       ret =3D __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> > +
> > +       mmput(mm);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> > +
>
> [...]

