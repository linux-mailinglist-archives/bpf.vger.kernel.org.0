Return-Path: <bpf+bounces-33697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E914D924B74
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77272913DF
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EF61C2DC1;
	Tue,  2 Jul 2024 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJMqOupr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DE1C0950;
	Tue,  2 Jul 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958270; cv=none; b=kp7IDQTJOYigXg/KchKWVlYQkii/jEq6xLOje2aj2gRZajWm6RCo7vBIUKxYrxNvmi5ky9azhKdQjn72YTCOywAf99mVrdzNZyYDGFAxZ+t7uVZwJZYbsm1eVWpkdKrZ1iMtlDyz2aBAejvpeJ/0Ti3/RiK+XWkg4AHj8uFde/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958270; c=relaxed/simple;
	bh=2NMCyaWR4evinVUCD179WEKkI0Q5gm7rUoAhi8vYmfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAJE+fAW8YKpqEgbjTjmLLyC4v40hTaOROVOhjyBBEfEEVt8W7xrClNk+Qn+Lt+6dEUxxPwkofsB8veiBMc1NWjJ37sh0gjBbMpGu+BjDLm3bG+1gXn7ofT6E+xmwvA2uh+em42j4kFqYCpzg8yyWpXIG67zXHYuXSzQwLgiYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJMqOupr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso3902039a12.2;
        Tue, 02 Jul 2024 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719958268; x=1720563068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnqKEO5ZZcp9/4+BqafJQuEQPd8pEu3nC1s3xKx77jQ=;
        b=aJMqOuprIF4Wp6Wtt7XLhuexuXFFijhZrXab+rrKpONg4XjEOBqLYgdTWQ0nq+6sKS
         dxHZgLjwpxXfQXj0bum6Kp22kHIJqqH5Jz/SzyoIde+5mYCX2EdodK7+ya82JrjP35mq
         deEcHmiPtUMZGugzZqt2SA4Ny+gtiRWfAc/tcu6AuqEAy4ubQYwcc8k0XAp6MmatIle/
         ii+Pk6dZFyp+AdiDZxNpR9i0SbFKgumQ9MKofwqJP1/GL28IrSOfgz259XBDUrS485ZJ
         ZDOMT/Z7eOPRm0MGIjjHENMnRTcIFHc8S2yagGFw1RtoAQIhKr6kf3HUZdeTGFQKML0b
         diNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719958268; x=1720563068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnqKEO5ZZcp9/4+BqafJQuEQPd8pEu3nC1s3xKx77jQ=;
        b=rhx4aNIr5slFT1SveCR2Y79cRGVQOy2kn67W9YPZPgYJ3EP6XsUrldHlgXydYuVhrb
         yn0KXcYLzxcx95vGQAVN+W2eQKd649JylyC1OWtZeRMD3MUuBIgE2J2pzdVivENCVgwD
         7bpklsTABEXkFKMdiHKl2SDdAFxZi6v3FHL6Jd0ql0CYImGtF2xyAmI8rGkQmOON2X5a
         oGWvwnyY9GoXMFDT3Auv4KmgGZ4pQErBoXmSoaCbfSVPRBGS371Lbw+Q3qIHYbMm7uD5
         LeKN6eic4/dmGHj1s4Trb22SLyreJDhTyPfmvdj4olSQYArrcEUCQNLHh2Og1+Cws60s
         zdeg==
X-Forwarded-Encrypted: i=1; AJvYcCV0iWjGhxjyDfThtBxSXuHb1csqSTyqa//l/vfIDPTB6RKq+X/D8u2e6vso5usjUDm5svufi5tgFssVHrCX12mSlnGrT3z+gbZoCk78TiNyXtWQlVw11iiqBWDBxyyUN1q8cYjVxpglxQAe1FWMvuksrhxzE+X6N2EXRkbV11BlDItvaUfW
X-Gm-Message-State: AOJu0Yy5wNXMqQOxfnFQSY/mS+c4mhizzp7prVfdCTO/5XI5J09evuZB
	fJbzUPMHgoE4gSWJHX21UiXGqjabwep0DyYCX/akDcafCa0WSNCRFYREWhJaUGlchGNeRaBNhyz
	WPXxOZ9EegiyGuHzt0t2InhqCq08=
X-Google-Smtp-Source: AGHT+IFimS1GxdoU3Td43x8MAf5jBXtU0svz9P3Elu0oSiqmpSxOmN9dgQ0Zu6rrb21dDj4NiLhvIm7vOI6LWDXUEOw=
X-Received: by 2002:a05:6a20:431b:b0:1be:e1e1:d5de with SMTP id
 adf61e73a8af0-1bef613f48bmr13555315637.30.1719958268208; Tue, 02 Jul 2024
 15:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-10-jolsa@kernel.org>
In-Reply-To: <20240701164115.723677-10-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 15:10:55 -0700
Message-ID: <CAEf4BzYzpyZL+hQogXp-BaWEu6CFvWyicCOnGUxJawMpErLWRQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 9/9] selftests/bpf: Add uprobe session
 consumers test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:44=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that attached/detaches multiple consumers on
> single uprobe and verifies all were hit as expected.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 203 ++++++++++++++++++
>  .../progs/uprobe_multi_session_consumers.c    |  53 +++++
>  2 files changed, 256 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_sessio=
n_consumers.c
>

