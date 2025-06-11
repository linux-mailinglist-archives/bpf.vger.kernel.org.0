Return-Path: <bpf+bounces-60296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4899AD48F9
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 04:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF65C7AAFD3
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 02:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACFC2253FB;
	Wed, 11 Jun 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ4ZiMzf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBB224B12
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749610528; cv=none; b=VYR8lwPU6y+2psaBJ+JsJOAT0UWTx56E3eQnHEyHdgpMCLQe5lGVTkNfhZjDELKKZ8F6RhrNIslCOGoIy9w81NRELAuokTQ90LX1hEAcnwPQMi5/wwE2OA/MgOEjGkzv4fygFmciLG46eV0hegJdGevCbgB5mx/t8D0MhUPg44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749610528; c=relaxed/simple;
	bh=ycoizBFsxYFVAQNYhSHnvP0CbgGl7sAbxHTJV7InOwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkoYGfDpUDQxij8jo9ZV39h5RbCVMESd0f+21DvW73lyW7fBA3X2I5t5AdVDu7ydgmytLW8BhboCNgidk/upq1bVROGM4EfdzzpN7EcBsTjrrMhBE/MrlrFkVboE8gOdCxJ3ofg7u71ttxv9EfLEPnbhzrNfYhFh5WWqI6W9Lek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ4ZiMzf; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso61937056d6.2
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 19:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749610525; x=1750215325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC57irUTe/rGPIq2t5H253S4n2z52yy/dJcpwI895xU=;
        b=CQ4ZiMzf8M8c5nXqSunc89dwUA9kuF2jru0o+sExvEtC/YiPIb6I58U6JommBegrf0
         bhiy2mo8WA0ZdlfweUrGKD5BzfRaxv34pPrYpn7aDvDXkOab9VD3WxJtSfzWL/iLCqCd
         Wf1cUpnYrc2HcQOIwa6j2ByEZseGcphsXYE+fTmDmuaDsW+tGy9QmggUpMtmlE1yTFzw
         D2AH5N+gTlqK4pY96+DffaDZQvYGE9D6d3qInr2VYMdKAjWz2ecI6xCfM82LwQGTyPwS
         mXqrA6gHu9EuUugHNszx7eCOFNE1bAASAtGSm/jzm8b79EBe0Pn6fZ7wxcpT7BprrRYY
         NY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749610525; x=1750215325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC57irUTe/rGPIq2t5H253S4n2z52yy/dJcpwI895xU=;
        b=Sy8Ylgfw93sXuH7IULzvztYPqI7//q+ssKB5kz1gxNv0J0JDOAcbT1B9phfN7FVev7
         veOD1bbPfbwoldIkwePMa7JhUspLMy3VbjV8slJZvSIcW6VmOopl+QDsTm0DcDbSKFlQ
         JCg3Xoz85iDO+Ns2Uen7MKlxK3INknPbhoAIh/H3Q5ya4zKNtHDkNsCAjRUY5Qthg1fe
         RHkN8Q5ikEq1GlgTfJsje0eYOwtO8eRyzQIaW80mBxCAd8S7MTH/xwfe4FZhCvcQ9iLM
         Ihqz7t1nj6Q7EeWta0Ome2Sh0TUTzPcdT6l0VPqzw3oknrfxtSG17EyHu4lfAIjHyZ/R
         iVMw==
X-Gm-Message-State: AOJu0Yytb9h+LAjjPJ1F5jZUH9UAz8cdv9hLQiVP96YPhS8ZHyBsSodl
	XfZlUhWLJPMTEOcEBgMiIv9nrpfDJ3jq7P8jZSAV2rAFR+Llgmf7VHiRuhT1dK4QNPTjfB0Y5yq
	X9TiQfPNbspSvQuVe+hwXFl4qIlw19Cg=
X-Gm-Gg: ASbGnctsSwk1JIdILQkP+nSOzOf8oBdzBa4o1N+2WEFZvVcTxGN4V0jSZv/FOp4tESt
	8xz5GHvEgWw23wbc/8kC7X94/1L1s8jwmgMEZQv6mUtxbw4YXB5Np7iJi51rzfn48XrSv2iZEkS
	D85fKY0s1LJ0I+drZX5MAGIEeV38esX4vm8chMAfLWzFNM
X-Google-Smtp-Source: AGHT+IFjb5frwASVYd/DBCr1xuo1nYPCMkJ4siyc5ZvjiVcMxpe8CQbK+5urSamPfzYGzUGQFulRcw5ksSekHxvZUUE=
X-Received: by 2002:a05:6214:224e:b0:6f8:a978:d46 with SMTP id
 6a1803df08f44-6fb2c334737mr32016186d6.19.1749610525223; Tue, 10 Jun 2025
 19:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215221.846484-1-eddyz87@gmail.com>
In-Reply-To: <20250610215221.846484-1-eddyz87@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 11 Jun 2025 10:54:48 +0800
X-Gm-Features: AX0GCFvT71p4WkUXkuunflAZtzChpOlbhQ6kOZLPZU4k4rC8p8aNwvXteq2qZgQ
Message-ID: <CALOAHbDPkbhun3KFXpwTuSKGzOx4PcUBhqDriofMgzwCXxR8_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: more precise cpu_mitigations
 state detection
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:52=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
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

The /proc/config.gz file is not enabled in certain kernel releases.
Should we also check "/boot/config-$(uname -r)" as an alternative?

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


--=20
Regards
Yafang

