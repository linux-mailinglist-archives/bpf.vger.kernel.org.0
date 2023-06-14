Return-Path: <bpf+bounces-2569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554872F2A4
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 04:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEB31C209E7
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 02:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196F38A;
	Wed, 14 Jun 2023 02:43:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEF17E
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 02:43:02 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212FE1BD4;
	Tue, 13 Jun 2023 19:43:00 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-5ed99ebe076so14326456d6.2;
        Tue, 13 Jun 2023 19:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686710579; x=1689302579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3GdRFv4fE/zfluXvu89QwD03ztqFWOqgIXCFNkHxr8=;
        b=hCmpewaeSQtj+k/kMRCZ2EzA/4iz3CEeDRXwKjPKkUbQA6gwTU5bVla/+mVguPMB6U
         01kRRp4xyMC0nBzVFJ2B9xSmgH899NlX01OYRjf/y8xhSbndWM92h0BYKNfLODk6xY1V
         xrQ3cvdVCXmmy4GLYxu0qpcG6NRZAx/dIme35P6LlhcITk6VT2wiy/buT71m90l4UmMl
         w/tgxXwH1N5E6ifdakPhMhvgaPEMgizPEVC4Pil+Wh2+/bhE4DLn59rMKlE+Mn8jtE4q
         c/k5iVxA0w5iJ2fTixtXFujpyVGAfPEsHNL0eF0VnM9rh55WqQ+4P3RpoYnJbTDtnY+N
         9RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686710579; x=1689302579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3GdRFv4fE/zfluXvu89QwD03ztqFWOqgIXCFNkHxr8=;
        b=c2cIwirmh0cz0gyz1il30zIFGDrRbJKNS+rV4qH3yzOP33yJQlriru+RvcZW9l8uUV
         GoUZcCjMXXjBnnV2JlyaJV+YvTGexGn1sWvfUUeu94pbyqWvzxmou9JvGv7urG6XJrlz
         g1I/zkWdzg5wdIkGvwziDoaYps3ftRhVbFgGAljxW3FvkPa1creNHHClG+eBA3hFTJjg
         NiF9P4wStZYb+k+vjY1I9wckJKuOCezrHCxZZpA/lKskgLy6c7tA9B9O8KpOnCPeMRG7
         99Fp/BqGptMh8WKEktQ6d0WAUlyqonmp3jlX6MFFK4C3nQLARVi1t7u9RCEfndTJcGKK
         qAOA==
X-Gm-Message-State: AC+VfDxfKlL4vssS8KR2TkMLWaybvQiECeWC8OeQp5aTdHDxbpx95iML
	Gy+bXm3nawuEktxV1t0Jb562C236r2Ate5NacmQ=
X-Google-Smtp-Source: ACHHUZ4d7V35FZj71aMz2S2tvkrZsd/q8AZVtAzDQKNj6LM64rIIVL4V5f2UegVweV/0wRrAOU+gdPpHVF7t9R27Apc=
X-Received: by 2002:a05:6214:f26:b0:625:aa49:9ab5 with SMTP id
 iw6-20020a0562140f2600b00625aa499ab5mr18747405qvb.57.1686710578919; Tue, 13
 Jun 2023 19:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-4-laoar.shao@gmail.com>
 <06f219e8-9ae5-01a1-f955-25f556ad5077@gmail.com>
