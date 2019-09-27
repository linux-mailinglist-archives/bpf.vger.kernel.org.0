Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3BC0928
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2019 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfI0QGx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Sep 2019 12:06:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41759 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfI0QGx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Sep 2019 12:06:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id n1so7899346qtp.8;
        Fri, 27 Sep 2019 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WuJOTJ2rOSqnA/50pnyOXzTvEfMJbgrIo2rcpLSW7Tg=;
        b=IVivMG2TUNffhVhaJuilBHsl7JxqidjeZHHkeraE/MlXcZ2TefX9vPKaY2HcO6Dadz
         gPq6Ztj7lL94xoaQvHIwHQo2dKPvbMd80zRrw+50MAtxfI+Y555vuBhHEiL/Y7w8nDwz
         a/1v+xBjEaq+aSf1h37bT1REyPFdVs2L9fZyZElXSfevdP/PYA0WKpwm7BdUi9slgURo
         RV9+pPge7rIl7H22xzcNnW2mjawtc2lWI1oMlF6yX19LMoBTIRSEATI3rY7SRkRxXX/w
         arRxGCdkCmfBapS99cGz/OQOgDa7+Dp4DE0EUj3C2dE314H/ppK8OeRIOq1ZNLF0SlVH
         sxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuJOTJ2rOSqnA/50pnyOXzTvEfMJbgrIo2rcpLSW7Tg=;
        b=CAJvP+QUTbfKFJyvt4N12oAILmmgww6eeEd6yNMakdPqyM9mr+tXT8765aBuvYpYKC
         xaKCjmPs5zZD/N+BdjkK1ZGVIDn0HFZcRSvBY+XtzULRIe2SlAPjsHKsttpq6QknfPbR
         xCKzZfisLkGcahiK0cvAymI+8Y7ys4q3U2RNGidck7BCT5OJwgrqJhwei3QLf9Rc4wSJ
         k8UevjRBbZ6AY1WFTUhoVqxNnaadKs1wyXUM+8CBZINDWwdWWtjka+B09Oeuc76u5oY+
         aWCTLRgB0PALJiNEiK9hew0GNXEmYNJL8l7DdAhmnKDCObFOmsz+7alTMXGKTVe/CalH
         Giqg==
X-Gm-Message-State: APjAAAVKEKrg0M/xyNn3Ymn2bxNk1d1XRqISnbVUczS1/n8h81uy2bxI
        D+EE8gTzkLeSlZxqWrh8FkaqT1+CgnK/vBFCLuY=
X-Google-Smtp-Source: APXvYqzLFrmMJlQ95+RqgH2dFJPj8OuYHHdpmRDTBJfkiqyr8s0ZyOBW2VN4Rl/6RfyCKPD37fKAoSutpeb3jbHqSdg=
X-Received: by 2002:a0c:9326:: with SMTP id d35mr8142518qvd.162.1569600412178;
 Fri, 27 Sep 2019 09:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190927130834.18829-1-kpsingh@chromium.org>
