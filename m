Return-Path: <bpf+bounces-49879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D749BA1DCA7
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 20:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC40E7A206A
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D019258E;
	Mon, 27 Jan 2025 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtgE6aq8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A5419007F
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005676; cv=none; b=DEt7FxCXO7F6rRhn7O1TiI4T6DGo2SkAM56hqVZu/xtR22mT5mibNFsRkbSvAL/Nn2JDw11Nq2d27suxP8yD+21xJkGZ4KRiIZugc6sU+UtsIkeQnc+aOdw7380JTqAatABo0FJ41dzLMK5nG+1CP27CKUxRmkX32kRt7CrFi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005676; c=relaxed/simple;
	bh=FBZP8mO+bZoOT9YhWpByvEeaNlU0pBhX8nlF2g+m2iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOLS3TYTAjMkJWbDEVjjO2lnfVHs1jwpUBAQc3XC2eV/2PhhZYwbURf4ekuJfHVP4sY3BiCYsIfIOxkLU4wSZa8gqJdeP9hZneS7moq90sBQXRnIldlXn3ca/nZDsYhcaraDkdJD2/8ZLue242VUlXG+ENELqcJeg6ZubNY/2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtgE6aq8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216426b0865so79807925ad.0
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 11:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738005674; x=1738610474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNopMD8bxFrUq1IsZsiT99nre+ljuZTk7nAPSQpUuPI=;
        b=YtgE6aq8j9VloosjENocnqT6AtEeY08y8cYWFsXqdaQ7yC/sfSqk8d4DH/LqtHv0oM
         3wyeAY85ZCeAaMJFcr+qymN/lMjpKEOgPPxhYl8v7qDm7YkBWMACctDYg/JhMDdIInfH
         0Dzqd1qtsThoruFAD3Kh2damynh47++aXtCCqI21siz1v4+C/WwXHMugOAiboEQK4nGF
         wQcNmY/9zq5ZiNFnDJcE9MJvRPSm+6fhu6rX8oUgr7iNfuaOn66oJkqoVi/QjbPI52WB
         2KqmBtE/6xVcYtuG9Fa1u/dhoYsoHyWsaCORwgHdUYwGa72Wa0Y8G5c+xCiK6zp1FgYC
         9zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738005674; x=1738610474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNopMD8bxFrUq1IsZsiT99nre+ljuZTk7nAPSQpUuPI=;
        b=uczdw8Kb7fz6jN0dgUZVZhkYMZjP1KGM64XSadDQ0seM009N+M4BoFu5IxyH01Oynj
         DIed/UChz4yu8+K7Yv3gegwvDT7w1maN/gYbJ8NSNlF1ZTHSliKh1S9QKrgi/s1GLR13
         erRqQ82IJMG5aG6BULCkxQQDAWW6nE6/6dY9fIrW19CmyT7tRC60mFkk+7rKmfUN/p9Z
         hDtsQup9vXYNLaOX5Ma1hQx0bwLztRMnicaJbSjl7+eRG4SV1SzK35+pwR7CoqKWRwnu
         vThvoWrWoXeRMEaIBkfb83SDs1Oa6L+V3G+Ro0YbEAc4mFAEy2MYLWDAvdSewKVnV4Ck
         RcZQ==
X-Gm-Message-State: AOJu0YxYA5NTyOYsivEa2IXyOcq6NiVXQhASSBS1p6U2cBdXAl3NKye7
	zuO9KC6LdMswlC31CDufdK9pDaKP5gOH40zgRcWc/zOD3gojDLBgQ9bRkyjc07gJ6st5HHZv0HW
	M7HE+swPDXmxFA7ZG/RWGNd97YzQ=
X-Gm-Gg: ASbGncubUdsRTkwr2GUaJ9LRECrq3HiuvcKfuKPoqt1/jQe1V/Wo3X2gc5TspmHXbsV
	x+SfbyGDyWN4jTQi1JXYLWMtWVOWTQFDWg6gBifnq8yKUvDSje1fKtQMU7bjX7CKv+HciybQKW/
	1qUA==
X-Google-Smtp-Source: AGHT+IGRCr/wIjb/0gdZpCqJWXQ1D02zXueEkzLpFPZAUdLCZ0Q2U5abQO9U7aXNEJY2hi0z7CKA2pOjbXbJx8L31wQ=
X-Received: by 2002:a05:6a21:3388:b0:1e1:a9dd:5a68 with SMTP id
 adf61e73a8af0-1eb2145db73mr67058622637.1.1738005673604; Mon, 27 Jan 2025
 11:21:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124181602.1872142-1-linux@jordanrome.com>
 <CAEf4Bzb9EOwQnzCL4j6vGFdJ-hgPXif5Z8iXUT-sKvf+bgTfEg@mail.gmail.com> <CA+QiOd7i7xjQhyjfaOfTMhZZ=x_-kpdDaA7pvcs1ZuEFgErFcQ@mail.gmail.com>
