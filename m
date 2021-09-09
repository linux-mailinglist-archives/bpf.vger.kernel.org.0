Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242FB405CC4
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 20:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhIISUq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 14:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbhIISUp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 14:20:45 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE1C061574
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 11:19:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id c206so5681724ybb.12
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=voAXMpkqYzgceffEABKiLud05a2GiklQuvm0MFdhMSg=;
        b=bVBqh/4av7gkN+bn7rnEPelQB2MdxmzIulkNRMGGc/1lGv5nmtjS79eOhRO4XaHrOE
         prVgqQ5V+UWQvBrFNOt9HHdPn9COvcvNucEHm11clCiLF0pOgNgd0NZF4ym3Di1/oMGl
         T4cNCUspdJsLoTejgsWmg5Dlc2Or/IPgY7F1z8Rm5e83yCr+YPohwqNTHqCgAVZtdtSo
         AMyOsUKk0qW49Gt6HSf+JY83wDPd2MiwBP2PwBGPsTYz8AbCAwqP8F/SvQ1ign45KgT0
         ghiWwFV8TlCtAAfPuqzRHmX3axd56RzhIeOv4mIewZv1XSmSa25FaQ89NqcHythOR0BM
         cGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=voAXMpkqYzgceffEABKiLud05a2GiklQuvm0MFdhMSg=;
        b=6luXJkbGKTl20F5JxxMjb/pSx3CEw6y1plD3mxgsRMRX3cONVw30ijuYpFHeCeVBuU
         f0iGo8KX1fwYaTjfgbihFNHmf5zwikMGrnnvubyUeVgYSchL1Mq0+R46B4fsBzVN1C+K
         VI/Td6NWxVg5cNmY2x5H95cmTX02r8qrWIzd0Ikx0SvTgi16Lfa2IrIhMBEXYyjS81Xp
         sALYh8tgzLBPFC+g1DU3O3F4z6tmSW3Ht9ij1FI2bE9DtKr8xqXcNloN+LkEQZK7Z8ys
         iqE8GzMPLFf9jYRR+76C8kAU13AAOWqo393TU55pLY1qYU/g4b2IGEiSOQFac9Z9e6D6
         12xA==
X-Gm-Message-State: AOAM532gvRWbvkCw8LExWU//z0Xv2Rz2nfNPys3Qplwxc3FaZ9GhyEgM
        EBQjxB794HkobtAddo58N71dOF+x4KOHca6xL2s=
X-Google-Smtp-Source: ABdhPJxXrTU5l1hRJhRDzSV+ReElagXNmjUx3yf7B3yNEjXV98eNFQsI1LvXsYLgBgApUeO6+3NGiEnw7q1RdItDMR4=
X-Received: by 2002:a5b:f03:: with SMTP id x3mr4295806ybr.546.1631211575049;
 Thu, 09 Sep 2021 11:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain> <87mtrfmoyh.fsf@toke.dk>
 <YOa4JVEp20JolOp4@localhost.localdomain> <8735snvjp7.fsf@toke.dk>
 <YTA7x6BIq85UWrYZ@localhost.localdomain> <190d8d21-f11d-bb83-58aa-08e86e0006d9@redhat.com>
 <YTcGUbRpvWK+633g@localhost.localdomain> <936bfbdf-e194-b676-d28a-acf526120155@redhat.com>
In-Reply-To: <936bfbdf-e194-b676-d28a-acf526120155@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Sep 2021 11:19:23 -0700
Message-ID: <CAEf4BzabVVPgRB9V=DAFjzYSx-q59bmBsQQAupKYWy5eUxqVkw@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net,
        Zaremba Larysa <larysa.zaremba@intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 8, 2021 at 6:28 AM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
