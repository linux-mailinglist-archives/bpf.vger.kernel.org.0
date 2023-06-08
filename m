Return-Path: <bpf+bounces-2172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB8728B8C
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 01:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED701C21015
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9826E34D71;
	Thu,  8 Jun 2023 23:08:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA631F00
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 23:08:23 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792012D7F
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 16:08:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so2076502a12.2
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 16:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686265700; x=1688857700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcnD1YvF+yc8MXcpeuIcMjfS9x9zbpemPIuJeoGrET4=;
        b=i1vM4w+8elnq6MZfj8W+fwR2Nft8G+c4e2GgY041N3v3J0y2dBMdFoAF9svvb3RPwY
         P6KmGqXHGv2PtAI4+ib9TwMfOwyZ6L727gImavTb97NTuGfvr9HwIMXS4LjPAbnmARNq
         7HCWgG0uzXiW5KluK0SBLFPH5e4jdQQvEgzMqIkDgxE38xpHr7CMSxGjJfsTi9Au6GSp
         +Rm3p/5xGq1HIG5eosP+1L4WE85MGYeMbnOFnWIyzSgtPFGIXo32SiIxKP7wM7nZ3lKg
         O9IEHul8qwIHIoYaUCNa7BVFSZzmVbXlxBgg/XcE46Z/VDvZUa67j2LkOUvuuww6MfRU
         +QIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686265700; x=1688857700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcnD1YvF+yc8MXcpeuIcMjfS9x9zbpemPIuJeoGrET4=;
        b=XeCBPY9XTeEt4NlP5sC9s2ATFii+kJa1dWgzMrBFRo5CgJ4L1WPIsIJtwX11+21Y4X
         Cf1msRJTlq9QhKDn+KQJzYEirLR4T+AiDc0dF75KiaP4vCffH1SOmZi30zV1hCEGtt5A
         JhVMFmLmaTBpDA/whPp6DTJGip/e4RkDBleviVAvdqwdmGbKSkHmPd+0PMEYhHutngDq
         DRg0Wd/rDML9qCerFysu6MVvK4VkaOJ0IjDPNTMfM9a42+oMbZCDiPQSravlAJJzqnl/
         pRGu4ZZzIRiO9b101gUpAq+RyAsZE7m3z/ZsmGWf35VeJaq/oKbeclEhnx8xGk7ZRtGh
         8grA==
X-Gm-Message-State: AC+VfDzahj9eICPWIblBluxmukTvKlz7F7nAORzMjcDcZQsfz/SpiTRr
	h6NE0iqFxR0kMvZEsHVx1Ta/yvdioOxclylCugk=
X-Google-Smtp-Source: ACHHUZ4MgVTRN7ITGohv/HYYN+cu1cvuTNMFndBT9vX05fBeMuMKcJIgMHQg/KC+ndNjcG7WTPBZkVblf0SzCZoct5w=
X-Received: by 2002:a17:907:801:b0:96a:5bdd:7557 with SMTP id
 wv1-20020a170907080100b0096a5bdd7557mr410424ejb.70.1686265699613; Thu, 08 Jun
 2023 16:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-4-laoar.shao@gmail.com>
In-Reply-To: <20230608103523.102267-4-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 16:08:07 -0700
Message-ID: <CAEf4BzZsY=wT4BQTyMK5_MQamXo-vY1bLFc9rYGoxtnC1Maj=Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/11] bpftool: Show probed function in
 kprobe_multi link info
To: Yafang Shao <laoar.shao@gmail.com>
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

On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Show the already expose kprobe_multi link info in bpftool. The result as
> follows,
>
> $ tools/bpf/bpftool/bpftool link show
> 4: kprobe_multi  prog 29
>         retprobe 0  func_cnt 4
>         addrs ffffffffb5d475b0  funcs schedule_timeout_interruptible
>               ffffffffb5d475f0        schedule_timeout_killable
>               ffffffffb5d47630        schedule_timeout_uninterruptible
>               ffffffffb5d47670        schedule_timeout_idle

what about module names? kallsyms has this information and it is quite
important, in addition to function name


