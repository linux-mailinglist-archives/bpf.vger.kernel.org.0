Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94936615284
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 20:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiKATpN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKATpM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 15:45:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD2B12770
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 12:45:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kt23so39677182ejc.7
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qMOfY/Q7aPt0Mx8H1IgyBcZ5GVgiMq3b06S3LKuua+4=;
        b=qt08mi02EkvPK0CKNUtT3gDYzzZFUswYvSSsehFtQcIATNTo7tDmmO6IfNVLumlpha
         vOgdsTekzVFuWkfx5UeuLCb7PU5QTPcVVjcQ4y7nmnbb8DxVwa70mGaGhVL4M1sP4jp4
         c1N2ttLRnYkAWolFPeY0O2wRS0CrcfV9kW2ozK4bFrL2lAy+CHOLTjoR1zBtiLfSHReV
         IPMCM6nvM5WcfxupLSqrWqBqUSb6puLdL2NyyfSrXLAfoBpko2gu80jNi1o4g5wIG0tY
         3Y2uUeP9JLVqAGIwwd6gBY49Ht0E12sv/slz1a0f4xCOVObEI4gtuOT1t2siRdwAmvJh
         OUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMOfY/Q7aPt0Mx8H1IgyBcZ5GVgiMq3b06S3LKuua+4=;
        b=Bn/4AJ0EF/huU7+H5+uxlQlz5G6xxvetLw0eAC5Y78qfJ5cNASlcx12X5vxw+ZYUGj
         xM0S8wf0RE4dzqdOdJHGWOK4sbKgGllac+q47L7bWc802w8fDdHFGa7kyz3aQjjeDXs2
         5CpKgzVZWwU0AS6clFiKG20pXD1EdAn+8k1eSamehSrISEqRd6ru32sgxAgNtmb5ifUQ
         Q6a4UvPsJwCSqLK/vZx63BU2MQ+8NDitpC2xtRUz4fyreZBmFIdu1RkQfuLj9Q6V7zdz
         TrcBna/tMJvI6IjTVBgaCOw2qL47K+mmv/4Lvl7k0VStqHvIvBZLu3af83iugcd8gjaB
         twIg==
X-Gm-Message-State: ACrzQf3T0B4tPv0qLioJnqUSnhiXHh/+29TMCL6z/6NQ7sOSIUR1qIF7
        w39yx71wlHMYruYC/Wbeb8898zto9Wq4unmEOYE=
X-Google-Smtp-Source: AMsMyM7WM7a5gZCLjtUbGBNeNwDVBrjd5j1j1n/ULO5abBoZK5si0eLunylNP8OyLeE4V8D2NzMa9ZE3lRDkww4thO0=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr20064239ejb.633.1667331909628; Tue, 01
 Nov 2022 12:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221025222802.2295103-1-eddyz87@gmail.com> <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
 <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com> <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
 <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com> <CAEf4BzZE7boex4KBjMmhJ4Nib6BA71-pf5jiAg74FjEdr_2e6A@mail.gmail.com>
 <ea841d91-a43f-a6e0-e8ce-90f9b2d3f77c@oracle.com> <CAADnVQ+Oe-euDp7dFEOntzdy9uYmGqapVM0YNdRDNerCN-8OQQ@mail.gmail.com>
 <a1f1cce3ad89c7ff9857cea643763f44d5047186.camel@gmail.com>
In-Reply-To: <a1f1cce3ad89c7ff9857cea643763f44d5047186.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Nov 2022 12:44:58 -0700
Message-ID: <CAADnVQKjYcTPJnSjidPq5Tp-Yoj_p=_+g2Gq_MoKPCmymVzftA@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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

On Tue, Nov 1, 2022 at 12:21 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2022-11-01 at 11:35 -0700, Alexei Starovoitov wrote:
> > On Tue, Nov 1, 2022 at 9:02 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > > > Yes, we discussed this before. This will need to add additional work
> > > > > in preprocessor. I just made a discussion topic in llvm discourse
> > > > >
> > > > > https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-defined-type/66268
> >
> > That would be a great clang feature.
> > Thanks Yonghong!
> >
> > > > >
> > > > > Let us see whether we can get some upstream agreement or not.
> > > > >
> > > >
> > > > Thanks for starting the conversation! I'll be following along.
> > > >
> > >
> > >
> > > I think this sort of approach assumes that vmlinux.h is included after
> > > any uapi headers, and would guard type definitions with
> > >
> > > #if type_is_defined(foo)
> > > struct foo {
> > >
> > > };
> > > #endif
> > >
> > > ...is that right? My concern is that the vmlinux.h definitions have
> > > the CO-RE attributes. From a BPF perspective, would we like the vmlinux.h
> > > definitions to dominate over UAPI definitions do you think, or does it
> > > matter?
> >
> > I think it's totally fine to require #include "vmlinux.h" to be last.
> > The attr(preserve_access_index) is only useful for kernel internal
> > structs. uapi structs don't need it.
> >
> > >
> > > I was wondering if there might be yet another way to crack this;
> > > if we did want the vmlinux.h type definitions to be authoritative
> > > because they have the preserve access index attribute, and because
> > > bpftool knows all vmlinux types, it could use that info to selectively
> > > redefine those type names such that we avoid name clashes when later
> > > including UAPI headers. Something like
> > >
> > > #ifdef __VMLINUX_H__
> > > //usual vmlinux.h type definitions
> > > #endif /* __VMLINUX_H__ */
> > >
> > > #ifdef __VMLINUX_ALIAS__
> > > if !defined(timespec64)
> > > #define timespec64 __VMLINUX_ALIAS__timespec64
> > > #endif
> > > // rest of the types define aliases here
> > > #undef __VMLINUX_ALIAS__
> > > #else /* unalias */
> > > #if defined(timespec64)
> > > #undef timespec64
> > > #endif
> > > // rest of types undef aliases here
> > > #endif /* __VMLINUX_ALIAS__ */
> > >
> > >
> > > Then the consumer does this:
> > >
> > > #define __VMLINUX_ALIAS__
> > > #include "vmlinux.h"
> > > // include uapi headers
> > > #include "vmlinux.h"
> > >
> > > (the latter include of vmlinux.h is needed to undef all the type aliases)
> >
> > Sounds like a bunch of complexity for the use case that is not
> > clear to me.
>
> Well, my RFC is not shy of complexity :)
> What Alan suggests should solve the confilicts described in [1] or any
> other confilicts of such kind.
>
> [1] https://lore.kernel.org/bpf/999da51bdf050f155ba299500061b3eb6e0dcd0d.camel@gmail.com/

I don't quite see how renaming all types in the 1st vmlinux.h
will help with name collisions inside enum {}.
The enums will conflict with 2nd vmlinux.h too.
Unless the proposal is to rename them as well,
but then what's the point?
