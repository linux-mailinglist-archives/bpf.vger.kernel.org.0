Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131874B35EB
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 16:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiBLPsH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Feb 2022 10:48:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiBLPsG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 10:48:06 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F48212
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 07:48:03 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e8so9126863ilm.13
        for <bpf@vger.kernel.org>; Sat, 12 Feb 2022 07:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s1msFUotavtYgJbNoDnJzgqT8fJqEttCL99z4wtICxY=;
        b=TSYaEPM04uh/T7t7XGsHOr3VEc7P32JQdzjcnXSd057E2CsQRm72cFZ4T1b/AvRJY8
         beouEUkk3jAljWv9XnEW76OSuGHct6CC6THK/ECOueC6gwn1NCmYWbLgBRftLmBc/LPZ
         /A/zT7rBSqUIi2kAJAVST8f4zz1/bsg0LKAqa/ETHh2buf7zVm1i7MdVHLU2FK5I3ONI
         +TbT76d9JJiPZVkkmDfB8F06ns1HYDAX0Pq7lw+UumKQA9U2Hs7IJalUGZULNXISj2ZX
         H3AX582GyU0uPKgYzVf+8yDRYUA5L+QY4au8pjhKrV1jL4Q6+gWSc+UkBb9SuYk63fol
         X8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s1msFUotavtYgJbNoDnJzgqT8fJqEttCL99z4wtICxY=;
        b=gPGrOWik04cQBs+vxj1vpO1wygdniNwbOTHwZFqR2Tbp+SjlQvJFqjjsmIMzGAMe2+
         vI3C9JPt5Wbz7QnF8zHgwzgcrPUbKX7B38TyXUngwChqfdNRGfKiO7gYJ4fuYqec1yaG
         JaMbBtHUB7U83cjhIE8Jt/miSMMAt1be8jih6WnDKwZwytQyR91UbQz3q4/STzHsNpcK
         RjNKTiYJ9RLsgCXsa2XfYxtQsxXKZl5tAgTcYtJVMp7KOpBLata0APmnlhqqwH4Xy4uG
         WxFrEyp3i87Um67d3TBvgwZZjRq1IK85ZmVdEb/A5NrQU+9kEitD1KQXImr+oSfK4PHT
         JQzA==
X-Gm-Message-State: AOAM530kStjLwBKbkM8IHgi6FkuqoYq9jQNpasjU2EBKRmb5Wd0XGoXi
        LtQx0NUx7msL53L/azG4FEwiWRDmDoE1HqRJimarVBzW6Mw=
X-Google-Smtp-Source: ABdhPJxyR7rU/GiUR+ogU2J7XgY7prKDNlTSiFd4zZas9VYg8c9xezVNKpYZPPUxJYb763VIlM9t/myaRGalUCNDdSQ=
X-Received: by 2002:a05:6e02:1a6c:: with SMTP id w12mr3533577ilv.305.1644680882432;
 Sat, 12 Feb 2022 07:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20220212073054.1052880-1-andrii@kernel.org> <YgfToqR6xR5lq0HI@kernel.org>
 <YgfUEW5pa0eMN3/I@kernel.org>
