Return-Path: <bpf+bounces-41690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9A999A62
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529D21C266AC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018EE1EABC1;
	Fri, 11 Oct 2024 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6fH3uZK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5F748F;
	Fri, 11 Oct 2024 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613573; cv=none; b=krUo5ESBtEUtD84jKFPRj05rfm4gJq8WnSoHN/p6zMwkc6EeeFiyTqhuZOqKkAdJ/gcE7AT41NkDEso0CWoHLQtSrJag71ALwtEHC1wCtEbURim5mBY9ssFZy/CQAVNY85FC9aGa1qV1n1ycwRr7exBwuY1bRqImuTYlF7MMkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613573; c=relaxed/simple;
	bh=pB09D+ikXn+9IVSsRHluKgs+6L2cI6yP9CmVTwgb6zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIwo8jWDc8jSrT9AXb5QeFayonFdf/yuR7A05GTiW7/Dh3zYzeSoaK2U2eRMUgVzpt7jooH6p4Tlx4HMl8WumcOxaMOO2FdQ9TWiEGMVZelHTOeDp2vSQSzyEQwTKMAT7LcMpIhWgfStVicOjyOwq7u51ZzUncjAhwSgH05iIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6fH3uZK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso1204776a91.3;
        Thu, 10 Oct 2024 19:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728613571; x=1729218371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZCFSI/Agu/8Lkwd3g/VXAxZhDaOh3heOcowRLQjwBw=;
        b=I6fH3uZKzTS3791jWl9KT3IMY7kcNNpir6K8Oa32CziT3pEMdkP6Oc2RBjTiEBIR6u
         V7BRbu1A8egOiJO56MnS/W0jWonMVbgiWBn+B8E4r9NGfLWujUG//pF1ID0L3YuqmU5S
         zjUhIRoOAwl5QcUubfvBdExcANgyTbcU0Yh2hJzFZrypIL5t0dxMUmKiOyu72XmQlYqd
         pbC69VyP524lLsWl8u4ck7de78Dh5lE0mCLvi5SLLu+2/qTy0Dd9bZbCe2Oqh9hu3gZ3
         VE8v3Gt79uRPHwYfiIAzkAjpSuaZzIb1Um2CV5eCaNfLZF/82ilrE+c//u6DoP4ukUVZ
         p/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613571; x=1729218371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZCFSI/Agu/8Lkwd3g/VXAxZhDaOh3heOcowRLQjwBw=;
        b=Ztux1ilQwkrWdl9ilpISrZ/++8/nGwxNUvhjgjszTB732VMNNwcxVDh1sgBovnPlGg
         qD2EWSCQBYMtItL/tzXnytPM8pSFZsh/+i6E9TeaNKgfM+GaUtgYUO7iYRSEw9qgesZN
         IEEEp2fGLW8TJXcst7Nc9iBhIYtXcR1ee49C4EiMds5oaEnbwX8xdwkpw+AhnX9hKO3e
         G91lymIN8jw9D2exJV3Sj20CWbcch0Kx02dqEZXjDouJFWm0LuPQr5rAEJV5uEtOwUnZ
         QE3MWxpZqNF1Mvsf/uuUJ+YzW7+m1MNaTv7eCc95tOirX7D/dmOzPN7BnxzgMUeW0NDZ
         7uJw==
X-Forwarded-Encrypted: i=1; AJvYcCULJaL1xNTpkgfBLN6t1EcNmOg12cHToJL0JJW1oNJMqphUGJOjTm/QSGRM1P9zrY9pP3Mjx5QeZYjwr5Mj@vger.kernel.org, AJvYcCW3Tv5WjjTbZw4U10P3fLKwJEkEzx2k6TzjlRYQ4Pcg5mOuNBsN/nB/tNikSMEbNHalVvhiRclPEUsCnIPyMhMWiKZf@vger.kernel.org, AJvYcCWwheaCLU7NpnDhcsFBguPJb4zTp1Lt7ZaPluaUK7Bi+0NkJFt1sebM7oPJPQvPzZfPZLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEnEX8Qn2CGIK6pv94R17MIM+7TABj2CM7yxma3d/LLSx9g2Vl
	0k8o14jP9hG6co9lwh5JGqYY2TdU8rHvhYffZVsgND8VRMHWPRxwnXdNLe60hgOIOJAbIwnBsc5
	CLZWEapSSNghI99DWGllqmIIUJUJ+O48p
X-Google-Smtp-Source: AGHT+IHI9LnP7gW5W+zrjXwsIsIxBLXMHqmbI+eolb+NC4ufRtsMXGz2TNh+CsRytro0/kp9S+VI1x/DuF1ftVSUOwM=
X-Received: by 2002:a17:90b:438d:b0:2e2:b513:d534 with SMTP id
 98e67ed59e1d1-2e2f0d8ceb9mr1725153a91.37.1728613571473; Thu, 10 Oct 2024
 19:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010200957.2750179-1-jolsa@kernel.org> <20241010200957.2750179-14-jolsa@kernel.org>
In-Reply-To: <20241010200957.2750179-14-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:25:59 -0700
Message-ID: <CAEf4BzY9pp2bQXBwxcS4qLoPRRHrsKjA1UWdpZi3inkuz0PCDQ@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 13/16] selftests/bpf: Add uprobe session single
 consumer test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:12=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Testing that the session ret_handler bypass works on single
> uprobe with multiple consumers, each with different session
> ignore return value.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 33 ++++++++++++++
>  .../bpf/progs/uprobe_multi_session_single.c   | 44 +++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_sessio=
n_single.c
>

see the nit, but regardless:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_singl=
e.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
> new file mode 100644
> index 000000000000..1fa53d3785f6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <stdbool.h>
> +#include "bpf_kfuncs.h"
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +__u64 uprobe_session_result[3] =3D {};
> +int pid =3D 0;
> +
> +static int uprobe_multi_check(void *ctx, bool is_return, int idx)

nit: you don't use is_return

> +{
> +       if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
> +               return 1;
> +
> +       uprobe_session_result[idx]++;
> +
> +       /* only consumer 1 executes return probe */
> +       if (idx =3D=3D 0 || idx =3D=3D 2)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
> +int uprobe_0(struct pt_regs *ctx)
> +{
> +       return uprobe_multi_check(ctx, bpf_session_is_return(), 0);
> +}
> +
> +SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
> +int uprobe_1(struct pt_regs *ctx)
> +{
> +       return uprobe_multi_check(ctx, bpf_session_is_return(), 1);
> +}
> +
> +SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
> +int uprobe_2(struct pt_regs *ctx)
> +{
> +       return uprobe_multi_check(ctx, bpf_session_is_return(), 2);
> +}
> --
> 2.46.2
>

