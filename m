Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A161F125B21
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 06:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfLSF64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 00:58:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42190 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfLSF64 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 00:58:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id z14so2466777qkg.9
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 21:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dt3M2L0p8ec0hogt/EdarQMFj7CZ3Qo4uWUehotx128=;
        b=a9Ges/fFYhgBPv0PCXN7438mgG8KdPC3/pdTU4ngcEFqIR9+I/T26wvfi08+3qF2bM
         4gwI2KI7gPxe2BZyoO1m5bRsac1qQK6W65OTM5EiYuB31rcpve1EakMJVNDLDWacEdI4
         wgCnaGg89KPa1b4QU5HTTDLa62nOFc0bn7y1gax+H46cYJl8OYn3vu2Jlke4m7yTjBwx
         e6GH2Pbx9EuFQoPSV11kpXPMjfcdoEdO2X9iZBG8yYKtNew2m+jVkFa6gNyha6wOv+0B
         twnip5o7fnaS4MTLb+GAMXQhbDWbKphxH/C/792NvaRN7UghiZBwf1Lw9AQ3u58tGN6N
         kdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dt3M2L0p8ec0hogt/EdarQMFj7CZ3Qo4uWUehotx128=;
        b=RofkF6rnlnYJpzyoaIHjsKi2RGLXk6ZswqMg+AOB397MZo7uimWhjGY6IATXtrD79Y
         zyOAoE+hQROvwpnojERIrmtoCXzWIXYnbJZcq4M1QMaktcfOdBq3VbsL1OH53Lfi6bNy
         8t8gypDuSmKwJVzVe/xhIO0WahcB5anfO08TsXkqTVN8ZelvxNjUDdVaVg5cayOIxJB4
         vvLQHcyq4FDKmbNZQa2CsOps8KD5wSHVF4sepaRpx28ylMY8l/YRhY7ZNmG2xdIVl0W7
         Bp1xRlX8ArsUgUQ4So6hyFMe7v7oEEYiTbz+WlzZvOUNQXpUlUE5AKB+2mGxJdbrmQLu
         Rb7w==
X-Gm-Message-State: APjAAAUL3JBGrJdLpPQUpTH2J9KpBZwfGWyJK2ljl/S/+jYMMGLB2kFu
        banSD8R/JkLCEma2W6ih83VVYC9aDdxaAoTlr4E=
X-Google-Smtp-Source: APXvYqzR1JQpoQ7Eod5ObASo7GWN0q1vL/QSdlNyfgtQmZtYE6O9x969Lj7USIaphkxfrZS8QCAokadbYpxk6dEWkl0=
X-Received: by 2002:a37:e408:: with SMTP id y8mr6484146qkf.39.1576735134898;
 Wed, 18 Dec 2019 21:58:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576720240.git.rdna@fb.com> <31ac56887591418c2c098fabc14ad00de008e603.1576720240.git.rdna@fb.com>
