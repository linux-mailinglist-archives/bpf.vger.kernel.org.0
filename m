Return-Path: <bpf+bounces-53160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C26A4D246
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 05:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD6E3ADF3A
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 04:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345DF1EE7AA;
	Tue,  4 Mar 2025 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="JE4qFaZ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271DBA38
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741061167; cv=none; b=WF5iFTrO0L72jtXdC7b2vAspybq+6yQMJ+FAe2d/RXYq+rgtBJ0AzatOQVRL18Z0Q42VDXYvRvLbQlUb+pzjUisfBvvYiDJs6qEU59mh7Y5Ilct8SKlmfyWvjHsrTYdkRCwKTyXZaVX5GeXUscs+wzZfnsm4vCnJLvj/f9DpUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741061167; c=relaxed/simple;
	bh=oo6gH2jdjNYt6ZHxZMvx/6+ytc0EzmVXbKGR+wg6mkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfXar5JsWpFC5oqvuVjjcAXSJ5ETMMpo0vcnclaAap/5RMc+kHbxPYAMnsa7A9ame/6wW+TfGeb0qEDpd0opoy7VvxeqUbRb8d3OODrCOYuHhDsQ1W93rp9L0SBkAzNqsnfIFnKTLKys/xbhOrdhk4h1QwL9kH8bw2I5lUnh9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=JE4qFaZ4; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fd66f404fbso18658957b3.3
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 20:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741061162; x=1741665962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIqf6mtlDAa3FwsapH2YnZ+PNw95oUew8gpvx9xBf44=;
        b=JE4qFaZ4qDJEiCQAVvqPpsF3x1AZIMK8sEXhkMtDZQNK1vRTSGr6WJQ8iEKhajTKZl
         SPTAVGkNjvAnP8xRTRRyt6mXXXLHmlWYvFHotCUTmFj7DpVjgllNXcl3GW6TQmUv9Uzk
         05i4ldnQVX2Y4y58c5CaqBmcqLduyJk9hlzKXyCcO2s0SSZ5TfM6/ZcogLG3vV4r9kZx
         J2T0Ssl04sfMiKr2Ng6Ot9nHdgv5y9SjiKypGfTbd6NPUh4hcrGoIYKLu49ZiW0Oi67p
         E4/adt6otfJER5iNNZOVoMggwyC2N8KjeEA0eTxLilMfrUm7oqHdwskcAG4XUux21Qgc
         6m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741061162; x=1741665962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIqf6mtlDAa3FwsapH2YnZ+PNw95oUew8gpvx9xBf44=;
        b=eZjgMFh+/ljvpbou0V0k54HhYzSdQaG8yH4L9DiNJ7PLpjjskB5Ajbqu9Z2EdN25Cm
         961pO9LAc+bersR97aFQ3UGb9TY/Uj0ZtyjKLLOU4IyBAsVSU5ikyQrMv4ZeiSgVkhD6
         HWPnKNGaGRVF5f2gux97FJlaGDFC0hObJc4nPmqSdvyymdaJ7TnlsIrv9e+VKVEBFeoG
         0x0xfDJoHZSv8jpTgmkC32PeoVLHSSSHmYi6brSrfFUNZVIODmewDeUMPH7kgNnKunT0
         7Vg+GiBT6ENLVUMw6nBUFe+T8xjQBtcVbrNVoT4dNZSKBYpYncmpbLlwwYKkbao8SEMt
         T5JA==
X-Gm-Message-State: AOJu0YzTLP5Am9VLyrPRxtIVkIwu3Zw6Ravw8vZdTsSdYRotxcSiCUsR
	rrexiKaLtcfzBke8kdhdM0u2bF2/KHF2uoXSbyRsbpY4JmBXc3r31sib0kKWrlHPiwynficVPjF
	MaBxDoqfivjrk+SCYFjpcEiA72LbZvxr2+MafQw==
X-Gm-Gg: ASbGncumLF+wIpsDDt2UssD5YxZrV9Ki4I5LG9u3aRHRp5lFLSeNxnh0xYXn3d8ouCc
	58/NGCjytq4bZQkYDYBsGFt4iFRywNZAPhjnJhVq0CmJ+d8DPJH7T5wN2DEgwFk84rsDcRM2e8+
	0XSqYZGLMqJ6e8PAbArErYtWdGOuo=
X-Google-Smtp-Source: AGHT+IE2y5j2G+ZGxe/NzPc0BwQ1q2z9VkL/AP6dzsAzKYY0XT5CAKud7jy0nZY/85VAcjUedt1I0wtWGyzGv9HG9o8=
X-Received: by 2002:a05:690c:6207:b0:6fb:b1dd:9ffe with SMTP id
 00721157ae682-6fd4a16d1abmr219680317b3.35.1741061161620; Mon, 03 Mar 2025
 20:06:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228003321.1409285-1-emil@etsalapatis.com>
 <20250228003321.1409285-3-emil@etsalapatis.com> <d75cc812-b622-c200-dcf3-a91bbea6a37c@huaweicloud.com>
