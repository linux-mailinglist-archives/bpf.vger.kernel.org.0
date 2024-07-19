Return-Path: <bpf+bounces-35105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B49937BF7
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 19:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2EFB20DE7
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09CE146A8E;
	Fri, 19 Jul 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YobGSJai"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8F250EC
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411901; cv=none; b=YuNrLYC6mIVm/xMDInztbSAmZrieh4geNhwwxFuR7n54EP7w6ccUrRYJNKCWTU6MThhouOI5xoAO9tHCem4DUR4DPjIup1NMmHpAf3V8jDg+Ge7ZjouCaDQCs9I+GbdsiiDSfrDi/frM5JMrXUUr8zy/eGD/x7RxntJ6tDL49aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411901; c=relaxed/simple;
	bh=BwdG5HwVyarC8fE6hM5eA5wbkhq8mm6s6hI2ey8K+6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9W02mLpoMWeHrFoNLiWR47ND1+LRySMFBUI1dnB8S0aDXahmTB3yYhmS1A1UDRvlumbZSwT+8X7xPjeK5jxVOtEv6IP7tJ4CinLj3T5CSmWqUGOUyxlr4RSUQnEDcm2kjT2TSCU+hVkj1YrN0DpMztr/lO6rqrWKWndhtXY2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YobGSJai; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-765590154b4so1503871a12.0
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721411899; x=1722016699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sk/BdWzi7K5Tie46asWoIHyvL+Pl61U0wRyTTp+e5EU=;
        b=YobGSJaitYvFWa7G3GpNOZr0zcrJ6JlevEURBY+k9GVIJk3FpuL2P1BSLfONXKyhgw
         C4IT9tUXIa+QEhIU2Q8Jy5sN9+9zTCQR5gcWho1CqL6evNa0myVn4YyX1ALt1UMcq9ou
         +xO5xT6ErxvXj2HgirGxaylj7FGVL25qYEr2bPLzlfKSSaG1ys0lZym+0IGFF4NYpeNZ
         dT9hSYKiFd16DsKDWHhifU8yOJjN0mtEIaqqDYi1OjGynNKuvWP6eWeghW9VnulIjC8y
         HJjT7glFISh45FW8R1RRmbvvp57WXOJChO8kD6TBQNK5EP4IA9yqaydY4vIKK2FWWP2q
         DAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721411899; x=1722016699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sk/BdWzi7K5Tie46asWoIHyvL+Pl61U0wRyTTp+e5EU=;
        b=e9kYiCJ1SNyPNoJhJwITUKpeSOY9DGtwSRkqn1rA3ittbOtAHTtEivlRSoLiHG8Sxz
         axjLoe26PuoeKUUF9pJ9Du55RwqHT5uMUE6ZQl2k4U41lhRutpy9SmCKdxLVVYpAShYM
         OwXWRWnQeexUHdp7XLCkMuy23os7Lsts0kOkUuw/kACFou1uIzXEUHxa/yeYGpZPsmun
         AR3fw3a2uQttqS0XLftFE1lM03WB1k9yUZbPqK6vYOpRF+vOwXwHATMYHm3LBVHaVLVV
         IesN8h3jU7R1xInRgO6nQBqx/ILqQb6bvtllL+q7xCTaoslnTF9sRJSFeCtRWOigi/dh
         6u/w==
X-Forwarded-Encrypted: i=1; AJvYcCWeu8rxnN2yz8z3jszdNDMWl9aK0+9Xs/IfnV64Vv10lqMuIiohKJ/NdUUOhokk8anG9U2BuOGZ3I2w1+Gi8Rl4aZjv
X-Gm-Message-State: AOJu0YxzR1R2EfiJjmGljsMz5pzYHl0PBgi/o8ewSIlHvrc3SbgIEopZ
	3DTJwVv6JnN4pXjaByCVzrdgZ5vA6nEzwmh63Xr8CguHcCB6YkEyC9kUEuLbipob88x+BG4qjcf
	Vq9ZiO7Vu4PrHmKjV7pXxdgnnNFg=
