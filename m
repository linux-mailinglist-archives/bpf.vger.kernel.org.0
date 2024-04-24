Return-Path: <bpf+bounces-27604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF78AFD51
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49F71C21D29
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 00:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BACF639;
	Wed, 24 Apr 2024 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3pTjqBf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122C7FF
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918449; cv=none; b=tL1uiHCjDtgxgPVGI3p5Y5ixRYIYwzRGl/HjCWQFarxQtD8+biDMqSC7+GmDpBo2wzy/OI+6nB5rMllCkgEx2sHTQPAjb2FXvd+YQcUyo0aVmX07e2KOaz4CsPV3rCUrhBj2LGndlBUtRoUiFVyVoRAGCMpRluBLqrg0sA9JsKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918449; c=relaxed/simple;
	bh=CSv/ogOg8knPl0hns9X18jJ0djbJwAxaIVFY//akvJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtJ4K0/q+m5V49p0B2on15VlO1xMk6YcNmxhJLPp7hVg0FDis0tnC6PpWIoatqQAu0EEF/f5Ipv4WU9feJy4u4r0p6UD4ovltp0t0M3D6drvojvXU7kArDIPGuEhyWS9FOqysUFuU/8D1oCaJhaTOfkidch8BpjJBaWFJ/M3laA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3pTjqBf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ac1674d890so4691024a91.3
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713918447; x=1714523247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrDseg5V1A46FrsYOblPYYc/yuBeaoJFLb8SxcMBdAc=;
        b=E3pTjqBfvwTmmBNHHPJ3ba9iHkvVw7FgJhdTztUExzyXeVKv/BhTTBSmo8dN9XXC3V
         7BejutG3X0/q5GpOk1CKZkvFo+2wlAdStxfuxy90VOCIzHnh/N26/FQptJuhVa/jf1CR
         LuDW7FpFXU6/L2Jo/BP204ktAn8GAGd6I2TXjBkHSmnJYN+P2GgpOPv2mgKCQo+FRmxZ
         SOIuKqxH26nVrCPeycqB+5VaQiE798wqQlnVPPuUgJCHvpl1UgOYMGmwIBo5mmS+GN/x
         mKwS1dzkoX9FczOan30d3rx/f/3PG7aevpCR1gD2Lu0kvQa6RKpzHpidWLIfs37prMTq
         CSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918447; x=1714523247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrDseg5V1A46FrsYOblPYYc/yuBeaoJFLb8SxcMBdAc=;
        b=sYd354/DutSPKVuh8CgWexFbhyCVbc8zmKnaSTuBkDnwIpmoPRekYt/ygwNpJh+slH
         ocivTYpHQz5onp1Q+PGt0aeXbSV4vF+LhXsjRAk5ors8SWCymLIuDrDYv2SidQQcPSzz
         BkROW4GD2tqtNJ0A5DnVFxZpro72t4B3RISDcTdE/0WQsZcKo6utEY0ukPK43zxVzCNk
         1QcCyHI3enMD1r3QUTPMupjfU8g/FTLYs9URbjBUYGDQT3rHiwvfZHkL1qCO+O1+Dpi5
         31aO6MfbAjxMlkLQRJSl1D3HyqtbDeKXHbvJorvmMfI+SA/NZKuV+xUDQev35L23cZLg
         oqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8qxYAHUBtH1RtegMKbu+mNvoLnzz8bd0uaqrzMmKKKR0+jn2nbRGIKv79LdBcigGQ+JiiS5gtITwik9HLhSo8zn+G
X-Gm-Message-State: AOJu0Ywdpd+0hVshILx/F0kiQn5Pmv8EOkQbLOvF3rAynjWzlRSmYpXL
	X6gsAuPVfZUeQcGpWK2mi8JYnTJfebNGFGMNrz99I+DDLwmCAtbNBUPAbHMm+DSHlD88qDzgRNR
	IJvzGrxy0dwJMBI35BdwWSqxPWSY=
X-Google-Smtp-Source: AGHT+IEmYwppbZTsN41otLtMbLJAbZuNE+hQPqtfPyIetse+D2SozNj24s2jwSX02gWxt/rgI611i7Po13ayXCnKuFI=
X-Received: by 2002:a17:90a:a102:b0:2a5:2870:6d with SMTP id
 s2-20020a17090aa10200b002a52870006dmr840449pjp.48.1713918446736; Tue, 23 Apr
 2024 17:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422121241.1307168-1-jolsa@kernel.org> <20240422121241.1307168-7-jolsa@kernel.org>
