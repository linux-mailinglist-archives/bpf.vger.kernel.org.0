Return-Path: <bpf+bounces-6872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D376EC8A
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2398B282277
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD8C1ED4F;
	Thu,  3 Aug 2023 14:32:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54123BCA
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:32:44 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5D1211D
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:32:41 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so1110267276.3
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691073160; x=1691677960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3uivDxhzasAzwmsu60W32Vsp+mt+obdRn/+JwWFK2Y=;
        b=rey2t5+88y45FN6ExmU8gmo2jRHkA0Jlv3v4CtG+oLUpy1l2enn8LPaWf5yZGVlpyk
         ef4/otfyY+HnkzNOLS4tTC75OOWiZSWyhWgNr1QuapUXAA76H+7BLlB9yF6js5CHGP/n
         LVjlAUAx8V+eXLzD+K2/Ucpp/UThCkgtdyiNlt6oYlRqp1lkxkGtZyZ08LTiC+wMAo+Q
         HRJQTp8UiAXruwcsTaBqsILlAvcwHulUGCDK3IWpiJx1U8b63r9P+/2PbnnxhIsLkmVN
         kvYKx7wGEKGi/W7s48YB6yi0L0nUYX5AOTOhDaGYtmjgwtLm7pcu8wpbvBj9oKboLk90
         TwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691073160; x=1691677960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3uivDxhzasAzwmsu60W32Vsp+mt+obdRn/+JwWFK2Y=;
        b=Av96HftlniQeTdBPx6MjxinTf1GA00aYfqkS5UIvUgtz4fkACxK8o0YjJh8pyiKVfm
         HkW2E1PX+W7Cg03vfMGzEMxK0+yHh2fTcD4U+JbXAvuFwGF7mG24dD5v7Uvgb1bSmC4q
         vjkJigzW5xJ2vzrLM6iwwqVPPl79Ro1t0wggEVjWShivPqHst5kpWIBIoXkgo76s3tqI
         ZUbKjldq7XXEpWMbIY4wSD0yR14NSFCJT+ih29VYc7q9HGgs4I0cirfrAifjokBhu9Qi
         +2giQTnpLF0cEz2+gsgCwklkcfFbERGMr0+hPV9AmohJo9fxO4BIpGe1FZdHV/CLm27b
         IcAg==
X-Gm-Message-State: ABy/qLaDXSUiK3gJF6575fG/AFQ95CM4Yv4ZuAq+eXudSyz6RUoNZfoZ
	SGnsk1sPOixRrJyLpw871cSV61SRdYFKvDDrUso=
X-Google-Smtp-Source: APBJJlG5JBpFXSpYkujzv5ba8Q7szzhjdX1gtlKQT1JGi4qRfNswd5Fg7/nA9GyJFRd+ADWUJ7eHvT5Z8naocNKlMMI=
X-Received: by 2002:a81:728b:0:b0:577:2f3f:dd20 with SMTP id
 n133-20020a81728b000000b005772f3fdd20mr23595711ywc.34.1691073160252; Thu, 03
 Aug 2023 07:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230731111313.3745-1-laoar.shao@gmail.com> <20230731111313.3745-3-laoar.shao@gmail.com>
 <7256b868-f475-0ecc-a5b4-2d0015c1de08@linux.dev>
