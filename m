Return-Path: <bpf+bounces-46911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BA59F183F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B939A188C9D1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A035D1A8F9C;
	Fri, 13 Dec 2024 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsDKYMDu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9261196C7B;
	Fri, 13 Dec 2024 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734127134; cv=none; b=bOU24ICciWTuhbnt5G9ozk4/RjvdLrWwW8LFjUyyCDcg4Hfkocnw+oE78KieXfWrN1jx9Gf5AdcJXiXV9X2Xo99ljeI36qUGVTNAJ3pZK1uJfcXMP1FMu0K+qUvQnxGZGwg1AZedFmeNyQQhYFGoRCNBIOxudt/wkUd5xT+dKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734127134; c=relaxed/simple;
	bh=E56Ezby+zEQ39D7dSlElnsUmlKtP2ColERFfXQhdY6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ec2xPr/pWV6HRglPm1SCVz5Ehd/jOEKlOdIjh8lfBMysOCTQiPQoCoKzBAdDLapxS3g46Q+pyKrr2mdX8BlFP1rFxmXNfa2xch2Rlnpz+jbzf6X37BnfPqKBFtWBH/IHJfm16GrzlT6elcN4CBBlviTVCDSwjl2vBTIc1kkpsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsDKYMDu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so1930023a91.3;
        Fri, 13 Dec 2024 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734127132; x=1734731932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRuW5If3GOyjAvQmO16jlrosej2iJDMJI5NoP8Vab+s=;
        b=WsDKYMDuXJyYXuCCha1buZp/CSdFebEm57zPUZ0p6hDobGdxvyT+rpOcqM+vmM/egX
         HFEzWovRbQIDDFijvBG3bxGbvWkELOm5Lghp11tkNQ5p6X4PWEliT5kt427x0lowqS8v
         JPjPPRwgl7+r2E+2uU9N0FCe4YpnMoicpUtOJhPPUiikQnw3vCi2FZ6F2AP62oKmQuPB
         1Q/3HHvA7yVIyNxYzMet85aDW+uOVYiGmd6EzqhuxyPrRTcS8ZlEChZdLxR4kWT+TNQY
         sTJsz+peGgPaEsAtH3rDd/ZM/KK+O8BnhPpecB2PL4wp/LdQ7nR+9k1x8yxc7q8x0Ybn
         4fAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734127132; x=1734731932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRuW5If3GOyjAvQmO16jlrosej2iJDMJI5NoP8Vab+s=;
        b=wt5r9ebHorUMotgNwVWMszhML08VSRAD/3wd40n+LeNCznzSC6g0Ot5DvNEAYbI4Vj
         X7fRjkJ6mbApt46W7VcgpCqUhqQX3GsTJNwkwT1TMQO5SmLAwU9bUFqMTK9ce/mFCOmF
         jod6CMwPI0btrYD26VJ5zgNv3OpgKEo4ZV+2xJoG4muzLsLn2N95dLqejxH5GnblqE/Z
         LkzMOWNB6LTkooBN2ZNUpffSLK7Tx0qzIMc+91QFGlk/ejDFT5ujRRgbcg4uEomXDPmv
         LuhwIbp/R2xPZ6cNszhAT3UqkC/UdchQJfRW++zsvafCoVFpXmNnauh6npdpOHgZ3WCq
         YlNg==
X-Forwarded-Encrypted: i=1; AJvYcCUDKuYAl3C6NjIT0tc6eXNBa6EtLj2sUcoi0R+1MQ1UYkVLUX9jgpr/wdU9/McyEoWuxW7W0neQxSxso1iJH/GVMlNJ@vger.kernel.org, AJvYcCUGLJp2jPnemkjq5seWjYlUjnR6ZTAxKDn9k3e0vGMj+eAnU4bxzCw7whHD3p5zYC2ViH0=@vger.kernel.org, AJvYcCWvsqmEPJSRtpHz7EnIQN6rvP9c+NY2pHGL3sV/K43cQ+/xQx1IANyrqcQ74vE5fHfH3Dpwt280EzPm0x49@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8effq8ekCPWXazCPIMbE/gD6bkC43wfcpd1B39kVMRviauH4
	lR3xEOydcSRcNHFAapR2spBnGZiIeLT7B7tMGzovYHIygjJ50rKRKklVSlbeXY6zu64jjHduRfQ
	/XKCyDA9HRV/sfQFO60tcp+sxm6M=
