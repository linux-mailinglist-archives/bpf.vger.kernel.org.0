Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A76D0E2C
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 20:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjC3S4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3S4X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 14:56:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B642586B4
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:56:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y4so80474319edo.2
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680202580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOfvj8Mz1wkWN99sOxXSwdmwF7BYjm0xeAOcjduip58=;
        b=Qf/PnVmRcu1Dj0pf4gQHTE2yhIKTGkxJ6GVC8PiOPBuXC/odHrEbghPMnbRa1Wh/tm
         PyjU4VhS8/kVseUR1PdlfGNyrLwTZ0GbjQZogzcmQuPEQviy/4pGAYicINms5I8PDMMP
         f7p+DpnNjPed+Jy5eRBZJNKn+ar2tWbxP7ZvUaAGCl7BdyWRujWvLozeG9t9nmquGW08
         WT8HOTSmkC6sFuyrXDDCGwUQsosXAPxaoIO/cyDnFC5/jp+ZQZofLoIp0Cy0c+1T3+iz
         n7BR9GZIUzrNtxda+p2RAgt6jdwqYGbv01FB4MasshLD8d7IhJheAqb5/rSxnwNv0xR8
         wTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680202580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOfvj8Mz1wkWN99sOxXSwdmwF7BYjm0xeAOcjduip58=;
        b=rJC1HxlZEZPJacysEQgyIubs28Zpbp765dDzhA1ipaGs5RLRKA1phQ4uic6Nc68bDZ
         2wS3VDuRoS132Qbc30WKliwFVU5PY7+rQjSNTFqPKv0FB1OCymNhwnvvcNTqso+l0dh/
         QG2LOi43NOGZDNCeLDAjVMo72Hz/s4CrL2Ibyu5Mm0LbYyQVrosTiFIFbDor3AQ3+fOa
         172N4xXdQkRRPt/WI2P6QRWGdmScDYnOcULT4b0nd7K/eWj4pyPtBJaDblkwFECu+z06
         iQ354rsUoHio8WYWcwARs9bFifkxR2t6iZsMngffQPYjKOwikN7k/EIe414gVjqj7z6i
         ndnQ==
X-Gm-Message-State: AAQBX9c6NnF2WgYGjOWqO2R1JiIsjGetkGwUXSaNqWbljU0iEqYGyVWE
        zlox7m2AdF/cojFxXeNMeaXYLDQEMRR74EW+VrY=
X-Google-Smtp-Source: AKy350bdUupYhENFbEu9UESyOMhQvHxsFfvz7EFP9LHzHGqSriwPWtRWL48cq8egRarTjRNzY8IVA2ZZoMTLuddT0R0=
X-Received: by 2002:a50:cdda:0:b0:4fb:dc5e:6501 with SMTP id
 h26-20020a50cdda000000b004fbdc5e6501mr11942454edj.1.1680202580003; Thu, 30
 Mar 2023 11:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230327185202.1929145-1-andrii@kernel.org> <20230327185202.1929145-4-andrii@kernel.org>
 <09709d267f92856f5fd5293bd81bbe1ada4b41bc.camel@gmail.com>
 <CAADnVQ+hSFfkcJ=Ni_4UnW5sx93GdBMKSGcT1RujWkaonZN-OQ@mail.gmail.com> <b4b8406f9a08283308d4c3d597db158319801aff.camel@gmail.com>
In-Reply-To: <b4b8406f9a08283308d4c3d597db158319801aff.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 30 Mar 2023 11:56:07 -0700
Message-ID: <CAEf4BzZ0YAFicGa-efv+J8cTzGwN_jrGOC0_HTa3KgjaR761vg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] veristat: guess and substitue underlying
 program type for freplace (EXT) progs
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 30, 2023 at 7:49=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-03-29 at 22:38 -0700, Alexei Starovoitov wrote:
> > On Wed, Mar 29, 2023 at 11:36=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Mon, 2023-03-27 at 11:52 -0700, Andrii Nakryiko wrote:
> > > > SEC("freplace") (i.e., BPF_PROG_TYPE_EXT) programs are not loadable=
 as
