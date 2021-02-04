Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F01030E86F
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 01:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhBDAUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 19:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhBDAUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 19:20:09 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BC4C061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 16:19:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so1451120wry.2
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 16:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwOU3tajBpwMNzaDxBB/H0260BYdrNs4s2hHz4ehMJ8=;
        b=tpkTwKQVzYg4JHEQA9co+sO6vPA9GSqZiOwi1GOw6PttgXowGnCeGpcIn/pm+4LuMH
         fY8vKB8xY7sxmsOSBLsfC0ogNEhadmrRi9Spkrtse0rKnWzJBMTkzcOj3wjQa30SKKEE
         XeWGGbAWIA0n5EQb1rXIuWSypTq8kBAPbuCQGYrBrxEGeyYye/rCcpwZ0MmuqcKPaPro
         ZLMZtPG4LRk1jyIu8P3q++oQbkHM19geYllUqHC/qlAUz41eL76chPz9P/XPQdTwjbCF
         uaIaqz1CGqx65dRf0/1e/yAB+yDmQiYhkRnAYDZrPCCE1koHEozb+ZBZUSMRzEfRY7k9
         0vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwOU3tajBpwMNzaDxBB/H0260BYdrNs4s2hHz4ehMJ8=;
        b=hgU1HxA36yA8H6z4os997OI9EXy9JxBEQM0kAnipMVTH6UYowcJCIrAUAYnxhzgNWV
         RItJMyMIYEkd8ndeRFOc1MGhrBA/2U9ZDK6zkEA2wPzjMKDUumydRoOSAnqsZLa3OwfB
         FWAukq8CAXmLw1/MbPetd+QrSb3+G6hcYQNmoleOODRyR8HcMMl4aR/tnLoTTQP40h5A
         2azI40n5HiDveO1hsKXLQ1KgQESYY7sRIMWYvLWj3OpBQFRGBoYer0Bwx0lHwYmWiruE
         UvkkduxuUvSaYdmjzh/916KcLTOLm8CSf+eCS+s11jcxPs4he2M/eVCZm2TBG0CvpKza
         L+9A==
X-Gm-Message-State: AOAM530FvCunTKYFnUFdCh1whxOFzOA9Q5YmxwG7K2cLzZpGefoN55FS
        aNwsdiVd/ZrA4bt5TS61zSKKjZBY2CWrRbkgbo1uP3z61/04ChTj
X-Google-Smtp-Source: ABdhPJz2GpAS71guaOdh6rGmaNJ3YMT5JX5lDr2FTX//bIP123UmQ67gYakoiIKMSmAAImwSrMkWfWEXlgyRrMEd7OY=
X-Received: by 2002:a5d:414f:: with SMTP id c15mr6242828wrq.42.1612397967338;
 Wed, 03 Feb 2021 16:19:27 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
 <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com> <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 3 Feb 2021 17:19:11 -0700
Message-ID: <CAJCQCtS342b_DAOHswvB6ZwcRa79SoDrNgWDYwOHY4sVPx8pPw@mail.gmail.com>
Subject: Re: 5:11: in-kernel BTF is malformed
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 4:32 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> The important and very relevant part from the bugzilla:
>
> Feb 03 15:06:26 fmac.local kernel: BPF:        sched_reset_on_fork
> type_id=6 bitfield_size=0 bits_offset=0
> Feb 03 15:06:26 fmac.local kernel: BPF:
> Feb 03 15:06:26 fmac.local kernel: BPF:Invalid member bits_offset
> Feb 03 15:06:26 fmac.local kernel: BPF:
>
> Do you have full dmesg with output from the BPF verifier?

Full dmesg is attached to the bug. So is the kernel config.

[    0.000000] Linux version 5.11.0-0.rc6.141.fc34.x86_64
(mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 11.0.0
20210123 (Red Hat 11.0.0-0), GNU ld version 2.35.1-25.fc34) #1 SMP Mon
Feb 1 13:51:38 UTC 2021

> If you can share the vmlinux itself, that would help as well.

vmlinuz is in this rpm

https://kojipkgs.fedoraproject.org//packages/kernel/5.11.0/0.rc6.141.fc34/x86_64/kernel-core-5.11.0-0.rc6.141.fc34.x86_64.rpm


-- 
Chris Murphy
