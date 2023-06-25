Return-Path: <bpf+bounces-3401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB35673D180
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 16:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945F9280FBB
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1C5664;
	Sun, 25 Jun 2023 14:31:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188920F4
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 14:31:45 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3258C6;
	Sun, 25 Jun 2023 07:31:43 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6300510605bso18282656d6.0;
        Sun, 25 Jun 2023 07:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687703503; x=1690295503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXWqS0BuWowWOlSSHJDExrhhBjipqdLP0wY0QwqjAYI=;
        b=E8A76JSDZp4k8Uy40lnPcDrugHZOAZZiaPGX5AZ3LkTOEl9pJVcghitjVyDaV7yvX6
         oSIbh7uY68cFYz+8VnqPYJiNn3f4uKNVOffoidCLlWBGN7jBfiJ12DWzKZQkWKyFMv1Q
         R79RZnmhDDvp89jllGqQGC1PF+fZcj/L6waU41o3+SJcf7u89/LHggT2jVOOAG54o7rU
         3vrrU05VzbYhtWAXkpVU3D0hmQBMtG2jq4cWlrxrsYk/T4qo+pD16JsNOAymza3roLpY
         f7aX6LInFyQXbvO0CVqv2ufeN/9WzApbfZbjfoCqdim2CKi5IuXLhac1aAB8BeJHp+9K
         4PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703503; x=1690295503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXWqS0BuWowWOlSSHJDExrhhBjipqdLP0wY0QwqjAYI=;
        b=QeP5CYdHXtjxuzbTc3UYp8l60Z0Nh/s1b2lmsPG8b/DnXdi6MpXuILYxbpc95uI9nO
         Kvtv5oqK0VjDXsjuCc4cjcoLeHVvd1/YCObceDJ6/porh/7I0bRbgcISvq5HgGzd31nT
         uWJ/KQ8PITK9s8ZJ6o60WY2NKxAhEnv1GLRSOp8k2D74SdkmQZWOWJIyKdi+C+KN0u0S
         vmDltHgxQ0nW3T8wdQBuXeas3zV1VQ3dWEccKbigOeGh1rBONovexBN8LNOx5hFRdQEw
         FRfdpCmW1dWRfCQEjy6o+N+6wT7UqSDAWgX7hrMHssAOSh2P+tP9OrIZyrkIGyWn79aV
         Q8Eg==
X-Gm-Message-State: AC+VfDxz9i89xkFVIS5bB4N+fvtPsikRF3Q/HtVj2bQXP7i4jvW6DU3H
	nut9MrD1TdB1ORLHipt5hAG5l+CLSyM1r5+7ygs=
X-Google-Smtp-Source: ACHHUZ4VBKpp5uOVD2RvuooF+bTS2aAMwdOp5jLNB8wyBspok39a82ItW1YPMc2etIjW6/Ako2+9JWJQpsBOYj7IqFo=
X-Received: by 2002:a05:6214:2348:b0:626:3a5a:f8dc with SMTP id
 hu8-20020a056214234800b006263a5af8dcmr34805187qvb.57.1687703502761; Sun, 25
 Jun 2023 07:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623141546.3751-1-laoar.shao@gmail.com> <20230623141546.3751-12-laoar.shao@gmail.com>
 <47769c5d-e6da-1f60-aac5-42c7322485fd@isovalent.com>
In-Reply-To: <47769c5d-e6da-1f60-aac5-42c7322485fd@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Jun 2023 22:31:06 +0800
Message-ID: <CALOAHbCVVPyUArUpH1U4dFR4MMish96ZVw9TmHHdjzqWH37=TA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 11/11] bpftool: Show perf link info
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

