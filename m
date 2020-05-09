Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FCC1CC1CB
	for <lists+bpf@lfdr.de>; Sat,  9 May 2020 15:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEIN3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 May 2020 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgEIN3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 May 2020 09:29:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD7C061A0C
        for <bpf@vger.kernel.org>; Sat,  9 May 2020 06:29:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f134so846411wmf.1
        for <bpf@vger.kernel.org>; Sat, 09 May 2020 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSHgVr1+OqCQJfMEJtbRVU+sLyEep0NVbMZfdbR29as=;
        b=oknRkMCEibYIowA4vB1F3w7+Q/Jp0IVgvt2GIVkcYs4jGkZYb/VfjRwH32C8CUTdPN
         aUFt5iFA7Cz91RJbZOo/+W5kDyV76FSpUVDotaox7zRzSoR0P3PjdfrfaM6dmq3d51Of
         OerwQKoZYDuVWbO0HCz5IfY1xzK79DO67ZgQdI/6IuMsuYqHueROKGF3lJJbpi60sdTg
         CtxGoOyzeXxyqHfa7Uk3sNtLuaAp/7MBqVUCphNGkjOktIpT124jBZdjFK4KhS97hhjR
         Vit99/vakOEVM/EHcKzdktKfMTwakJMzyrrwlZO7896DgSDA/BY8OUUQRMb+pBgLTtSi
         IPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSHgVr1+OqCQJfMEJtbRVU+sLyEep0NVbMZfdbR29as=;
        b=Rr3pMBoBBAcb6PlbIAyoE4cUG5rKvBxWYcFztcyLhI/LGcNCdHZVnTHLdkPPaAOk/9
         gS40gQR0eIKPGeI/ZD+pwyOzGws4alTLo0STT4iuC3sG4qZ+SK9QA6e79I2bO0x8vF2v
         1dDdsz+ElBr1t0FN0/X2oiiXGqzCoJymykt+veJYUJi1sz7z6b9pPzcZ/LqP8hHUsb4g
         uZSLlGO3s4QwCe5a/jJXXjHBWzB/aUQlUJ6cFHQ9bmEX5m86dR8y2eTZtVM1FGnLFYz3
         QwSqPjAPNr1LewzwETYdJcqFp7cB0uLw2qcP8psYkYRvYVoThKLgde1LfHvoHSHYB4pz
         Y0HQ==
X-Gm-Message-State: AGi0Puai5+oXJlmvZ6fz+0Pff/AejTRRfbNIyg/YiKoo7umENNs0Mpgy
        MMq+ek6Dfq2jkx/Sj7L+OQJrSIaKAfF4cH/hM4hI
X-Google-Smtp-Source: APiQypLJu3K94Mj0KvnDUsBW9QafFIIZ0NqV5fFJKU4lHtevDMBGej6H9IYQfxGVaA6uG9tsuZz33L/KPB7QrqoAdog=
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr21212533wme.84.1589030938399;
 Sat, 09 May 2020 06:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <3ab505db-9e04-366b-d602-6b2935739f54@intel.com>
 <CAEf4BzZXA3pDwqLGTnrDAn7cH67Ei6tp8PRZwVAmsT-nTMA0gA@mail.gmail.com>
 <CAFLU3KuU6zFs7+xQ-=vy9WEx-4U=cTSW9VXNMyxRdwY3LHc9HA@mail.gmail.com>
 <CAFLU3KuUm_1HBjyQdypuWCa4soKwXF7zEic-4=e4pvTBbuwd+A@mail.gmail.com>
 <65526c26-c94b-d5dd-7143-b1af7071dbf9@intel.com> <CAFLU3KsDXDXqqhOUTx6jij7p3tgirNtDH-619z9mvgafFYN=jA@mail.gmail.com>
 <b3991caf-9e04-b6f4-aee5-86191a0fc3df@intel.com>
In-Reply-To: <b3991caf-9e04-b6f4-aee5-86191a0fc3df@intel.com>
From:   KP Singh <kpsingh@google.com>
Date:   Sat, 9 May 2020 15:28:42 +0200
Message-ID: <CAFLU3Ku=+VQ5KYXfwSqRknuYsz9nMV7-oj1Z1BNL4jiwVXPOOQ@mail.gmail.com>
Subject: Re: bprm_count and stack_mprotect error when testing BPF LSM on v5.7-rc3
To:     Ma Xinjian <max.xinjian@intel.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 9, 2020 at 11:59 AM Ma Xinjian <max.xinjian@intel.com> wrote:
>
>
> On 5/9/20 5:26 PM, KP Singh wrote:
> > Do you have bpf in your CONFIG_LSM string?
>
> That's the point!
>
> I remove bpf from  since I can't boot if bpf in it.

That does indicate a problem which needs to be fixed.

> seems bpf in CONFIG_LSM conflict with CONFIG_BPF_LSM
>
> Here is boot error:
>
> "Cannot determine cgroup we are running in: No data available
> Failed to allocate manager object: No data available
> [!!!!!!] Failed to allocate manager object, freezing.

I found some references to these error messages and they seem
to be coming from systemd but I am not sure.

   https://github.com/lxc/lxc/issues/1669
   https://github.com/containers/libpod/issues/1226

> Freezing execution.
> [   35.773797] random: fast init done
> [  130.560629] random: crng init done"
>
> > Also, can you share your Kconfig please?
>
> refer to attackment.
>
> I doubt sth was wrong with my kconfig, maybe me some suggestion

I am not saying something is wrong with your Kconfig :)
I just want to make sure we eliminate as many
variables as possible.

I was able to boot this successfully using QEMU
(after I enabled SCSI and VIRTIO). So it's likely
dependent on some user-space configuration
(again, I am not saying your config is wrong). But
I will need more information to reproduce and debug this.

Can you try providing a reliable reproduction with a list
of steps? e.g.

1. Download the vanilla image here.
2. Compile the kernel with defonconfig and kvmconfig
   (or your own config)
3. Boot the kernel in QEMU with the cmdline (...) and the
  QEMU args (...)

Thanks!
- KP

>
> Besides, I tested on both physical machine and vm

[...]

> >
