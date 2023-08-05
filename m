Return-Path: <bpf+bounces-7065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B7770D4D
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 04:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF5F1C216BE
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 02:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1917CE;
	Sat,  5 Aug 2023 02:25:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89415A6
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 02:25:43 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA354EDB
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 19:25:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76754b9eac0so206648285a.0
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 19:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691202340; x=1691807140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2hd3bd+OSnHPFkI4rNh39RPltqIjG+kXp8/y1D9Ido=;
        b=ZCdTYA5gHSLZMC2doCugKbXNUisbQX+w6QocCHifwRnINQl9jfMUYNB+QRh6Cnbz94
         l4x7v/d2g6JMWq+m/gsXYknGkM2JeZxQYbjw25Iu6OFP1vcCptcYjipv5qNTS3VbRQWZ
         138nOBQMXR65eHuXCiBxY4mmEs33zJ6xjFH3p89LdbPL9htWvvXHNGFkurZ4jAY5CPsV
         iyBM1/7UXdHqLZtBP7GBGfhUQubUq7vNem7hwVpfgAbGNnpQODt09ty2+Va8+BegokVA
         l9kK9y4Gfg9FtpMeMSFC4jT+yEimZlYfmfyEQ20kwqVZ7CVcPj36yt81vuDevXKzf0ua
         /32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691202340; x=1691807140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2hd3bd+OSnHPFkI4rNh39RPltqIjG+kXp8/y1D9Ido=;
        b=OOvsVRIBORMuKCfOtEtQqatZEzOdVrtcr6ESoy+Pg1rN6REA9eHGG8kkvIJY7mAGiK
         nHCbaG/FvXmLoENDbLO0MsEulJufxYePu4LepWLWvV/nugzh/tsudZ83qKNSIX0Ys5yf
         CnclMAcNSduzW6zJz/yQPFcwbrEz8YCh1TPPFLuSD09Ki41tomwCb1+FiOOkoN1BP6RV
         GSAKUM4wcgnbjXC/SnKubWskrvXzWktkxvMNIDDpGwt2IGKKGXnQ/hsBOZ2y/S7/8brx
         NaxZ5sX1lnwWk8ZezNO34o3Z14Rdq8Ht8EHSlTaWUvmXAPygrmMvnYc0ckB238JHoq9q
         sEhg==
X-Gm-Message-State: AOJu0YzBvkH2rtvs0TKabK1Y4sg0t6J32AF2UM/pL+SyLq9M1qWbFxyR
	HHjGDGkAyhXCtgULdl6iNlYpkbgJbEeatNDjAoA=
X-Google-Smtp-Source: AGHT+IFcDkdIgsDM4+nY6LkmCWJomGtBNGIdZX8SmvFiv/yTmsXMMlofeojalYfBPoLQmEbtzEUy5B2s/ORYV/ojiBU=
X-Received: by 2002:ac8:5889:0:b0:403:c3fb:27b6 with SMTP id
 t9-20020ac85889000000b00403c3fb27b6mr4808828qta.54.1691202339211; Fri, 04 Aug
 2023 19:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804105732.3768-1-laoar.shao@gmail.com> <20230804105732.3768-3-laoar.shao@gmail.com>
 <5fd74eee-34ce-6dfc-57f1-897ce26fc3d4@linux.dev>