On Sat, Jun 24, 2023 at 12:49=E2=80=AFAM Quentin Monnet <quentin@isovalent.=
com> wrote:
>
> 2023-06-23 14:15 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> > Enhance bpftool to display comprehensive information about exposed
> > perf_event links, covering uprobe, kprobe, tracepoint, and generic perf
> > event. The resulting output will include the following details:
> >
> > $ tools/bpf/bpftool/bpftool link show
> > 4: perf_event  prog 23
> >         uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
> >         bpf_cookie 0
> >         pids uprobe(27503)
> > 5: perf_event  prog 24
> >         uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
> >         bpf_cookie 0
> >         pids uprobe(27503)
> > 6: perf_event  prog 31
> >         kprobe ffffffffa90a9660 kernel_clone
> >         bpf_cookie 0
> >         pids kprobe(27777)
> > 7: perf_event  prog 30
> >         kretprobe ffffffffa90a9660 kernel_clone
> >         bpf_cookie 0
> >         pids kprobe(27777)
> > 8: perf_event  prog 37
> >         tracepoint sched_switch
> >         bpf_cookie 0
> >         pids tracepoint(28036)
> > 9: perf_event  prog 43
> >         event software:cpu-clock
> >         bpf_cookie 0
> >         pids perf_event(28261)
> > 10: perf_event  prog 43
> >         event hw-cache:LLC-load-misses
> >         bpf_cookie 0
> >         pids perf_event(28261)
> > 11: perf_event  prog 43
> >         event hardware:cpu-cycles
> >         bpf_cookie 0
> >         pids perf_event(28261)
> >
> > $ tools/bpf/bpftool/bpftool link show -j
> > [{"id":4,"type":"perf_event","prog_id":23,"retprobe":false,"file":"/hom=
e/dev/waken/bpf/uprobe/a.out","offset":4920,"bpf_cookie":0,"pids":[{"pid":2=
7503,"comm":"uprobe"}]},{"id":5,"type":"perf_event","prog_id":24,"retprobe"=
:true,"file":"/home/dev/waken/bpf/uprobe/a.out","offset":4920,"bpf_cookie":=
0,"pids":[{"pid":27503,"comm":"uprobe"}]},{"id":6,"type":"perf_event","prog=
_id":31,"retprobe":false,"addr":18446744072250627680,"func":"kernel_clone",=
"offset":0,"bpf_cookie":0,"pids":[{"pid":27777,"comm":"kprobe"}]},{"id":7,"=
type":"perf_event","prog_id":30,"retprobe":true,"addr":18446744072250627680=
,"func":"kernel_clone","offset":0,"bpf_cookie":0,"pids":[{"pid":27777,"comm=
":"kprobe"}]},{"id":8,"type":"perf_event","prog_id":37,"tracepoint":"sched_=
switch","bpf_cookie":0,"pids":[{"pid":28036,"comm":"tracepoint"}]},{"id":9,=
"type":"perf_event","prog_id":43,"event_type":"software","event_config":"cp=
u-clock","bpf_cookie":0,"pids":[{"pid":28261,"comm":"perf_event"}]},{"id":1=
0,"type":"perf_event","prog_id":43,"event_type":"hw-cache","event_config":"=
LLC-load-misses","bpf_cookie":0,"pids":[{"pid":28261,"comm":"perf_event"}]}=
,{"id":11,"type":"perf_event","prog_id":43,"event_type":"hardware","event_c=
onfig":"cpu-cycles","bpf_cookie":0,"pids":[{"pid":28261,"comm":"perf_event"=
}]}]
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
> > 4: perf_event  prog 23
> >         uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
> > 5: perf_event  prog 24
> >         uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
> > 6: perf_event  prog 31
> >         kprobe kernel_clone
> > 7: perf_event  prog 30
> >         kretprobe kernel_clone
> > 8: perf_event  prog 37
> >         tracepoint sched_switch
> > 9: perf_event  prog 43
> >         event software:cpu-clock
> > 10: perf_event  prog 43
> >         event hw-cache:LLC-load-misses
> > 11: perf_event  prog 43
> >         event hardware:cpu-cycles
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/bpf/bpftool/link.c | 237 +++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 236 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index e5aeee3..31bee95 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -17,6 +17,8 @@
> >  #include "main.h"
> >  #include "xlated_dumper.h"
> >
> > +#define PERF_HW_CACHE_LEN 128
> > +
> >  static struct hashmap *link_table;
> >  static struct dump_data dd =3D {};
> >
> > @@ -274,6 +276,110 @@ static int cmp_u64(const void *A, const void *B)
> >       jsonw_end_array(json_wtr);
> >  }
> >
> > +static void
> > +show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t =
*wtr)
> > +{
> > +     jsonw_bool_field(wtr, "retprobe", info->perf_event.kprobe.flags &=
 0x1);
> > +     jsonw_uint_field(wtr, "addr", info->perf_event.kprobe.addr);
> > +     jsonw_string_field(wtr, "func",
> > +                        u64_to_ptr(info->perf_event.kprobe.func_name))=
;
> > +     jsonw_uint_field(wtr, "offset", info->perf_event.kprobe.offset);
> > +}
> > +
> > +static void
> > +show_perf_event_uprobe_json(struct bpf_link_info *info, json_writer_t =
*wtr)
> > +{
> > +     jsonw_bool_field(wtr, "retprobe", info->perf_event.uprobe.flags &=
 0x1);
> > +     jsonw_string_field(wtr, "file",
> > +                        u64_to_ptr(info->perf_event.uprobe.file_name))=
;
> > +     jsonw_uint_field(wtr, "offset", info->perf_event.uprobe.offset);
> > +}
> > +
> > +static void
> > +show_perf_event_tracepoint_json(struct bpf_link_info *info, json_write=
r_t *wtr)
> > +{
> > +     jsonw_string_field(wtr, "tracepoint",
> > +                        u64_to_ptr(info->perf_event.tracepoint.tp_name=
));
> > +}
> > +
> > +static char *perf_config_hw_cache_str(__u64 config)
> > +{
> > +     const char *hw_cache, *result, *op;
> > +     char *str =3D malloc(PERF_HW_CACHE_LEN);
> > +
> > +     if (!str) {
> > +             p_err("mem alloc failed");
> > +             return NULL;
> > +     }
> > +
> > +     hw_cache =3D perf_event_name(evsel__hw_cache, config & 0xff);
> > +     if (hw_cache)
> > +             snprintf(str, PERF_HW_CACHE_LEN, "%s-", hw_cache);
> > +     else
> > +             snprintf(str, PERF_HW_CACHE_LEN, "%lld-", config & 0xff);
> > +
> > +     op =3D perf_event_name(evsel__hw_cache_op, (config >> 8) & 0xff);
> > +     if (op)
> > +             snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(st=
r),
> > +                      "%s-", op);
> > +     else
> > +             snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(st=
r),
> > +                      "%lld-", (config >> 8) & 0xff);
> > +
> > +     result =3D perf_event_name(evsel__hw_cache_result, config >> 16);
> > +     if (result)
> > +             snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(st=
r),
> > +                      "%s", result);
> > +     else
> > +             snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(st=
r),
> > +                      "%lld", config >> 16);
> > +     return str;
> > +}
> > +
> > +static const char *perf_config_str(__u32 type, __u64 config)
> > +{
> > +     const char *perf_config;
> > +
> > +     switch (type) {
> > +     case PERF_TYPE_HARDWARE:
> > +             perf_config =3D perf_event_name(event_symbols_hw, config)=
;
> > +             break;
> > +     case PERF_TYPE_SOFTWARE:
> > +             perf_config =3D perf_event_name(event_symbols_sw, config)=
;
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
> > +}
> > +
> >  static int show_link_close_json(int fd, struct bpf_link_info *info)
> >  {
> >       struct bpf_prog_info prog_info;
> > @@ -329,6 +435,24 @@ static int show_link_close_json(int fd, struct bpf=
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
> > +                     show_perf_event_kprobe_json(info, json_wtr);
> > +                     break;
> > +             case BPF_PERF_EVENT_UPROBE:
> > +                     show_perf_event_uprobe_json(info, json_wtr);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -500,6 +624,75 @@ static void show_kprobe_multi_plain(struct bpf_lin=
k_info *info)
> >       }
> >  }
> >
> > +static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
> > +{
> > +     const char *buf;
> > +
> > +     buf =3D (const char *)u64_to_ptr(info->perf_event.kprobe.func_nam=
e);
> > +     if (buf[0] =3D=3D '\0' && !info->perf_event.kprobe.addr)
> > +             return;
> > +
> > +     if (info->perf_event.kprobe.flags & 0x1)
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
> > +     if (info->perf_event.uprobe.flags & 0x1)
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
> > +}
> > +
> >  static int show_link_close_plain(int fd, struct bpf_link_info *info)
> >  {
> >       struct bpf_prog_info prog_info;
> > @@ -548,6 +741,24 @@ static int show_link_close_plain(int fd, struct bp=
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
> > +                     show_perf_event_kprobe_plain(info);
> > +                     break;
> > +             case BPF_PERF_EVENT_UPROBE:
> > +                     show_perf_event_uprobe_plain(info);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -570,11 +781,12 @@ static int do_show_link(int fd)
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
> >  again:
> >       err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> >       if (err) {
> > @@ -609,7 +821,30 @@ static int do_show_link(int fd)
> >                       goto again;
> >               }
> >       }
> > +     if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
> > +             if (info.perf_event.type =3D=3D BPF_PERF_EVENT_EVENT)
> > +                     goto out;
>
> This "if (...) goto out;" seems unnecessary? If info.perf_event.type is
> BPF_PERF_EVENT_EVENT we won't match any of the conditions below and
> should reach the "out:" label anyway (and that label seems also
> unnecessary)?

Makes sense. Will change it.

--=20
Regards
Yafang

