Return-Path: <bpf+bounces-2517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB572E6C6
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E65C1C20C89
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C283AE76;
	Tue, 13 Jun 2023 15:12:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B235E23DB
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:12:17 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A63C101;
	Tue, 13 Jun 2023 08:12:13 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75d461874f4so105011685a.0;
        Tue, 13 Jun 2023 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686669132; x=1689261132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMmcV/sMZgGZK8fGDZdNFZHyX+z1VL9htd4ZpnT2X6I=;
        b=lwpP9fugtHIPeE2qAsFLusRqbmMiGpREe9OQj4y8JD3dq+178bClzrEEUmwTqU0yYD
         EKjxdQ7kpUkhdyII+tULpRyxC9b+g8jQ1EwMOtaJBE/FB3ddyoGKylEZtSwCpzuj9JMu
         +XRpq49LNKxNac2t/RXSl4pnsx1z0TRzJYt9wrcJBRhhhxupUHuygqrD47BqLp28HFve
         StkYJJUmD3GuK+9xwsej7uO5kiclyAqK956k9cVadE9Ox1Ls7uv7CbKx4aUnd6mf+0po
         N01WkzKEI3AyCNhl81g5IenaXkQa81FP3k7QjjEEamWZtlDTDrjBgwPWAwzTQtMl0Flz
         ICmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686669132; x=1689261132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMmcV/sMZgGZK8fGDZdNFZHyX+z1VL9htd4ZpnT2X6I=;
        b=gko6OFD8wAwlC0+mbGTe3F1/lkwjX4oTvFtYTp9szLLmCqQ+9EZ7imHFTRbkA36pDS
         1iSjxR1YtR4ojDYB6JGLAJTdNnjXcTxjZRMxkcL+Lv5ZzcnTn0LDB4uud+ab9jGlmEVO
         8U1L6j/tQcMpINugh3CQPqpcpU4onwPqFx2gA170RbBniDuUQytyoaMpRiYTsG8+jatv
         9aOQ3Ff84ZR2DlX8zTzGg+b0Hz3dso8drtxGii1dUsefC5tSG+n1FseZxLv8HHWSk2SE
         wCnfjCORgcr+yEssB21RR1VHgIViuI8/fRk605lgZ6YB8bMldYYmaKIcfOc++lfS5cK9
         E6+w==
X-Gm-Message-State: AC+VfDxdNW+y+JMIgDPZ9AoPGBVWRziCb5/WQpbNve66SffQQ1fXmYo7
	FkeQxR1Ctp/VxxK2vrdM4QSE6yUDFjE8mtYvNlA=
X-Google-Smtp-Source: ACHHUZ4WdE1tMGT1YcAPDK7+KsJpmygEl3hyWyMwtwMWhcTT0XE+7cqVwO8yJLSp5ZHObgVGt0uD6t9x3KQ/v4QAGaQ=
X-Received: by 2002:a05:6214:b6a:b0:62b:53b0:70b0 with SMTP id
 ey10-20020a0562140b6a00b0062b53b070b0mr8908092qvb.31.1686669132088; Tue, 13
 Jun 2023 08:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-11-laoar.shao@gmail.com>
 <98bd7ece-2058-d4bf-dab9-fc566eb655b3@isovalent.com>
In-Reply-To: <98bd7ece-2058-d4bf-dab9-fc566eb655b3@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 13 Jun 2023 23:11:23 +0800
Message-ID: <CALOAHbApU8HwhsU77mMEx0vx0kHSwCmZaiJ7kQ_UMsG48--wwQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/10] bpftool: Show probed function in
 perf_event link info
To: Quentin Monnet <quentin@isovalent.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
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

