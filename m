Return-Path: <bpf+bounces-37184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE86951F96
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A781C2185A
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8A21B9B42;
	Wed, 14 Aug 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6bsfOlF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9481B86DA
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652082; cv=none; b=kIG+HnrXgMYcoc6CzL8EyAo52vK1/Xj215oBV7728dmONCfvTeHwB8T91buUH4u+7G+CiycBZ8zCWLhFfOpn722VxIa5As8gEVCF4VV/R2nKoDUBcFefKjxnUXe2xnlgyeqFCu6vpurpJ+9lDZSwEKU5BcFSXBc7vKszYt65cSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652082; c=relaxed/simple;
	bh=1gR7IPGJlvDuH9OGf4O4TKswFpP6LwMPMY2YDmqcZhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0ksie5FKss9VbHoEa94hxKrZIGynrBE/6TBeK7aUfWTzIsEIVR6F3ppDlSFX38xbLpYkB0KVDleISTO+swa2Nv/hRjzklhwftjaJg7bb/GJykfO9emGim9aNOWUDM5k7mS8Wlk+1twyrwQHWFiIC1YzSK/uai0ZgHoQcDOJvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y6bsfOlF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so7646a12.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723652078; x=1724256878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bQ9j9ErtrrpZhSLzeUe548UlFsO7KLb0/TyLtNcWJw=;
        b=Y6bsfOlFnrM681/3d/iqNng48eYUH2/3fxGvd1bip/5D70uhu/GyEUXi4dJ4BJTsV8
         iDJxh8vz3zqBMkfPRYAXED+FfWtM3OXeI9iWoBcPddFwIdt9L/rFZc0vDXiKsTsQKgY+
         s5A/F5wZNsgIDkiQT/kRNgJ2zCTbH8Ge/1TnRpTnZWc17goih2AlA0l5w4H3+jmmXh3f
         Fg6FYIjoMqbd8r8Gos/GFq8p2ZXiY/faQfzKGimgEYREspLO8+KYMooQe0xZ1AOb0Jiy
         cT+skCXnNy5eWhN3NP8pvDLOOpEhh9j4UsW78PENIUSD1Bs/S7uRjmgf3LpHV/Yo1+x4
         Ls3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723652078; x=1724256878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bQ9j9ErtrrpZhSLzeUe548UlFsO7KLb0/TyLtNcWJw=;
        b=vB66SDD7mKGLAgKD86jUsiMzTgoT/bV67zTbkxYgz/7u54N2qyXuvxTHX5xAz755Do
         DmWfFLAz1bLGoCf9KG8aiIDY3QZ2MxEDBFvDBgnG5WiBpSyoISuaRXJRHUQ8r2wqdnmm
         SxVX/gd3TwF80F8Anc7TVrhMAzhKzSyexpjIBHClxIBoeVY/a7JzD9CghpulefvIZz53
         73SKzc7hNNp9skG1G9/YPTAT8yy+nNd3hz4US9AuqwlM3i22lFLxVEKggBkNZh/XsbME
         UcMrCsg7jWQbcZjOOslVS6AculbKvFG1tzLkNP/rbG1jSmgY5mzUvCq+uGf2WAp3LI8E
         V6QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRY1wa2DCMfIj7giV/dFIf8wWCAD/Kbuuf4e+npv55enAuYQNF4V5Wk1sAq0ii/dnOr9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBccsSjD1YHk4grMZ+9+9mA8CcViBBe5sxsed1/DLWPDi1bLR
	bloRlFBUGw25GRrjOB6k+BZZrMGju/J12LbZI1KtecniWLCMw/MBG8v+QfXVrkz78CrJEuUhA7I
	9hWukJ9k43Hu4KxYh0kITFo4kNi5cCoPcXXni
X-Google-Smtp-Source: AGHT+IEDxZPD3vJxwWTsDeOPtGLySgwgkgr6dRkg5BY1PBUpXws7SIHVDHMiXTM6viwfIH4s0+WA4qXy/HT+Mlhdu7E=
X-Received: by 2002:a05:6402:50cf:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5bea55635d8mr87569a12.5.1723652077454; Wed, 14 Aug 2024
 09:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813002932.3373935-1-andrii@kernel.org> <20240813002932.3373935-2-andrii@kernel.org>
 <CAG48ez1oUas3ZMsDdJSxbZoFK0xfsLFiEZjJmOryzkURPPBeBA@mail.gmail.com> <CAEf4BzZa9Rkm=MAOOF58K444NAfiRry2Y1DDgPYaB48x6yEdbw@mail.gmail.com>
