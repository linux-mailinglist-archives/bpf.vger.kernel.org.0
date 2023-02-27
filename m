Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4DE6A4AD9
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 20:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjB0T31 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 14:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjB0T30 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 14:29:26 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEAC1C7CC
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:29:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so4496006wmc.5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677526164;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ekalVOfJxHXcdcHO5GKUDX6+cAIhLbZ0sHJg9CRPXrc=;
        b=ol9+WG4h2ND7ErNkx+BHxqbLUUgX9a4ljiAvqepXbjw5PQgCmEMfz9sAporCH2nYgf
         EPYZNlZJD3F+T5CrAUwuE0CYkvmmX5tHCcxvj5qteGPWJY2NBMR8+pKFCmts6qBtjPc8
         O753KaoDMODgcxKNBhfrfrFfQM/+YzikRNw7PlhoPF+MmbH2LUUapMYJxS1B1GYOjJZJ
         6GcXsz0QVwQFS0QZyG9DQyZ0EjTJWcWuw+0zgU9xWZOpVZRbSXoXAvibdnh7BymBQfQC
         tWYpgLHevECjP479Rf2cSbLKNVvQc35KgFRK4nXMFdyYbDd4A+P0Ch2ktycNdd6rkPSs
         NWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677526164;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekalVOfJxHXcdcHO5GKUDX6+cAIhLbZ0sHJg9CRPXrc=;
        b=2tg5xogi4lC7dMU7LB31XPyr1wNm9AeHbL6kvKRC3nB3BzoqzcQ+Ij0pRIS0iSdplZ
         Hcql1ofF/A1JWYBRTET2BM6gHa5jt+UooOhewnwxla0yQmf4rzpqF40dCrTlfli4s8ET
         jGQBySKqgud9qC98hNgWj3Xj1kARzUbVykWS0z0F4ZKKZ/jyrv8clc53vZhAX9kGWcdC
         L1ycPXmKtMxeyn6NaMdAR6W3zgoHncCzRTsk8CP7FZbEnZfCmwDAW7IHT5pkRL2k08Np
         yrNeS7P+/+7MNPBkOCazU5wmhGnDJardbFabx43P3TP3gBAU4T8OyDCCSmKRrbezGw9n
         dc0w==
X-Gm-Message-State: AO0yUKXQ5Pyu+hLF9a6S1vUzNm5cEWflu1NzgQf99DAb7QdVJIeK/AAM
        AiwIVlBDD6Ma8kwumutHOL0=
X-Google-Smtp-Source: AK7set/DXlmxGL+MKusJz+Q7MUStTE1b7iiOaMs560KxlIdaygPyCiib9vxOeNwoyb8jbzfLgD8AIA==
X-Received: by 2002:a05:600c:3093:b0:3eb:3104:efef with SMTP id g19-20020a05600c309300b003eb3104efefmr178541wmn.31.1677526163747;
        Mon, 27 Feb 2023 11:29:23 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003dc4a47605fsm13934171wmk.8.2023.02.27.11.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:29:23 -0800 (PST)
Message-ID: <9ea9b52fca1300265ce5639a2da809813edb774f.camel@gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org,
        andrii@kernel.org, acme@redhat.com
Date:   Mon, 27 Feb 2023 21:29:21 +0200
In-Reply-To: <CAEf4BzZauF7V3pY1hgWgnJRN1F6eSkbTOTG3kM0c85uAX-vOfQ@mail.gmail.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
         <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
         <Y/czygarUnMnDF9m@google.com>
         <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
         <Y/hLsgSO3B+2g9iF@google.com>
         <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
         <Y/p0ryf5PcKIs7uj@google.com>
         <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
         <693dffd9571073a47820653fd2de863010491454.camel@gmail.com>
         <CAEf4BzYaiD27y=Y85xhrj+VOvJY_5q1oVtg-4vYmFZFEpmW+nQ@mail.gmail.com>
         <CACYkzJ7tgbJqwUVxfGd4UKDUcOQjK8zsbEKUUjV79=xHQn1fFg@mail.gmail.com>
         <CAEf4BzZauF7V3pY1hgWgnJRN1F6eSkbTOTG3kM0c85uAX-vOfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-02-27 at 11:24 -0800, Andrii Nakryiko wrote:
> On Mon, Feb 27, 2023 at 10:05 AM KP Singh <kpsingh@kernel.org> wrote:
> >=20
> > On Mon, Feb 27, 2023 at 6:32=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >=20
> > > On Mon, Feb 27, 2023 at 6:17 AM Eduard Zingerman <eddyz87@gmail.com> =
wrote:
> > > >=20
> > > > On Sun, 2023-02-26 at 03:03 +0200, Eduard Zingerman wrote:
> > > > > On Sat, 2023-02-25 at 20:50 +0000, Matt Bobrowski wrote:
> > > > > > Sorry Eduard, I replied late last night although the email boun=
ced due
> > > > > > to exceeding the mail char limit. Let's try attaching a compres=
sed
> > > > > > variant of the requested files, which includes the compiled ker=
nel's
> > > > > > BTF and the kernel's config.
> > > > >=20
> > > > > Hi Matt,
> > > > >=20
> > > > > I tried using your config but still can't reproduce the issue.
> > > > > Will try to do it using debian 12 chroot tomorrow or on Monday.
> > > >=20
> > > > Hi Matt,
> > > >=20
> > > > Short update:
> > > > I've reproduced the issue with multiple STRUCT 'linux_binprm' BTF I=
Ds
> > > > in Debian testing chroot, thank you for providing all details.
> > > > Attaching the instructions in the end of the email.
> > > > Need some time to analyze pahole behavior.
> > > >=20
> > >=20
> > > Try using [0] to pinpoint what actually is different between any two
> > > linux_binprm definitions. I've hacked up this "tool" last time I had
> > > to pinpoint where two BTF types diverge, maybe it will save you a bit
> > > of time as well. I'd like to put this functionality into btfdump
> > > ([1]), but I didn't get to it yet, unfortunately.
> > >=20
> >=20
> > It's not just linux_binprm but a bunch of other structs (quite a lot
> > of them that seem to diverge)
>=20
> yes, task_struct is usually a thing that suffers from such
> duplications, as it forms a huge graph of types. Which is where that
> btfdiff "tool" comes handly, it recursively compares side-by-side two
> types that are supposed to be equal (but are not), by ignoring BTF
> type IDs and trying to pin point actual differences (like STRUCT vs
> FWD, or extra field, or whatever). It just needs two starting type
> IDs.

Thank you for links to these tools!

>=20
> >=20
> > [...]
> > WARN: multiple IDs found for 'sock_common': 4400, 53212 - using 4400
> > WARN: multiple IDs found for 'request_sock': 4458, 53257 - using 4458
> > WARN: multiple IDs found for 'task_struct': 265, 55830 - using 265
> > WARN: multiple IDs found for 'file': 474, 55854 - using 474
> > WARN: multiple IDs found for 'vm_area_struct': 480, 55857 - using 480
> > WARN: multiple IDs found for 'seq_file': 670, 55891 - using 670
>=20
>=20
> [...]
>=20
> >=20
> > I was able to "fix" this with using clang 16.x and the following hacky =
pahole:
> >=20
> > 030e3b4 - core: Add DW_TAG_unspecified_type to tag__is_tag_type() set
> > (HEAD) (2023-02-26 Arnaldo Carvalho de Melo)
> > f20515b - dwarves: support DW_TAG_atomic_type (2023-02-26 David Lampart=
er)
> > de24234 - pahole: Prep 1.24 (tag: v1.24) (2022-08-22 Arnaldo Carvalho d=
e Melo)
> > d6c9528 - dwarf_loader: Encode char type as signed (2022-08-10 Yonghong=
 Song)
> >=20
> > and the the following patch on top:
> >=20
>=20
> I'd start with understanding what BTF and DWARF differences are
> causing the issue before trying to come up with the fix. For that we
> don't even need config or repro steps, it should be enough to share
> vmlinux with BTF and DWARF, and start from there.
>=20

Yes, I suspect that there is some kind of unanticipated
anomaly for some DWARF encoding for some kind of objects,
just need to find the root for the diverging type hierarchies.=20

> But I'm sure Eduard is on top of this already (especially that he can
> repro the issue now).

I'm working on it, nothing to report yet, but I'm working on it.