X-Google-Smtp-Source: AGHT+IG96lHxGNJ7nuGWk9bBO1dpmY8WSAj0SL/8gr9afHkdg4CIjNvn1vIBixC+s7uJFFylib9e0BFctedVfJn7ELA=
X-Received: by 2002:a05:6a20:748e:b0:1c0:e5d1:619e with SMTP id
 adf61e73a8af0-1c42289bc20mr1035675637.18.1721411899084; Fri, 19 Jul 2024
 10:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718132750.2914808-1-jolsa@kernel.org> <20240718132750.2914808-3-jolsa@kernel.org>
In-Reply-To: <20240718132750.2914808-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 10:58:07 -0700
Message-ID: <CAEf4BzaSM1iBuC0kL8s2J_Xh1BxE90QE-8ypsqJKb1TP8t48Cg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/2] selftests/bpf: Add uprobe multi consumers test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 6:28=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that attached/detaches multiple consumers on

typo: attaches

> single uprobe and verifies all were hit as expected.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 211 +++++++++++++++++-
>  .../bpf/progs/uprobe_multi_consumers.c        |  39 ++++
>  2 files changed, 249 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consum=
ers.c
>

LGTM, took me a bit of extra time to validate the counting logic, but
it looks correct.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index da8873f24a53..5228085c2240 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -6,6 +6,7 @@
>  #include "uprobe_multi.skel.h"
>  #include "uprobe_multi_bench.skel.h"
>  #include "uprobe_multi_usdt.skel.h"
> +#include "uprobe_multi_consumers.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "testing_helpers.h"
>  #include "../sdt.h"
> @@ -581,7 +582,7 @@ static void attach_uprobe_fail_refctr(struct uprobe_m=
ulti *skel)
>                 goto cleanup;
>
>         /*
> -        * We attach to 3 uprobes on 2 functions so 2 uprobes share singl=
e function,
> +        * We attach to 3 uprobes on 2 functions, so 2 uprobes share sing=
le function,

this probably belongs in patch #1

>          * but with different ref_ctr_offset which is not allowed and res=
ults in fail.
>          */
>         offsets[0] =3D tmp_offsets[0]; /* uprobe_multi_func_1 */
> @@ -722,6 +723,212 @@ static void test_link_api(void)
>         __test_link_api(child);
>  }
>
> +static struct bpf_program *
> +get_program(struct uprobe_multi_consumers *skel, int prog)
> +{
> +       switch (prog) {
> +       case 0:
> +               return skel->progs.uprobe_0;
> +       case 1:
> +               return skel->progs.uprobe_1;
> +       case 2:
> +               return skel->progs.uprobe_2;
> +       case 3:
> +               return skel->progs.uprobe_3;
> +       default:
> +               ASSERT_FAIL("get_program");
> +               return NULL;
> +       }
> +}
> +
> +static struct bpf_link **
> +get_link(struct uprobe_multi_consumers *skel, int link)
> +{
> +       switch (link) {
> +       case 0:
> +               return &skel->links.uprobe_0;
> +       case 1:
> +               return &skel->links.uprobe_1;
> +       case 2:
> +               return &skel->links.uprobe_2;
> +       case 3:
> +               return &skel->links.uprobe_3;
> +       default:
> +               ASSERT_FAIL("get_link");
> +               return NULL;
> +       }
> +}
> +
> +static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx)
> +{
> +       struct bpf_program *prog =3D get_program(skel, idx);
> +       struct bpf_link **link =3D get_link(skel, idx);
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> +
> +       /*
> +        * bit/prog: 0,1 uprobe entry
> +        * bit/prog: 2,3 uprobe return
> +        */
> +       opts.retprobe =3D idx =3D=3D 2 || idx =3D=3D 3;
> +
> +       *link =3D bpf_program__attach_uprobe_multi(prog, 0, "/proc/self/e=
xe",


this will crash if idx is wrong, let's add explicit NULL checks for
link and prog, just to fail gracefully?


> +                                               "uprobe_session_consumer_=
test",
> +                                               &opts);
> +       if (!ASSERT_OK_PTR(*link, "bpf_program__attach_uprobe_multi"))
> +               return -1;
> +       return 0;
> +}
> +
> +static void uprobe_detach(struct uprobe_multi_consumers *skel, int idx)
> +{
> +       struct bpf_link **link =3D get_link(skel, idx);
> +
> +       bpf_link__destroy(*link);
> +       *link =3D NULL;
> +}
> +
> +static bool test_bit(int bit, unsigned long val)
> +{
> +       return val & (1 << bit);
> +}
> +
> +noinline int
> +uprobe_session_consumer_test(struct uprobe_multi_consumers *skel,

this gave me pause, I was frantically recalling when did we end up
landing uprobe sessions support :)


