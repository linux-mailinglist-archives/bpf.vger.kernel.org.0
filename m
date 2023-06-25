Return-Path: <bpf+bounces-3399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4778973D17E
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F951C20938
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ADD63D9;
	Sun, 25 Jun 2023 14:29:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EDB63A3
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 14:29:53 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3249E53;
	Sun, 25 Jun 2023 07:29:51 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635783b8b80so12309736d6.1;
        Sun, 25 Jun 2023 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687703391; x=1690295391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdTfFfl135w/q2JkvWXGQPS9eOQuX6TcqOKZ5cKs/cA=;
        b=Zyi8e0y6eDEQRxalgyHoc2M6OWhbNyAenkBosWG2zxBkYyha2d5vUcVmfyCnnhWs28
         yTjdanWETHMO4+OPiNpm3Y/jKqvuvXpPqCQY7A+xchTuQSpGvywCIwKaocp+Ep2nJygn
         XE94kG+Ym+Ls4GMonq5SITK+MB5X6KO2ukdbyMwWqaV4MxQcXl33TcrlcrDQzQIuEfil
         4hz6pwGzhMNXS95L4BD725WFFsGSpVk3sz+PydggHpXPC1Gr8cVAVmljob2a+BcRIuI1
         MaTOQzn2QvB84nbVZmu9sMrDugy3N9C3/jVS4nxXW2zBAV/Gkv8JOqWzbUSrRJn+nu3P
         ilCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703391; x=1690295391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdTfFfl135w/q2JkvWXGQPS9eOQuX6TcqOKZ5cKs/cA=;
        b=f4BGbvt9KWlN8DyC1/VHUgMfvCDaFSvXbQQCz0dn57nFAfWlxk4PAp41nNwbYsw4ia
         BXW5HMV5k2wh32i5q8Ftdx/0RFaMoKNstu1SZPfIUx02kiTxgEY1ybkw3/LpIGjIs/Si
         fVwTV+6qY8wXYUF/00MUcm2mm1vapAbcnYblXx+eb47Br1rIsF24sTzuFIaHzouQrHd1
         N/fJqfbtDmnneP7tmnCkpE9drsDBct4HF5mRiFRJ7EjhRmLcjZ7NgqKOrxSmHJG/tqw9
         B13iWgmLH2RH8bN4R87GnVHc7pJOlZmy37UgfLwoa+i4PQDiS249N07V72xJxFrYNo8Z
         jYfQ==
X-Gm-Message-State: AC+VfDwzsVUKAuu3b/HfBci/F4R1UkddOK4+JkRrurNCS7AE573mKSLQ
	2TtJdZG3shaiEVJKANJ7vAr8yxX2dhg0mFTouC0=
X-Google-Smtp-Source: ACHHUZ7ar2kUi2VvDfYDUwcZvnQs7m2CEsfFHyAWh5BK0Nvc7uI5wFWdYVQtnb+geTBAIepPdQKocLouJ83PBxESe2w=
X-Received: by 2002:a05:6214:20e4:b0:62f:ebc4:89bc with SMTP id
 4-20020a05621420e400b0062febc489bcmr22372841qvk.20.1687703390976; Sun, 25 Jun
 2023 07:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623141546.3751-1-laoar.shao@gmail.com> <20230623141546.3751-4-laoar.shao@gmail.com>
 <3ad842a7-32cb-a06e-5e15-a13c3c80e1d5@isovalent.com>
