Return-Path: <bpf+bounces-41688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B0F999A5A
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3722B21ABC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC1B1EABA7;
	Fri, 11 Oct 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5qumAhB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B668748F;
	Fri, 11 Oct 2024 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613437; cv=none; b=PUVXnLl3SEQrN1dfjOYoSkaerjPgbFOWfXt1er8j2+TutavUPEaZ7KATmU4G1YjcjdM/BHjlcHrMLn6rElSyxBST2XQcQ+4A/wVQbmmcHxZJXeLu//zeTJt2LrBw/wmlVZoNcRWF6XzbFuOcqN/orlpHhoeECrdNYb+98kguzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613437; c=relaxed/simple;
	bh=hB9Rm+VDiS20ETnnY3kZOvZq0gxnb+tOePxB8JsfUww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUO5LzqNfiU56mRSalvDlH7mQs3YpJ6Ae/T6lv3CBJv/nNwN6tnErBp5gTWuOWaX/M2sxf2L2p7QcBqWFBisEMhAML/60Nm4V8mz1TQblpwaUoJZ0Ez9RO9xnGYjbjacXA9hLvymBm05U1upi5IJRLhwp/bL3LfQGkL/Vs40LNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5qumAhB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7163489149eso1192090a12.1;
        Thu, 10 Oct 2024 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728613435; x=1729218235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIQO3j6PuoeGl6CJy42IBSBkjRIWT/5RPimBtGSIMHw=;
        b=S5qumAhB9FU8DLs1fjF5CK7A197pWvtjL5nG/KLc2IB+oc6TT/iqNTrk8P46YGOICx
         6z9t5DmZC5Za2jPhdHn/18u9ZlY+fEtwOHg0IQx1hVPlT+g9G6g5Cuj+EKMuUtXvT3Sg
         ylU//R4r+qZ8xfS3O1V+6l9Ut8TA2y6Z3orgEV7bgHjy8l9moTkaOAiZw7/PjRrTw7/W
         xgKl9n/K8rHVbt2LtAZ42nIP/miJVxqC8aFGLTqbaWtn6E7DDndjC+vmyuaKuLKNkMvw
         VuCiYTmtc1Qc+3PB9wLCjiDW6xNc9TPxn4KWT0KOaPO/1BlCZVOrS0/KUCGnDmtL9d4y
         mVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613435; x=1729218235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIQO3j6PuoeGl6CJy42IBSBkjRIWT/5RPimBtGSIMHw=;
        b=rAVUe9oB0QScQLrcxYNexL84e8JCn+IpLpT8H+ZpNh3ND/letADCA897H8UPNjCdQJ
         Nka9+FTkDtuvpBEGj69xE1Ws6Gi6m+gqV+H579dJbuL7bhqNCCRMvi5bboXhClc6Od7Z
         Tkem3arzZIjbwWNURCzTnIfYZ1+kIR4nqp13CYVD2aTNLw66rKL9q6spjjs/tLLh9Ohh
         4NrdMhEV8UJ1RKDh69VXJE51+u5HpfRmu7XQv2mghfe7+f35PkAaPkg+JYkF3rLaD69/
         jPKpi+3sQgfZ51t1rkca444Rbp+bUDaXY1Tj2KJqq0KrapYWqtelDa2gnSpHof0ndfjX
         bQwA==
X-Forwarded-Encrypted: i=1; AJvYcCUSauMswDVlyuOPB/KK+RKXTlOLJ2f6kBA1EG2TY1nm6erEd1R3yPrhmESFyzraNqwNBPA=@vger.kernel.org, AJvYcCVU2M5Gw9HEjLML/DTDaovXu49XvYOJaEQ1qFg/zhKvvmYTOxXymFfZMIfW9W9bOFyAzx9P4ZDstAa79CI2iCObm3yV@vger.kernel.org, AJvYcCVW7GITJ6eWszkaAPMwob8fxTTESyMHJbXxEAduJ2Uw2ooh0S+hP9mQePkL3GU94Y1tX7nlFfMZilI1RgbH@vger.kernel.org
X-Gm-Message-State: AOJu0YzYi99FJ9V8kfZGtGytB8xdJRA+wvIPdZ9TJLS4gOazZrKchMRq
	pCyw55hWxeEP9KdAl1wAtU6FIzRdJSYz89P55QMZ83L6/gSa7NOkp1h+utAbj5KfJ8QrNpNUOZu
	sdxl2GbmeNJrCkp0k5yMx7N3nP7o=
X-Google-Smtp-Source: AGHT+IG7zr7TqS769iqGNvW/ctWNHznWpjgLubJG4GRwHgBaXZz48MS65kb0h0zZXZtCnmqSjxZJkyAloFKYL6ecIXg=
X-Received: by 2002:a17:90a:6883:b0:2e2:c681:51ce with SMTP id
 98e67ed59e1d1-2e2f0ae879amr1763316a91.1.1728613434951; Thu, 10 Oct 2024
 19:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010200957.2750179-1-jolsa@kernel.org> <20241010200957.2750179-12-jolsa@kernel.org>
In-Reply-To: <20241010200957.2750179-12-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:23:42 -0700
Message-ID: <CAEf4BzaBxEVdnHGTkGjqmaXG2OZ_HcNVTpWdfy__DXCFymBcyw@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 11/16] selftests/bpf: Add uprobe session
 verifier test for return value
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
> Making sure uprobe.session program can return only [0,1] values.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        |  2 ++
>  .../bpf/progs/uprobe_multi_verifier.c         | 31 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifi=
er.c
>

Nice

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 284cd7fce576..e693eeb1a5a5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -11,6 +11,7 @@
>  #include "uprobe_multi_session.skel.h"
>  #include "uprobe_multi_session_cookie.skel.h"
>  #include "uprobe_multi_session_recursive.skel.h"
> +#include "uprobe_multi_verifier.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "testing_helpers.h"
>  #include "../sdt.h"
> @@ -1246,4 +1247,5 @@ void test_uprobe_multi_test(void)
>                 test_session_cookie_skel_api();
>         if (test__start_subtest("session_cookie_recursive"))
>                 test_session_recursive_skel_api();
> +       RUN_TESTS(uprobe_multi_verifier);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c b/=
tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c
> new file mode 100644
> index 000000000000..fe49f2cb5360
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/usdt.bpf.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +
> +SEC("uprobe.session")
> +__success
> +int uprobe_sesison_return_0(struct pt_regs *ctx)
> +{
> +       return 0;
> +}
> +
> +SEC("uprobe.session")
> +__success
> +int uprobe_sesison_return_1(struct pt_regs *ctx)
> +{
> +       return 1;
> +}
> +
> +SEC("uprobe.session")
> +__failure
> +__msg("At program exit the register R0 has smin=3D2 smax=3D2 should have=
 been in [0, 1]")
> +int uprobe_sesison_return_2(struct pt_regs *ctx)
> +{
> +       return 2;
> +}
> --
> 2.46.2
>

