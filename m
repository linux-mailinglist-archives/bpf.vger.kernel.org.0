Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422E0C2569
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2019 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbfI3Qus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Sep 2019 12:50:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43152 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfI3Qus (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Sep 2019 12:50:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so8368905qke.10;
        Mon, 30 Sep 2019 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KoXld5A01oSGDgCLY+ILZpasDZh9Ml2uSiGgAsKNG8w=;
        b=FeiT7jCVx9yzGP5+5VicytREB73495f8wt2wy3rTz0P/An3RtHDcJhDMXwFKiyyxxP
         NAHO82N7/e1YneU2+qo3xQuXGpCBA6AjslWTc8P3lvSJsQlwj9GT4rKHUUvwbNye3RL3
         MD62J5Ycq1fQSZTzx/T35RWaEb4b1VbcYOknebObNcgiMs0Dcc1/z/e9G2fvku2KdfR4
         eLMpfH1sEpBZTzJX1ogP8pTb0+e4Z1tGixO8GspRxNKmDzuF3jPXABgFIR+F3Z3OMl3c
         /Bn5yKJ4W+1+FEaMq99NhMmY+3hKUig1Neq00qQpeRpspQWg1b7l4HDFBxSPI6GbBuhT
         qVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KoXld5A01oSGDgCLY+ILZpasDZh9Ml2uSiGgAsKNG8w=;
        b=lJfUG53KLD30y8MyhScJkIluvV47loFuLtwmMT94VoRhfUUGOCEHuq6Io+ijP1PHc3
         VIQHuMFn2z31MIq5BY2mMFYE9R/NjKd9mjssOU9gt84tFglH6P3DFJJwKQV21AZ4gMf1
         PSay/zgAbK8WqAEw6/zzC6yJjZGDC9GMKJtxgk9w3Vb90umQHZ+HVr4rm1njCt6jjBU7
         gmORxt46goqRDzHDTNVn2svBU+wANQYOooQhr7WXxgClA+X/AhjmA/JJZnCHtPY7Pgoa
         zSYobdDbYLIVqy8Lw7ov0i22sQ5yJYLnAy2TVhPA0yt3YiG6PLQCgx9hDMecGa9FT4sg
         kvuA==
X-Gm-Message-State: APjAAAV0TMt5e6d1avbUtL+rlUWVUEe1EHqf99TmuptHp7p0YAHgsZMJ
        xt2O3xRrxKSJgZjamqo7yf5nhDU2jPEd8/BLU8M=
X-Google-Smtp-Source: APXvYqxpZFT6uu3F7zK0gwboh8wqtndVlH7R0FjdalKWDeDHssjvqgoKeHndmEeJ1OzBYHCcBpfVHvVjsi08K5+Mrxs=
X-Received: by 2002:a37:98f:: with SMTP id 137mr1025607qkj.449.1569862245153;
 Mon, 30 Sep 2019 09:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190927130834.18829-1-kpsingh@chromium.org> <CAEf4Bzb_8AJS=HLUt9QpdRrt4AzW1ME9tFyL-QTqyu=7fC-dGA@mail.gmail.com>
 <87h84uxno9.fsf@toke.dk>
In-Reply-To: <87h84uxno9.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Sep 2019 09:50:33 -0700
Message-ID: <CAEf4BzZNWu1e8ryuhyPW5=NqkX_s8NkBaet+akwh5ixxL1AegA@mail.gmail.com>
Subject: Re: [PATCH] tools: libbpf: Add bpf_object__open_buffer_xattr
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 30, 2019 at 12:12 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Sep 27, 2019 at 6:11 AM KP Singh <kpsingh@chromium.org> wrote:
> >>
> >> From: KP Singh <kpsingh@google.com>
> >>
> >> Introduce struct bpf_object_open_buffer_attr and an API function,
> >> bpf_object__open_xattr, as the existing API, bpf_object__open_buffer,
> >> doesn't provide a way to specify neither the "needs_kver" nor
> >> the "flags" parameter to the internal call to the
> >> __bpf_object__open which makes it inconvenient for loading BPF
> >> objects that do not require a kernel version from a buffer.
> >>
> >> The flags attribute in the bpf_object_open_buffer_attr is set
> >> to MAPS_RELAX_COMPAT when used in bpf_object__open_buffer to
> >> maintain backward compatibility as this was added to load objects
> >> with non-compat map definitions in:
> >>
> >> commit c034a177d3c8 ("bpf: bpftool, add flag to allow non-compat map
> >>                       definitions")
> >>
> >> and bpf_object__open_buffer was called with this flag enabled (as a
> >> boolean true value).
> >>
> >> The existing "bpf_object__open_xattr" cannot be modified to
> >> maintain API compatibility.
> >>
> >> Reported-by: Anton Protopopov <a.s.protopopov@gmail.com>
> >> Signed-off-by: KP Singh <kpsingh@google.com>
> >> ---
> >>  tools/lib/bpf/libbpf.c   | 39 ++++++++++++++++++++++++++++-----------
> >>  tools/lib/bpf/libbpf.h   | 10 ++++++++++
> >>  tools/lib/bpf/libbpf.map |  5 +++++
> >>  3 files changed, 43 insertions(+), 11 deletions(-)
> >>
> >> This patch is assimilates the feedback from:
> >>
> >>   https://lore.kernel.org/bpf/20190815000330.12044-1-a.s.protopopov@gm=
ail.com/
> >>
> >> I have added a "Reported-by:" tag, but please feel free to update to
> >> "Co-developed-by" if it's more appropriate from an attribution perspec=
tive.
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 2b57d7ea7836..1f1f2e92832b 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -2752,25 +2752,42 @@ struct bpf_object *bpf_object__open(const char=
 *path)
> >>         return bpf_object__open_xattr(&attr);
> >>  }
> >>
> >> -struct bpf_object *bpf_object__open_buffer(void *obj_buf,
> >> -                                          size_t obj_buf_sz,
> >> -                                          const char *name)
> >> +struct bpf_object *
> >> +bpf_object__open_buffer_xattr(struct bpf_object_open_buffer_attr *att=
r)
> >
> > I have few concerns w.r.t. adding API in this form and I'm going to
> > use this specific case to discuss more general problem of API design,
> > ABI compatibility, and extending APIs with extra optional arguments.
> >
> > 1. In general, I think it would be good for libbpf API usability to
> > use the following pattern consistently (moving forward):
> >
> > T1 some_api_function(T2 mandatory_arg1, ..., TN mandatory_arg, struct
> > something_opts *opts)
> >
> > So all the mandatory arguments that have to be provides are specified
> > explicitly as function arguments. That makes it very clear what API
> > expects to get always.
> > opts (we use both opts and attrs, but opts seems better because its
> > optional options :), on the other hand, is stuff that might be
> > omitted, so if user doesn't care about tuning behavior of API and
> > wants all-defaults behavior, then providing NULL here should just
> > work.
> >
> > So in this case for bpf_object__open_buffer_xattr(), it could look like=
 this:
> >
> > struct bpf_object* bpf_object__open_buffer_opts(void *buf, size_t sz,
> > struct bpf_object_open_opts* opts);
>
> I like this idea! Sensible defaults that can be selected by just passing
> NULL as opts is a laudable goal.

Cool, I just sent out RFC w/ what I had in mind and applied that to
consistent open_mem/open_file APIs, let's discuss further there.

>
> > 2. Now, we need to do something with adding new options without
> > breaking ABIs. With all the existing extra attributes, when we need to
> > add new field to that struct, that can break old code that's
> > dynamically linked to newer versions of libbpf, because their
> > attr/opts struct is too short for new code, so that could cause
> > segment violation or can make libbpf read garbage for those newly
> > added fields. There are basically three ways we can go about this:
> >
> > a. either provide the size of opts struct as an extra argument to each
> > API that uses options, so:
> > struct bpf_object* bpf_object__open_buffer_opts(void *buf, size_t sz,
> > struct bpf_object_open_opts* opts, size_t opts_sz);
> >
> > b. make it mandatory that every option struct has to have as a first
> > field its size, so:
> >
> > struct bpf_object_open_opts {
> >         size_t sz;
> >         /* now we can keep adding attrs */
> > };
> >
> > Now, when options are provided, we'll read first sizeof(size_t) bytes,
> > validate it for sanity and then we'll know which fields are there or
> > not.
> >
> > Both options have downside of user needing to do extra initialization,
> > but it's not too bad in either case. Especially in case b), if user
> > doesn't care about extra options, then no extra steps are necessary.
> > In case a, we can pass NULL, 0 at the end, so also not a big deal.
> >
> > c. Alternatively, we can do symbol versioning similar how xsk.c
> > started doing it, and handle those options struct size differences
> > transparently. But that's a lot of extra boilerplate code in libbpf
> > and I'd like to avoid that, if possible.
>
> My hunch is that we're kidding ourselves if we think we can avoid the
> symbol versioning. And besides, checking struct sizes needs boilerplate
> code as well, boilerplate that will fail at runtime instead of compile
> time if it's done wrong.
>
> So IMO we're better off just doing symbol version right from the
> beginning.

I'm not against symbol versioning, don't get me wrong. Yonghong is
already fixing one of the problems with symbol versioning and after
that it should be pretty streamlined to add extra symbol versions. But
I'd like to avoid create a new symbol version for every minor new
optional field being added. On libbpf side this will cause lots of
boilerplate code for each version to "converge" to correct and full
struct definition and then call into a common implementation that
expects full struct definition.

With what I'm proposing in the RFC patch I sent out and CC'ed you on
we should have new symbol version only when there is some nontrivial
change only, which I think is a good thing to strive for.

>
> > 3. Now, the last minor complain is about flags field. It's super
> > generic. Why not have a set of boolean fields in a struct, in this
> > case to allow to specify strict/compat modes. Given we solve struct
> > extensibility issue, adding new bool fields is not an issue at all, so
> > the benefit of flags field are gone. The downside of flags field is
> > that it's very opaque integer, you have to go and read sources to
> > understand all the intended use cases and possible flags, which is
> > certainly not a great user experience.
>
> This I agree with :)
>
> -Toke
>
