Return-Path: <bpf+bounces-60527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263CBAD7D4A
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34697B017F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D775122E3E0;
	Thu, 12 Jun 2025 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7SmVzhz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD31531E3
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763162; cv=none; b=ORyHs9v5nImcw0azDhbQCK2ITNTtKoS5yXJZKnpPmqHj3P+FBflnrkHHbW8foyKF8aKhItwPXMszohzIC2u3Rv6sk9AksycwidMX4YsZIhZIhrZh4JVdcgqNITSzfDuluAzzKa+Z8KBDWrZuO3CnKTtmKp/3YwlAl+j27keHFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763162; c=relaxed/simple;
	bh=C0eusfq1z3sLOEaLkhnDkj6ciOmyhXPzWSaGDY54bVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PA2pI9XGShq+P00hnq0pAfZMrlpPHKPexsZtxvkyQUqhwGTd3P/LADx/lT39fRSeBoHwGgBngJh8Edfu4tw7umEbiY6ZrodUMY4jcm0KqwGl++DbhBR5SWz+sGRxgSSmXCA72nC4A9xvkl77SLBy37i4BA2Jm5Qfkt1i3bcA+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7SmVzhz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23526264386so14167245ad.2
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749763160; x=1750367960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bA2uDMdXSlVpnFLPb2EBqdwA+ErlgqezQexDsPVtuEg=;
        b=e7SmVzhz4YjCXuO7Bm5Fpl+7F7KIFyXaiz4TZHvxameEw4A5TKXmMpYp9XxLSa5jnI
         SbiW0e5TQA9jfGTUb109t++M/BG6Z8v1o6Ix9gNXCZVB6shKKLb8t2q3Suh2beyXZ7Vt
         /QbJBcs24wkn4njrIamUZrgb9c5I2ZQy8UaZ8Dpzw85rU5iJqMPnXyLEul6dvObpxfKZ
         3iw80Yh09Za6Z+W34C0GymEn8hMtj1JwwADyoE/rCiHQdRaFuVAFyBOKoBB62lf3l2Lt
         UaR7N0B4nfmXSXyGrw70zCPx+sHJ52Gw46483wsq92nCdw01NoCPiz72elLILlGKxV4/
         jwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749763160; x=1750367960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bA2uDMdXSlVpnFLPb2EBqdwA+ErlgqezQexDsPVtuEg=;
        b=bFYcJ37mBkmv6epW8TkaGo/0BTBnnC0pgHHT/6nankardVCSUwf0wrCGeDNw9bj/7W
         HR2QCy1wR45c/Ra/RWMuX84brhl7paVJZ0s1GHiAAJjPbIEW+aWq0tY+ioO845ozGHZC
         DujQGEM0GanSHvmafR6l29VuNh91adABRvWAcuqxTxPTYfua6jrbvsy+JdcalPwF0j4n
         cedpmkdGLIndCql90g8zKcu4eO3kpd+f84MBbP4+SW03NruqUi3eO9JItSSOx1xdtvbP
         xWVXazk5QIwSFiVHn2JmHSemUMGctNMRmQsg58jZYbGGu+1BF0DItmSshAU6d/czqmvd
         YW6Q==
X-Gm-Message-State: AOJu0YxvmI1UJzPIJJEfCq7CD4peFMs/AKvYT6Bb+0Dqeyp+4UN0/aFU
	jMceggvmAsreQCvrP6aU9IbbxXqaG6o26srjasT7ddVv2H7Hw3jK9YgKf2C9K27Y5PgYAVlZvv6
	1RgVXZ4ECxwXI8qxs0gCBxtKM2G1ew0U=
X-Gm-Gg: ASbGncsvDoK3pMg+F88Uo4WCKtUBwMJ7B4IxtvXh2hg9nW+BliiUmJtSqp7XlznpM1b
	SaU/s2gtH/Qa0zDhrKm9VbExhtI0Q8Rgq3p9rz96vhMqyQtWJm4DYT0YabtipAp/CFbtWQydTEr
	fI2jHRw5KjiuqDMUVDdOnX2vO7S2/1Ignul59HQIyR8vc1/gemHIr3oznj8MM=
X-Google-Smtp-Source: AGHT+IEOdSipPFCRcv4aNliYJ8iS5SQ6dTx2EZXAK4WK1xKQsh1zF8aMa7J3D5ifH0Ub9+8cb3V9LEfOTN8RS9et2M8=
X-Received: by 2002:a17:902:e849:b0:234:b422:7120 with SMTP id
 d9443c01a7336-2365d89174emr8486315ad.9.1749763160149; Thu, 12 Jun 2025
 14:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215221.846484-1-eddyz87@gmail.com>
In-Reply-To: <20250610215221.846484-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 14:19:08 -0700
X-Gm-Features: AX0GCFskzR2XrPMLPxoR6Hm0CP33FvlISFvQvihGoCYVm2dMyrRgqBCB2AOIgRo
Message-ID: <CAEf4BzazEkfH9XQqR+WhXoyERLndtBpb4mbWSNtCECQ-eQs1hQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: more precise cpu_mitigations
 state detection
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, mykyta.yatsenko5@gmail.com, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> test_progs and test_verifier binaries execute unpriv tests under the
> following conditions:
> - unpriv BPF is enabled;
> - CPU mitigations are enabled (see [1] for details).
>
> The detection of the "mitigations enabled" state is performed by
> unpriv_helpers.c:get_mitigations_off() via inspecting kernel boot
> command line, looking for a parameter "mitigations=3Doff".
>
> Such detection scheme won't work for certain configurations,
> e.g. when CONFIG_CPU_MIGITGATIONS is disabled and boot parameter is

