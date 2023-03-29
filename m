Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE96CF3FF
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC2UDV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjC2UDS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 16:03:18 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20674EE3
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 13:03:16 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id q27so11797005oiw.0
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680120196; x=1682712196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zUxVz1Quf/wwaC4Az7rB3yNXnpX0SUpoRreER7n7PU=;
        b=qdO3PmDavk21uIgP8fNjUYHtz+Eow3WW+F4NIbC8qJD+VagxAIQjWN9IvkS5d5wnSA
         zgC6u4IZYuY3WkbLUdEV5eDwcjtni8qdIPaaJpLfw/bJlZUMurQAfNRmnAl9lWHJE2Su
         IkJ/9U2s9jqymrRBCOTZpSOcKVSi26Jq2J8f8pVyw/6D9jnbNJoqPpMblZjlHcmKMXJX
         +0UDMoeG2YopFnGd4r6fxpc00P7fUj2GJmjhxS021YPG6VPUrVHj+z/vjitmaz+yy1pO
         gki1a115udjxVXnJRxg0BgrL2JifF2O/P14XlTCUppdwl/wPTJxmfJrVumFkcX0YKymg
         VknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680120196; x=1682712196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zUxVz1Quf/wwaC4Az7rB3yNXnpX0SUpoRreER7n7PU=;
        b=Qf2hmUQYHM536GlT5RWLb9aW/AM1O913HfN2K84huKb7lJyikgR/F7RSnyRc5bW22X
         p0g+pjp4+Hj/1OroJdM01B5WAxRD7WqAxcIFbHAtnbVd15U1rntIfx2SXoYPYBP+ss1B
         kyNLJpd68RzN+QyNP0Fs5HIeOHm4/aXToOb2qTJPD0FHn7SicNFLmN5MMLhC4v0lZzwp
         QvANfdAcDw14AMLsj/05M2fwdqIXUtpYbBzdn0UOJTxB0UYH/Prg9kfHmp/tRgz3EQ5u
         PzmplKZIGIrdeFOkh4CLsRI1U4H9fIviPfrqWKHA9B1/US9rommHppMzD4oo/M26Ojgn
         eCiQ==
X-Gm-Message-State: AO0yUKWxdcz/+C4/TraB+idxDQhKEW9caHNado/5HT2uta5MzaCuwfRm
        kUyUD4DYad7JNyUFIPK0dYfo1eRx5bR1ppunhIKR48bddF0QEg==
X-Google-Smtp-Source: AK7set8U/xwUbdwdJXYMOivAJjqhPCVW0x7998wg8rfZtoyoAXq2NusBl4WNX0PLs07/ND7U9y0pLvFw3K0fYXuTdB0=
X-Received: by 2002:aca:916:0:b0:386:d8a5:d80b with SMTP id
 22-20020aca0916000000b00386d8a5d80bmr5351340oij.4.1680120196076; Wed, 29 Mar
 2023 13:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230322215246.1675516-1-martin.lau@linux.dev>
 <20230322215246.1675516-6-martin.lau@linux.dev> <CADvTj4rP3kPODxARVTEs2HsNFOof-BZtr8OsEKdjgcGVOTqKaA@mail.gmail.com>
 <456bcd47-efa2-7e3d-78c0-5f41ecba477c@linux.dev> <CADvTj4ouGHvPHEgZobUewY2ZjHZhTzJ96oCBAV8VO2xT2bPC0Q@mail.gmail.com>
 <2b5b56bb-7160-41ac-1fb8-4dbc6ad67d9f@linux.dev>
