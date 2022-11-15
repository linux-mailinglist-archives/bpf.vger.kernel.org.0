Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB9628F7F
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 02:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKOBsn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 20:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiKOBsm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 20:48:42 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ADAD72;
        Mon, 14 Nov 2022 17:48:40 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-368edbc2c18so123929147b3.13;
        Mon, 14 Nov 2022 17:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNuWbtyi2DGq0JMDb2OrbzGf3xZeKbndYxXiO7TURe0=;
        b=Km5To1twBOZuFmyOfmG4LJ+/kKhVICV8abGtsojCrd/j4xC7ElBv7yCk5DqAAcjuHQ
         NkHy8IMJMkHKUiupj/g+kE11SwkcdUtAz6EYaqGr44lscaH4+vOaXaWMpNDHrPpDQCTI
         mjEecw+XSm4c3Z3dbCtv7yazwp5LggqQ1MphQNQb0lGUGV7ub0juPxLT4H8xXDw4kGCV
         V+gpLvaHQw+n4vB9JNy3XMlIP7FxmU2S2DpPqjvwcsD51okchYsScQz0ftSsGbfOgDOg
         tPHajEWlWmTowv8ASwwU/Ujet0eX1ZWDFWTcKqw1CaBWGUD/F7GYM8QOfPCMdYxv4jSI
         bbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNuWbtyi2DGq0JMDb2OrbzGf3xZeKbndYxXiO7TURe0=;
        b=7IwVH4vq50XPZ+1uH8ma3zuhRqkIYRpAGAS8YGElXNGK9wsAvOv8VJOLwchfDPd2YJ
         ZTFDOKN49yBFcN+N9e2qcXF7bax59pVQ5npXRdaT8A2hn33fxbJ3r/PAJSnQ6zcdlGFq
         IsuZTg63w/SrYWTkl5Q4TyNv8pvn3QuxuxzIY20PreCMJgVHkIj9UuBJF331TYlKMzd/
         szh2YNcfQjYu+nG/pvaPWeedqg4yk4WbeIty1o2XEfEY3sw4sELnpd/f3yMAk7r1Je28
         IechE8BsRzAfONrxI5w1mA/UPsU52VJx2ygDwRiB+NPQAO6KC289T8v5gujlIoeLoQZo
         CAXQ==
X-Gm-Message-State: ANoB5plzBTA9DbBh5JU82FFvVUzMqARAu7zpF2XDmtN7XzxxIxDHERhN
        gcD407tNzulPR+mjUZedOovEzQg1aN2OAZHrpPd7mRpxZA==
X-Google-Smtp-Source: AA0mqf4sSTrGQ7yqkww4dj5Nn2U2JhCMRn5UImuRaDxzM6e6SVnuM5iX4Jro4JewmKGUPyfd0glI8TIydYMFUAaBhJA=
X-Received: by 2002:a81:6503:0:b0:381:49e8:a798 with SMTP id
 z3-20020a816503000000b0038149e8a798mr7033910ywb.253.1668476919118; Mon, 14
 Nov 2022 17:48:39 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
 <Y2J+n7SqmtfyA7ZM@krava> <Y2j6ivTwFmA0FtvY@krava> <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
 <Y2uv/GjnSdr/ujOj@krava> <CAADnVQJp0ZrodRu8ZtvvtXk6KAbjxmwqD-nXgFAxNpNxN6JM=g@mail.gmail.com>
 <Y2w9bNhVlAs/PcNV@krava> <Y25gFdliV7XqdUnN@krava> <CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com>
 <Y3H2qayW0hKlzBkK@krava> <Y3LFgI6mmC0SKiFw@krava>
