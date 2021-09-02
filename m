Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE1B3FE965
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 08:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhIBGot (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 02:44:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:3053 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233285AbhIBGot (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 02:44:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="199220761"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="199220761"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 23:43:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="688875241"
Received: from unknown (HELO localhost.localdomain) ([10.102.102.63])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 23:43:48 -0700
Date:   Wed, 1 Sep 2021 22:49:43 -0400
From:   Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net,
        Zaremba Larysa <larysa.zaremba@intel.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Message-ID: <YTA7x6BIq85UWrYZ@localhost.localdomain>
References: <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk>
 <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain>
 <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain>
 <87mtrfmoyh.fsf@toke.dk>
 <YOa4JVEp20JolOp4@localhost.localdomain>
 <8735snvjp7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735snvjp7.fsf@toke.dk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 09, 2021 at 12:57:08PM +0200, Toke Høiland-Jørgensen wrote:
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
> 
> >> I would expect that the program would decide ahead-of-time which BTF IDs
> >> it supports, by something like including the relevant structs from
> >> vmlinux.h. And then we need the BTF ID encoded into the packet metadata
> >> as well, so that it is possible to check at run-time which driver the
> >> packet came from (since a packet can be redirected, so you may end up
> >> having to deal with multiple formats in the same XDP program).
> >> 
> >> Which would allow you to write code like:
> >> 
> >> if (ctx->has_driver_meta) {
> >>   /* this should be at a well-known position, like first (or last) in meta area */
> >>   __u32 *meta_btf_id = ctx->data_meta;
> >>   
> >>   if (*meta_btf_id == BTF_ID_MLX5) {
> >>     struct meta_mlx5 *meta = ctx->data_meta;
> >>     /* do something with meta */
> >>   } else if (meta_btf_id == BTF_ID_I40E) {
> >>     struct meta_i40e *meta = ctx->data_meta;
> >>     /* do something with meta */
> >>   } /* etc */
> >> }
> >> 
> >> and libbpf could do relocations based on the different meta structs,
> >> even removing the code for the ones that don't exist on the running
> >> kernel.
> >
> > This looks nice. In this case we need defintions of struct meta_mlx5 and
> > struct meta_i40e at build time. How are we going to deliver this to bpf
> > core app? This will be available in /sys/kernel/btf/mlx5 and
> > /sys/kernel/btf/i40e (if drivers are loaded). Should we dump this to
> > vmlinux.h? Or a developer of the xdp program should add this definition
> > to his code?
> 
> Well, if the driver just defines the struct, the BTF for it will be
> automatically part of the driver module BTF. BPF program developers
> would need to include this in their programs somehow (similar to how
> you'll need to get the type definitions from vmlinux.h today to use
> CO-RE); how they do this is up to them. Since this is a compile-time
> thing it will probably depend on the project (for instance, BCC includes
> a copy of vmlinux.h in their source tree, but you can also just pick out
> the structs you need).
> 
> > Maybe create another /sys/kernel/btf/hints with vmlinux and hints from
> > all drivers which support hints?
> 
> It may be useful to have a way for the kernel to export all the hints
> currently loaded, so libbpf can just use that when relocating. The
> problem of course being that this will only include drivers that are
> actually loaded, so users need to make sure to load all their network
> drivers before loading any XDP programs. I think it would be better if
> the loader could discover all modules *available* on the system, but I'm
> not sure if there's a good way to do that.
> 
> > Previously in this thread someone mentioned this ___ use case in libbpf
> > and proposed creating something like mega xdp hints structure with all
> > available fields across all drivers. As I understand this could solve
> > the problem about defining correct structure at build time. But how will
> > it work when there will be more than one structures with the same name
> > before ___? I mean:
> > struct xdp_hints___mega defined only in core app
> > struct xdp_hints___mlx5 available when mlx5 driver is loaded
> > struct xdp_hints___i40e available when i40e driver is loaded
> >
> > When there will be only one driver loaded should libbpf do correct
> > reallocation of fields? What will happen when both of the drivers are
> > loaded?
> 
> I think we definitely need to make this easy for developers so they
> don't have to go and manually track down the driver structs and write
> the disambiguation code etc. I.e., the example code I included above
> that checks the frame BTF ID and does the loading based on it should be
> auto-generated. We already have some precedence for auto-generated code
> in vmlinux.h and the bpftool skeletons. So maybe we could have a command
> like 'bpftool gen_xdp_meta <fields>' which would go and lookup all the
> available driver structs and generate a code helper function that will
> extract the driver structs and generate the loader code? So that if,
> say, you're interested in rxhash and tstamp you could do:
> 
> bpftool gen_xdp_meta rxhash tstamp > my_meta.h
> 
> which would then produce my_meta.h with content like:
> 
> struct my_meta { /* contains fields specified on the command line */
>   u32 rxhash;
>   u32 tstamp;
> }
> 
> struct meta_mlx5 {/*generated from kernel BTF */};
> struct meta_i40e {/*generated from kernel BTF */};
> 
> static inline int get_xdp_meta(struct xdp_md *ctx, struct my_meta *meta)
> {
>  if (ctx->has_driver_meta) {
>    /* this should be at a well-known position, like first (or last) in meta area */
>    __u32 *meta_btf_id = ctx->data_meta;
>    
>    if (*meta_btf_id == BTF_ID_MLX5) {
>      struct meta_mlx5 *meta = ctx->data_meta;
>      my_meta->rxhash = meta->rxhash;
>      my_meta->tstamp = meta->tstamp;
>      return 0;
>    } else if (meta_btf_id == BTF_ID_I40E) {
>      struct meta_i40e *meta = ctx->data_meta;
>      my_meta->rxhash = meta->rxhash;
>      my_meta->tstamp = meta->tstamp;
>      return 0;
>    } /* etc */
>  }
>  return -ENOENT;
> }

According to meta_btf_id. Do You have an idea how driver should fill this
field? 
hints->btf_id = btf_id_by_name("struct meta_i40e"); /* fill btf id at
config time */
btf_id_by_name will get module btf (or vmlinux btf) and search for
correct name for each ids. Does this look correct?

Is there any way in kernel to get btf id based on name or we have to
write functions for this? I haven't seen code for this case, but maybe I
missed it.

> 
> 
> -Toke
> 
