Return-Path: <bpf+bounces-76885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E9CCC90A0
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA79E30463B5
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD601E5B7B;
	Wed, 17 Dec 2025 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbKuCzrC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB00318E1F
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991426; cv=none; b=oK0tMN8J7yCB+LQBtjbnNu88i8lyNODFJTUuhBOtAwOGrQWcEtYxnOEJWWMHipfFaGfxbhkcCeH7JHSMpL6KDbBWLMAaSY3uzdwzSnFrY7hLzb3HOZsActNJOdussBv7ED2fLPQi7gt3RrbAHuoeTrlXj9FZbnW/+s6Nl0+WPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991426; c=relaxed/simple;
	bh=gy9Z/G35tdZe/YHnIPa+kozJQtLqnJDKt6oR8ovLxYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJtjUZk/5h/2QT5PvoVjVhvBsGm/eYB0Hf4SJJmvwqz66Hx9pCJCtGoYHn/Sbqti3yxW9qGpoIbHOiwCqoR1/VD8y5t/1ET6ocpwexQhacmhiwIJLy6r+pO80sWsMfgHjBm7kw905hI3fIQwy45OdAl8QL4T6bP7ql4X+lkbito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbKuCzrC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34abc7da414so4645237a91.0
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765991424; x=1766596224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/ZP5DLulRgKGF0H7SALtjbqHbgKXDr1Fcb8Qn9m5f4=;
        b=gbKuCzrCbRjmfXmZcWthcECxwStJncrI5+S1JR2P8AJ5FIEilvbT1uwJCVOr/r6e8H
         bSjnueTPj44AZCu82/+qbiw/BxXVjsQFw2OmBKG+OGrg+uH3SaC6X746jr+a1J5Xzmvi
         pCklqvjaTSdNMseDufWzVSXmTUCZP+7bQoqtYKKCYWB07YVziB3YmOCOiIR9asQp8gQg
         aM2dlHfLvQHyh600duUzZB1tSggThwoYV3DjgaWJ9NI60wtxUwML3XBOqiP6SBPg5+hD
         ilkvsAiZQhRqMfsUa7mh7oIreeTCt+Azwmrdy7J+VqDQKMPSNanx4Ir5RGHK2C8rJulr
         AJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765991424; x=1766596224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/ZP5DLulRgKGF0H7SALtjbqHbgKXDr1Fcb8Qn9m5f4=;
        b=byVWP1GZi9ZlM8oYLsLIgjtd4G/H/hhjmO0KkVJJ2hqBdRMDy4Y7Q56ffzasRSANz/
         fi8p8ShiYk6DaQHhgegqRVokIIRYeSNkGWpzUAC9SmA6ecOFHMlrxcwEubzyjFj9pxTT
         E4p80fF3/9yYJYjJBQg00Th4BBtoALlq886UHTP4BB6yqi5UBu37LesOFFqZsz2QqNT5
         +jjVOjz/OeEqq8py30hLtwPtqxgAbTAEVNP6Gfl1GPxOzdRRFriAWPtdglHwVD/Q0ZU3
         52ty0jRzQIZvpNpZNJuUS1zNDJlB254fwEsRnzsWkpeBWId13DpPDSbRP9EQA5bexou5
         V4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8fntTCNYDB1qxMSaJDqljDHuojhXK7upf3OkkSuPn/E1ezAfUCDzFf9rj7zYydpglX9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpIlO/KfNKOOVZ5437RG5bgMNAjuucQ/Mr6f7tOGwDGNQYAYHK
	vHZPOZwkGq8tim6/DrPsHgekJNzke+G79cjYkLqAzZ+OVcU6B6ffdjXVqEelexNucFdpXpJex9w
	pgY2XTDMCWMjLYszis6tPLzco0sAJxxo=
X-Gm-Gg: AY/fxX4O/VzTx666dbjLTOxMCk0+kAy2E8BlEU8u0MfDZHSFaQprV00dd5OmtIZbzYp
	ygFDc8XwvX4qHwDSP7ag6HWrlXQCBhOMB/wPUr1C3+BVr3xCB4fjxDg2flX+D5qN4XoyulgxRFt
	LQNiQAIwXIW6ijKvjM014qP4gYf4M1GtA+/Ub0rDcP3adlGQFMO84s28DCnVXASzpogk70SQccK
	zxHGepwwU8esua+x7cXjEGhIP+6aBz56v+s+fDbwdjiLTPLK/uGw3f60nDqpuKpaeoyQfit4/y0
	L90rratQt2I=