In-Reply-To: <3ad842a7-32cb-a06e-5e15-a13c3c80e1d5@isovalent.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Jun 2023 22:29:14 +0800
Message-ID: <CALOAHbC+5YGkevDqD3E=v+H3xkKiTfutfF4HpiEz0iE2OMRgqA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 03/11] bpftool: Show kprobe_multi link info
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
> > Show the already expose kprobe_multi link info in bpftool. The result a=
s
> > follows,
> >
> > $ tools/bpf/bpftool/bpftool link show
> > 4: kprobe_multi  prog 22
> >         kprobe.multi  func_cnt 7
> >         addr             func [module]
> >         ffffffffbbc44f20 schedule_timeout_interruptible
> >         ffffffffbbc44f60 schedule_timeout_killable
> >         ffffffffbbc44fa0 schedule_timeout_uninterruptible
> >         ffffffffbbc44fe0 schedule_timeout_idle
> >         ffffffffc08028d0 xfs_trans_get_efd [xfs]
> >         ffffffffc080fa10 xfs_trans_get_buf_map [xfs]
> >         ffffffffc0813320 xfs_trans_get_dqtrx [xfs]
> >         pids kprobe_multi(1434978)
> > 5: kprobe_multi  prog 22
> >         kretprobe.multi  func_cnt 7
> >         addr             func [module]
> >         ffffffffbbc44f20 schedule_timeout_interruptible
> >         ffffffffbbc44f60 schedule_timeout_killable
> >         ffffffffbbc44fa0 schedule_timeout_uninterruptible
> >         ffffffffbbc44fe0 schedule_timeout_idle
> >         ffffffffc08028d0 xfs_trans_get_efd [xfs]
> >         ffffffffc080fa10 xfs_trans_get_buf_map [xfs]
> >         ffffffffc0813320 xfs_trans_get_dqtrx [xfs]
> >         pids kprobe_multi(1434978)
> >
> > $ tools/bpf/bpftool/bpftool link show -j
> > [{"id":4,"type":"kprobe_multi","prog_id":22,"retprobe":false,"func_cnt"=
:7,"funcs":[{"addr":18446744072564789024,"func":"schedule_timeout_interrupt=
ible","module":""},{"addr":18446744072564789088,"func":"schedule_timeout_ki=
llable","module":""},{"addr":18446744072564789152,"func":"schedule_timeout_=
uninterruptible","module":""},{"addr":18446744072564789216,"func":"schedule=
_timeout_idle","module":""},{"addr":18446744072644208848,"func":"xfs_trans_=
get_efd","module":"xfs"},{"addr":18446744072644262416,"func":"xfs_trans_get=
_buf_map","module":"xfs"},{"addr":18446744072644277024,"func":"xfs_trans_ge=
t_dqtrx","module":"xfs"}],"pids":[{"pid":1434978,"comm":"kprobe_multi"}]},{=
"id":5,"type":"kprobe_multi","prog_id":22,"retprobe":true,"func_cnt":7,"fun=
cs":[{"addr":18446744072564789024,"func":"schedule_timeout_interruptible","=
module":""},{"addr":18446744072564789088,"func":"schedule_timeout_killable"=
,"module":""},{"addr":18446744072564789152,"func":"schedule_timeout_uninter=
ruptible","module":""},{"addr":18446744072564789216,"func":"schedule_timeou=
t_idle","module":""},{"addr":18446744072644208848,"func":"xfs_trans_get_efd=
","module":"xfs"},{"addr":18446744072644262416,"func":"xfs_trans_get_buf_ma=
p","module":"xfs"},{"addr":18446744072644277024,"func":"xfs_trans_get_dqtrx=
","module":"xfs"}],"pids":[{"pid":1434978,"comm":"kprobe_multi"}]}]
> >
> > When kptr_restrict is 2, the result is,
> >
> > $ tools/bpf/bpftool/bpftool link show
> > 4: kprobe_multi  prog 22
> >         kprobe.multi  func_cnt 7
> > 5: kprobe_multi  prog 22
> >         kretprobe.multi  func_cnt 7
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/bpf/bpftool/link.c | 109 +++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 108 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 2d78607..8461e6d 100644
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
> > +     jsonw_bool_field(json_wtr, "retprobe",
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
>
> We could maybe print null ("jsonw_null(json_wtr);") instead of an empty
> string here when we have no module name. Although I'm not sure it
> matters too much. Let's see whether the series needs another respin.

Will change it. Thanks for your review.

>
> Anyway:
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>



--=20
Regards
Yafang

