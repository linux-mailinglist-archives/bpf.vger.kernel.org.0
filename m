Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1C4963AA
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbiAURUw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 12:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbiAURUv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 12:20:51 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F18C06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 09:20:51 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id o9so11622608iob.3
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 09:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFWfF+fE/rjJhNwX0XcZZq8rJjzcpaAZR/DfHSrNhTU=;
        b=SU0CNvrqnd0AS2EHK698eRDJ7CWLSncMg2JImaH8URpJiuteiHzKXyrD9p+wl9Lzu3
         CpPPXkbvh8+5fSyYWMchLafdvl16gLF611IXOM/mRq3b5EynuJ0Z3Yqch87tnQyuan3/
         wrggeRWHZTDx3SlAMOwWzoRLtVv/1otXhNFosRPuLFB+e+LJ7DXkDn4UZGRZ2D1WjfQQ
         a3Xz+S9ZMKa0OfJHHX3xA9G25vNA+lwopbw9dIqQLhKCG5XWGC4mjcWA7uAQ70INStVr
         nq6bIbBYLLakvEBZ8UqDKaJTVi+m+9UQdKdaeDSA8wKE+kLIDmbUx9xV++g8Jq7sVgfg
         ingw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFWfF+fE/rjJhNwX0XcZZq8rJjzcpaAZR/DfHSrNhTU=;
        b=Wfex5Cm6/cyaOg1/Od+cZm4PD0vxARl28J54befdUEzgGmPVZCU78mJwRH21kAHkLN
         gtWvZvffZ2andL/591wVP9Zv40sAvGV1DcQyzgae+LwWH6JZ2twmH8hTuMm1Mh8fQukP
         5T4M3YsUBQZj06ZC5MhGK5ZbDj1WL8VTFo0buP0ZV7ztwlSinKwPfpEm/FXbScR7CiEJ
         xQOF8St0pNKNekjoqhXYDzcJiULSuFa/4MnqaYnuVjE3z6xEemUfxgQn+yMWvSFKZRU+
         WLOFZ8Q2hVaKl6R7kxJ9fAitkmGYE7/Ki4e/5UMhrbha4iHgEGcTklGjOSYqZxXqbLKT
         tIMA==
X-Gm-Message-State: AOAM530Vt67UmjL7IMdpHJG9IyBmDaAzuZr4iAFlh6jAX3uc7g0NFzkJ
        eBecWrb8Mrctqts5uKQLCBhrtqqMUILqqXZF0UY=
X-Google-Smtp-Source: ABdhPJxSRbhCJkWfHL6+vqkdjvgORAVOweE2Ptpi4Xhg6EoguCIYHY2T74PzGxFvIqfdtxsWggDoxtpWfUaQx+fDSPc=
X-Received: by 2002:a5d:9f01:: with SMTP id q1mr2555481iot.144.1642785650909;
 Fri, 21 Jan 2022 09:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220120172942.246805-1-kennyyu@fb.com>
 <20220120172942.246805-2-kennyyu@fb.com> <CAEf4BzbEqSh36mFsrwtMYD6c-=LcJ3XbJsEa1ZatLdWkB+3mtQ@mail.gmail.com>
 <CAADnVQL-85q36gRvMGocXMLNk4WjDa_Xpi8Y9ZQS+qYLhF8E+A@mail.gmail.com>
In-Reply-To: <CAADnVQL-85q36gRvMGocXMLNk4WjDa_Xpi8Y9ZQS+qYLhF8E+A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Jan 2022 09:20:39 -0800
Message-ID: <CAEf4Bzaen2f2njYOAJuyWot2YvXn0YV=2zBVyFZw=_CqJdggPw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kenny Yu <kennyyu@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Gabriele <phoenix1987@gmail.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 20, 2022 at 6:28 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 20, 2022 at 2:46 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> a
> > > + *             wrapper of **access_process_vm**\ ().
> > > + *     Return
> > > + *             The number of bytes written to the buffer, or a negative error
> > > + *             in case of failure.
> >
> > wait, can it read less than *size* and return success?
> >
> > bpf_probe_read_kernel() returns:
> >
> > 0 on success, or a negative error in case of failure.
> >
> > Let's be consistent. Returning the number of read bytes makes more
> > sense in cases when we don't know the amount of bytes to be actually
> > read ahead of time (e.g., when reading zero-terminated strings).
> >
> > BTW, should we also add a C string reading helper as well, just like
> > there is bpf_probe_read_user_str() and bpf_probe_read_user()?
>
> That would be difficult. There is no suitable kernel api for that.

Ok, but maybe we can add it later. Otherwise it will be hard to
profiler Python processes and such, because you most certainly will
need to read zero-terminated strings there.

>
> > Another thing, I think it's important to mention that this helper can
> > be used only from sleepable BPF programs.
> >
> > And not to start the bikeshedding session, but we have
> > bpf_copy_from_user(), wouldn't something like
> > bpf_copy_from_user_{vm,process,remote}() be more in line and less
> > surprising for BPF users. BTW, "access" implies writing just as much
> > as reading, so using "access" in the sense of "read" seems wrong and
> > confusing.
>
> How about bpf_copy_from_user_task() ?
> The task is the second to last argument, so the name fits ?

yeah, I like the name


> Especially if we call it this way it would be best to align
> return codes with bpf_copy_from_user.
> Adding memset() in case of failure is mandatory too.
> I've missed this bit earlier.

Yep, good catch! Seems like copy_from_user() currently returns amount
of bytes *not* read and memsets those unread bytes to zero. So for
efficiency we could probably memset only those that were read.

>
> The question is to decide what to do with
> ret > 0 && ret < size condition.
> Is it a failure and we should memset() the whole buffer and
> return -EFAULT or memset only the leftover bytes and return 0?
> I think the former is best to align with bpf_copy_from_user.

Yeah, I think all or nothing approach (either complete success and
zero return, or memset and error return) is best and most in line with
other similar helpers.
