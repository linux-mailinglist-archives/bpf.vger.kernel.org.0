Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8849E865
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 18:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbiA0RJG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 12:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiA0RJG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 12:09:06 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6257C061714
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 09:09:05 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n17so4385840iod.4
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 09:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ltUC9kRolqRrY5uLf3St/EwTGUkON+1tqgV/o1Mo0Fk=;
        b=nYHcY0S3rCN5InDLHsu0wRq62BfEwgC9RHJ9E4UuWO3eojdnrv5b401ZMuuscSlAJ+
         7aFJR16+IeaaaN7uHwzQORWiwQcIP04xLnF/V4WBreENIlLRbV6ORMr4JFuxiQspG2E2
         hn6sYNf+J0b5yTUF2hcb8xe98NnAZ6wJIFmaDXiiV01uMPqJAN2rVKsULJx5Pn383ztN
         wGTNnGoESDY0IdlrZDIpOYyMbExsMeRb7NfpFzWTo/y/4eZhtpudb3j04923+eU9EsEc
         u4Fmea204Y7hAyDo6IYC7p74eDzu4xLCgmEMHRtO4eq0Sv0G9H6gJ0vCCzbDeDJdKaKk
         wmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ltUC9kRolqRrY5uLf3St/EwTGUkON+1tqgV/o1Mo0Fk=;
        b=mmbefFHlIpVDHgX8fuMyyNJA/9VYiW5Lpwx/Husg33zYbRfPWKkaidNMDq7hlTV3ZJ
         Vz6zjbDFPbqN3TU9BgDQEr3AuiYIUR+Rxu+w9c5ZFcPTm402Hs/oLon/DZx/sXIn+9eN
         tpjnj6NEKhgI+PegjaogYYTAneG0CJVK0xOQIGaKz60FKBjU4Z3VEasHpbaaTYSyN4al
         jQK+1ysKOxctur7mOMWdYkIxhgX6g0T3JHuI8RLzyIjPrLb1yF+WRTz9FzJ/Dgp2OGxn
         C1cctHc3O8kTg16NXYN7ZRl/qL8ix0KOuGWKF3xeTlzHBzc5d3I8x54Xhm4hpgy0wIVV
         YEzw==
X-Gm-Message-State: AOAM531NcMmbH1b1N7wN0tfcZzBtzMCYZAULPsROW0oRPcLmMMIPRjku
        hnP5IfD5SXdxjaui5DVIi2IH7CjKNmZhhXXADNF/TZ1dE0WmAQ==
X-Google-Smtp-Source: ABdhPJyPc4t3jtOwCMspfc/sJCXMt0glfWUwfobHvNSRhwUC9/f9LzT5uCaf2kK0tIxRS9tSUMpQi+SsdeTbrdXzhlA=
X-Received: by 2002:a5d:89cf:: with SMTP id a15mr2556612iot.79.1643303345140;
 Thu, 27 Jan 2022 09:09:05 -0800 (PST)
MIME-Version: 1.0
References: <d7f8f9e3370d33be0a3385c7604d8925e10c91d1.1643285321.git.lorenzo@kernel.org>
 <87pmod196i.fsf@toke.dk>
