Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E170A3ABD89
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 22:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhFQUih (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 16:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFQUih (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 16:38:37 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77F5C061574;
        Thu, 17 Jun 2021 13:36:27 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id bj15so3845646qkb.11;
        Thu, 17 Jun 2021 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDVXVk3I2rfDZGq72YGMlss6FWWN6DWRrgMI317m85w=;
        b=Mv22Vt7LUDhtsumcHt5Y26h7SkqnTfCgdJRuDiYMQaRB+J5LHjnuIKKO74HTp2ODEk
         NABwpe0U+O7t1P/8F47pi8S5z2HtItY5nTNrBIQ490O0qHO/Fm6CqhBY+OFfWpGFwVPV
         CbTjlUaISQYrvHRjsPPZmtnllcVZrS4xNwE4Nt4h2zps/LJNAqVaG+dSRIyncITbiPBg
         2Gv+1Ekm9wewDhRBlpswQbzkjNusYLWPwHB5Bcf9auTWkRZn/wddxRcuBd74pfsrguc0
         y4hYdw+UReQMSo2afmepG4EFefOeHipSIWNUstHRb3aN9MmgUaODs6fJrFkdAhgHnJX2
         gAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDVXVk3I2rfDZGq72YGMlss6FWWN6DWRrgMI317m85w=;
        b=GcS0zedNGq/3RYBqe2NJb2o3vK/BspgR8VYTPsoPJP3D2hIHcJsrafGc6+jR+cKqrK
         g1k9arGaot/WEM3ssaPAlD370+SO9p8Dm77abD4zpPDLIO9QZhqMd1LGSAEws84C3sha
         RV2EyFvrWZe9DOKdaRQr5ZX4vKhqS+CxLO9AGcSMbYTPc5CmLbI0Ma0B++NxeJDa/qy2
         9kGk1PVI9FEmZHJy+hWuhc0lSeewiaUF4ncecY8GN/a4ISADBjpXiBMSKJtGTHElhW8n
         oltq9X37LWpaEz0qqBxhbdeGhTBFGNgs6nl4/nBay4pqOZOR7/i9crfmci5jgtBbgXXW
         7YnQ==
X-Gm-Message-State: AOAM530k5OYsMACg2KP124OVMOY22ZUX836H73xjyr5UmTdSTdizkRrz
        uFEj90utdsXX7bXmhMZYiiCswNiKLELIhaAgX8M=
X-Google-Smtp-Source: ABdhPJwbimy2MZD9Ae7ayigWyBvayOX46/hs9s8m0jpHC9F7aNAl602LheK2N04NE4+8/4gkWT+3dvG5x8Qt6DcXKR4=
X-Received: by 2002:a25:6612:: with SMTP id a18mr9045907ybc.347.1623962186492;
 Thu, 17 Jun 2021 13:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210617182023.8137-1-grantseltzer@gmail.com> <20210617182023.8137-2-grantseltzer@gmail.com>
In-Reply-To: <20210617182023.8137-2-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Jun 2021 13:36:15 -0700
Message-ID: <CAEf4Bzar3CVJCkKHo5RKcCXLAwEVW5y_JUTo7_cVuBOwjRaiJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/1] Add documentation for libbpf including
 API autogen
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 11:20 AM grantseltzer <grantseltzer@gmail.com> wrote:
>
> This adds rst files containing documentation for libbpf. This includes
> the addition of libbpf_api.rst which pulls comment documentation from
> header files in libbpf under tools/lib/bpf/. The comment docs would be
> of the standard kernel doc format.
>
> Signed-off-by: grantseltzer <grantseltzer@gmail.com>
> ---
>  Documentation/bpf/index.rst                   | 13 +++++++
>  Documentation/bpf/libbpf.rst                  | 14 +++++++
>  Documentation/bpf/libbpf_api.rst              | 27 ++++++++++++++
>  Documentation/bpf/libbpf_build.rst            | 37 +++++++++++++++++++

Didn't we agree to have docs under Documentation/bpf/libbpf? That
should make it clear that each is libbpf-specific and probably would
make copying/syncing easier. Plus it will be a libbpf sub-section in
the docs, no?

>  .../bpf/libbpf_naming_convention.rst          | 32 +++++++---------
>  5 files changed, 104 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/bpf/libbpf.rst
>  create mode 100644 Documentation/bpf/libbpf_api.rst
>  create mode 100644 Documentation/bpf/libbpf_build.rst
>  rename tools/lib/bpf/README.rst => Documentation/bpf/libbpf_naming_convention.rst (89%)
>
> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> index a702f67dd..44f646735 100644
> --- a/Documentation/bpf/index.rst
> +++ b/Documentation/bpf/index.rst
> @@ -12,6 +12,19 @@ BPF instruction-set.
>  The Cilium project also maintains a `BPF and XDP Reference Guide`_
>  that goes into great technical depth about the BPF Architecture.
>
> +libbpf
> +======
> +
> +Libbpf is a userspace library for loading and interacting with bpf programs.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   libbpf
> +   libbpf_api
> +   libbpf_build
> +   libbpf_naming_convention
> +
>  BPF Type Format (BTF)
>  =====================
>
> diff --git a/Documentation/bpf/libbpf.rst b/Documentation/bpf/libbpf.rst
> new file mode 100644
> index 000000000..2e62cadee
> --- /dev/null
> +++ b/Documentation/bpf/libbpf.rst
> @@ -0,0 +1,14 @@
> +.. SPDX-License-Identifier: GPL-2.0

Should we use dual-license LGPL-2.1 OR BSD-2-Clause like the rest of libbpf?

> +
> +libbpf
> +======
> +
> +This is documentation for libbpf, a userspace library for loading and
> +interacting with bpf programs.
> +

[...]

> +    $ cd src
> +    $ PKG_CONFIG_PATH=/build/root/lib64/pkgconfig DESTDIR=/build/root make
> \ No newline at end of file
> diff --git a/tools/lib/bpf/README.rst b/Documentation/bpf/libbpf_naming_convention.rst
> similarity index 89%
> rename from tools/lib/bpf/README.rst
> rename to Documentation/bpf/libbpf_naming_convention.rst
> index 8928f7787..b6dc5c592 100644
> --- a/tools/lib/bpf/README.rst
> +++ b/Documentation/bpf/libbpf_naming_convention.rst
> @@ -1,7 +1,7 @@
> -.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +.. SPDX-License-Identifier: GPL-2.0

I don't think we can just easily re-license without asking original
contributor. But see above, I think we should stick to the
dual-license to stay consistent with libbpf sources?


[...]