In-Reply-To: <CA+QiOd7i7xjQhyjfaOfTMhZZ=x_-kpdDaA7pvcs1ZuEFgErFcQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 11:21:01 -0800
X-Gm-Features: AWEUYZnvyfPel3phqu1es4xEAOyK4NuRwd4Gnqr0Bf8_-ahK2n9mBPDT-6n5-cM
Message-ID: <CAEf4BzZE=VVdQZDr1Mzow0TqKyFejXznfaXMBt9QbviN5Gj99g@mail.gmail.com>
Subject: Re: [bpf-next v3 1/3] mm: add copy_remote_vm_str
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 6:02=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> On Fri, Jan 24, 2025 at 7:09=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 24, 2025 at 10:22=E2=80=AFAM Jordan Rome <linux@jordanrome.=
com> wrote:
> > >
> > > Similar to `access_process_vm` but specific to strings.
> > > Also chunks reads by page and utilizes `strscpy`
> > > for handling null termination.
> > >
> > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > ---
> > >  include/linux/mm.h |   3 ++
> > >  mm/memory.c        | 119 +++++++++++++++++++++++++++++++++++++++++++=
++
> > >  mm/nommu.c         |  68 ++++++++++++++++++++++++++
> > >  3 files changed, 190 insertions(+)
> > >
> >
> > [...]
> >
> > > +               maddr =3D kmap_local_page(page);
> > > +               retval =3D strscpy(buf, maddr + offset, bytes);
> > > +               unmap_and_put_page(page, maddr);
> > > +
> > > +               if (retval > -1 && retval < bytes) {
> > > +                       /* found the end of the string */
> > > +                       buf +=3D retval;
> > > +                       goto out;
> > > +               }
> > > +
> > > +               if (retval =3D=3D -E2BIG) {
> >
> > nit: strscpy() can't return any other error, so I'd structure result
> > handling as:
> >
> > if (retval < 0) {
> >   /* that annoying last byte copy */
> >   retval =3D bytes;
> > }
> > if (retval < bytes) {
> >     /* "we are done" handling */
> > }
> >
> > /* common len, buf, addr adjustment logic stays here */
> >
>
> Ack. Actually, I thought of a way to make this cleaner
> and correct.
>
> >
> > but also here's the question. If we get E2BIG, while bytes is exactly
> > how many bytes we have left in the buffer, the last byte should be
> > zero, no? So this should be cleanly handled, right? Or do we have a
> > test for that and it works already?
> >
>
> Ok, I found an inconsistency that gets handled in the BPF helper
> `bpf_copy_from_user_task_str`, which I'm going to fix in the next
> version of this patch.
>
> Let me explain how this function is SUPPOSED to work
> and enumerate some different test cases (a lot of which are in commit 3).
>
> Note1: all of the target strings
> are null terminated (if you try to copy a string that's not null terminat=
ed
> you may accidentally copy junk).
>
> Note2: strscopy returns E2BIG if the len requested isn't as long
> as the string INCLUDING the nul terminator. So if you want to copy
> "test_data\0" you need to request 10 bytes not 9. And if you request
> 10 or anything greater it returns 9.

yeah, that's actually smart for strscpy() to have this protocol, it
allows to read full string and know that it's full (if the string fits
exactly into the dst buffer). But I think on the BPF side we have a
convention to return the size *including* the NUL byte, so we get a
bit of inefficiency. But oh well, I think consistency is better to be
maintained.

>
> Note3: This function, as opposed to the bpf helper calling
> this function, returns the number copied NOT including the nul terminator=
.
>
> So... the target string is "test_data".
>
> Request 10 bytes, return 9.
> Request 2 bytes, return 1.
> Request 20 bytes, return 9.
>
> Now, let's say this string falls across a page boundary
> where "_" is the last character in the page.
>
> Request 10 bytes, which becomes a request
> for 5 bytes for the first page. strscopy returns E2BIG
> and copies "test\0" into the buffer. We copy the last
> bytes of the page into the buffer, which is the "_",
> and then  request 5 more bytes on the next page,
> copying "data\0" and strscopy returns 4. Return 9.
>
> Now let's say the last "a" is the last character on the page.
> Request 10 bytes, which becomes a request
> for 9 bytes. strscopy returns E2BIG and copies "test_dat\0"
> into the buffer. Once again we copy the last byte
> of the page into the buffer, which is "a"
> and we request 1 more byte of the next page, which
> is the nul terminator. strscopy returns 0 and this
> function returns 9.

so I was worried about the situation where the string is test_data|\0,
like you describe (where | is denoting page boundary, NUL is right
after the page end), and we request 9 bytes (not 10 like in your
example). By manually copying that "a" (last byte of the page), we
might not return zero terminated dst buf (that was my theory). Would
be good to have a test proving otherwise.

But I'll go and read the latest version, maybe I'm overthinking this.

>
> Again note, that this version of the code has a bug
> that is "handled" by the bpf helper and I'm going to fix.
>
> > > +                       retval =3D bytes;
> > > +                       /*
> > > +                        * Because strscpy always null terminates we =
need to
> > > +                        * copy the last byte in the page if we are g=
oing to
> > > +                        * load more pages
> > > +                        */
> > > +                       if (bytes < len) {
> > > +                               end =3D bytes - 1;
> > > +                               copy_from_user_page(vma,
> > > +                                               page,
> > > +                                               addr + end,
> > > +                                               buf + end,

[...]

