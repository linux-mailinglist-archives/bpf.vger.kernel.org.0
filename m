Return-Path: <bpf+bounces-5681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBF475E016
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 08:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10291C20A74
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 06:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18836EC7;
	Sun, 23 Jul 2023 06:32:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C7373
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 06:32:11 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443711BC7
	for <bpf@vger.kernel.org>; Sat, 22 Jul 2023 23:32:08 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7656652da3cso258260585a.1
        for <bpf@vger.kernel.org>; Sat, 22 Jul 2023 23:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690093927; x=1690698727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V++kUyqMXRkLbN1V3L64nbQn0qcB1reQlEScOc4R0DA=;
        b=okWdkoX7OJ8HItyNxNTuURGuSRgThaXftgLjYqb/oFASLOGRFJQJVDXgMHrEOV4g3z
         4tIHzgEHrdR9D6OIp2WJUfC3sJN0p2rp6aklHNrPz5hVXTyTtj4FELHJbVb2JYKEbTm7
         qczwAFePNOECxwRjxmdeC/ptbV2c5OMMuvk2BxOjCz06ZRL93B7dNj5bENUAjDNGd/it
         08SDYCCFZlZfURw/ZYwgEz/XMYpc8MByK6MpZArmaD/b5GFL1etGoZ57ANN63js7QJRk
         MaCN+gIVYSkRDyNAuf5NxMKIQnry8NPbzW1HISte3Kepnxea9xO6kqRLdcXZ/Du1YTT+
         sHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690093927; x=1690698727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V++kUyqMXRkLbN1V3L64nbQn0qcB1reQlEScOc4R0DA=;
        b=RH8RssMSx3ZgAe/YztGqXrWIwiRtwJPRZ3d5hqJTl9dnqDlGn4KPVcJM1lBusljkVo
         lkR8hTuZkubbnML1J5GYPpp1rmDaRLXT13qrZ0Wtw5HPh2VnpZ8P0I6/OWb73K7Uzz0b
         Mf0tcEisFhUZdqb+vAjD2aiWE/tBOoQf+z9cqEghWD1ypClw/syR708FjS7yJ8wZ7L+w
         obOXdNsnpsZp7/cCVb6ZAZoJNCHUfB21VI5fBFcenyYs42mrcs9OsQKPeRLaUinFD2vQ
         aMKioff1BQatpYfnqZXemXYZ8ft5lhTfj5aDbboWvXh/kXh1DeFMTLAHafCAhLWiOSz8
         1cbA==
X-Gm-Message-State: ABy/qLYw9jBZVhpPaNcUlsFsK/A5VGW8/x3DAH+/+Xe4GXOJ5nVEGshL
	12b+y/PEjm7iiYGABGbsGVO0F7rYeZ+Nyju2GEQ=
X-Google-Smtp-Source: APBJJlHYZWEbGa7GOtv0JsQqTFHegnweynqhFyhO7SBgVVQrhrV+7FeqS0Lm4yA9HPEzsLDhtLAOUk27OUML/nl+a6E=
X-Received: by 2002:a05:620a:2107:b0:767:261d:1ef6 with SMTP id
 l7-20020a05620a210700b00767261d1ef6mr4920488qkl.59.1690093927334; Sat, 22 Jul
 2023 23:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721092725.3795-1-laoar.shao@gmail.com> <20230721092725.3795-3-laoar.shao@gmail.com>
