Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950EC1486B5
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 15:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbgAXOQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 09:16:12 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35421 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387927AbgAXOQM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 09:16:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id q39so805662pjc.0
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASOtb96BI6lTR6mu+ywHC0FfQOfd7+/ZeIlUMSQ1MgU=;
        b=kmOyBuxl6PiajDWOBlWoRTw9yCno28+dJhqCOaiVgt6OckuzVAlVVZRw10RbyxwIBa
         uzMgDELMRyNUlNoW+CptCJeZidIZIYqFTEpTEhkuNiGGPZE/WdP8i3rmgFINfGzlkZdo
         sLYYApupXDdvLWAGmDrqQIwwialBjxVF2Ry8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASOtb96BI6lTR6mu+ywHC0FfQOfd7+/ZeIlUMSQ1MgU=;
        b=SOurJ6ZDSuD+xjjsxFRDxwE47Bkfiw8zeiKr5lWEky2vdfSAb5hJfMAC/vIlKqtgMy
         S4zz5QoBtu+rXL35vmIOVhsN9rU37MNJI8smny9jqFomFq+rFUblDtxsiqlbkApk1u7f
         Hj8VlNQ7o1efx6y9d5BQcki4ZsRk955dkwl3R6jjDLLrA7cy4Kt05txyjqWhutg77Kpw
         3/6aR20hnw0UyttzmmJmKDDGYKay/8rH1CfsxUTL5QqSvczvaAX9zlrOm5p3xcEeXOKd
         X2tgu4P2uvFGBbGDfr6fnuMz64qFFtDUVZXLvtOefFAPZVZP9gg2DgEgPOwVrfVdXpy3
         sQOQ==
X-Gm-Message-State: APjAAAUFNgTrBl3G0c+m9yzDYo7eq1wKc5K32tpdnXTUcJJrNPFsdrf2
        f76RBMZ2K7G4eVE3rf6r98NpdQ==
X-Google-Smtp-Source: APXvYqwNRhkmJ4mbSYJLO0PmKxo+8nA6r5QBn7/anONeoROTjVfQayIadlHpsoWWf7cq2t4MlfwYcQ==
X-Received: by 2002:a17:90a:2203:: with SMTP id c3mr3394823pje.68.1579875371008;
        Fri, 24 Jan 2020 06:16:11 -0800 (PST)
Received: from chromium.org ([2601:647:4903:8020:88e3:d812:557:e2e5])
        by smtp.gmail.com with ESMTPSA id v8sm6549623pff.151.2020.01.24.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:16:10 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 24 Jan 2020 06:16:00 -0800
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v3 08/10] tools/libbpf: Add support for
 BPF_PROG_TYPE_LSM
Message-ID: <20200124141600.GB21334@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-9-kpsingh@chromium.org>
 <CAEf4BzZ7gmCTzxw4f=fp=j2_buBQ3rV8m3qWH8s-ySY6sGVPzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ7gmCTzxw4f=fp=j2_buBQ3rV8m3qWH8s-ySY6sGVPzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Thu, Jan 23, 2020 at 7:25 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > * Add functionality in libbpf to attach eBPF program to LSM hooks
> > * Lookup the index of the LSM hook in security_hook_heads and pass it in
> >   attr->lsm_hook_idx
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > ---
> 
> Looks good, but see few nits below.
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Thanks!

> 
> >  tools/lib/bpf/bpf.c      |   6 ++-
> >  tools/lib/bpf/bpf.h      |   1 +
> >  tools/lib/bpf/libbpf.c   | 104 +++++++++++++++++++++++++++++++++++++--
> >  tools/lib/bpf/libbpf.h   |   4 ++
> >  tools/lib/bpf/libbpf.map |   3 ++
> >  5 files changed, 114 insertions(+), 4 deletions(-)
> >
> 
> [...]
> 
> > @@ -5084,6 +5099,8 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
> >                 if (prog->type != BPF_PROG_TYPE_UNSPEC)
> >                         continue;
> >
> > +
> > +
> 
> why these extra lines?

Ah this might have crept in my latest rebase. Will remove these.

> 
> >                 err = libbpf_prog_type_by_name(prog->section_name, &prog_type,
> >                                                &attach_type);
> >                 if (err == -ESRCH)
> > @@ -6160,6 +6177,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)       \
> >  }                                                              \
> >
> >  BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
> > +BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
> >  BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
> >  BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
> >  BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
> > @@ -6226,6 +6244,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
> >                                       struct bpf_program *prog);
> >  static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
> >                                      struct bpf_program *prog);
> > +static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
> > +                                  struct bpf_program *prog);
> >
> >  struct bpf_sec_def {
> >         const char *sec;
> > @@ -6272,6 +6292,9 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("freplace/", EXT,
> >                 .is_attach_btf = true,
> >                 .attach_fn = attach_trace),
> > +       SEC_DEF("lsm/", LSM,
> > +               .expected_attach_type = BPF_LSM_MAC,
> 
> curious, will there be non-MAC LSM programs? if yes, how they are
> going to be different and which prefix will we use then?

One can think BPF_LSM_AUDIT programs which will only be used to log
information from the LSM hooks and not enforce a policy. Currently,
one can sort of do that by disabling CONFIG_SECURITY_BPF_ENFORCE but
that's an all or none hammer.

> 
> > +               .attach_fn = attach_lsm),
> >         BPF_PROG_SEC("xdp",                     BPF_PROG_TYPE_XDP),
> >         BPF_PROG_SEC("perf_event",              BPF_PROG_TYPE_PERF_EVENT),
> >         BPF_PROG_SEC("lwt_in",                  BPF_PROG_TYPE_LWT_IN),
> > @@ -6533,6 +6556,44 @@ static int bpf_object__collect_struct_ops_map_reloc(struct bpf_object *obj,
> >         return -EINVAL;
> >  }
> >
> > +static __s32 find_lsm_hook_idx(struct bpf_program *prog)
> 
> nit: I'd stick to int for return result, we barely ever use __s32 in libbpf.c

Sure. Changed to int.

- KP

> 
> [...]