In-Reply-To: <87pmod196i.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Jan 2022 09:08:54 -0800
Message-ID: <CAEf4BzYOZ6fi_SSgJmWRD7TM44w71L_+QPv9H13OCA08f9RHww@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: deprecate xdp_cpumap and xdp_devmap sec definitions
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Thu, Jan 27, 2022 at 7:37 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>
> > Deprecate xdp_cpumap xdp_devmap sec definitions.
> > Introduce xdp/devmap and xdp/cpumap definitions according to the standa=
rd
> > for SEC("") in libbpf:
> > - prog_type.prog_flags/attach_place
> > Update cpumap/devmap samples and kselftests
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  samples/bpf/xdp_redirect_cpu.bpf.c                   |  8 ++++----
> >  samples/bpf/xdp_redirect_map.bpf.c                   |  2 +-
> >  samples/bpf/xdp_redirect_map_multi.bpf.c             |  2 +-
> >  tools/lib/bpf/libbpf.c                               | 12 ++++++++++--
> >  .../bpf/progs/test_xdp_with_cpumap_frags_helpers.c   |  2 +-
> >  .../bpf/progs/test_xdp_with_cpumap_helpers.c         |  2 +-
> >  .../bpf/progs/test_xdp_with_devmap_frags_helpers.c   |  2 +-
> >  .../bpf/progs/test_xdp_with_devmap_helpers.c         |  2 +-
> >  .../selftests/bpf/progs/xdp_redirect_multi_kern.c    |  2 +-
> >  9 files changed, 21 insertions(+), 13 deletions(-)
> >
> > diff --git a/samples/bpf/xdp_redirect_cpu.bpf.c b/samples/bpf/xdp_redir=
ect_cpu.bpf.c
> > index 25e3a405375f..87c54bfdbb70 100644
> > --- a/samples/bpf/xdp_redirect_cpu.bpf.c
> > +++ b/samples/bpf/xdp_redirect_cpu.bpf.c
> > @@ -491,7 +491,7 @@ int  xdp_prognum5_lb_hash_ip_pairs(struct xdp_md *c=
tx)
> >       return bpf_redirect_map(&cpu_map, cpu_dest, 0);
> >  }
> >
> > -SEC("xdp_cpumap/redirect")
> > +SEC("xdp/cpumap")
> >  int xdp_redirect_cpu_devmap(struct xdp_md *ctx)
> >  {
> >       void *data_end =3D (void *)(long)ctx->data_end;
> > @@ -507,19 +507,19 @@ int xdp_redirect_cpu_devmap(struct xdp_md *ctx)
> >       return bpf_redirect_map(&tx_port, 0, 0);
> >  }
> >
> > -SEC("xdp_cpumap/pass")
> > +SEC("xdp/cpumap")
> >  int xdp_redirect_cpu_pass(struct xdp_md *ctx)
> >  {
> >       return XDP_PASS;
> >  }
> >
> > -SEC("xdp_cpumap/drop")
> > +SEC("xdp/cpumap")
> >  int xdp_redirect_cpu_drop(struct xdp_md *ctx)
> >  {
> >       return XDP_DROP;
> >  }
> >
> > -SEC("xdp_devmap/egress")
> > +SEC("xdp/devmap")
> >  int xdp_redirect_egress_prog(struct xdp_md *ctx)
> >  {
> >       void *data_end =3D (void *)(long)ctx->data_end;
> > diff --git a/samples/bpf/xdp_redirect_map.bpf.c b/samples/bpf/xdp_redir=
ect_map.bpf.c
> > index 59efd656e1b2..415bac1758e3 100644
> > --- a/samples/bpf/xdp_redirect_map.bpf.c
> > +++ b/samples/bpf/xdp_redirect_map.bpf.c
> > @@ -68,7 +68,7 @@ int xdp_redirect_map_native(struct xdp_md *ctx)
> >       return xdp_redirect_map(ctx, &tx_port_native);
> >  }
> >
> > -SEC("xdp_devmap/egress")
> > +SEC("xdp/devmap")
> >  int xdp_redirect_map_egress(struct xdp_md *ctx)
> >  {
> >       void *data_end =3D (void *)(long)ctx->data_end;
> > diff --git a/samples/bpf/xdp_redirect_map_multi.bpf.c b/samples/bpf/xdp=
_redirect_map_multi.bpf.c
> > index bb0a5a3bfcf0..8b2fd4ec2c76 100644
> > --- a/samples/bpf/xdp_redirect_map_multi.bpf.c
> > +++ b/samples/bpf/xdp_redirect_map_multi.bpf.c
> > @@ -53,7 +53,7 @@ int xdp_redirect_map_native(struct xdp_md *ctx)
> >       return xdp_redirect_map(ctx, &forward_map_native);
> >  }
> >
> > -SEC("xdp_devmap/egress")
> > +SEC("xdp/devmap")
> >  int xdp_devmap_prog(struct xdp_md *ctx)
> >  {
> >       void *data_end =3D (void *)(long)ctx->data_end;
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4ce94f4ed34a..1d97bc346be6 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -237,6 +237,8 @@ enum sec_def_flags {
> >       SEC_SLOPPY_PFX =3D 16,
> >       /* BPF program support non-linear XDP buffer */
> >       SEC_XDP_FRAGS =3D 32,
> > +     /* deprecated sec definitions not supposed to be used */
> > +     SEC_DEPRECATED =3D 64,
> >  };
> >
> >  struct bpf_sec_def {
> > @@ -6575,6 +6577,10 @@ static int libbpf_preload_prog(struct bpf_progra=
m *prog,
> >       if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
> >               opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> >
> > +     if (def & SEC_DEPRECATED)
> > +             pr_warn("sec '%s' is deprecated, please use new version i=
nstead\n",
> > +                     prog->sec_name);
> > +
>
> How is the user supposed to figure out what "the new version" is?


Let's add the section to
https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide and
link to it from the deprecation warning.

>
> -Toke
>