X-Gm-Gg: ASbGncu2bDf36urfrGE17FQ23+HM02PIj0Y9QmfiXhY+Df/QVtMMAZSpETjDBVr2CkV
	TaYm5unHbPHrmHMvJYawVFen+w8TRC0oJya/Ww/ihnILRM30BN+0o7g==
X-Google-Smtp-Source: AGHT+IGRrSm4m2kqgYGUrMI3nXyAJZ9dvwPg+FslkQ4ufTgJPdCZapmlkjywJFfBBjMERC2y0QLYsn95uG/3s2FI7zo=
X-Received: by 2002:a17:90b:280a:b0:2ee:b4d4:69 with SMTP id
 98e67ed59e1d1-2f2903a450cmr6720090a91.35.1734127132021; Fri, 13 Dec 2024
 13:58:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-11-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-11-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 13:58:38 -0800
Message-ID: <CAEf4BzY=MOmqsuuL3iOyeaVGd63-6wdo9uU+6QhjbUOvgp=iVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/13] selftests/bpf: Add uprobe/usdt optimized test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding tests for optimized uprobe/usdt probes.
>
> Checking that we get expected trampoline and attached bpf programs
> get executed properly.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 203 ++++++++++++++++++
>  .../selftests/bpf/progs/uprobe_optimized.c    |  29 +++
>  2 files changed, 232 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_optimized.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index c397336fe1ed..1dbc26a1130c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -14,6 +14,8 @@
>  #include <asm/prctl.h>
>  #include "uprobe_syscall.skel.h"
>  #include "uprobe_syscall_executed.skel.h"
> +#include "uprobe_optimized.skel.h"
> +#include "sdt.h"
>
>  __naked unsigned long uretprobe_regs_trigger(void)
>  {
> @@ -350,6 +352,186 @@ static void test_uretprobe_shadow_stack(void)
>
>         ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
>  }
> +
> +#define TRAMP "[uprobes-trampoline]"
> +
> +static unsigned char nop5[5] =3D { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
> +
> +noinline void uprobe_test(void)
> +{
> +       asm volatile ("                                 \n"
> +               ".global uprobe_test_nop5               \n"
> +               ".type uprobe_test_nop5, STT_FUNC       \n"
> +               "uprobe_test_nop5:                      \n"
> +               ".byte 0x0f, 0x1f, 0x44, 0x00, 0x00     \n"
> +       );
> +}
> +
> +extern u8 uprobe_test_nop5[];
> +
> +noinline void usdt_test(void)
> +{
> +       STAP_PROBE(optimized_uprobe, usdt);
> +}
> +
> +static void *find_nop5(void *fn)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < 10; i++) {
> +               if (!memcmp(nop5, fn + i, 5))
> +                       return fn + i;
> +       }
> +       return NULL;
> +}
> +
> +static int find_uprobes_trampoline(void **start, void **end)
> +{
> +       char line[128];
> +       int ret =3D -1;
> +       FILE *maps;
> +
> +       maps =3D fopen("/proc/self/maps", "r");
> +       if (!maps) {
> +               fprintf(stderr, "cannot open maps\n");
> +               return -1;
> +       }
> +
> +       while (fgets(line, sizeof(line), maps)) {
> +               int m =3D -1;
> +
> +               /* We care only about private r-x mappings. */
> +               if (sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n", start, =
end, &m) !=3D 2)
> +                       continue;
> +               if (m < 0)
> +                       continue;
> +               if (!strncmp(&line[m], TRAMP, sizeof(TRAMP)-1)) {
> +                       ret =3D 0;
> +                       break;
> +               }
> +       }

you could have used PROCMAP_QUERY ;)

> +
> +       fclose(maps);
> +       return ret;
> +}
> +

[...]

