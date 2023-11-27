Return-Path: <bpf+bounces-16000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A818A7FAAB9
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27741C20D9D
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E0845967;
	Mon, 27 Nov 2023 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGhcsy5l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5DAD59
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:57:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so669111166b.3
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701115074; x=1701719874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yCgkxXJsT7Py/61YERGrcpEKEpaRjkUJG0F9scbtlo=;
        b=OGhcsy5lSh8qsCM20883i47rPgGUZe8ZKXW9nbMWFz9DlIrEtmQOxq9iq89sFqrbe2
         qHILz/JTYJ0w9KFI3ZzJilvk7Ig00LloaMdHuZZpLql5NLiJc/hKHkt7LtJTahmtAwdi
         hwvldUB6bwjh/S/T+VQTWPfjh8yiNVyCXPq5GbbUbbOkmFpP3/f4RwuiWqHsQjiPkQix
         VgddhuLjdaXjjHoP0HTQKSzYuDtq4TRIdeU7fzZH1As+FrPkMuFb1eMiW+BrL52sshY+
         pdFnado0vYsnzrPJBil/Hg5hIWhgZHDk/2Qv1dFV2dke6yz/eGWFM/WFudyhnPF3aX5j
         moog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701115074; x=1701719874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yCgkxXJsT7Py/61YERGrcpEKEpaRjkUJG0F9scbtlo=;
        b=gOKqqkn8xrEB0KYRFh24JNZ4lF+OpZchYjEB3vlxmRBgVp6dGwaDgNxVPUwVz5zDuU
         J3sn4SKXqLd5RnYCh7dy3T6Sz8BwG+Pc3r41JlPg9H5S/PtB6A46jl35WIopmsd7YWdp
         cTm/pwaAn08BJnRyZjWOJHpQ4tMXRT+UR5BCLI+ETAPV2Wi9sV1MqwBlPBJvyCfikrfm
         TzSvN9rQvavAvmNNqT+9sbyBgUmDukSZs3OP8cFFNnITM+rUtzBauqr2+gGL44NxROkp
         pVFrFD3lLcUdpLn7yckM/jUyOXun5nUk2cXOIjaQa1gy5wotrDE6vhWwUezraHoQDRPX
         JlJA==
X-Gm-Message-State: AOJu0YyFHBwKkyM4wCEOlqTJZ2HCyQbbCKz6nxIdU0mplIlRiAOTZ9Oi
	VWG1oesbz3QfkF//KdDYvq26tg+a4vtbBM+u0xI=
X-Google-Smtp-Source: AGHT+IEHVAjm3s/3jsxkHnZR7qFKFqKBKQK2AGrHMDUVdvc03yW1fKkoYvzuLcsDF7IbXib99krpGnL+K98bR/2TavY=
X-Received: by 2002:a17:906:3fd0:b0:9b2:c583:cd71 with SMTP id
 k16-20020a1709063fd000b009b2c583cd71mr8139216ejj.50.1701115073681; Mon, 27
 Nov 2023 11:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127050342.1945270-1-yonghong.song@linux.dev>
 <CAEf4BzZYydzYLCyPYxsUQ1OhMnnHw7f+mmErzNQFXubZCj8t9w@mail.gmail.com> <f25da05e-0a93-449b-a683-526641c7acf6@linux.dev>
