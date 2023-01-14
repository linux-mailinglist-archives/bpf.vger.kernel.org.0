Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCD66A8BC
	for <lists+bpf@lfdr.de>; Sat, 14 Jan 2023 03:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjANCom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 21:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjANCol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 21:44:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F557D9D5
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 18:44:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s5so33594435edc.12
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 18:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpDjNSBHRRCufC77uitEKR7waQgAP+nSJzJsq337PtY=;
        b=ZVSxV0ddk12xNZzPei1/XC/6s6V1vcNUWjLkWOPUn5/Qb5n+Tl+KYs5PhYtkklb5e1
         OOpBBCtPBez08zBOGSKkIuZ8R+2UotBWD8BOFQgebqMQS7P8RuRnXmyC0Zn/xfy98WGd
         UxjPfXS2zZtcLD+ObvaAsudxgahMkwUDlA5dh75lqDQ8PWrwSprLfORlX7EeaYR5Zo6Y
         rEpLhUmzQhKEVX1fshrpzuQgt5d6+/y7C85mYRsEvgdJpIonjuL0FYrxsRwvRtfwSMxb
         iV3n4cMTFnsWCv7goVmxBAsDFyQTEDiX3ZhBy0a40vCIRD6lA1mqL+2dieqVHx+FIDjE
         KrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpDjNSBHRRCufC77uitEKR7waQgAP+nSJzJsq337PtY=;
        b=TRWB9Nww2pL4kSWC/ezaUMMs+36PdAP+NLc0Uy7GnVhgKWIXFplFdYxYdD4Svx/3kd
         hw7hU8S96BwVzJXbtsvJ7TYGn4cpqr97rYicnfvkBeuGDsoIiLVddWtC951mZpYmyQh+
         2RxRWAM0nZfsUnfrMpBbXTgupjLfWnPiMNk9ogw3fp6hXYANV/L7MPNCxIxYb3UdtUe9
         dkQPFeoKalK/ehBkbmtjdJUbk63lNR4qV3IXPhGX0+awB1X6Z5M3HOeYnyYgjf2bROHS
         HIC4FzmWJCYOo3AsQzy7/myNsDixfe9izgGAW7bqK8YThn6e/j0/ZNXAu50+pPlpzi4s
         /KkQ==
X-Gm-Message-State: AFqh2koEQ9T/G8kp0RtN2oVS2olpPWaO6O8znIf6+vzVKzhMTA/on0WR
        uTFYvUjvM5ODNEjG/g9EKU2qmp9I0izyOtkoUJA=
X-Google-Smtp-Source: AMrXdXv0ft8ivo/P65fOa7I7m/NkKjStJL5Z8m2pSK0ajkGnN+qZCZ1zgUvdyhotVHP0cZ/pTlZZiQ8ev+1AwX6j0N8=
X-Received: by 2002:a05:6402:2208:b0:48a:7ada:b260 with SMTP id
 cq8-20020a056402220800b0048a7adab260mr4904851edb.311.1673664278272; Fri, 13
 Jan 2023 18:44:38 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
 <CAEf4BzYztcahNoFH_CvtWz_1dTA3SSYv+zOorsyP0TfX-2EdaA@mail.gmail.com>
 <CA+khW7gXaHwxZjS1sp0oAF-t0jk0+CnwxdhV9kqyBfqEVack-w@mail.gmail.com>
 <CAEf4BzaQPtFMkcJdH4m5S0X5t3UD1M0M_bJk9Z65Zspb5bbxgA@mail.gmail.com> <CA+khW7g44a7a1-C+q7B5NA1DPiM6zCanLsrXOfNm1vOvKwPtAw@mail.gmail.com>
In-Reply-To: <CA+khW7g44a7a1-C+q7B5NA1DPiM6zCanLsrXOfNm1vOvKwPtAw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Jan 2023 18:44:26 -0800
Message-ID: <CAEf4BzbtKXzk2oLkmYM_6uiAg5OpxvoakgiS3tsh4+Z1hK1GDg@mail.gmail.com>
Subject: Re: CORE feature request: support checking field type directly
To:     Hao Luo <haoluo@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 6:20 PM Hao Luo <haoluo@google.com> wrote:
>
> On Fri, Jan 13, 2023 at 5:14 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 13, 2023 at 5:06 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Fri, Jan 13, 2023 at 3:41 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> <...>
> > > >
> > > > Have you tried bpf_core_type_matches()? It seems like exactly what =
you
> > > > are looking for? See [0] for logic of what constitutes "a match".
> > > >
> > >
> > > It seems bpf_core_type_matches() is for the userspace code. I'm
> >
> > It's in the same family as bpf_type_{exists,size}() and
> > bpf_field_{exists,size,offset}(). It's purely BPF-side. Please grep
> > for bpf_core_type_matches() in selftests/bpf.
> >
> > > looking for type checking in the BPF code. We probably don't need to
> > > check type equivalence, just comparing the btf_id of the field's type
> > > and the btf_id of a target type may be sufficient.
> >
> > With the example above something like below should work:
> >
> > struct rw_semaphore__old {
> >         struct task_struct *owner;
> > };
> >
> > struct rw_semaphore__new {
> >         atomic_long_t owner;
> > };
> >
> > u64 owner;
> > if (bpf_core_type_matches(struct rw_semaphore__old) /* owner is
> > task_struct pointer */) {
> >         struct rw_semaphore__old *old =3D (struct rw_semaphore__old *)s=
em;
> >         owner =3D (u64)sem->owner;
> > } else if (bpf_core_type_matches(struct rw_semaphore__old) /* owner
> > field is atomic_long_t */) {
> >         struct rw_semaphore__new *new =3D (struct rw_semaphore__new *)s=
em;
> >         owner =3D new->owner.counter;
> > }
> >
> > >
> > > The commit 94a9717b3c (=E2=80=9Clocking/rwsem: Make rwsem->owner an
> > > atomic_long_t=E2=80=9D) is rare, but the 'owner' field is useful for =
tracking
> > > the owner of a kernel lock.
> >
> > We implemented bpf_core_type_matches() to detect tracepoint changes,
> > which is equivalent (if not harder) use case. Give it a try.
> >
>
> Thanks Andrii for the pointer. It's still not working. I got the
> following error when loading:
>
> libbpf: prog 'on_contention_begin': relo #1: parsing [43] struct
> rw_semaphore__old + 0 failed: -22
> libbpf: prog 'on_contention_begin': relo #1: failed to relocate: -22
> libbpf: failed to perform CO-RE relocations: -22
>
> I'll dig a little more next week.

You need triple underscore between old and new suffixes, see [0] for
ignored suffix rule.

  [0] https://nakryiko.com/posts/bpf-core-reference-guide/#handling-incompa=
tible-field-and-type-changes
