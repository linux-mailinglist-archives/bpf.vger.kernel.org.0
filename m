Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905C93F0859
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 17:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbhHRPsO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 11:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbhHRPsL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Aug 2021 11:48:11 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60663C061796;
        Wed, 18 Aug 2021 08:47:33 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a126so6132324ybg.6;
        Wed, 18 Aug 2021 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOrhWSG8tjo5OSgprY2llNKO2ACxIKOE7ZmEL78dvtA=;
        b=lnkPfyjpYTKtkW0YIEaCP0fpL/NjGrkOQlEMxEXRlBSsNUzoegDivDw2F8Afx5bPuP
         dpiZ58rSEc0ylRTvgkN4nErsvEqcTuO4iDb4r9WcCXSohzB9f8Op7DsW5M4U5AyB4//9
         qAzZBzAxGGlFq4hrDCqm9nNHEzbzYaWzWPD+5HK73W6bVLj0vgyr8HMyw6KIYoxqB0RE
         3aYUHs3+UncBIMHaWnj3yjKjMowIsz0i5jSGqR6CLkNPz3zI7CfVhSmvK1iMagUn0q2H
         9PNnnhw3K9eB7zxCp/S2Sa3Vo1cEeqZG72ptLClwHxMlTDluDq8asQ5k7EWrKHrjAbfQ
         bmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOrhWSG8tjo5OSgprY2llNKO2ACxIKOE7ZmEL78dvtA=;
        b=CW0aTAN0VnQd+im03tlUk+ddjrSWNbriRyNxXtFDCWm2D/Nr05hy748YVUJv2JnSNT
         h/Z9CUKwbMy5j21U5nqcO33IMN6AEqF58b3jGN8Rdv7FsslTWQjHqszoDPhUciGW5WeM
         yJzORYZ9JZaVesNzSZIlUgfJj2hUH4tfRsa+ubtl58RuAkd93Za2tsAzTppIfGR2a6xv
         XgeyGBq4rk6EF+Ra80zFDLId3RdRx5GdWqE/liasBlaXvI4yKDDet9rYRsvkc5MeIgDp
         WJsayycwkxL1azqCHIApt4iolYss9Un/YJzFxH4oVbbAOh7h6nrMAmKoML8bwThU9vcw
         5wtA==
X-Gm-Message-State: AOAM530N6C5YQSVvwAmzfmOFj7gibPDPSRjX+zQV/IMvbZmWXzrtNXM4
        8ISRpTvIoL4QfNDfNYFiElEBdvo3rKOM3AefYZs=
X-Google-Smtp-Source: ABdhPJyR8QdcODzDgT542cUdR9MMX31xJ9TBOBbg8rC/FPv6K014VhQRs/xKw6Ltm4n0i4SuwWZFfWxyJ/3jdqSG+0A=
X-Received: by 2002:a25:5054:: with SMTP id e81mr12147806ybb.510.1629301652564;
 Wed, 18 Aug 2021 08:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210818151313.49992-1-grantseltzer@gmail.com>
In-Reply-To: <20210818151313.49992-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 18 Aug 2021 08:47:21 -0700
Message-ID: <CAEf4BzavDNohwRpQmuow2PRzqnnRBWnOvMxx3Xbgudgv5=K6TA@mail.gmail.com>
Subject: Re: [PATCH] Rename libbpf documentation index file
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 18, 2021 at 8:13 AM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This patch renames a documentation libbpf.rst to index.rst. In order
> for readthedocs to pick this file up and properly build the
> documentation site.
>
> It also changes the title type of the ABI subsection in the
> naming convention doc. This is so that readthedocs doesn't treat this
> section as a seperate document.
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---

Please don't forget to add [PATCH bpf-next] to your future patches.
Also libbpf-related patches should come with "libbpf: " prefix in
patch subject.

Applied to bpf-next, thanks.


>  Documentation/bpf/libbpf/{libbpf.rst => index.rst}    | 8 ++++++++
>  Documentation/bpf/libbpf/libbpf_naming_convention.rst | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>  rename Documentation/bpf/libbpf/{libbpf.rst => index.rst} (75%)
>
> diff --git a/Documentation/bpf/libbpf/libbpf.rst b/Documentation/bpf/libbpf/index.rst
> similarity index 75%
> rename from Documentation/bpf/libbpf/libbpf.rst
> rename to Documentation/bpf/libbpf/index.rst
> index 1b1e61d5ead1..4f8adfc3ab83 100644
> --- a/Documentation/bpf/libbpf/libbpf.rst
> +++ b/Documentation/bpf/libbpf/index.rst
> @@ -3,6 +3,14 @@
>  libbpf
>  ======
>
> +For API documentation see the `versioned API documentation site <https://libbpf.readthedocs.io/en/latest/api.html>`_.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   libbpf_naming_convention
> +   libbpf_build
> +
>  This is documentation for libbpf, a userspace library for loading and
>  interacting with bpf programs.
>
> diff --git a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> index 6bf9c5ac7576..9c68d5014ff1 100644
> --- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> +++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> @@ -69,7 +69,7 @@ functions. These can be mixed and matched. Note that these functions
>  are not reentrant for performance reasons.
>
>  ABI
> -==========
> +---
>
>  libbpf can be both linked statically or used as DSO. To avoid possible
>  conflicts with other libraries an application is linked with, all
> --
> 2.31.1
>
