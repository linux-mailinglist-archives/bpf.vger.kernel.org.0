Return-Path: <bpf+bounces-43784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6999B9959
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031E3282054
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061881D7E52;
	Fri,  1 Nov 2024 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEIi7L/X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1782155C9E
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492538; cv=none; b=Cuove3RjQdH0EyCOPj+OlItRDWB/Sg7jCep7CmBv3YVwrD9E7wdmQSRP7DkwAeXSuyjA3lpGjH3PrVwbliErBqetjDoRsoVZG4b+EVYcOeJvspWCd+MNy+d2GM49RSC9S1yh7kmehmbPQcl7GPxxF+F2qo8xxKbSsuYnOvsWbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492538; c=relaxed/simple;
	bh=/L8O35yhLt9KzX2WY98IdPzARqafUdXABrwa/S9H0wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3En/B8lsVus3oS92KsdUdIof83gGqUfJJAKh+64WtZ2lP5RNaFa0x8dNfPIa2CBesxCxv4c8ZUFWOpQAaYN+fXyZqSaIB/Ydeaxd3ezsgT+zDwkn81lioVQB3HWi+7qe26cn9kpWZIddiP3sCTCOc0hNdoUNET2FiFlX0eWUzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEIi7L/X; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so1572071f8f.2
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730492535; x=1731097335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHQukP9SCtpVW6zB+0cFt300Ls+v8Et2kuaW99rbhBQ=;
        b=MEIi7L/XyDvgUmimJ0lQkdseRYQDh9t/TBLhjhQ+2mHcQwYbyxF1v7Zl88T+mp6ALH
         aB05AYt5pC9jnGSu9kPWgMfHGS2rrANPjVyyCqDRPEcuEDk4JcCS1ml6QulaeMwhNRS4
         41/+MwAC+lrzR7hRIq7CM0CB4bGKE6VdjFlgXQXY1wFNv8usS56SNyqT11sPzTC2w0I4
         XPWdZvxTjNlfG+7KHFJumRzY+bUO+rK0hhUdvNPZ4ZqWx8+ezK6WlJQfr4M7F2ox4lgq
         lkGdXiQDKxEqLXct0LXQoPSzEMV+pPnOVuDnwkXl+B2xjUsQ8QN0eKDQhCTywntV+6Ls
         bX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492535; x=1731097335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHQukP9SCtpVW6zB+0cFt300Ls+v8Et2kuaW99rbhBQ=;
        b=myG/clZ9764MT8Vz59VxujR8DKEohu3gKJ4vmtElrQwP7qfWWDAT1cjcjl9SDg5QR0
         x93Bjr/V/a+455ri2rmoniK1ukCJoEXVB/PXSFAfYHGM+yyJFobqD151MqUq/rAtWkUS
         hFxCNZZ2b15clX3HMSdC2fSuNWEKxlXOxXVyucbxodEajlWo+JJvbFuzQh+KubR26+AU
         SFTm7sPtWFKWKYn4jNzwfJD7YmNXmCoy9JaiLvId9EOAgS+gflwAGp16ZMoDWU1vjIP0
         hhb/VDVad52P13qCbYW3gIVNGhC+dgREfd1Ae7Wc7+BEZRTVQmFY3lOp8DVJHOFY5Wue
         L7nA==
X-Forwarded-Encrypted: i=1; AJvYcCU4U0D0AoGLyVhb0R3psqixxidSNF7PabJldmKG2YE4s9+JhsfPJ2SYVQDkJVsI+E3NuKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVlGrJFovBoFrqSjtZYof23xfg2rJjKZI0fiHOf8HR45CbH0bA
	F0wUyZhffK724hHElhO/iqm7jOgrW6flaJO+8coQn45ZqOOBq4FZST9ByPC+34sKdFr7dRhgcdS
	Ysa7z1asjccsAoXl39XYBIYOEIOY=
X-Google-Smtp-Source: AGHT+IFH+j6mjBKQDhmMgrTPHMhPwy+PD6zcaF61HxIu8aEbnvAT+bQwN4ot6riWhdem2RgPh1Wc3yeCsY7e+9z1O7o=
X-Received: by 2002:a5d:5f89:0:b0:37c:c4d3:b9ba with SMTP id
 ffacd0b85a97d-381be7ad23fmr7788476f8f.12.1730492535090; Fri, 01 Nov 2024
 13:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101195702.2926731-1-tao.lyu@epfl.ch>
In-Reply-To: <20241101195702.2926731-1-tao.lyu@epfl.ch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Nov 2024 13:22:03 -0700
Message-ID: <CAADnVQKV=4Dc7e_rFJEYYX1-1HWO9Yzgwb5d2kPnCCzcwUX+_g@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix incorrect precision backtracking
To: Tao Lyu <tao.lyu@epfl.ch>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:04=E2=80=AFPM Tao Lyu <tao.lyu@epfl.ch> wrote:
>
> Hi,
>
> The process_iter_arg check function misses the type check on the iter
> args, which leads to any pointer types can be passed as iter args.
>
> As the attached testcase shows, when I pass a ptr_to_map_value whose
> offset is 0, process_iter_arg still regards it as a stack pointer and
> use its offset to check the stack slot types.
>
> In this case, as long as the stack slot types matched with the
> ptr_to_map_value offset is correct, then checks can be bypassed.
>
> I attached the fix, which checks if the argument type is stack pointer.
>
> Please let me know if this fix might be incomplete.
> I'm happy to revise it.
>
> Best,
> Tao
>
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> ---
>  kernel/bpf/verifier.c                     |  6 ++++++
>  tools/testing/selftests/bpf/progs/iters.c | 23 +++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 797cf3ed32e0..bc968d2b76d9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8031,6 +8031,12 @@ static int process_iter_arg(struct bpf_verifier_en=
v *env, int regno, int insn_id
>                 return -EINVAL;
>         }
>         t =3D btf_type_by_id(meta->btf, btf_id);
> +
> +       // Ensure the iter arg is a stack pointer

no c++ comments pls.

Also I believe Kumar sent a fix for this already.
It fell through the cracks.

Kumar,
please resend.

pw-bot: cr

> +       if (reg->type !=3D PTR_TO_STACK) {
> +               verbose(env, "iter pointer should be the PTR_TO_STACK typ=
e\n");
> +               return -EINVAL;
> +       }

