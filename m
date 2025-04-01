Return-Path: <bpf+bounces-55100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA20A78339
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 22:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7041890EAA
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F520E70D;
	Tue,  1 Apr 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb5UluY/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9DA3594F
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743538859; cv=none; b=UzyJgrB27wVvARYcyKHaTlIWZepfpvFsNOe6d0aJUr7YLRfqulCi7eO/tLBYi4Zl5N3QAy0jVUVFNldrEGhY7mSMDJ6MuXPTkcUB7NwatUUvmxMtLHKLkCZ/DfRRicMLmGivS6vd5P3uGIJw0CtHa7CCb92gGvpKJMvFzBNnGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743538859; c=relaxed/simple;
	bh=kG9MHKWfPsSZKGqLUTFwCujqelgajo8PTThK77Y2xCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXmG5y7jPuAWq4gTqDYRdjf7IRxocx4PW+UPhJlgWXNkbK/K69CprM4vIZ950jlVPlyEKlYYRWA+Y6YRvUV0Lv/A+ZWkuT8l7tC28KV8fb7yxrSWWUh91tI8QdRz/O0tqv0pdo4rntckP+6YXZ4OFa1XD20DNzgUV0jaTjVHKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb5UluY/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fd89d036so128264795ad.1
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743538857; x=1744143657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GD4JOmOmxtR6uV1aAT/bnTzFjdrEUsA2rDcxgCEY+k=;
        b=Sb5UluY/b3NgoOTsq/xT/7vuuvAjaAGajKG8jM116wzBYP+2ftWDwmsYy4cFUJFgNX
         7v/6a9GK7PNzLEeF8chMz9bf4oUlJ27e/1jJNMgmXM4uCoSIMHZDR4m3w4YMyxByNuxd
         kQScpeqrE/HVkLvIcgr8jHrsFAzffvqXlOEpDN78q8YwLyrqY1OxPQNwxrQoJ162LjsG
         LkYLALluAIX9cB6HENuJssXkFaHEDNMsVQpSff4403R3FO3CPLY0EB2UTTo82mnR4gbx
         xBsqOI3UceC6MNgn+RFitve3mm0E2YHWaUyHYM5+MB9lhabIS91wVSJicEW7AadLSGnd
         4PoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743538857; x=1744143657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GD4JOmOmxtR6uV1aAT/bnTzFjdrEUsA2rDcxgCEY+k=;
        b=HpgG8EbiDcsr7CKie0SuRa+5JIDoySBoLkBJKQKYlB1fGg982SJgIiZVPjjZROotR9
         IJtEl0Soe+xPBEhTPIzZ1Qt60qD3Vbr/1pMe4QNCRwfb1q1fYE0qbXaBT0yVAahPKqpf
         xQYq49Ig6oOoqBgBMT9XAx1HGdiRyv7ItIa6tPDOcLJ4DQnJET1g/TiVdh9ezyHluuJ6
         XGtGRmxoq/pXqmvRmApel9GWtsAP4DridO5ltoqrTxFbUf52o/0Q8EYDzcUAa7IgB5ji
         V172dhQoEFUZL46mXKgciptdaRyhSXkTwJ1NAqxBU/XEx+P3rlKkVt+P/7Tox1WCXG51
         /D0Q==
X-Gm-Message-State: AOJu0YzIXIiX6PSAf0fqubL4Go3663R2KfQKUFs17S96Lfsj4bfXHJy+
	+7mdti4n52MkXlR2vxm1PAtV8d+xomEWIV/N7QnAPqo70KjOw2qJb7ITxgqgDTfMtVdJHeQE/4Y
	G6vZjgJtfWomhHAcTrgyJBXTUVYk=
X-Gm-Gg: ASbGncuDJBWGCqMoxRnbwek7xLtnZj+tBYLseKANN2OVD0xjRPO+DYoCYabqUuNc5Ry
	xZ8Q9N8qr+grb/oISmr18Bu3aPZTEXdKtJParN1ydTCHxhKU92Cu4uFJAY6Y4LMxHGSy9hXpo5w
	AvQd2NovPRjxEG08id5+Jy0ScsAy//cyoqu4Eki9Lyzw==
