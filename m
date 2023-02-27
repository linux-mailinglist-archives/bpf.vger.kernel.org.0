Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816116A4AE0
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 20:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjB0Tbb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 14:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjB0Tba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 14:31:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77241EBD7
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:31:28 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ck15so30557086edb.0
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ewe9tflL8sm8EjimkKWcigOXrrd/3vK0UFgPClT/zY=;
        b=qZdQ9AEzRsLkmdm/DJm6NTBQ8xxZl7eQbCW9sIKCPENVSPYAXGZiSldfzpND9BQgGD
         Yz7kCPug9aYOKg5lv4LpoyGd2fsGlWLAWguXqKauEyjvX6AiCrMRQpHQjHF0br/rHaNM
         Fk38Ud6q7nFoLhWhrRD0VsgPAEXBd4O3rzmKimt6PpRwpEwqj+1ghQFlGWmiGA6Aus05
         Lca8Ygb99GVpamcfDtctynmrhmDPp/YFvG98k/ec60WEPEE1D8XyudTFlfHCPiWKSXRx
         lEhswi+A5HkAaB7Bj0JS+JnBqSG6HMpiRLRMnIY4FPysnzPgdkIt0JkKTStAuEi0S12L
         EhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ewe9tflL8sm8EjimkKWcigOXrrd/3vK0UFgPClT/zY=;
        b=WvnqmDydGO67w+t8Z8WeIvKUc7N8BX0zoD3WsXMlQ7FbROQgkx/FBvBwF9K/eBTOZE
         jFlBmjHAmctfGV8CLag9jKhNkezKbY/scn1OxL5LI6zqr5snJpMXricVmHW0yJtP4ddN
         wH+bXPwJ0ukypL8SErGhb5f5TY5Nh4Ww/UYin7aWHthJd8MWnROzlGA63UI7/WkP6ddL
         5Vdh8JcLVeYKdlhTA2e6z6PlTwpfIjAexwtU03BeSwJTEBlGrs7D3G11D9+oy0J1j0nq
         Qkn4DAzZXT/cNK0OnKSz67b97ZJF/KcHq3kNeMHsHoMExUzYtOOhTW+etbTyW+g48s67
         qpLg==
X-Gm-Message-State: AO0yUKXT2K8nk5jf5EsmE171McUw0JJIs9LeagF4KWIj4kpUFHtcCrcC
        Wwx9wg7iEAcfEytgbbgPuZHrLTLzjFWVviLf65E=
X-Google-Smtp-Source: AK7set8P+d8RtroXkREIjnffhK94K+QbDQcOd70Nas8wN4I+3HyOtoVp0nZhmMHVwqb12XxRNgxg2euolcWfAoqFBuQ=
X-Received: by 2002:a05:6402:2811:b0:4ac:ce81:9c1d with SMTP id
 h17-20020a056402281100b004acce819c1dmr546737ede.0.1677526287293; Mon, 27 Feb
 2023 11:31:27 -0800 (PST)
MIME-Version: 1.0
References: <Y/P1yxAuV6Wj3A0K@google.com> <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
 <Y/czygarUnMnDF9m@google.com> <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
 <Y/hLsgSO3B+2g9iF@google.com> <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
 <Y/p0ryf5PcKIs7uj@google.com> <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
 <693dffd9571073a47820653fd2de863010491454.camel@gmail.com>
 <CAEf4BzYaiD27y=Y85xhrj+VOvJY_5q1oVtg-4vYmFZFEpmW+nQ@mail.gmail.com>
 <CACYkzJ7tgbJqwUVxfGd4UKDUcOQjK8zsbEKUUjV79=xHQn1fFg@mail.gmail.com>
 <CAEf4BzZauF7V3pY1hgWgnJRN1F6eSkbTOTG3kM0c85uAX-vOfQ@mail.gmail.com> <9ea9b52fca1300265ce5639a2da809813edb774f.camel@gmail.com>
In-Reply-To: <9ea9b52fca1300265ce5639a2da809813edb774f.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 11:31:14 -0800
Message-ID: <CAEf4BzYO+Rgcfbr+QzJ-8BdQg-x-mC6c4bOhA+Z4cvu_1ObX+g@mail.gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>,
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

