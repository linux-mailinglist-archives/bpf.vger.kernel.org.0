Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4EE603959
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 07:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJSFse (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 01:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJSFsd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 01:48:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347844E1BB
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 22:48:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gf8so16097651pjb.5
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 22:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+UtnXdvUPpogEDb3ybD7Y0vci+U2Y/pnWaDPh5QRIg=;
        b=VWgwew98ZqbhkhBKE3jzC0YOND5baHjgNEuzCFFK+mgKabCuQGETN6Em6LGopk8KA1
         C5UsP1YLxB7Ne6C5n/YLui8OrQEInNral8zIiEiBV4qDxqJQPKfNVZFrYfjtR2KtcDSM
         BY9gUwbRJVmOH7jQOEYgouFp2ofDTHOW+yBuQLbazQK0HA/svNSwKiSH5PsftE7o//yi
         ZtQSn+rNLs9uQ0xbRnleAm/HBu61JIVeXA3A/yNieXM+oytlY2qNKcNuagDPBHyjeJzV
         00CaFPV0azAudunna451lI89PThNVq8duX+I1ca8OsH9QLY7MWRhT0eb9wkU4Sqzx6F7
         Jwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+UtnXdvUPpogEDb3ybD7Y0vci+U2Y/pnWaDPh5QRIg=;
        b=i3pme4JnPrJc8tYq/wBxWFudY1S9wo3XS0hZ239+S+erGmi00rKyrYv6it170K5Dfy
         lj01OVUGEow63xjF7wLV977cBdK7KEY0GVgmWBWZb/nx9+2rXc5tiH1L2rrlvsfADL5Z
         U0Bc5c71u9p9Ihs4qSkKIpU+E3y5H/XVJID8EGpATn48iMjeivGc9EUwOVWLteJkL6B+
         7OvqCCW3p8Da2hQiOmOvRdO3ouIKHBAKuNJetckc98UX29XlQ2DT/t3pyiSl57zUNSIB
         8JSvzwr6QfnAAMROhPmQ48yIrmPIkzH+5P0JDW8jhcuf8xMySNScXKUvOCaQkHMCfNru
         Spkg==
X-Gm-Message-State: ACrzQf3iQCyx37vbb85fX/54GIDi3tzaF6qVRUL3ObNuSt/pJtYJGLZO
        T/FWSEufZ/S233wjK+f7bIc=
X-Google-Smtp-Source: AMsMyM72K+td8/ejGSaUnAE4DxSN6PJDDZZFdQFoz6Je43ahw7NBg9BchGem0/IgRXImqVRJA5688Q==
X-Received: by 2002:a17:90b:1d11:b0:20d:4c69:6886 with SMTP id on17-20020a17090b1d1100b0020d4c696886mr42607227pjb.14.1666158511637;
        Tue, 18 Oct 2022 22:48:31 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id m20-20020a62a214000000b0053e93aa8fb9sm10350158pff.71.2022.10.18.22.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:48:31 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:18:12 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 09/25] bpf: Support bpf_list_head in map
 values
Message-ID: <20221019054812.vdpx6mlvke3ev3k4@apollo>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-10-memxor@gmail.com>
 <20221019015916.cyrmxrqskztsn7gf@macbook-pro-4.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019015916.cyrmxrqskztsn7gf@macbook-pro-4.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 07:29:16AM IST, Alexei Starovoitov wrote:
> On Thu, Oct 13, 2022 at 11:52:47AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Add the basic support on the map side to parse, recognize, verify, and
> > build metadata table for a new special field of the type struct
> > bpf_list_head. To parameterize the bpf_list_head for a certain value
> > type and the list_node member it will accept in that value type, we use
> > BTF declaration tags.
> >
> > The definition of bpf_list_head in a map value will be done as follows:
> >
> > struct foo {
> > 	struct bpf_list_node node;
> > 	int data;
> > };
> >
> > struct map_value {
> > 	struct bpf_list_head head __contains(foo, node);
> > };
> >
> > Then, the bpf_list_head only allows adding to the list 'head' using the
> > bpf_list_node 'node' for the type struct foo.
> >
> > The 'contains' annotation is a BTF declaration tag composed of four
> > parts, "contains:kind:name:node" where the kind and name is then used to
> > look up the type in the map BTF. The node defines name of the member in
> > this type that has the type struct bpf_list_node, which is actually used
> > for linking into the linked list. For now, 'kind' part is hardcoded as
> > struct.
>
> ...
>
> > +	value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
> > +	if (!value_type)
> > +		return -EINVAL;
> > +	if (strncmp(value_type, "struct:", sizeof("struct:") - 1))
> > +		return -EINVAL;
> > +	value_type += sizeof("struct:") - 1;
>
> I don't get it.
> The patch 24 does:
> +#define __contains(name, node) __attribute__((btf_decl_tag("contains:struct:" #name ":" #node)))
>
> The 'struct:' part is invisible to users. They won't make a mistake.
> Why bother adding it to BTF and then check for it?
> Backward compat concerns?
> But it's in bpf_experimental.h.
> That probably be the last thing to change and so easy to do.
> Please drop it?
>

Fair, I just left it there anticipating atleast union with a discriminant might
be a possible candidate, but since this is all unstable it's not a big deal.

> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> > new file mode 100644
> > index 000000000000..4e31790e433d
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -0,0 +1,23 @@
> > +#ifndef __KERNEL__
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_core_read.h>
> > +
>
> Why bother with the above?
> The below should be enough ?
>

Actually, I'm using this header inside the kernel, userspace, and BPF programs.
In the kernel to provide type definitions for bpf_list_head and bpf_list_node,
which are then emitted to vmlinux.h (and also used inside the kernel ofcourse).

In userspace for these types as otherwise including skeleton fails to build, as
such types are global variables, but there I have to define __KERNEL__ around
include.

In the BPF program, for the kfunc declarations.

I guess I can split the header into two to avoid confusion. I agree it's a bit
ugly.
