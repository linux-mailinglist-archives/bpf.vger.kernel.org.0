Return-Path: <bpf+bounces-56519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B74A996C1
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86ABE3BEFDC
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE7E2857CF;
	Wed, 23 Apr 2025 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTAI5lN/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476B264A89;
	Wed, 23 Apr 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429677; cv=none; b=DcZxtBvziHcTLVIQLWl3AkmTBAmDRKF6yYca2qKU6I/U6V1zScMrejsDAU62ujP6N1TWV4rMozk86JsqOIB9RdrI9zs4c8DYGEemAINnHZDcqmfPcEwpSqF9YUFm9V485oBminapK89Kqs1VOOW+UUd9sy44TWJTIRhMa4RmPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429677; c=relaxed/simple;
	bh=n4L3kGj7dIWkX0YgIds/zFis/5wBQ8FsBRO1BYRt6lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7iq+boOlLa+d4OGgmM0KpKHpvC9ONSbPe8GDQoDG+VZQTI70kBGTNZm5u29UNnb4lDFngkReHOkbST7JNk8uHk0WeiVawx43aug9Fk+KsnQoIfJl+BQmWosPYpg/ZWAuo2sh8wufTBQRHoR03io0ReY7VqMxWEOxnjB4XA6mTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTAI5lN/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acb39c45b4eso20889366b.1;
        Wed, 23 Apr 2025 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745429674; x=1746034474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0IgeqQK+ypxMEBs2TKNqLAgjf7iZpebNiYho9qWtDA=;
        b=WTAI5lN/mLSjHLR0q3lOCGCySewqx8rC5r/Y/F3hNMOz6vf76IsXixB4aUxrbX7mwx
         dtgcnnivSP3Vgpz0Lo5XTerOmoM3xodURuraFgqy0ZH4VJv5/gCPU2wGXmyhsnvP+JDH
         2CbthJshJYTGgBybEprutS27jmGG3do70+3Qau2ukqmFRqdmEEmEphjURxWAMrdEpJJT
         nC6VhmZoaSrt5RaDli0Uie7xLSdLlZo8SR+9wM/ClT8XzYLb9VohHQ16Eeo8GYFoG6AO
         HZYjN6/YXozq+eEcg+Aj8Lkb5bcKIdpvLn3xMHJuwDjAzYlUweoGTHko9y4L2otAU3Hw
         xQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429674; x=1746034474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0IgeqQK+ypxMEBs2TKNqLAgjf7iZpebNiYho9qWtDA=;
        b=jzbMnm1xwVIPdf4HYGNi99HkxQVoN5PFnhoAf/TQTtzls6mkcgNrrQ+7v5XiDaJnKY
         4aFivExYU23t9+KxljchdB8J4txeosbj1E37mhPCODMQpF98juufg9YBXKNDIgaDhrHL
         yFiUtu91AYxHwavA/IL1WOyKCGihuRGhn2uwqz/vrOD5hElz3PLPomjTvajU1J4Q8r/Z
         ok2vDjcQAvi69ZsszLeOgJyPlcPfu6Vy2kmrbYp+pGVvFRJU+zW/HMOPo/jkrdxb8teF
         yeeXLfwFD3M1IXCLTaEFTrQpjEl0QMAwxPj5+mQT+IhJ6TtQxPdJm32AH2usEum6W4yd
         qTxA==
X-Forwarded-Encrypted: i=1; AJvYcCUrCjX/Qs6UgWM60KgGaVtA+lHTvfLJiRiJ2NfpPwKeNnodvi9K7g2f7P4b3vNztkX0r+c=@vger.kernel.org, AJvYcCW0HsqlC+j2CKuX14M01gch8WkEgxcbN6wL86+OquLYmYkbVHBa4Ndsz5ZUKEcLxllGrnTgiHzJ2ePaHBh0UCKUMPO/@vger.kernel.org, AJvYcCWz+QbhAcONhDgxL9gBMdz83zo8v82KwePgw2RSVfVXurH+gftYPbpfsr065791VbBvc50v6p5gPQ9H4C5M@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0YYqIhKBYcL1mdz5bpsKnXJ1VFf3gY39Z9fVwdpttoucgqAf
	HsnZnFNoTPnjQ6WSkDrYyb9oo9n+sOZKhamJz6O630Zg+iefYZguH+mKAxkmArmVhLFn0CKP9oS
	ZfnRCEXwcI+CEZ1Z+N6d3cc2FumK3cLML
X-Gm-Gg: ASbGncsz7RpfiSQ1lkvHbI3MziVzvHhXlaeLNHorM6K+j18BnXcn1etlIyoFpDHMpMo
	o3fpFhMHYKUqzbAsPVknAcAd935aFFFN15JK2Zx2ZKdTkkdXxdM/sI8/wOvC9bgUt5/VbzZ9bGr
	+nYpS78XytbqCJF7yCM7Z9LSEzLpevToDsJqNORw==
X-Google-Smtp-Source: AGHT+IGE6KgqjdEsjT62mEbwggqBL3RncgPCKgwzcO51Yj8ahZjTYpC1AySv4RZGnFDiQT+myK+psQMP6ufSxgI9o2s=
X-Received: by 2002:a17:906:c103:b0:ace:3b02:368d with SMTP id
 a640c23a62f3a-ace3b0239c7mr438945066b.44.1745429674171; Wed, 23 Apr 2025
 10:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-13-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-13-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 10:34:20 -0700
X-Gm-Features: ATxdqUGjw3AJIGKWXF9WdA8WuDDEB4xN7eh_H9-wlnhYX3XOtYF75zgYa1lsp9Q
Message-ID: <CAEf4BzZZmF7f2n9OzhRfZAt4LkUnSSjo27P+2vfD=sc6FThgkQ@mail.gmail.com>
Subject: Re: [PATCH perf/core 12/22] selftests/bpf: Reorg the uprobe_syscall
 test function
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:46=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding __test_uprobe_syscall with non x86_64 stub to execute all the test=
s,
> so we don't need to keep adding non x86_64 stub functions for new tests.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 34 +++++++------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index c397336fe1ed..2b00f16406c8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -350,29 +350,8 @@ static void test_uretprobe_shadow_stack(void)
>
>         ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
>  }
> -#else
> -static void test_uretprobe_regs_equal(void)
> -{
> -       test__skip();
> -}
> -
> -static void test_uretprobe_regs_change(void)
> -{
> -       test__skip();
> -}
> -
> -static void test_uretprobe_syscall_call(void)
> -{
> -       test__skip();
> -}
>
> -static void test_uretprobe_shadow_stack(void)
> -{
> -       test__skip();
> -}
> -#endif
> -
> -void test_uprobe_syscall(void)
> +static void __test_uprobe_syscall(void)
>  {
>         if (test__start_subtest("uretprobe_regs_equal"))
>                 test_uretprobe_regs_equal();
> @@ -383,3 +362,14 @@ void test_uprobe_syscall(void)
>         if (test__start_subtest("uretprobe_shadow_stack"))
>                 test_uretprobe_shadow_stack();
>  }
> +#else
> +static void __test_uprobe_syscall(void)
> +{
> +       test__skip();
> +}
> +#endif
> +
> +void test_uprobe_syscall(void)
> +{
> +       __test_uprobe_syscall();
> +}
> --
> 2.49.0
>

