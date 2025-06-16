Return-Path: <bpf+bounces-60770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8497FADBBC5
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 23:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EB6188EEEC
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BBA1D9346;
	Mon, 16 Jun 2025 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXNWwPfx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB4215F7C
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108433; cv=none; b=g79LM48x7PheRYZeRev6da7ErdFJB3Sb4LlFKD/VmbnnVXebmaYNp8+Wa/ypC7levPpRvJejMCMXcd2Qdramjqwgsg1QpLZdmOO8tPHVJ5RPOEzYXb/TnRQU8hRpS/ffxZ9H7WsSc2CUdKw1+goa4qYGVSAigMlV3nd6oHbHtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108433; c=relaxed/simple;
	bh=j02Dy2rqDlKzp5eicEXSvLdCADh4LUgfrZqMW3pAqvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3wYUP6KOue/ohP66BBYvoHc/2mBAT8BHp3yQ2qJZqL+691FpvD59Wl+UgxcV9XG7RZtkeOamHj5TDzGPWtLE5YfMMqJ9kpGc5Q3soBisrqk6r4uxTEFRvOGplvbvgP84jWtYoKYsbfkq7BAuHFtQ+DBTF0Z9Tz1aeJQMzT0iQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXNWwPfx; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-879d2e419b9so4879585a12.2
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750108431; x=1750713231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMyOudDNawoUS6y/kirvFjFOnCv7+8/voSmZoQgxZfU=;
        b=EXNWwPfxkSUICKD55b74mBYISX9atzgmjsFSdyCVcPHX1+pdrG8/CRxsZ3XXUW78s4
         6eeYMEz/R8WAeP/dopfchjzw+O9P3dJ4drQVg1JGC/OW6o7LpLXD4Rh2/5GsO55cyU+5
         dzTDUiaO/SPQKdnCWBhinfbMdK81hLYkRU2tapPPU+cef/aOe6jq+1EvPDlBAzCpW368
         7x+sCtZl9WrGBm/3IgcWEbMz6nAfnmSe0teAbmVNlzwpgXHW+VyfQRIgo+K00+10kXfd
         Xc4qtTXhFACWkL8EMJeovLoCHRZd+IY7WAK7/q7pQhMibktw/HDFfay5+EOM8Y/5fBgb
         lz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750108431; x=1750713231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMyOudDNawoUS6y/kirvFjFOnCv7+8/voSmZoQgxZfU=;
        b=Z5NX/E07M2omRK97K1S30KwS47v+Fs57b0FlrHerH3+ONioUPdoAQ2SUtN/JtQ3V88
         1q3EMWPtmmb6nyfesLmKc4McG0Uc0JSM3DVACjs+dE5HN47mWytDpwR9BtClamrENMg4
         oE3Rmii3h+1lm03k0azUB5xApdCnqX6JTKlSFS+xSYURFP4zLH58SBvm7eiFrSZe5yR2
         stOkRUC0hoiUTjjshphISxxlwMBwODJSFu3jlLlNJilt3rXN8bysOPOPCVb6uRVc76bi
         UK3g11fSawDJdXTuVQsN9dGJlXkSRnZUbEKlTzWyeQp7FYjBZchglWd0HLXyy0IngdKm
         Q4xg==
X-Gm-Message-State: AOJu0Yy6BdJLVsB8jcG1fCcbm6e3vR2exBGJ8AJXMXoVUpxKl27CjVS6
	KB8XWIlXNjH+o8TsjL4zg0D8nNkLKa/+5tqB4BzKypUhkqmzI8IC0xs/lBJC9Rui/64xDzJahDg
	XEFvzim/28t4P2kjo04MbKaB5v3m9NNhH3UBRWcg=
X-Gm-Gg: ASbGnct75F11l3yjWRh03Tpk/U/u8YajK8/rTtMF5Ri/Bl4jF9VucZIPF8W+JAvavvd
	KmGvVm4yzXIlPmCgcMv2JX1Wf3MgWFdeuZbP4qO66S1EYfhXmWbRi4omZRmxTL4NDSogDjbkH3q
	liL9FDrXvsDAxoZjXH5k2fQiYBMfws4yWHYZGUC2NFv1Sa2m5VLIX7hVvOMqU=
X-Google-Smtp-Source: AGHT+IGbN/fYnEgxsi8N9xw1VC5ioLNXAHjfmOzQ5ZjFXL9cqhjfzxeShNu8h95h4OYdYWLPCNzz1stJLKz7mrw4C64=
X-Received: by 2002:a17:90b:1e07:b0:311:f99e:7f4e with SMTP id
 98e67ed59e1d1-313f1cae835mr19180848a91.16.1750108430746; Mon, 16 Jun 2025
 14:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614050617.4161083-1-eddyz87@gmail.com> <20250614050617.4161083-2-eddyz87@gmail.com>
