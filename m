Return-Path: <bpf+bounces-33586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE72191EBF2
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6219B1F21FF3
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD05C747F;
	Tue,  2 Jul 2024 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpNTycdv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AEB393;
	Tue,  2 Jul 2024 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719881450; cv=none; b=I5FL883rBrLuHXU8Lmzqs4q5Jgf0ECr37G8YWBfuZ606+EBGmieceGPS6j70FeZ+mPazAWM8Y8VgwgrICfvou66mYM1ZLB6OthW85N0KHXCXjUEN/RkxqaLfs0j6fMXMidkLhTFwebwBPfxPhl8lRcnqOlpEEUyK3xc2/8Ed7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719881450; c=relaxed/simple;
	bh=0PXRHIHZoSwkwd+wtEfJAGq4W2ivS2XcgyCtdGxzRkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLJ40Z4m0LIsZjfxuhGvydrYGmM4xf85UFyt+O5hOrpXkZLPD/+K3LCr3DCBDyVZKT+0UIHALXJRZ9G5vuBQ2ytvCVF79blFcjOOvTdx3iWKwiaYRi6+VhpH0UehlW1HxlJsWSSZIXrnd/3MGah0wxhjjtSxyO3QiI6bVDID88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpNTycdv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-706524adf91so2914504b3a.2;
        Mon, 01 Jul 2024 17:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719881448; x=1720486248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30AfonYGYq2X4o/7NFpqRFDK9omT6ND1cVfdbuoTNhY=;
        b=IpNTycdvHKdEXwla1A0HpgUUHq07TCMdxSaL6aodT+Z1fNa+lXgQkT4VdMBd/twdi8
         RaMojrTgEhBjVTLSWrH2TxPCSTmRVGWutob8SWSV1eBbi5DGLPhdVN24kLy1sntJxdR3
         4TKioD/YchzXbNwb0xWJTATxHDYdxVTBMygcZqtpT5PojSSg9FS1iQVgI717I4GmPXze
         /c5bIP2UjEBT6vWd2W9Z3LAxHwXw4xWQeOAuVt9lR5psZcqM0ua11ns8/1ioF7RMj4dP
         4vN/ZPd+p4pIU6jDe0JurbjNidv6afutHsrx80uRaNxehy4DUT1+Pb+GQ2rVS7JNAeWr
         uwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719881448; x=1720486248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30AfonYGYq2X4o/7NFpqRFDK9omT6ND1cVfdbuoTNhY=;
        b=iDv8k69Hprr2AVV2j22o5IsbudkmdVNdq13bw+7P1b2kyInrJdZg3jBGHUulaJcGQN
         arC/krlczg+px2UCMF6DiSwdu3x2g5osLnxIAHnBBPR5K0DGzdyrrYTG34lrvjNID5MC
         vsFlYeDoD8/ttFo0oorTodcrZWfB/GloYeFcQC/vSUVDe+vxJ1Qx1iuyllU9OS5iwr6X
         lKc8heGZnrSd15KcK0j2i5l3QWPbANN6lWu1L+yA5QbtRR14MNKdIsyrBTxlr+IeSJRt
         a82aHcCBmW0pqBbPDf+mioz+sdPxVBMbFY86lYJ4FoQFOfD/kpttyqxdqAZe2a/jrl4Z
         DyxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPInaz5yLn9PmutoR76OXgzp9yUpFyPZ6ugxeboyJfQ4IAHyTb8dxBDi99eVg2dSHjncsaBQfvyOJYdH9n0PZ19khAqcLTCMu7+MBM0ksh6Kotuw6jdyBEzOt/fPyN/4DqZU1utno6ZFM/r9ak3nRr7NBAbF7+eEFiwyx2ru+N
X-Gm-Message-State: AOJu0YzRExXzTLRH9vd/0tY4Q5RmMr+g0mYsLVBXempOXccZKv9ZMoek
	leC9hA0j/RrnAbA4MoDIFP9RS5SKWWbimFzQL9esPfunu60+TyLq3kVzWbOgNCqCxssi1MeC7nx
	SDpGBL1pM4sfu4EONBb2Z+2AokDQ=