In-Reply-To: <20190927130834.18829-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 27 Sep 2019 09:06:41 -0700
Message-ID: <CAEf4Bzb_8AJS=HLUt9QpdRrt4AzW1ME9tFyL-QTqyu=7fC-dGA@mail.gmail.com>
Subject: Re: [PATCH] tools: libbpf: Add bpf_object__open_buffer_xattr
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 27, 2019 at 6:11 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Introduce struct bpf_object_open_buffer_attr and an API function,
> bpf_object__open_xattr, as the existing API, bpf_object__open_buffer,
> doesn't provide a way to specify neither the "needs_kver" nor
> the "flags" parameter to the internal call to the
> __bpf_object__open which makes it inconvenient for loading BPF
> objects that do not require a kernel version from a buffer.
>
> The flags attribute in the bpf_object_open_buffer_attr is set
> to MAPS_RELAX_COMPAT when used in bpf_object__open_buffer to
> maintain backward compatibility as this was added to load objects
> with non-compat map definitions in:
>
> commit c034a177d3c8 ("bpf: bpftool, add flag to allow non-compat map
>                       definitions")
>
> and bpf_object__open_buffer was called with this flag enabled (as a
> boolean true value).
>
> The existing "bpf_object__open_xattr" cannot be modified to
> maintain API compatibility.
>
> Reported-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/lib/bpf/libbpf.c   | 39 ++++++++++++++++++++++++++++-----------
>  tools/lib/bpf/libbpf.h   | 10 ++++++++++
>  tools/lib/bpf/libbpf.map |  5 +++++
>  3 files changed, 43 insertions(+), 11 deletions(-)
>
> This patch is assimilates the feedback from:
>
>   https://lore.kernel.org/bpf/20190815000330.12044-1-a.s.protopopov@gmail.com/
>
> I have added a "Reported-by:" tag, but please feel free to update to
> "Co-developed-by" if it's more appropriate from an attribution perspective.
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2b57d7ea7836..1f1f2e92832b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2752,25 +2752,42 @@ struct bpf_object *bpf_object__open(const char *path)
>         return bpf_object__open_xattr(&attr);
>  }
>
> -struct bpf_object *bpf_object__open_buffer(void *obj_buf,
> -                                          size_t obj_buf_sz,
> -                                          const char *name)
> +struct bpf_object *
> +bpf_object__open_buffer_xattr(struct bpf_object_open_buffer_attr *attr)

I have few concerns w.r.t. adding API in this form and I'm going to
use this specific case to discuss more general problem of API design,
ABI compatibility, and extending APIs with extra optional arguments.

1. In general, I think it would be good for libbpf API usability to
use the following pattern consistently (moving forward):

T1 some_api_function(T2 mandatory_arg1, ..., TN mandatory_arg, struct
something_opts *opts)

So all the mandatory arguments that have to be provides are specified
explicitly as function arguments. That makes it very clear what API
expects to get always.
opts (we use both opts and attrs, but opts seems better because its
optional options :), on the other hand, is stuff that might be
omitted, so if user doesn't care about tuning behavior of API and
wants all-defaults behavior, then providing NULL here should just
work.

So in this case for bpf_object__open_buffer_xattr(), it could look like this:

struct bpf_object* bpf_object__open_buffer_opts(void *buf, size_t sz,
struct bpf_object_open_opts* opts);

2. Now, we need to do something with adding new options without
breaking ABIs. With all the existing extra attributes, when we need to
add new field to that struct, that can break old code that's
dynamically linked to newer versions of libbpf, because their
attr/opts struct is too short for new code, so that could cause
segment violation or can make libbpf read garbage for those newly
added fields. There are basically three ways we can go about this:

a. either provide the size of opts struct as an extra argument to each
API that uses options, so:
struct bpf_object* bpf_object__open_buffer_opts(void *buf, size_t sz,
struct bpf_object_open_opts* opts, size_t opts_sz);

b. make it mandatory that every option struct has to have as a first
field its size, so:

struct bpf_object_open_opts {
        size_t sz;
        /* now we can keep adding attrs */
};

Now, when options are provided, we'll read first sizeof(size_t) bytes,
validate it for sanity and then we'll know which fields are there or
not.

Both options have downside of user needing to do extra initialization,
but it's not too bad in either case. Especially in case b), if user
doesn't care about extra options, then no extra steps are necessary.
In case a, we can pass NULL, 0 at the end, so also not a big deal.

c. Alternatively, we can do symbol versioning similar how xsk.c
started doing it, and handle those options struct size differences
transparently. But that's a lot of extra boilerplate code in libbpf
and I'd like to avoid that, if possible.

3. Now, the last minor complain is about flags field. It's super
generic. Why not have a set of boolean fields in a struct, in this
case to allow to specify strict/compat modes. Given we solve struct
extensibility issue, adding new bool fields is not an issue at all, so
the benefit of flags field are gone. The downside of flags field is
that it's very opaque integer, you have to go and read sources to
understand all the intended use cases and possible flags, which is
certainly not a great user experience.

I'm curious to hear opinions of people regarding these ABI issues and solutions.


>  {
>         char tmp_name[64];
>

[...]
