Return-Path: <bpf+bounces-20069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E78386D4
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 06:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E2E1C23057
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 05:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E2E4414;
	Tue, 23 Jan 2024 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCZd2P1q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8D610E;
	Tue, 23 Jan 2024 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988626; cv=none; b=noLhdHeB2qrBitzFScL5tdHqcfBiIge4sK/v1kRx3kiNUbSXsarU9yvL+/osmSxQiqEkZKmI+ImcnyC0LO0OqMlmPcWWryRh8RqTgGl3wL4kVvUROW5nGr6Kexmo304Ob9BmFe96rhy6yLuhTdNjn8VBO8FZ8tRMdudrfymf7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988626; c=relaxed/simple;
	bh=7rGHj9r3OXJL07yNpi61MkOCzh1FvjG8lj3vqTCI+SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNEuUtE4FjAUCAGDToBxE+aOQuFzkiskgPij+puvPc2ai7/7lHac0ThgTbkZwuE3Ict8XPBliGWkxmixdYYWXBktEf7Vj703NYPm+1TWfIB3V7pZe0+GwuBUCrOSOJ5fuyc0YT8972hZtFTuqQmtlDErr93fpvNAnPafzr/BaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCZd2P1q; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-290b9f83037so834887a91.1;
        Mon, 22 Jan 2024 21:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705988625; x=1706593425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuovRQjx7d71L1ULwmEIz7mlWHd8R7QHzO34D3ThGeY=;
        b=gCZd2P1qWCzjCQ6SGE5wcBHzqz7subo5zf/zCJuvXsPCV0bTd5YQTWuYZcpicA1VkC
         /qS9SJv0yPGR2+C+Ml/KQWDJGfstIFqHeMxctHMVoUAsJjTNZGYPGvI9fDSEJmzroJt5
         W8IwajDpoMn70jhs6jqe6AsgqmvtkILJzH1Wzr3Mx4xSL/xk291205vppfq+tlxkknKF
         BxSS1e+u1A8b5e1F9QvRr52Lk9yJfeF5nejVTIf742AmbHqAWhUE7/MxNpa+nuhV9Tzg
         iTVkTtFj8IEKjWI796/RoufakI32/pf9podI/NiTi8LHkzTmTp7YBGxMzqCYcoa/k8nl
         cYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705988625; x=1706593425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuovRQjx7d71L1ULwmEIz7mlWHd8R7QHzO34D3ThGeY=;
        b=rlLOH7UleX85vby9hHBf8daVOcUd6im3SwcoHMOtPnhy5Hxgwu+pFtfeJuo0gbB5i1
         En3RMalwnUNoa3nddnlLgMTFvo/Oe+SERB3W6eykxc4gp7bodWWc4UWhL4/IvgzQIs1z
         UbQrCTMivcdygoX72hmpVVmc9BiZ9LMipZZnaj7FegdEs4lPew0tZUfgpugvWBRhODLm
         bROqiVZYnr/ARRFDwNnoR08UroVHCPSGrff/0li4CC9iRuAijSalgzZwtL2RIeoNx1zx
         BlKr836Y4Kac+LEZz2M2qYKUVOFQTC71owmlDQN1iLtCJiR7J6iH0Du5Lgsa48+itdbB
         MqYg==
X-Gm-Message-State: AOJu0YzHXGQ3oO94zTJtRZZ8nlndX7OCaYGefpHN93GbI+OrAkkujfsw
	HXbwzorGMOe3AsUPqddTfrJ4C3RWVK6YrywiSaGRNddlmHZ4QSgs6hHsT9xTB1ybyoy4GcX0d0o
	OnKyQOGtUKWAPWyCGA9jHOyqQB68=
X-Google-Smtp-Source: AGHT+IEXUaDidFghYUnWcJpAOGf8GFGtYpk0jNWNdlFlwcsv+0JMDDc5RlHGVi+IG2fPEqGTCINRiIYKXhAdCOJTTz4=
X-Received: by 2002:a17:90a:1041:b0:290:2405:aee7 with SMTP id
 y1-20020a17090a104100b002902405aee7mr8514741pjd.11.1705988624603; Mon, 22 Jan
 2024 21:43:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122075700.7120-1-yangtiezhu@loongson.cn> <20240122075700.7120-4-yangtiezhu@loongson.cn>
 <CAEf4Bzaj=W3tUbfKRbQ3JgYqXimthVOs9uvmj4YxkbDhE3v0SA@mail.gmail.com> <15c4c8b2-9561-37b9-91d9-ce4ec76537e4@loongson.cn>
