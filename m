Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84B220F735
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 16:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbgF3O2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgF3O2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 10:28:51 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBD7C03E979
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 07:28:51 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id r9so6568304ual.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZfEnDgVVNipP2I93VYm6PPgX7n0at/rNjnPHhhxKF/c=;
        b=Z0Zxqkp3ix0lxO1L1ILBLBn8BfnG4iK+6iKiRH2fec8kP3QHx8M9et2FPY4Bmececm
         E6C44MyjESYs+7e+J9431N77BrhptP6WBWP20adA5wbZoa4Fgut/hqoaIZFeVC3aNPzX
         Rj6HKSGMNGhOHAO+eTMgH5nL3rHqqx/RtSSQEYgVfyoQzOFxXxZqVJXxoCh0dLiEJoEO
         byxnwcfp9NvQTYwgqMUm/KcQ9OaH4dF+/Hr2dMiTWfvg8xdrNkwpGgk4jcajT/guo8HD
         0DVg1EeB50xr/E3xi7rboJCCT4NyocenpP5BTR+k/huxD84tdXFbf7WgPPPmsifZfPQ1
         z+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZfEnDgVVNipP2I93VYm6PPgX7n0at/rNjnPHhhxKF/c=;
        b=LnCVEfrRqXRZHR9RSwSY5G86s4HO2Y//o2ZDkjJ7AcajMaZeHW8I9NL7t3XmSGIK8D
         flRdDJU7k5mb3lYheqdFQQgDN+GD9Xk0pmaVrbdUnZN0XJBna38p3kNY/nJ2PhcLb7sA
         gokxpeVxO6UsUeRcy7TsmaeuQwhgpsNQWNZrUxuPFGnoP/f752LHTDwdqfyoA80NRYog
         vIO03kvXqlC5MzA/ifr/nVS+Lo8iVrtYdgdC3/4V2kUsiOSBeIV3krT+n2WcfVlFDVbS
         1OMdz4juk2SLZ/ayBenSpfH84OCdsmZfbxQjsCwbS0qA4COvkZLsGnXG388GZ35w/VoT
         fZxg==
X-Gm-Message-State: AOAM532te7k+YAEjl9tffS+NVxMZ3ImyE6gZAkgLn+fqZYx+MNipQlDI
        o7k8nmEBK0AQmQQ3kRlicpRrbHFcteKa+x97fxuvEFU=
X-Google-Smtp-Source: ABdhPJxXfxZweqN2zw6As1JX/BQ0MOrzSXddaG3vU7f3CiO9t9wQs7CRqbYJTBV+j8Tsxj89VqUHIN6FXwsEtqTCK5s=
X-Received: by 2002:a9f:2e16:: with SMTP id t22mr14465117uaj.84.1593527330188;
 Tue, 30 Jun 2020 07:28:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:4744:0:0:0:0:0 with HTTP; Tue, 30 Jun 2020 07:28:49
 -0700 (PDT)
From:   Rudi Ratloser <reimth@gmail.com>
Date:   Tue, 30 Jun 2020 16:28:49 +0200
Message-ID: <CAOLRBTUSkRbku25rbw6Fyb019wFqFvEN=6xGM+RgFJFQ=NH4KQ@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference in __cgroup_bpf_run_filter_skb
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have experienced a kernel BPF null pointer dereference issue on all
our machines since mid of June. It might be related to an upgrade of
libvirt/kvm/qemu at that point of time. But we=E2=80=99re not sure.

None of the servers can be used with this bug, as they crash latest
one hour after reboot. The time period until kernel panic can be
easily reduced down to 2 minutes, when starting one or more
applications of the following list:
- LXD daemon (4.2.1)
- libvirtd daemon (6.4.0) with qemu/kvm guests
- NFS server 2.5.1
- Mozilla Firefox
- Mozilla Thunderbird

If none of the applications run, the systems seem to be stable.

Intermediate solution:
Downgrade Linux kernel to 4.9.226 LTS or 4.4.226  LTS on all the machines

Why this solution works is not clear, yet. One of the major
differences we saw is, that both kernel packages have been configured
with user namespaces disabled.

We experienced the kernel freeze on following Arch Linux kernels:
- 5.7.0 (5.7.0-3-MANJARO x64)
- 5.6.16 (5.6.16-1-MANJARO x64)
- 5.4.44 (5.4.44-1-MANJARO x64)
- 4.19.126 (4.19.126-1-MANJARO x64)
- 4.14.183 (4.14.183-1-MANJARO x64)
Kernel configs can be taken from https://gitlab.manjaro.org/packages/core.

Subsequent e-mails will contain the relevant extracts from journal or
netconsole logs.

Help and support on this issue is welcome.
