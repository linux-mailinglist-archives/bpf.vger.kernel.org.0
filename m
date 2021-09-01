Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF33FD8E2
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 13:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbhIALkn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 07:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243753AbhIALkn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Sep 2021 07:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630496385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Om5B2W3t+fW0DWLUQjN1Z9adUS3zdf+8SczsT0i6Ja0=;
        b=G17fya9LW9udsS31n1FF5aHMfubEzf9iwSXgLK5ZGYSZ73A3L2yo1Aua7obGXcIG60XRzd
        O1T/FMTvHCchRKhbgGNAxTDFjRZMrp3oqq6tm07t6IbkkwsTMjhaWf2EFJYKbJM20jZmDD
        g7qXIlH0Rk9z6ZM9C2uz/PA7EH9caUo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-I9urq2FGM-isYT9CKXs18g-1; Wed, 01 Sep 2021 07:39:44 -0400
X-MC-Unique: I9urq2FGM-isYT9CKXs18g-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so878586wmj.8
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 04:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Om5B2W3t+fW0DWLUQjN1Z9adUS3zdf+8SczsT0i6Ja0=;
        b=B+HsLkLLJtBFDcvkmzd96NDRf+qJoqSkRrBE383LK1qpU0vkKPmSYMzSVG9CRvNkRs
         Iwp1sMHYR5vKlOmuKKNNyNgwbDTWnORvxx8Vhf3n9o12rSIEzNUSLsZGQ7DNDuTZBnY1
         b8CYt14J67Db8JBFKwe8r1rzBrQq6w6PaOpavwhppHvm/lh62FxG/WhY9tzc30YYusnz
         jK7vMajDXSH7vtCc+xAFxrW6tIBNElfI/WwsWOzIPNjmCCumLCZ/K1+ngFMErdi6rnUp
         N3r3PWPiNdZ3aMJAlvrs17g5F4abZeUD9GbgrTjZjkBtIPxPLr93X4pO9YUtCwvqSkkn
         Zdaw==
X-Gm-Message-State: AOAM532l7kp8koLTjnGQ87dEx1eKBjAbW8/z4hCEWJT1DaZ/kANTEAib
        ERyFhA5FZwVb2WTBE2g9n2lQd3+N63jXdfY6cN61VpxiLskY1QV0oGweZRsSu/mB1bJyQSO902k
        RI8X0a7Gg0seG
X-Received: by 2002:a1c:28b:: with SMTP id 133mr9197252wmc.138.1630496382812;
        Wed, 01 Sep 2021 04:39:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyek3btq8+RBNHOROVj7AlMC7xgwsgjELvU6aWn2rDcQOd3TynoRbpbujxe5RvZG89nQ+1iFQ==
X-Received: by 2002:a1c:28b:: with SMTP id 133mr9197238wmc.138.1630496382592;
        Wed, 01 Sep 2021 04:39:42 -0700 (PDT)
Received: from krava ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id x18sm5704975wmj.36.2021.09.01.04.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:39:42 -0700 (PDT)
Date:   Wed, 1 Sep 2021 13:39:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH bpf-next v4 17/27] bpf: Add multi trampoline attach
 support
Message-ID: <YS9mfFhMyT8vaYF/@krava>
References: <20210826193922.66204-1-jolsa@kernel.org>
 <20210826193922.66204-18-jolsa@kernel.org>
 <CAEf4BzbvhgG8uLtkWHYmTBzKnPSJOLAmqDum0tZn1LNVi-8-nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbvhgG8uLtkWHYmTBzKnPSJOLAmqDum0tZn1LNVi-8-nw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 04:36:22PM -0700, Andrii Nakryiko wrote:
> On Thu, Aug 26, 2021 at 12:41 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Adding new multi trampoline link (BPF_LINK_TYPE_TRACING_MULTI)
> > as an interface to attach program to multiple functions.
> >
> > The link_create bpf_attr interface already has 'bpf_prog' file
> > descriptor, that defines the program to be attached. It must be
> > loaded with BPF_F_MULTI_FUNC flag.
> >
> > Adding new multi_btf_ids/multi_btf_ids_cnt link_create bpf_attr
> > fields that provides BTF ids.
> >
> > The new link gets multi trampoline (via bpf_trampoline_multi_get)
> > and links the provided program with embedded trampolines and the
> > 'main' trampoline with new multi link/unlink functions:
> >
> >   int bpf_trampoline_multi_link_prog(struct bpf_prog *prog,
> >                                      struct bpf_trampoline_multi *tr);
> >   int bpf_trampoline_multi_unlink_prog(struct bpf_prog *prog,
> >                                        struct bpf_trampoline_multi *tr);
> >
> > If embedded trampoline contains fexit programs, we need to switch
> > its model to the multi trampoline model (because of the final 'ret'
> > argument). We keep the count of attached multi func programs for each
> > trampoline, so we can tell when to switch the model.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h            |   5 ++
> >  include/uapi/linux/bpf.h       |   5 ++
> >  kernel/bpf/core.c              |   1 +
> >  kernel/bpf/syscall.c           | 120 +++++++++++++++++++++++++++++++++
> >  kernel/bpf/trampoline.c        |  87 ++++++++++++++++++++++--
> >  tools/include/uapi/linux/bpf.h |   5 ++
> >  6 files changed, 219 insertions(+), 4 deletions(-)
> >
> 
> [...]
> 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1f9d336861f0..9533200ffadf 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1008,6 +1008,7 @@ enum bpf_link_type {
> >         BPF_LINK_TYPE_NETNS = 5,
> >         BPF_LINK_TYPE_XDP = 6,
> >         BPF_LINK_TYPE_PERF_EVENT = 7,
> > +       BPF_LINK_TYPE_TRACING_MULTI = 8,
> >
> >         MAX_BPF_LINK_TYPE,
> >  };
> > @@ -1462,6 +1463,10 @@ union bpf_attr {
> >                                  */
> >                                 __u64           bpf_cookie;
> >                         } perf_event;
> > +                       struct {
> > +                               __aligned_u64   multi_btf_ids;          /* addresses to attach */
> > +                               __u32           multi_btf_ids_cnt;      /* addresses count */
> > +                       };
> 
> Please follow the pattern of perf_event, name this struct "multi".

I did that in struct bpf_link_create_opts and forgot this place,
will change

> 
> >                 };
> >         } link_create;
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index bad03dde97a2..6c16ac43dd91 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> 
> [...]
> 
> > +
> > +       bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING_MULTI,
> > +                     &bpf_tracing_multi_link_lops, prog);
> > +       link->attach_type = prog->expected_attach_type;
> > +       link->multi = multi;
> > +
> > +       err = bpf_link_prime(&link->link, &link_primer);
> > +       if (err)
> > +               goto out_free;
> > +       err = bpf_trampoline_multi_link_prog(prog, multi);
> > +       if (err)
> > +               goto out_free;
> 
> bpf_link_cleanup(), can't free link after priming. Look at other
> places using bpf_link.

will check, thanks

jirka

> 
> 
> > +       return bpf_link_settle(&link_primer);
> > +
> > +out_free:
> > +       bpf_trampoline_multi_put(multi);
> > +       kfree(link);
> > +out_free_ids:
> > +       kfree(btf_ids);
> > +       return err;
> > +}
> > +
> 
> [...]
> 