On Tue, Jun 13, 2023 at 9:42=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-06-12 15:16 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> > Enhance bpftool to display comprehensive information about exposed
> > perf_event links, covering uprobe, kprobe, tracepoint, and generic perf
> > event. The resulting output will include the following details:
> >
> > $ tools/bpf/bpftool/bpftool link show
> > 3: perf_event  prog 14
> >         event_type software  event_config cpu-clock
> >         bpf_cookie 0
> >         pids perf_event(1379330)
> > 4: perf_event  prog 14
> >         event_type hw-cache  event_config LLC-load-misses
> >         bpf_cookie 0
> >         pids perf_event(1379330)
> > 5: perf_event  prog 14
> >         event_type hardware  event_config cpu-cycles
> >         bpf_cookie 0
> >         pids perf_event(1379330)
> > 6: perf_event  prog 20
> >         retprobe 0  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1=
338
> >         bpf_cookie 0
> >         pids uprobe(1379706)
> > 7: perf_event  prog 21
> >         retprobe 1  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1=
338
> >         bpf_cookie 0
> >         pids uprobe(1379706)
> > 8: perf_event  prog 27
> >         tp_name sched_switch
> >         bpf_cookie 0
> >         pids tracepoint(1381734)
> > 10: perf_event  prog 43
> >         retprobe 0  func_name kernel_clone  addr ffffffffad0a9660
>
> Could we swap the name and the address, for consistency with the
> kprobe_multi case?

Agree. Will change it.

>
> Also do we really need the "_name" suffix in "func_name" and "file_name"
> for plain output? I don't mind in JSON, but I think the result is a bit
> long for plain output.

They are really a bit long. Will remove the "_name" suffix.