In-Reply-To: <15c4c8b2-9561-37b9-91d9-ce4ec76537e4@loongson.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Jan 2024 21:43:32 -0800
Message-ID: <CAEf4BzZuMJ7gsRLL03irRrMH6DAO-NsvQoiYrfV4Ga_3hJUMWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: Skip callback tests if jit
 is disabled in test_verifier
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:35=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
>
>
> On 01/23/2024 09:08 AM, Andrii Nakryiko wrote:
> > On Sun, Jan 21, 2024 at 11:57=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongs=
on.cn> wrote:
> >>
> >> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
> >> exist 6 failed tests.
>
> ...
>
> >>         if (expected_ret =3D=3D ACCEPT || expected_ret =3D=3D VERBOSE_=
ACCEPT) {
> >> +               if (fd_prog < 0 && saved_errno =3D=3D EINVAL && jit_di=
sabled) {
> >> +                       for (i =3D 0; i < prog_len; i++, prog++) {
> >> +                               if (!insn_is_pseudo_func(prog))
> >> +                                       continue;
> >> +                               printf("SKIP (callbacks are not allowe=
d in non-JITed programs)\n");
> >> +                               skips++;
> >> +                               goto close_fds;
> >> +                       }
> >> +               }
> >
> > Wouldn't it be better to add an explicit flag to those tests to mark
> > that they require JIT enabled, instead of trying to derive this from
> > analysing their BPF instructions?
>
> Maybe something like this, add test flag F_NEEDS_JIT_ENABLED in
> bpf_loop_inline.c, check the flag and jit_disabled at the beginning
> of do_test_single(), no need to check fd_prog, saved_errno and the other
> conditions, the patch #2 can be removed too.
>
> If you are OK with the following changes, I will send v7 later.
>

Yes, I think this approach is much better, thanks.

> ----->8-----
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c
> b/tools/testing/selftests/bpf/test_verifier.c
> index 1a09fc34d093..c65915188d7c 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -67,6 +67,7 @@
>
>   #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS     (1 << 0)
>   #define F_LOAD_WITH_STRICT_ALIGNMENT           (1 << 1)
> +#define F_NEEDS_JIT_ENABLED                    (1 << 2)
>
>   /* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
>   #define ADMIN_CAPS (1ULL << CAP_NET_ADMIN |    \
> @@ -74,6 +75,7 @@
>                      1ULL << CAP_BPF)
>   #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
>   static bool unpriv_disabled =3D false;
> +static bool jit_disabled;
>   static int skips;
>   static bool verbose =3D false;
>   static int verif_log_level =3D 0;
> @@ -1524,6 +1526,13 @@ static void do_test_single(struct bpf_test *test,
> bool unpriv,
>          __u32 pflags;
>          int i, err;
>
> +       if ((test->flags & F_NEEDS_JIT_ENABLED) && jit_disabled) {
> +               printf("SKIP (callbacks are not allowed in non-JITed
> programs)\n");
> +               skips++;
> +               sched_yield();
> +               return;
> +       }
> +
>          fd_prog =3D -1;
>          for (i =3D 0; i < MAX_NR_MAPS; i++)
>                  map_fds[i] =3D -1;
> @@ -1844,6 +1853,8 @@ int main(int argc, char **argv)
>                  return EXIT_FAILURE;
>          }
>
> +       jit_disabled =3D !is_jit_enabled();
> +
>          /* Use libbpf 1.0 API mode */
>          libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
>
> diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
> b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
> index a535d41dc20d..59125b22ae39 100644
> --- a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
> +++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
> @@ -57,6 +57,7 @@
>          .expected_insns =3D { PSEUDO_CALL_INSN() },
>          .unexpected_insns =3D { HELPER_CALL_INSN() },
>          .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>          .result =3D ACCEPT,
>          .runs =3D 0,
>          .func_info =3D { { 0, MAIN_TYPE }, { 12, CALLBACK_TYPE } },
> @@ -90,6 +91,7 @@
>          .expected_insns =3D { HELPER_CALL_INSN() },
>          .unexpected_insns =3D { PSEUDO_CALL_INSN() },
>          .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>          .result =3D ACCEPT,
>          .runs =3D 0,
>          .func_info =3D { { 0, MAIN_TYPE }, { 16, CALLBACK_TYPE } },
> @@ -127,6 +129,7 @@
>          .expected_insns =3D { HELPER_CALL_INSN() },
>          .unexpected_insns =3D { PSEUDO_CALL_INSN() },
>          .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>          .result =3D ACCEPT,
>          .runs =3D 0,
>          .func_info =3D {
> @@ -165,6 +168,7 @@
>          .expected_insns =3D { PSEUDO_CALL_INSN() },
>          .unexpected_insns =3D { HELPER_CALL_INSN() },
>          .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>          .result =3D ACCEPT,
>          .runs =3D 0,
>          .func_info =3D {
> @@ -235,6 +239,7 @@
>          },
>          .unexpected_insns =3D { HELPER_CALL_INSN() },
>          .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>          .result =3D ACCEPT,
>          .func_info =3D {
>                  { 0, MAIN_TYPE },
> @@ -252,6 +257,7 @@
>          .unexpected_insns =3D { HELPER_CALL_INSN() },
>          .result =3D ACCEPT,
>          .prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> +       .flags =3D F_NEEDS_JIT_ENABLED,
>          .func_info =3D { { 0, MAIN_TYPE }, { 16, CALLBACK_TYPE } },
>          .func_info_cnt =3D 2,
>          BTF_TYPES
>
> Thanks,
> Tiezhu
>