X-Google-Smtp-Source: AGHT+IFggb1O5clKEnz2YlhOP3Cl2Nap+Z2HKz/pevAResw+OM9gsJ/D/49cwV1ctEmQdADRgvfC2BDVa3CY2U2qBhw=
X-Received: by 2002:a17:90b:380f:b0:340:66f9:381 with SMTP id
 98e67ed59e1d1-34abd6d873bmr15524851a91.10.1765991423580; Wed, 17 Dec 2025
 09:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com> <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com> <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
In-Reply-To: <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Dec 2025 09:10:08 -0800
X-Gm-Features: AQt7F2pFkg4U81fo64XlJTuzjU2K4-SAoifZ5ytp6MjwlPEBsCOno0bZj-DvibA
Message-ID: <CAEf4BzZyLpHW5++0=JOh1GkBb_P6mWKLrA0mgoMuXqxUV8=Ssw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, qmo@kernel.org, Andrii Nakryiko <andrii@kernel.org>, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 8:06=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 16/12/2025 19:46, Eduard Zingerman wrote:
> > On Tue, 2025-12-16 at 11:00 -0800, Eduard Zingerman wrote:
> >> On Tue, 2025-12-16 at 17:18 +0000, Alan Maguire wrote:
> >>
> >> [...]
> >>
> >>> @@ -1460,10 +1466,16 @@ static void btf_dump_emit_type_chain(struct b=
tf_dump *d,
> >>>             case BTF_KIND_UNION:
> >>>                     btf_dump_emit_mods(d, decls);
> >>>                     /* inline anonymous struct/union */
> >>> -                   if (t->name_off =3D=3D 0 && !d->skip_anon_defs)
> >>> +                   if (t->name_off =3D=3D 0 && !d->skip_anon_defs) {
> >>>                             btf_dump_emit_struct_def(d, id, t, lvl);
> >>> -                   else
> >>> +                   } else if (decls->cnt =3D=3D 0 && !fname[0] && d-=
>force_anon_struct_members) {
> >>> +                           /* anonymize nested struct and emit it */
> >>> +                           btf_dump_set_anon_type(d, id, true);
> >>> +                           btf_dump_emit_struct_def(d, id, t, lvl);
> >>> +                           btf_dump_set_anon_type(d, id, false);
> >>
> >>
> >> Hi Alan,
> >>
> >> I think this is a solid idea.
> >>
> >> It seems to me that with current implementation there would be a
> >> trouble in the following scenario:
> >>
> >>   struct foo { struct foo *ptr; };
> >>   struct bar {
> >>     struct foo;
> >>   }
> >>
> >> Because state for 'foo' will be anonymize =3D=3D true at the moment wh=
en
> >> 'ptr' field is printed.
> >>
> >> Maybe pass a direct parameter to btf_dump_emit_struct_def()?
> >
> > Digging a bit more into this, here are a couple of weird examples:
> >
> >   $ cat ~/tmp/ms-ext-test.c
> >   struct foo {
> >     struct foo *ptr;
> >   };
> >
> >   struct bar {
> >     struct foo;
> >   };
> >
> >   struct bar root;
> >   $ gcc -g -c -o ~/tmp/ms-ext-test.o ~/tmp/ms-ext-test.c
> >   $ pahole -J ~/tmp/ms-ext-test.o
> >   $ bpftool btf dump file ~/tmp/ms-ext-test.o format c
> >   #ifndef __VMLINUX_H__
> >   #define __VMLINUX_H__
> >
> >   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> >   #pragma clang attribute push (__attribute__((preserve_access_index)),=
 apply_to =3D record)
> >   #endif
> >
> >   #ifndef __ksym
> >   #define __ksym __attribute__((section(".ksyms")))
> >   #endif
> >
> >   #ifndef __weak
> >   #define __weak __attribute__((weak))
> >   #endif
> >
> >   #ifndef __bpf_fastcall
> >   #if __has_attribute(bpf_fastcall)
> >   #define __bpf_fastcall __attribute__((bpf_fastcall))
> >   #else
> >   #define __bpf_fastcall
> >   #endif
> >   #endif
> >
> >   struct foo {
> >       struct foo *ptr;
> >   };
> >
> >
> >   /* BPF kfuncs */
> >   #ifndef BPF_NO_KFUNC_PROTOTYPES
> >   #endif
> >
> >   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> >   #pragma clang attribute pop
> >   #endif
> >
> >   #endif /* __VMLINUX_H__ */
> >
> >
> >   $ cat ~/tmp/ms-ext-test.c
> >   struct foo {
> >     struct foo *ptr;
> >   };
> >
> >   struct bar {
> >     struct foo;
> >     int a;
> >   };
> >
> >   struct bar root;
> >   $ cgcc -fms-extensions -g -c -o ~/tmp/ms-ext-test.o ~/tmp/ms-ext-test=
.c
> >   $ pahole -J ~/tmp/ms-ext-test.o
> >   $ tools/bpf/bpftool/bpftool btf dump file ~/tmp/ms-ext-test.o format =
c
> >   #ifndef __VMLINUX_H__
> >   #define __VMLINUX_H__
> >
> >   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> >   #pragma clang attribute push (__attribute__((preserve_access_index)),=
 apply_to =3D record)