>
> >         bpf_cookie 0
> >         pids kprobe(1384186)
> > 11: perf_event  prog 41
> >         retprobe 1  func_name kernel_clone  addr ffffffffad0a9660
> >         bpf_cookie 0
> >         pids kprobe(1384186)
> >
> > $ tools/bpf/bpftool/bpftool link show -j
> > [{"id":3,"type":"perf_event","prog_id":14,"event_type":"software","even=
t_config":"cpu-clock","bpf_cookie":0,"pids":[{"pid":1379330,"comm":"perf_ev=
ent"}]},{"id":4,"type":"perf_event","prog_id":14,"event_type":"hw-cache","e=
vent_config":"LLC-load-misses","bpf_cookie":0,"pids":[{"pid":1379330,"comm"=
:"perf_event"}]},{"id":5,"type":"perf_event","prog_id":14,"event_type":"har=
dware","event_config":"cpu-cycles","bpf_cookie":0,"pids":[{"pid":1379330,"c=
omm":"perf_event"}]},{"id":6,"type":"perf_event","prog_id":20,"retprobe":0,=
"file_name":"/home/yafang/bpf/uprobe/a.out","offset":4920,"bpf_cookie":0,"p=
ids":[{"pid":1379706,"comm":"uprobe"}]},{"id":7,"type":"perf_event","prog_i=
d":21,"retprobe":1,"file_name":"/home/yafang/bpf/uprobe/a.out","offset":492=
0,"bpf_cookie":0,"pids":[{"pid":1379706,"comm":"uprobe"}]},{"id":8,"type":"=
perf_event","prog_id":27,"tp_name":"sched_switch","bpf_cookie":0,"pids":[{"=
pid":1381734,"comm":"tracepoint"}]},{"id":10,"type":"perf_event","prog_id":=
43,"retprobe":0,"func_name":"kernel_clone","offset":0,"addr":18446744072317=
736544,"bpf_cookie":0,"pids":[{"pid":1384186,"comm":"kprobe"}]},{"id":11,"t=
ype":"perf_event","prog_id":41,"retprobe":1,"func_name":"kernel_clone","off=
set":0,"addr":18446744072317736544,"bpf_cookie":0,"pids":[{"pid":1384186,"c=
omm":"kprobe"}]}]
> >
> > For generic perf events, the displayed information in bpftool is limite=
d to
> > the type and configuration, while other attributes such as sample_perio=
d,
> > sample_freq, etc., are not included.
> >
> > The kernel function address won't be exposed if it is not permitted by
> > kptr_restrict. The result as follows when kptr_restrict is 2.
> >
> > $ tools/bpf/bpftool/bpftool link show
> > 3: perf_event  prog 14
> >         event_type software  event_config cpu-clock
> > 4: perf_event  prog 14
> >         event_type hw-cache  event_config LLC-load-misses
> > 5: perf_event  prog 14
> >         event_type hardware  event_config cpu-cycles
> > 6: perf_event  prog 20
> >         retprobe 0  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1=
338
> > 7: perf_event  prog 21
> >         retprobe 1  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1=
338
> > 8: perf_event  prog 27
> >         tp_name sched_switch
> > 10: perf_event  prog 43
> >         retprobe 0  func_name kernel_clone
> > 11: perf_event  prog 41
> >         retprobe 1  func_name kernel_clone
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/bpf/bpftool/link.c | 213 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 213 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 0015582..c16f71d 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -15,6 +15,7 @@
> >  #include "json_writer.h"
> >  #include "main.h"
> >  #include "xlated_dumper.h"
> > +#include "perf.h"
> >
> >  static struct hashmap *link_table;
> >  static struct dump_data dd =3D {};
> > @@ -207,6 +208,109 @@ static int cmp_u64(const void *A, const void *B)
> >       jsonw_end_array(json_wtr);
> >  }
> >
> > +static void
> > +show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t =
*wtr)
> > +{
> > +     jsonw_uint_field(wtr, "retprobe", info->kprobe.flags & 0x1);
>
> "retprobe" should likely be a boolean here too (and below), I don't see
> them taking any other values than 0 or 1?

Right. Should use boolean instead.

>
> > +     jsonw_string_field(wtr, "func_name",
> > +                        u64_to_ptr(info->kprobe.func_name));
> > +     jsonw_uint_field(wtr, "offset", info->kprobe.offset);
> > +     jsonw_uint_field(wtr, "addr", info->kprobe.addr);
> > +}
> > +
> > +static void
> > +show_perf_event_uprobe_json(struct bpf_link_info *info, json_writer_t =
*wtr)
> > +{
> > +     jsonw_uint_field(wtr, "retprobe", info->uprobe.flags & 0x1);
> > +     jsonw_string_field(wtr, "file_name",
> > +                        u64_to_ptr(info->uprobe.file_name));
> > +     jsonw_uint_field(wtr, "offset", info->uprobe.offset);
> > +}
> > +
> > +static void
> > +show_perf_event_tp_json(struct bpf_link_info *info, json_writer_t *wtr=
)
> > +{
> > +     jsonw_string_field(wtr, "tp_name",
> > +                        u64_to_ptr(info->tracepoint.tp_name));
> > +}
> > +
> > +static const char *perf_config_hw_cache_str(__u64 config)
>
> The returned "str" is not a "const char *"? Why not simply a "char *"
> and avoiding the cast when we free() it?

Good point. Will change it.