In-Reply-To: <Y3LFgI6mmC0SKiFw@krava>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 15 Nov 2022 09:48:27 +0800
Message-ID: <CACkBjsZpz9WqHgPY3oMj4BKuDPwU_QNkkCh2OeHL+nersyrQQw@mail.gmail.com>
Subject: Re: WARNING in bpf_bprintf_prepare
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri Olsa <olsajiri@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=BA=8C 06:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 14, 2022 at 09:04:57AM +0100, Jiri Olsa wrote:
> > On Sat, Nov 12, 2022 at 12:02:50AM +0800, Hao Sun wrote:
> > > Jiri Olsa <olsajiri@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=BA=94 22:45=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Thu, Nov 10, 2022 at 12:53:16AM +0100, Jiri Olsa wrote:
> > > >
> > > > SNIP
> > > >
> > > > > > > > > ---
> > > > > > > > > diff --git a/include/trace/bpf_probe.h b/include/trace/bp=
f_probe.h
> > > > > > > > > index 6a13220d2d27..5a354ae096e5 100644
> > > > > > > > > --- a/include/trace/bpf_probe.h
> > > > > > > > > +++ b/include/trace/bpf_probe.h
> > > > > > > > > @@ -78,11 +78,15 @@
> > > > > > > > >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(=
__VA_ARGS__))(__VA_ARGS__)
> > > > > > > > >
> > > > > > > > >  #define __BPF_DECLARE_TRACE(call, proto, args)          =
               \
> > > > > > > > > +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call)=
;              \
> > > > > > > > >  static notrace void                                     =
               \
> > > > > > > > >  __bpf_trace_##call(void *__data, proto)                 =
                       \
> > > > > > > > >  {                                                       =
               \
> > > > > > > > >         struct bpf_prog *prog =3D __data;                =
                 \
> > > > > > > > > -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog=
, CAST_TO_U64(args));  \
> > > > > > > > > +                                                        =
               \
