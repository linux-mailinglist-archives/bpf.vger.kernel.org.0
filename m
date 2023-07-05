Return-Path: <bpf+bounces-4041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376F57481C5
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B6A1C20A5A
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7351E539B;
	Wed,  5 Jul 2023 10:13:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430174C8F
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:13:39 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5458E122;
	Wed,  5 Jul 2023 03:13:37 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso2036136241.3;
        Wed, 05 Jul 2023 03:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688552016; x=1691144016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3OXLV7670HYbFkf4+KB0EvSTXTvzi9vkrfOeJXtwk8=;
        b=Xxek6sc/NJyTlF3gXjJlHpXbTOv5WDObTkrp1L72GHGwqCQ91s+iNu10nWq9pKcSd2
         FI2VjP02cd4AOa4bT3zrpT+qs1534bpAOtl55hdo6yFT+8WWunbEQeFjux8Zzv83aOoX
         73gvsaF5TSslUKpMquZKzg8KIYNGRGNysOy9Itl6Q0YhgsgaS3TNG5/lpy7blqIjcbqZ
         NzCG44gJimCpT4dMwF5bHDVKsN+/rcZUXO76UHNraikPm3EbQwbtdGDuu3/8QGGfb8Fn
         8SjUTRrSvtDLifbgdNmdi4Vh+3hv5QdHRk5SF4hdE3YKpYNg/0KSH6TVE1NVcAx9XHQL
         8HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552016; x=1691144016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3OXLV7670HYbFkf4+KB0EvSTXTvzi9vkrfOeJXtwk8=;
        b=EX0wFVwT5WItrcjku7pdpPtCaKVVAh+/xu3WHv0ZiZDP+hMC57maV9RykbPDAWqTVl
         opc1xhNCzHOwtpgwQJzJ2BvOCHVRdFBFkKp+fw4+ZS9d1rn/au9F4/Ruykp86CGhcQeR
         aMFtNxa/V4dETdr6uB5ewQHE7kNGXe5sEGZVHNPItTd9K82nKVnDleqG5EYfjA7HeuG7
         wcIwpZ8MgsljX6cINe2CBYRGNdOScJOFmpg+2M5NUYaIgV3niwKxiGAwz/0wDzriBKY/
         3WtPxDT3OBRtnfYZc4VJyoQIDT+N3MRsjOVhPpybdCYiLpfbZMrggoTVT8HJJ5547nZr
         uUiw==
X-Gm-Message-State: ABy/qLasMrV6MxqLZ5ewSS/huIuQKHNYIe29lJMtJG2ozoQV5Cr5RbDn
	gpCPPLwqFzuMT5ppO880h2D8vE7dZZ8ES+l4ehE=
X-Google-Smtp-Source: APBJJlFgCcXjnb9qP5+oYGH9SmBsr5No45+Ih/zpINS+pNNgixyvKCgP6MFh2b/OAOqEy+8ofbZ76oGFqggYNqJLv7Q=
X-Received: by 2002:a67:fe07:0:b0:440:dd8e:2aa3 with SMTP id
 l7-20020a67fe07000000b00440dd8e2aa3mr5265376vsr.35.1688552016369; Wed, 05 Jul
 2023 03:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-12-laoar.shao@gmail.com>
 <d991de64-ebdd-bb65-482a-aae64459c739@iogearbox.net>
In-Reply-To: <d991de64-ebdd-bb65-482a-aae64459c739@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 5 Jul 2023 18:13:00 +0800
Message-ID: <CALOAHbBSjzaWrTRKh6fuxL-bpNWYAuojpfoYx4FGa8Lb1i9W+w@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 11/11] bpftool: Show perf link info
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