X-Google-Smtp-Source: AGHT+IHvYRGa0PpkqUOldtS81M/uIkpqIbu1pPA1goB035m3ZifYdG5WS13dKvfJQXG6vuK3I8rgxQ1JIV7/rfvtWfk=
X-Received: by 2002:a17:902:ef07:b0:224:c47:cb7 with SMTP id
 d9443c01a7336-2292f89cb94mr236295095ad.0.1743538856974; Tue, 01 Apr 2025
 13:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741874348.git.vmalik@redhat.com> <4e26ca57634db305a622b010b0d86dbb36b09c37.1741874348.git.vmalik@redhat.com>
 <CAEf4BzYTJh06kqR9hL=TvfBTRNskZMCPTAmcD7=nMFJrqR1OSA@mail.gmail.com> <317d7c59-a8aa-45ca-a6ab-3b602ac360ed@redhat.com>
In-Reply-To: <317d7c59-a8aa-45ca-a6ab-3b602ac360ed@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Apr 2025 13:20:44 -0700
X-Gm-Features: AQ5f1Jq5eGvjlc5XS122G8N6-BT1357c3GmZFj2yIs_n2ho9W5adQY1cUfr89_U
Message-ID: <CAEf4Bzb=F7nTWvLMo=NgMf_X4bkcNg8rR2E8K6UTv6B++4gxsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 5:48=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wro=
te:
>
> On 3/28/25 23:48, Andrii Nakryiko wrote:
> > On Mon, Mar 24, 2025 at 5:04=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> String operations are commonly used so this exposes the most common on=
es
> >> to BPF programs. For now, we limit ourselves to operations which do no=
t
> >> copy memory around.
> >>
> >> Unfortunately, most in-kernel implementations assume that strings are
> >> %NUL-terminated, which is not necessarily true, and therefore we canno=
t
> >> use them directly in BPF context. So, we use distinct approaches for
> >> bounded and unbounded variants of string operations:
> >>
> >> - Unbounded variants are open-coded with using __get_kernel_nofault
> >>   instead of plain dereference to make them safe.
> >>
> >> - Bounded variants use params with the __sz suffix so safety is assure=
d
> >>   by the verifier and we can use the in-kernel (potentially optimized)
> >>   functions.
> >>
> >> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> >> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> >> ---
> >>  kernel/bpf/helpers.c | 299 ++++++++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 299 insertions(+)
> >>

[...]

> >> +
> >> +       pagefault_disable();
> >> +       while (i++ < XATTR_SIZE_MAX) {
> >> +               __get_kernel_nofault(&c1, cs++, char, cs_out);
> >> +               __get_kernel_nofault(&c2, ct++, char, ct_out);
> >
> > nit: should we avoid passing increment statements into macro? It's
> > succinct and all, but we lose nothing by having cs++; ct++; at the end
> > of while loop, no?
>
> That's probably a good idea. It shouldn't be a problem having those
> increments at the end of the loop so let me update it.

ok, thanks

>
> >
> >> +               if (c1 !=3D c2) {
> >> +                       ret =3D c1 < c2 ? -1 : 1;
> >> +                       goto out;
> >> +               }
> >> +               if (!c1)
> >> +                       goto out;
> >> +       }
> >> +cs_out:
> >> +       ret =3D -1;
> >> +       goto out;
> >> +ct_out:
> >> +       ret =3D 1;
> >> +out:
> >> +       pagefault_enable();
> >> +       return ret;
> >> +}
> >
> > Given valid values are only -1, 0, and 1, should we return -EFAULT
> > when one or the other string can't be fetched?
> >
> > Yes, users that don't care will treat -EFAULT as the first string is
> > smaller than the second, but that's what you have anyways. But having
> > -EFAULT is still useful, IMO. We can also return -E2BIG if we reach i
> > =3D=3D XATTR_SIZE_MAX situation, no?
>
> I was a bit hesitant to make the semantics of bpf_strcmp different from
> strcmp. But the truth is that returning errors here may bring some value
> so if people are ok with that, I have no problem implementing your
> proposal.
>
> But in such a case, I'd suggest that we do the same for the rest of the
> string kfuncs, too. That is, return -EINVAL if __get_kernel_nofault

-EFAULT, not -EINVAL

> fails and -E2BIG if the string is longer than XATTR_SIZE_MAX, possibly
> wrapped in PTR_ERR when the kfunc returns a pointer. What do you think?

