Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5529D6A4AC6
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 20:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjB0TY2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 14:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0TY1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 14:24:27 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ABE1CF62
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:24:21 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ee7so30339289edb.2
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H2fbNoSblTqtonua3Ke9sw0jhRNgwlRSotZu7vrUiU=;
        b=T3qD3ZNt8p2DYMdtJ66lMXM/br+YAmiErKcP7uo3xn/f2qKIDugkL9BcxlBs2u9WYK
         5T1Ln4v3MsXjUI0hiXrCT63MTuk4CQk+Tm4rdhr4Ab79v8tjZKPtsotZfTjJrC5j4u7/
         Z1R+8UlgicKqoHrEflHCFYBy1AxQFjOs9F3lWzeyo03bUm8QA21WYdMYLxKkkh5H0mK7
         /u6tA/w/Obejl1VFaa1DVKtWoq9RGbTXyVXHyKEuensmUnsYPaGg28rTp8NV/SZofDql
         sxlLhJc3QGDUc1TVMNpC/hfzv0wcLFb7skLgzmqWLMChDdG1cfVBLObAz/DUtIbkL/Ma
         /B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1H2fbNoSblTqtonua3Ke9sw0jhRNgwlRSotZu7vrUiU=;
        b=YUcVDYTCWd1IvVwiuMWfH1/X9ysStN/Bv/9S24mPjab16qdxnkl6Q8sdT5MdFmFF4R
         g4h9gfqhZuXxYGdPzeQ2/yiCRWiu6jnvv8wzWnyP3JAPlqydym4qErMnoO8+T3ISQPHV
         /rDMxFQNccIAzVp9uRI2N587g1UGeZfLE+KSLfNtGvb7nps0e5H/SJBM1vgUAjT5hdz0
         rSbYWb2PGdqePOvFFADKeI4R4QJNPtKC4tebniPY9BqwlCBVaSulIoAdZO25yVCLC8Yb
         fdWWOyU8e3Mzz/0Rxzx4ztZRiP6NP0pyP3uyh4ZP+1A1oE4l9h2wqQkcg6+gCQrM1Kqd
         E6Ag==
X-Gm-Message-State: AO0yUKWdo+j5AJT7GIiYxzdkJK2Dt66/LOitOe3gjaqCxqq8XDAShImQ
        cMHxavBrPNpiQJqH4IuEoNAaA19OdeZz+WOPsw8=
X-Google-Smtp-Source: AK7set9M5Yk22DTtIZ6RnnM5OFhiJFxSEqFcoTuMgoCpV8Eb+Z8SoP/UrrUt05JurfZB6gMqZWqQRKDGMajyAV6LuLY=
X-Received: by 2002:a50:d0c2:0:b0:4ac:b626:378e with SMTP id
 g2-20020a50d0c2000000b004acb626378emr364761edf.5.1677525859459; Mon, 27 Feb
 2023 11:24:19 -0800 (PST)
MIME-Version: 1.0
References: <Y/P1yxAuV6Wj3A0K@google.com> <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
 <Y/czygarUnMnDF9m@google.com> <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
 <Y/hLsgSO3B+2g9iF@google.com> <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
 <Y/p0ryf5PcKIs7uj@google.com> <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
 <693dffd9571073a47820653fd2de863010491454.camel@gmail.com>
 <CAEf4BzYaiD27y=Y85xhrj+VOvJY_5q1oVtg-4vYmFZFEpmW+nQ@mail.gmail.com> <CACYkzJ7tgbJqwUVxfGd4UKDUcOQjK8zsbEKUUjV79=xHQn1fFg@mail.gmail.com>
In-Reply-To: <CACYkzJ7tgbJqwUVxfGd4UKDUcOQjK8zsbEKUUjV79=xHQn1fFg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 11:24:07 -0800
Message-ID: <CAEf4BzZauF7V3pY1hgWgnJRN1F6eSkbTOTG3kM0c85uAX-vOfQ@mail.gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
To:     KP Singh <kpsingh@kernel.org>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org,
        andrii@kernel.org, acme@redhat.com
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

On Mon, Feb 27, 2023 at 10:05 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Mon, Feb 27, 2023 at 6:32=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Feb 27, 2023 at 6:17 AM Eduard Zingerman <eddyz87@gmail.com> wr=
ote:
> > >
> > > On Sun, 2023-02-26 at 03:03 +0200, Eduard Zingerman wrote:
> > > > On Sat, 2023-02-25 at 20:50 +0000, Matt Bobrowski wrote:
> > > > > Sorry Eduard, I replied late last night although the email bounce=
d due
> > > > > to exceeding the mail char limit. Let's try attaching a compresse=
d
> > > > > variant of the requested files, which includes the compiled kerne=
l's
> > > > > BTF and the kernel's config.
> > > >
> > > > Hi Matt,
> > > >
> > > > I tried using your config but still can't reproduce the issue.
> > > > Will try to do it using debian 12 chroot tomorrow or on Monday.
> > >
> > > Hi Matt,
> > >
> > > Short update:
> > > I've reproduced the issue with multiple STRUCT 'linux_binprm' BTF IDs
> > > in Debian testing chroot, thank you for providing all details.
> > > Attaching the instructions in the end of the email.
> > > Need some time to analyze pahole behavior.
> > >
> >
> > Try using [0] to pinpoint what actually is different between any two
> > linux_binprm definitions. I've hacked up this "tool" last time I had
> > to pinpoint where two BTF types diverge, maybe it will save you a bit
> > of time as well. I'd like to put this functionality into btfdump
> > ([1]), but I didn't get to it yet, unfortunately.
> >
>
> It's not just linux_binprm but a bunch of other structs (quite a lot
> of them that seem to diverge)

yes, task_struct is usually a thing that suffers from such
duplications, as it forms a huge graph of types. Which is where that
btfdiff "tool" comes handly, it recursively compares side-by-side two
types that are supposed to be equal (but are not), by ignoring BTF
type IDs and trying to pin point actual differences (like STRUCT vs
FWD, or extra field, or whatever). It just needs two starting type
IDs.

>
> [...]
> WARN: multiple IDs found for 'sock_common': 4400, 53212 - using 4400
> WARN: multiple IDs found for 'request_sock': 4458, 53257 - using 4458
> WARN: multiple IDs found for 'task_struct': 265, 55830 - using 265
> WARN: multiple IDs found for 'file': 474, 55854 - using 474
> WARN: multiple IDs found for 'vm_area_struct': 480, 55857 - using 480
> WARN: multiple IDs found for 'seq_file': 670, 55891 - using 670


[...]

>
> I was able to "fix" this with using clang 16.x and the following hacky pa=
hole:
>
> 030e3b4 - core: Add DW_TAG_unspecified_type to tag__is_tag_type() set
> (HEAD) (2023-02-26 Arnaldo Carvalho de Melo)
> f20515b - dwarves: support DW_TAG_atomic_type (2023-02-26 David Lamparter=
)
> de24234 - pahole: Prep 1.24 (tag: v1.24) (2022-08-22 Arnaldo Carvalho de =
Melo)
> d6c9528 - dwarf_loader: Encode char type as signed (2022-08-10 Yonghong S=
ong)
>
> and the the following patch on top:
>

I'd start with understanding what BTF and DWARF differences are
causing the issue before trying to come up with the fix. For that we
don't even need config or repro steps, it should be enough to share
vmlinux with BTF and DWARF, and start from there.

But I'm sure Eduard is on top of this already (especially that he can
repro the issue now).