In-Reply-To: <d75cc812-b622-c200-dcf3-a91bbea6a37c@huaweicloud.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Mon, 3 Mar 2025 23:05:51 -0500
X-Gm-Features: AQ5f1JofAI6sK3s7NzQISikjmdOT0mfcX92Dflqcton49y6Ss19ZYidx9qjD-TY
Message-ID: <CABFh=a4dV=PCZfTf2MQn9831-v-rp3aJfjr1YpfUE9JCrLwUYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: bpf: add bpf_cpumask_fill selftests
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.de, eddyz87@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Fri, Feb 28, 2025 at 8:16=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/28/2025 8:33 AM, Emil Tsalapatis wrote:
> > Add selftests for the bpf_cpumask_fill helper that sets a bpf_cpumask t=
o
> > a bit pattern provided by a BPF program.
> >
> > Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> > ---
> >  .../selftests/bpf/prog_tests/verifier.c       |  2 +
> >  .../selftests/bpf/progs/cpumask_success.c     | 23 ++++++
> >  .../selftests/bpf/progs/verifier_cpumask.c    | 77 +++++++++++++++++++
> >  3 files changed, 102 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpumask.=
c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/=
testing/selftests/bpf/prog_tests/verifier.c
> > index 8a0e1ff8a2dc..4dd95e93bd7e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -23,6 +23,7 @@
> >  #include "verifier_cgroup_storage.skel.h"
> >  #include "verifier_const.skel.h"
> >  #include "verifier_const_or.skel.h"
> > +#include "verifier_cpumask.skel.h"
> >  #include "verifier_ctx.skel.h"
> >  #include "verifier_ctx_sk_msg.skel.h"
> >  #include "verifier_d_path.skel.h"
> > @@ -155,6 +156,7 @@ void test_verifier_cgroup_skb(void)           { RUN=
(verifier_cgroup_skb); }
> >  void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_st=
orage); }
> >  void test_verifier_const(void)                { RUN(verifier_const); }
> >  void test_verifier_const_or(void)             { RUN(verifier_const_or)=
; }
> > +void test_verifier_cpumask(void)              { RUN(verifier_cpumask);=
 }
>
> Why is a new file necessary ? Is it more reasonable to add these success
> and failure test cases in cpumask_success.c and cpumask_failure.c ?

Sounds good, I will roll the new tests into the existing files.

> >  void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
> >  void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_ms=
g); }
> >  void test_verifier_d_path(void)               { RUN(verifier_d_path); =
}
> > diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tool=
s/testing/selftests/bpf/progs/cpumask_success.c
> > index 80ee469b0b60..f252aa2f3090 100644
> > --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> > +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> > @@ -770,3 +770,26 @@ int BPF_PROG(test_refcount_null_tracking, struct t=
ask_struct *task, u64 clone_fl
> >               bpf_cpumask_release(mask2);
> >       return 0;
> >  }
> > +
> > +SEC("syscall")
> > +__success
> > +int BPF_PROG(test_fill_reject_small_mask)
> > +{
> > +     struct bpf_cpumask *local;
> > +     u8 toofewbits;
> > +     int ret;
> > +
> > +     local =3D create_cpumask();
> > +     if (!local)
> > +             return 0;
> > +
> > +     /* The kfunc should prevent this operation */
> > +     ret =3D bpf_cpumask_fill((struct cpumask *)local, &toofewbits, si=
zeof(toofewbits));
> > +     if (ret !=3D -EACCES)
> > +             err =3D 2;
>
> The check may not be true when running local with a smaller NR_CPUS. It
> will be more reasonable to adjust the size according to the value of
> nr_cpu_ids.

Now that the size check rounds the size up to the nearest sizeof(long)
bytes, passing a
mask of size 1 is guaranteed to fail.

> > +
> > +     bpf_cpumask_release(local);
> > +
> > +     return 0;
> > +}
> > +
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_cpumask.c b/too=
ls/testing/selftests/bpf/progs/verifier_cpumask.c
> > new file mode 100644
> > index 000000000000..bb84dd36beac
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_cpumask.c
> > @@ -0,0 +1,77 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +#include "cpumask_common.h"
> > +
> > +#define CPUMASK_TEST_MASKLEN (8 * sizeof(u64))
> > +
> > +u64 bits[CPUMASK_TEST_MASKLEN];
> > +
> > +SEC("syscall")
> > +__success
> > +int BPF_PROG(test_cpumask_fill)
> > +{
> > +     struct bpf_cpumask *mask;
> > +     int ret;
> > +
> > +     mask =3D bpf_cpumask_create();
> > +     if (!mask) {
> > +             err =3D 1;
> > +             return 0;
> > +     }
> > +
> > +     ret =3D bpf_cpumask_fill((struct cpumask *)mask, bits, CPUMASK_TE=
ST_MASKLEN);
> > +     if (!ret)
> > +             err =3D 2;
>
> It would be better to also test the cpu bits in the cpumask after
> bpf_cpumask_fill() is expected.

Sounds good, will address it.

> > +
> > +     if (mask)
> > +             bpf_cpumask_release(mask);
>
> The "if (mask)" check is unnecessary.

Ditto.


> > +
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__description("bpf_cpumask_fill: invalid cpumask target")
> > +__failure __msg("type=3Dscalar expected=3Dfp")
> > +int BPF_PROG(test_cpumask_fill_cpumask_invalid)
> > +{
> > +     struct bpf_cpumask *invalid =3D (struct bpf_cpumask *)0x123456;
> > +     int ret;
> > +
> > +     ret =3D bpf_cpumask_fill((struct cpumask *)invalid, bits, CPUMASK=
_TEST_MASKLEN);
> > +     if (!ret)
> > +             err =3D 2;
> > +
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__description("bpf_cpumask_fill: invalid cpumask source")
> > +__failure __msg("leads to invalid memory access")
> > +int BPF_PROG(test_cpumask_fill_bpf_invalid)
> > +{
> > +     void *garbage =3D (void *)0x123456;
> > +     struct bpf_cpumask *local;
> > +     int ret;
> > +
> > +     local =3D create_cpumask();
> > +     if (!local) {
> > +             err =3D 1;
> > +             return 0;
> > +     }
> > +
> > +     ret =3D bpf_cpumask_fill((struct cpumask *)local, garbage, CPUMAS=
K_TEST_MASKLEN);
> > +     if (!ret)
> > +             err =3D 2;
> > +
> > +     bpf_cpumask_release(local);
> > +
> > +     return 0;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
>

