Return-Path: <bpf+bounces-33690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB3924B03
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0628286B17
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85FD17DA3E;
	Tue,  2 Jul 2024 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKpMElGj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98AC17DA1A;
	Tue,  2 Jul 2024 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957518; cv=none; b=SbyzWPPgS9F8ba5xIOOZBMIi/nPlLCFQdYAhjqndHGc9mFcq4sbRVX3zCcmH6cCm3SowkO16oyC1al2TwCGzT3JDGZsyoJoEssuw5+kb3Dio/Tv9YxueGcr7ntJSecS4+5FKOWIuv36E3bABEr3rhZ34DFXQU+8J4D6nLnpHVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957518; c=relaxed/simple;
	bh=h5tXr7SMwPFkrJ4rF+P4EAcXAD3ZGPryksKht092tqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ai4Y2SMenR2IUHoCGhjwnePCateQ9AI9HW3Ndeo8ojpQvhVWJvvTRRvp4Skv4g70dP8csjN86OmzB/1WUWQr6Rn9qGp02O4Rno7k7c9s4vGH6CIBnR1juJBxPEmuByuI/kWXpmaPWgugIM4vLM4khuJP0bJ035I5XEB39BH98dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKpMElGj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so2853272a12.1;
        Tue, 02 Jul 2024 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957515; x=1720562315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVi2Bg4QaR88dBIp/tbbscm8o7qaqp+DV5RfjEivydw=;
        b=gKpMElGj7v7HJ6p8DgJVCYPKfzF82w2cDUxj5EBiXHXR/QEuYIMOJ4EiHKAIRri2wt
         0x3zjCEngjzzrbbDWcxDUscmCAQcK3h+kccxFRCwOQQ7sRWA2tWL/sfyAU0ZZyrVkaMa
         tohLzbuNkpdNLjkb1GUJkaXKkK2LHbtbzc9qlqdcJPA4+LG21Il+E7XUqQq51+ZjyX/o
         jKSlFbuHThEjpIMAvsWovduKpUJzbcvPRTeGC0ntJ4WNAGvutUc6Xtm4Q9rw0Xquvx1X
         4F02/cMujHmch58MEQ6Lx6nBw5ZJihXvaocupt7lAytzLgjh+pGsHV6mkVVVQIj0Q1YR
         VYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957515; x=1720562315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVi2Bg4QaR88dBIp/tbbscm8o7qaqp+DV5RfjEivydw=;
        b=I6xgH542BcB7zm6PD4dB5HRw76vN2HjvC4l+j5IqzHLwZXYUY0FWKDdSmfmVAHE9VB
         dLbo5S38Qosp1zrxzY1fp7JcycssTcsuOOJCyPJ+LSWo1E75KOg0qyjAoJBBjBNN0MNQ
         KgUXdOZXuDkjW0eKsFATOJh+ri0A6qQPktuHeUfDH931tvlfgtz+j5mqmfh9MBUHPX1P
         q1P0AJkzP6kkTvDXKmq9iD8X3fiu26fpddhVfFALoeTDr3MYJhkJ/95dmZgQ18kG2WNf
         45+HIScH1LRV46+vskMsYZoXuj2baGig258qC0nD1Tnw9uKOq4mi0f0F8u86fnqVFD0f
         UVnw==
X-Forwarded-Encrypted: i=1; AJvYcCUIZzmPGyumJ+IFcUz36rHOJ6H4xIcOyNIdF2dTEfnE3GM2cyI+OXD2Fc7rYviHEUXrxnAu0mF2UEuFtIIrOQ04GilhEgkuoI82Hao8nirm+ytOtK7zPipzVbbfml5Eb+LqpgUQlueLFvKqJBy5qArNPv9ICmDM3oVKpfvVesYIOI3f4Ybm
X-Gm-Message-State: AOJu0Yz85mNxzVKa/ekWT9KATXAEN4Qwho+rwc++9v2NrO9Ooore5D1p
	35HWvv5B/nV8X7o0vggIlSLBTjzC4Pl4T6dT/FUlxJ3LGmnWnle6qrbx0c5sZWQwEVhCCbD0OH/
	FLTxJQNKjQOjwd9DbzVSOP1O0Cr8=
