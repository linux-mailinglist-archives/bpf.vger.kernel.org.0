Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBA54A544F
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 01:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiBAAxv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 19:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiBAAxv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 19:53:51 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E911AC061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 16:53:50 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z18so4179122ilp.3
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 16:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kg7Ml+9U00mSP1Z4iiyRW96StQFfnh7vqGE4Pgb2+vM=;
        b=lmPyr18qNiWWUa7Av3Xa/SSP5yX5ryWuyvb94X3CKoe0VWEl7EMdNyOa/FtdeqUK78
         Jk9zoZw5MeTEhYBEmmJIE5tStLxOEfV1r9zDxJ9rIpg6H33eoI2enCflBVfkqcONGcLG
         VokKCD4d30wx6DyG7oInox9WQx3OWfyy0VtrIlytOO0CSdMnsk03e51iNCz4GphiXLgg
         fIK/zgV5DVgCzQMLvN8/4h4N9//c4++O2UeoGY5wlbJYyNMn/aXUO5QKD7lOG7511e3S
         NKYSq8VMQ01g3N2GQCNrGNaSMeSTZeo0YlWkGO+yfz9DpWYSBgVy9H6mURZ9S0iXHoId
         kRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kg7Ml+9U00mSP1Z4iiyRW96StQFfnh7vqGE4Pgb2+vM=;
        b=5KM4TSbmsRw6rn4yOaQJPF0TRpSP8t1R+SD4RooHq7oD1DLsvIYwLs+osUc+WZAial
         MELo3kvUZn3tEkj3ISOgWArh8o+oPv2s4k0TVrq7i2jkttfYJCeLW+ZnITtfMOjG8D4h
         LlaYGYkNWX+HZfGx7nY/S8stfj5YwAmmvPu+A0PTb7VS1k0Q8peoAqH+roQCezhwX6GC
         A6Ao/XZryWwd8DJHuRwoQuVxZCZajObq6KEdVoPTC+OSDOXbWdPbtvve0W/wunLNbnYr
         sN7jOibUoDKcVEPyGqDo7Th99/x/WESUupgTAazxVhKUJ6G1/hXQ+eJX8YARsrw60M1Q
         IjYQ==
X-Gm-Message-State: AOAM530pZWtSx9ntOB9zJ7VDlnJf8KCBKZXV6TBpCqpsfDIYaFcoiyqK
        mHnOn9i3nBxfUgrosqZitA1rWaQfCOLt0VdJeRA=
X-Google-Smtp-Source: ABdhPJwGopjB2s7AuWYXLGy5fOijDd/QATe2XYrYu3ipojJ9aM1qugVuaKyQxKy+88JeTRuTtqWZW14H3fW0nmZ9MVs=
X-Received: by 2002:a05:6e02:1bc7:: with SMTP id x7mr13009876ilv.98.1643676830346;
 Mon, 31 Jan 2022 16:53:50 -0800 (PST)
MIME-Version: 1.0
References: <d7f8f9e3370d33be0a3385c7604d8925e10c91d1.1643285321.git.lorenzo@kernel.org>
 <87pmod196i.fsf@toke.dk> <CAEf4BzYOZ6fi_SSgJmWRD7TM44w71L_+QPv9H13OCA08f9RHww@mail.gmail.com>
 <YfLVQAbbR+dcZfii@lore-desk>
