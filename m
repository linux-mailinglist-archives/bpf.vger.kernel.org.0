Return-Path: <bpf+bounces-12940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FCF7D2277
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9971C2093D
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE6612F;
	Sun, 22 Oct 2023 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8i2yiUx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13010FC
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 10:06:23 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655ADE6
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 03:06:22 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1ea05b3f228so1693721fac.1
        for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697969181; x=1698573981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApB3fBukxcRRutiXZMFOGvDxthestNJNWe1cIRYdLFY=;
        b=Z8i2yiUxrYtgY5If7KBhhlqykFp+KkOYWcMnPdwbZPKjJ81h0YQr2tmAfB+GIblcmI
         GtZx7avGtC+DwuH8vnOnCNCpq1l0oYDKO38O+/Kv6Ztx9sIdt3xpVYrqvZ4GgN7eR7C4
         yqozD7AzoPM9h6rzWdRSjerux8pL3tFpLayS1WXTOJpcwZ6Rufmw8//vvCC4j0Rvdorl
         k2MrdQdkWerEZQpjc7Wh42Q9Qmsyd3Mini2x8ZlKtLCCU2xJdZ4au9NdfNTBpHsihqH7
         pYJmoQB6Xquv+9qdo4aj1FzeaoTuLtc97y4OkmCc7VKHY2g82o30ii/bKVxFUexQBfjL
         N+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697969181; x=1698573981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApB3fBukxcRRutiXZMFOGvDxthestNJNWe1cIRYdLFY=;
        b=FkW/+8afKY0caEaxQKzhi9aOe/3/F53npxjQdEQYa19GkLNUvLlvczcJu+dYQs1Nsb
         R2tdMCSAaJeJZGFyfpa0ut6yNbDrJAsvvU8Xxq9y0/mq9CvQEVi+muIKxy4i2EkS3AoJ
         AP9ZJ9YUZQ9EVn1atZIJG9i4jgK94o4PnNUXYyZLrfjf2tZOjHCn2WqeQ5L7tscteKOI
         xdb+jDZ+ANWM+0RsNYeMrRIk84H2aI5vV0hDpuMhlRJLhz7Np1vFqJJVPHtbPsA8LNqa
         F9J/ONmQ0gHVKws9rwKHYk3B3apfEorsjJf+Z2F/p4RXsYBAZIFxUS46iQ6gdUPmRqTp
         hzyg==
X-Gm-Message-State: AOJu0YwJxwfqGDGUFc5HIws3hvRCyYB3x8IDruyib4vBPek+m4fQuoTJ
	PkVxtjFLbu9OLl3Clnx8HqMSEoxCE4Vhy3olEoY=
X-Google-Smtp-Source: AGHT+IHPZ3TF2IeoSuedDLiQCxVT+poOMq6WZZlIbhHkmXnevdcroW4MuJuwjq+oH3ahHnaiQqweNsvF3eiZPo3xUlE=
X-Received: by 2002:a05:6871:78a:b0:1e9:d25d:3cb0 with SMTP id
 o10-20020a056871078a00b001e9d25d3cb0mr8302032oap.21.1697969181306; Sun, 22
 Oct 2023 03:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022092606.2245-1-laoar.shao@gmail.com> <20231022094906.3003-1-laoar.shao@gmail.com>