X-Google-Smtp-Source: AGHT+IEuyqWwK3sealCqYh/T3xqkNnFIiFfzKLJAJ8MIbp8FqNT0HzMFiNJW077uTKRQKnq3ArRhsw/XFgs3IAHRt7s=
X-Received: by 2002:a05:6a00:179d:b0:705:b0aa:a6bf with SMTP id
 d2e1a72fcca58-70aaad2bd89mr9322805b3a.2.1719881448051; Mon, 01 Jul 2024
 17:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702003119.3641219-1-briannorris@chromium.org> <20240702003119.3641219-4-briannorris@chromium.org>
In-Reply-To: <20240702003119.3641219-4-briannorris@chromium.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:50:35 -0700
Message-ID: <CAEf4Bzbxu_PJsDE_ex_FBi+SKnWZjVA8vA11vL2BxUhyBB6CAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools build: Correct bpf fixdep dependencies
To: Brian Norris <briannorris@chromium.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 5:32=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> The dependencies in tools/lib/bpf/Makefile are incorrect. Before we
> recurse to build $(BPF_IN_STATIC), we need to build its 'fixdep'
> executable.
>
> I can't use the usual shortcut from Makefile.include:
>
>   <target>: <sources> fixdep
>
> because its 'fixdep' target relies on $(OUTPUT), and $(OUTPUT) differs
> in the parent 'make' versus the child 'make' -- so I imitate it via
> open-coding.
>
> I tweak a few $(MAKE) invocations while I'm at it, because
> 1. I'm adding a new recursive make; and
> 2. these recursive 'make's print spurious lines about files that are "up
>    to date" (which isn't normally a feature in Kbuild subtargets) or
>    "jobserver not available" (see [1])
>
> After this change, top-level builds result in an empty grep result from:
>
>   $ grep 'cannot find fixdep' $(find tools/ -name '*.cmd')
>
> [1] https://www.gnu.org/software/make/manual/html_node/MAKE-Variable.html
> If we're not using $(MAKE) directly, then we need to use more '+'.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  tools/build/Makefile.include | 10 +++++++++-
>  tools/lib/bpf/Makefile       |  6 +++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tools/build/Makefile.include b/tools/build/Makefile.include
> index 8dadaa0fbb43..c95e4773b826 100644
> --- a/tools/build/Makefile.include
> +++ b/tools/build/Makefile.include
> @@ -1,8 +1,16 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  build :=3D -f $(srctree)/tools/build/Makefile.build dir=3D. obj
>
> +# More than just $(Q), we sometimes want to suppress all command output =
from a
> +# recursive make -- even the 'up to date' printout.
> +ifeq ($(V),1)
> +  SILENT_MAKE =3D +$(Q)$(MAKE)
> +else
> +  SILENT_MAKE =3D +$(Q)$(MAKE) --silent
> +endif
> +
>  fixdep:
> -       $(Q)$(MAKE) -C $(srctree)/tools/build CFLAGS=3D LDFLAGS=3D $(OUTP=
UT)fixdep
> +       $(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS=3D LDFLAGS=3D $(O=
UTPUT)fixdep
>
>  fixdep-clean:
>         $(Q)$(MAKE) -C $(srctree)/tools/build clean
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 2cf892774346..0743cf653615 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -153,7 +153,11 @@ $(BPF_IN_SHARED): force $(BPF_GENERATED)
>         echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_=
xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 ))=
 || true
>         $(Q)$(MAKE) $(build)=3Dlibbpf OUTPUT=3D$(SHARED_OBJDIR) CFLAGS=3D=
"$(CFLAGS) $(SHLIB_FLAGS)"
>
> -$(BPF_IN_STATIC): force $(BPF_GENERATED)
> +$(STATIC_OBJDIR):
> +       $(Q)mkdir -p $@
> +
> +$(BPF_IN_STATIC): force $(BPF_GENERATED) | $(STATIC_OBJDIR)

wouldn't $(BPF_IN_SHARED) target need a similar treatment?

> +       $(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS=3D LDFLAGS=3D OUT=
PUT=3D$(STATIC_OBJDIR) $(STATIC_OBJDIR)fixdep
>         $(Q)$(MAKE) $(build)=3Dlibbpf OUTPUT=3D$(STATIC_OBJDIR)
>
>  $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
> --
> 2.45.2.803.g4e1b14247a-goog
>
>