In-Reply-To: <YfLVQAbbR+dcZfii@lore-desk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 16:53:39 -0800
Message-ID: <CAEf4BzZkZbnMGbpu3_zJc1t3D82FfgFUuf4RzP97Zy=WbOYB0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: deprecate xdp_cpumap and xdp_devmap sec definitions
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 9:24 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote=
:
>
> > On Thu, Jan 27, 2022 at 7:37 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
> > >
> > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > >
> > > > Deprecate xdp_cpumap xdp_devmap sec definitions.
> > > > Introduce xdp/devmap and xdp/cpumap definitions according to the st=
andard
> > > > for SEC("") in libbpf:
> > > > - prog_type.prog_flags/attach_place
> > > > Update cpumap/devmap samples and kselftests
> > > >
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  samples/bpf/xdp_redirect_cpu.bpf.c                   |  8 ++++----
> > > >  samples/bpf/xdp_redirect_map.bpf.c                   |  2 +-
> > > >  samples/bpf/xdp_redirect_map_multi.bpf.c             |  2 +-
> > > >  tools/lib/bpf/libbpf.c                               | 12 ++++++++=
++--
> > > >  .../bpf/progs/test_xdp_with_cpumap_frags_helpers.c   |  2 +-
> > > >  .../bpf/progs/test_xdp_with_cpumap_helpers.c         |  2 +-
> > > >  .../bpf/progs/test_xdp_with_devmap_frags_helpers.c   |  2 +-
> > > >  .../bpf/progs/test_xdp_with_devmap_helpers.c         |  2 +-
> > > >  .../selftests/bpf/progs/xdp_redirect_multi_kern.c    |  2 +-
> > > >  9 files changed, 21 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/samples/bpf/xdp_redirect_cpu.bpf.c b/samples/bpf/xdp_r=
edirect_cpu.bpf.c
> > > > index 25e3a405375f..87c54bfdbb70 100644
> > > > --- a/samples/bpf/xdp_redirect_cpu.bpf.c
> > > > +++ b/samples/bpf/xdp_redirect_cpu.bpf.c
> > > > @@ -491,7 +491,7 @@ int  xdp_prognum5_lb_hash_ip_pairs(struct xdp_m=
d *ctx)
> > > >       return bpf_redirect_map(&cpu_map, cpu_dest, 0);
> > > >  }
> > > >
> > > > -SEC("xdp_cpumap/redirect")
> > > > +SEC("xdp/cpumap")
> > > >  int xdp_redirect_cpu_devmap(struct xdp_md *ctx)
> > > >  {
> > > >       void *data_end =3D (void *)(long)ctx->data_end;
> > > > @@ -507,19 +507,19 @@ int xdp_redirect_cpu_devmap(struct xdp_md *ct=
x)
> > > >       return bpf_redirect_map(&tx_port, 0, 0);
> > > >  }
> > > >
> > > > -SEC("xdp_cpumap/pass")
> > > > +SEC("xdp/cpumap")
> > > >  int xdp_redirect_cpu_pass(struct xdp_md *ctx)
> > > >  {
> > > >       return XDP_PASS;
> > > >  }
> > > >
> > > > -SEC("xdp_cpumap/drop")
> > > > +SEC("xdp/cpumap")
> > > >  int xdp_redirect_cpu_drop(struct xdp_md *ctx)
> > > >  {
> > > >       return XDP_DROP;
> > > >  }
> > > >
> > > > -SEC("xdp_devmap/egress")
> > > > +SEC("xdp/devmap")
> > > >  int xdp_redirect_egress_prog(struct xdp_md *ctx)
> > > >  {
> > > >       void *data_end =3D (void *)(long)ctx->data_end;
> > > > diff --git a/samples/bpf/xdp_redirect_map.bpf.c b/samples/bpf/xdp_r=
edirect_map.bpf.c
> > > > index 59efd656e1b2..415bac1758e3 100644
> > > > --- a/samples/bpf/xdp_redirect_map.bpf.c
> > > > +++ b/samples/bpf/xdp_redirect_map.bpf.c
> > > > @@ -68,7 +68,7 @@ int xdp_redirect_map_native(struct xdp_md *ctx)
> > > >       return xdp_redirect_map(ctx, &tx_port_native);
> > > >  }
> > > >
> > > > -SEC("xdp_devmap/egress")
> > > > +SEC("xdp/devmap")
> > > >  int xdp_redirect_map_egress(struct xdp_md *ctx)
> > > >  {
> > > >       void *data_end =3D (void *)(long)ctx->data_end;
> > > > diff --git a/samples/bpf/xdp_redirect_map_multi.bpf.c b/samples/bpf=
/xdp_redirect_map_multi.bpf.c
> > > > index bb0a5a3bfcf0..8b2fd4ec2c76 100644
> > > > --- a/samples/bpf/xdp_redirect_map_multi.bpf.c
> > > > +++ b/samples/bpf/xdp_redirect_map_multi.bpf.c
> > > > @@ -53,7 +53,7 @@ int xdp_redirect_map_native(struct xdp_md *ctx)
> > > >       return xdp_redirect_map(ctx, &forward_map_native);
> > > >  }
> > > >
> > > > -SEC("xdp_devmap/egress")
> > > > +SEC("xdp/devmap")
> > > >  int xdp_devmap_prog(struct xdp_md *ctx)
> > > >  {
> > > >       void *data_end =3D (void *)(long)ctx->data_end;
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 4ce94f4ed34a..1d97bc346be6 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -237,6 +237,8 @@ enum sec_def_flags {
> > > >       SEC_SLOPPY_PFX =3D 16,
> > > >       /* BPF program support non-linear XDP buffer */
> > > >       SEC_XDP_FRAGS =3D 32,
> > > > +     /* deprecated sec definitions not supposed to be used */
> > > > +     SEC_DEPRECATED =3D 64,
> > > >  };
> > > >
> > > >  struct bpf_sec_def {
> > > > @@ -6575,6 +6577,10 @@ static int libbpf_preload_prog(struct bpf_pr=
ogram *prog,
> > > >       if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRA=
GS))
> > > >               opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> > > >
> > > > +     if (def & SEC_DEPRECATED)
> > > > +             pr_warn("sec '%s' is deprecated, please use new versi=
on instead\n",
> > > > +                     prog->sec_name);
> > > > +
> > >
> > > How is the user supposed to figure out what "the new version" is?
> >
> >
> > Let's add the section to
> > https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide and
> > link to it from the deprecation warning.
>
> so, is it better to add an utility routine to map the deprecated sec_name=
 to
> the new one, or is it enough to add a section in Libbpf-1.0-migration-gui=
de?
> I am fine both ways.

Let's add a section about deprecated sections (we were also talking
about deprecating "classifier" in favor of "tc", so we can mention
that as well). It's better to maintain that mapping in a wiki than
through libbpf code, IMO. Wiki can provide more context than what we
can reasonable put into deprecation messages as well.

>
> Regards,
> Lorenzo
>
> >
> > >
> > > -Toke
> > >
