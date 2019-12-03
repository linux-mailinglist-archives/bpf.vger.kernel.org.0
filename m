Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8491610FF3D
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2019 14:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLCNuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Dec 2019 08:50:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33604 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLCNuW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Dec 2019 08:50:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id 21so3937611ljr.0
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2019 05:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2Z48S2RpCT7bsi6W8o9xAPWyHBrbdx8QNidFwrDG7o=;
        b=BMG9l3glchxTcyzwEYZoeiPQ1Qf2dSE6m5plMBgskvfutAmc6yj49QbctF3o4z2oTB
         cps93OWgeo9tBN5woaUXIeuQbi6wTX2/OWPsTo9jP+pi73R/oSh0rx6tceSQLrDFpI65
         l8Y8XBgAtVdwxzND/FTSGV52KUoEBJBS6le14z1sVIR/WSQg3JxG0/FpflNiBAwQVk4a
         gfPtpFOnN7vVbnlMNAlvPeVBJe9Phc2rtYgnw90J/nC3xrEJ6scm91fL4jUpHOsNyUxt
         FjHhCcWANrj6bggMYyvjPor0jXKfdO4xamiI8KpJPMN8iH1Wvg7ko6ioSyRacz2fb3/L
         GbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2Z48S2RpCT7bsi6W8o9xAPWyHBrbdx8QNidFwrDG7o=;
        b=mbFdKogTaCSVIalqevGNOmYr2sSa7C/DicaskA+NbJ55MTC1Ygw7xCvwduO890C1u3
         Qlml0h3lHV20zcvtqV+ObgJ+owO7UVFr9DIqGgkmvuxX8Fs3D1Jk8RJ5lxK8USAjPELK
         2V3avVdNTH3qA4U6kTYWudUW2FJR9gsa49NENVDM1+yHvgEWhOu9nhKv+l3Mh4AD+Buh
         EpwveDY5lyn9lpG5ZT+IaTEU+3MQb9mk9bP+hYK1ZZW18hZ8qd8XUSzIFkMQJ0d8qzcO
         HTbvBcBWg/9LcZ8kWGWEIt+uf9PFfxuZ4rFm2oR7di4o0ZJJ4dtFYZ2eQhDOH9y5lHjQ
         9ITg==
X-Gm-Message-State: APjAAAUqdBSSlHIOdTHtM1SXspsxqcupUWmWVXAwI0BwxDJoV2Jd8Xl6
        nmDIlUXHmtFlupoo2F+qJOZoNItm+D2e2r86fxsklg==
X-Google-Smtp-Source: APXvYqzb5uReRFeX5koEY/BY43USZn3g2h9ZdZxnYptuZH70/60NpjVjh2aKhOqsBsPE5+4y54vib9ipj2q5Hb+FAW4=
X-Received: by 2002:a2e:7202:: with SMTP id n2mr2354490ljc.194.1575381019973;
 Tue, 03 Dec 2019 05:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20191126183451.GC29071@kernel.org> <87d0dexyij.fsf@toke.dk>
 <20191126190450.GD29071@kernel.org> <CAEf4Bzbq3J9g7cP=KMqR=bMFcs=qPiNZwnkvCKz3-SAp_m0GzA@mail.gmail.com>
 <20191126221018.GA22719@kernel.org> <20191126221733.GB22719@kernel.org>
 <CAEf4BzbZLiJnUb+BdUMEwcgcKCjJBWx1895p8qS8rK2r5TYu3w@mail.gmail.com>
 <20191126231030.GE3145429@mini-arch.hsd1.ca.comcast.net> <20191126155228.0e6ed54c@cakuba.netronome.com>
 <20191127013901.GE29071@kernel.org> <20191127134553.GC22719@kernel.org>
In-Reply-To: <20191127134553.GC22719@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 3 Dec 2019 19:20:08 +0530
Message-ID: <CA+G9fYsK8zn3jqF=Wz6=8BBx4i1JTkv2h-LCbjE11UJkcz_NEA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Use PRIu64 for sym->st_value to fix build on
 32-bit arches
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

FYI,

On Wed, 27 Nov 2019 at 19:15, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Another fix I'm carrying in my perf/core branch,
>
> Regards,
>
> - Arnaldo
>
> commit 98bb09f90a0ae33125fabc8f41529345382f1498
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Wed Nov 27 09:26:54 2019 -0300
>
>     libbpf: Use PRIu64 for sym->st_value to fix build on 32-bit arches
>
>     The st_value field is a 64-bit value, so use PRIu64 to fix this error on
>     32-bit arches:
>
>       In file included from libbpf.c:52:
>       libbpf.c: In function 'bpf_program__record_reloc':
>       libbpf_internal.h:59:22: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'Elf64_Addr' {aka 'const long long unsigned int'} [-Werror=format=]
>         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
>                             ^~~~~~~~~~
>       libbpf_internal.h:62:27: note: in expansion of macro '__pr'
>        #define pr_warn(fmt, ...) __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
>                                  ^~~~
>       libbpf.c:1822:4: note: in expansion of macro 'pr_warn'
>           pr_warn("bad call relo offset: %lu\n", sym->st_value);
>           ^~~~~~~
>       libbpf.c:1822:37: note: format string is defined here
>           pr_warn("bad call relo offset: %lu\n", sym->st_value);
>                                          ~~^
>                                          %llu

This build error is been noticed on Linux mainline kernel for 32-bit
architectures from Nov 26.

Full build log,
https://ci.linaro.org/job/openembedded-lkft-linux-mainline/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-lkft/2297/consoleText
https://ci.linaro.org/job/openembedded-lkft-linux-mainline/

- Naresh
