Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392F749668F
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 21:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiAUUpP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 15:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiAUUpP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 15:45:15 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18038C06173D
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 12:45:14 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id d13so1870870ljl.5
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 12:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hqWL/nHYnUBO+Ln1N3+JmH4jOEi3UlJnxazuE/NF8h0=;
        b=VY7zjbOdtIGBRC8Jsf7LYuzWSMI63i9iqt2wn2NVA1BS4pUdJja02DAgATa7EXKNVC
         59bMzMflXqqF1sasaJninuhXRFznZfDm4bu8Y37ORwQ/lq9pumRqQDUhcuTufCZtTXKn
         dwZhMrTIyJvqfwdOjl2px+JzJmQ+KQThwRsbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hqWL/nHYnUBO+Ln1N3+JmH4jOEi3UlJnxazuE/NF8h0=;
        b=WsxyDlNcF6y5GRFBh9u9i52BKF2i7v05QPn5rzoRmeo1O7RwpxHsbCPYDh2NV/V5Me
         6VGv7kJTLOTEGML1vanG8+UGXkL11C80WnyaMxwO6AjbQvANnwC3WqwDdnkdbqgl0Y41
         X47LZpF3ew+tsEYAw+wCV84tJQze8mcRBapY5vvuIiRqZiPvPZ9sgEZ8qJlFxP0mORFc
         Wm4lvRhaBg0buwGijhtnFOSwPrgIvk9wJ6zQV9IZCA6smsHt+lGK3D3d44V4S0Fn+hft
         eA1By6R4RGyjhFpfwvUN08gPPv/dENgt54JULW8quiE3bJGORR/Axz0zl4CBHFMmOgjs
         3Ujg==
X-Gm-Message-State: AOAM531SleNgLrEPKeGvXuum6wHOD+5e1uEPtsRZ2WbcxnMwZAyrV/X6
        96ZpSocS7GC3Q6hRuWRMhyS4TC/VdpOyHIdn5YzEGg==
X-Google-Smtp-Source: ABdhPJwOmghXusPS8BhldNXanor5xsas/PN+2MQZSq3Zr9ecOZwNDUhzQLHG09Xt1FLhQMwoZnJqyyLwGeQxktkybpM=
X-Received: by 2002:a2e:9bce:: with SMTP id w14mr4385061ljj.110.1642797905119;
 Fri, 21 Jan 2022 12:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20220112142709.102423-1-mauricio@kinvolk.io> <20220112142709.102423-3-mauricio@kinvolk.io>
 <c1d96b78-5eda-6999-bd22-55514f4900dc@isovalent.com>
In-Reply-To: <c1d96b78-5eda-6999-bd22-55514f4900dc@isovalent.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Fri, 21 Jan 2022 15:44:54 -0500
Message-ID: <CAHap4zsBxGCCZvzVNRV5mSSaggQDM2h5Fem38tZp7Fn2gsrdhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/8] libbpf: Implement changes needed for
 BTFGen in bpftool
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 12, 2022 at 1:08 PM Quentin Monnet <quentin@isovalent.com> wrot=
e:
>
> 2022-01-12 09:27 UTC-0500 ~ Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> > This commit extends libbpf with the features that are needed to
> > implement BTFGen:
> >
> > - Implement bpf_core_create_cand_cache() and bpf_core_free_cand_cache()
> > to handle candidates cache.
> > - Expose bpf_core_add_cands() and bpf_core_free_cands to handle
> > candidates list.
> > - Expose bpf_core_calc_relo_insn() to bpftool.
> >
> > Signed-off-by: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> > Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> > Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> > Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> > ---
> >  tools/lib/bpf/Makefile          |  2 +-
> >  tools/lib/bpf/libbpf.c          | 43 +++++++++++++++++++++------------
> >  tools/lib/bpf/libbpf_internal.h | 12 +++++++++
> >  3 files changed, 41 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> > index f947b61b2107..dba019ee2832 100644
> > --- a/tools/lib/bpf/Makefile
> > +++ b/tools/lib/bpf/Makefile
> > @@ -239,7 +239,7 @@ install_lib: all_cmd
> >
> >  SRC_HDRS :=3D bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk=
.h            \
> >           bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h     =
    \
> > -         skel_internal.h libbpf_version.h
> > +         skel_internal.h libbpf_version.h relo_core.h libbpf_internal.=
h
> >  GEN_HDRS :=3D $(BPF_GENERATED)
>
> I don't think these headers should be added to libbpf's SRC_HDRS. If we
> must make them available to bpftool, we probably want to copy them
> explicitly through LIBBPF_INTERNAL_HDRS in bpftool's Makefile.

I got confused, thanks for catching this up!
