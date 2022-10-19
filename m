Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8694604C84
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJSP7a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiJSP7K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 11:59:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754ADA031D
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 08:58:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r17so40995742eja.7
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EDcNMzNzWACvXWCfxbRKijg/TTyaLS+Mi3rV+QmaZAc=;
        b=lSHqhD9nFYXbAJjCXDUHmWM+yAMDchEGCC/TpIcW8BDJvWhjKpbSTXer5LB9+tKwJc
         ljTPlkLuUKnKW5SE4pk3ekQYWv0smV3/cVoLNPKftAdEsTY8VuIwPOo7aQY42oJq8tzw
         UBGuWmD0Xs+FViw2Z9gpc6/k0pJJ4aKuiwhAw0DBIkfxwRIYgAqmCOZlXK0/zHvFjKWR
         8Wt05O7JCtdqZ9SK/NM+ib9f0zHwcIr90lR+PNPj/rMITa5q/qbl/4C88qhuMTS/V8x4
         E+ElSBKZJ5WUqsWrOb/JYTfMlp5BxytLajGmWVmLQ5D/yacR1PDLTCQpypEGlg5z/zFj
         +9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDcNMzNzWACvXWCfxbRKijg/TTyaLS+Mi3rV+QmaZAc=;
        b=XEk8cQxQH7EgknGptr8Rx/FdPf6K0dy7YQNeaSJTIbAN49zMvDYqCOFEGGnAkH+KhW
         QDMm97F0c0dMV6CjIMdOwmxIly6pth+qIzwgN/E92mf/CTnETgvNJIq4uElxlmz6n8Ka
         h4rK2in6zCDCsNByR77yQkBEGjVjz7WeiCG8WlHhFdS4fs0levFd4v/QyYxd7plxxLgB
         CyIY8kVYaSrSJ5vWBKsLq6DnpUuqYFJreVRdeWXV6gvALvQZUtCaVbaKT8InNm4LIs8I
         ttXlp+i8jtYUYLIT9herJZSwOsjXyHmL2fiVnBprNvD3mEXGsXVBEscmojAss28ppnnk
         2rqw==
X-Gm-Message-State: ACrzQf0kyMYbuYj9Yq497FIkRa84xs7ZAnwUXUFcelE3iUxEN1A948iy
        B6NsBoUsPwFWSbY7v+olNTTHw0BShaFdULVf7h4=
X-Google-Smtp-Source: AMsMyM6KNait79a6d/IENoBYXoDcoQ5Dv4jPyvZlWEZKs+p9b8a1vdDzZttdX9PSUXsbT9Y7GmtWYPymn0uDgym8+cE=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr7459556ejb.633.1666195088530; Wed, 19
 Oct 2022 08:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221013062303.896469-1-memxor@gmail.com> <20221013062303.896469-10-memxor@gmail.com>
 <20221019015916.cyrmxrqskztsn7gf@macbook-pro-4.dhcp.thefacebook.com> <20221019054812.vdpx6mlvke3ev3k4@apollo>
In-Reply-To: <20221019054812.vdpx6mlvke3ev3k4@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Oct 2022 08:57:57 -0700
Message-ID: <CAADnVQKB2S=Vz0AmXSTEHUJX7-qjB7DeQN3xMygu7m2hmo+tig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/25] bpf: Support bpf_list_head in map values
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 10:48 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, Oct 19, 2022 at 07:29:16AM IST, Alexei Starovoitov wrote:
> > On Thu, Oct 13, 2022 at 11:52:47AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > Add the basic support on the map side to parse, recognize, verify, and
> > > build metadata table for a new special field of the type struct
> > > bpf_list_head. To parameterize the bpf_list_head for a certain value
> > > type and the list_node member it will accept in that value type, we use
> > > BTF declaration tags.
> > >
> > > The definition of bpf_list_head in a map value will be done as follows:
> > >
> > > struct foo {
> > >     struct bpf_list_node node;
> > >     int data;
> > > };
> > >
> > > struct map_value {
> > >     struct bpf_list_head head __contains(foo, node);
> > > };
> > >
> > > Then, the bpf_list_head only allows adding to the list 'head' using the
> > > bpf_list_node 'node' for the type struct foo.
> > >
> > > The 'contains' annotation is a BTF declaration tag composed of four
> > > parts, "contains:kind:name:node" where the kind and name is then used to
> > > look up the type in the map BTF. The node defines name of the member in
> > > this type that has the type struct bpf_list_node, which is actually used
> > > for linking into the linked list. For now, 'kind' part is hardcoded as
> > > struct.
> >
> > ...
> >
> > > +   value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
> > > +   if (!value_type)
> > > +           return -EINVAL;
> > > +   if (strncmp(value_type, "struct:", sizeof("struct:") - 1))
> > > +           return -EINVAL;
> > > +   value_type += sizeof("struct:") - 1;
> >
> > I don't get it.
> > The patch 24 does:
> > +#define __contains(name, node) __attribute__((btf_decl_tag("contains:struct:" #name ":" #node)))
> >
> > The 'struct:' part is invisible to users. They won't make a mistake.
> > Why bother adding it to BTF and then check for it?
> > Backward compat concerns?
> > But it's in bpf_experimental.h.
> > That probably be the last thing to change and so easy to do.
> > Please drop it?
> >
>
> Fair, I just left it there anticipating atleast union with a discriminant might
> be a possible candidate, but since this is all unstable it's not a big deal.
>
> > > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> > > new file mode 100644
> > > index 000000000000..4e31790e433d
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > > @@ -0,0 +1,23 @@
> > > +#ifndef __KERNEL__
> > > +
> > > +#include <vmlinux.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_core_read.h>
> > > +
> >
> > Why bother with the above?
> > The below should be enough ?
> >
>
> Actually, I'm using this header inside the kernel, userspace, and BPF programs.
> In the kernel to provide type definitions for bpf_list_head and bpf_list_node,
> which are then emitted to vmlinux.h (and also used inside the kernel ofcourse).
>
> In userspace for these types as otherwise including skeleton fails to build, as
> such types are global variables, but there I have to define __KERNEL__ around
> include.
>
> In the BPF program, for the kfunc declarations.
>
> I guess I can split the header into two to avoid confusion. I agree it's a bit
> ugly.

I think we can add bpf_list_head and bpf_list_node to uapi/bpf.h
The chances of them changing the size are pretty low.
