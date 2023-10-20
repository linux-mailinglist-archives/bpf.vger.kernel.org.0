Return-Path: <bpf+bounces-12845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7997D13FD
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267882825AE
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E61DA2F;
	Fri, 20 Oct 2023 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqxZvahY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA831EA7A
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 16:30:46 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B63CA
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 09:30:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so1519372a12.2
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697819443; x=1698424243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c1qsE1GAMxWHfNqlIESceBNMyTVgVw4x+Bo/JmJxkM=;
        b=VqxZvahYQlyKqeD5fcxfyFp38G63ZZfKYmxCFme4yDYFycENyw6Fw43Cl8nsS75kNv
         i7CvkyGymFv9uVGOJARYseShlCwl6q6SxSDgr1WPISDEw30b5atOrperzf1RHhF03siw
         QkbheQL8XfJStV2zmYmS4IdoxnVd8GyDcDjdfJle1SmH34VBfCjCsxLcMj9r7c/ugQXg
         0rK4QV+XrGAhHW8CXnPzqXXIts/+TpgXfNxSrNuRsUXnrRLREQ/4xfZYFbj6xE8zxOIJ
         3iIECIH4Q3GPItAVwFjXvyRcmh81zrZpdTVdJTXhldqNYYhXsQVVsEkwUUIltk/PDOAL
         +p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819443; x=1698424243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4c1qsE1GAMxWHfNqlIESceBNMyTVgVw4x+Bo/JmJxkM=;
        b=Wu+38uXC33csaieh03nxNr5udeFiqSdUDVMoz2ZvhxYhZJ3FmqNExkJevN+S3IVUQ8
         A0X82eyz89dfkfzoHNLSag9WVXl+bE68H3QbomTyESwyeda/g3VTSIN/k6kShKnEYwxg
         FszdvnUq2Zz9VEpTtSHryFy4SvcJvpIqPenCbm6XdtR57jDEmnwHSKzsQiUPkieA2mCo
         oFb+ZEN8wuFZF8nXHHCNDUW55tzhSku283SFE385g6Mojih1FqbojWELso7XdxOkrmrL
         QfBQfrQOiO2qqsGHPRab+yFpl0fQL4nWqOIxhPR/ydr2BIWL4EnNQBQCWk//lyx7h/JN
         sCxg==
X-Gm-Message-State: AOJu0YwyYdvC359kEVrHV+LVaAYpuWrOUEQUCyz/5UQEYaD3O47ad1no
	fLIsCzSgpt2WLWrls15ipIqAyOklsmuSlDFWX0sh+soN
X-Google-Smtp-Source: AGHT+IEtpjqLAIzXsPFySHCLhdFWrZEumJWhiVtpQT2svUEni2Rv+fCFLI3CHhGwPXmE37D8WJ6A2RvDE3/lgXo2cvk=
X-Received: by 2002:a05:6402:5c4:b0:53e:30dc:ef59 with SMTP id
 n4-20020a05640205c400b0053e30dcef59mr2054501edx.10.1697819443304; Fri, 20 Oct
 2023 09:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020144839.2734006-1-memxor@gmail.com>
In-Reply-To: <20231020144839.2734006-1-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 20 Oct 2023 09:30:32 -0700
Message-ID: <CAEf4BzZR2tDXWwYWr_MHABVQGbAo5KwVg7gjKXYVg4iOEmVqnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Make linked_list failure test
 more robust
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 7:48=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The linked list failure test 'pop_front_off' and 'pop_back_off'
> currently rely on matching exact instruction and register values.  The
> purpose of the test is to ensure the offset is correctly incremented for
> the returned pointers from list pop helpers, which can then be used with
> container_of to obtain the real object. Hence, somehow obtaining the
> information that the offset is 48 will work for us. Make the test more
> robust by relying on verifier error string of bpf_spin_lock and remove
> dependence on fragile instruction index or register number, which can be
> affected by different clang versions used to build the selftests.
>
> Fixes: 300f19dcdb99 ("selftests/bpf: Add BPF linked list API tests")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/linked_list.c | 10 ++--------
>  tools/testing/selftests/bpf/progs/linked_list_fail.c |  4 +++-
>  2 files changed, 5 insertions(+), 9 deletions(-)
>

Thanks for the fix! Applied to bpf-next.

> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
> index 69dc31383b78..2fb89de63bd2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> @@ -94,14 +94,8 @@ static struct {
>         { "incorrect_head_var_off2", "variable ptr_ access var_off=3D(0x0=
; 0xffffffff) disallowed" },
>         { "incorrect_head_off1", "bpf_list_head not found at offset=3D25"=
 },
>         { "incorrect_head_off2", "bpf_list_head not found at offset=3D1" =
},
> -       { "pop_front_off",
> -         "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_null_f=
oo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) "
> -         "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)=
 refs=3D2,4\n"
> -         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=3Dptr_or_null_ exp=
ected=3Dpercpu_ptr_" },
> -       { "pop_back_off",
> -         "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_null_f=
oo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) "
> -         "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)=
 refs=3D2,4\n"
> -         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=3Dptr_or_null_ exp=
ected=3Dpercpu_ptr_" },
> +       { "pop_front_off", "off 48 doesn't point to 'struct bpf_spin_lock=
' that is at 40" },
> +       { "pop_back_off", "off 48 doesn't point to 'struct bpf_spin_lock'=
 that is at 40" },
>  };
>
>  static void test_linked_list_fail_prog(const char *prog_name, const char=
 *err_msg)
> diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools=
/testing/selftests/bpf/progs/linked_list_fail.c
> index f4c63daba229..6438982b928b 100644
> --- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
> +++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
> @@ -591,7 +591,9 @@ int pop_ptr_off(void *(*op)(void *head))
>         n =3D op(&p->head);
>         bpf_spin_unlock(&p->lock);
>
> -       bpf_this_cpu_ptr(n);
> +       if (!n)
> +               return 0;
> +       bpf_spin_lock((void *)n);
>         return 0;
>  }
>
> --
> 2.40.1
>

