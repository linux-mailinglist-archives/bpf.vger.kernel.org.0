Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258F3605442
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 01:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJSX7r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 19:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJSX7q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 19:59:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E69A2BA
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:59:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 67so18695691pfz.12
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Df0HM7eTKLdL6z0oVOsGvvNVLMA1ZnYmehQ9+97eXOI=;
        b=UAT3OcXKGydgzY9GD9t5RcmwR8YIsLnRR/G392lN/G4+vxAB05qNU1omhjIFyweDH5
         upMUmZAKTXRllP0EQZeW0FeSrD/L/5Xc5Bemm5MLffABCijOZbXTBSi/NrvvnIDcUhYF
         cRf42ywUoo8zENPH48ZQv1KYvFTuuclVJe49A3Tlvke4o2Is17g9In+vVdG/nV99RRKq
         OzG8GRwvZZ1OyjBXpdf9ecKdPZK+InSxX1D0RWgBL5+B6RbTJAQEQoxfZftIzm7Q3c8r
         aYQ2y50f4B8tzAxrslZCRUd3lmTtvb2K7V3GftGwingUhr6jFq2JevrIBahUtKxJcl38
         l/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Df0HM7eTKLdL6z0oVOsGvvNVLMA1ZnYmehQ9+97eXOI=;
        b=JwvdXE+wu5bH7qmOLPvFNwUaJOkAH1Ty8fkAgUjHDP0Pdt9kygnNQpc+cAn42wIJOx
         xLcJmTdam8KKS2nDZt6suc5kH07AmilwDu9csMLrZwIFmP0IvmrKEyRAYpPp5gE9qhzv
         CRPlyLPIp58hPb4B0ADHetCFG77mF1FynvIjwl4Uls3U/sx+a/3GCkBWlfFVHw7erYBg
         v9wA1WWJtr6O85kzVK6eyWtPfDDHd0BswFWI3h8+i1gA4hHBT0RB6/ezA8RqZHxddhDG
         son+40Al5zBsf/mpgEXfM1Ez4uD87NWWEbX6+rKnLxvplWe1pyTPcNZwqegIyWLGGbyG
         3Nog==
X-Gm-Message-State: ACrzQf0+3SJsVSMz4usPRBkGOgmAJxUnugD0A7ap52UKKoa0VmSVPCMC
        S6o/lGI7a3+Nnl3lKaBXLpo=
X-Google-Smtp-Source: AMsMyM6N1LcKUE+WTFCCa4l0dN5RwNPJt5hzj8Eaq4btLjtg4+lNWmvwbQRwNhBhM7S3aJHL8xYz3g==
X-Received: by 2002:a05:6a00:24d1:b0:566:1ab1:43f5 with SMTP id d17-20020a056a0024d100b005661ab143f5mr10995932pfv.44.1666223984128;
        Wed, 19 Oct 2022 16:59:44 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id n190-20020a6227c7000000b00565cf8c52c8sm12314667pfn.174.2022.10.19.16.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:59:43 -0700 (PDT)
Date:   Thu, 20 Oct 2022 05:29:32 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 09/25] bpf: Support bpf_list_head in map
 values
Message-ID: <20221019235932.h7ys372t6vob2rg7@apollo>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-10-memxor@gmail.com>
 <20221019015916.cyrmxrqskztsn7gf@macbook-pro-4.dhcp.thefacebook.com>
 <20221019054812.vdpx6mlvke3ev3k4@apollo>
 <CAADnVQKB2S=Vz0AmXSTEHUJX7-qjB7DeQN3xMygu7m2hmo+tig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKB2S=Vz0AmXSTEHUJX7-qjB7DeQN3xMygu7m2hmo+tig@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 09:27:57PM IST, Alexei Starovoitov wrote:
> On Tue, Oct 18, 2022 at 10:48 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Wed, Oct 19, 2022 at 07:29:16AM IST, Alexei Starovoitov wrote:
> > > On Thu, Oct 13, 2022 at 11:52:47AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > Add the basic support on the map side to parse, recognize, verify, and
> > > > build metadata table for a new special field of the type struct
> > > > bpf_list_head. To parameterize the bpf_list_head for a certain value
> > > > type and the list_node member it will accept in that value type, we use
> > > > BTF declaration tags.
> > > >
> > > > The definition of bpf_list_head in a map value will be done as follows:
> > > >
> > > > struct foo {
> > > >     struct bpf_list_node node;
> > > >     int data;
> > > > };
> > > >
> > > > struct map_value {
> > > >     struct bpf_list_head head __contains(foo, node);
> > > > };
> > > >
> > > > Then, the bpf_list_head only allows adding to the list 'head' using the
> > > > bpf_list_node 'node' for the type struct foo.
> > > >
> > > > The 'contains' annotation is a BTF declaration tag composed of four
> > > > parts, "contains:kind:name:node" where the kind and name is then used to
> > > > look up the type in the map BTF. The node defines name of the member in
> > > > this type that has the type struct bpf_list_node, which is actually used
> > > > for linking into the linked list. For now, 'kind' part is hardcoded as
> > > > struct.
> > >
> > > ...
> > >
> > > > +   value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
> > > > +   if (!value_type)
> > > > +           return -EINVAL;
> > > > +   if (strncmp(value_type, "struct:", sizeof("struct:") - 1))
> > > > +           return -EINVAL;
> > > > +   value_type += sizeof("struct:") - 1;
> > >
> > > I don't get it.
> > > The patch 24 does:
> > > +#define __contains(name, node) __attribute__((btf_decl_tag("contains:struct:" #name ":" #node)))
> > >
> > > The 'struct:' part is invisible to users. They won't make a mistake.
> > > Why bother adding it to BTF and then check for it?
> > > Backward compat concerns?
> > > But it's in bpf_experimental.h.
> > > That probably be the last thing to change and so easy to do.
> > > Please drop it?
> > >
> >
> > Fair, I just left it there anticipating atleast union with a discriminant might
> > be a possible candidate, but since this is all unstable it's not a big deal.
> >
> > > > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> > > > new file mode 100644
> > > > index 000000000000..4e31790e433d
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > > > @@ -0,0 +1,23 @@
> > > > +#ifndef __KERNEL__
> > > > +
> > > > +#include <vmlinux.h>
> > > > +#include <bpf/bpf_tracing.h>
> > > > +#include <bpf/bpf_helpers.h>
> > > > +#include <bpf/bpf_core_read.h>
> > > > +
> > >
> > > Why bother with the above?
> > > The below should be enough ?
> > >
> >
> > Actually, I'm using this header inside the kernel, userspace, and BPF programs.
> > In the kernel to provide type definitions for bpf_list_head and bpf_list_node,
> > which are then emitted to vmlinux.h (and also used inside the kernel ofcourse).
> >
> > In userspace for these types as otherwise including skeleton fails to build, as
> > such types are global variables, but there I have to define __KERNEL__ around
> > include.
> >
> > In the BPF program, for the kfunc declarations.
> >
> > I guess I can split the header into two to avoid confusion. I agree it's a bit
> > ugly.
>
> I think we can add bpf_list_head and bpf_list_node to uapi/bpf.h
> The chances of them changing the size are pretty low.

Sounds good to me, the rest I'll keep in bpf_experimental.h.