yep, makes sense. Unlike strcmp() and others, we do have an extra
conditions as you mentioned (memory read faulting, too long/unbounded
strings, etc), so I'd prefer if users were able to tell error
condition from trustworthy result, yep

>
> >
> >> +
> >> +/**
> >> + * bpf_strchr - Find the first occurrence of a character in a string
> >> + * @s: The string to be searched
> >> + * @c: The character to search for
> >> + *
> >> + * Note that the %NUL-terminator is considered part of the string, an=
d can
> >> + * be searched for.
> >> + */
> >> +__bpf_kfunc char *bpf_strchr(const char *s, int c)
> >
> > if we do int -> char here, something breaks?
>
> No, it shouldn't. IIUC the int comes from the original prototype of libc
> strchr and it's there solely for legacy purposes. Let's change it to
> char.
>

+1, I always found that `int c` in glibc confusing

> >
> >> +{
> >> +       char *ret =3D NULL;
> >> +       int i =3D 0;
> >> +       char sc;
> >> +
> >> +       pagefault_disable();
> >> +       while (i++ < XATTR_SIZE_MAX) {
> >> +               __get_kernel_nofault(&sc, s, char, out);
> >> +               if (sc =3D=3D (char)c) {
> >> +                       ret =3D (char *)s;
> >> +                       break;
> >> +               }
> >> +               if (sc =3D=3D '\0')
> >
> > not very consistent with bpf_strcmp() implementation where you just
> > did `!c1` for the same. FWIW, when dealing with string characters I
> > like `sc =3D=3D '\0'` better, but regardless let's be consistent, at
> > least.
> >
> >> +                       break;
> >> +               s++;
> >
> > It's like bpf_strcmp and bpf_strchr were written by two different
> > people, stylistically :)
>
> Yeah, the main reason here is that I've taken the implementations from
> lib/string.c so that's where these differences come from. But the truth
> is that the BPF kfuncs required quite a lot of changes so it's better to
> rewrite them even further and make them consistent among themselves.
> I'll have a look into it.
>
> >
> >> +       }
> >> +out:
> >> +       pagefault_enable();
> >
> > how about we
> >
> > DEFINE_LOCK_GUARD_0(pagefault, pagefault_disable(), pagefault_enable())
> >
> > like we do for preempt_{disable,enable}() and simplify all the
> > implementations significantly?
>
> That's neat, I didn't know it. It will a bit more tricky to use here as
> __get_kernel_nofault still requires a label but we should at least be
> able to get rid of pagefault_{disable,enable}() in each function.

yep, we'll have:

err_out:
    return -EFAULT;

But the rest will be a clean loop and no pagefault_disable() clean
ups, distracting from the main logic

[...]

> >> +/**
> >> + * bpf_strnchr - Find a character in a length limited string
> >> + * @s: The string to be searched
> >> + * @s__sz: The number of characters to be searched
> >> + * @c: The character to search for
> >> + *
> >> + * Note that the %NUL-terminator is considered part of the string, an=
d can
> >> + * be searched for.
> >> + */
> >> +__bpf_kfunc char *bpf_strnchr(void *s, u32 s__sz, int c)
> >
> > I'm a bit on the fence here. I can see cases where s would be some
> > string somewhere (not "trusted" by verifier, because I did BPF CO-RE
> > based casts, etc). Also I can see how s__sz is non-const known at
> > runtime only.
> >
> > I think the performance argument is much less of a priority compared
> > to the ability to use the helper in a much wider set of cases. WDYT?
> > Maybe let's just have __get_kernel_nofault() for everything?
> >
> > If performance is truly that important, we can later have an
> > optimization in which we detect constant size and "guaranteed"
> > lifetime and validity of `s`, and use optimized strnchr()
> > implementation?
> >
> > But I'd start with a safe and generic __get_kernel_nofault() way for su=
re.
>
> Ok, that makes sense. I didn't realize that with this prototype, we're
> eliminating a number of uses-cases and I agree that it's more important
> than performance.
>
> Also it turned out that the bounded string functions are seldom
> optimized on arches and therefore the performance benefit is minimal
> (the only real case is strnlen on few arches like arm64).
>
> So let's turn everything to generic __get_kernel_nofault variants for
> now. We can think about optimization later, it would be much better if
> we could detect situations when the kernel implementaion can be used
> even for the unbounded functions. There, the performance gain would be
> seen on much more functions.