> > > > > > > > > +       if (likely(this_cpu_inc_return(__bpf_trace_tp_act=
ive_##call) =3D=3D 1))             \
> > > > > > > > > +               CONCATENATE(bpf_trace_run, COUNT_ARGS(arg=
s))(prog, CAST_TO_U64(args));  \
> > > > > > > > > +       this_cpu_dec(__bpf_trace_tp_active_##call);      =
                               \
> > > > > > > > >  }
> > > > > > > >
> > > > > > > > This approach will hurt real use cases where
> > > > > > > > multiple and different raw_tp progs run on the same cpu.
> > > > > > >
> > > > > > > would the 2 levels of nesting help in here?
> > > > > > >
> > > > > > > I can imagine the change above would break use case where we =
want to
> > > > > > > trigger tracepoints in irq context that interrupted task that=
's already
> > > > > > > in the same tracepoint
> > > > > > >
> > > > > > > with 2 levels of nesting we would trigger that tracepoint fro=
m irq and
> > > > > > > would still be safe with bpf_bprintf_prepare buffer
> > > > > >
> > > > > > How would these 2 levels work?
> > > > >
> > > > > just using the active counter like below, but I haven't tested it=
 yet
> > > > >
> > > > > jirka
> > > >
> > > > seems to be working
> > > > Hao Sun, could you please test this patch?
> > > >
> > >
> > > Hi Jirka,
> > >
> > > I've tested the proposed patch, the warning from bpf_bprintf_prepare =
will not
> > > be triggered with the patch, but the reproducer can still trigger the=
 following
> > > warning. My test was conducted on:
> > >
> > > commit:  f67dd6ce0723 Merge tag 'slab-for-6.1-rc4-fixes'
> > > git tree:   upstream
> > > kernel config: https://pastebin.com/raw/sE5QK5HL
> > > C reproducer: https://pastebin.com/raw/X96ASi27
> > > console log *before* the patch: https://pastebin.com/raw/eSCUNFrd
> > > console log *after* the patch: https://pastebin.com/raw/tzcmdWZt
> >
> > thanks for testing.. I can't reproduce this for some reason
> >
> > I'll check some more and perhaps go with denying bpf attachment
> > for this tracepoint as Alexei suggeste
>
> the change below won't allow to attach bpf program with any printk
> helper in contention_begin and bpf_trace_printk tracepoints
>
> I still need to test it on the machine that reproduced the issue
> for me.. meanwhile any feedback is appreciated
>

Hi,

Tested on my machine, the C reproducer won't trigger any issue
this time with the patch. The test was conducted on:

commit:  f67dd6ce0723 Merge tag 'slab-for-6.1-rc4-fixes'
git tree:   upstream
kernel config: https://pastebin.com/raw/sE5QK5HL
C reproducer: https://pastebin.com/raw/X96ASi27
full console log *before* the patch: https://pastebin.com/raw/n3x55RDr
full console log *after* the patch: https://pastebin.com/raw/7HdxnCnL

Thanks
Hao

> thanks,
> jirka
>
> ---
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 798aec816970..d88e0741b381 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1257,7 +1257,8 @@ struct bpf_prog {
>                                 enforce_expected_attach_type:1, /* Enforc=
e expected_attach_type checking at attach time */
>                                 call_get_stack:1, /* Do we call bpf_get_s=
tack() or bpf_get_stackid() */
>                                 call_get_func_ip:1, /* Do we call get_fun=
c_ip() */
> -                               tstamp_type_access:1; /* Accessed __sk_bu=
ff->tstamp_type */
> +                               tstamp_type_access:1, /* Accessed __sk_bu=
ff->tstamp_type */
> +                               call_printk:1; /* Do we call trace_printk=
/trace_vprintk  */
>         enum bpf_prog_type      type;           /* Type of BPF program */
>         enum bpf_attach_type    expected_attach_type; /* For some prog ty=
pes */
>         u32                     len;            /* Number of filter block=
s */
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 20749bd9db71..fd2725624fed 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -742,7 +742,7 @@ void perf_event_detach_bpf_prog(struct perf_event *ev=
ent);
>  int perf_event_query_prog_array(struct perf_event *event, void __user *i=
nfo);
>  int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p=
rog);
>  int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog =
*prog);
> -struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
> +struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name, struc=
t bpf_prog *prog);
>  void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
>  int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id=
,
>                             u32 *fd_type, const char **buf,
> @@ -775,7 +775,8 @@ static inline int bpf_probe_unregister(struct bpf_raw=
_event_map *btp, struct bpf
>  {
>         return -EOPNOTSUPP;
>  }
> -static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const cha=
r *name)
> +static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const cha=
r *name,
> +                                                              struct bpf=
_prog *prog)
>  {
>         return NULL;
>  }
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 85532d301124..d6081e8336c6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3281,7 +3281,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *=
prog,
>                 return -EINVAL;
>         }
>
> -       btp =3D bpf_get_raw_tracepoint(tp_name);
> +       btp =3D bpf_get_raw_tracepoint(tp_name, prog);
>         if (!btp)
>                 return -ENOENT;
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 07c0259dfc1a..9862345d9249 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7572,6 +7572,10 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
>                 err =3D __check_func_call(env, insn, insn_idx_p, meta.sub=
progno,
>                                         set_user_ringbuf_callback_state);
>                 break;
> +       case BPF_FUNC_trace_printk:
> +       case BPF_FUNC_trace_vprintk:
> +               env->prog->call_printk =3D 1;
> +               break;
>         }
>
>         if (err)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f2d8d070d024..9a4652a05690 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2229,10 +2229,32 @@ int perf_event_query_prog_array(struct perf_event=
 *event, void __user *info)
>  extern struct bpf_raw_event_map __start__bpf_raw_tp[];
>  extern struct bpf_raw_event_map __stop__bpf_raw_tp[];
>
> -struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
> +static int check_printk_denylist(const char *name, struct bpf_prog *prog=
)
> +{
> +       static const char *denylist[] =3D {
> +               "contention_begin",
> +               "bpf_trace_printk",
> +       };
> +       int i;
> +
> +       if (!prog->call_printk)
> +               return 0;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(denylist); i++) {
> +               if (!strcmp(denylist[i], name))
> +                       return 1;
> +       }
> +       return 0;
> +}
> +
> +struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name,
> +                                                struct bpf_prog *prog)
>  {
>         struct bpf_raw_event_map *btp =3D __start__bpf_raw_tp;
>
> +       if (check_printk_denylist(name, prog))
> +               return NULL;
> +
>         for (; btp < __stop__bpf_raw_tp; btp++) {
>                 if (!strcmp(btp->tp->name, name))
>                         return btp;
