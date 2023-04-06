Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22746DA459
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 23:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjDFVFH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 17:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDFVFH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 17:05:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9057683
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 14:05:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so44088149pjt.2
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680815105; x=1683407105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNRCJoIoDXAo0VVuK3T57BNRjFdXWTL7erL+hT1pobU=;
        b=SlSBp5P3vWCVXWndx68keciSexeGpoefJ6NVWI331gvwvvXrW9/1eqeNnWYGciClva
         gKIACFDiSyGK/FkirUM8ez0ly+s2HADiRcj6IXcquK+EUrnUy7RLXL1xURt13eBaBxCF
         YVVqeYtLeMNx6jc538OJfK7JxcOl4Om/zFPTP0ZQgGqpbySNqQ2xItfw4gW4dhPKyEhy
         bkVWRpK0Xi/xRH96dlCMt0BsGLUtdwpqZF8x2eMaWsT5VjXSn9qYgGop5hhO+1aUdz8i
         GgA/tiq2nzX0qhStdj2rdMljBpLw1cgnrfwM73KqcttOy37/7FTkmmlo+jK5HerFgoJW
         JaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815105; x=1683407105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNRCJoIoDXAo0VVuK3T57BNRjFdXWTL7erL+hT1pobU=;
        b=yZBBctYJXSuntZRocu6JrsaNby9ayJQrJoq05+Np+4df/qekA7Z6t/4/G0pYAn8fud
         wCM7qNM3VvVzGGG4quvMAsB1OQbEhPgYimgbzH/u/BAHS+cL5j4+PFTvJwQjZGvFZ6K7
         sLYy345Ri7uElfAWYjcmNjZ1U53jyimlaay1JHU2EL98WPTGLHvA0hJSln0mZUpkVq2J
         4psCRtfRkD2hI1mTbhB4hKzjfhWRq1+tnN2TheGv5CfdviYRkWFtSZaAOmWaKdGvIlbN
         MuKorlfFhtzYskRVohjMzWDMOyat4qEKFr8yQjjA+IlZZ0kShSnz4Wc4hpdijHlOZ2tA
         hiqg==
X-Gm-Message-State: AAQBX9esvAz22xyrrzeBFbTaqFoi++yyUBkutz6NV1bW56VuZkMQRtrg
        hNHcAZwiyeFpmYwwXBjKVKFZ1FPQYBQyGzJsWBZKrQ==
X-Google-Smtp-Source: AKy350b4mgPyvzJv0j7I0hAXuUqukiGbXQ1tLOWMuoKx+ok1ZwW4SOWNtVA293Yioyr06nkuefunTNhAi0mfsA4z1Ug=
X-Received: by 2002:a17:90a:4886:b0:23b:5155:309f with SMTP id
 b6-20020a17090a488600b0023b5155309fmr2914464pjh.0.1680815105131; Thu, 06 Apr
 2023 14:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PiJmRwv8UTyQuEBmn1aHg5mXGqHSpAiOJF0Xo9SwZLfW623A@mail.gmail.com>
 <CAEf4BzZntoM0fHzgBuGiqiTNkq=jT-f09nwub-MHyguJCfLeNA@mail.gmail.com>
 <CA+PiJmSNnQ9DD+JVc9hG7iEj5ZDZfhOhYAMKs+f=kXs=DZxuAA@mail.gmail.com>
 <CAADnVQKMrsc+Dxz3uWeKzCPDfr0XKWaWsbn3AeEm+RCmp-apUQ@mail.gmail.com>
 <CA+PiJmT4KyWAAEbYWggOLdy-WR=m1D+EO3j1+=UbY-wVUpzYDA@mail.gmail.com>
 <20230405025726.nesfo5rwuiqnzgqc@macbook-pro-6.dhcp.thefacebook.com> <CAEf4BzaD+8tStmJ4i5TeSNpCMhwZ4CkTYMYf+N9YHwK46EtCcA@mail.gmail.com>
