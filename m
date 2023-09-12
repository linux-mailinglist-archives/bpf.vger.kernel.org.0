Return-Path: <bpf+bounces-9767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD7E79D60E
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1251C20B78
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C106719BA8;
	Tue, 12 Sep 2023 16:17:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0718C35
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:17:32 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD80D10EB
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 09:17:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d58b3efbso5348431f8f.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694535450; x=1695140250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR/G0+j326yUI4bInAyOsVMLuaD3ScYFapNQuQINprQ=;
        b=HF0GbLVeiJ9nb70PXkHdgBYGCd3zrA9KwgOEjHwP99mzs+eA5xP0mEVih3gK03SKV2
         ZWdvWIeSK0Yfpu9Kh+zJbjjPVUz2f/4GdSwf43yY26lR4yvifEdgxSGt9F0iivjb8kXn
         n4BcTn/mv5UDvFVREyqGMTExopGgL7X8IRxoajFSm6v9kaO9cjT1QGhkgbzWoywPaskM
         TUpfb48PHxiktE7RZNRpRtRdtBxwblHsvGSEVDBvNOyY9oMJiD3UeF0Fc+7C2RvutAh+
         /ZcaPo+Wwqk4Kpwqbr1AvLEKMYOLpUDBQy42uS7C25qLvsv3XiF1NREo6uOVenrQihzY
         wRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694535450; x=1695140250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR/G0+j326yUI4bInAyOsVMLuaD3ScYFapNQuQINprQ=;
        b=RN+B45AJKboFZ9exZjtxh6LHkU/EiyAW2LUzvN1YnR6FIRKDLhl6x9ui+wOJczE8yA
         VGh6uHFLY+ftiVLpUDYAPNFMushwQtPRDw0Gs7uPPiR1DyH5ssieYzFR2QAJPuY+UYcU
         VYHDeAwuRq2VpkoDDmVwftLkDZkYF8pWzxM2FKfB6OEhqQ9gb84ana26OfqU1PW5YIGa
         rfWxEBC7eLO3Sfrb0eugr9jPfE5Hg7TYxnjYqCKrMN+qXREdLe/WZxGek4qBxj3Ex9IV
         YMk0Eujmfb1Xuxl89VG0YVItxqXK7MdxgLMV1v4cuoiPOHTX3ZK9lNZSxWlssX/PuGiA
         A2hg==
X-Gm-Message-State: AOJu0YzJGV14VbOTKkfPK2Zno5FJZgJNaiHocWEZARQyHD9i0hvF2+v1
	2QM6mJ8Mqm0UVLQy9h3GZYCIL6pdqVI0NNRNuQk=
X-Google-Smtp-Source: AGHT+IHv4pamMKHgWLLZ5zGJoqKNVaBXFVkXm/FAL3REMRsUaHYxyTvrpW7RCSlMOeoLU5nZYw6lPBJrXVZciCKXRgM=
X-Received: by 2002:a05:6000:92f:b0:317:3deb:a899 with SMTP id
 cx15-20020a056000092f00b003173deba899mr13500wrb.1.1694535449889; Tue, 12 Sep
 2023 09:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912141437.366046-1-jolsa@kernel.org> <CAADnVQ+BfF3fojHCcfq6suJ-4GkTrchtkfrZHtvt0OQDMXLBBA@mail.gmail.com>
In-Reply-To: <CAADnVQ+BfF3fojHCcfq6suJ-4GkTrchtkfrZHtvt0OQDMXLBBA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Sep 2023 09:17:18 -0700
Message-ID: <CAEf4BzZKgM0g+M4Se181qKh0NH_csa+4EsSgcvJE5_icJdEmSg@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix kprobe_multi_test/attach_override test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 7:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 12, 2023 at 7:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > We need to deny the attach_override test for arm64
> > and make it static.
> >
> > Fixes: 7182e56411b9 ("selftests/bpf: Add kprobe_multi override test")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.aarch64               | 1 +
> >  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testi=
ng/selftests/bpf/DENYLIST.aarch64
> > index 7f768d335698..b32f962dee92 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -9,6 +9,7 @@ kprobe_multi_test/bench_attach                   # bpf_=
program__attach_kprobe_mu
> >  kprobe_multi_test/link_api_addrs                 # link_fd unexpected =
link_fd: actual -95 < expected 0
> >  kprobe_multi_test/link_api_syms                  # link_fd unexpected =
link_fd: actual -95 < expected 0
> >  kprobe_multi_test/skel_api                       # libbpf: failed to l=
oad BPF skeleton 'kprobe_multi': -3
> > +kprobe_multi_test/attach_override                # test_attach_overrid=
e:FAIL:kprobe_multi_empty__open_and_load unexpected error: -22
>
> why do we need this ?
> Andrii, move of kconfig override into common should fix it, no?

So my patch did indeed enable BPF_KPROBE_OVERRIDE=3Dy on aarch64, but we
are now encountering "not supported" error somewhere:

test_attach_override:PASS:kprobe_multi_empty__open_and_load 0 nsec
libbpf: prog 'test_override': failed to attach: Operation not supported
test_attach_override:PASS:override_attached_bpf_fentry_test1 0 nsec
libbpf: prog 'test_override': failed to attach: Operation not supported
test_attach_override:FAIL:override_attached_should_fail_bio unexpected
error: -95

retsnoop should be able to point out where this is coming from, but
unfortunately I don't have aarch64 setup that allows me to run VMs (at
least not yet). So if Jiri has access to arm64 machine, please take a
look meanwhile.

We need to understand if bpf_override_return() never worked, or Jiri's
change with addrs_check_error_injection_list added breaks something.
And then act accordingly (either denylist the test, or fix the bug).

>
> >  module_attach                                    # prog 'kprobe_multi'=
: failed to auto-attach: -95
> >  fentry_test/fentry_many_args                     # fentry_many_args:FA=
IL:fentry_many_args_attach unexpected error: -524
> >  fexit_test/fexit_many_args                       # fexit_many_args:FAI=
L:fexit_many_args_attach unexpected error: -524
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c=
 b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index e05477b210a5..4041cfa670eb 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -454,7 +454,7 @@ static void test_kprobe_multi_bench_attach(bool ker=
nel)
> >         }
> >  }
> >
> > -void test_attach_override(void)
> > +static void test_attach_override(void)
> >  {
> >         struct kprobe_multi_override *skel =3D NULL;
> >         struct bpf_link *link =3D NULL;
> > --
> > 2.41.0
> >

