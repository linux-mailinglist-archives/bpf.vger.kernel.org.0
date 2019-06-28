Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9C5A2CD
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 19:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfF1Rxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jun 2019 13:53:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34209 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfF1Rxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jun 2019 13:53:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so7270255qtu.1
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0VXjOuemygXk3sKnpxbC7ILnkH2orjaphFPqCj99sM=;
        b=Z6EV76OTACjwwOtXRy2M4jOtzIuMpefOe7cCmCnJbbDrjczXj97KoIL/U+nycB3WE9
         czeHXf+IBRbYXI5vJKPrkRv99eOCZCMPL/Cf7OyjUipYW2Mw/OcI7ip8QuoK0KIRqK7j
         mGTF3kfSbf7OAhJnuMHMmd+Ugv49gfL1lNu8V138a608c2DKjXgfVFdFk8JEukxKAajm
         1BJ4mbP/0cmgw1PXbDWeZCdkdJ4xx5Az6rfd1e5kPMEZOP4jCwa8aIT4ePth4G9CqsS4
         VEdi1Ynl5Dt0f1ruEo+e8PSTyxmOyhwYSgYB7LKvGQnOHVVWjXGtKyrAEiQ7W37tp9db
         3ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0VXjOuemygXk3sKnpxbC7ILnkH2orjaphFPqCj99sM=;
        b=hkI2oroWF/y8qLVs3fafeRzBbvg9V+aqo7bqndMkc4f8IRlSD1SjszDBJu0NESvaqb
         iaxsGFBuKiDlMA4npjHGdyqsTJKkxohCSi8gNZoSgVUFQMH1zzDorRroyYwT8em7K3sg
         aPWFWSIaRrhE92/9ypFwEW+bwHPwF5tTGbOtDbFuYmuG54mIRuMuCFAQUSpooynEj+8N
         OGuWsps1kWNtnLKx1RoQ+rwV1rXsKuAiltHFIWzkCx9+wANKctMyHTy+obABSaMEIer2
         2+k52qf6qP0Gs/akBeXEyXyC3p3YBThy60l5WFuL1953Btm08SaZRZiLG9qMJdHRaMe/
         PSqQ==
X-Gm-Message-State: APjAAAXj2ja2q26ooJKur0MhPZFjvJpM+XitL9SEZYQs8As8+H+kPIg3
        ZOFERkQzjivY1//J5FEaW6a/nZ9tEK6oDrWmgj/kyZ/W
X-Google-Smtp-Source: APXvYqyS0IXrMADEPPcRuoV3KltvwkFD9CNT8aNf1PLkMC8hwHwpOeo49LZjiuz1O3a++hOT7zHjmJ26waYHq/72f0Y=
X-Received: by 2002:ac8:152:: with SMTP id f18mr8940598qtg.84.1561744418151;
 Fri, 28 Jun 2019 10:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190628172209.37290-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190628172209.37290-1-andriy.shevchenko@linux.intel.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 28 Jun 2019 10:53:27 -0700
Message-ID: <CAPhsuW75_wNSkLeRVL-X+qtdbExU+xcu7Vx5f5ZiH2CL-3TPxA@mail.gmail.com>
Subject: Re: [PATCH v1] tools: Keep list of tools in alphabetical order
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 28, 2019 at 10:23 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When `make help` is executed it lists the possible tools to build,
> though couple of entries is kept unordered. Fix it here.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/Makefile b/tools/Makefile
> index 3dfd72ae6c1a..02585735320c 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -10,6 +10,7 @@ help:
>         @echo 'Possible targets:'
>         @echo ''
>         @echo '  acpi                   - ACPI tools'
> +       @echo '  bpf                    - misc BPF tools'
>         @echo '  cgroup                 - cgroup tools'
>         @echo '  cpupower               - a tool for all things x86 CPU power'
>         @echo '  debugging              - tools for debugging'
> @@ -22,12 +23,11 @@ help:
>         @echo '  kvm_stat               - top-like utility for displaying kvm statistics'
>         @echo '  leds                   - LEDs  tools'
>         @echo '  liblockdep             - user-space wrapper for kernel locking-validator'
> -       @echo '  bpf                    - misc BPF tools'
> +       @echo '  objtool                - an ELF object analysis tool'
>         @echo '  pci                    - PCI tools'
>         @echo '  perf                   - Linux performance measurement and analysis tool'
>         @echo '  selftests              - various kernel selftests'
>         @echo '  spi                    - spi tools'
> -       @echo '  objtool                - an ELF object analysis tool'
>         @echo '  tmon                   - thermal monitoring and tuning tool'
>         @echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
>         @echo '  usb                    - USB testing tools'
> --
> 2.20.1
>
