Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013E14D0679
	for <lists+bpf@lfdr.de>; Mon,  7 Mar 2022 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbiCGS1X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 13:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbiCGS1W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 13:27:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D88939F1;
        Mon,  7 Mar 2022 10:26:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2778B8166E;
        Mon,  7 Mar 2022 18:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722B9C340F4;
        Mon,  7 Mar 2022 18:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646677584;
        bh=tiM5Uvq+D31XhjJe7+hWNcPkNyAsCyNOhRKy5ex9OS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZKncCtRmliUj08hyHjNPIch7ZIcVa/2uoOlqtXYHfSGXXt2FIwx3UCD9FmEje7oXy
         NKqgElEOarYqHJo/nW6N5R1QgRcUSPoWXqNHFx1EAxPr04T1vw5tB8OqEQ3U0DnpyQ
         ca6Nv+e83arQ9MrGv5O/klgVXR+yLOe3uavLWbMXB5cy6bMd5wwx17GMORE6fVjnHP
         TFQI0pbgk0MmuJgtClIBhD9ww429rgSPtFcFWTRV1fsE6rF9JDXpsZNqZXX9qS5052
         Z9qjZ7dWRjXVQyRzzsbw42OEt3SYOG1gzJLH73TYaxoBOQhVLP0Oejw1v0aylcyjvA
         c0q8YOMJIEMng==
Received: by mail-yb1-f181.google.com with SMTP id l2so13269860ybe.8;
        Mon, 07 Mar 2022 10:26:24 -0800 (PST)
X-Gm-Message-State: AOAM5323Orjrce40RNfFXhW/zI0h9VWQgO7jpdr+Azl0thrKR0a5G81i
        GIOoCxGet3g0HB3znIsjbbI9RAE9uTty7ruiFuM=
X-Google-Smtp-Source: ABdhPJwC4K57hPFP1bG+dnJm59ZAitT7BxWTbMHWd5AfT32rDjPYEnJGWS/Lo+o3LgTZFmX9YJOhB9M9DD1oIYiJVSQ=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr8563794ybn.259.1646677583501; Mon, 07
 Mar 2022 10:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
 <20220304172852.274126-2-benjamin.tissoires@redhat.com> <CAPhsuW4otgwwDN6+xcjPXmZyUDiynEKFtXjaFb-=kjz7HzUmZw@mail.gmail.com>
 <CAO-hwJJjDMaTXH9i1UkO7Qy+sbNprDyW67cRp8HryMMWMi5H9w@mail.gmail.com> <YiOWmG2oARiYmRHr@gofer.mess.org>
In-Reply-To: <YiOWmG2oARiYmRHr@gofer.mess.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 7 Mar 2022 10:26:12 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5yitrNMvbx3s=K+a5JDrAj1=F=qWfwVLBPFn+w0EypJg@mail.gmail.com>
Message-ID: <CAPhsuW5yitrNMvbx3s=K+a5JDrAj1=F=qWfwVLBPFn+w0EypJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/28] bpf: add new is_sys_admin_prog_type() helper
To:     Sean Young <sean@mess.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 5, 2022 at 8:58 AM Sean Young <sean@mess.org> wrote:
>
> On Sat, Mar 05, 2022 at 11:07:04AM +0100, Benjamin Tissoires wrote:
> > On Sat, Mar 5, 2022 at 12:12 AM Song Liu <song@kernel.org> wrote:
> > >
> > > On Fri, Mar 4, 2022 at 9:30 AM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > LIRC_MODE2 does not really need net_admin capability, but only sys_admin.
> > > >
> > > > Extract a new helper for it, it will be also used for the HID bpf
> > > > implementation.
> > > >
> > > > Cc: Sean Young <sean@mess.org>
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > >
> > > > ---
> > > >
> > > > new in v2
> > > > ---
> > > >  kernel/bpf/syscall.c | 14 +++++++++++++-
> > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > index db402ebc5570..cc570891322b 100644
> > > > --- a/kernel/bpf/syscall.c
> > > > +++ b/kernel/bpf/syscall.c
> > > > @@ -2165,7 +2165,6 @@ static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
> > > >         case BPF_PROG_TYPE_LWT_SEG6LOCAL:
> > > >         case BPF_PROG_TYPE_SK_SKB:
> > > >         case BPF_PROG_TYPE_SK_MSG:
> > > > -       case BPF_PROG_TYPE_LIRC_MODE2:
> > > >         case BPF_PROG_TYPE_FLOW_DISSECTOR:
> > > >         case BPF_PROG_TYPE_CGROUP_DEVICE:
> > > >         case BPF_PROG_TYPE_CGROUP_SOCK:
> > > > @@ -2202,6 +2201,17 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
> > > >         }
> > > >  }
> > > >
> > > > +static bool is_sys_admin_prog_type(enum bpf_prog_type prog_type)
> > > > +{
> > > > +       switch (prog_type) {
> > > > +       case BPF_PROG_TYPE_LIRC_MODE2:
> > > > +       case BPF_PROG_TYPE_EXT: /* extends any prog */
> > > > +               return true;
> > > > +       default:
> > > > +               return false;
> > > > +       }
> > > > +}
> > >
> > > I am not sure whether we should do this. This is a behavior change, that may
> > > break some user space. Also, BPF_PROG_TYPE_EXT is checked in
> > > is_perfmon_prog_type(), and this change will make that case useless.
> >
> > Sure, I can drop it from v3 and make this function appear for HID only.
>
> For BPF_PROG_TYPE_LIRC_MODE2, I don't think this change will break userspace.
> This is called from ir-keytable(1) which is called from udev. It should have
> all the necessary permissions.
>
> In addition, the vast majority IR decoders are non-bpf. bpf ir decoders have
> very few users at the moment.
>
> I am working on completely new userspace tooling which will make extensive
> use of bpf ir decoding with full lircd and IRP compatibility, but this is not
> finished yet (see https://github.com/seanyoung/cir).

Thanks for these information. I guess change for BPF_PROG_TYPE_LIRC_MODE2
is ok then. Would you mind ack or review this change (either current version or
a later version)?

Thanks,
Song