>
> > +{
> > +#define PERF_HW_CACHE_LEN 128
>
> Let's move the #define to the top of the file, please.

Agree.

>
> > +     const char *hw_cache, *result, *op;
> > +     char *str =3D malloc(PERF_HW_CACHE_LEN);
> > +
> > +     if (!str) {
> > +             p_err("mem alloc failed");
> > +             return NULL;
> > +     }
> > +     hw_cache =3D perf_hw_cache_str(config & 0xff);
> > +     if (hw_cache)
> > +             snprintf(str, PERF_HW_CACHE_LEN, "%s-", hw_cache);
> > +     else
> > +             snprintf(str, PERF_HW_CACHE_LEN, "%lld-", config & 0xff);
> > +     op =3D perf_hw_cache_op_str((config >> 8) & 0xff);
> > +     if (op)
> > +             snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(st=
r),
> > +                      "%s-", op);
> > +     else
> > +             snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(st=
r),
> > +                      "%lld-", (config >> 8) & 0xff);
> > +     result =3D perf_hw_cache_op_result_str(config >> 16);
> > +     if (result)
> > +             snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(st=
r),
> > +                      "%s", result);
> > +     else
> > +             snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(st=
r),
> > +                      "%lld", config >> 16);
> > +
> > +     return str;
> > +}
> > +
> > +static const char *perf_config_str(__u32 type, __u64 config)
> > +{
> > +     const char *perf_config;
> > +
> > +     switch (type) {
> > +     case PERF_TYPE_HARDWARE:
> > +             perf_config =3D perf_hw_str(config);
> > +             break;
> > +     case PERF_TYPE_SOFTWARE:
> > +             perf_config =3D perf_sw_str(config);
> > +             break;
> > +     case PERF_TYPE_HW_CACHE:
> > +             perf_config =3D perf_config_hw_cache_str(config);
> > +             break;
> > +     default:
> > +             perf_config =3D NULL;
> > +             break;
> > +     }
> > +     return perf_config;
> > +}
> > +
> > +static void
> > +show_perf_event_event_json(struct bpf_link_info *info, json_writer_t *=
wtr)
> > +{
> > +     __u64 config =3D info->perf_event.config;
> > +     __u32 type =3D info->perf_event.type;
> > +     const char *perf_type, *perf_config;
> > +
> > +     perf_type =3D perf_type_str(type);
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
> > +}
> > +
> >  static int show_link_close_json(int fd, struct bpf_link_info *info)
> >  {
> >       struct bpf_prog_info prog_info;
> > @@ -262,6 +366,16 @@ static int show_link_close_json(int fd, struct bpf=
_link_info *info)
> >       case BPF_LINK_TYPE_KPROBE_MULTI:
> >               show_kprobe_multi_json(info, json_wtr);
> >               break;
> > +     case BPF_LINK_TYPE_PERF_EVENT:
> > +             if (info->perf_link_type =3D=3D BPF_PERF_LINK_PERF_EVENT)
> > +                     show_perf_event_event_json(info, json_wtr);
> > +             else if (info->perf_link_type =3D=3D BPF_PERF_LINK_TRACEP=
OINT)
> > +                     show_perf_event_tp_json(info, json_wtr);
> > +             else if (info->perf_link_type =3D=3D BPF_PERF_LINK_KPROBE=
)
> > +                     show_perf_event_kprobe_json(info, json_wtr);
> > +             else if (info->perf_link_type =3D=3D BPF_PERF_LINK_UPROBE=
)
> > +                     show_perf_event_uprobe_json(info, json_wtr);
>
> It would be clearer to me with another switch/case I think (same for
> plain output), but I don't mind much.

Agree. Will use switch-case instead.

>
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -433,6 +547,71 @@ static void show_kprobe_multi_plain(struct bpf_lin=
k_info *info)
> >       }
> >  }
> >
> > +static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
> > +{
> > +     const char *buf;
> > +     __u32 retprobe;
> > +
> > +     buf =3D (const char *)u64_to_ptr(info->kprobe.func_name);
> > +     if (buf[0] =3D=3D '\0' && !info->kprobe.addr)
> > +             return;
> > +
> > +     retprobe =3D info->kprobe.flags & 0x1;
> > +     printf("\n\tretprobe %u  func_name %s  ", retprobe, buf);
> > +     if (info->kprobe.offset)
> > +             printf("offset %#x  ", info->kprobe.offset);
> > +     if (info->kprobe.addr)
> > +             printf("addr %llx  ", info->kprobe.addr);
> > +}
> > +
> > +static void show_perf_event_uprobe_plain(struct bpf_link_info *info)
> > +{
> > +     const char *buf;
> > +     __u32 retprobe;
> > +
> > +     buf =3D (const char *)u64_to_ptr(info->uprobe.file_name);
> > +     if (buf[0] =3D=3D '\0')
> > +             return;
> > +
> > +     retprobe =3D info->uprobe.flags & 0x1;
> > +     printf("\n\tretprobe %u  file_name %s  ", retprobe, buf);
> > +     if (info->uprobe.offset)
> > +             printf("offset %#x  ", info->kprobe.offset);
> > +}
> > +
> > +static void show_perf_event_tp_plain(struct bpf_link_info *info)
> > +{
> > +     const char *buf;
> > +
> > +     buf =3D (const char *)u64_to_ptr(info->tracepoint.tp_name);
> > +     if (buf[0] =3D=3D '\0')
> > +             return;
> > +
> > +     printf("\n\ttp_name %s  ", buf);
> > +}
> > +
> > +static void show_perf_event_event_plain(struct bpf_link_info *info)
> > +{
> > +     __u64 config =3D info->perf_event.config;
> > +     __u32 type =3D info->perf_event.type;
> > +     const char *perf_type, *perf_config;
> > +
> > +     perf_type =3D perf_type_str(type);
> > +     if (perf_type)
> > +             printf("\n\tevent_type %s  ", perf_type);
> > +     else
> > +             printf("\n\tevent_type %u  ", type);
> > +
> > +     perf_config =3D perf_config_str(type, config);
> > +     if (perf_config)
> > +             printf("event_config %s  ", perf_config);
> > +     else
> > +             printf("event_config %llu  ", config);
> > +
> > +     if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
> > +             free((void *)perf_config);
> > +}
> > +
> >  static int show_link_close_plain(int fd, struct bpf_link_info *info)
> >  {
> >       struct bpf_prog_info prog_info;
> > @@ -481,6 +660,16 @@ static int show_link_close_plain(int fd, struct bp=
f_link_info *info)
> >       case BPF_LINK_TYPE_KPROBE_MULTI:
> >               show_kprobe_multi_plain(info);
> >               break;
> > +     case BPF_LINK_TYPE_PERF_EVENT:
> > +             if (info->perf_link_type =3D=3D BPF_PERF_LINK_PERF_EVENT)
> > +                     show_perf_event_event_plain(info);
> > +             else if (info->perf_link_type =3D=3D BPF_PERF_LINK_TRACEP=
OINT)
> > +                     show_perf_event_tp_plain(info);
> > +             else if (info->perf_link_type =3D=3D BPF_PERF_LINK_KPROBE=
)
> > +                     show_perf_event_kprobe_plain(info);
> > +             else if (info->perf_link_type =3D=3D BPF_PERF_LINK_UPROBE=
)
> > +                     show_perf_event_uprobe_plain(info);
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -508,6 +697,7 @@ static int do_show_link(int fd)
> >       int err;
> >
> >       memset(&info, 0, sizeof(info));
> > +     buf[0] =3D '\0';
> >  again:
> >       err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> >       if (err) {
> > @@ -542,7 +732,30 @@ static int do_show_link(int fd)
> >                       goto again;
> >               }
> >       }
> > +     if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
> > +             if (info.perf_link_type =3D=3D BPF_PERF_LINK_PERF_EVENT)
> > +                     goto out;
> > +             if (info.perf_link_type =3D=3D BPF_PERF_LINK_TRACEPOINT &=
&
> > +                 !info.tracepoint.tp_name) {
> > +                     info.tracepoint.tp_name =3D (unsigned long)&buf;
> > +                     info.tracepoint.name_len =3D sizeof(buf);
> > +                     goto again;
> > +             }
> > +             if (info.perf_link_type =3D=3D BPF_PERF_LINK_KPROBE &&
> > +                 !info.kprobe.func_name) {
> > +                     info.kprobe.func_name =3D (unsigned long)&buf;
> > +                     info.kprobe.name_len =3D sizeof(buf);
> > +                     goto again;
> > +             }
> > +             if (info.perf_link_type =3D=3D BPF_PERF_LINK_UPROBE &&
> > +                 !info.uprobe.file_name) {
> > +                     info.uprobe.file_name =3D (unsigned long)&buf;
> > +                     info.uprobe.name_len =3D sizeof(buf);
>
> Maybe increase the size of buf to accommodate for long paths?

Agree. Should increase it to PATH_MAX.

>
> > +                     goto again;
> > +             }
> > +     }
> >
> > +out:
> >       if (json_output)
> >               show_link_close_json(fd, &info);
> >       else
>
> Thanks for this work!

Many thanks for your review.

--=20
Regards
Yafang

