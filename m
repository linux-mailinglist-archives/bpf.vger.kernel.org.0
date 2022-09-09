Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32FE5B2BD0
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 03:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIIBtb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 21:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIIBta (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 21:49:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E219F1203E7
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 18:49:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so3986301pjp.2
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 18:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GXCFwHHCJRMCdU1brLJcEePCzJmV3QviHzY4dH4qh6U=;
        b=Sq+QMTMh0K04aIMYokEWYKNRuRcRptRMYvkpnKDrAsRZ+mM1jcuvRd0OS3a5YQ7zud
         1nCxrjccRdrWW7CXaqUaIkRpmxN/iFxZ35rb7IiBeJ5mfOIXkH7B+2Ux6dt7L8zjv9F0
         t6/hNkOr/657a3d4pKtijiUtbiCCcCsGA+HOOgKysinT+Jx2GsCB1zxxCOssG2G2ZEm6
         VwGF/Gr6ED8oKeKKBeb+qlETLDE+L3nftm+wdliKPo5nyNjC09vlX9teRngfXyHPX+zi
         iq3uXCMyEjKS25IzN8B0wSiz10vX9R8XIiuDSy+yadnBbYY/2AnuboBQKwKZvVIgCn/E
         Uzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GXCFwHHCJRMCdU1brLJcEePCzJmV3QviHzY4dH4qh6U=;
        b=a2n3R6Tgkh8AEMjCJrfi1DAd+ZVFAWvJSbvz50Ng5ST++2Ch/6BnUsCTMGzWZKtRys
         3bvNM2bb4WzNwpJ3yjqdGfM4oTCZ4rGfeG0WeQ/u0coDIRFr7WVAvIzRMKFdA2DFRrPP
         DN4qOUd+W+zQ07ikllX2o6Tr92j2nu2ZQ3bU8DC5BSsgTpdc6k9saC1vYOykUIHtavo+
         UvHhJAxu9Srd7RgDZ82ee9FnqlxhUJKi37sAfTAAuYyY5XLycDaWz1t6aN9r+/SyEtGh
         +9/3nSCA7+SKGS+Y3uaFsffu/lRVzhB0+DJJRStY0e9x8bJVfhG/2g4h4HTm99747IQ3
         Wqug==
X-Gm-Message-State: ACgBeo0mwDu9GniqiqL6ku5Bal9N1rzP9OO6z4bfoZCfEsSlMQQNXiRx
        9lNe5FnBYtUBxnv3ie4ugXODvBSbzSAnzCxSnoBi+6KPvHw5bA==
X-Google-Smtp-Source: AA6agR7/sA4n8qyZ54JMrjLg8im0CAvXPynNtm6e1SY1+UUhREUDmJxmKTi/tzp46ptCl/BZKXNi2p2ZgsowlqWyVqw=
X-Received: by 2002:a17:902:7783:b0:173:11e6:a580 with SMTP id
 o3-20020a170902778300b0017311e6a580mr11603016pll.10.1662688159292; Thu, 08
 Sep 2022 18:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220908183952.3438815-1-mj@hunetr.com> <YxpmmepVMXXcaNfh@google.com>
In-Reply-To: <YxpmmepVMXXcaNfh@google.com>
From:   Marcelo Juchem <juchem@gmail.com>
Date:   Thu, 8 Sep 2022 20:48:42 -0500
Message-ID: <CAK0nC2VpY-ag_OJr+mF=WGGAxUEwE6bDeB5mMmMJoSVp4i4iAQ@mail.gmail.com>
Subject: Re: [PATCH] bpftool: output map/prog indices on `gen skeleton`
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, Marcelo Juchem <mj@hunetr.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm not sure I can run all definite tests to know whether the program
is loadable or not. I wouldn't even know what the tests should be in
all cases.
On the other hand, it's very practical for me to attempt attaching
certain functions in order, until one of them works.
Besides, that's not necessarily the only library functionality that
could be built on top of this extra introspective power.

This is just one usage example, of course, but I'll try to illustrate
what one possible application would look like:

```
size_t attach_with_fallback(bpf_object_skeleton *skeleton,
std::initializer_list<size_t> probes) {
  for (size_t i: probes) {
    bpf_link *link = bpf_program__attach(*skeleton->progs[i].prog);
    if (!libbpf_get_error(link)) {
      return i;
    }
  }
  return skeleton->prog_cnt;
}

// ...

CHECK_ATTACHED(
  attach_with_fallback(
    obj->skeleton,
    {
      my_ebpf::prog_index::on_prepare_task_switch,
      my_ebpf::prog_index::on_prepare_task_switch_isra_0,
      my_ebpf::prog_index::on_finish_task_switch,
      my_ebpf::prog_index::on_finish_task_switch_isra_0
    }
  )
);
CHECK_ATTACHED(
  attach_with_fallback(
    obj->skeleton,
    {
      my_ebpf::prog_index::on_tcp_recvmsg,
      my_ebpf::prog_index::on_tcp_recvmsg_pre_5_19
    }
  )
);
```

-mj

On Thu, Sep 8, 2022 at 5:03 PM <sdf@google.com> wrote:
>
> On 09/08, Marcelo Juchem wrote:
> > The skeleton generated by `bpftool` makes it easy to attach and load bpf
> > objects as a whole. Some BPF programs are not directly portable across
> > kernel
> > versions, though, and require some cherry-picking on which programs to
> > load/attach. The skeleton makes this cherry-picking possible, but not
> > entirely
> > friendly in some cases.
>
> > For example, an useful feature is `attach_with_fallback` so that one
> > program can be attempted, and fallback programs tried subsequently until
> > one works (think `tcp_recvmsg` interface changing on kernel 5.19).
>
> > Being able to represent a set of probes programatically in a way that is
> > both
> > descriptive, compile-time validated, runtime efficient and custom library
> > friendly is quite desirable for application developers. A very simple way
> > to
> > represent a set of probes is with an array of indices.
>
> > This patch creates a couple of enums under the `__cplusplus` section to
> > represent the program and map indices inside the skeleton object, that
> > can be
> > used to refer to the proper program/map object.
>
> > This is the code generated for the `__cplusplus` section of
> > `profiler.skel.h`:
> > ```
> >    enum map_idxs: size_t {
> >      events = 0,
> >      fentry_readings = 1,
> >      accum_readings = 2,
> >      counts = 3,
> >      rodata = 4
> >    };
> >    enum prog_idxs: size_t {
> >      fentry_XXX = 0,
> >      fexit_XXX = 1
> >    };
> >    static inline struct profiler_bpf *open(const struct
> > bpf_object_open_opts *opts = nullptr);
> >    static inline struct profiler_bpf *open_and_load();
> >    static inline int load(struct profiler_bpf *skel);
> >    static inline int attach(struct profiler_bpf *skel);
> >    static inline void detach(struct profiler_bpf *skel);
> >    static inline void destroy(struct profiler_bpf *skel);
> >    static inline const void *elf_bytes(size_t *sz);
> > ```
> > ---
> >   src/gen.c | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
>
> > diff --git a/src/gen.c b/src/gen.c
> > index 7070dcf..7e28dc7 100644
> > --- a/src/gen.c
> > +++ b/src/gen.c
> > @@ -1086,6 +1086,38 @@ static int do_skeleton(int argc, char **argv)
> >               \n\
> >                                                                           \n\
> >               #ifdef __cplusplus                                          \n\
> > +             "
> > +     );
> > +
>
> [..]
>
> > +     {
> > +             size_t i = 0;
> > +             printf("\tenum map_index: size_t {");
> > +             bpf_object__for_each_map(map, obj) {
> > +                     if (!get_map_ident(map, ident, sizeof(ident)))
> > +                             continue;
> > +                     if (i) {
> > +                             printf(",");
> > +                     }
> > +                     printf("\n\t\t%s = %lu", ident, i);
> > +                     ++i;
> > +             }
> > +             printf("\n\t};\n");
> > +     }
> > +     {
> > +             size_t i = 0;
> > +             printf("\tenum prog_index: size_t {");
> > +             bpf_object__for_each_program(prog, obj) {
> > +                     if (i) {
> > +                             printf(",");
> > +                     }
> > +                     printf("\n\t\t%s = %lu", bpf_program__name(prog), i);
> > +                     ++i;
> > +             }
> > +             printf("\n\t};\n");
> > +     }
>
> I might be missing something, but what prevents you from calling these
> on the skeleton's bpf_object?
>
>    skel = xxx__open();
>
>    bpf_object__for_each_map(map, skel->obj) {
>      // do whatever you want here to test whether it's loadable or not
>    }
>
>    // same for bpf_object__for_each_program
>
>    xxx__load(skel);
>
> How do these new enums help?
