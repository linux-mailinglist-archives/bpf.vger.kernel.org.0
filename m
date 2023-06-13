Return-Path: <bpf+bounces-2513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0B972E678
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 17:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0410C28107E
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B744839229;
	Tue, 13 Jun 2023 14:59:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299823DB
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 14:59:54 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03376E5;
	Tue, 13 Jun 2023 07:59:53 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62df62fb2a5so5458196d6.2;
        Tue, 13 Jun 2023 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686668392; x=1689260392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqegA108YqivNhRcKa64yCMqzJoXsb5CST/ebpmvJq4=;
        b=Ap6klYksIuoVV/aCaXrAlQimcSBPS4BukyfzN+X+b+QvB/77NrNOAMOVK/eBMzL+2Q
         VFEah59UjjQi+NXlFQg8oSg+nlrMtUqw5eltZtuoV4mq/yyMq9o3TUR6bLJ7XG6b11c+
         BJsRIQFLFutbqNlR6RoHgikWhv9QjvxG/uXXAxexLVIhKO0r5TxKhNWRSiw/xj7K0DpE
         s3lN57rkzGPG1jPUhxlkWOwFWyHWdMc4PyIbzda9AXu3z10x4e6YxgDjGIBTqSAQao/C
         rOhpg6/WPtOohz9VrxllpRu4Bc82eatVosGSq6HpYxb3JvCUNLbTTbVWARKAAlQbsm27
         PCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686668392; x=1689260392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqegA108YqivNhRcKa64yCMqzJoXsb5CST/ebpmvJq4=;
        b=AzmZMCP0ZjrUHP4BFndreNHgGd2VTaAkoG0eAaqM2Ib+HFI7Dz3kSr42ahZiz61VxH
         RUnT8zJ2Up2CQ1fPT98zMsjsQHPYjJq9FTrwmMNbXT0vavdOrD4aQ0OQ5utT+I7Yc+f4
         T3MMI68xoPIwmVaINX43jY5m6NUq8O+0PUulZsbNd9qr4MPBOgoh48qbK1TxKy2aOael
         L80s1vDHSKMFlHUUTBiwQH4wfpWr23sTZwCt/yooBUgH6/U/gkr29ShjJd4/LnMRse+t
         C/5MQyCdRgA5CqMRZH/3JdTOBZmhcvyO597oqfBcD246Y20XGf4IQ4AUbpPCrSq2VMmV
         vQyg==
X-Gm-Message-State: AC+VfDzw1ed/37YVda17Rt5SIiH7KsWu3pG/1GhjzV88r4OiQ75DjlGG
	EyaWxJ837jhBmfemAStlks4sK8PaluDrObofjEk=
X-Google-Smtp-Source: ACHHUZ6DFfoqOvZ9ueLIHlSdayoMa/zj6Whu/qSD0XvfWrcCcuNBihugxlKurNqfpTkjnMfXCA3WnCiaLAJlKSbReLQ=
X-Received: by 2002:ad4:5ba6:0:b0:625:88f5:7c3d with SMTP id
 6-20020ad45ba6000000b0062588f57c3dmr14628344qvq.1.1686668392078; Tue, 13 Jun
 2023 07:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-4-laoar.shao@gmail.com>
 <0e64ecd5-cba4-0963-ec74-47ceb9e867ab@isovalent.com>
In-Reply-To: <0e64ecd5-cba4-0963-ec74-47ceb9e867ab@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 13 Jun 2023 22:59:13 +0800
Message-ID: <CALOAHbCzr_ShGH+jOU14FXxc29578pKdm29+zR+LTy2VK3eXGw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpftool: Show probed function in
 kprobe_multi link info
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

On Tue, Jun 13, 2023 at 9:41=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-06-12 15:16 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> > Show the already expose kprobe_multi link info in bpftool. The result a=
s
> > follows,
> >
> > 52: kprobe_multi  prog 381
> >         retprobe 0  func_cnt 7
> >         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
> >               ffffffff9ec44f60        schedule_timeout_killable
> >               ffffffff9ec44fa0        schedule_timeout_uninterruptible
> >               ffffffff9ec44fe0        schedule_timeout_idle
> >               ffffffffc09468d0        xfs_trans_get_efd [xfs]
> >               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
> >               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
> >         pids kprobe_multi(559862)
> > 53: kprobe_multi  prog 381
> >         retprobe 1  func_cnt 7
> >         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
> >               ffffffff9ec44f60        schedule_timeout_killable
> >               ffffffff9ec44fa0        schedule_timeout_uninterruptible
> >               ffffffff9ec44fe0        schedule_timeout_idle
> >               ffffffffc09468d0        xfs_trans_get_efd [xfs]
> >               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
> >               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
> >         pids kprobe_multi(559862)
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
> >  tools/bpf/bpftool/link.c | 109 +++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 108 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 2d78607..0015582 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -14,8 +14,10 @@
> >
> >  #include "json_writer.h"
> >  #include "main.h"
> > +#include "xlated_dumper.h"
> >
> >  static struct hashmap *link_table;
> > +static struct dump_data dd =3D {};
> >
> >  static int link_parse_fd(int *argc, char ***argv)
> >  {
> > @@ -166,6 +168,45 @@ static int get_prog_info(int prog_id, struct bpf_p=
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
> > +static void
> > +show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> > +{
> > +     __u32 i, j =3D 0;
> > +     __u64 *addrs;
> > +
> > +     jsonw_uint_field(json_wtr, "retprobe",
> > +                      info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RE=
TURN);
>
> The "retprobe" field could maybe be a boolean rather than an int.

Will change it.

>
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
>
> Can we trim the square brackets around module names for the JSON output,
> please? They make entries look like arrays; but mostly, if we keep them,
> we're forcing every consumer to trim them on their side before being
> able to reuse the value.

Agree, will trim it.

--=20
Regards
Yafang