In-Reply-To: <5fd74eee-34ce-6dfc-57f1-897ce26fc3d4@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 5 Aug 2023 10:25:02 +0800
Message-ID: <CALOAHbBW3rBtE_5gPc-RV+jQ-=-gOOAgkht+5HSiudTD_EOkoA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add selftest for fill_link_info
To: yonghong.song@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 5, 2023 at 12:22=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/4/23 3:57 AM, Yafang Shao wrote:
> > Add selftest for the fill_link_info of uprobe, kprobe and tracepoint.
> > The result:
> >
> >    $ tools/testing/selftests/bpf/test_progs --name=3Dfill_link_info
> >    #79/1    fill_link_info/kprobe_link_info:OK
> >    #79/2    fill_link_info/kretprobe_link_info:OK
> >    #79/3    fill_link_info/kprobe_fill_invalid_user_buff:OK
> >    #79/4    fill_link_info/tracepoint_link_info:OK
> >    #79/5    fill_link_info/uprobe_link_info:OK
> >    #79/6    fill_link_info/uretprobe_link_info:OK
> >    #79/7    fill_link_info/kprobe_multi_link_info:OK
> >    #79/8    fill_link_info/kretprobe_multi_link_info:OK
> >    #79/9    fill_link_info/kprobe_multi_ubuff:OK
> >    #79      fill_link_info:OK
> >    Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
> >
> > The test case for kprobe_multi won't be run on aarch64, as it is not
> > supported.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Ack with a few nits below.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> > ---
> >   tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 +
> >   .../selftests/bpf/prog_tests/fill_link_info.c      | 337 ++++++++++++=
+++++++++
> >   .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
> >   3 files changed, 382 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_i=
nfo.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_i=
nfo.c
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testi=
ng/selftests/bpf/DENYLIST.aarch64
> > index 3b61e8b..b2f46b6 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -12,3 +12,6 @@ kprobe_multi_test/skel_api                       # li=
bbpf: failed to load BPF sk
> >   module_attach                                    # prog 'kprobe_multi=
': failed to auto-attach: -95
> >   fentry_test/fentry_many_args                     # fentry_many_args:F=
AIL:fentry_many_args_attach unexpected error: -524
> >   fexit_test/fexit_many_args                       # fexit_many_args:FA=
IL:fexit_many_args_attach unexpected error: -524
> > +fill_link_info/kprobe_multi_link_info            # bpf_program__attach=
_kprobe_multi_opts unexpected error: -95
> > +fill_link_info/kretprobe_multi_link_info         # bpf_program__attach=
_kprobe_multi_opts unexpected error: -95
> > +fill_link_info/kprobe_multi_ubuff                # bpf_program__attach=
_kprobe_multi_opts unexpected error: -95
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/=
tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > new file mode 100644
> > index 0000000..001a8b5
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > @@ -0,0 +1,337 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
> > +
> > +#include <string.h>
> > +#include <linux/bpf.h>
> > +#include <linux/limits.h>
> > +#include <test_progs.h>
> > +#include "trace_helpers.h"
> > +#include "test_fill_link_info.skel.h"
> > +
> > +#define TP_CAT "sched"
> > +#define TP_NAME "sched_switch"
> > +#define KPROBE_FUNC "tcp_rcv_established"
> > +#define UPROBE_FILE "/proc/self/exe"
> > +#define KMULTI_CNT (4)
> > +
> > +/* uprobe attach point */
> > +static noinline void uprobe_func(void)
> > +{
> > +     asm volatile ("");
> > +}
> > +
> > +static int verify_perf_link_info(int fd, enum bpf_perf_event_type type=
, long addr,
> > +                              ssize_t offset, ssize_t entry_offset)
> > +{
> > +     struct bpf_link_info info;
> > +     __u32 len =3D sizeof(info);
> > +     char buf[PATH_MAX];
> > +     int err =3D 0;
> > +
> > +     memset(&info, 0, sizeof(info));
> > +     buf[0] =3D '\0';
> > +
> > +again:
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     if (!ASSERT_OK(err, "get_link_info"))
> > +             return -1;
> > +
> > +     if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_PERF_EVENT, "link_type"))
> > +             return -1;
> > +     if (!ASSERT_EQ(info.perf_event.type, type, "perf_type_match"))
> > +             return -1;
> > +
> > +     switch (info.perf_event.type) {
> > +     case BPF_PERF_EVENT_KPROBE:
> > +     case BPF_PERF_EVENT_KRETPROBE:
> > +             ASSERT_EQ(info.perf_event.kprobe.offset, offset, "kprobe_=
offset");
> > +
> > +             /* In case kernel.kptr_restrict is not permitted or MAX_S=
YMS is reached */
> > +             if (addr)
> > +                     ASSERT_EQ(info.perf_event.kprobe.addr, addr + ent=
ry_offset,
> > +                               "kprobe_addr");
> > +
> > +             if (!info.perf_event.kprobe.func_name) {
> > +                     ASSERT_EQ(info.perf_event.kprobe.name_len, 0, "na=
me_len");
> > +                     info.perf_event.kprobe.func_name =3D ptr_to_u64(&=
buf);
> > +                     info.perf_event.kprobe.name_len =3D sizeof(buf);
> > +                     goto again;
> > +             }
> > +
> > +             err =3D strncmp(u64_to_ptr(info.perf_event.kprobe.func_na=
me), KPROBE_FUNC,
> > +                           strlen(KPROBE_FUNC));
> > +             ASSERT_EQ(err, 0, "cmp_kprobe_func_name");
> > +             break;
> > +     case BPF_PERF_EVENT_TRACEPOINT:
> > +             if (!info.perf_event.tracepoint.tp_name) {
> > +                     ASSERT_EQ(info.perf_event.tracepoint.name_len, 0,=
 "name_len");
> > +                     info.perf_event.tracepoint.tp_name =3D ptr_to_u64=
(&buf);
> > +                     info.perf_event.tracepoint.name_len =3D sizeof(bu=
f);
> > +                     goto again;
> > +             }
> > +
> > +             err =3D strncmp(u64_to_ptr(info.perf_event.tracepoint.tp_=
name), TP_NAME,
> > +                           strlen(TP_NAME));
> > +             ASSERT_EQ(err, 0, "cmp_tp_name");
> > +             break;
> > +     case BPF_PERF_EVENT_UPROBE:
> > +     case BPF_PERF_EVENT_URETPROBE:
> > +             ASSERT_EQ(info.perf_event.uprobe.offset, offset, "uprobe_=
offset");
> > +
> > +             if (!info.perf_event.uprobe.file_name) {
> > +                     ASSERT_EQ(info.perf_event.uprobe.name_len, 0, "na=
me_len");
> > +                     info.perf_event.uprobe.file_name =3D ptr_to_u64(&=
buf);
> > +                     info.perf_event.uprobe.name_len =3D sizeof(buf);
> > +                     goto again;
> > +             }
> > +
> > +             err =3D strncmp(u64_to_ptr(info.perf_event.uprobe.file_na=
me), UPROBE_FILE,
> > +                           strlen(UPROBE_FILE));
> > +                     ASSERT_EQ(err, 0, "cmp_file_name");
> > +             break;
> > +     default:
>
> Is the 'default' case possible? Probably not, right? Then
> let us add
>                 err =3D -1;
> to indicate this path is not possible.

will add it.

>
> > +             break;
> > +     }
> > +     return err;
> > +}
> > +
> [...]
> > +
> > +static void test_kprobe_fill_link_info(struct test_fill_link_info *ske=
l,
> > +                                    enum bpf_perf_event_type type,
> > +                                    bool retprobe, bool invalid)
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts,
> > +             .attach_mode =3D PROBE_ATTACH_MODE_LINK,
> > +             .retprobe =3D retprobe,
> > +     );
> > +     ssize_t offset =3D 0, entry_offset =3D 0;
>
> Remove 'offset =3D 0'.
>
> > +     int link_fd, err;
> > +     long addr;
> > +
> > +     skel->links.kprobe_run =3D bpf_program__attach_kprobe_opts(skel->=
progs.kprobe_run,
> > +                                                              KPROBE_F=
UNC, &opts);
> > +     if (!ASSERT_OK_PTR(skel->links.kprobe_run, "attach_kprobe"))
> > +             return;
> > +
> > +     link_fd =3D bpf_link__fd(skel->links.kprobe_run);
> > +     addr =3D ksym_get_addr(KPROBE_FUNC);
> > +     if (!invalid) {
> > +             /* See also arch_adjust_kprobe_addr(). */
> > +             if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
> > +                     entry_offset =3D 4;
> > +             err =3D verify_perf_link_info(link_fd, type, addr, offset=
, entry_offset);
>
> Replease 'offset' with '0'.

will do it.

>
> > +             ASSERT_OK(err, "verify_perf_link_info");
> > +     } else {
> > +             kprobe_fill_invalid_user_buffer(link_fd);
> > +     }
> > +     bpf_link__detach(skel->links.kprobe_run);
> > +}
> > +
> [...]
> > +
> > +static void test_kprobe_multi_fill_link_info(struct test_fill_link_inf=
o *skel,
> > +                                          bool retprobe, bool buffer)
> > +{
> > +     LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> > +     const char *syms[KMULTI_CNT] =3D {
> > +             "schedule_timeout_interruptible",
> > +             "schedule_timeout_uninterruptible",
> > +             "schedule_timeout_idle",
> > +             "schedule_timeout_killable",
> > +     };
> > +     __u64 addrs[KMULTI_CNT];
> > +     int link_fd, i, err =3D 0;
>
> 'err =3D 0' =3D> 'err'.

will change it.

>
> > +
> > +     qsort(syms, KMULTI_CNT, sizeof(syms[0]), symbols_cmp_r);
> > +     opts.syms =3D syms;
> > +     opts.cnt =3D KMULTI_CNT;
> > +     opts.retprobe =3D retprobe;
> > +     skel->links.kmulti_run =3D bpf_program__attach_kprobe_multi_opts(=
skel->progs.kmulti_run,
> > +                                                                    NU=
LL, &opts);
> > +     if (!ASSERT_OK_PTR(skel->links.kmulti_run, "attach_kprobe_multi")=
)
> > +             return;
> > +
> > +     link_fd =3D bpf_link__fd(skel->links.kmulti_run);
> > +     for (i =3D 0; i < KMULTI_CNT; i++)
> > +             addrs[i] =3D ksym_get_addr(syms[i]);
> > +
> > +     if (!buffer)
> > +             err =3D verify_kmulti_link_info(link_fd, addrs, retprobe)=
;
> > +     else
> > +             verify_kmulti_user_buffer(link_fd, addrs);
> > +     ASSERT_OK(err, "verify_kmulti_link_info");
>
> if (!buffer) {
>         err =3D verify_kmulti_link_info(link_fd, addrs, retprobe);
>         ASSERT_OK(err, "verify_kmulti_link_info");
> } else {
>         verify_kmulti_user_buffer(link_fd, addrs);
> }

That is better. Thanks for your review.

--=20
Regards
Yafang