On Mon, Feb 27, 2023 at 11:29 AM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
>
> On Mon, 2023-02-27 at 11:24 -0800, Andrii Nakryiko wrote:
> > On Mon, Feb 27, 2023 at 10:05 AM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > On Mon, Feb 27, 2023 at 6:32=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 27, 2023 at 6:17 AM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
> > > > >
> > > > > On Sun, 2023-02-26 at 03:03 +0200, Eduard Zingerman wrote:
> > > > > > On Sat, 2023-02-25 at 20:50 +0000, Matt Bobrowski wrote:
> > > > > > > Sorry Eduard, I replied late last night although the email bo=
unced due
> > > > > > > to exceeding the mail char limit. Let's try attaching a compr=
essed
> > > > > > > variant of the requested files, which includes the compiled k=
ernel's
> > > > > > > BTF and the kernel's config.
> > > > > >
> > > > > > Hi Matt,
> > > > > >
> > > > > > I tried using your config but still can't reproduce the issue.
> > > > > > Will try to do it using debian 12 chroot tomorrow or on Monday.
> > > > >
> > > > > Hi Matt,
> > > > >
> > > > > Short update:
> > > > > I've reproduced the issue with multiple STRUCT 'linux_binprm' BTF=
 IDs
> > > > > in Debian testing chroot, thank you for providing all details.
> > > > > Attaching the instructions in the end of the email.
> > > > > Need some time to analyze pahole behavior.
> > > > >
> > > >
> > > > Try using [0] to pinpoint what actually is different between any tw=
o
> > > > linux_binprm definitions. I've hacked up this "tool" last time I ha=
d
> > > > to pinpoint where two BTF types diverge, maybe it will save you a b=
it
> > > > of time as well. I'd like to put this functionality into btfdump
> > > > ([1]), but I didn't get to it yet, unfortunately.
> > > >
> > >
> > > It's not just linux_binprm but a bunch of other structs (quite a lot
> > > of them that seem to diverge)
> >
> > yes, task_struct is usually a thing that suffers from such
> > duplications, as it forms a huge graph of types. Which is where that
> > btfdiff "tool" comes handly, it recursively compares side-by-side two
> > types that are supposed to be equal (but are not), by ignoring BTF
> > type IDs and trying to pin point actual differences (like STRUCT vs
> > FWD, or extra field, or whatever). It just needs two starting type
> > IDs.
>
> Thank you for links to these tools!
>
> >
> > >
> > > [...]
> > > WARN: multiple IDs found for 'sock_common': 4400, 53212 - using 4400
> > > WARN: multiple IDs found for 'request_sock': 4458, 53257 - using 4458
> > > WARN: multiple IDs found for 'task_struct': 265, 55830 - using 265
> > > WARN: multiple IDs found for 'file': 474, 55854 - using 474
> > > WARN: multiple IDs found for 'vm_area_struct': 480, 55857 - using 480
> > > WARN: multiple IDs found for 'seq_file': 670, 55891 - using 670
> >
> >
> > [...]
> >
> > >
> > > I was able to "fix" this with using clang 16.x and the following hack=
y pahole:
> > >
> > > 030e3b4 - core: Add DW_TAG_unspecified_type to tag__is_tag_type() set
> > > (HEAD) (2023-02-26 Arnaldo Carvalho de Melo)
> > > f20515b - dwarves: support DW_TAG_atomic_type (2023-02-26 David Lampa=
rter)
> > > de24234 - pahole: Prep 1.24 (tag: v1.24) (2022-08-22 Arnaldo Carvalho=
 de Melo)
> > > d6c9528 - dwarf_loader: Encode char type as signed (2022-08-10 Yongho=
ng Song)
> > >
> > > and the the following patch on top:
> > >
> >
> > I'd start with understanding what BTF and DWARF differences are
> > causing the issue before trying to come up with the fix. For that we
> > don't even need config or repro steps, it should be enough to share
> > vmlinux with BTF and DWARF, and start from there.
> >
>
> Yes, I suspect that there is some kind of unanticipated
> anomaly for some DWARF encoding for some kind of objects,
> just need to find the root for the diverging type hierarchies.
>
> > But I'm sure Eduard is on top of this already (especially that he can
> > repro the issue now).
>
> I'm working on it, nothing to report yet, but I'm working on it.
>

Thanks, please keep us posted!
