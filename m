Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2B1619BDD
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 16:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiKDPju (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 11:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiKDPjt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 11:39:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075AF31DE9
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 08:39:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so14274231eja.6
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7LgYurN7VD2CzC5a2zyT5/knojv+7ACyX8w4NIjJdyA=;
        b=HkOVIbAjNn3fQ99NNYoSLHw5WDO0W0CQGoMsIdMOs2YRxcfu5fVvmFgceF2ThbjrYT
         gZDgOS7Pv/jUjm8TSAKqjmUuUyhQQcWtZECUcFsH0vipLGhBfDw7Eb1Lj3jNuLRXcCTv
         Vu2in/TnfhXq7PRhK52io5L9AdNmQ2PQKa8yze+gr/efTBXHv7cQXvXsMeQgGBueZHI6
         NWnVfFzqxZjwCN3ZBgiI8LC70/eGZTYbaC9mptnvc/6FPr8iW7uEK8HSvMgoPPWtqO58
         o8kdCl/d94OyalhpcS06WGHpMY/fbBM+mlKw75nlGlA19BjbpQmk3dxlZDf56hNRbhqB
         RvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LgYurN7VD2CzC5a2zyT5/knojv+7ACyX8w4NIjJdyA=;
        b=loePTBJrgggG959vgUDM0bWm7uTnQTOeYBa8hAaXXVs5muvPKPOLci8lBfC+RF8mgW
         CqVNtiRUzP8YC5jjWX9uY2dOG+D+TxEaEcKUJW2PXoEmx0ar+zCjkB4FqSF85ZRL+eVY
         IAOt+1Epw53A+jA6r6jjPn+69m9xkGBgnmaAxYLjLGIABDpklL7kvZJc90+7kXK/0AUm
         P1q5g3COjhv4UvS0BVeJAGTj/GSTet5ciD4dVHksqZdD9nAnNiXttgTkSoN+rcll6Mu/
         /x3OqMSXAoGZBG2C1gWzVAqdd/jHY1+/Rm4QlKRsFjga7CDWmkqhhusJtPbWLXy5ym8n
         pPiA==
X-Gm-Message-State: ACrzQf1GmBMWdkFiBxb38FW8mD+qrN7KPmNl+oSWgN+I5k+OS+vCR3Qo
        6usqN5xErLGMSgvL9scHtAXCZp6+2sTpdkSn3mI=
X-Google-Smtp-Source: AMsMyM6hKnFWvBBLNpX8klzOePuUyfGo8ZaycXgDAhIhvqhz2RcULkVtXjxPjOHhsARRxHmSMVphOBvfWRx1cb1g9Lw=
X-Received: by 2002:a17:906:1f48:b0:7ae:77d:bac with SMTP id
 d8-20020a1709061f4800b007ae077d0bacmr13907601ejk.708.1667576387391; Fri, 04
 Nov 2022 08:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221103191013.1236066-1-memxor@gmail.com> <20221103191013.1236066-20-memxor@gmail.com>
 <ba1a01b3-8028-fdbb-910b-19612e22bf5f@meta.com> <20221104080943.fud4grm5tzp6tl3h@apollo>
In-Reply-To: <20221104080943.fud4grm5tzp6tl3h@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 4 Nov 2022 08:39:36 -0700
Message-ID: <CAADnVQ+T467LJafoc5ehDg-4PPepqiGfkEcpZFfTyv4X2JidWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 19/24] bpf: Introduce bpf_obj_new
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@meta.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
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

On Fri, Nov 4, 2022 at 1:09 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Fri, Nov 04, 2022 at 08:07:25AM IST, Dave Marchevsky wrote:
> > On 11/3/22 3:10 PM, Kumar Kartikeya Dwivedi wrote:
> > > Introduce type safe memory allocator bpf_obj_new for BPF programs. The
> > > kernel side kfunc is named bpf_obj_new_impl, as passing hidden arguments
> > > to kfuncs still requires having them in prototype, unlike BPF helpers
> > > which always take 5 arguments and have them checked using bpf_func_proto
> > > in verifier, ignoring unset argument types.
> > >
> > > Introduce __ign suffix to ignore a specific kfunc argument during type
> > > checks, then use this to introduce support for passing type metadata to
> > > the bpf_obj_new_impl kfunc.
> > >
> > > The user passes BTF ID of the type it wants to allocates in program BTF,
> > > the verifier then rewrites the first argument as the size of this type,
> > > after performing some sanity checks (to ensure it exists and it is a
> > > struct type).
> > >
> > > The second argument is also fixed up and passed by the verifier. This is
> > > the btf_struct_meta for the type being allocated. It would be needed
> > > mostly for the offset array which is required for zero initializing
> > > special fields while leaving the rest of storage in unitialized state.
> > >
> > > It would also be needed in the next patch to perform proper destruction
> > > of the object's special fields.
> > >
> > > A convenience macro is included in the bpf_experimental.h header to hide
> > > over the ugly details of the implementation, leading to user code
> > > looking similar to a language level extension which allocates and
> > > constructs fields of a user type.
> > >
> > > struct bar {
> > >     struct bpf_list_node node;
> > > };
> > >
> > > struct foo {
> > >     struct bpf_spin_lock lock;
> > >     struct bpf_list_head head __contains(bar, node);
> > > };
> > >
> > > void prog(void) {
> > >     struct foo *f;
> > >
> > >     f = bpf_obj_new(typeof(*f));
> > >     if (!f)
> > >             return;
> > >     ...
> > > }
> > >
> > > A key piece of this story is still missing, i.e. the free function,
> > > which will come in the next patch.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> >
> > [...]
> >
> > > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> > > new file mode 100644
> > > index 000000000000..1d3451084a68
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> >
> > Maybe bpf_experimental.h should go in libbpf as part of this series? If
> > including vmlinux.h is an issue - nothing in libbpf currently includes it - you
> > could rely on the BPF program including it, with a comment similar to "Note
> > that bpf programs need to include..." in lib/bpf/bpf_helpers.h .
> >
>
> I don't have a problem with that, but I would like to also know Andrii's opinion
> on this, since it won't work properly if people don't keep libbpf and kernel
> version in sync.

let's do the directory bikeshedding later.
bpf_experimental.h can be moved to libbpf dir in the follow up.