In-Reply-To: <20240422121241.1307168-7-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Apr 2024 17:27:14 -0700
Message-ID: <CAEf4Bza2oReiAMhO3bUwP9LmdQ=+u98gEd2Vz_zGmB1PUVi4-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Add kprobe multi session test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding kprobe multi session test and testing that the entry program
> return value controls execution of the return probe program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |   2 +
>  .../bpf/prog_tests/kprobe_multi_test.c        |  49 +++++++++
>  .../bpf/progs/kprobe_multi_session.c          | 100 ++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sessio=
n.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index 14ebe7d9e1a3..180030b5d828 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -75,4 +75,6 @@ extern void bpf_key_put(struct bpf_key *key) __ksym;
>  extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
>                                       struct bpf_dynptr *sig_ptr,
>                                       struct bpf_key *trusted_keyring) __=
ksym;
> +
> +extern bool bpf_session_is_return(void) __ksym;
>  #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 51628455b6f5..d1f116665551 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -4,6 +4,7 @@
>  #include "trace_helpers.h"
>  #include "kprobe_multi_empty.skel.h"
>  #include "kprobe_multi_override.skel.h"
> +#include "kprobe_multi_session.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "bpf/hashmap.h"
>
> @@ -326,6 +327,52 @@ static void test_attach_api_fails(void)
>         kprobe_multi__destroy(skel);
>  }
>
> +static void test_session_skel_api(void)
> +{
> +       struct kprobe_multi_session *skel =3D NULL;
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       struct bpf_link *link =3D NULL;
> +       int err, prog_fd;
> +
> +       skel =3D kprobe_multi_session__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "kprobe_multi_session__open_and_load"))
> +               goto cleanup;

return?

> +
> +       skel->bss->pid =3D getpid();
> +
> +       err =3D  kprobe_multi_session__attach(skel);

nit: extra space