In-Reply-To: <7256b868-f475-0ecc-a5b4-2d0015c1de08@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 3 Aug 2023 22:32:04 +0800
Message-ID: <CALOAHbAz1a-9X8oW2948kx3+4DsekrQ37C87X6kRMbjBaB12wA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Add selftest for fill_link_info
To: yonghong.song@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 7:00=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 7/31/23 4:13 AM, Yafang Shao wrote:
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
> > ---
> >   tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 +
> >   .../selftests/bpf/prog_tests/fill_link_info.c      | 369 ++++++++++++=
+++++++++
> >   .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
> >   3 files changed, 414 insertions(+)
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
> > index 0000000..948ae60
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > @@ -0,0 +1,369 @@
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
> > +     switch (info.type) {
> > +     case BPF_LINK_TYPE_PERF_EVENT:
> > +             if (!ASSERT_EQ(info.perf_event.type, type, "perf_type_mat=
ch"))
> > +                     return -1;
> > +
> > +             switch (info.perf_event.type) {
> > +             case BPF_PERF_EVENT_KPROBE:
> > +             case BPF_PERF_EVENT_KRETPROBE:
> > +                     ASSERT_EQ(info.perf_event.kprobe.offset, offset, =
"kprobe_offset");
> > +
> > +                     /* In case kptr setting is not permitted or MAX_S=
YMS is reached */
>
> 'kptr' has special meaning in bpf ecosystem (searching verifier.c).
> Could you re-word the above comments? I am not sure what it means.

It is the kernel.kptr_restrict sysctl knob.
Will re-word it.

>
> > +                     if (addr)
> > +                             ASSERT_EQ(info.perf_event.kprobe.addr, ad=
dr + entry_offset,
> > +                                       "kprobe_addr");
> > +
> > +                     if (!info.perf_event.kprobe.func_name) {
> > +                             ASSERT_EQ(info.perf_event.kprobe.name_len=
, 0, "name_len");
> > +                             info.perf_event.kprobe.func_name =3D ptr_=
to_u64(&buf);
> > +                             info.perf_event.kprobe.name_len =3D sizeo=
f(buf);
> > +                             goto again;
> > +                     }
> > +
> > +                     err =3D strncmp(u64_to_ptr(info.perf_event.kprobe=
.func_name), KPROBE_FUNC,
> > +                                   strlen(KPROBE_FUNC));
> > +                     ASSERT_EQ(err, 0, "cmp_kprobe_func_name");
> > +                     break;
> > +             case BPF_PERF_EVENT_TRACEPOINT:
> > +                     if (!info.perf_event.tracepoint.tp_name) {
> > +                             ASSERT_EQ(info.perf_event.tracepoint.name=
_len, 0, "name_len");
> > +                             info.perf_event.tracepoint.tp_name =3D pt=
r_to_u64(&buf);
> > +                             info.perf_event.tracepoint.name_len =3D s=
izeof(buf);
> > +                             goto again;
> > +                     }
> > +
> > +                     err =3D strncmp(u64_to_ptr(info.perf_event.tracep=
oint.tp_name), TP_NAME,
> > +                                   strlen(TP_NAME));
> > +                     ASSERT_EQ(err, 0, "cmp_tp_name");
> > +                     break;
> > +             case BPF_PERF_EVENT_UPROBE:
> > +             case BPF_PERF_EVENT_URETPROBE:
> > +                     ASSERT_EQ(info.perf_event.uprobe.offset, offset, =
"uprobe_offset");
> > +
> > +                     if (!info.perf_event.uprobe.file_name) {
> > +                             ASSERT_EQ(info.perf_event.uprobe.name_len=
, 0, "name_len");
> > +                             info.perf_event.uprobe.file_name =3D ptr_=
to_u64(&buf);
> > +                             info.perf_event.uprobe.name_len =3D sizeo=
f(buf);
> > +                             goto again;
> > +                     }
> > +
> > +                     err =3D strncmp(u64_to_ptr(info.perf_event.uprobe=
.file_name), UPROBE_FILE,
> > +                                   strlen(UPROBE_FILE));
> > +                     ASSERT_EQ(err, 0, "cmp_file_name");
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> > +     default:
> > +             switch (type) {
> > +             case BPF_PERF_EVENT_KPROBE:
> > +             case BPF_PERF_EVENT_KRETPROBE:
> > +             case BPF_PERF_EVENT_TRACEPOINT:
> > +             case BPF_PERF_EVENT_UPROBE:
> > +             case BPF_PERF_EVENT_URETPROBE:
> > +                     err =3D -1;
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
>
> Is this whole 'default' thing ever possible?
> Maybe you should have ASSERT_EQ(info.type, BPF_LINK_TYPE_PERF_EVENT)
> first and then you won't need a top switch statement?

Will change it.

>
>
> > +     }
> > +     return err;
> > +}
> > +
> > +static void kprobe_fill_invalid_user_buffer(int fd)
> > +{
> > +     struct bpf_link_info info;
> > +     __u32 len =3D sizeof(info);
> > +     int err;
> > +
> > +     memset(&info, 0, sizeof(info));
> > +
> > +     info.perf_event.kprobe.func_name =3D 0x1; /* invalid address */
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, -EINVAL, "invalid_buff_and_len");
> > +
> > +     info.perf_event.kprobe.name_len =3D 64;
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, -EFAULT, "invalid_buff");
> > +
> > +     info.perf_event.kprobe.func_name =3D 0;
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, -EINVAL, "invalid_len");
> > +
> > +     ASSERT_EQ(info.perf_event.kprobe.addr, 0, "func_addr");
> > +     ASSERT_EQ(info.perf_event.kprobe.offset, 0, "func_offset");
> > +     ASSERT_EQ(info.perf_event.type, 0, "type");
> > +}
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
> > +     if (!ASSERT_GE(link_fd, 0, "link_fd"))
> > +             return;
>
> There is no need to check validity of link_fd if skel->links.kprobe_run
> is valid.

