Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A31B3ABD90
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 22:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhFQUjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 16:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFQUjU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 16:39:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E916C061574;
        Thu, 17 Jun 2021 13:37:12 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id u30so5439148qke.7;
        Thu, 17 Jun 2021 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1h4dv+JYtiiLXp8wxdzLY9l8r0h397e8RzhgYeAcyHk=;
        b=pSbHOd9tSoF3+WvRAN+bdzn8hMk5aBcTjCO9ZYn48Acmp7fRze1UQ4qg8Hbi1lBptc
         jnalu5Roh0B0NuEHBdyv3fs0Sw/i1afXlFXQt6iRbwyQIBzhF8uvOJoBjdYwu4Pz1IuH
         5H/Zndbhf1Smt/YqCrDZ9th8E4/wwh2Qm7iYbbpmYnjUK2UJttjfljwgv5ZoJzLSx0H4
         NR2G5Popq/EGK3T8IDVPl50EY8cvtA0NkpByFDbMBE9mCtXOASWCBG5oGiGFsy4J5QcP
         xdkfRJekeYz4mu0IsrL90rS93UTN7EHtn0XI0fplfImWKGNtZchrwdnvYFdDbTveEUmJ
         namQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1h4dv+JYtiiLXp8wxdzLY9l8r0h397e8RzhgYeAcyHk=;
        b=n2pE8XlYRLmekaVaHhoro1kpM3KjMRoVJy8CiNm1FyELBYT/LlHgB7ZX5NfzIUGTyB
         KK6+XyJRy5uYc8hYAk7qlFMFFryJuRBG3ZBGLslmWAU23r/UX+tFQTmL4NTNZkUJzbiJ
         qYNfYtSrg8WkGfWfUC35ygESjRoyiBJL/0DzLWtzW6Q9Wiba3F7OVZOuEGiZwubfbibA
         Tk2EBAPmDvtnyyRIzEPscYtB29PltrXU1cPlX+hJvOzeDiWSZ9bXJjUEUnduP5RzlqYW
         ixZRtwug3ku/2ScTcgsBUUCP5Va7T+JG0gystlFLMXXchW2HICLLlwYrNi26YTWUXHdz
         BrwQ==
X-Gm-Message-State: AOAM532vZjBEJIUEpbiSA5yPOhdMiVqJGhEpLK1HdzvP7RNIxbw2sMhN
        NBjCuICwfzQZspQpBhTlKF/eTxTAcL1Ch9Ab1Pk=
X-Google-Smtp-Source: ABdhPJx9cQtL2/+vKFnEBama38q6emzazwv3nmFr58w14mACkWa0/FnepvO0UxxyDacSFjtTzh0fhTZp6FJ227UD1b4=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr8142750ybg.459.1623962231239;
 Thu, 17 Jun 2021 13:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210617182023.8137-1-grantseltzer@gmail.com>
In-Reply-To: <20210617182023.8137-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Jun 2021 13:37:00 -0700
Message-ID: <CAEf4BzYEMWXse1x6=GHwBgDqPG5i14xdQe_1Vf4K5qvygqxW2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/1] Autogenerating libbpf API documentation
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
> This patch series is meant to start the initiative to document libbpf.
> It includes .rst files which are text documentation describing building,
> API naming convention, as well as an index to generated API documentation.
>
> In this approach the generated API documentation is enabled by the kernels
> existing kernel documentation system which uses sphinx. The resulting docs
> would then be synced to kernel.org/doc
>
> You can test this by running `make htmldocs` and serving the html in
> Documentation/output. Since libbpf does not yet have comments in kernel
> doc format, see kernel.org/doc/html/latest/doc-guide/kernel-doc.html for
> an example so you can test this.
>
> The advantage of this approach is to use the existing sphinx
> infrastructure that the kernel has, and have libbpf docs in
> the same place as everything else.
>
> The current plan is to have the libbpf mirror sync the generated docs
> and version them based on the libbpf releases which are cut on github.
>
> grantseltzer (1):
>   Add documentation for libbpf including API autogen
>

You don't need the cover letter if you are submitting a single patch.
Just put all of the context in cover letter into the patch
description.

>  Documentation/bpf/index.rst                   | 13 +++++++
>  Documentation/bpf/libbpf.rst                  | 14 +++++++
>  Documentation/bpf/libbpf_api.rst              | 27 ++++++++++++++
>  Documentation/bpf/libbpf_build.rst            | 37 +++++++++++++++++++
>  .../bpf/libbpf_naming_convention.rst          | 32 +++++++---------
>  5 files changed, 104 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/bpf/libbpf.rst
>  create mode 100644 Documentation/bpf/libbpf_api.rst
>  create mode 100644 Documentation/bpf/libbpf_build.rst
>  rename tools/lib/bpf/README.rst => Documentation/bpf/libbpf_naming_convention.rst (89%)
>
> --
> 2.31.1