On Wed, Jul 5, 2023 at 4:54=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 6/28/23 1:53 PM, Yafang Shao wrote:
> [...]
> > +
> > +static void
> > +show_perf_event_event_json(struct bpf_link_info *info, json_writer_t *=
wtr)
> > +{
> > +     __u64 config =3D info->perf_event.event.config;
> > +     __u32 type =3D info->perf_event.event.type;
> > +     const char *perf_type, *perf_config;
> > +
> > +     perf_type =3D perf_event_name(perf_type_name, type);
> > +     if (perf_type)
> > +             jsonw_string_field(wtr, "event_type", perf_type);
> > +     else
> > +             jsonw_uint_field(wtr, "event_type", type);
> > +
> > +     perf_config =3D perf_config_str(type, config);
> > +     if (perf_config)
> > +             jsonw_string_field(wtr, "event_config", perf_config);
> > +     else
> > +             jsonw_uint_field(wtr, "event_config", config);
> > +
> > +     if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
> > +             free((void *)perf_config);
>
> nit no need to cast

It will discard the 'const', so we have to do the cast here, otherwise
the compiler will complain.

>
> > +}
> > +
> >   static int show_link_close_json(int fd, struct bpf_link_info *info)
> >   {
> >       struct bpf_prog_info prog_info;
> > @@ -334,6 +440,26 @@ static int show_link_close_json(int fd, struct bpf=
_link_info *info)
> >       case BPF_LINK_TYPE_KPROBE_MULTI:
> >               show_kprobe_multi_json(info, json_wtr);
> >               break;
> > +     case BPF_LINK_TYPE_PERF_EVENT:
> > +             switch (info->perf_event.type) {
> > +             case BPF_PERF_EVENT_EVENT:
> > +                     show_perf_event_event_json(info, json_wtr);
> > +                     break;
> > +             case BPF_PERF_EVENT_TRACEPOINT:
> > +                     show_perf_event_tracepoint_json(info, json_wtr);
> > +                     break;
> > +             case BPF_PERF_EVENT_KPROBE:
> > +             case BPF_PERF_EVENT_KRETPROBE:
> > +                     show_perf_event_kprobe_json(info, json_wtr);
> > +                     break;
> > +             case BPF_PERF_EVENT_UPROBE:
> > +             case BPF_PERF_EVENT_URETPROBE:
> > +                     show_perf_event_uprobe_json(info, json_wtr);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -505,6 +631,75 @@ static void show_kprobe_multi_plain(struct bpf_lin=
k_info *info)
> >       }
> >   }
> >
> > +static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
> > +{
> > +     const char *buf;
> > +
> > +     buf =3D (const char *)u64_to_ptr(info->perf_event.kprobe.func_nam=
e);
>
> ditto, same for the other occurrences further below

Agree.

>
> > +     if (buf[0] =3D=3D '\0' && !info->perf_event.kprobe.addr)
> > +             return;
> > +
> > +     if (info->perf_event.type =3D=3D BPF_PERF_EVENT_KRETPROBE)
> > +             printf("\n\tkretprobe ");
> > +     else
> > +             printf("\n\tkprobe ");
> > +     if (info->perf_event.kprobe.addr)
> > +             printf("%llx ", info->perf_event.kprobe.addr);
> > +     printf("%s", buf);
> > +     if (info->perf_event.kprobe.offset)
> > +             printf("+%#x", info->perf_event.kprobe.offset);
> > +     printf("  ");
> > +}
> > +
> > +static void show_perf_event_uprobe_plain(struct bpf_link_info *info)
> > +{
> > +     const char *buf;
> > +
> > +     buf =3D (const char *)u64_to_ptr(info->perf_event.uprobe.file_nam=
e);
> > +     if (buf[0] =3D=3D '\0')
> > +             return;
> > +
> > +     if (info->perf_event.type =3D=3D BPF_PERF_EVENT_URETPROBE)
> > +             printf("\n\turetprobe ");
> > +     else
> > +             printf("\n\tuprobe ");
> > +     printf("%s+%#x  ", buf, info->perf_event.uprobe.offset);
> > +}
> > +
> > +static void show_perf_event_tracepoint_plain(struct bpf_link_info *inf=
o)
> > +{
> > +     const char *buf;
> > +
> > +     buf =3D (const char *)u64_to_ptr(info->perf_event.tracepoint.tp_n=
ame);
> > +     if (buf[0] =3D=3D '\0')
> > +             return;
> > +
> > +     printf("\n\ttracepoint %s  ", buf);
> > +}
> > +
> > +static void show_perf_event_event_plain(struct bpf_link_info *info)
> > +{
> > +     __u64 config =3D info->perf_event.event.config;
> > +     __u32 type =3D info->perf_event.event.type;
> > +     const char *perf_type, *perf_config;
> > +
> > +     printf("\n\tevent ");
> > +     perf_type =3D perf_event_name(perf_type_name, type);
> > +     if (perf_type)
> > +             printf("%s:", perf_type);
> > +     else
> > +             printf("%u :", type);
> > +
> > +     perf_config =3D perf_config_str(type, config);
> > +     if (perf_config)
> > +             printf("%s  ", perf_config);
> > +     else
> > +             printf("%llu  ", config);
> > +
> > +     if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
> > +             free((void *)perf_config);
>
> same
>
> > +}
> > +
> >   static int show_link_close_plain(int fd, struct bpf_link_info *info)
> >   {
> >       struct bpf_prog_info prog_info;
> > @@ -553,6 +748,26 @@ static int show_link_close_plain(int fd, struct bp=
f_link_info *info)
> >       case BPF_LINK_TYPE_KPROBE_MULTI:
> >               show_kprobe_multi_plain(info);
> >               break;
> > +     case BPF_LINK_TYPE_PERF_EVENT:
> > +             switch (info->perf_event.type) {
> > +             case BPF_PERF_EVENT_EVENT:
> > +                     show_perf_event_event_plain(info);
> > +                     break;
> > +             case BPF_PERF_EVENT_TRACEPOINT:
> > +                     show_perf_event_tracepoint_plain(info);
> > +                     break;
> > +             case BPF_PERF_EVENT_KPROBE:
> > +             case BPF_PERF_EVENT_KRETPROBE:
> > +                     show_perf_event_kprobe_plain(info);
> > +                     break;
> > +             case BPF_PERF_EVENT_UPROBE:
> > +             case BPF_PERF_EVENT_URETPROBE:
> > +                     show_perf_event_uprobe_plain(info);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -575,11 +790,12 @@ static int do_show_link(int fd)
> >       struct bpf_link_info info;
> >       __u32 len =3D sizeof(info);
> >       __u64 *addrs =3D NULL;
> > -     char buf[256];
> > +     char buf[PATH_MAX];
> >       int count;
> >       int err;
> >
> >       memset(&info, 0, sizeof(info));
> > +     buf[0] =3D '\0';
> >   again:
> >       err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> >       if (err) {
> > @@ -614,6 +830,35 @@ static int do_show_link(int fd)
> >                       goto again;
> >               }
> >       }
> > +     if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
> > +             switch (info.perf_event.type) {
> > +             case BPF_PERF_EVENT_TRACEPOINT:
> > +                     if (!info.perf_event.tracepoint.tp_name) {
> > +                             info.perf_event.tracepoint.tp_name =3D (u=
nsigned long)&buf;
>
> lets use ptr_to_u64() in all these cases

Agree.

>
> > +                             info.perf_event.tracepoint.name_len =3D s=
izeof(buf);
> > +                             goto again;
> > +                     }
> > +                     break;
> > +             case BPF_PERF_EVENT_KPROBE:
> > +             case BPF_PERF_EVENT_KRETPROBE:
> > +                     if (!info.perf_event.kprobe.func_name) {
> > +                             info.perf_event.kprobe.func_name =3D (uns=
igned long)&buf;
> > +                             info.perf_event.kprobe.name_len =3D sizeo=
f(buf);
> > +                             goto again;
> > +                     }
> > +                     break;
> > +             case BPF_PERF_EVENT_UPROBE:
> > +             case BPF_PERF_EVENT_URETPROBE:
> > +                     if (!info.perf_event.uprobe.file_name) {
> > +                             info.perf_event.uprobe.file_name =3D (uns=
igned long)&buf;
> > +                             info.perf_event.uprobe.name_len =3D sizeo=
f(buf);
> > +                             goto again;
> > +                     }
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +     }
> >
> >       if (json_output)
> >               show_link_close_json(fd, &info);
> >
>


--=20
Regards
Yafang