Let's leave it for the future, I suspect string routine performance
will never be a real performance concert, as it will normally be a
small part of otherwise much more expensive custom logic in BPF
program. But we'll have an option to optimize, and that's all that
matters. Generality beats performance for these APIs, though, so let's
generalize first.

>
> >
> >> +{
> >> +       return strnchr(s, s__sz, c);
> >> +}
> >> +

[...]

> >> +/**
> >> + * bpf_strspn - Calculate the length of the initial substring of @s w=
hich only contain letters in @accept
> >> + * @s: The string to be searched
> >> + * @accept: The string to search for
> >> + */
> >> +__bpf_kfunc size_t bpf_strspn(const char *s, const char *accept)
> >> +{
> >> +       int i =3D 0;
> >> +       char c;
> >> +
> >> +       pagefault_disable();
> >> +       while (i < XATTR_SIZE_MAX) {
> >> +               __get_kernel_nofault(&c, s++, char, out);
> >> +               if (c =3D=3D '\0' || !bpf_strchr(accept, c))
> >
> > hm... so `s` is untrusted/unsafe, but `accept` is? How should verifier
> > make a distinction? It's `const char *` in the signature, so what
> > makes one more safe than the other?
>
> accept is untrusted as well, that's why bpf_strchr is used instead of
> strchr. Or am I missing something?


I'm just asking how should verifier know this just looking at the prototype=
:

__bpf_kfunc size_t bpf_strspn(const char *s, const char *accept)

?

For the next revision, let's add a bunch more "negative cases",
passing known-bad pointers/strings and checking -EFAULT and -E2BIG.
These are very generic APIs, let's test this thoroughly: user instead
of kernel pointers, unbounded/too long strings, just plain invalid
pointers, etc.


>
> >
> >> +                       break;
> >> +               i++;
> >> +       }
> >> +out:
> >> +       pagefault_enable();
> >> +       return i;
> >> +}
> >> +
> >> +/**
> >> + * strcspn - Calculate the length of the initial substring of @s whic=
h does not contain letters in @reject
> >> + * @s: The string to be searched
> >> + * @reject: The string to avoid
> >> + */
> >> +__bpf_kfunc size_t bpf_strcspn(const char *s, const char *reject)
> >> +{
> >> +       int i =3D 0;
> >> +       char c;
> >> +
> >> +       pagefault_disable();
> >> +       while (i < XATTR_SIZE_MAX) {
> >> +               __get_kernel_nofault(&c, s++, char, out);
> >> +               if (c =3D=3D '\0' || bpf_strchr(reject, c))
> >> +                       break;
> >> +               i++;
> >> +       }
> >> +out:
> >> +       pagefault_enable();
> >> +       return i;
> >> +}
> >> +
> >> +/**
> >> + * bpf_strpbrk - Find the first occurrence of a set of characters
> >> + * @cs: The string to be searched
> >> + * @ct: The characters to search for
> >> + */
> >> +__bpf_kfunc char *bpf_strpbrk(const char *cs, const char *ct)
> >
> > wouldn't this be `cs + bpf_strcspn(cs, ct)`?
>
> That's IMO correct, unless bpf_strcspn(cs, ct) =3D=3D strlen(cs). Then it=
's
> NULL. But it's still a nicer implementation.

