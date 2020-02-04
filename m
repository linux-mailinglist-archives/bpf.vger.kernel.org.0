Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF55152211
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2020 22:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBDVrX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Feb 2020 16:47:23 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36465 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBDVrX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Feb 2020 16:47:23 -0500
Received: by mail-qv1-f65.google.com with SMTP id db9so137358qvb.3
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2020 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0O6LurSbx17wJIFmlyOyz1L4q96278kBQvOHK2Bdtc=;
        b=GMLGrO68Voq0/1Nwt/0Tb1Xev1zUdhhr1ZNQn4Jr82fzbIp6guUFGs/afFC69x+OH2
         hxcwSQlzP2pPEdR0awme/HBjZCVKgoPL1ItWaOfI42dMtPRlD/seH54ggkqP/+5DVMmg
         bbQExG1iyx7dOODIBMF6VXs/8d0YaWXt/W35n//jA5HM171Eu64ZdUWAbCqyp8k+QS9Q
         NSKwqq7iAdlCGaOrCVZAPIcr/BM8jfrHKRXeKcysAXEVO3L/S7qa4/Jmd4FwDJBCelj3
         Q6kLKO7D0i8PvcWhMJOJE9oYfnwQoI13iWVtr6CPX1lwaou6xbLhIY4WiL5UA29/DLXO
         6TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0O6LurSbx17wJIFmlyOyz1L4q96278kBQvOHK2Bdtc=;
        b=B4oT68raAW1zo2JK2w/gBF2qQQcCC5a/SbIdi4FG3rUa3DeUue8Mh9rTzSfH2h5YyU
         cxtCDtnJ3SH58tjoSWCAraKj0Fvz4EBU9msf0w8vIAhjv7u68BZIQqY6nh/U5j0/+YcA
         +BN0bK5U+ZHPwckZC6S7ubbac7u+9dErBXj7pU8GGL8p+RJX+MQE0xUWaPf3UHYTuHw7
         M0n0qOLnHuL9verFhuyjNd11VNoQRPq1dwz0dXr4282qqOhA3kcPWr3iL3QBhzWhp13v
         tVuDDUtJdl1tigOE2yatDSWYQZqeCwoscmpt51uc6AChpXI2Ay+ko/nIkXZ2FE5MYScq
         tNSQ==
X-Gm-Message-State: APjAAAUJ//+PlgL7is0RQbFMCBh0MX+l7SAQNwlajsYbMIGkFsFoiWca
        SKsleGGIjH+ipeCD0xsuY5JpU8x4++H092l0Y5jOAw==
X-Google-Smtp-Source: APXvYqxpMk0GPIFRhKnNcJ5LTCHLRf3NyJI/tm/qLbnHW6ImHGAtQ1wVrAXK42lXjc2MDyqVc5NhRjpqNrb53dWFZQw=
X-Received: by 2002:a05:6214:8cb:: with SMTP id da11mr28292450qvb.228.1580852841261;
 Tue, 04 Feb 2020 13:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20200204175303.1423782-1-songliubraving@fb.com>
 <CAEf4BzabT41Ls3CLmv9Vb-X_5NLwbMiQLLiNoK34svjKt4BxfA@mail.gmail.com> <8BE57865-79D3-42B2-978A-116CD0142FFB@fb.com>
In-Reply-To: <8BE57865-79D3-42B2-978A-116CD0142FFB@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 Feb 2020 13:47:10 -0800
Message-ID: <CAEf4BzbRzFsgnYFLw__oJL9640-Dfn11pjgsqN6EdX+3UmbWwg@mail.gmail.com>
Subject: Re: [PATCH] tools/bpf/runqslower: Rebuild libbpf.a on libbpf source change
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 4, 2020 at 1:35 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Feb 4, 2020, at 10:43 AM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Feb 4, 2020 at 9:54 AM Song Liu <songliubraving@fb.com> wrote:
> >>
> >> Add missing dependency of $(BPFOBJ) to $(LIBBPF_SRC), so that running make
> >> in runqslower/ will rebuild libbpf.a when there is change in libbpf/.
> >>
> >> Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
> >> Cc: Andrii Nakryiko <andriin@fb.com>
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> >> ---
> >> tools/bpf/runqslower/Makefile | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
> >> index 87eae5be9bcd..ea89fcb6d68f 100644
> >> --- a/tools/bpf/runqslower/Makefile
> >> +++ b/tools/bpf/runqslower/Makefile
> >> @@ -75,7 +75,7 @@ $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
> >>        fi
> >>        $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
> >>
> >> -$(BPFOBJ): | $(OUTPUT)
> >> +$(BPFOBJ): $(LIBBPF_SRC) | $(OUTPUT)
> >
> > Let's instead update this rule to do what selftests/bpf do (watch *.c,
> > *.h and Makefile, and use all + install_headers to build libbpf and
> > generate bpf_helper_defs.h?
>
> Do you mean:
>
> diff --git c/tools/bpf/runqslower/Makefile w/tools/bpf/runqslower/Makefile
> index 87eae5be9bcd..39edd68afa8e 100644
> --- c/tools/bpf/runqslower/Makefile
> +++ w/tools/bpf/runqslower/Makefile
> @@ -75,7 +75,7 @@ $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
>         fi
>         $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
>
> -$(BPFOBJ): | $(OUTPUT)
> +$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(OUTPUT)
>         $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)                         \
>                     OUTPUT=$(abspath $(dir $@))/ $(abspath $@)

this works

Acked-by: Andrii Nakryiko <andriin@fb.com>

>
> >
> > Please also specify (in subject) which tree (bpf or bpf-next) you are targeting.
>
> Aha, I started with "bpf: runqslower:". Then I some how changed it to
> tools/bpf/runquslower. Will fix.
>
> Thanks,
> Song
>