here and everywhere else (copy/paste FTW), typo: MITIGATIONS

> not supplied.
>
> Miss-detection leads to test_progs executing tests meant to be run
> only with mitigations enabled, e.g.
> verifier_and.c:known_subreg_with_unknown_reg(), and reporting false
> failures.
>
> Internally, verifier sets bpf_verifier_env->bypass_spec_{v1,v4}
> basing on the value returned by kernel/cpu.c:cpu_mitigations_off().
> This function is backed by a variable kernel/cpu.c:cpu_mitigations.
>
> This state is not fully introspect-able via sysfs. The closest proxy
> is /sys/devices/system/cpu/vulnerabilities/spectre_v1, but it reports
> "vulnerable" state only if mitigations are disabled *and* current cpu
> is vulnerable, while verifier does not check cpu state.
>
> There are only two ways the kernel/cpu.c:cpu_mitigations can be set:
> - via boot parameter;
> - via CONFIG_CPU_MIGITGATIONS option.
>
> This commit updates unpriv_helpers.c:get_mitigations_off() to scan
> /proc/config.gz for CONFIG_CPU_MIGITGATIONS value in addition to boot
> command line check.
>
> Tested using the following configurations:
> - mitigations enabled (unpriv tests are enabled)
> - mitigations disabled via boot cmdline (unpriv tests skipped)
> - mitigations disabled via CONFIG_CPU_MIGITGATIONS
>   (unpriv tests skipped)
>
> [1] https://lore.kernel.org/bpf/20231025031144.5508-1-laoar.shao@gmail.co=
m/
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/unpriv_helpers.c | 45 +++++++++++++++++++-
>  1 file changed, 43 insertions(+), 2 deletions(-)
>

As Yanfang mentioned, seems like libbpf does

snprintf(buf, PATH_MAX, "/boot/config-%s", uts.release);

before going for /proc/config.gz. Let's add that to be a bit more
consistent (and it will be a touch faster to not have to unzip the
config, right?)

pw-bot: cr

> diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing=
/selftests/bpf/unpriv_helpers.c
> index 220f6a963813..1dec3c6b3d70 100644
> --- a/tools/testing/selftests/bpf/unpriv_helpers.c
> +++ b/tools/testing/selftests/bpf/unpriv_helpers.c
> @@ -6,10 +6,46 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <fcntl.h>
> +#include <zlib.h>
>
>  #include "unpriv_helpers.h"
>
> -static bool get_mitigations_off(void)
> +static bool scan_config(const char *pat)
> +{
> +       bool ret =3D false;
> +       const char *msg;
> +       char buf[1024];
> +       gzFile config;
> +       int n, err;
> +
> +       config =3D gzopen("/proc/config.gz", "rb");
> +       if (!config) {
> +               perror("gzopen /proc/config.gz");
> +               goto out;
> +       }
> +       for (;;) {
> +               if (!gzgets(config, buf, sizeof(buf))) {
> +                       msg =3D gzerror(config, &err);
> +                       if (err =3D=3D Z_ERRNO)
> +                               perror("gzgets /proc/config.gz");
> +                       else if (err !=3D Z_OK)
> +                               fprintf(stderr, "gzgets /proc/config.gz: =
%s", msg);
> +                       goto out;
> +               }
> +               n =3D strlen(buf);
> +               if (buf[n - 1] =3D=3D '\n')
> +                       buf[n - 1] =3D 0;
> +               if (strcmp(buf, pat) =3D=3D 0) {
> +                       ret =3D true;
> +                       goto out;
> +               }
> +       }
> +out:
> +       gzclose(config);
> +       return ret;
> +}
> +
> +static bool scan_cmdline(const char *pat)

nit: I find "scan_xxx" quite unreadable when used in the expression
(did you scan? yes! did you find anything?... who knows... it's
similar with "filter_" or "check_" prefixes, but I digress). Can we
use "cmdline_contains" and "config_contains" or something along those
lines, so that the condition above reads more naturally?

>  {
>         char cmdline[4096], *c;
>         int fd, ret =3D false;
> @@ -27,7 +63,7 @@ static bool get_mitigations_off(void)
>
>         cmdline[sizeof(cmdline) - 1] =3D '\0';
>         for (c =3D strtok(cmdline, " \n"); c; c =3D strtok(NULL, " \n")) =
{
> -               if (strncmp(c, "mitigations=3Doff", strlen(c)))
> +               if (strncmp(c, pat, strlen(c)))
>                         continue;
>                 ret =3D true;
>                 break;
> @@ -37,6 +73,11 @@ static bool get_mitigations_off(void)
>         return ret;
>  }
>
> +static bool get_mitigations_off(void)
> +{
> +       return scan_cmdline("mitigations=3Doff") || !scan_config("CONFIG_=
CPU_MITIGATIONS=3Dy");
> +}
> +
>  bool get_unpriv_disabled(void)
>  {
>         bool disabled;
> --
> 2.47.1
>

