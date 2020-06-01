Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DF91E9C09
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 05:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgFADaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 May 2020 23:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgFADaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 May 2020 23:30:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E603C061A0E;
        Sun, 31 May 2020 20:30:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m18so6345588ljo.5;
        Sun, 31 May 2020 20:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F6i5SASVSgSpSYDAzcQbg53yQdsOZO3Fx6kPYx0YZ3k=;
        b=O3HBguBOjy9sbFSRhXwYFbERBBgwHyLSwd1HeOzzomTbQ9sstgS0uLsWg+9DMY8cuU
         9Xc5EKddC/tJ4jLJ0Ohyo5lRJJ9Ut5PDDYH3gr8d/Q8wlhWmtihojzzQLoebqotEo8Np
         ZMmCdZzdl4wBxvBeqbNy/8yfvXW8q1xgBDJBepPs5ulKx5qdYDTcPKLAOVd2Sv8/Bati
         M9DYquffpRBTZboxLSNWIp19dP9Tt+vvenkFMswFrJ+cS3dJUhkSoKRyQlbXLjnnI70G
         QdzARbHY/ltMk/udHvzbh/ugykfksYJy4fd4AinbKgLN1RTXT1VNxe/yaDnk76td13BJ
         BG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F6i5SASVSgSpSYDAzcQbg53yQdsOZO3Fx6kPYx0YZ3k=;
        b=nlwby03BTb9up85fk/de1DTomhZ1CCfNU+Fuidw7t+ePeq2/HrStfXStp43sGr82AP
         uILbbK4MBtQg+mijiG4rH6ZaHrA5acZ0ejDT64NHfbbGjvHlrf+TKuUbEDRbeA6xuSHx
         TMtbfSNjGpPFBw/W/eQFehssI/fDAdEQLFwv2JsvzZe+fdOHOrbU4MYvMM991naf7uDk
         NOpQPGAAkTL44cReBXbmLswAy/lar4OA/wfEveQcOCyZCsy67x3GRGEW0iN2zc+9C3Q0
         scCIgkfgoT6PmRjgePLyC4I31mmVVxoglfPL4Dh15K2xQU4otmLmGGQrYvn+iuLZHHuz
         Jt6Q==
X-Gm-Message-State: AOAM531Fevx2jCocxp8eww0GI8KWBnINfU+RzjvzvPaA8sZumQMkDj03
        /FrZYHvN1IeLRF16SVhHj8G4I18B++oEjRrt13M=
X-Google-Smtp-Source: ABdhPJyAzNEi9cYcWRrJbXRavEbq8HtQrf4XpgklNn4d4oE7k997AbiodKa1D6orRYJMl6d9CC7JAHppNThneUVBUCI=
X-Received: by 2002:a2e:9187:: with SMTP id f7mr9916269ljg.450.1590982222677;
 Sun, 31 May 2020 20:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com> <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook> <202005291043.A63D910A8@keescook> <ff10225b79a14fec9bc383e710d74b2e@huawei.com>
In-Reply-To: <ff10225b79a14fec9bc383e710d74b2e@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 31 May 2020 20:30:11 -0700
Message-ID: <CAADnVQK2WEh980KMkXy9TNeDqKA-fDMxkojPYf=b5eJSgG=K0g@mail.gmail.com>
Subject: Re: new seccomp mode aims to improve performance
To:     "zhujianwei (C)" <zhujianwei7@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Lennart Poettering <lennart@poettering.net>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 31, 2020 at 7:08 PM zhujianwei (C) <zhujianwei7@huawei.com> wro=
te:
>
> This is the test result on linux 5.7.0-rc7 for aarch64.
> And retpoline disabled default.
> #cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
> Not affected
>
> bpf_jit_enable 1
> bpf_jit_harden 0
>
> We run unixbench syscall benchmark on the original kernel and the new one=
(replace bpf_prog_run_pin_on_cpu() with immediately returning 'allow' one).
> The unixbench syscall testcase runs 5 system calls=EF=BC=88close/umask/du=
p/getpid/getuid, extra 15 syscalls needed to run it=EF=BC=89 in a loop for =
10 seconds, counts the number and finally output it. We also add some more =
filters (each with the same rules) to evaluate the situation just like kees=
 mentioned(case like systemd-resolve), and we find it is right: more filter=
s, more overhead. The following is our result (./syscall 10 m):
>
> original:
>         seccomp_off:                    10684939
>         seccomp_on_1_filters:   8513805         overhead=EF=BC=9A19.8%
>         seccomp_on_4_filters:   7105592         overhead=EF=BC=9A33.0%
>         seccomp_on_32_filters:  2308677         overhead=EF=BC=9A78.3%
>
> after replacing bpf_prog_run_pin_on_cpu:
>         seccomp_off:                    10685244
>         seccomp_on_1_filters:   9146483         overhead=EF=BC=9A14.1%
>         seccomp_on_4_filters:   8969886         overhead=EF=BC=9A16.0%
>         seccomp_on_32_filters:  6454372         overhead=EF=BC=9A39.6%
>
> N-filter bpf overhead:
>         1_filters:              5.7%
>         4_filters:              17.0%
>         32_filters:     38.7%
>
> // kernel code modification place
> static noinline u32 bpf_prog_run_pin_on_cpu_allow(const struct bpf_prog *=
prog, const void *ctx)
> {
>         return SECCOMP_RET_ALLOW;
> }

This is apples to oranges.
As explained earlier:
https://lore.kernel.org/netdev/20200531171915.wsxvdjeetmhpsdv2@ast-mbp.dhcp=
.thefacebook.com/T/#u
Please use __weak instead of static and redo the numbers.