> > > > is through veristat, as kernel expects actual program's FD during
> > > > BPF_PROG_LOAD time, which veristat has no way of knowing.
> > > >
> > > > Unfortunately, freplace programs are a pretty important class of
> > > > programs, especially when dealing with XDP chaining solutions, whic=
h
> > > > rely on EXT programs.
> > > >
> > > > So let's do our best and teach veristat to try to guess the origina=
l
> > > > program type, based on program's context argument type. And if gues=
sing
> > > > process succeeds, we manually override freplace/EXT with guessed pr=
ogram
> > > > type using bpf_program__set_type() setter to increase chances of pr=
oper
> > > > BPF verification.
> > > >
> > > > We rely on BTF and maintain a simple lookup table. This process is
> > > > obviously not 100% bulletproof, as valid program might not use cont=
ext
> > > > and thus wouldn't have to specify correct type. Also, __sk_buff is =
very
> > > > ambiguous and is the context type across many different program typ=
es.
> > > > We pick BPF_PROG_TYPE_CGROUP_SKB for now, which seems to work fine =
in
> > > > practice so far. Similarly, some program types require specifying a=
ttach
> > > > type, and so we pick one out of possible few variants.
> > > >
> > > > Best effort at its best. But this makes veristat even more widely
> > > > applicable.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > I left one nitpick below, otherwise looks good.
> > >
> > > I tried in on freplace programs from selftests and only 3 out 18
> > > programs verified correctly, others complained about unavailable
> > > functions or exit code not in range [0, 1], etc.
> > > Not sure, if it's possible to select more permissive attachment kinds=
, though.
> > >
> > > Tested-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > Thanks for testing and important feedback.
> > I've applied the set. The nits can be addressed in the follow up.
> >
> > What do you have in mind as 'more permissive attach' ?
> > What are those 15 out of 18 with invalid exit code?
> > What kind of attach_type will help?
>
> TLDR: I apologize, it was a bad comment.
>       Should have done more analysis yesterday and withheld from commenti=
ng.
>
> ---
>
> Inspected each program and it turned out that most of the failing ones
> are either not programs but separate functions, or have __skb_buf paramet=
er.
> The summary table is at the end of the email, here is the list of those
> that should load but fail:
>
> - Have __skb_buf parameter and attach to SEC("tc")
>   - fexit_bpf2bpf.bpf.o:new_get_skb_len
>   - freplace_cls_redirect.bpf.o:freplace_cls_redirect_test
>   - freplace_global_func.bpf.o:new_test_pkt_access
> - Need ifindex to be specified prior loading:
>   - xdp_metadata2.bpf.o:freplace_rx

Thanks for compiling the table! I went through it and left comments.
skbuff programs do work now, but xdp_metadata2 is harder case, I don't
think it will work, as it requires driver support.

>                                                                          =
   Should
> File                            Program                            Verdic=
t  fail?   Reason
> ------------------------------  ---------------------------------  ------=
-  ------  -----------------------
> fexit_bpf2bpf.bpf.o             new_get_constant                   failur=
e      no  Function, not a program

not much that can be done here, it's just `long` argument...

> fexit_bpf2bpf.bpf.o             new_get_skb_ifindex                failur=
e      no  Function, not a program

Yeah, this heuristic of substituting the original program type won't
work when subprog uses more than one argument and/or if the first
argument is not the context type argument, unfortunately.


> fexit_bpf2bpf.bpf.o             new_get_skb_len                    failur=
e      no  __sk_buff parameter

Right.. I'll set SCHED_CLS as a better guess for __sk_buff. It doesn't
seem to regress anything for Meta-specific programs I tried it
on.cI'll switch it over, unless others have opinions about SCHED_CLS
vs CGROUP_SKB. I'm not well versed in all the __sk_buff-using program
type differences, unfortunately.

This one now works with SCHED_CLS now.


> fexit_bpf2bpf.bpf.o             new_test_pkt_write_access_subprog  failur=
e      no  Function, not a program

yep, subprog, can't work

> fexit_bpf2bpf.bpf.o             test_main                          failur=
e      no  Function, not a program
> fexit_bpf2bpf.bpf.o             test_subprog1                      failur=
e      no  Function, not a program
> fexit_bpf2bpf.bpf.o             test_subprog2                      failur=
e      no  Function, not a program
> fexit_bpf2bpf.bpf.o             test_subprog3                      failur=
e      no  Function, not a program

These are actually fexit programs. Currently they are assumed to be
fexit of kernel function. These programs are using BPF_PROG() macro,
they really have a u64[] context type. Maybe there is something to be
done here to improve the situation, but I'm not yet planning to look
into this.


> freplace_attach_probe.bpf.o     new_handle_kprobe                  failur=
e     yes

guessing kprobe correctly, yep

> freplace_cls_redirect.bpf.o     freplace_cls_redirect_test         failur=
e      no  __sk_buff parameter

Now succeeds with SCHED_CLS.

> freplace_connect4.bpf.o         new_do_bind                        failur=
e     yes
> freplace_connect_v4_prog.bpf.o  new_connect_v4_prog                failur=
e     yes

yep, guessed correctly CGROUP_SOCK_ADDR, but designed to fail

> freplace_get_constant.bpf.o     security_new_get_constant          failur=
e      no  Function, not a program

same as new_get_constant, I don't think we can do better

> freplace_global_func.bpf.o      new_test_pkt_access                failur=
e      no  __sk_buff parameter

Now works.

> freplace_progmap.bpf.o          xdp_cpumap_prog                    succes=
s
> freplace_progmap.bpf.o          xdp_drop_prog                      succes=
s
> test_trace_ext.bpf.o            test_pkt_md_access_new             succes=
s

Cool, handled.

> xdp_metadata2.bpf.o             freplace_rx                        failur=
e      no  needs ifindex

this is a new fancy bpf_dev_bound_kfunc_check() stuff, I don't think
it can be easily solved (I tried substituting IFINDEX_LO and that
didn't work, of course).

> ------------------------------  ---------------------------------  ------=
-  ------- -----------------------
