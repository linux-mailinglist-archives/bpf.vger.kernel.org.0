Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9644101D3
	for <lists+bpf@lfdr.de>; Sat, 18 Sep 2021 01:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhIQXkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhIQXkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 19:40:37 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA7FC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 16:39:14 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w10-20020ac87e8a000000b002a68361412bso22630839qtj.7
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 16:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8FJ6XBGVn4gnyhHG6ynCeB3KAKB+nfcMlVCIW7Up2PE=;
        b=U9Awus17Hmpq/VmawDw1R6a7fDEzowPLQ9r2vEuHw3QAgaIR3Aq03sUkjFJqShM8nB
         F2nqhXVIWzKAk902KUQEakJQYAEf5ICgzQUiaJrkUONjIBGyG1ViKjyAf2otBkqioiq+
         v8Gug/lyb7iqeYQm1H7B7H4Bpsri8vT/Xs3Rl3FThpGSXH/MSDDiGZ+D5E9/FRUWpx+h
         LD+af+fPlIRCRQ3zxMpnwSZtuL7f0G3mfuzfvOi/qnxSP11YZ4bv5jiWyacvDCSrCehY
         H7lgCqLgaAKLz4WFe7nPYEUI6XLdxDhoQOt4WgaoNU3bhkWmziQjrtzF38sLQtiHl3Xb
         6Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8FJ6XBGVn4gnyhHG6ynCeB3KAKB+nfcMlVCIW7Up2PE=;
        b=vaxHgGaheno5NdJrXox7sstzgNeg/goDrEZiGdN8BvRgybNkPLbgnn6BdQbIX7UcPg
         l+oiXY7HNIApNivQFU26KR6FulndwkYSQvKlyLjJRnV3wal0fQXlipUr5Pr0++MwCcwE
         N9JWuA4+3awa6yoko9EXYWpKQm65cIPmPOuVpMm9zuZBfxz+yvDBW9pPpCt1qwedxHNw
         rY2U1viu0t7hyZhnj8B+uHfRTMdR/XdzGmY+w5hRxiSVt6z1WD9FcgstjgRWtVjz8AVa
         1LW7dmrHrAGAMYt8a0E7YpPihk48ovGz1HzQTvhv87lAQ1La9w9L4VdCxm+sM+TuXnge
         SevA==
X-Gm-Message-State: AOAM531OOuQRJMXztNCb3Nuxtm5iUmQtiLCnvNmK6PJ8+b2GAz5fE0qD
        dq1F/SF+quPiKBLAjOEKWKyih0A=
X-Google-Smtp-Source: ABdhPJxKqnjTSz8OTMbiasZVEviaMs6V5qmFj7QTIKw4fPmkpFX1mCFiP1cyAz8FgCM9EjGT04dYXlA=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:5937:6f21:df47:504])
 (user=sdf job=sendgmr) by 2002:a25:2485:: with SMTP id k127mr8261059ybk.71.1631921953781;
 Fri, 17 Sep 2021 16:39:13 -0700 (PDT)
Date:   Fri, 17 Sep 2021 16:39:11 -0700
In-Reply-To: <CAEf4BzYg3Tdv3KjmwNYu=81ig=KeLOGvqA+zH_nC_VmJ3M6hjg@mail.gmail.com>
Message-Id: <YUUnHw3OjnTPD8Ii@google.com>
Mime-Version: 1.0
References: <20210917061020.821711-1-andrii@kernel.org> <20210917061020.821711-9-andrii@kernel.org>
 <YUTP20fF5wx0LbxQ@google.com> <CAEf4BzYV1YpYojN4STU=wB9G19n_JdXoMsxFeSkM43GeS6ATMg@mail.gmail.com>
 <YUUgj5kR1XA48Z3n@google.com> <CAEf4BzYg3Tdv3KjmwNYu=81ig=KeLOGvqA+zH_nC_VmJ3M6hjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/9] libbpf: add opt-in strict BPF program
 section name handling logic