This is clever, though bit notation obscures the meaning of the code a
bit. But thanks for the long comment explaining the overall idea.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index b521590fdbb9..83eac954cf00 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -9,6 +9,7 @@
>  #include "uprobe_multi_session.skel.h"
>  #include "uprobe_multi_session_cookie.skel.h"
>  #include "uprobe_multi_session_recursive.skel.h"
> +#include "uprobe_multi_session_consumers.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "testing_helpers.h"
>  #include "../sdt.h"
> @@ -739,6 +740,206 @@ static void test_session_recursive_skel_api(void)
>         uprobe_multi_session_recursive__destroy(skel);
>  }
>
> +static int uprobe_attach(struct uprobe_multi_session_consumers *skel, in=
t bit)
> +{
> +       struct bpf_program **prog =3D &skel->progs.uprobe_0 + bit;
> +       struct bpf_link **link =3D &skel->links.uprobe_0 + bit;
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> +
> +       /*
> +        * bit: 0,1 uprobe session
> +        * bit: 2,3 uprobe entry
> +        * bit: 4,5 uprobe return
> +        */
> +       opts.session =3D bit < 2;
> +       opts.retprobe =3D bit =3D=3D 4 || bit =3D=3D 5;
> +
> +       *link =3D bpf_program__attach_uprobe_multi(*prog, 0, "/proc/self/=
exe",
> +                                                "uprobe_session_consumer=
_test",
> +                                                &opts);
> +       if (!ASSERT_OK_PTR(*link, "bpf_program__attach_uprobe_multi"))
> +               return -1;
> +       return 0;
> +}
> +
> +static void uprobe_detach(struct uprobe_multi_session_consumers *skel, i=
nt bit)
> +{
> +       struct bpf_link **link =3D &skel->links.uprobe_0 + bit;

ok, this is nasty, no one guarantees this should keep working,
explicit switch would be preferable

> +
> +       bpf_link__destroy(*link);
> +       *link =3D NULL;
> +}
> +
> +static bool test_bit(int bit, unsigned long val)
> +{
> +       return val & (1 << bit);
> +}
> +
> +noinline int
> +uprobe_session_consumer_test(struct uprobe_multi_session_consumers *skel=
,
> +                            unsigned long before, unsigned long after)
> +{
> +       int bit;
> +
> +       /* detach uprobe for each unset bit in 'before' state ... */
> +       for (bit =3D 0; bit < 6; bit++) {

Does "bit" correspond to the uprobe_X program? Maybe call it an uprobe
index or something, if that's the case? bits are just representations,
but semantically meaningful is identifier of an uprobe program, right?

> +               if (test_bit(bit, before) && !test_bit(bit, after))
> +                       uprobe_detach(skel, bit);
> +       }
> +
> +       /* ... and attach all new bits in 'after' state */
> +       for (bit =3D 0; bit < 6; bit++) {
> +               if (!test_bit(bit, before) && test_bit(bit, after)) {
> +                       if (!ASSERT_OK(uprobe_attach(skel, bit), "uprobe_=
attach_after"))
> +                               return -1;
> +               }
> +       }
> +       return 0;
> +}
> +

[...]

> +
> +static void test_session_consumers(void)
> +{
> +       struct uprobe_multi_session_consumers *skel;
> +       int before, after;
> +
> +       skel =3D uprobe_multi_session_consumers__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_multi_session_consumers__open_an=
d_load"))
> +               return;
> +
> +       /*
> +        * The idea of this test is to try all possible combinations of
> +        * uprobes consumers attached on single function.
> +        *
> +        *  - 1 uprobe session with return handler called
> +        *  - 1 uprobe session without return handler called
> +        *  - 2 uprobe entry consumer
> +        *  - 2 uprobe exit consumers
> +        *
> +        * The test uses 6 uprobes attached on single function, but that
> +        * translates into single uprobe with 6 consumers in kernel.
> +        *
> +        * The before/after values present the state of attached consumer=
s
> +        * before and after the probed function:
> +        *
> +        *  bit 0   : uprobe session with return
> +        *  bit 1   : uprobe session with no return
> +        *  bit 2,3 : uprobe entry
> +        *  bit 4,5 : uprobe return
> +        *
> +        * For example for:
> +        *
> +        *   before =3D 0b10101
> +        *   after  =3D 0b00110
> +        *
> +        * it means that before we call 'uprobe_session_consumer_test' we
> +        * attach uprobes defined in 'before' value:
> +        *
> +        *   - bit 0: uprobe session with return
> +        *   - bit 2: uprobe entry
> +        *   - bit 4: uprobe return
> +        *
> +        * uprobe_session_consumer_test is called and inside it we attach
> +        * and detach * uprobes based on 'after' value:
> +        *
> +        *   - bit 0: uprobe session with return is detached
> +        *   - bit 1: uprobe session without return is attached
> +        *   - bit 2: stays untouched
> +        *   - bit 4: uprobe return is detached
> +        *
> +        * uprobe_session_consumer_test returs and we check counters valu=
es
> +        * increased by bpf programs on each uprobe to match the expected
> +        * count based on before/after bits.
> +        */
> +       for (before =3D 0; before < 64; before++) {
> +               for (after =3D 0; after < 64; after++)
> +                       session_consumer_test(skel, before, after);
> +       }
> +
> +       uprobe_multi_session_consumers__destroy(skel);
> +}
> +

[...]

