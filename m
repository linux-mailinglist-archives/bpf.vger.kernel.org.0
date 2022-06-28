Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E159355EA43
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiF1Qum (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbiF1QtM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:49:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74853207A
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:46:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w24so13116346pjg.5
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=POy+zBjn312v0YhfuOKTjwLjE/i7nInlT7W/RUAD3x0=;
        b=mwh9lspGqFai2wIzZ2N0tIigtwUZApjXm4sL69nMcR2WGlXJdMeZNHSSmCQIEPmyS2
         APfkkVbYEaSnXI+rpLEyznXB0rQ8927dNT0SNzWD5cRuoWk/5VNvt+Nzno5SNZr+xerA
         jdJXFdUoELrS3bWSNsPj1Y3RWykTSOxFwWmxCUygjhMn5AlL1Ms7spXu89nuJeop6mkJ
         ikUR56yLCVHJAFgWvNe6cQtXbeYsCU7ORFoOsrKNxX3N9D5Qib9qlX8N14TVkbTidbSV
         kiPYlgHk0Q4iTqzTEzklKMG6kn+r7CfeBqp2Z03sDzFveMk9AMnpkALrjZtL6JYYSfjC
         CTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=POy+zBjn312v0YhfuOKTjwLjE/i7nInlT7W/RUAD3x0=;
        b=VoNIaRAnuYCAAiPMIHAwyuHg5YIZ4uOHwnZqLqs7P19rUUx4Og6y87lb4Ssxmg4qBV
         KjQJwv0siLh94xokeCEzo2QEVfCPUqZEbKp9nHKrQYYcHnb9+xBP0yxFVMmAojTbkMAz
         Mguqie66ixYH73qwmfQf/n7OIfvNCjyiPjxNluYIL+r+x2VsSK9gTBJaLdB25u/IXqD8
         WIkxFMhYm4/RVikH8D0eGqe/S4zHUOUFoYmCJwtsQ/8bzUPmsl+vEvZN0vGCremyfsqj
         QndlppTXYPma8BL5Oy2ywt/H5lKzqRlnG4O6qc7Du335c8tqN6yhaHW/Tc91EyfqeKYg
         nYKw==
X-Gm-Message-State: AJIora++Y1NctZK2LWlBdhkzl5v+qM5UDokPKAs6MNt63HHaARbi0nu4
        0yaQiY2IA2q6sVsZd17B6lA=
X-Google-Smtp-Source: AGRyM1vW7Nb2qyBiAAVgyD9R0+sj+gkP53tntlKYA2kMl9UgDMK5fSKOpNVDsFU1hV9zHAWZ3+BRWQ==
X-Received: by 2002:a17:90a:9407:b0:1ed:5b4c:4df2 with SMTP id r7-20020a17090a940700b001ed5b4c4df2mr587198pjo.114.1656434807088;
        Tue, 28 Jun 2022 09:46:47 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::1:50])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709027c0400b0016a04b577f1sm9531765pll.246.2022.06.28.09.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:46:46 -0700 (PDT)
Date:   Tue, 28 Jun 2022 09:46:43 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf] bpf, docs: Better scale maintenance of BPF subsystem
Message-ID: <20220628164643.2gdyifct4x2zbbsb@MacBook-Pro-3.local>
References: <5bdc73e7f5a087299589944fa074563cdf2c2c1a.1656353995.git.daniel@iogearbox.net>
 <20220627122535.6020f23e@kicinski-fedora-PC1C0HJN>
 <CAADnVQLOS4kvmcp+aaX6gtDUCUfoL906K+Y4KUZOsYBDso_xMw@mail.gmail.com>
 <20220627133027.1e141f11@kernel.org>
 <CAADnVQKf8huK_bdGPQzOZwXJD7aqr-2a3jFPfhYrEz8BD115qw@mail.gmail.com>
 <ac8da400-f403-7817-414d-d3001c82dc4c@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8da400-f403-7817-414d-d3001c82dc4c@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 28, 2022 at 10:59:02AM +0200, Daniel Borkmann wrote:
> On 6/27/22 10:38 PM, Alexei Starovoitov wrote:
> > On Mon, Jun 27, 2022 at 1:30 PM Jakub Kicinski <kuba@kernel.org> wrote:
> [...]
> > > > vger continues to cause trouble and it doesn't sound that the fix is coming.
> > > > So having everyone directly cc-ed is the only option we have.
> > > 
> > > Yeah, Exhibit A - vger is lagging right now...
> > > I guess the "real fix" is on the vger, trying to massage MAINTAINERS
> > > now is not a great use of time..
> > 
> > The real fix is to move away from vger and adjust get_maintainer
> > script to be smarter when the mailer can do its job.
> > MAINTAINERS file should list everyone who performs code reviews
> > and maintains the code.
> 
> Agree to all above. I think to address Jakub's concern, we could adapt
> this regex similarly as we have in XDP and move this as a remainder to
> a misc/noise section, like below:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dbf978014e8a..b5a1960c8339 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3657,8 +3657,6 @@ F:        scripts/pahole-version.sh
>  F:     tools/bpf/
>  F:     tools/lib/bpf/
>  F:     tools/testing/selftests/bpf/
> -N:     bpf
> -K:     bpf
> 
>  BPF JIT for ARM
>  M:     Shubham Bansal <illusionist.neo@gmail.com>
> @@ -3850,6 +3848,11 @@ L:       bpf@vger.kernel.org
>  S:     Maintained
>  F:     tools/testing/selftests/bpf/
> 
> +BPF [MISC]
> +L:     bpf@vger.kernel.org
> +S:     Odd Fixes
> +K:     (?:\b|_)bpf(?:\b|_)
> +

Good idea!

>  BROADCOM B44 10/100 ETHERNET DRIVER
>  M:     Michael Chan <michael.chan@broadcom.com>
>  L:     netdev@vger.kernel.org
> 
> If there are no objections, I can fold this in..

sgtm
