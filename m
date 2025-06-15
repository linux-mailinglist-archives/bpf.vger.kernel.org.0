Return-Path: <bpf+bounces-60670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74278ADA09C
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 04:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9F71731F4
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 02:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D83596A;
	Sun, 15 Jun 2025 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIetyNsj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3951C27
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749953920; cv=none; b=ApWAIstC/pTPkw8C38kRs8uScs47FnBhwFOf/b3yRadIDNYjn3TsL/G2RR+PjtY/QTC1UfH4Yw4ONsUd/EarnNosa1fDFlaBuEZXHzP6yzuM/MhBbQyC5pbnLkPZ+ZiM9k1lvabXdwWYegXjEX0TFPcOnWbak7q1sP1Dawsdtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749953920; c=relaxed/simple;
	bh=UWXZ0RBYcrS5N2yhANMOjeqGX83mXg1QArCo9aA15Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saV+uIzVbVMrqVwVKEJZXTldNRwGU6tqHRRb9f8N98Tc1Y/spXcnIsUhvppNlzbo/v2idcU2e91OHs2nSsf3dHE6F9zDPmEfiWJPpC+X1s/RfccOypfLGqesFTGgQHKsIOB3XXcW1Q9JaxpzfQSIm00VqMfVz6VCeVAwqaCdfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIetyNsj; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso30436106d6.3
        for <bpf@vger.kernel.org>; Sat, 14 Jun 2025 19:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749953917; x=1750558717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmoxOJFF15Lpw7/dBP7O2Tws9Sa12c7E69uYTb0BFWQ=;
        b=EIetyNsjahdLAt+XeUskM1gKUz1F4Zcq0/XqkSPqwDnRm1ufK8mZFmbFtUsZ6JPzFi
         FokQXA5asyqD1QYk7prZD5x0xaCs+DqI8m0shwMTnmPxZB425Pm5IXXhunkc6dLOajsI
         HIooMxhVW5TDrcJ+FA24WwbYirD3NhjpM7/G3qw+KznP1YQEDrdh+ED4yeHtWFlChBrP
         M8tsAm4r1+vn9WTaHZl7zPMY+ZFpxM1NiaBKec0po/UGirLLyht9wHCHvq2rhwcMxyWZ
         SiWyqJBKP2NRnhEdMFt4OamAhDCNkhsC/+fEuTu5OYgna99atBmBWWmXktqtpDP2riSH
         GHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749953917; x=1750558717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmoxOJFF15Lpw7/dBP7O2Tws9Sa12c7E69uYTb0BFWQ=;
        b=VGejmVrJnKNlcZS8GI3G4dkGqz/A2sOcUn9Bqk6OBbhOSkdCFynWEp4lYgaGVSfVME
         AxpWQQAwIWv/8X4sPnJ1gSByuR6fh4uF+oYRKKJgVCawUE5VnpR84EIqm6SrHLIUMqWr
         p//CPUxup+fTBT1W8279d/Xuy3FnqIZfrDHUavYMpHRJ4YXE3IyBgFqxJs5m8om9KfYI
         D2zRAnhHWL2kc7WkAwInK8JHc8i2uinENzb/SSCdN4ioMKlqK3zGXU6wkNidbgt/k2Q/
         A8e/7mlqJYftx4wl3bXtB83N0rsKIQ+CSRIYn3hoMmeIkrcmf54hOfSepuYo4hxkoxdo
         5xgg==
X-Gm-Message-State: AOJu0YxL56NbRZ44L6KWxi9vZmhA3hI98H4oyNUPbRiuvbNVU03A2kek
	mre/cI3F6+662YuekRCz2w1UAqKFpTk/+ZnFkGcii0ONiiyztmSXTFHGXwSESH6vIM+HveV7a3e
	abWPI1y3CGWsyGdONBPrdyWzMdkQI9i8=
X-Gm-Gg: ASbGncvq8ZThEOb3BCTrg3YOfONC6usYwxYU6R/1dIEVYyIJ0J8HZ4tqvAcNnj62rRN
	Ea4cwpai07ZhIjK6EnXYDzNmK9UxHvn0uhxtmghmDJGhpPKCmlaIcXnafCDBu/pYOTppPBqGJM1
	ctECm+cgrU5JnO9FKE0z+TmTPSB+nfVrWQObqzz/WMrizB
X-Google-Smtp-Source: AGHT+IFWG6f+C/wZ1FM7ucpLmE3CdfBOHDSNB8kG9sxhfuQekhNcoKGz2xgBY32A8FGR64SgsxDDdqkRqqV0le/1W/s=
X-Received: by 2002:a05:6214:5014:b0:6e8:fe16:4d44 with SMTP id
 6a1803df08f44-6fb4777ab3cmr75996916d6.31.1749953917635; Sat, 14 Jun 2025
 19:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614050617.4161083-1-eddyz87@gmail.com> <20250614050617.4161083-2-eddyz87@gmail.com>
In-Reply-To: <20250614050617.4161083-2-eddyz87@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 15 Jun 2025 10:18:01 +0800
X-Gm-Features: AX0GCFuAi5r6VGNp9iPVby17BeKubcb6Yek_QblwSvtfkX-r75qpyUaEEpDn6QE
Message-ID: <CALOAHbBpa_iAU-hCxUXwd0g8WdjSF4zFx44pByqJqZ++y0cWXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] selftests/bpf: more precise
 cpu_mitigations state detection
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 1:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
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

Acked-by: Yafang Shao <laoar.shao@gmail.com>

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
> +{
> +       int n, err, ret =3D -1;
> +       const char *msg;
> +       char buf[1024];
> +       gzFile config;
> +
> +       config =3D open_config();
> +       if (!config)
> +               goto out;
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
> +               }
> +               n =3D strlen(buf);
> +               if (buf[n - 1] =3D=3D '\n')
> +                       buf[n - 1] =3D 0;
> +               if (strcmp(buf, pat) =3D=3D 0) {
> +                       ret =3D true;
> +                       goto out;
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


--=20
Regards
Yafang

