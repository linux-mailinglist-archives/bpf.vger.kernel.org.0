Return-Path: <bpf+bounces-47255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788909F6AC5
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB753188B615
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1681F37AD;
	Wed, 18 Dec 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/KsCt7u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDE1E9B39;
	Wed, 18 Dec 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538235; cv=none; b=NBFFjuGmk/4q7u6X+CXBAydPk8L8QbeVbtiZmbbFrs1iOzk7JObgrCsYrB/oZtbPjrcJeWpo6NGKwpfWnuuGQ59C/y4TfWmGRC8xqJjEZtbnYopo+uInXqqchOmWs7ncRAP4oeEzrywPmuvm9/3bb+fTY/XR3GN5Brb2Tnr95OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538235; c=relaxed/simple;
	bh=xUnF+y4uovZdNpeIH2k8Av2PE4uD4zJrGUs5uEwgG9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1A+o1CjVyNDt1TTWqlO1wpzS+JLUNoNIiHpUjxedF+CLan6g0SlbDbNboPPOtOGagUpl3xTSHNMtQ7QVPXlwJS0+kxib06azEqk5KaCt4MMhuqSSBSku5IR3IgB/gG/+83IGUB2IA/ZBFxMATuJTu/FywGmqWDNPIZd6VsrJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/KsCt7u; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6efe4e3d698so52590897b3.0;
        Wed, 18 Dec 2024 08:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734538232; x=1735143032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtvghjFKK37r9cMfNimCkciqZPOXsWGCRwc0bYSZwFc=;
        b=J/KsCt7u68sckaO4UoiLyLIv8oP/AcN1CzY8TUKVkldeBPrMLTr94q3RuyEX013Mgk
         pla/xtCJpSdBQOfrBmRZ3OHhihJk0iwXvWEQVVGVxY+DxCwR8d/3RB1FW9Rz/s0jKp2O
         c0VEl/tFsicFWEeuL+jtZ9Evvllw8Tn85v5cbkZX4WYA0YA+GPVskGwUEyKaGL4Ij6Ha
         /+iLz9cYarZ0x3nBSNjlPWHGA0lyBeCXTq31u/o6k1Ig4IZ27iM7Csb5W0dwSmB+Hddg
         rQk5xwYZXS01+7WQCvFpIQx5PHTSp+G+W4Z7X6emLu5m0EdTiV6gLN86eEWo3fclK7qd
         pnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734538232; x=1735143032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtvghjFKK37r9cMfNimCkciqZPOXsWGCRwc0bYSZwFc=;
        b=C0Dn1Yaw1EFpNsn/FeZPoKVkSCs2ceLft5Q5E3C1LevhvrXhYGbHNlTbwdkkYxskVu
         QdmewW37cw+DJoHof5N8oq10eoK/1YbbLTxv/lacelysek1X8tw1wYOYH9hWMq6BlGGt
         zY99N8/Sw/lYHGKdgduHVu4oz8yU0k5i8yTEluG2FP6IYDcFk01t4cEslufmoCD/tpZO
         oLxYdSf8Gw1LMNwrS9+PpQiJs6CgRkbOsP1jnAK5p+HFQTH0r0zHw+Vtn9XdxAVCHpxO
         il1hZMfbLfYx60Mpj1/fesCZQh0stMzSeyORkpologpVuZTVmQsljdOnwHjl7KnblYqA
         KRrg==
X-Forwarded-Encrypted: i=1; AJvYcCUr4Ep6E5yKuI2aCqPqWRy3eleLMM8Wj7+BYz/2FUwOh5tzdw9mwhtKyK/Hw70pRKeedio=@vger.kernel.org, AJvYcCWXkvyrumv5rlr/of6/Qk5NsWqxiHRNOEJjf/TxWcO1/4AOjkQqkUXwGbVPwJpR0CzHXIQIa3GB@vger.kernel.org
X-Gm-Message-State: AOJu0YzaieYMHxSrS0IoVj7Apakwqf6gcGzWY+8l76NSwU+5OXk20ipO
	yb2V1cBAOHpfzYCSFht7bLS7EYtjrg8kKe7PEzGySzz9Uhc41/Rt2QqDMSFnI9oKOcC/TsIHq2M
	/O0Do1WWvvAHcc/DOoTPGlnlv1fA=
X-Gm-Gg: ASbGncsXPZwK6id5jcGAn5MvowPGE/NgiHnhMPysg9kRwh58TvEyllXKYO9fQGk3ZwK
	zxz1RmRHpXSqexkcROh0Tsz6n1JvsjKVPMrsqy04=
X-Google-Smtp-Source: AGHT+IGCZD+srFmsKqDDgb/bF6aZlcNo10N24Rt1dKCOdV+lJzu7PSm7zqXtOeK03waz9Kx5ye0EueJaaKEkxjqO6Z0=
X-Received: by 2002:a05:690c:360c:b0:6ef:4fba:8153 with SMTP id
 00721157ae682-6f3ccc2f8e4mr26244357b3.10.1734538232509; Wed, 18 Dec 2024
 08:10:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-3-amery.hung@bytedance.com> <455a554d-fe8f-4c9e-b1d9-654897da92ce@linux.dev>
In-Reply-To: <455a554d-fe8f-4c9e-b1d9-654897da92ce@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 18 Dec 2024 08:10:21 -0800
Message-ID: <CAMB2axNPwhEsUKf6JX+oBxL4JkS2CyTDfOQ=x2D5T6mtXy_o-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 02/13] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 5:17=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/13/24 3:29 PM, Amery Hung wrote:
>
> > +void test_struct_ops_refcounted(void)
> > +{
> > +     if (test__start_subtest("refcounted"))
> > +             refcounted();
> > +     if (test__start_subtest("refcounted_fail__ref_leak"))
> > +             refcounted_fail__ref_leak();
>
> test_loader.c could make writing this test easier and it can also test th=
e
> verifier failure message. e.g. for the ref_leak test, the following shoul=
d do:
>
>         RUN_TESTS(struct_ops_refcounted_fail__ref_leak);
>
> The same for the other subtests in this patch.
>

Thanks for the pointer. I will change selftests in this set to use test_loa=
der.

> > +     if (test__start_subtest("refcounted_fail__global_subprog"))
> > +             refcounted_fail__global_subprog();
> > +}
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fa=
il__ref_leak.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fa=
il__ref_leak.c
> > new file mode 100644
> > index 000000000000..6e82859eb187
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref=
_leak.c
> > @@ -0,0 +1,17 @@
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "../bpf_testmod/bpf_testmod.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
>
> +#include "bpf_misc.h"
>
> +__failure __msg("Unreleased reference")
> > +SEC("struct_ops/test_refcounted")
> > +int BPF_PROG(test_refcounted, int dummy,
> > +          struct task_struct *task)
> > +{
> > +     return 0;
> > +}
> > +
> > +SEC(".struct_ops.link")
> > +struct bpf_testmod_ops testmod_ref_acquire =3D {
> > +     .test_refcounted =3D (void *)test_refcounted,
> > +};
>
> [ I will stop here for today and will continue the rest tomorrow. ]

