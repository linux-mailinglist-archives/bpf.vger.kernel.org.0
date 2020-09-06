Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A68E25EC72
	for <lists+bpf@lfdr.de>; Sun,  6 Sep 2020 06:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgIFEQj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Sep 2020 00:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgIFEQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Sep 2020 00:16:38 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9491CC061573;
        Sat,  5 Sep 2020 21:16:38 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d18so10851812iop.13;
        Sat, 05 Sep 2020 21:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Z/fGL94ajDI5pDOUTAQoK2bBKVk8IqTDMiT7vswB5Vc=;
        b=rnB9oeb9uAiNdxico8gQ/Uu6PpV+qFWrCd2pTcN2Fmdb18UpWf0HjBo+NgPEtr2pf5
         c6eX5YrN2kBgZLTovSqtgKkE++G5zGTRNNmuHn2t0jRh3YzeIiz9DvhMjqnIaXyz84bC
         +uv8bT9iZ0yHlP1pi1SDL7fCh2LdBh/Xb17DasEaqNmdFQ2XFGrKVQiZSyk/gmVXuXNL
         HPd1zUEo6MOfCCUp7DWQnQYzbh0Km+MuhehLS5A0LP2TZ8TW3+JG+/dX0dkEz56jXH/c
         9I7ww9xOPNYx/ieoeFqv/wOl0JV7FC5KzyeBDDnxUxzBmyzs6+M0p7iNNYGHDH3iCwcP
         uyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Z/fGL94ajDI5pDOUTAQoK2bBKVk8IqTDMiT7vswB5Vc=;
        b=qRfTNOjxplhwZ8LwH30PD3plzpaD3CGMMrZFVN4apRktHEhsGpzTqgCM5YBFt/awX5
         CU2rX8YwLREF4rwnvtlA4Z15Hj2ZlyzOD2IZxhhK99iTOoCkPJRKGvgrEx/WnPNsJyWA
         cRVmPDlCJhAlrwx6ZqWVaoaqDltvjTNWNC06Rt3P+zSj+E2zM2igbtzEak3Q81AdMme9
         ri1GgYmM3zq3Nur+uUCw65YiqljeF4R22kJMq5E1jtuIpR3qRAK4PZ463wNHZI23nSVX
         XxOO/KzqIEKVWBN0Ucc4W4vo6p6tCarY5EoRE0fNwOKTF1FaFc2Gy+MYDSaZC3l1Fe0K
         Px4g==
X-Gm-Message-State: AOAM531DTeTdtusfX7NPuQxf6UH3EHO09bVzIVODuaqjEreNUwe0Uo/9
        QfJHtyqgIn8Ic0s4p/KV5UYtMwhIT/om9v8X6tOc72mgqHtodA==
X-Google-Smtp-Source: ABdhPJwCoI42ih5aArUUmiOJR/2BMvhkFDr7wupnF1B1JsbP1K10yQELOXzkBL4PH5HND7W8HNGHs3o9k9j7loqWGi4=
X-Received: by 2002:a5e:881a:: with SMTP id l26mr12929738ioj.51.1599365794492;
 Sat, 05 Sep 2020 21:16:34 -0700 (PDT)
MIME-Version: 1.0
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Sat, 5 Sep 2020 21:16:23 -0700
Message-ID: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
Subject: Problem with endianess of pahole BTF output for vmlinux
To:     bpf@vger.kernel.org, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I'm using GCC 8.4.0, binutils 2.34 and pahole 1.17, compiling on an
Ubuntu/x86_64 host and targeting both little- and big-endian mips
running on malta/qemu. When cross-compiling Linux 5.4.x LTS and
testing bpftool/BTF functionality on the target, I encounter errors on
big-endian targets:

> root@OpenWrt:/# bpftool btf dump file /sys/kernel/btf/vmlinux
> libbpf: failed to get EHDR from /sys/kernel/btf/vmlinux
> Error: failed to load BTF from /sys/kernel/btf/vmlinux: No error information

After investigating, the problem appears to be that "pahole -J"
running on the x86_64 little-endian host will always generate raw BTF
of native endianness (based on BTF magic), which causes the error
above on big-endian targets.

Is this expected? Is DEBUG_INFO_BTF supported in general when
cross-compiling? How does one generate BTF encoded for the target
endianness with pahole?

Thanks for any feedback or suggestions,
Tony