Will change it and the others.

>
> > +
> > +     addr =3D ksym_get_addr(KPROBE_FUNC);
> > +     if (!invalid) {
> > +             /* See also arch_adjust_kprobe_addr(). */
> > +             if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
> > +                     entry_offset =3D 4;
> > +             err =3D verify_perf_link_info(link_fd, type, addr, offset=
, offset ?: entry_offset);
>
> offset is always 0 here.

Will simplify it.

>
> > +             ASSERT_OK(err, "verify_perf_link_info");
> > +     } else {
> > +             kprobe_fill_invalid_user_buffer(link_fd);
> > +     }
> > +     bpf_link__detach(skel->links.kprobe_run);
> > +}
> > +
> > +static void test_tp_fill_link_info(struct test_fill_link_info *skel)
> > +{
> > +     int link_fd, err;
> > +
> > +     skel->links.tp_run =3D bpf_program__attach_tracepoint(skel->progs=
.tp_run, TP_CAT, TP_NAME);
> > +     if (!ASSERT_OK_PTR(skel->links.tp_run, "attach_tp"))
> > +             return;
> > +
> > +     link_fd =3D bpf_link__fd(skel->links.tp_run);
> > +     if (!ASSERT_GE(link_fd, 0, "link_fd"))
> > +             return;
>
> No need to check link_fd.
>
> > +
> > +     err =3D verify_perf_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT,=
 0, 0, 0);
