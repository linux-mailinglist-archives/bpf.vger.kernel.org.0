Return-Path: <bpf+bounces-4038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E017C74819E
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F21C20ADC
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670F4C95;
	Wed,  5 Jul 2023 10:02:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678514A2C
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:02:02 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312511B2;
	Wed,  5 Jul 2023 03:02:00 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-635eb5b0320so47745026d6.3;
        Wed, 05 Jul 2023 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688551319; x=1691143319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEhX0BTKyXMaBqR4vKrukAC5S55tdlPlLD+KQ2fUOZc=;
        b=agQokwA5H9mhZhWUoWMyrqCFodXRO0J3LPnBaBwC8FoWDkx56MpzaAfBPISaTCJV57
         M8Q+8m/PcnLUxDzIEmVPGzA+8GndP71sMq4wmE/PvUDVjb83cG0+iZdTgY1I5Bs9KToX
         4WhC8neur7t14EeYVgaCkqzA6AiSjpFeZiczNGudtP7+t5VsE7/Qc/JtOUVC0A9xniDf
         MoO3T2IhOqDdjDWJd965QIaoTrNOzXVCvzVlVly5om8qqLZmmRKA69SMR1EYrEcmasjV
         luQ/hfrALauL1TJU+NrxicLLIuLpfm5PpFHmnk2X0aXpFjSPZCqG83GCpcsCuk53MDr0
         Qegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688551319; x=1691143319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEhX0BTKyXMaBqR4vKrukAC5S55tdlPlLD+KQ2fUOZc=;
        b=jcRNUqtEClYhs6yB/ARx7apksR0s0XypgLlSRPu3pYhkMEl8AM/P/n8Dr9r+GAfh+/
         dhja5ypWskfh4LHTvLfc8Yg2iYbDR5PKr5VmY14SbxMp/VKjEROZSg5ypmP4YkrSYXha
         TDehFLAtpokKLvycIAEZ8MtUAV11JgYlBHPnfxZ5scnMa9AhYep0DBNFvUboJMWmvq7j
         QdptmGGuioDSZnCzR6g1ZLr8DfH1mF9zjS00oeCkGUNCmJIwrjHMJGNufIDKCmqLlRcw
         I07ZHIveeNxsB5oQ7PMz2SM+gCoKVhuXvhKp5Uq8OzYeKUfE0LUcz7x8M+BC3grFGOJ/
         sZlw==
X-Gm-Message-State: ABy/qLa35C/MJ/bflhTZYcKc9UYGmRaHZnngr4fR6v27n7uqoH8B/Xoc
	5/e4Qh82XoL5rSNvFCmdTiQaaZTGdw5QK7G4+jE=
X-Google-Smtp-Source: APBJJlELziP6zwNIAfH6z1WgrsBMxbfTyCCyDyTCr+S6fkiudzGEOEsvoUnSLe/TvH2AcMhBdaOGcM81Sng0uIWW46k=
X-Received: by 2002:a05:6214:212d:b0:5ef:46a9:15d2 with SMTP id
 r13-20020a056214212d00b005ef46a915d2mr21653458qvc.7.1688551319293; Wed, 05
 Jul 2023 03:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-7-laoar.shao@gmail.com>
 <a9170c05-4d32-beda-95a6-b8c4c39438ae@iogearbox.net>
In-Reply-To: <a9170c05-4d32-beda-95a6-b8c4c39438ae@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 5 Jul 2023 18:01:23 +0800
Message-ID: <CALOAHbAVuXC9xj14JoXge6e2taRU80_KBG2o9mwgps-y5TnVqA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 06/11] bpf: Expose symbol's respective address
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 4:26=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 6/28/23 1:53 PM, Yafang Shao wrote:
> > Since different symbols can share the same name, it is insufficient to =
only
> > expose the symbol name. It is essential to also expose the symbol addre=
ss
> > so that users can accurately identify which one is being probed.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   kernel/trace/trace_kprobe.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index e4554dbfd113..17e17298e894 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1547,15 +1547,15 @@ int bpf_get_kprobe_info(const struct perf_event=
 *event, u32 *fd_type,
> >       if (tk->symbol) {
> >               *symbol =3D tk->symbol;
> >               *probe_offset =3D tk->rp.kp.offset;
> > -             *probe_addr =3D 0;
> >       } else {
> >               *symbol =3D NULL;
> >               *probe_offset =3D 0;
> > -             if (kallsyms_show_value(current_cred()))
> > -                     *probe_addr =3D (unsigned long)tk->rp.kp.addr;
> > -             else
> > -                     *probe_addr =3D 0;
> >       }
> > +
> > +     if (kallsyms_show_value(current_cred()))
> > +             *probe_addr =3D (unsigned long)tk->rp.kp.addr;
> > +     else
> > +             *probe_addr =3D 0;
> >       return 0;
>
> Can't this be simplified further? If tk->symbol is NULL we assign NULL an=
yway:

Agree. Thanks.

>
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 1b3fa7b854aa..bf2872ca5aaf 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1544,15 +1544,10 @@ int bpf_get_kprobe_info(const struct perf_event *=
event, u32 *fd_type,
>
>          *fd_type =3D trace_kprobe_is_return(tk) ? BPF_FD_TYPE_KRETPROBE
>                                                : BPF_FD_TYPE_KPROBE;
> -       if (tk->symbol) {
> -               *symbol =3D tk->symbol;
> -               *probe_offset =3D tk->rp.kp.offset;
> -               *probe_addr =3D 0;
> -       } else {
> -               *symbol =3D NULL;
> -               *probe_offset =3D 0;
> -               *probe_addr =3D (unsigned long)tk->rp.kp.addr;
> -       }
> +       *probe_offset =3D tk->rp.kp.offset;
> +       *probe_addr =3D kallsyms_show_value(current_cred()) ?
> +                     (unsigned long)tk->rp.kp.addr : 0;
> +       *symbol =3D tk->symbol;
>          return 0;
>   }
>   #endif /* CONFIG_PERF_EVENTS */
>


--=20
Regards
Yafang