ah, strlen() is problematic (though we can have __bpf_strcspn()
returning both size_t and the actual character (as out parameter), to
distinguish these situations, don't know. It will be more obvious
while implementing if that makes sense or not (all those algorithms
are pretty straightforward, so code reuse isn't really a big concern
from my POV)

>
> >
> >> +{
> >> +       char *ret =3D NULL;
> >> +       int i =3D 0;
> >> +       char c;
> >> +
> >> +       pagefault_disable();
> >> +       while (i++ < XATTR_SIZE_MAX) {
> >> +               __get_kernel_nofault(&c, cs, char, out);
> >> +               if (c =3D=3D '\0')
> >> +                       break;
> >> +               if (bpf_strchr(ct, c)) {
> >> +                       ret =3D (char *)cs;
> >> +                       break;
> >> +               }
> >> +               cs++;
> >> +       }
> >> +out:
> >> +       pagefault_enable();
> >> +       return ret;
> >> +}
> >> +
> >> +/**
> >> + * bpf_strstr - Find the first substring in a %NUL terminated string
> >> + * @s1: The string to be searched
> >> + * @s2: The string to search for
> >> + */
> >> +__bpf_kfunc char *bpf_strstr(const char *s1, const char *s2)
> >> +{
> >> +       size_t l1, l2;
> >> +
> >> +       l2 =3D bpf_strlen(s2);
> >> +       if (!l2)
> >> +               return (char *)s1;
> >> +       l1 =3D bpf_strlen(s1);
> >> +       while (l1 >=3D l2) {
> >> +               l1--;
> >> +               if (!memcmp(s1, s2, l2))
> >> +                       return (char *)s1;
> >> +               s1++;
> >> +       }
> >> +       return NULL;
> >
> > no __get_kernel_nofault() anymore?
>
> It's hidden inside bpf_strlen.
>
> But I assume that the same as below applies (string possibly changing in
> between the bpf_strlen and memcmp calls) so we'll need a different
> implementation.
>

yep, assume the worst. The result might be invalid due to race (as in,
we can report that string is found at position X, but a few
nanoseconds later that's not true anymore), that's fine. But we
shouldn't crash, loop forever, etc. As long as the result is correct
in a non-changing string situation, we should be fine.

> >
> >> +}
> >> +
> >> +/**
> >> + * bpf_strnstr - Find the first substring in a length-limited string
> >> + * @s1: The string to be searched
> >> + * @s1__sz: The size of @s1
> >> + * @s2: The string to search for
> >> + * @s2__sz: The size of @s2
> >> + */
> >> +__bpf_kfunc char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2_=
_sz)
> >> +{
> >> +       /* strnstr() uses strlen() to get the length of s2. Since this=
 is not
> >> +        * safe in BPF context for non-%NUL-terminated strings, use st=
rnlen
> >> +        * first to make it safe.
> >> +        */
> >> +       if (strnlen(s2, s2__sz) =3D=3D s2__sz)
> >> +               return NULL;
> >> +       return strnstr(s1, s2, s1__sz);
> >> +}
> >> +
> >
> > we have to assume that the string will change from under us, so any
> > algorithm that does bpf_strlen/strlen/strnlen and then relies on that
> > length to be true seems fishy...
>
> Hm, that's a good point, I didn't consider that. I'll think about a
> better implementation for bpf_strstr and bpf_strnstr.
>
> Thanks a lot for the thourough review! I'll post v4 soon.
>

thanks, let's be a bit more paranoid and add some negative tests while at i=
t

> Viktor
>
> >
> > pw-bot: cr
> >
> >>  __bpf_kfunc_end_defs();
> >>
> >>  BTF_KFUNCS_START(generic_btf_ids)
> >> @@ -3293,6 +3579,19 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF=
_ITER_NEXT | KF_RET_NULL | KF_SLE
> >>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_=
SLEEPABLE)
> >>  BTF_ID_FLAGS(func, bpf_local_irq_save)
> >>  BTF_ID_FLAGS(func, bpf_local_irq_restore)
> >> +BTF_ID_FLAGS(func, bpf_strcmp);
> >> +BTF_ID_FLAGS(func, bpf_strchr);
> >> +BTF_ID_FLAGS(func, bpf_strchrnul);
> >> +BTF_ID_FLAGS(func, bpf_strnchr);
> >> +BTF_ID_FLAGS(func, bpf_strnchrnul);
> >> +BTF_ID_FLAGS(func, bpf_strrchr);
> >> +BTF_ID_FLAGS(func, bpf_strlen);
> >> +BTF_ID_FLAGS(func, bpf_strnlen);
> >> +BTF_ID_FLAGS(func, bpf_strspn);
> >> +BTF_ID_FLAGS(func, bpf_strcspn);
> >> +BTF_ID_FLAGS(func, bpf_strpbrk);
> >> +BTF_ID_FLAGS(func, bpf_strstr);
> >> +BTF_ID_FLAGS(func, bpf_strnstr);
> >>  BTF_KFUNCS_END(common_btf_ids)
> >>
> >>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> >> --
> >> 2.48.1
> >>
> >
>

