Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB65B2C31
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 04:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIICj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 22:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIICjZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 22:39:25 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE525F4D
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 19:39:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z8-20020a17090a014800b001fac4204c7eso141344pje.8
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 19:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=inPxHq+KrnKfQqIZCe/BUAIsJdUyw8tOtqkD6eaZDTg=;
        b=MnvK9srsnjCsTUZhls5Ng24hc4C5ybks0WFlpFbbt2A85bZ5Cq1TtGZGwbIWGP1//C
         oaFvPZZk+InyUaQIxz47xRzzEOc7wHsMFbVp8SliJ4sbDXvfEdanUGTzIQgxEeq3CreA
         zgw/BA9RBQGe2akiF9oAzBxfH0sGgYyoYQ/HLdcNXdkxHGJTBNwFpwpHAmN9PozK/Oze
         QG+kiw5clPoV3oEyLY24UkOSRXiOXphoMgbuwStIRLfZxkPhQrXxhfN7noZbS/ujmh19
         XK2QxszT+L+jSkjVsHXNN/O8ZgTujkj+jGYTcIPelXNvYnjFVBIEtxLryaZ1zXhHLVCb
         nZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=inPxHq+KrnKfQqIZCe/BUAIsJdUyw8tOtqkD6eaZDTg=;
        b=TITHloEiladYTGFhDSNH1pathKoOHAWOaUEiT0R3j9ElWslduM7MLV0jyDczzad+ew
         nVc4FL+fmN5YMzr9M+nIErxMJsg+Yj8LOg/Spr9QlYzA08HDvNtRWb4JePMtQBE1D2oD
         qvEsdzd1ClZg2RYAeVOYI4j7o/wlHsN2SKTgljynXzN+owMDr0iLb8s+xaAX7ThgZ4mq
         2/G2tSGoYP0sSSXXcllAtV4zsQCFWZi3uIXrY9Ks47IKS4L0ZAYfFdqr4WFDD+g+Q2Mj
         d9tVhSdFqw699paYiu6pEOCqaIRPzGSi720rd9zXEJdLIbc+w6C7Geu2d7ZZS+T+fZWP
         4Rtg==
X-Gm-Message-State: ACgBeo0u56yDFZnG9ZgxD1/1N0IeXECtO+R7S7ZZt5U9+0n8DrlelX9r
        gzlrc6xJ7NVVv2Ne0JOlQu69WQc=
X-Google-Smtp-Source: AA6agR71u6EqQz9KXLG5t48VaXYxo/6jo5yDgHmaGGylZT6qedzcEy3jo8V0Muekv2UndSzqeQCeRwc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:1d81:b0:200:52da:7b5c with SMTP id
 pf1-20020a17090b1d8100b0020052da7b5cmr7306080pjb.228.1662691163370; Thu, 08
 Sep 2022 19:39:23 -0700 (PDT)
Date:   Thu, 8 Sep 2022 19:39:22 -0700
In-Reply-To: <CAK0nC2VpY-ag_OJr+mF=WGGAxUEwE6bDeB5mMmMJoSVp4i4iAQ@mail.gmail.com>
Mime-Version: 1.0
References: <20220908183952.3438815-1-mj@hunetr.com> <YxpmmepVMXXcaNfh@google.com>
 <CAK0nC2VpY-ag_OJr+mF=WGGAxUEwE6bDeB5mMmMJoSVp4i4iAQ@mail.gmail.com>
Message-ID: <YxqnWuH8LRBDlFRV@google.com>
Subject: Re: [PATCH] bpftool: output map/prog indices on `gen skeleton`
From:   sdf@google.com
To:     Marcelo Juchem <juchem@gmail.com>
Cc:     bpf@vger.kernel.org, Marcelo Juchem <mj@hunetr.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/08, Marcelo Juchem wrote:
> I'm not sure I can run all definite tests to know whether the program
> is loadable or not. I wouldn't even know what the tests should be in
> all cases.
> On the other hand, it's very practical for me to attempt attaching
> certain functions in order, until one of them works.
> Besides, that's not necessarily the only library functionality that
> could be built on top of this extra introspective power.

> This is just one usage example, of course, but I'll try to illustrate
> what one possible application would look like:

> ```
> size_t attach_with_fallback(bpf_object_skeleton *skeleton,
> std::initializer_list<size_t> probes) {
>    for (size_t i: probes) {
>      bpf_link *link = bpf_program__attach(*skeleton->progs[i].prog);
>      if (!libbpf_get_error(link)) {
>        return i;
>      }
>    }
>    return skeleton->prog_cnt;
> }

> // ...

> CHECK_ATTACHED(
>    attach_with_fallback(
>      obj->skeleton,
>      {
>        my_ebpf::prog_index::on_prepare_task_switch,
>        my_ebpf::prog_index::on_prepare_task_switch_isra_0,
>        my_ebpf::prog_index::on_finish_task_switch,
>        my_ebpf::prog_index::on_finish_task_switch_isra_0
>      }
>    )
> );
> CHECK_ATTACHED(
>    attach_with_fallback(
>      obj->skeleton,
>      {
>        my_ebpf::prog_index::on_tcp_recvmsg,
>        my_ebpf::prog_index::on_tcp_recvmsg_pre_5_19
>      }
>    )
> );
> ```