From:   sdf@google.com
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/17, Andrii Nakryiko wrote:
> On Fri, Sep 17, 2021 at 4:11 PM <sdf@google.com> wrote:
> >
> > On 09/17, Andrii Nakryiko wrote:
> > > On Fri, Sep 17, 2021 at 10:26 AM <sdf@google.com> wrote:
> > > >
> > > > On 09/16, Andrii Nakryiko wrote:
> > > > > Implement strict ELF section name handling for BPF programs. It
> > > utilizes
> > > > > `libbpf_set_strict_mode()` framework and adds new flag:
> > > > > LIBBPF_STRICT_SEC_NAME.
> > > >
> > > > > If this flag is set, libbpf will enforce exact section name  
> matching
> > > for
> > > > > a lot of program types that previously allowed just partial prefix
> > > > > match. E.g., if previously SEC("xdp_whatever_i_want") was  
> allowed, now
> > > > > in strict mode only SEC("xdp") will be accepted, which makes  
> SEC("")
> > > > > definitions cleaner and more structured. SEC() now won't be used  
> as
> > > yet
> > > > > another way to uniquely encode BPF program identifier (for that
> > > > > C function name is better and is guaranteed to be unique within
> > > > > bpf_object). Now SEC() is strictly BPF program type and,  
> depending on
> > > > > program type, extra load/attach parameter specification.
> > > >
> > > > > Libbpf completely supports multiple BPF programs in the same ELF
> > > > > section, so multiple BPF programs of the same type/specification
> > > easily
> > > > > co-exist together within the same bpf_object scope.
> > > >
> > > > > Additionally, a new (for now internal) convention is introduced:
> > > section
> > > > > name that can be a stand-alone exact BPF program type  
> specificator,
> > > but
> > > > > also could have extra parameters after '/' delimiter. An example  
> of
> > > such
> > > > > section is "struct_ops", which can be specified by itself, but  
> also
> > > > > allows to specify the intended operation to be attached to, e.g.,
> > > > > "struct_ops/dctcp_init". Note, that "struct_ops_some_op" is not
> > > allowed.
> > > > > Such section definition is specified as "struct_ops+".
> > > >
> > > > > This change is part of libbpf 1.0 effort ([0], [1]).
> > > >
> > > > >    [0] Closes: https://github.com/libbpf/libbpf/issues/271
> > > > >    [1]
> > > > >
> > >  
> https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling
> > > >
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >   tools/lib/bpf/libbpf.c        | 135
> > > ++++++++++++++++++++++------------
> > > > >   tools/lib/bpf/libbpf_legacy.h |   9 +++
> > > > >   2 files changed, 98 insertions(+), 46 deletions(-)
> > > >

> [...]

> > > > > +     /*
> > > > > +      * Enforce strict BPF program section (SEC()) names.
> > > > > +      * E.g., while prefiously SEC("xdp_whatever") or
> > > SEC("perf_event_blah")
> > > > > were
> > > > > +      * allowed, with LIBBPF_STRICT_SEC_PREFIX this will become
> > > > > +      * unrecognized by libbpf and would have to be just  
> SEC("xdp")
> > > and
> > > > > +      * SEC("xdp") and SEC("perf_event").
> > > > > +      */
> > > > > +     LIBBPF_STRICT_SEC_NAME = 0x04,
> > > >
> > > > To clarify: I'm assuming, as discussed, we'll still support that  
> old,
> > > > non-conforming naming in libbpf 1.0, right? It just won't be enabled
> > > > by default.
> >
> > > No, we won't. All those opt-in strict flags will be turned on
> > > permanently in libbpf 1.0. But I'm adding an ability to provide custom
> > > callbacks to handle whatever (reasonable) BPF program section names.
> > > So if someone has a real important case needing custom handling, it's
> > > not a big problem to implement that logic on their own. If someone is
> > > just resisting making their code conforming, well... Stay on the old
> > > fixed version, write a callback, or just do the mechanical rename, how
> > > hard can that be? We are dropping bpf_program__find_program_by_title()
> > > in libbpf 1.0, that API is meaningless with multiple programs per
> > > section, so you'd have to update your logic to either skeleton or
> > > bpf_program__find_program_by_name() anyways.
> >
> > I see. I was assuming some of them would stay, iirc Toke also was asking
> > for this one to stay (or was it the old maps format?). FTR, I'm not
> > resisting any changes, I'm willing to invest some time to update our
> > callers, just trying to understand what my options are. We do have some
> > cases where we depend on the section names, so maybe I should just
> > switch from bpf_program__title to bpf_program__name (and do appropriate
> > renaming).

> Switching to name over title (section name) is a good idea for sure.

> >
> > RE skeleton: I'm not too eager to adopt it, I'll wait for version 2 :-)

> Honest curiosity, what's wrong with the current version of skeleton?
> Can you please expand on this?

Nothing wrong, I'm just joking, but I guess we went with a different path
long time ago where we ship .o more-or-less independently and it's hard to
adopt skeletons at this point (where .o is bundled with the userspace part).
We also ship several .o's compiled for different kernel versions because
prior to BTF we didn't have a good way todo '#ifdef KERNEL_X_Y_Z' and
some of that still lives on (but probably should die eventually).

Maybe we should do some talk on some conference on the way we ship
bpf to the fleet. Again, it's not like we don't like to change anything
here, but there is some existing "legacy" infra that has some
assumptions that might not easy to change in a short period of time.