In-Reply-To: <20231022094906.3003-1-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 22 Oct 2023 18:05:45 +0800
Message-ID: <CALOAHbA=_HV6ohXgr-yO2WVVmQjXL0rTHc6vJ=mb+qCUKzuPAA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix selftests broken by mitigations=off
To: laoar.shao@gmail.com
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, gerhorst@cs.fau.de, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 5:49=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> When we configure the kernel command line with 'mitigations=3Doff' and se=
t
> the sysctl knob 'kernel.unprivileged_bpf_disabled' to 0, the commit
> bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations"=
)
> causes issues in the execution of 'test_progs -t verifier.' This is becau=
se
> 'mitigations=3Doff' bypasses Spectre v1 and Spectre v4 protections.
>
> Currently, when a program requests to run in unprivileged mode
> (kernel.unprivileged_bpf_disabled =3D 0), the BPF verifier may prevent it
> from running due to the following conditions not being enabled:
>
>   - bypass_spec_v1
>   - bypass_spec_v4
>   - allow_ptr_leaks
>   - allow_uninit_stack
>
> While 'mitigations=3Doff' enables the first two conditions, it does not
> enable the latter two. As a result, some test cases in
> 'test_progs -t verifier' that were expected to fail to run may run
> successfully, while others still fail but with different error messages.
> This makes it challenging to address them comprehensively.
>
> Moreover, in the future, we may introduce more fine-grained control over
> CPU mitigations, such as enabling only bypass_spec_v1 or bypass_spec_v4.
>
> Given the complexity of the situation, rather than fixing each broken tes=
t
> case individually, it's preferable to skip them when 'mitigations=3Doff' =
is
> in effect and introduce specific test cases for the new 'mitigations=3Dof=
f'
> scenario. For instance, we can introduce new BTF declaration tags like
> '__failure__nospec', '__failure_nospecv1' and '__failure_nospecv4'.
>
> In this patch, the approach is to simply skip the broken test cases when
> 'mitigations=3Doff' is enabled. The result as follows after this commit,
>
> - without 'mitigations=3Doff'
>   - kernel.unprivileged_bpf_disabled =3D 2
>     Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>   - kernel.unprivileged_bpf_disabled =3D 0
>     Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
> - with 'mitigations=3Doff'
>   - kernel.unprivileged_bpf_disabled =3D 2
>     Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>   - kernel.unprivileged_bpf_disabled =3D 0
>     Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>
> Fixes: bc5bc309db45 ("bpf: Inherit system settings for CPU security mitig=
ations")
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/bpf/CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW=
3hmUCNSV9kx4sQ@mail.gmail.com
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/bpf/unpriv_helpers.c | 34 +++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> ---
> v1 -> v2: Fix leaked fd
>
> diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing=
/selftests/bpf/unpriv_helpers.c
> index 2a6efbd0401e..ca4760795f5d 100644
> --- a/tools/testing/selftests/bpf/unpriv_helpers.c
> +++ b/tools/testing/selftests/bpf/unpriv_helpers.c
> @@ -4,9 +4,41 @@
>  #include <stdlib.h>
>  #include <error.h>
>  #include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
>
>  #include "unpriv_helpers.h"
>
> +static bool get_mitigations_off(void)
> +{
> +       char cmdline[4096], *c;
> +       int fd, ret =3D false;
> +
> +       fd =3D open("/proc/cmdline", O_RDONLY);
> +       if (fd < 0) {
> +               perror("open /proc/cmdline");
> +               return false;
> +       }
> +
> +       if (read(fd, cmdline, sizeof(cmdline) - 1) < 0) {
> +               perror("read /proc/cmdline");
> +               goto out;
> +       }
> +
> +       cmdline[sizeof(cmdline) - 1] =3D '\0';
> +       for (c =3D strtok(cmdline, " \n"); c; c =3D strtok(NULL, " \n")) =
{
> +               if (!strncmp(c, "mitigtions=3Doff", strlen(c))) {
> +                       ret =3D true;
> +                       break;
> +               }
> +       }
> +
> +out:
> +       close(fd);
> +       return ret;
> +}
> +
>  bool get_unpriv_disabled(void)
>  {
>         bool disabled;
> @@ -22,5 +54,5 @@ bool get_unpriv_disabled(void)
>                 disabled =3D true;
>         }
>
> -       return disabled;
> +       return disabled ? true : !get_mitigations_off();
>  }
> --
> 2.39.3
>

Pls. just igore this wrong patch. Sorry about the noise.
I must be in a sleep state currently. I will send a new one after I
get awake ...

--=20
Regards
Yafang

