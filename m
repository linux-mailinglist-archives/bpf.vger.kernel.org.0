Return-Path: <bpf+bounces-1770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33059721477
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 05:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29B51C20A9D
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 03:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C31C26;
	Sun,  4 Jun 2023 03:24:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F0B17F6
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 03:24:47 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCB8D3
	for <bpf@vger.kernel.org>; Sat,  3 Jun 2023 20:24:46 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6262be06e41so37108336d6.0
        for <bpf@vger.kernel.org>; Sat, 03 Jun 2023 20:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685849085; x=1688441085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lou1fAaObCbBalCYEzUsmfmJQBJKKKTYODkDOi2IXps=;
        b=WtZc3RQiPLPOw4XJ9lVmB7im7a9kkmFtVJqIn/UdMcfBaCZRMSzjQZ6ra/yG3ECCOk
         aLp6j91XzY1M6Q0yRiGyWI+92phVIfsZwjPtw8U3eVO3O/OTv7SfeCAEIiy5jZ6xZ8+2
         WJkR9d8Z5JC1lnrgRIq5y4ki8Tbvm4XOlYItjMgntYXdjkR8LtQJHRIcKBgOEwd+az6Z
         H62H7+fbO6nxDEZgVIbcgXs49G7EaCOg+NBrf/E1srgIY59Ai/wuJ45uBih0goFNYROR
         1nkmiefA2uv2woixKEle3N4JcT4kngqzWUxhaHfhnNrfnYkWzKNNuTR0fwkqhuxXIFPF
         ejHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685849085; x=1688441085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lou1fAaObCbBalCYEzUsmfmJQBJKKKTYODkDOi2IXps=;
        b=IGm09SgJU0eJui1kTvfz52f1pkAxZFb2bAJPcpliYpRl+SiSXUJHCFl+oskaOLgr28
         KWAgi1Vtue5NgvEqSD3ltFii+ykE3G1dSUCACQtR6BQ1aoYVyjRkkpnLx/gicEu+AHUn
         byzbjO5Dg9YXl+sJTgcfuGXZRuEMxz3SMvsuDK18GObcaPGXGrMPZOlwSiGY/UWodqVe
         b4oM8Rnssl2Z9PkGgna5BLzOpOlUJ9J/V/8qyJF5bU+w32Clvv8UvzRtqBBXV0GCHT5N
         q/d8K2ngaHFKf3jqoGGABrBE+zhlobYEMhdYkg4E+I1dyRpgtwcETcdWip/0Nn+MI448
         E4Sg==
X-Gm-Message-State: AC+VfDyCCXmvuBEAxX1Oyx21lDSusutwad0CT6VN8RLJOD9xY0iTng/X
	u2W3SQFgPfcOrhSEG4b3vAxtwt3KejJJzXnxr2A=
X-Google-Smtp-Source: ACHHUZ5Y+5BNCS0I5DHkXVivZ57xVv+s8vBCmppMDFfIBzVrFCzOaLaAugNiSZZGXhBzljhDSFkjuiUQqZP5Y9jkv6E=
X-Received: by 2002:a05:6214:5087:b0:626:1637:f58c with SMTP id
 kk7-20020a056214508700b006261637f58cmr3104525qvb.30.1685849085457; Sat, 03
 Jun 2023 20:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602085239.91138-1-laoar.shao@gmail.com> <20230602085239.91138-3-laoar.shao@gmail.com>
 <20230602203659.fzmvfjysdqdf7guq@MacBook-Pro-8.local>
In-Reply-To: <20230602203659.fzmvfjysdqdf7guq@MacBook-Pro-8.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 4 Jun 2023 11:24:09 +0800
Message-ID: <CALOAHbB-tAuxNJJMOz1vRCWAFfSbaf4FGrbKEcJVV+rubqtjKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpftool: Show probed function in
 kprobe_multi link info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 3, 2023 at 4:37=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 02, 2023 at 08:52:35AM +0000, Yafang Shao wrote:
> > Show the already expose kprobe_multi link info in bpftool. The result a=
s
> > follows,
> > $ tools/bpf/bpftool/bpftool link show
> > 1: kprobe_multi  prog 5
> >         func_cnt 4  addrs            symbols
> >                     ffffffffb4d465b0 schedule_timeout_interruptible
> >                     ffffffffb4d465f0 schedule_timeout_killable
> >                     ffffffffb4d46630 schedule_timeout_uninterruptible
> >                     ffffffffb4d46670 schedule_timeout_idle
> >         pids trace(8729)
> >
> > $ tools/bpf/bpftool/bpftool link show -j
> > [{"id":1,"type":"kprobe_multi","prog_id":5,"func_cnt":4,"addrs":[{"addr=
":18446744072448402864,"symbol":"schedule_timeout_interruptible"},{"addr":1=
8446744072448402928,"symbol":"schedule_timeout_killable"},{"addr":184467440=
72448402992,"symbol":"schedule_timeout_uninterruptible"},{"addr":1844674407=
2448403056,"symbol":"schedule_timeout_idle"}],"pids":[{"pid":8729,"comm":"t=
race"}]}]
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/bpf/bpftool/link.c | 94 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 94 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 2d78607..3b00c07 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -166,6 +166,57 @@ static int get_prog_info(int prog_id, struct bpf_p=
rog_info *info)
> >       return err;
> >  }
> >
> > +static int cmp_u64(const void *A, const void *B)
> > +{
> > +     const __u64 *a =3D A, *b =3D B;
> > +
> > +     return *a - *b;
> > +}
> > +
> > +static void kprobe_multi_print_plain(__u64 addr, char *sym, __u32 inde=
nt)
> > +{
> > +     printf("\n\t%*s  %0*llx %s", indent, "", 16, addr, sym);
> > +}
> > +
> > +static void kprobe_multi_print_json(__u64 addr, char *sym)
> > +{
> > +     jsonw_start_object(json_wtr);
> > +     jsonw_uint_field(json_wtr, "addr", addr);
> > +     jsonw_string_field(json_wtr, "symbol", sym);
> > +     jsonw_end_object(json_wtr);
> > +}
> > +
> > +static void kernel_syms_show(const __u64 *addrs, __u32 cnt, __u32 inde=
nt)
> > +{
> > +     char buff[256], sym[256];
> > +     __u64 addr;
> > +     int i =3D 0;
> > +     FILE *fp;
> > +
> > +     fp =3D fopen("/proc/kallsyms", "r");
> > +     if (!fp)
> > +             return;
> > +
> > +     /* Each address is guaranteed to be unique. */
> > +     qsort((void *)addrs, cnt, sizeof(__u64), cmp_u64);
> > +     /* The addresses in /proc/kallsyms are already sorted. */
> > +     while (fgets(buff, sizeof(buff), fp)) {
> > +             if (sscanf(buff, "%llx %*c %s", &addr, sym) !=3D 2)
> > +                     continue;
> > +             /* The addr probed by kprobe_multi is always in
> > +              * /proc/kallsyms, so we can ignore some edge cases.
> > +              */
> > +             if (addr !=3D addrs[i])
> > +                     continue;
> > +             if (indent)
> > +                     kprobe_multi_print_plain(addr, sym, indent);
> > +             else
> > +                     kprobe_multi_print_json(addr, sym);
> > +             i++;
> > +     }
> > +     fclose(fp);
>
> There is kernel_syms_load().
> Let's reuse it instead of reimplementing kallsysm parsing?

I will think about it. Thanks for your suggestion.

--=20
Regards
Yafang