>         pids trace(276245)
>
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":4,"type":"kprobe_multi","prog_id":29,"retprobe":0,"func_cnt":4,"fu=
ncs":[{"addr":18446744072465184176,"func":"schedule_timeout_interruptible"}=
,{"addr":18446744072465184240,"func":"schedule_timeout_killable"},{"addr":1=
8446744072465184304,"func":"schedule_timeout_uninterruptible"},{"addr":1844=
6744072465184368,"func":"schedule_timeout_idle"}],"pids":[{"pid":276245,"co=
mm":"trace"}]}]
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 82 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 2d78607..c8033c3 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -14,6 +14,7 @@
>
>  #include "json_writer.h"
>  #include "main.h"
> +#include "xlated_dumper.h"
>
>  static struct hashmap *link_table;
>
> @@ -166,6 +167,34 @@ static int get_prog_info(int prog_id, struct bpf_pro=
g_info *info)
>         return err;
>  }
>
> +static void
> +show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> +{
> +       struct dump_data dd =3D {};
> +       const __u64 *addrs;
> +       __u32 i;
> +       int err;
> +
> +       jsonw_uint_field(json_wtr, "retprobe", info->kprobe_multi.retprob=
e);
> +       jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
> +       jsonw_name(json_wtr, "funcs");
> +       jsonw_start_array(json_wtr);
> +       addrs =3D (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> +       err =3D kernel_syms_load(&dd, addrs, info->kprobe_multi.count);
> +       if (err) {
> +               jsonw_end_array(json_wtr);
> +               return;
> +       }
> +       for (i =3D 0; i < dd.sym_count; i++) {
> +               jsonw_start_object(json_wtr);
> +               jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].addr=
ess);
> +               jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].na=
me);
> +               jsonw_end_object(json_wtr);
> +       }
> +       jsonw_end_array(json_wtr);
> +       kernel_syms_destroy(&dd);
> +}
> +
>  static int show_link_close_json(int fd, struct bpf_link_info *info)
>  {
>         struct bpf_prog_info prog_info;
> @@ -218,6 +247,9 @@ static int show_link_close_json(int fd, struct bpf_li=
nk_info *info)
>                 jsonw_uint_field(json_wtr, "map_id",
>                                  info->struct_ops.map_id);
>                 break;
> +       case BPF_LINK_TYPE_KPROBE_MULTI:
> +               show_kprobe_multi_json(info, json_wtr);
> +               break;
>         default:
>                 break;
>         }
> @@ -351,6 +383,35 @@ void netfilter_dump_plain(const struct bpf_link_info=
 *info)
>                 printf(" flags 0x%x", info->netfilter.flags);
>  }
>
> +static void show_kprobe_multi_plain(struct bpf_link_info *info)
> +{
> +       struct dump_data dd =3D {};
> +       const __u64 *addrs;
> +       __u32 i;
> +       int err;
> +
> +       if (!info->kprobe_multi.count)
> +               return;
> +
> +       printf("\n\tretprobe %d  func_cnt %u  ",
> +              info->kprobe_multi.retprobe, info->kprobe_multi.count);
> +       addrs =3D (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> +       err =3D kernel_syms_load(&dd, addrs, info->kprobe_multi.count);
> +       if (err)
> +               return;
> +       for (i =3D 0; i < dd.sym_count; i++) {
> +               if (!i)
> +                       printf("\n\taddrs %016lx  funcs %s  ",
> +                              dd.sym_mapping[i].address,
> +                              dd.sym_mapping[i].name);
> +               else
> +                       printf("\n\t      %016lx        %s  ",
> +                              dd.sym_mapping[i].address,
> +                              dd.sym_mapping[i].name);
> +       }
> +       kernel_syms_destroy(&dd);
> +}
> +
>  static int show_link_close_plain(int fd, struct bpf_link_info *info)
>  {
>         struct bpf_prog_info prog_info;
> @@ -396,6 +457,9 @@ static int show_link_close_plain(int fd, struct bpf_l=
ink_info *info)
>         case BPF_LINK_TYPE_NETFILTER:
>                 netfilter_dump_plain(info);
>                 break;
> +       case BPF_LINK_TYPE_KPROBE_MULTI:
> +               show_kprobe_multi_plain(info);
> +               break;
>         default:
>                 break;
>         }
> @@ -417,7 +481,9 @@ static int do_show_link(int fd)
>  {
>         struct bpf_link_info info;
>         __u32 len =3D sizeof(info);
> +       __u64 *addrs =3D NULL;
>         char buf[256];
> +       int count;
>         int err;
>
>         memset(&info, 0, sizeof(info));
> @@ -441,12 +507,28 @@ static int do_show_link(int fd)
>                 info.iter.target_name_len =3D sizeof(buf);
>                 goto again;
>         }
> +       if (info.type =3D=3D BPF_LINK_TYPE_KPROBE_MULTI &&
> +           !info.kprobe_multi.addrs) {
> +               count =3D info.kprobe_multi.count;
> +               if (count) {
> +                       addrs =3D calloc(count, sizeof(__u64));
> +                       if (!addrs) {
> +                               p_err("mem alloc failed");
> +                               close(fd);
> +                               return -1;
> +                       }
> +                       info.kprobe_multi.addrs =3D (unsigned long)addrs;
> +                       goto again;
> +               }
> +       }
>
>         if (json_output)
>                 show_link_close_json(fd, &info);
>         else
>                 show_link_close_plain(fd, &info);
>
> +       if (addrs)
> +               free(addrs);
>         close(fd);
>         return 0;
>  }
> --
> 1.8.3.1
>