In-Reply-To: <20230721092725.3795-3-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 23 Jul 2023 14:31:31 +0800
Message-ID: <CALOAHbA8tLQ9=nXGzBiyZNwi+X5c9Rko1-eRWsehZfSP68eA4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for fill_link_info
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 5:27=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add selftest for the fill_link_info of uprobe, kprobe and tracepoint.
> The result:
>
>   #78/1    fill_link_info/kprobe_link_info:OK
>   #78/2    fill_link_info/kretprobe_link_info:OK
>   #78/3    fill_link_info/fill_invalid_user_buff:OK
>   #78/4    fill_link_info/tracepoint_link_info:OK
>   #78/5    fill_link_info/uprobe_link_info:OK
>   #78/6    fill_link_info/uretprobe_link_info:OK
>   #78      fill_link_info:OK
>   Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/fill_link_info.c      | 232 +++++++++++++++=
++++++
>  .../selftests/bpf/progs/test_fill_link_info.c      |  25 +++
>  2 files changed, 257 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> new file mode 100644
> index 0000000..9779a8a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#include <string.h>
> +#include <linux/bpf.h>
> +#include <linux/limits.h>
> +#include <test_progs.h>
> +#include "trace_helpers.h"
> +#include "test_fill_link_info.skel.h"
> +
> +#define TP_CAT "sched"
> +#define TP_NAME "sched_switch"
> +#define KPROBE_FUNC "tcp_rcv_established"
> +#define UPROBE_FILE "/proc/self/exe"
> +
> +/* uprobe attach point */
> +static noinline void uprobe_func(void)
> +{
> +       asm volatile ("");
> +}
> +
> +static int verify_link_info(int fd, enum bpf_perf_event_type type, long =
addr, ssize_t offset)
> +{
> +       struct bpf_link_info info;
> +       __u32 len =3D sizeof(info);
> +       char buf[PATH_MAX];
> +       int err =3D 0;
> +
> +       memset(&info, 0, sizeof(info));
> +       buf[0] =3D '\0';
> +
> +again:
> +       err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> +       if (!ASSERT_OK(err, "get_link_info"))
> +               return -1;
> +
> +       switch (info.type) {
> +       case BPF_LINK_TYPE_PERF_EVENT:
> +               if (!ASSERT_EQ(info.perf_event.type, type, "perf_type_mat=
ch"))
> +                       return -1;
> +
> +               switch (info.perf_event.type) {
> +               case BPF_PERF_EVENT_KPROBE:
> +               case BPF_PERF_EVENT_KRETPROBE:
> +                       ASSERT_EQ(info.perf_event.kprobe.offset, offset, =
"kprobe_offset");
> +
> +                       /* In case kptr setting is not permitted or MAX_S=
YMS is reached */
> +                       if (addr)
> +                               ASSERT_EQ(info.perf_event.kprobe.addr, ad=
dr, "kprobe_addr");

The BPF CI failed due to this assertion. Because the 4 Bytes ENDBR
instructions are added into the function entry, in which case
info.perf_event.kprobe.addr will be (addr + 4).
Will improve this test case in the next version.

> +
> +                       if (!info.perf_event.kprobe.func_name) {
> +                               ASSERT_EQ(info.perf_event.kprobe.name_len=
, 0, "name_len");
> +                               info.perf_event.kprobe.func_name =3D ptr_=
to_u64(&buf);
> +                               info.perf_event.kprobe.name_len =3D sizeo=
f(buf);
> +                               goto again;
> +                       }
> +
> +                       err =3D strncmp(u64_to_ptr(info.perf_event.kprobe=
.func_name), KPROBE_FUNC,
> +                                     strlen(KPROBE_FUNC));
> +                       ASSERT_EQ(err, 0, "cmp_kprobe_func_name");
> +                       break;
> +               case BPF_PERF_EVENT_TRACEPOINT:
> +                       if (!info.perf_event.tracepoint.tp_name) {
> +                               ASSERT_EQ(info.perf_event.tracepoint.name=
_len, 0, "name_len");
> +                               info.perf_event.tracepoint.tp_name =3D pt=
r_to_u64(&buf);
> +                               info.perf_event.tracepoint.name_len =3D s=
izeof(buf);
> +                               goto again;
> +                       }
> +
> +                       err =3D strncmp(u64_to_ptr(info.perf_event.tracep=
oint.tp_name), TP_NAME,
> +                                     strlen(TP_NAME));
> +                       ASSERT_EQ(err, 0, "cmp_tp_name");
> +                       break;
> +               case BPF_PERF_EVENT_UPROBE:
> +               case BPF_PERF_EVENT_URETPROBE:
> +                       ASSERT_EQ(info.perf_event.uprobe.offset, offset, =
"uprobe_offset");
> +
> +                       if (!info.perf_event.uprobe.file_name) {
> +                               ASSERT_EQ(info.perf_event.uprobe.name_len=
, 0, "name_len");
> +                               info.perf_event.uprobe.file_name =3D ptr_=
to_u64(&buf);
> +                               info.perf_event.uprobe.name_len =3D sizeo=
f(buf);
> +                               goto again;
> +                       }
> +
> +                       err =3D strncmp(u64_to_ptr(info.perf_event.uprobe=
.file_name), UPROBE_FILE,
> +                                     strlen(UPROBE_FILE));
> +                       ASSERT_EQ(err, 0, "cmp_file_name");
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +       default:
> +               switch (type) {
> +               case BPF_PERF_EVENT_KPROBE:
> +               case BPF_PERF_EVENT_KRETPROBE:
> +               case BPF_PERF_EVENT_TRACEPOINT:
> +               case BPF_PERF_EVENT_UPROBE:
> +               case BPF_PERF_EVENT_URETPROBE:
> +                       err =3D -1;
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +       }
> +       return err;
> +}
> +
> +static void kprobe_fill_invalid_user_buffer(int fd)
> +{
> +       struct bpf_link_info info;
> +       __u32 len =3D sizeof(info);
> +       int err =3D 0;
> +
> +       memset(&info, 0, sizeof(info));
> +
> +       info.perf_event.kprobe.func_name =3D 0x1; /* invalid address */
> +       err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> +       ASSERT_EQ(err, -EINVAL, "invalid_buff_and_len");
> +
> +       info.perf_event.kprobe.name_len =3D 64;
> +       err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> +       ASSERT_EQ(err, -EFAULT, "invalid_buff");
> +
> +       info.perf_event.kprobe.func_name =3D 0;
> +       err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> +       ASSERT_EQ(err, -EINVAL, "invalid_len");
> +
> +       ASSERT_EQ(info.perf_event.kprobe.addr, 0, "func_addr");
> +       ASSERT_EQ(info.perf_event.kprobe.offset, 0, "func_offset");
> +       ASSERT_EQ(info.perf_event.type, 0, "type");
> +}
> +
> +static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
> +                                      enum bpf_perf_event_type type,
> +                                      bool retprobe, bool invalid)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts,
> +               .attach_mode =3D PROBE_ATTACH_MODE_LINK,
> +               .retprobe =3D retprobe,
> +       );
> +       int link_fd, err;
> +       long addr;
> +
> +       skel->links.kprobe_run =3D bpf_program__attach_kprobe_opts(skel->=
progs.kprobe_run,
> +                                                                KPROBE_F=
UNC, &opts);
> +       if (!ASSERT_OK_PTR(skel->links.kprobe_run, "attach_kprobe"))
> +               return;
> +
> +       link_fd =3D bpf_link__fd(skel->links.kprobe_run);
> +       if (!ASSERT_GE(link_fd, 0, "link_fd"))
> +               return;
> +
> +       addr =3D ksym_get_addr(KPROBE_FUNC);
> +       if (!invalid) {
> +               err =3D verify_link_info(link_fd, type, addr, 0);
> +               ASSERT_OK(err, "verify_link_info");
> +       } else {
> +               kprobe_fill_invalid_user_buffer(link_fd);
> +       }
> +       bpf_link__detach(skel->links.kprobe_run);
> +}
> +
> +static void test_tp_fill_link_info(struct test_fill_link_info *skel)
> +{
> +       int link_fd, err;
> +
> +       skel->links.tp_run =3D bpf_program__attach_tracepoint(skel->progs=
.tp_run, TP_CAT, TP_NAME);
> +       if (!ASSERT_OK_PTR(skel->links.tp_run, "attach_tp"))
> +               return;
> +
> +       link_fd =3D bpf_link__fd(skel->links.tp_run);
> +       if (!ASSERT_GE(link_fd, 0, "link_fd"))
> +               return;
> +
> +       err =3D verify_link_info(link_fd, BPF_PERF_EVENT_TRACEPOINT, 0, 0=
);
> +       ASSERT_OK(err, "verify_link_info");
> +       bpf_link__detach(skel->links.tp_run);
> +}
> +
> +static void test_uprobe_fill_link_info(struct test_fill_link_info *skel,
> +                                      enum bpf_perf_event_type type, ssi=
ze_t offset,
> +                                      bool retprobe)
> +{
> +       int link_fd, err;
> +
> +       skel->links.uprobe_run =3D bpf_program__attach_uprobe(skel->progs=
.uprobe_run, retprobe,
> +                                                           0, /* self pi=
d */
> +                                                           UPROBE_FILE, =
offset);
> +       if (!ASSERT_OK_PTR(skel->links.uprobe_run, "attach_uprobe"))
> +               return;
> +
> +       link_fd =3D bpf_link__fd(skel->links.uprobe_run);
> +       if (!ASSERT_GE(link_fd, 0, "link_fd"))
> +               return;
> +
> +       err =3D verify_link_info(link_fd, type, 0, offset);
> +       ASSERT_OK(err, "verify_link_info");
> +       bpf_link__detach(skel->links.uprobe_run);
> +}
> +
> +void serial_test_fill_link_info(void)
> +{
> +       struct test_fill_link_info *skel;
> +       ssize_t offset;
> +
> +       skel =3D test_fill_link_info__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               goto cleanup;
> +
> +       /* load kallsyms to compare the addr */
> +       if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
> +               return;
> +       if (test__start_subtest("kprobe_link_info"))
> +               test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, f=
alse, false);
> +       if (test__start_subtest("kretprobe_link_info"))
> +               test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KRETPROBE=
, true, false);
> +       if (test__start_subtest("fill_invalid_user_buff"))
> +               test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, f=
alse, true);
> +       if (test__start_subtest("tracepoint_link_info"))
> +               test_tp_fill_link_info(skel);
> +
> +       offset =3D get_uprobe_offset(&uprobe_func);
> +       if (test__start_subtest("uprobe_link_info"))
> +               test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_UPROBE, o=
ffset, false);
> +       if (test__start_subtest("uretprobe_link_info"))
> +               test_uprobe_fill_link_info(skel, BPF_PERF_EVENT_URETPROBE=
, offset, true);
> +
> +cleanup:
> +       test_fill_link_info__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/to=
ols/testing/selftests/bpf/progs/test_fill_link_info.c
> new file mode 100644
> index 0000000..f776134
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_tracing.h>
> +
> +SEC("kprobe")
> +int BPF_PROG(kprobe_run)
> +{
> +       return 0;
> +}
> +
> +SEC("uprobe")
> +int BPF_PROG(uprobe_run)
> +{
> +       return 0;
> +}
> +
> +SEC("tracepoint")
> +int BPF_PROG(tp_run)
> +{
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 1.8.3.1
>


--=20
Regards
Yafang