In-Reply-To: <f25da05e-0a93-449b-a683-526641c7acf6@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Nov 2023 11:57:41 -0800
Message-ID: <CAEf4BzbJOtq8hO5rbshKChKd9dfUtOA28UR9Z7vC0kqf5AF05g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a few selftest failures due to llvm18 change
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 11:49=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 11/27/23 1:49 PM, Andrii Nakryiko wrote:
> > On Sun, Nov 26, 2023 at 9:04=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> With latest upstream llvm18, the following test cases failed:
> >>    $ ./test_progs -j
> >>    #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
> >>    #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
> >>    #13      bpf_cookie:FAIL
> >>    #77      fentry_fexit:FAIL
> >>    #78/1    fentry_test/fentry:FAIL
> >>    #78      fentry_test:FAIL
> >>    #82/1    fexit_test/fexit:FAIL
> >>    #82      fexit_test:FAIL
> >>    #112/1   kprobe_multi_test/skel_api:FAIL
> >>    #112/2   kprobe_multi_test/link_api_addrs:FAIL
> >>    ...
> >>    #112     kprobe_multi_test:FAIL
> >>    #356/17  test_global_funcs/global_func17:FAIL
> >>    #356     test_global_funcs:FAIL
> >>
> >> Further analysis shows llvm upstream patch [1] is responsible
> >> for the above failures. For example, for function bpf_fentry_test7()
> >> in net/bpf/test_run.c, without [1], the asm code is:
> >>    0000000000000400 <bpf_fentry_test7>:
> >>       400: f3 0f 1e fa                   endbr64
> >>       404: e8 00 00 00 00                callq   0x409 <bpf_fentry_tes=
t7+0x9>
> >>       409: 48 89 f8                      movq    %rdi, %rax
> >>       40c: c3                            retq
> >>       40d: 0f 1f 00                      nopl    (%rax)
> >> and with [1], the asm code is:
> >>    0000000000005d20 <bpf_fentry_test7.specialized.1>:
> >>      5d20: e8 00 00 00 00                callq   0x5d25 <bpf_fentry_te=
st7.specialized.1+0x5>
> >>      5d25: c3                            retq
> >> and <bpf_fentry_test7.specialized.1> is called instead of <bpf_fentry_=
test7>
> >> and this caused test failures for #13/#77 etc. except #356.
> >>
> >> For test case #356/17, with [1] (progs/test_global_func17.c)),
> >> the main prog looks like:
> >>    0000000000000000 <global_func17>:
> >>         0:       b4 00 00 00 2a 00 00 00 w0 =3D 0x2a
> >>         1:       95 00 00 00 00 00 00 00 exit
> >> which passed verification while the test itself expects a verification
> >> failure.
> >>
> >> Let us add 'barrier_var' style asm code in both places to prevent
> >> function specialization which caused selftests failure.
> >>
> >>    [1] https://github.com/llvm/llvm-project/pull/72903
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   net/bpf/test_run.c                                     | 2 +-
> >>   tools/testing/selftests/bpf/progs/test_global_func17.c | 1 +
> >>   2 files changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> >> index c9fdcc5cdce1..711cf5d59816 100644
> >> --- a/net/bpf/test_run.c
> >> +++ b/net/bpf/test_run.c
> >> @@ -542,7 +542,7 @@ struct bpf_fentry_test_t {
> >>
> >>   int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
> >>   {
> >> -       asm volatile ("");
> >> +       asm volatile ("": "+r"(arg));
> >>          return (long)arg;
> >>   }
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/test_global_func17.c b/=
tools/testing/selftests/bpf/progs/test_global_func17.c
> >> index a32e11c7d933..5de44b09e8ec 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_global_func17.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_global_func17.c
> >> @@ -5,6 +5,7 @@
> >>
> >>   __noinline int foo(int *p)
> >>   {
> >> +       barrier_var(p);
> >>          return p ? (*p =3D 42) : 0;
> >>   }
> >>
> > I recently stumbled upon no_clone ([0]) and no_ipa ([1]) attributes.
> > Should we consider using those here instead?
> >
> >    [0] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.ht=
ml#index-noclone-function-attribute
> >    [1] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.ht=
ml#index-noipa-function-attribute
>
> noipa attribute might help here. But sadly, noclone and noipa are gcc spe=
cific
> and clang does not support either of them.

I see, that's too bad, I assumed Clang also supports something like
that. Maybe someday.

>
> >
> >
> >> --
> >> 2.34.1
> >>