Thanks for the explanation, but I think I'm still confused :-)
You mention 'attach' and that the kernel will not let you attach,
but isn't 'attach' too late? Kernel should not let you load the program if  
the
function signature doesn't match, so you need to have a load_with_fallback?

But regardless, you should be able to achieve it without any new code it
seems:

bool attach_with_fallback(std::initializer_list<struct bpf_program *>  
progs) {
   for (auto p i: progs) {
     bpf_link *link = bpf_program__attach(p);
     if (!libbpf_get_error(link)) {
       return false;
     }
   }
   return true;
}

CHECK_ATTACHED(
   attach_with_fallback(
     obj->skeleton,
     {
        
bpf_object__find_program_by_name(obj->skeleton->obj, "on_tcp_recvmsg"),
        
bpf_object__find_program_by_name(obj->skeleton->obj, "on_tcp_recvmsg_5_19"),
     }
   )

Would something like this work for you?



> -mj

> On Thu, Sep 8, 2022 at 5:03 PM <sdf@google.com> wrote:
> >
> > On 09/08, Marcelo Juchem wrote:
> > > The skeleton generated by `bpftool` makes it easy to attach and load  
> bpf
> > > objects as a whole. Some BPF programs are not directly portable across
> > > kernel
> > > versions, though, and require some cherry-picking on which programs to
> > > load/attach. The skeleton makes this cherry-picking possible, but not
> > > entirely
> > > friendly in some cases.
> >
> > > For example, an useful feature is `attach_with_fallback` so that one
> > > program can be attempted, and fallback programs tried subsequently  
> until
> > > one works (think `tcp_recvmsg` interface changing on kernel 5.19).
> >
> > > Being able to represent a set of probes programatically in a way that  
> is
> > > both
> > > descriptive, compile-time validated, runtime efficient and custom  
> library
> > > friendly is quite desirable for application developers. A very simple  
> way
> > > to
> > > represent a set of probes is with an array of indices.
> >
> > > This patch creates a couple of enums under the `__cplusplus` section  
> to
> > > represent the program and map indices inside the skeleton object, that
> > > can be
> > > used to refer to the proper program/map object.
> >
> > > This is the code generated for the `__cplusplus` section of
> > > `profiler.skel.h`:
> > > ```
> > >    enum map_idxs: size_t {
> > >      events = 0,
> > >      fentry_readings = 1,
> > >      accum_readings = 2,
> > >      counts = 3,
> > >      rodata = 4
> > >    };
> > >    enum prog_idxs: size_t {
> > >      fentry_XXX = 0,
> > >      fexit_XXX = 1
> > >    };
> > >    static inline struct profiler_bpf *open(const struct
> > > bpf_object_open_opts *opts = nullptr);
> > >    static inline struct profiler_bpf *open_and_load();
> > >    static inline int load(struct profiler_bpf *skel);
> > >    static inline int attach(struct profiler_bpf *skel);
> > >    static inline void detach(struct profiler_bpf *skel);
> > >    static inline void destroy(struct profiler_bpf *skel);
> > >    static inline const void *elf_bytes(size_t *sz);
> > > ```
> > > ---
> > >   src/gen.c | 32 ++++++++++++++++++++++++++++++++
> > >   1 file changed, 32 insertions(+)
> >
> > > diff --git a/src/gen.c b/src/gen.c
> > > index 7070dcf..7e28dc7 100644
> > > --- a/src/gen.c
> > > +++ b/src/gen.c
> > > @@ -1086,6 +1086,38 @@ static int do_skeleton(int argc, char **argv)
> > >               \n\
> >  
> >                                                                            
> \n\
> > >               #ifdef  
> __cplusplus                                          \n\
> > > +             "
> > > +     );
> > > +
> >
> > [..]
> >
> > > +     {
> > > +             size_t i = 0;
> > > +             printf("\tenum map_index: size_t {");
> > > +             bpf_object__for_each_map(map, obj) {
> > > +                     if (!get_map_ident(map, ident, sizeof(ident)))
> > > +                             continue;
> > > +                     if (i) {
> > > +                             printf(",");
> > > +                     }
> > > +                     printf("\n\t\t%s = %lu", ident, i);
> > > +                     ++i;
> > > +             }
> > > +             printf("\n\t};\n");
> > > +     }
> > > +     {
> > > +             size_t i = 0;
> > > +             printf("\tenum prog_index: size_t {");
> > > +             bpf_object__for_each_program(prog, obj) {
> > > +                     if (i) {
> > > +                             printf(",");
> > > +                     }
> > > +                     printf("\n\t\t%s = %lu",  
> bpf_program__name(prog), i);
> > > +                     ++i;
> > > +             }
> > > +             printf("\n\t};\n");
> > > +     }
> >
> > I might be missing something, but what prevents you from calling these
> > on the skeleton's bpf_object?
> >
> >    skel = xxx__open();
> >
> >    bpf_object__for_each_map(map, skel->obj) {
> >      // do whatever you want here to test whether it's loadable or not
> >    }
> >
> >    // same for bpf_object__for_each_program
> >
> >    xxx__load(skel);
> >
> > How do these new enums help?
