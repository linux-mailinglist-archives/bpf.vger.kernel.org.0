Return-Path: <bpf+bounces-9937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252079EE13
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 18:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBA3281E19
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1E01F944;
	Wed, 13 Sep 2023 16:12:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA528F68
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 16:12:45 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E07B8
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:12:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50091b91a83so11519387e87.3
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694621562; x=1695226362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZHPBUHROlmV78pmncNrNTS0Rrd+auaZ+8hoskWMuyE=;
        b=FstBmudz1EZMwuU4I/im250sZDNiYyCX1zhCQfJEd0qCna043p8eU6L4yYnnuDdaTz
         QeMNAG+3AvUhXYMazt3knTHpWorXqhH6X/dkEjMa8VM0TIhuTK80NhvHtligVu1ZkSy3
         YsHg9P8giNQYKb/f6gINxyz+YNbyl0cIRLCTGMAtIcTx86a/3cMXJdUk56N9cO6yB/hK
         LSpsviwcUtXU1JxzqkDRl9v0N4BAH9ptDcLmJha/UeF/PKnM2pWwVzAutF+oqOS4SAES
         wmbdzS1MRFi63uNhD7xi4LB3rKAJfimm2efJx/XrZbE+2gK7wHB8zCMDrYi5b6MSx0Ly
         Bwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694621562; x=1695226362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZHPBUHROlmV78pmncNrNTS0Rrd+auaZ+8hoskWMuyE=;
        b=L5P6RYsIwVUc3vN+NgUYbVkUllks6ytHBp/pcmg5BBaU0cHoO4r6gGtC78f8zkTahR
         Fd91uePlNvIYsgSFcykvrVV3LH51Sxpxj2bi8Ba2116iD51UipM6S9IWKWty1CAOZIJ/
         iqzBoKNnmrX5rvwdXro9jy2wuOic/lKtSRIwGbawx6ULxaP3eNCANgeOYTkASbYRdK0g
         TshMQCx+WcrdK9MHicKaSXntAwZd4SYzMGLZBFSo78zeovDpF+AZHGyUlyeS20d5riuw
         r3UJWbwyRIFQHRsCC6CvQp170bcGPjbwVe/YK7sj0mxbCZWaGnZUgHDbSOSrIy8KEtlT
         xIaA==
X-Gm-Message-State: AOJu0YxH5WEuckBcqRyiwBpP7QXPjkLsoDEmULmF4zC2C3QlDNU7kLCy
	QaQxYgCJett0GBgHvn9Ji5wJn4agzvE1rYLFewRYB+GSuFPgpcIF
X-Google-Smtp-Source: AGHT+IEOq82pLFuGPeVkYeNR+4Udl/T8LisA1Am9+Wo9Dy9SuCtvUoQmsGBjT1FsZ2RTGD6CVf8C8VUqO/ESOyiDX1c=
X-Received: by 2002:a05:6512:110a:b0:500:aa41:9d67 with SMTP id
 l10-20020a056512110a00b00500aa419d67mr3063240lfg.8.1694621562071; Wed, 13 Sep
 2023 09:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-18-memxor@gmail.com>
 <mb61pr0n214xq.fsf@amazon.com>
In-Reply-To: <mb61pr0n214xq.fsf@amazon.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 13 Sep 2023 18:12:31 +0200
Message-ID: <CANk7y0iBGC31ifLCLYOFgGaoj8V7UJKUMtx+p9DC5uirhXBZPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 17/17] selftests/bpf: Add tests for BPF exceptions
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 5:14=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Wed, Sep 13 2023, Kumar Kartikeya Dwivedi wrote:
>
> Hi,
>
> > Add selftests to cover success and failure cases of API usage, runtime
> > behavior and invariants that need to be maintained for implementation
> > correctness.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
> >  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
> >  .../selftests/bpf/prog_tests/exceptions.c     | 408 ++++++++++++++++++
> >  .../testing/selftests/bpf/progs/exceptions.c  | 368 ++++++++++++++++
> >  .../selftests/bpf/progs/exceptions_assert.c   | 135 ++++++
> >  .../selftests/bpf/progs/exceptions_ext.c      |  72 ++++
> >  .../selftests/bpf/progs/exceptions_fail.c     | 347 +++++++++++++++
> >  7 files changed, 1332 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_assert=
.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testi=
ng/selftests/bpf/DENYLIST.aarch64
> > index 7f768d335698..f5065576cae9 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -1,5 +1,6 @@
> >  bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_a=
pi_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> >  bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_a=
pi_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> > +exceptions                                    # JIT does not support c=
alling kfunc bpf_throw: -524
>
> I think you forgot to drop this.
> exceptions work on aarch64 with this: https://lore.kernel.org/bpf/2023091=
2233942.6734-1-puranjay12@gmail.com/

Sorry for the noise. I realised that my patch should remove this from
the DENYLIST.

> Thanks,
> Puranjay