In-Reply-To: <YgfUEW5pa0eMN3/I@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 12 Feb 2022 07:47:51 -0800
Message-ID: <CAEf4BzZg-2KnWgs7TxJa+BAytGqAOZdg0VPVv68_WzpEoqxQ1g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/2] perf: stop using deprecated bpf APIs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 12, 2022 at 7:36 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sat, Feb 12, 2022 at 12:34:58PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, Feb 11, 2022 at 11:30:52PM -0800, Andrii Nakryiko escreveu:
> > > libbpf's bpf_prog_load() and bpf__object_next() APIs are deprecated.
> > > remove perf's usage of these deprecated functions. After this patch
> > > set, the only remaining libbpf deprecated APIs in perf would be
> > > bpf_program__set_prep() and bpf_program__nth_fd().
> >
> > Not applying to perf/core, I'm checking...
>
> Just some fuzz on the second patch:
>
> =E2=AC=A2[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
> patching file tools/perf/util/bpf-loader.c
> Hunk #2 succeeded at 111 with fuzz 1 (offset -1 lines).
> Hunk #3 succeeded at 156 (offset -2 lines).
> Hunk #4 succeeded at 1563 (offset 8 lines).
> Hunk #5 succeeded at 1575 (offset 8 lines).
> Hunk #6 succeeded at 1628 (offset 8 lines).
> =E2=AC=A2[acme@toolbox perf]$
>
> Applying manually to test on the set of test build containers.

Sorry, my bad. I just followed my typical bpf-next routine and didn't
even think twice before basing everything off bpf-next. You can see I
didn't even CC you or linux-perf-users@vger.kernel.org. :(

I'll resend v6 against perf/core.


>
> - Arnaldo
>
> > =E2=AC=A2[acme@toolbox perf]$ b4 am -ctsl --cc-trailers 20220212073054.=
1052880-1-andrii@kernel.org
> > Looking up https://lore.kernel.org/r/20220212073054.1052880-1-andrii%40=
kernel.org
> > Grabbing thread from lore.kernel.org/all/20220212073054.1052880-1-andri=
i%40kernel.org/t.mbox.gz
> > Checking for newer revisions on https://lore.kernel.org/all/
> > Analyzing 3 messages in the thread
> > Checking attestation on all messages, may take a moment...
> > ---
> >   [PATCH v5 1/2] perf: Stop using deprecated bpf_load_program() API
> >     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >     + Link: https://lore.kernel.org/r/20220212073054.1052880-2-andrii@k=
ernel.org
> >     + Cc: kernel-team@fb.com
> >     + Cc: daniel@iogearbox.net
> >     + Cc: ast@kernel.org
> >     + Cc: bpf@vger.kernel.org
> >   [PATCH v5 2/2] perf: Stop using deprecated bpf_object__next() API
> >     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >     + Link: https://lore.kernel.org/r/20220212073054.1052880-3-andrii@k=
ernel.org
> >     + Cc: kernel-team@fb.com
> >     + Cc: daniel@iogearbox.net
> >     + Cc: ast@kernel.org
> >     + Cc: bpf@vger.kernel.org
> > ---
> > Total patches: 2
> > ---
> > Cover: ./v5_20220211_andrii_perf_stop_using_deprecated_bpf_apis.cover
> >  Link: https://lore.kernel.org/r/20220212073054.1052880-1-andrii@kernel=
.org
> >  Base: not specified
> >        git am ./v5_20220211_andrii_perf_stop_using_deprecated_bpf_apis.=
mbx
> > =E2=AC=A2[acme@toolbox perf]$        git am ./v5_20220211_andrii_perf_s=
top_using_deprecated_bpf_apis.mbx
> > Applying: perf: Stop using deprecated bpf_load_program() API
> > Applying: perf: Stop using deprecated bpf_object__next() API
> > error: patch failed: tools/perf/util/bpf-loader.c:68
> > error: tools/perf/util/bpf-loader.c: patch does not apply
> > Patch failed at 0002 perf: Stop using deprecated bpf_object__next() API
> > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> >
> >
> > - Arnaldo
> >
> > > v4 -> v5:
> > >   - add bpf_perf_object__add() and use it where appropriate (Jiri);
> > >   - use __maybe_unused in first patch;
> > > v3 -> v4:
> > >   - Fixed commit title
> > >   - Added weak definition for deprecated function
> > > v2 -> v3:
> > >   - Fixed commit message to use upstream perf
> > > v1 -> v2:
> > >   - Added missing commit message
> > >   - Added more details to commit message and added steps to reproduce
> > >     original test case.
> > >
> > > Christy Lee (2):
> > >   perf: Stop using deprecated bpf_load_program() API
> > >   perf: Stop using deprecated bpf_object__next() API
> > >
> > >  tools/perf/tests/bpf.c       | 14 ++----
> > >  tools/perf/util/bpf-event.c  | 13 +++++
> > >  tools/perf/util/bpf-loader.c | 98 +++++++++++++++++++++++++++++-----=
--
> > >  3 files changed, 96 insertions(+), 29 deletions(-)
> > >
> > > --
> > > 2.30.2
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