> +                            unsigned long before, unsigned long after)
> +{
> +       int idx;
> +
> +       /* detach uprobe for each unset programs in 'before' state ... */
> +       for (idx =3D 0; idx < 4; idx++) {
> +               if (test_bit(idx, before) && !test_bit(idx, after))
> +                       uprobe_detach(skel, idx);
> +       }
> +
> +       /* ... and attach all new programs in 'after' state */
> +       for (idx =3D 0; idx < 4; idx++) {
> +               if (!test_bit(idx, before) && test_bit(idx, after)) {
> +                       if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_=
attach_after"))
> +                               return -1;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static void session_consumer_test(struct uprobe_multi_consumers *skel,
> +                                 unsigned long before, unsigned long aft=
er)
> +{
> +       int err, idx;
> +
> +       printf("session_consumer_test before %lu after %lu\n", before, af=
ter);
> +
> +       /* 'before' is each, we attach uprobe for every set idx */
> +       for (idx =3D 0; idx < 4; idx++) {
> +               if (test_bit(idx, before)) {
> +                       if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_=
attach_before"))
> +                               goto cleanup;
> +               }
> +       }
> +
> +       err =3D uprobe_session_consumer_test(skel, before, after);
> +       if (!ASSERT_EQ(err, 0, "uprobe_session_consumer_test"))
> +               goto cleanup;
> +
> +       for (idx =3D 0; idx < 4; idx++) {
> +               const char *fmt =3D "BUG";
> +               __u64 val =3D 0;
> +
> +               if (idx < 2) {
> +                       /*
> +                        * uprobe entry
> +                        *   +1 if define in 'before'
> +                        */
> +                       if (test_bit(idx, before))
> +                               val++;
> +                       fmt =3D "prog 0/1: uprobe";
> +               } else {
> +                       /* uprobe return is tricky ;-)
> +                        *
> +                        * to trigger uretprobe consumer, the uretprobe n=
eeds to be installed,
> +                        * which means one of the 'return' uprobes was al=
ive when probe was hit:
> +                        *
> +                        *   idxs: 2/3 uprobe return in 'installed' mask
> +                        *
> +                        * in addition if 'after' state removes everythin=
g that was installed in
> +                        * 'before' state, then uprobe kernel object goes=
 away and return uprobe
> +                        * is not installed and we won't hit it even if i=
t's in 'after' state.
> +                        */

yeah, this is tricky, thanks for writing this out, seems correct to me

> +                       unsigned long installed =3D before & 0b1100; // i=
s uretprobe installed
> +                       unsigned long exists    =3D before & after;  // d=
id uprobe go away
> +
> +                       if (installed && exists && test_bit(idx, after))

nit: naming didn't really help (actually probably hurt the analysis).
installed is whether we had any uretprobes, so "had_uretprobes"?
exists is whether uprobe stayed attached during function call, right,
so maybe "probe_preserved" or something like that?

I.e., the condition should say "if we had any uretprobes, and the
probe instance stayed alive, and the program is still attached at
return".

> +                               val++;
> +                       fmt =3D "idx 2/3: uretprobe";
> +               }
> +
> +               ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt);
> +               skel->bss->uprobe_result[idx] =3D 0;
> +       }
> +
> +cleanup:
> +       for (idx =3D 0; idx < 4; idx++)
> +               uprobe_detach(skel, idx);
> +}
> +

[...]