> > +     ASSERT_OK(err, "verify_perf_link_info");
> > +     bpf_link__detach(skel->links.tp_run);
> > +}
> > +
> > +static void test_uprobe_fill_link_info(struct test_fill_link_info *ske=
l,
> > +                                    enum bpf_perf_event_type type, ssi=
ze_t offset,
> > +                                    bool retprobe)
> > +{
> > +     int link_fd, err;
> > +
> > +     skel->links.uprobe_run =3D bpf_program__attach_uprobe(skel->progs=
.uprobe_run, retprobe,
> > +                                                         0, /* self pi=
d */
> > +                                                         UPROBE_FILE, =
offset);
> > +     if (!ASSERT_OK_PTR(skel->links.uprobe_run, "attach_uprobe"))
> > +             return;
> > +
> > +     link_fd =3D bpf_link__fd(skel->links.uprobe_run);
> > +     if (!ASSERT_GE(link_fd, 0, "link_fd"))
> > +             return;
>
> No need to check link_fd.
>
> > +
> > +     err =3D verify_perf_link_info(link_fd, type, 0, offset, 0);
> > +     ASSERT_OK(err, "verify_perf_link_info");
> > +     bpf_link__detach(skel->links.uprobe_run);
> > +}
> > +
> > +static int verify_kmulti_link_info(int fd, const __u64 *addrs, bool re=
tprobe)
> > +{
> > +     __u64 kmulti_addrs[KMULTI_CNT];
> > +     struct bpf_link_info info;
> > +     __u32 len =3D sizeof(info);
> > +     int flags, i, err =3D 0;
> > +
> > +     memset(&info, 0, sizeof(info));
> > +
> > +again:
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     if (!ASSERT_OK(err, "get_link_info"))
> > +             return -1;
> > +
> > +     ASSERT_EQ(info.type, BPF_LINK_TYPE_KPROBE_MULTI, "kmulti_type");
>
> You can do
>         if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_KPROBE_MULTI, "kmulti_typ=
e"))
>                 return -1;
>
> and then there is no need for below switch statement.

Will change it.

>
> > +     switch (info.type) {
> > +     case BPF_LINK_TYPE_KPROBE_MULTI:
> > +             ASSERT_EQ(info.kprobe_multi.count, KMULTI_CNT, "func_cnt"=
);
> > +             flags =3D info.kprobe_multi.flags & BPF_F_KPROBE_MULTI_RE=
TURN;
> > +             if (!retprobe)
> > +                     ASSERT_EQ(flags, 0, "kmulti_flags");
> > +             else
> > +                     ASSERT_NEQ(flags, 0, "kretmulti_flags");
> > +
> > +             if (!info.kprobe_multi.addrs) {
> > +                     info.kprobe_multi.addrs =3D ptr_to_u64(kmulti_add=
rs);
> > +                     goto again;
> > +             }
> > +             for (i =3D 0; i < KMULTI_CNT; i++)
> > +                     ASSERT_EQ(kmulti_addrs[i], addrs[i], "kmulti_addr=
s");
> > +             break;
> > +     default:
> > +             err =3D -1;
> > +             break;
> > +     }
> > +     return err;
> > +}
> > +
> > +static void verify_kmulti_user_buffer(int fd, const __u64 *addrs)
> > +{
> > +     __u64 kmulti_addrs[KMULTI_CNT];
> > +     struct bpf_link_info info;
> > +     __u32 len =3D sizeof(info);
> > +     int err, i;
> > +
> > +     memset(&info, 0, sizeof(info));
> > +
> > +     info.kprobe_multi.count =3D KMULTI_CNT;
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, -EINVAL, "no_addr");
> > +
> > +     info.kprobe_multi.addrs =3D ptr_to_u64(kmulti_addrs);
> > +     info.kprobe_multi.count =3D 0;
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, -EINVAL, "no_cnt");
> > +
> > +     for (i =3D 0; i < KMULTI_CNT; i++)
> > +             kmulti_addrs[i] =3D 0;
> > +     info.kprobe_multi.count =3D KMULTI_CNT - 1;
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, -ENOSPC, "smaller_cnt");
> > +     for (i =3D 0; i < KMULTI_CNT - 1; i++)
> > +             ASSERT_EQ(kmulti_addrs[i], addrs[i], "kmulti_addrs");
> > +     ASSERT_EQ(kmulti_addrs[i], 0, "kmulti_addrs");
> > +
> > +     for (i =3D 0; i < KMULTI_CNT; i++)
> > +             kmulti_addrs[i] =3D 0;
> > +     info.kprobe_multi.count =3D KMULTI_CNT + 1;
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, 0, "bigger_cnt");
> > +     for (i =3D 0; i < KMULTI_CNT; i++)
> > +             ASSERT_EQ(kmulti_addrs[i], addrs[i], "kmulti_addrs");
> > +
> > +     info.kprobe_multi.count =3D KMULTI_CNT;
> > +     info.kprobe_multi.addrs =3D 0x1; /* invalid addr */
> > +     err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> > +     ASSERT_EQ(err, -EFAULT, "invalid_buff");
> > +}
> > +
> > +static int symbols_cmp_r(const void *a, const void *b)
> > +{
> > +     const char **str_a =3D (const char **) a;
> > +     const char **str_b =3D (const char **) b;
> > +
> > +     return strcmp(*str_a, *str_b);
> > +}
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
> > +     if (!ASSERT_GE(link_fd, 0, "link_fd"))
> > +             return;
>
> No need to check link_fd.
>
> > +
> > +     for (i =3D 0; i < KMULTI_CNT; i++)
> > +             addrs[i] =3D ksym_get_addr(syms[i]);
> > +
> > +     if (!buffer)
> > +             err =3D verify_kmulti_link_info(link_fd, addrs, retprobe)=
;
> > +     else
> > +             verify_kmulti_user_buffer(link_fd, addrs);
> > +     ASSERT_OK(err, "verify_kmulti_link_info");
> > +     bpf_link__detach(skel->links.kmulti_run);
> > +}
> > +
> > +void test_fill_link_info(void)
> > +{
> > +     struct test_fill_link_info *skel;
> > +     ssize_t offset;
> > +
> > +     skel =3D test_fill_link_info__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "skel_open"))
> > +             goto cleanup;
>
> Just return here if skel is invalid.

Will change it.

>
> > +
> > +     /* load kallsyms to compare the addr */
> > +     if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
> > +             return;
>
> You actually need to go to 'cleanup' here.

will change it.

--=20
Regards
Yafang