In-Reply-To: <CAEf4BzZa9Rkm=MAOOF58K444NAfiRry2Y1DDgPYaB48x6yEdbw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 14 Aug 2024 18:13:59 +0200
Message-ID: <CAG48ez0QdmjJua8V4RPhs2WmuGGhD++H-e2vacfP1=2jVgCy+w@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:21=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Aug 13, 2024 at 1:59=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Tue, Aug 13, 2024 at 2:29=E2=80=AFAM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > > Harden build ID parsing logic, adding explicit READ_ONCE() where it's
> > > important to have a consistent value read and validated just once.
> > >
> > > Also, as pointed out by Andi Kleen, we need to make sure that entire =
ELF
> > > note is within a page bounds, so move the overflow check up and add a=
n
> > > extra note_size boundaries validation.
> > >
> > > Fixes tag below points to the code that moved this code into
> > > lib/buildid.c, and then subsequently was used in perf subsystem, maki=
ng
> > > this code exposed to perf_event_open() users in v5.12+.
> >
> > Sorry, I missed some things in previous review rounds:
> >
> > [...]
> > > @@ -18,31 +18,37 @@ static int parse_build_id_buf(unsigned char *buil=
d_id,
> > [...]
> > >                 if (nhdr->n_type =3D=3D BUILD_ID &&
> > > -                   nhdr->n_namesz =3D=3D sizeof("GNU") &&
> > > -                   !strcmp((char *)(nhdr + 1), "GNU") &&
> > > -                   nhdr->n_descsz > 0 &&
> > > -                   nhdr->n_descsz <=3D BUILD_ID_SIZE_MAX) {
> > > -                       memcpy(build_id,
> > > -                              note_start + note_offs +
> > > -                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf32=
_Nhdr),
> > > -                              nhdr->n_descsz);
> > > -                       memset(build_id + nhdr->n_descsz, 0,
> > > -                              BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> > > +                   name_sz =3D=3D note_name_sz &&
> > > +                   strcmp((char *)(nhdr + 1), note_name) =3D=3D 0 &&
> >
> > Please change this to something like "memcmp((char *)(nhdr + 1),
> > note_name, note_name_sz) =3D=3D 0" to ensure that we can't run off the =
end
> > of the page if there are no null bytes in the rest of the page.
>
> I did switch this to strncmp() at some earlier point, but then
> realized that there is no point because note_name is controlled by us
> and will ensure there is a zero at byte (note_name_sz - 1). So I don't
> think memcmp() buys us anything.

There are two reasons why using strcmp() here makes me uneasy.


First: We're still operating on shared memory that can concurrently change.

Let's say strcmp is implemented like this, this is the generic C
implementation in the kernel (which I think is the implementation
that's used for x86-64):

int strcmp(const char *cs, const char *ct)
{
        unsigned char c1, c2;

        while (1) {
                c1 =3D *cs++;
                c2 =3D *ct++;
                if (c1 !=3D c2)
                        return c1 < c2 ? -1 : 1;
                if (!c1)
                        break;
        }
        return 0;
}

No READ_ONCE() or anything like that - it's not designed for being
used on concurrently changing memory.

And let's say you call it like strcmp(<shared memory>, "GNU"), and
we're now in the fourth iteration. If the compiler decides to re-fetch
the value of "c1" from memory for each of the two conditions, then it
could be that the "if (c1 !=3D c2)" sees c1=3D'\0' and c2=3D'\0', so the
condition evaluates as false; but then at the "if (!c1)", the value in
memory changed, and we see c1=3D'A'. So now in the next round, we'll be
accessing out-of-bounds memory behind the 4-byte string constant
"GNU".

So I don't think strcmp() on memory that can concurrently change is allowed=
.

(It actually seems like the generic memcmp() is also implemented
without READ_ONCE(), maybe we should change that...)


Second: You are assuming that if one side of the strcmp() is at most
four bytes long (including null terminator), then strcmp() also won't
access more than 4 bytes of the other string, even if that string does
not have a null terminator at index 4. I don't think that's part of
the normal strcmp() API contract.