X-Google-Smtp-Source: AGHT+IHt3MRHFvQEtjjTLGvUo+f9ev3JwcNAmSbWPfdH4zxYY/qKKbbMKf/4VGtIiuCdIB+TeW2xgcLFfu4TggRjRrs=
X-Received: by 2002:a17:906:a0c2:b0:a72:6f10:52da with SMTP id
 a640c23a62f3a-a75144a28bemr683487166b.59.1719957514889; Tue, 02 Jul 2024
 14:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-8-jolsa@kernel.org>
In-Reply-To: <20240701164115.723677-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:58:20 -0700
Message-ID: <CAEf4Bzbo_ojUokr0x9RKq0=3=+4XYAmW0=27dBew5MXx4348mw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 7/9] selftests/bpf: Add uprobe session cookie test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:43=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe session test that verifies the cookie value
> get properly propagated from entry to return program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 31 ++++++++++++
>  .../bpf/progs/uprobe_multi_session_cookie.c   | 48 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_sessio=
n_cookie.c
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index cd9581f46c73..d5f78fc61013 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -7,6 +7,7 @@
>  #include "uprobe_multi_bench.skel.h"
>  #include "uprobe_multi_usdt.skel.h"
>  #include "uprobe_multi_session.skel.h"
> +#include "uprobe_multi_session_cookie.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "testing_helpers.h"
>  #include "../sdt.h"
> @@ -655,6 +656,34 @@ static void test_session_skel_api(void)
>         uprobe_multi_session__destroy(skel);
>  }
>
> +static void test_session_cookie_skel_api(void)
> +{
> +       struct uprobe_multi_session_cookie *skel =3D NULL;
> +       int err;
> +
> +       skel =3D uprobe_multi_session_cookie__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
> +               goto cleanup;
> +
> +       skel->bss->pid =3D getpid();
> +
> +       err =3D uprobe_multi_session_cookie__attach(skel);
> +       if (!ASSERT_OK(err, " kprobe_multi_session__attach"))
> +               goto cleanup;
> +
> +       /* trigger all probes */
> +       uprobe_multi_func_1();
> +       uprobe_multi_func_2();
> +       uprobe_multi_func_3();
> +
> +       ASSERT_EQ(skel->bss->test_uprobe_1_result, 1, "test_uprobe_1_resu=
lt");
> +       ASSERT_EQ(skel->bss->test_uprobe_2_result, 2, "test_uprobe_2_resu=
lt");
> +       ASSERT_EQ(skel->bss->test_uprobe_3_result, 3, "test_uprobe_3_resu=
lt");
> +
> +cleanup:
> +       uprobe_multi_session_cookie__destroy(skel);
> +}
> +
>  static void test_bench_attach_uprobe(void)
>  {
>         long attach_start_ns =3D 0, attach_end_ns =3D 0;
> @@ -745,4 +774,6 @@ void test_uprobe_multi_test(void)
>                 test_attach_api_fails();
>         if (test__start_subtest("session"))
>                 test_session_skel_api();
> +       if (test__start_subtest("session_cookie"))
> +               test_session_cookie_skel_api();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cooki=
e.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
> new file mode 100644
> index 000000000000..5befdf944dc6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <stdbool.h>
> +#include "bpf_kfuncs.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int pid =3D 0;
> +
> +__u64 test_uprobe_1_result =3D 0;
> +__u64 test_uprobe_2_result =3D 0;
> +__u64 test_uprobe_3_result =3D 0;
> +
> +static int check_cookie(__u64 val, __u64 *result)
> +{
> +       __u64 *cookie;
> +
> +       if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
> +               return 1;
> +
> +       cookie =3D bpf_session_cookie();
> +
> +       if (bpf_session_is_return())
> +               *result =3D *cookie =3D=3D val ? val : 0;
> +       else
> +               *cookie =3D val;
> +       return 0;
> +}
> +
> +SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
> +int uprobe_1(struct pt_regs *ctx)
> +{
> +       return check_cookie(1, &test_uprobe_1_result);
> +}
> +
> +SEC("uprobe.session//proc/self/exe:uprobe_multi_func_2")
> +int uprobe_2(struct pt_regs *ctx)
> +{
> +       return check_cookie(2, &test_uprobe_2_result);
> +}
> +
> +SEC("uprobe.session//proc/self/exe:uprobe_multi_func_3")
> +int uprobe_3(struct pt_regs *ctx)
> +{
> +       return check_cookie(3, &test_uprobe_3_result);
> +}
> --
> 2.45.2
>