> >   #endif
> >
> >   #ifndef __ksym
> >   #define __ksym __attribute__((section(".ksyms")))
> >   #endif
> >
> >   #ifndef __weak
> >   #define __weak __attribute__((weak))
> >   #endif
> >
> >   #ifndef __bpf_fastcall
> >   #if __has_attribute(bpf_fastcall)
> >   #define __bpf_fastcall __attribute__((bpf_fastcall))
> >   #else
> >   #define __bpf_fastcall
> >   #endif
> >   #endif
> >
> >   struct foo {
> >       struct foo *ptr;
> >   };
> >
> >   struct bar {
> >       struct  {
> >               struct  *ptr;
> >       };
> >       int a;
> >   };
> >
> >
> >   /* BPF kfuncs */
> >   #ifndef BPF_NO_KFUNC_PROTOTYPES
> >   #endif
> >
> >   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> >   #pragma clang attribute pop
> >   #endif
> >
> >   #endif /* __VMLINUX_H__ */
> >
>
> Ack to all suggestions; in particular handling both cases with #ifdef is =
really nice since
> it does away with the need for libbpf/bpftool options. With that in place=
 - along with passing
> parameters rather than setting field values, and being more selective to =
ensure we only emit
> the #ifdef/#else/#endif for a composite type nested in a composite type -=
 the above
> gives us the following:
>
> struct foo {
>         struct foo *ptr;
> };
>
> struct bar {
>
> #ifdef __MS_EXTENSIONS__
>         struct foo;
> #else
>         struct {
>                 struct foo *ptr;
>         };
> #endif
>
>         int a;
> };
>
> I think that's the format we want.
>
> With respect to the padding behaviour, I may be missing something but I'm=
 not sure these changes
> will impact that. We pad in two cases:
>
> 1. between struct fields, where the current offset is less than the membe=
r offset or we have
> alignment requirements to be met.
> 2. at the end of the struct, to pad it out the the size/alignment require=
ments.
>
> I don't see anything different here for the case where we force-anonymize=
-inline the struct;
> it still does 1 and 2 identical with the out-of-line declaration. To test=
 this I augmented
> Eduard's example to add internal and whole struct alignment requirements:
>
> struct foo {
>     struct foo *ptr;
>     char __attribute__((__aligned__(16))) s;
>     int t;
> } __attribute__((__aligned__(64)));
>
> struct bar {
>     struct foo;
>     int a;
> };
>
> struct bar root;
>
> int main(int argc, char *argv[])
> {
>         struct bar *r =3D (struct bar *)argv[0];
> }
>
> $ gcc -fms-extensions -g -c -o /tmp/ms-ext-test.o /tmp/ms-ext-test.c
> $ pahole -J /tmp/ms-ext-test.o
> $ bpftool btf dump file /tmp/ms-ext-test.o format c
>
> struct foo {
>         struct foo *ptr;
>         long: 64;
>         char s;
>         int t;
>         long: 64;
>         long: 64;
>         long: 64;
>         long: 64;
>         long: 64;
> };
>
> struct bar {
>
> #ifdef __MS_EXTENSIONS__
>         struct foo;
> #else
>         struct {
>                 struct foo *ptr;
>                 long: 64;
>                 char s;
>                 int t;
>                 long: 64;
>                 long: 64;
>                 long: 64;
>                 long: 64;
>                 long: 64;
>         };
> #endif
>
>         int a;
>         long: 64;
>         long: 64;
>         long: 64;
>         long: 64;
>         long: 64;
>         long: 64;
>         long: 64;
> };
>
> This looks equivalent to me, but there may some other condition you're th=
inking
> of here?

I initially assumed that we won't have outer anonymous struct {} and
instead we'll just inline embedded structs directly. In that case it
can happen that if the following field has smaller alignment
requirement than embedded struct's alignment, then we can accidentally
pack field more tightly.

struct blah { long x; int y; /* 4 byte pad */ };

struct whatever {
    struct blah;
    char b;
};

b will be at offset 16. But if we did (an arguably cleaner)

struct whatever {
    long x;
    int y;
    /* here we should have long: 64 explicitly */
    char b;
}

then without explicit padding before b, b would end up at offset 13.

But all of this is not a concern if we keep an anonymous wrapping
struct, so ignore me.

>
> Thanks!
>
> Alan