In-Reply-To: <20250614050617.4161083-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Jun 2025 14:13:37 -0700
X-Gm-Features: AX0GCFsnhmap9bY88zyDW7gfnu9S9BzCn8Y3z3bqnz7gT8QFMCL4mZPOf9SSyN4
Message-ID: <CAEf4BzYh38ZW5x_tttT7qGSPbUtT4SLC7F+aoE_cymkV5q59hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] selftests/bpf: more precise
 cpu_mitigations state detection
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, laoar.shao@gmail.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 10:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
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
> e.g. when CONFIG_CPU_MITIGATIONS is disabled and boot parameter is
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
> - via CONFIG_CPU_MITIGATIONS option.
>
> This commit updates unpriv_helpers.c:get_mitigations_off() to scan
> /boot/config-$(uname -r) and /proc/config.gz for
> CONFIG_CPU_MITIGATIONS value in addition to boot command line check.
>
> Tested using the following configurations:
> - mitigations enabled (unpriv tests are enabled)
> - mitigations disabled via boot cmdline (unpriv tests skipped)
> - mitigations disabled via CONFIG_CPU_MITIGATIONS
>   (unpriv tests skipped)
>
> [1] https://lore.kernel.org/bpf/20231025031144.5508-1-laoar.shao@gmail.co=
m/
>
> Reported-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/unpriv_helpers.c | 94 +++++++++++++++++++-
>  1 file changed, 91 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing=
/selftests/bpf/unpriv_helpers.c
> index 220f6a963813..625556a0e7f1 100644
> --- a/tools/testing/selftests/bpf/unpriv_helpers.c
> +++ b/tools/testing/selftests/bpf/unpriv_helpers.c
> @@ -1,15 +1,76 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>
> +#include <errno.h>
>  #include <stdbool.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
> +#include <sys/utsname.h>
>  #include <unistd.h>
>  #include <fcntl.h>
> +#include <zlib.h>
>
>  #include "unpriv_helpers.h"
>
> -static bool get_mitigations_off(void)
> +static gzFile open_config(void)
> +{
> +       struct utsname uts;
> +       char buf[PATH_MAX];
> +       gzFile config;
> +
> +       if (uname(&uts)) {
> +               perror("uname");
> +               goto config_gz;
> +       }
> +
> +       snprintf(buf, sizeof(buf), "/boot/config-%s", uts.release);
> +       config =3D gzopen(buf, "rb");
> +       if (config)
> +               return config;
> +       fprintf(stderr, "gzopen %s: %s\n", buf, strerror(errno));
> +
> +config_gz:
> +       config =3D gzopen("/proc/config.gz", "rb");
> +       if (!config)
> +               perror("gzopen /proc/config.gz");
> +       return config;
> +}
> +
> +static int config_contains(const char *pat)

int-returning function... but we return do `ret =3D true;`, that looks
accidental and sloppy. Let's add a comment that it returns <0 on
error, 0 for no match, 1 for match and stick to numbers everywhere?

> +{
> +       int n, err, ret =3D -1;
> +       const char *msg;
> +       char buf[1024];
> +       gzFile config;
> +
> +       config =3D open_config();
> +       if (!config)
> +               goto out;

nothing to gzclose if open_config() returns NULL, just return

pw-bot: cr

> +
> +       for (;;) {
> +               if (!gzgets(config, buf, sizeof(buf))) {
> +                       msg =3D gzerror(config, &err);
> +                       if (err =3D=3D Z_ERRNO)
> +                               perror("gzgets /proc/config.gz");
> +                       else if (err !=3D Z_OK)
> +                               fprintf(stderr, "gzgets /proc/config.gz: =
%s", msg);
> +                       goto out;

nit: I'd probably just do

gzclose(config);
return -EINVAL; (or whatever the error code might be)

> +               }
> +               n =3D strlen(buf);
> +               if (buf[n - 1] =3D=3D '\n')
> +                       buf[n - 1] =3D 0;
> +               if (strcmp(buf, pat) =3D=3D 0) {
> +                       ret =3D true;
> +                       goto out;

same here, gzclose() + return;

it will be easier to follow in this rather straightforward function

> +               }
> +       }
> +       ret =3D false;
> +out:
> +       gzclose(config);
> +       return ret;
> +}
> +
> +static bool cmdline_contains(const char *pat)
>  {
>         char cmdline[4096], *c;
>         int fd, ret =3D false;
> @@ -27,7 +88,7 @@ static bool get_mitigations_off(void)
>
>         cmdline[sizeof(cmdline) - 1] =3D '\0';
>         for (c =3D strtok(cmdline, " \n"); c; c =3D strtok(NULL, " \n")) =
{
> -               if (strncmp(c, "mitigations=3Doff", strlen(c)))
> +               if (strncmp(c, pat, strlen(c)))
>                         continue;
>                 ret =3D true;
>                 break;
> @@ -37,8 +98,21 @@ static bool get_mitigations_off(void)
>         return ret;
>  }
>
> +static int get_mitigations_off(void)
> +{
> +       int enabled_in_config;
> +
> +       if (cmdline_contains("mitigations=3Doff"))
> +               return true;
> +       enabled_in_config =3D config_contains("CONFIG_CPU_MITIGATIONS=3Dy=
");
> +       if (enabled_in_config < 0)
> +               return -1;
> +       return !enabled_in_config;

same mix of bool and integers

> +}
> +
>  bool get_unpriv_disabled(void)
>  {
> +       int mitigations_off;
>         bool disabled;
>         char buf[2];
>         FILE *fd;
> @@ -52,5 +126,19 @@ bool get_unpriv_disabled(void)
>                 disabled =3D true;
>         }
>
> -       return disabled ? true : get_mitigations_off();
> +       if (disabled)
> +               return true;
> +
> +       /*
> +        * Some unpriv tests rely on spectre mitigations being on.
> +        * If mitigations are off or status can't be determined
> +        * assume that unpriv tests are disabled.
> +        */
> +       mitigations_off =3D get_mitigations_off();
> +       if (mitigations_off < 0) {
> +               fprintf(stderr,
> +                       "Can't determine if mitigations are enabled, disa=
bling unpriv tests.");
> +               return true;
> +       }
> +       return mitigations_off;
>  }
> --
> 2.47.1
>