> +       if (!ASSERT_OK(err, " kprobe_multi_session__attach"))
> +               goto cleanup;
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.trigger);
> +       err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +       ASSERT_OK(err, "test_run");
> +       ASSERT_EQ(topts.retval, 0, "test_run");
> +
> +       ASSERT_EQ(skel->bss->kprobe_test1_result, 1, "kprobe_test1_result=
");
> +       ASSERT_EQ(skel->bss->kprobe_test2_result, 1, "kprobe_test2_result=
");
> +       ASSERT_EQ(skel->bss->kprobe_test3_result, 1, "kprobe_test3_result=
");
> +       ASSERT_EQ(skel->bss->kprobe_test4_result, 1, "kprobe_test4_result=
");
> +       ASSERT_EQ(skel->bss->kprobe_test5_result, 1, "kprobe_test5_result=
");
> +       ASSERT_EQ(skel->bss->kprobe_test6_result, 1, "kprobe_test6_result=
");
> +       ASSERT_EQ(skel->bss->kprobe_test7_result, 1, "kprobe_test7_result=
");
> +       ASSERT_EQ(skel->bss->kprobe_test8_result, 1, "kprobe_test8_result=
");
> +
> +       ASSERT_EQ(skel->bss->kretprobe_test1_result, 0, "kretprobe_test1_=
result");
> +       ASSERT_EQ(skel->bss->kretprobe_test2_result, 1, "kretprobe_test2_=
result");
> +       ASSERT_EQ(skel->bss->kretprobe_test3_result, 0, "kretprobe_test3_=
result");
> +       ASSERT_EQ(skel->bss->kretprobe_test4_result, 1, "kretprobe_test4_=
result");
> +       ASSERT_EQ(skel->bss->kretprobe_test5_result, 0, "kretprobe_test5_=
result");
> +       ASSERT_EQ(skel->bss->kretprobe_test6_result, 1, "kretprobe_test6_=
result");
> +       ASSERT_EQ(skel->bss->kretprobe_test7_result, 0, "kretprobe_test7_=
result");
> +       ASSERT_EQ(skel->bss->kretprobe_test8_result, 1, "kretprobe_test8_=
result");

see below, even if array of ksym ptrs idea doesn't work out, at least
results can be an array (which is cleaner to work with both on BPF and
user space sides)

> +
> +cleanup:
> +       bpf_link__destroy(link);
> +       kprobe_multi_session__destroy(skel);
> +}
> +
>  static size_t symbol_hash(long key, void *ctx __maybe_unused)
>  {
>         return str_hash((const char *) key);
> @@ -690,4 +737,6 @@ void test_kprobe_multi_test(void)
>                 test_attach_api_fails();
>         if (test__start_subtest("attach_override"))
>                 test_attach_override();
> +       if (test__start_subtest("session"))
> +               test_session_skel_api();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session.c b/t=
ools/testing/selftests/bpf/progs/kprobe_multi_session.c
> new file mode 100644
> index 000000000000..9fb87f7f69da
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <stdbool.h>
> +#include "bpf_kfuncs.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +extern const void bpf_fentry_test1 __ksym;
> +extern const void bpf_fentry_test2 __ksym;
> +extern const void bpf_fentry_test3 __ksym;
> +extern const void bpf_fentry_test4 __ksym;
> +extern const void bpf_fentry_test5 __ksym;
> +extern const void bpf_fentry_test6 __ksym;
> +extern const void bpf_fentry_test7 __ksym;
> +extern const void bpf_fentry_test8 __ksym;
> +
> +int pid =3D 0;
> +
> +__u64 kprobe_test1_result =3D 0;
> +__u64 kprobe_test2_result =3D 0;
> +__u64 kprobe_test3_result =3D 0;
> +__u64 kprobe_test4_result =3D 0;
> +__u64 kprobe_test5_result =3D 0;
> +__u64 kprobe_test6_result =3D 0;
> +__u64 kprobe_test7_result =3D 0;
> +__u64 kprobe_test8_result =3D 0;
> +
> +__u64 kretprobe_test1_result =3D 0;
> +__u64 kretprobe_test2_result =3D 0;
> +__u64 kretprobe_test3_result =3D 0;
> +__u64 kretprobe_test4_result =3D 0;
> +__u64 kretprobe_test5_result =3D 0;
> +__u64 kretprobe_test6_result =3D 0;
> +__u64 kretprobe_test7_result =3D 0;
> +__u64 kretprobe_test8_result =3D 0;
> +
> +static int session_check(void *ctx, bool is_return)
> +{
> +       if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
> +               return 1;
> +
> +       __u64 addr =3D bpf_get_func_ip(ctx);
> +
> +#define SET(__var, __addr) ({                  \
> +       if ((const void *) addr =3D=3D __addr)      \
> +               __var =3D 1;                      \
> +})
> +
> +       if (is_return) {
> +               SET(kretprobe_test1_result, &bpf_fentry_test1);
> +               SET(kretprobe_test2_result, &bpf_fentry_test2);
> +               SET(kretprobe_test3_result, &bpf_fentry_test3);
> +               SET(kretprobe_test4_result, &bpf_fentry_test4);
> +               SET(kretprobe_test5_result, &bpf_fentry_test5);
> +               SET(kretprobe_test6_result, &bpf_fentry_test6);
> +               SET(kretprobe_test7_result, &bpf_fentry_test7);
> +               SET(kretprobe_test8_result, &bpf_fentry_test8);
> +       } else {
> +               SET(kprobe_test1_result, &bpf_fentry_test1);
> +               SET(kprobe_test2_result, &bpf_fentry_test2);
> +               SET(kprobe_test3_result, &bpf_fentry_test3);
> +               SET(kprobe_test4_result, &bpf_fentry_test4);
> +               SET(kprobe_test5_result, &bpf_fentry_test5);
> +               SET(kprobe_test6_result, &bpf_fentry_test6);
> +               SET(kprobe_test7_result, &bpf_fentry_test7);
> +               SET(kprobe_test8_result, &bpf_fentry_test8);
> +       }
> +
> +#undef SET

curious, have you tried implementing this through a proper for loop? I
wonder if something like

void *kfuncs[] =3D { &bpf_fentry_test1, ..., &bpf_fentry_test8 };

and then generic loop over this array would work. Can you please try?


> +
> +       /*
> +        * Force probes for function bpf_fentry_test[1357] not to
> +        * install and execute the return probe
> +        */
> +       if (((const void *) addr =3D=3D &bpf_fentry_test1) ||
> +           ((const void *) addr =3D=3D &bpf_fentry_test3) ||
> +           ((const void *) addr =3D=3D &bpf_fentry_test5) ||
> +           ((const void *) addr =3D=3D &bpf_fentry_test7))
> +               return 1;
> +
> +       return 0;
> +}
> +
> +/*
> + * No tests in here, just to trigger 'bpf_fentry_test*'
> + * through tracing test_run
> + */
> +SEC("fentry/bpf_modify_return_test")
> +int BPF_PROG(trigger)
> +{
> +       return 0;
> +}
> +
> +SEC("kprobe.session/bpf_fentry_test*")
> +int test_kprobe(struct pt_regs *ctx)
> +{
> +       return session_check(ctx, bpf_session_is_return());
> +}
> --
> 2.44.0
>

