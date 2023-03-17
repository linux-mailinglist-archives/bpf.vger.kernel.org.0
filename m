Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20BF6BEEAC
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 17:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCQQmM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCQQlb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 12:41:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A29271A
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:41:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so22669536edb.11
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679071287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJTJWTiY9rXVrtco97Fb8/hgauvrGle5evZ3/smQj7Y=;
        b=kIn4pYAjZvI+jixHU0AG3tedTU7ADkijS246bfExKEoC+jiN6Q3HeiJ4JU/FSUfYPo
         /qe8KyC4ef5XRMwaEiVzFEqLjXtaGl+coxABsvXueO+An8g2PBT1/Y+s/jmDomPcF9oi
         291ReXvMRB1VEw5HzYkpKzkoFj9VhV1a0jxyVFMTNo5xGclgYPSIyF7t8JpjJsGRrkHr
         Sn/GPyInXkJHOAiK6OMsmFS26DzT+PJpoEVU/ZngwsZVrlnZ0Uq1aKb9PAN4YogJ4DBP
         6R0QKlKchmG0QhBpajCC76KqNbVwaCKe9G4xb0BcI/lhyvKNTL4e2nQJTWFliG89xEuM
         lufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJTJWTiY9rXVrtco97Fb8/hgauvrGle5evZ3/smQj7Y=;
        b=jZ8rHi2qDYwtjLBhQG1IAGd46YlhwPgxJkb4wUXPKHP5nKY0ZHx3lzez+eQrq+1y2i
         6cUPZC+txmbADb9y9zbqCF5P+g9xIo6LsZhfxPoQ6wRuymGHfqABf7eViwhoYZJ4eH/Z
         WajQxUYJ1dQCbst1pgg2gSMLqbhYFY38l2NS665IbA2/xmnFdzbnQeOaO+h2SjDXHOD2
         kl7/GhFoJGDtkPqFE1qeE/29g9dWNgJOFstSEAmT7NWhqz3hEMFCG+urTvX0bT5OUGDp
         +6sFpgArzWUOs6id3qDoUwf9eK/vZrQ5iYbYZ9g+wmJTHSQda9o5C/g5xtBIxkZtcuWZ
         PpYQ==
X-Gm-Message-State: AO0yUKUQqFnotWOf+yXGLKNGatwISy00K0wEovIXbK+cErpsGpPNTZY9
        f+55SWqh36EC2A1W3rSZ0ckMoMf5zglruUkq6fo=
X-Google-Smtp-Source: AK7set/hWrovmAIAefrjTkNnIVAQkCSL7MXazVMqLe9cauOr6ZOZnxTlZcDkybC+PBwY7AU4iZdPMUGHzn7q4AywYvw=
X-Received: by 2002:a50:d0cd:0:b0:4fc:f0b8:7da0 with SMTP id
 g13-20020a50d0cd000000b004fcf0b87da0mr2146555edf.1.1679071286802; Fri, 17 Mar
 2023 09:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230317114832.13622-1-laoar.shao@gmail.com>
In-Reply-To: <20230317114832.13622-1-laoar.shao@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 09:41:15 -0700
Message-ID: <CAEf4BzbdFHt00E+XbZdmT4wYFfx8isfvRQ9JpbUkDaH30XaMtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Filter out preempt_count_
 functions from kprobe_multi bench
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 17, 2023 at 4:49=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> It hits below warning on my test machine when running test_progs,
>
> [  702.223611] ------------[ cut here ]------------
> [  702.224168] RCU not on for: preempt_count_sub+0x0/0xa0
> [  702.224770] WARNING: CPU: 14 PID: 5267 at include/linux/trace_recursio=
n.h:162 fprobe_handler.part.0+0x1b8/0x1c0
> [  702.231740] CPU: 14 PID: 5267 Comm: main_amd64 Kdump: loaded Tainted: =
G           O       6.2.0+ #584
> [  702.233169] RIP: 0010:fprobe_handler.part.0+0x1b8/0x1c0
> [  702.241388] Call Trace:
> [  702.241615]  <TASK>
> [  702.241811]  fprobe_handler+0x22/0x30
> [  702.242129]  0xffffffffc04710f7
> [  702.242417] RIP: 0010:preempt_count_sub+0x5/0xa0
> [  702.242809] Code: c8 50 68 94 42 0e b5 48 cf e9 f9 fd ff ff 0f 1f 80 0=
0 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 4b cd 38 0b <=
55> 8b 0d 9c d0 cf 02 48 89 e5 85 c9 75 1b 65 8b 05 be 78 f4 4a 89
> [  702.244752] RSP: 0018:ffffaf6187d27f10 EFLAGS: 00000082 ORIG_RAX: 0000=
000000000000
> [  702.245801] RAX: 000000000000000e RBX: 0000000001b6ab72 RCX: 000000000=
0000000
> [  702.246804] RDX: 0000000000000000 RSI: ffffffffb627967d RDI: 000000000=
0000001
> [  702.247801] RBP: ffffaf6187d27f30 R08: 0000000000000000 R09: 000000000=
0000000
> [  702.248786] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
00000ca
> [  702.249782] R13: ffffaf6187d27f58 R14: 0000000000000000 R15: 000000000=
0000000
> [  702.250785]  ? preempt_count_sub+0x5/0xa0
> [  702.251540]  ? syscall_enter_from_user_mode+0x96/0xc0
> [  702.252368]  ? preempt_count_sub+0x5/0xa0
> [  702.253104]  ? syscall_enter_from_user_mode+0x96/0xc0
> [  702.253918]  do_syscall_64+0x16/0x90
> [  702.254613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [  702.255422] RIP: 0033:0x46b793
>
> It's caused by bench test attaching kprobe_multi link to preempt_count_su=
b
> function, which is not executed in rcu safe context so the kprobe handler
> on top of it will trigger the rcu warning.
>
> Filtering out preempt_count_ functions from the bench test.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 22be0a9..5561b93 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -379,6 +379,8 @@ static int get_syms(char ***symsp, size_t *cntp, bool=
 kernel)
>                 if (!strncmp(name, "__ftrace_invalid_address__",
>                              sizeof("__ftrace_invalid_address__") - 1))
>                         continue;
> +               if (!strncmp(name, "preempt_count_", strlen("preempt_coun=
t_")))
> +                       continue;
>

let's add str_has_pfx() helper macro from libbpf_internal.h to
test_progs.h and use that instead of repeating each substring twice?

Here's what libbpf is doing:

/* Check whether a string `str` has prefix `pfx`, regardless if `pfx` is
 * a string literal known at compilation time or char * pointer known only =
at
 * runtime.
 */
#define str_has_pfx(str, pfx) \
        (strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1
: strlen(pfx)) =3D=3D 0)


>                 err =3D hashmap__add(map, name, 0);
>                 if (err =3D=3D -EEXIST)
> --
> 1.8.3.1
>