In-Reply-To: <CAEf4BzaD+8tStmJ4i5TeSNpCMhwZ4CkTYMYf+N9YHwK46EtCcA@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 6 Apr 2023 14:04:54 -0700
Message-ID: <CA+PiJmQ8_uVczuHTrOz9uJh2z2Ywf0HVNttbKMVPLF59oSQ4XQ@mail.gmail.com>
Subject: Re: Dynptrs and Strings
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 7:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> so the idea that bpf prog will see opaque ctx =3D=3D name and a set
> of kfuncs will extract different things from ctx into local dynptrs ?
>
> Have you considered passing dynptr-s directly into bpf progs
> as arguments of struct_ops callbacks?
> That would be faster or slower performance wise?
>

The kfunc records data that fuse then uses to clean up afterwards.
That opaque struct seemed like the best place for it to live.
Alternatively, I could provide dynpointers up front, but those are
read only or read/write up front based on which operation they're
dealing with, and may or may not be promotable to read/write, which
involves creating a new dynpointer anyways. If I took that approach,
I'd likely present a read-only dynpointer, and wrap it in a larger
struct that contains the needed meta information. I'd definitely need
to ensure that only fuse-bpf can call those kfuncs in that case.

>
> yep. Don't be shy from improving the verifier to your needs.
>

Uploaded a couple patches yesterday :)
A patch to remove the buffer requirement for the slice functions, and
another to accept dynpointer tagged mem as mem in helper functions.


On Wed, Apr 5, 2023 at 11:49=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> note that even if bpf_dynptr_slice() accepts a buffer, it won't ever
> touch it for LOCAL dynptrs, as the data is already linear in memory.
> This buffer is filled out only for skb/xdp **and** only if requested
> memory range can't be accessed as sequential memory. So you won't be
> copying data.
>

I added an '__opt' tag annotation for this, so I can avoid needing to
supply the buffer in those cases.

> For bpf_dynptr_read(), yep, it will copy data. Regardless if you are
> going to use it or not, we should relax the condition that final
> buffer should be smaller or equal to dynptr actual size, it should be
> bigger and we should just write to first N bytes of it.
>

Should dynptr_read return the length read? Otherwise you need to get
the dynpointer length and adjust for all the offsets to figure out how
much was probably read. But returning the length read would break
existing programs.
I also noticed that the various dynpointer offset/length checks don't
seem to account for both the dynpointer offset and the read/write etc
offset. All of the bounds checking there could use another pass.

> >
> > > At the moment I'm using bpf_dynptr_slice and declaring an empty and
> > > unused buffer. I'm then hitting an issue with bpf_strncmp not
> > > expecting mem that's tagged as being associated with a dynptr. I'm
> > > currently working around that by adjusting check_reg_type to be less
> > > picky, stripping away DYNPTR_TYPE_LOCAL if we're looking at an
> > > ARG_PTR_TO_MEM. I suspect that would also be the case for other dynpt=
r
> > > types.
>
> So this seems unintended (or there is some unintentional misuse of
> memory vs dynptr itself), we might be missing something in how we
> handle arguments right now. It would be nice if you can send a patch
> with a small selftest demonstrating this (and maybe a fix :) ).
>

Done :) Though not sure if the selftests I added are sufficient.
https://lore.kernel.org/bpf/20230406004018.1439952-1-drosen@google.com/

>
> We had previous discussions about whether to treat read-only as a
> runtime-only or statically known attribute. There were pros and cons,
> I don't remember what we ended up deciding. We do some custom handling
> for some SKB programs, but it would be good to handle this
> universally, yep.
>

I think it's currently not tracked, although the read only tag was
being used for the dynptr itself. Almost tricked me there. In that
case it'd probably be easier to add dynptr_data_ro than to add that
information everywhere.

>
> +1. I feel like we are just missing a few helpers to help extract
> and/or compare variable-sized strings (like bpf_dynptr_strncmp
> mentioned earlier) for all this to work well. But a concrete use case
> would allow us to design a coherent set of APIs to help with this.

Should be able to get that patch set together soon. I'm reworking the
test code with the verifier changes I mentioned above, and then will
be doing a round of cleanup to make it a bit more possible to see
what's actually in use now.