In-Reply-To: <2b5b56bb-7160-41ac-1fb8-4dbc6ad67d9f@linux.dev>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 29 Mar 2023 14:03:04 -0600
Message-ID: <CADvTj4pctyvU+9wQ3T+jq49NAxMV89eOFfj3bp3_GfFuJ99opA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/5] selftests/bpf: Add bench for task storage creation
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        David Faust <david.faust@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 1:59=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 3/29/23 12:12 PM, James Hilliard wrote:
> > On Wed, Mar 29, 2023 at 11:03=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>
> >> On 3/27/23 8:51 PM, James Hilliard wrote:
> >>>> diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_c=
reate.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
> >>>> index 2814bab54d28..7c851c9d5e47 100644
> >>>> --- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
> >>>> +++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
> >>>> @@ -22,6 +22,13 @@ struct {
> >>>>           __type(value, struct storage);
> >>>>    } sk_storage_map SEC(".maps");
> >>>>
> >>>> +struct {
> >>>> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> >>>> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> >>>> +       __type(key, int);
> >>>> +       __type(value, struct storage);
> >>>> +} task_storage_map SEC(".maps");
> >>>> +
> >>>>    SEC("raw_tp/kmalloc")
> >>>>    int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
> >>>>                size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags=
,
> >>>> @@ -32,6 +39,24 @@ int BPF_PROG(kmalloc, unsigned long call_site, co=
nst void *ptr,
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> +SEC("tp_btf/sched_process_fork")
> >>>> +int BPF_PROG(fork, struct task_struct *parent, struct task_struct *=
child)
> >>>
> >>> Apparently fork is a built-in function in bpf-gcc:
> >>
> >> It is also failing in a plain C program
> >>
> >> #>  gcc -Werror=3Dbuiltin-declaration-mismatch -o test test.c
> >> test.c:14:35: error: conflicting types for built-in function =E2=80=98=
fork=E2=80=99; expected
> >> =E2=80=98int(void)=E2=80=99 [-Werror=3Dbuiltin-declaration-mismatch]
> >>      14 | int __attribute__((__noinline__)) fork(long x, long y)
> >>         |                                   ^~~~
> >> cc1: some warnings being treated as errors
> >>
> >> #> clang -o test test.c
> >> succeed
> >>
> >> I am not too attached to the name but it seems something should be add=
ressed in
> >> the gcc instead.
> >
> > Hmm, so it looks like it's marked as a builtin here:
> > https://github.com/gcc-mirror/gcc/blob/releases/gcc-12.1.0/gcc/builtins=
.def#L875
> >
> > The macro for that is here:
> > https://github.com/gcc-mirror/gcc/blob/releases/gcc-12.1.0/gcc/builtins=
.def#L104-L111
> >
> > Which has this comment:
> > /* Like DEF_LIB_BUILTIN, except that the function is not one that is
> > specified by ANSI/ISO C. So, when we're being fully conformant we
> > ignore the version of these builtins that does not begin with
> > __builtin. */
> >
> > Looks like this builtin was originally added here:
> > https://github.com/gcc-mirror/gcc/commit/d1c38823924506d389ca58d02926ac=
e21bdf82fa
> >
> > Based on this issue it looks like fork is treated as a builtin for
> > libgcov support:
> > https://gcc.gnu.org/bugzilla//show_bug.cgi?id=3D82457
> >
> > So from my understanding fork is a gcc builtin when building with -std=
=3Dgnu11
> > but is not a builtin when building with -std=3Dc11.
>
> That sounds like there is a knob to turn this behavior on and off. Do the=
 same
> for the bpf target?

I don't think we want to have to do that.

>
> >
> > So it looks like fork is translated to __gcov_fork when -std=3Dgnu* is =
set which
> > is why we get this error.
> >
> > As this appears to be intended behavior for gcc I think the best option=
 is
> > to just rename the function so that we don't run into issues when build=
ing
> > with gnu extensions like -std=3Dgnu11.
>
> Is it sure 'fork' is the only culprit? If not, it is better to address it
> properly because this unnecessary name change is annoying when switching =
bpf
> prog from clang to gcc. Like changing the name in this .c here has to mak=
e
> another change to the .c in the prog_tests/ directory.

We've fixed a similar issue in the past by renaming to avoid a
conflict with the builtin:
https://github.com/torvalds/linux/commit/ab0350c743d5c93fd88742f02b3dff1216=
8ab435

>
> >
> >>
> >>>
> >>> In file included from progs/bench_local_storage_create.c:6:
> >>> progs/bench_local_storage_create.c:43:14: error: conflicting types fo=
r
> >>> built-in function 'fork'; expected 'int(void)'
> >>> [-Werror=3Dbuiltin-declaration-mismatch]
> >>>      43 | int BPF_PROG(fork, struct task_struct *parent, struct
> >>> task_struct *child)
> >>>         |              ^~~~
> >>>
> >>> I haven't been able to find this documented anywhere however.
> >>
>