In-Reply-To: <31ac56887591418c2c098fabc14ad00de008e603.1576720240.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 18 Dec 2019 21:58:43 -0800
Message-ID: <CAEf4BzYWJLJgCt4QCcThg4-kbPr=L+Nv2A5Nd0YknWWkuM05tg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 6/6] selftests/bpf: Test BPF_F_REPLACE in cgroup_attach_multi
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 18, 2019 at 6:17 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Test replacing a cgroup-bpf program attached with BPF_F_ALLOW_MULTI and
> possible failure modes: invalid combination of flags, invalid
> replace_bpf_fd, replacing a non-attachd to specified cgroup program.
>
> Example of program replacing:
>
>   # gdb -q --args ./test_progs --name=cgroup_attach_multi
>   ...
>   Breakpoint 1, test_cgroup_attach_multi () at cgroup_attach_multi.c:227
>   (gdb)
>   [1]+  Stopped                 gdb -q --args ./test_progs --name=cgroup_attach_multi
>   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
>   ID       AttachType      AttachFlags     Name
>   2133     egress          multi
>   2134     egress          multi
>   # fg
>   gdb -q --args ./test_progs --name=cgroup_attach_multi
>   (gdb) c
>   Continuing.
>
>   Breakpoint 2, test_cgroup_attach_multi () at cgroup_attach_multi.c:233
>   (gdb)
>   [1]+  Stopped                 gdb -q --args ./test_progs --name=cgroup_attach_multi
>   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
>   ID       AttachType      AttachFlags     Name
>   2139     egress          multi
>   2134     egress          multi
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  .../bpf/prog_tests/cgroup_attach_multi.c      | 53 +++++++++++++++++--
>  1 file changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> index 4eaab7435044..2ff21dbce179 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> @@ -78,7 +78,8 @@ void test_cgroup_attach_multi(void)
>  {
>         __u32 prog_ids[4], prog_cnt = 0, attach_flags, saved_prog_id;
>         int cg1 = 0, cg2 = 0, cg3 = 0, cg4 = 0, cg5 = 0, key = 0;
> -       int allow_prog[6] = {-1};
> +       DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts);
> +       int allow_prog[7] = {-1};
>         unsigned long long value;
>         __u32 duration = 0;
>         int i = 0;
> @@ -189,6 +190,52 @@ void test_cgroup_attach_multi(void)
>         CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
>         CHECK_FAIL(value != 1 + 2 + 8 + 16);
>
> +       /* test replace */
> +
> +       attach_opts.flags = BPF_F_ALLOW_OVERRIDE | BPF_F_REPLACE;
> +       attach_opts.replace_prog_fd = allow_prog[0];
> +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> +                 "fail_prog_replace_override", "unexpected success\n"))
> +               goto err;
> +       CHECK_FAIL(errno != EINVAL);

CHECK macro above can prints both in success and failure scenarios,
which means that errno of bpf_prog_attach_xattr can be overriden by a
bunch of other functions. So if this check is critical, you'd have to
remember errno before calling CHECK. Same for all the check below.

> +
> +       attach_opts.flags = BPF_F_REPLACE;
> +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> +                 "fail_prog_replace_no_multi", "unexpected success\n"))
> +               goto err;
> +       CHECK_FAIL(errno != EINVAL);
> +
> +       attach_opts.flags = BPF_F_ALLOW_MULTI | BPF_F_REPLACE;
> +       attach_opts.replace_prog_fd = -1;
> +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> +                 "fail_prog_replace_bad_fd", "unexpected success\n"))
> +               goto err;
> +       CHECK_FAIL(errno != EBADF);
> +
> +       /* replacing a program that is not attached to cgroup should fail  */
> +       attach_opts.replace_prog_fd = allow_prog[3];
> +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> +                 "fail_prog_replace_no_ent", "unexpected success\n"))
> +               goto err;
> +       CHECK_FAIL(errno != ENOENT);
> +
> +       /* replace 1st from the top program */
> +       attach_opts.replace_prog_fd = allow_prog[0];
> +       if (CHECK(bpf_prog_attach_xattr(allow_prog[6], cg1,
> +                                       BPF_CGROUP_INET_EGRESS, &attach_opts),
> +                 "prog_replace", "errno=%d\n", errno))
> +               goto err;
> +
> +       value = 0;
> +       CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
> +       CHECK_FAIL(system(PING_CMD));
> +       CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> +       CHECK_FAIL(value != 64 + 2 + 8 + 16);
> +
>         /* detach 3rd from bottom program and ping again */
>         if (CHECK(!bpf_prog_detach2(0, cg3, BPF_CGROUP_INET_EGRESS),
>                   "fail_prog_detach_from_cg3", "unexpected success\n"))
> @@ -202,7 +249,7 @@ void test_cgroup_attach_multi(void)
>         CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
>         CHECK_FAIL(system(PING_CMD));
>         CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> -       CHECK_FAIL(value != 1 + 2 + 16);
> +       CHECK_FAIL(value != 64 + 2 + 16);
>
>         /* detach 2nd from bottom program and ping again */
>         if (CHECK(bpf_prog_detach2(-1, cg4, BPF_CGROUP_INET_EGRESS),
> @@ -213,7 +260,7 @@ void test_cgroup_attach_multi(void)
>         CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
>         CHECK_FAIL(system(PING_CMD));
>         CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> -       CHECK_FAIL(value != 1 + 2 + 4);
> +       CHECK_FAIL(value != 64 + 2 + 4);
>
>         prog_cnt = 4;
>         CHECK_FAIL(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS,
> --
> 2.17.1
>
