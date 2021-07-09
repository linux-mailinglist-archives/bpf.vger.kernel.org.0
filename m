Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C071F3C2281
	for <lists+bpf@lfdr.de>; Fri,  9 Jul 2021 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhGIK76 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Jul 2021 06:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229641AbhGIK75 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 9 Jul 2021 06:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625828233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b71dsvuhM/MuSpSEdi3HWQCFWv1P+zj4aFXLcIGVUF8=;
        b=KFwYoPjZynMw7hAHZf32EJwS2Zs9Pj6PO1NlJqKvnUoYrb4hO0KYmC1pAmcaQ/WEmLKDKp
        r2SYlmFx7zjLLEbvgsg7RHT/IujqgUrW1QVzlDQSwxAFLGTVBbDv21TtNF/FNBvD0OFMSZ
        nmTmlSoKguWru+6Qiv8wek3Uy0zFd/g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-DZHSWWbhN7OTgzv-QtS6Iw-1; Fri, 09 Jul 2021 06:57:12 -0400
X-MC-Unique: DZHSWWbhN7OTgzv-QtS6Iw-1
Received: by mail-ed1-f72.google.com with SMTP id ee46-20020a056402292eb02903a1187e547cso2320767edb.0
        for <bpf@vger.kernel.org>; Fri, 09 Jul 2021 03:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=b71dsvuhM/MuSpSEdi3HWQCFWv1P+zj4aFXLcIGVUF8=;
        b=du6fgaZQ/moMmTVkFwEfD6PX9/+/2mexmx0WN/KnWOEfh01KvNTzbndK+c98pPXekS
         m0aaixJ95kgFo3H/CMObE6lLD1wWPTi5BnwBCBWoyKR5B1Dr7a+s+4cVWX3ZlKidxiM3
         D0w295PEEmhAFtpuKPyNv7OBvDkP8vN2M/9u9/Ui+FmRtD56+yTbAlcDy0wqFKKlqr4E
         c5AyWcpcNeOAHrGtw47Dk0KXHkNgeaN8DUtDHJXo4HIpmyu8GCVernL7/ooSoNvyY5rF
         t4WpY59RjC1AUEaTtdYpDnnrXSg2PR6mKglG3VfDZLVMR1RoP4sAXZ8nYNG//OnZflyG
         KKRQ==
X-Gm-Message-State: AOAM532QNcn0XLtXQbahZ8zCz3uMwn5VH4101WLgFFT1oMGfVdFhPINY
        JDtXDx1uFArxN3woV1TYmgdobeE6Q9q0rDXUhAttFhg1SaQC6MZcZ/sYTzZYOtflC00gzb8tD4x
        eDNOKz+hZXFKr
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr45471124edc.312.1625828231187;
        Fri, 09 Jul 2021 03:57:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcEgzt9SmaoJQBSMRg9i/ruS++CGfVRuSpQBsbjW43pdyCjJyZ7uJA/mr0TlmnGQqyl/k7ow==
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr45471075edc.312.1625828230805;
        Fri, 09 Jul 2021 03:57:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id gh15sm2210649ejb.46.2021.07.09.03.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 03:57:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 83D12180733; Fri,  9 Jul 2021 12:57:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
In-Reply-To: <YOa4JVEp20JolOp4@localhost.localdomain>
References: <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon>
 <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk>
 <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain> <87mtrfmoyh.fsf@toke.dk>
 <YOa4JVEp20JolOp4@localhost.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 09 Jul 2021 12:57:08 +0200
Message-ID: <8735snvjp7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:

>> I would expect that the program would decide ahead-of-time which BTF IDs
>> it supports, by something like including the relevant structs from
>> vmlinux.h. And then we need the BTF ID encoded into the packet metadata
>> as well, so that it is possible to check at run-time which driver the
>> packet came from (since a packet can be redirected, so you may end up
>> having to deal with multiple formats in the same XDP program).
>> 
>> Which would allow you to write code like:
>> 
>> if (ctx->has_driver_meta) {
>>   /* this should be at a well-known position, like first (or last) in meta area */
>>   __u32 *meta_btf_id = ctx->data_meta;
>>   
>>   if (*meta_btf_id == BTF_ID_MLX5) {
>>     struct meta_mlx5 *meta = ctx->data_meta;
>>     /* do something with meta */
>>   } else if (meta_btf_id == BTF_ID_I40E) {
>>     struct meta_i40e *meta = ctx->data_meta;
>>     /* do something with meta */
>>   } /* etc */
>> }
>> 
>> and libbpf could do relocations based on the different meta structs,
>> even removing the code for the ones that don't exist on the running
>> kernel.
>
> This looks nice. In this case we need defintions of struct meta_mlx5 and
> struct meta_i40e at build time. How are we going to deliver this to bpf
> core app? This will be available in /sys/kernel/btf/mlx5 and
> /sys/kernel/btf/i40e (if drivers are loaded). Should we dump this to
> vmlinux.h? Or a developer of the xdp program should add this definition
> to his code?

Well, if the driver just defines the struct, the BTF for it will be
automatically part of the driver module BTF. BPF program developers
would need to include this in their programs somehow (similar to how
you'll need to get the type definitions from vmlinux.h today to use
CO-RE); how they do this is up to them. Since this is a compile-time
thing it will probably depend on the project (for instance, BCC includes
a copy of vmlinux.h in their source tree, but you can also just pick out
the structs you need).

> Maybe create another /sys/kernel/btf/hints with vmlinux and hints from
> all drivers which support hints?

It may be useful to have a way for the kernel to export all the hints
currently loaded, so libbpf can just use that when relocating. The
problem of course being that this will only include drivers that are
actually loaded, so users need to make sure to load all their network
drivers before loading any XDP programs. I think it would be better if
the loader could discover all modules *available* on the system, but I'm
not sure if there's a good way to do that.

> Previously in this thread someone mentioned this ___ use case in libbpf
> and proposed creating something like mega xdp hints structure with all
> available fields across all drivers. As I understand this could solve
> the problem about defining correct structure at build time. But how will
> it work when there will be more than one structures with the same name
> before ___? I mean:
> struct xdp_hints___mega defined only in core app
> struct xdp_hints___mlx5 available when mlx5 driver is loaded
> struct xdp_hints___i40e available when i40e driver is loaded
>
> When there will be only one driver loaded should libbpf do correct
> reallocation of fields? What will happen when both of the drivers are
> loaded?

I think we definitely need to make this easy for developers so they
don't have to go and manually track down the driver structs and write
the disambiguation code etc. I.e., the example code I included above
that checks the frame BTF ID and does the loading based on it should be
auto-generated. We already have some precedence for auto-generated code
in vmlinux.h and the bpftool skeletons. So maybe we could have a command
like 'bpftool gen_xdp_meta <fields>' which would go and lookup all the
available driver structs and generate a code helper function that will
extract the driver structs and generate the loader code? So that if,
say, you're interested in rxhash and tstamp you could do:

bpftool gen_xdp_meta rxhash tstamp > my_meta.h

which would then produce my_meta.h with content like:

struct my_meta { /* contains fields specified on the command line */
  u32 rxhash;
  u32 tstamp;
}

struct meta_mlx5 {/*generated from kernel BTF */};
struct meta_i40e {/*generated from kernel BTF */};

static inline int get_xdp_meta(struct xdp_md *ctx, struct my_meta *meta)
{
 if (ctx->has_driver_meta) {
   /* this should be at a well-known position, like first (or last) in meta area */
   __u32 *meta_btf_id = ctx->data_meta;
   
   if (*meta_btf_id == BTF_ID_MLX5) {
     struct meta_mlx5 *meta = ctx->data_meta;
     my_meta->rxhash = meta->rxhash;
     my_meta->tstamp = meta->tstamp;
     return 0;
   } else if (meta_btf_id == BTF_ID_I40E) {
     struct meta_i40e *meta = ctx->data_meta;
     my_meta->rxhash = meta->rxhash;
     my_meta->tstamp = meta->tstamp;
     return 0;
   } /* etc */
 }
 return -ENOENT;
}


-Toke