> On 07/09/2021 08.27, Michal Swiatkowski wrote:
> > On Thu, Sep 02, 2021 at 11:17:43AM +0200, Jesper Dangaard Brouer wrote:
> >>
> >>
> >> On 02/09/2021 04.49, Michal Swiatkowski wrote:
> >>> On Fri, Jul 09, 2021 at 12:57:08PM +0200, Toke H=C3=B8iland-J=C3=B8rg=
ensen wrote:
> >>>> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
> >>>>
> >>>>>> I would expect that the program would decide ahead-of-time which B=
TF IDs
> >>>>>> it supports, by something like including the relevant structs from
> >>>>>> vmlinux.h. And then we need the BTF ID encoded into the packet met=
adata
> >>>>>> as well, so that it is possible to check at run-time which driver =
the
> >>>>>> packet came from (since a packet can be redirected, so you may end=
 up
> >>>>>> having to deal with multiple formats in the same XDP program).
> >>>>>>
> >>>>>> Which would allow you to write code like:
> >>>>>>
> >>>>>> if (ctx->has_driver_meta) {
> >>>>>>     /* this should be at a well-known position, like first (or las=
t) in meta area */
> >>>>>>     __u32 *meta_btf_id =3D ctx->data_meta;
> >>>>>>     if (*meta_btf_id =3D=3D BTF_ID_MLX5) {
> >>>>>>       struct meta_mlx5 *meta =3D ctx->data_meta;
> >>>>>>       /* do something with meta */
> >>>>>>     } else if (meta_btf_id =3D=3D BTF_ID_I40E) {
> >>>>>>       struct meta_i40e *meta =3D ctx->data_meta;
> >>>>>>       /* do something with meta */
> >>>>>>     } /* etc */
> >>>>>> }
> >>>>>>
> >>>>>> and libbpf could do relocations based on the different meta struct=
s,
> >>>>>> even removing the code for the ones that don't exist on the runnin=
g
> >>>>>> kernel.
> >>>>>
> >>>>> This looks nice. In this case we need defintions of struct meta_mlx=
5 and
> >>>>> struct meta_i40e at build time. How are we going to deliver this to=
 bpf
> >>>>> core app? This will be available in /sys/kernel/btf/mlx5 and
> >>>>> /sys/kernel/btf/i40e (if drivers are loaded). Should we dump this t=
o
> >>>>> vmlinux.h? Or a developer of the xdp program should add this defini=
tion
> >>>>> to his code?
> >>>>
> >>>> Well, if the driver just defines the struct, the BTF for it will be
> >>>> automatically part of the driver module BTF. BPF program developers
> >>>> would need to include this in their programs somehow (similar to how
> >>>> you'll need to get the type definitions from vmlinux.h today to use
> >>>> CO-RE); how they do this is up to them. Since this is a compile-time
> >>>> thing it will probably depend on the project (for instance, BCC incl=
udes
> >>>> a copy of vmlinux.h in their source tree, but you can also just pick=
 out
> >>>> the structs you need).
> >>>>
> >>>>> Maybe create another /sys/kernel/btf/hints with vmlinux and hints f=
rom
> >>>>> all drivers which support hints?
> >>>>
> >>>> It may be useful to have a way for the kernel to export all the hint=
s
> >>>> currently loaded, so libbpf can just use that when relocating. The
> >>>> problem of course being that this will only include drivers that are
> >>>> actually loaded, so users need to make sure to load all their networ=
k
> >>>> drivers before loading any XDP programs. I think it would be better =
if
> >>>> the loader could discover all modules *available* on the system, but=
 I'm
> >>>> not sure if there's a good way to do that.
> >>>>
> >>>>> Previously in this thread someone mentioned this ___ use case in li=
bbpf
> >>>>> and proposed creating something like mega xdp hints structure with =
all
> >>>>> available fields across all drivers. As I understand this could sol=
ve
> >>>>> the problem about defining correct structure at build time. But how=
 will
> >>>>> it work when there will be more than one structures with the same n=
ame
> >>>>> before ___? I mean:
> >>>>> struct xdp_hints___mega defined only in core app
> >>>>> struct xdp_hints___mlx5 available when mlx5 driver is loaded
> >>>>> struct xdp_hints___i40e available when i40e driver is loaded
> >>>>>
> >>>>> When there will be only one driver loaded should libbpf do correct
> >>>>> reallocation of fields? What will happen when both of the drivers a=
re
> >>>>> loaded?
> >>>>
> >>>> I think we definitely need to make this easy for developers so they
> >>>> don't have to go and manually track down the driver structs and writ=
e
> >>>> the disambiguation code etc. I.e., the example code I included above
> >>>> that checks the frame BTF ID and does the loading based on it should=
 be