In-Reply-To: <06f219e8-9ae5-01a1-f955-25f556ad5077@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 14 Jun 2023 10:42:22 +0800
Message-ID: <CALOAHbCjmn5_E8W+JG1_KYaprBm6k0PUGDFsydHbfSDzLmFxOQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpftool: Show probed function in
 kprobe_multi link info
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 14, 2023 at 6:36=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 6/12/23 08:16, Yafang Shao wrote:
> > Show the already expose kprobe_multi link info in bpftool. The result a=
s
> > follows,
> >
> > 52: kprobe_multi  prog 381
> >          retprobe 0  func_cnt 7
> >          addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
> >                ffffffff9ec44f60        schedule_timeout_killable
> >                ffffffff9ec44fa0        schedule_timeout_uninterruptible
> >                ffffffff9ec44fe0        schedule_timeout_idle
> >                ffffffffc09468d0        xfs_trans_get_efd [xfs]
> >                ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
> >                ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
> >          pids kprobe_multi(559862)
> > 53: kprobe_multi  prog 381
> >          retprobe 1  func_cnt 7
> >          addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
> >                ffffffff9ec44f60        schedule_timeout_killable
> >                ffffffff9ec44fa0        schedule_timeout_uninterruptible
> >                ffffffff9ec44fe0        schedule_timeout_idle
> >                ffffffffc09468d0        xfs_trans_get_efd [xfs]
> >                ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
> >                ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
> >          pids kprobe_multi(559862)
> >
> > $ tools/bpf/bpftool/bpftool link show -j
> > [{"id":52,"type":"kprobe_multi","prog_id":381,"retprobe":0,"func_cnt":7=
,"funcs":[{"addr":18446744072078249760,"func":"schedule_timeout_interruptib=
le","module":""},{"addr":18446744072078249824,"func":"schedule_timeout_kill=
able","module":""},{"addr":18446744072078249888,"func":"schedule_timeout_un=
interruptible","module":""},{"addr":18446744072078249952,"func":"schedule_t=
imeout_idle","module":""},{"addr":18446744072645535952,"func":"xfs_trans_ge=
t_efd","module":"[xfs]"},{"addr":18446744072645589520,"func":"xfs_trans_get=
_buf_map","module":"[xfs]"},{"addr":18446744072645604128,"func":"xfs_trans_=
get_dqtrx","module":"[xfs]"}],"pids":[{"pid":559862,"comm":"kprobe_multi"}]=
},{"id":53,"type":"kprobe_multi","prog_id":381,"retprobe":1,"func_cnt":7,"f=
uncs":[{"addr":18446744072078249760,"func":"schedule_timeout_interruptible"=
,"module":""},{"addr":18446744072078249824,"func":"schedule_timeout_killabl=
e","module":""},{"addr":18446744072078249888,"func":"schedule_timeout_unint=
erruptible","module":""},{"addr":18446744072078249952,"func":"schedule_time=
out_idle","module":""},{"addr":18446744072645535952,"func":"xfs_trans_get_e=
fd","module":"[xfs]"},{"addr":18446744072645589520,"func":"xfs_trans_get_bu=
f_map","module":"[xfs]"},{"addr":18446744072645604128,"func":"xfs_trans_get=
_dqtrx","module":"[xfs]"}],"pids":[{"pid":559862,"comm":"kprobe_multi"}]}]
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   tools/bpf/bpftool/link.c | 109 ++++++++++++++++++++++++++++++++++++++=
++++++++-
> >   1 file changed, 108 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 2d78607..0015582 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -14,8 +14,10 @@
> >
> >   #include "json_writer.h"
> >   #include "main.h"
> > +#include "xlated_dumper.h"
> >
> >   static struct hashmap *link_table;
> > +static struct dump_data dd =3D {};
> >
> >   static int link_parse_fd(int *argc, char ***argv)
> >   {
> > @@ -166,6 +168,45 @@ static int get_prog_info(int prog_id, struct bpf_p=
rog_info *info)
> >       return err;
> >   }
> >
> > +static int cmp_u64(const void *A, const void *B)
> > +{
> > +     const __u64 *a =3D A, *b =3D B;
> > +
> > +     return *a - *b;
> > +}
> > +
> > +static void
> > +show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> > +{
> > +     __u32 i, j =3D 0;
> > +     __u64 *addrs;
> > +
> > +     jsonw_uint_field(json_wtr, "retprobe",
> > +                      info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RE=
TURN);
> > +     jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
> > +     jsonw_name(json_wtr, "funcs");
> > +     jsonw_start_array(json_wtr);
> > +     addrs =3D (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> > +     qsort((void *)addrs, info->kprobe_multi.count, sizeof(__u64), cmp=
_u64);
> > +
> > +     /* Load it once for all. */
> > +     if (!dd.sym_count)
> > +             kernel_syms_load(&dd);
> > +     for (i =3D 0; i < dd.sym_count; i++) {
> > +             if (dd.sym_mapping[i].address !=3D addrs[j])
> > +                     continue;
> > +             jsonw_start_object(json_wtr);
> > +             jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].addr=
ess);
> > +             jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].na=
me);
> > +             /* Print none if it is vmlinux */
> > +             jsonw_string_field(json_wtr, "module", dd.sym_mapping[i].=
module);
> > +             jsonw_end_object(json_wtr);
> > +             if (j++ =3D=3D info->kprobe_multi.count)
> > +                     break;
> > +     }
> > +     jsonw_end_array(json_wtr);
> > +}
> > +
> >   static int show_link_close_json(int fd, struct bpf_link_info *info)
> >   {
> >       struct bpf_prog_info prog_info;
> > @@ -218,6 +259,9 @@ static int show_link_close_json(int fd, struct bpf_=
link_info *info)
> >               jsonw_uint_field(json_wtr, "map_id",
> >                                info->struct_ops.map_id);
> >               break;
> > +     case BPF_LINK_TYPE_KPROBE_MULTI:
> > +             show_kprobe_multi_json(info, json_wtr);
> > +             break;
> >       default:
> >               break;
> >       }
> > @@ -351,6 +395,44 @@ void netfilter_dump_plain(const struct bpf_link_in=
fo *info)
> >               printf(" flags 0x%x", info->netfilter.flags);
> >   }
> >
> > +static void show_kprobe_multi_plain(struct bpf_link_info *info)
> > +{
> > +     __u32 i, j =3D 0;
> > +     __u64 *addrs;
> > +
> > +     if (!info->kprobe_multi.count)
> > +             return;
> > +
> > +     printf("\n\tretprobe %d  func_cnt %u  ",
> > +            info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN,
> > +            info->kprobe_multi.count);
> > +     addrs =3D (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> > +     qsort((void *)addrs, info->kprobe_multi.count, sizeof(__u64), cmp=
_u64);
> > +
> > +     /* Load it once for all. */
> > +     if (!dd.sym_count)
> > +             kernel_syms_load(&dd);
> > +     for (i =3D 0; i < dd.sym_count; i++) {
> > +             if (dd.sym_mapping[i].address !=3D addrs[j])
> > +                     continue;
> > +             if (!j)
> > +                     printf("\n\taddrs %016lx  funcs %s",
> > +                            dd.sym_mapping[i].address,
> > +                            dd.sym_mapping[i].name);
> > +             else
> > +                     printf("\n\t      %016lx        %s",
> > +                            dd.sym_mapping[i].address,
> > +                            dd.sym_mapping[i].name);
> > +             if (dd.sym_mapping[i].module[0] !=3D '\0')
> > +                     printf(" %s  ", dd.sym_mapping[i].module);
> > +             else
> > +                     printf("  ");
>
> Could you explain what these extra spaces after module names are for?

There are two spaces. We use two spaces to seperate different items
printed in bpftool. For example,
  "4: kprobe_multi  prog 16"
There are two spaces between the "type" and the "prog".

We always print these two spaces after one item is printed:
  printf("type %u  ", info->type);
  printf("prog %u  ", info->prog_id);
That way, we can add new item easily and consistently.

--=20
Regards
Yafang