> >>>> auto-generated. We already have some precedence for auto-generated c=
ode
> >>>> in vmlinux.h and the bpftool skeletons. So maybe we could have a com=
mand
> >>>> like 'bpftool gen_xdp_meta <fields>' which would go and lookup all t=
he
> >>>> available driver structs and generate a code helper function that wi=
ll
> >>>> extract the driver structs and generate the loader code? So that if,
> >>>> say, you're interested in rxhash and tstamp you could do:
> >>>>
> >>>> bpftool gen_xdp_meta rxhash tstamp > my_meta.h
> >>>>
> >>>> which would then produce my_meta.h with content like:
> >>>>
> >>>> struct my_meta { /* contains fields specified on the command line */
> >>>>     u32 rxhash;
> >>>>     u32 tstamp;
> >>>> }
> >>>>
> >>>> struct meta_mlx5 {/*generated from kernel BTF */};
> >>>> struct meta_i40e {/*generated from kernel BTF */};
> >>>>
> >>>> static inline int get_xdp_meta(struct xdp_md *ctx, struct my_meta *m=
eta)
> >>>> {
> >>>>    if (ctx->has_driver_meta) {
> >>>>      /* this should be at a well-known position, like first (or last=
) in meta area */
> >>>>      __u32 *meta_btf_id =3D ctx->data_meta;
> >>>>      if (*meta_btf_id =3D=3D BTF_ID_MLX5) {
> >>>>        struct meta_mlx5 *meta =3D ctx->data_meta;
> >>>>        my_meta->rxhash =3D meta->rxhash;
> >>>>        my_meta->tstamp =3D meta->tstamp;
> >>>>        return 0;
> >>>>      } else if (meta_btf_id =3D=3D BTF_ID_I40E) {
> >>>>        struct meta_i40e *meta =3D ctx->data_meta;
> >>>>        my_meta->rxhash =3D meta->rxhash;
> >>>>        my_meta->tstamp =3D meta->tstamp;
> >>>>        return 0;
> >>>>      } /* etc */
> >>>>    }
> >>>>    return -ENOENT;
> >>>> }
> >>>
> >>> According to meta_btf_id.
> >>
> >> In BPF-prog (that gets loaded by libbpf), the BTF_ID_MLX5 and BTF_ID_I=
40E
> >> should be replaced by bpf_core_type_id_kernel() calls.
> >>
> >> I have a code example here[1], where I use the triple-underscore to lo=
okup
> >> btf_id =3D bpf_core_type_id_kernel(struct sk_buff___local).
> >>
> >> AFAIK (Andrii correctly me if I'm wrong) It is libbpf that does the bp=
f_id
> >> lookup before loading the BPF-prog into the kernel.
> >>
> >> For AF_XDP we need to code our own similar lookup of the btf_id. (In t=
hat
> >> process I imagine that userspace tools could/would read the BTF member
> >> offsets and check it against what they expected).
> >>
> >>
> >>   [1] https://github.com/xdp-project/bpf-examples/blob/master/ktrace-C=
O-RE/ktrace01_kern.c#L34-L57
> >>
> > Thanks a lot. I tested Your CO-RE example. For defines that are located
> > in vmlinux everything works fine (like for sk_buff). When I tried to ge=
t
> > btf id of structures defined in module (loaded module, structure can be
> > find in /sys/kerne/btf/module_name) I always get 0 (not found). Do You
> > know if bpf_core_type_id_kernel() should also support modules btf?
>
> This might be caused by git-submodule libbpf being too old in
> xdp-project/bpf-examples repo.  I will investigate closer.
>
>
> I did notice my bpftool (on my devel box) were tool old, as bpftool
> could not dump info in /sys/kerne/btf/module_name
>
>    # bpftool btf dump file /sys/kernel/btf/igc format raw
>    Error: failed to load BTF from /sys/kernel/btf/igc: Unknown error -22
>
> After updating bpftool it does work.
>
> > Based on:
> > [1] https://lore.kernel.org/bpf/20201110011932.3201430-5-andrii@kernel.=
org/
> > I assume that modules btfs also are marked as in-kernel, but I can't
> > make it works with bpf_core_type_id_kernel(). My clang version is
> > 12.0.1, so changes needed by modules btf should be there
> > [2] https://reviews.llvm.org/D91489
> >
> >>> Do You have an idea how driver should fill this field?
> >>
> >> (Andrii please correctly me as this is likely wrong:)
> >> I imagine that driver will have a pointer to a 'struct btf' object and=
 the
> >> btf_id can be read via btf_obj_id() (that just return btf->id).
> >> As this also allows driver to take refcnt on the btf-object.
> >> Much like Ederson did in [2].
> >>
> >> Maybe I misunderstood the use of the 'struct btf' object ?
> >>
> >> Maybe it is the wrong approach? As the patchset[2] exports btf_obj_id(=
) and
> >> introduced helper functions that can register/unregister btf objects[3=
],
> >> which I sense might not be needed today, as modules can get their own =
BTF
> >> info automatically today.
> >> Maybe this (btf->id) is not the ID we are looking for?
> >>
> >> [2] https://lore.kernel.org/all/20210803010331.39453-11-ederson.desouz=
a@intel.com/
> >> [3]
> >> https://lore.kernel.org/all/20210803010331.39453-2-ederson.desouza@int=
el.com/
> >>
> >
> > As 'struct btf' object do You mean one module btf with all definitions
> > or specific structure btf object?
> >
> > In case of Your example [1]. If in driver side there will be call to ge=
t
> > btf id of sk_buff:
> > id =3D btf_find_by_name_kind(vmlinux_btf, "sk_buff", BTF_KIND_STRUCT);
> > this id will be the same as id from Your ktrace01 program. I think this
> > is id that we are looking for.
>
> Yes, I think this is the ID we should use.
>
> The 'struct btf' object ID is something else I suspect? Or it is also a
> valid BTF ID?
>
> I wanted to ask Andrii if the IDs are unique across vmlinux and modules?

Depending on what IDs we are talking about (sorry, I don't follow this
thread very closely, so if you are curious about some aspects of BTF
or libbpf APIs, it would be good to have a specific questions with
some context). BTF as kernel object has it's own ID allocated through
idr, so yes, they are unique. so vmlinux BTF object will have it's own
ID, while each module's BTF will have it's own.

But if we are talking about BTF type IDs, that's entirely different
thing. BTF type IDs start from 1 (0 is reserved for special 'VOID'
type) all the way to number of types in vmlinux BTF. Then each module
extends vmlinx BTF starting at N + 1 and going to N + M, where N is
number of BTF types in vmlinux BTF and M is number of added types in
module BTF.

So in that regard each module has BTF type IDs that are overlapping
with other modules, which is why for unique fetching of BTF types from
modules you also need BTF object FD or ID of a module BTF, and then
BTF type ID within that module. But as I said, I didn't follow along
closely, so not sure if I'm answering the right question, sorry.

>
> I suspect as it looks like kern uses the IDR infra[0]:
>   [0] https://www.kernel.org/doc/html/latest/core-api/idr.html
>
>
> >>> hints->btf_id =3D btf_id_by_name("struct meta_i40e"); /* fill btf id =
at
> >>> config time */
> >>
> >> Yes, at config time the btf_id can change (and maybe we want to cache =
the
> >> btf_obj_id() lookup to avoid a function call).
> >>
> >>> btf_id_by_name will get module btf (or vmlinux btf) and search for
> >>> correct name for each ids. Does this look correct?
> >>>
> >>> Is there any way in kernel to get btf id based on name or we have to
> >>> write functions for this? I haven't seen code for this case, but mayb=
e I
> >>> missed it.
> >>
> >> There is a function named: btf_find_by_name_kind()
> >>
> > Thanks, this is what I needed.
>
