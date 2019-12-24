Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E76129E18
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2019 07:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfLXGgV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Dec 2019 01:36:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34756 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXGgV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Dec 2019 01:36:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so15764595qkk.1;
        Mon, 23 Dec 2019 22:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9f49rZjJKxHQwfDaONd7CPvs6B/LdSmBjADe//pqNas=;
        b=Q0fI68b6Cz4xabYadXmuPHobPKvFG2OM8qtvz8n0gm8iaRy3QkQsf70C667oqYKFz7
         BbI26kf9LSBYxPmQNBrn3mVmcj6aafUbeda7TeVJXEF0yUbnnrR9UyW1fKM9D1Vv9IFV
         cx5hM2YiJ8YArAo+JKOqpVlxtmu3Iu1/Lxg2MXOUfKWnPp/g55P6tl8qjLvfZCKRWkyF
         FN1T92sjrgi6Kr6aaAFRvrwLM68W468QdIfSmsqidLKwQtPfX1yaJ9qT0Hls3JA/VeRf
         77/Ye1FIneqm2xNioqZXdt0RY6nOm1WHooixyQIarWb4B5BdsAml5GnIII/wXZLXLna9
         Uuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9f49rZjJKxHQwfDaONd7CPvs6B/LdSmBjADe//pqNas=;
        b=IdeS6jf0k4mQaC4TPVx1Ha/ecDPmIl8D+yYqC9CrvUI4uZ3V3/dzW9UcKYvYaSdHcx
         QUF2TY6mVrXXIBMWqj2y4zeQy0Ogauiu7mXdfl64yQXVGuKB1M1mgHljyS0DbV1NYnA/
         m81KDHly/ASdJb+sOsDWA6oZqTo9+fHzvPTbU4v4i1a7bk9jP+pWfGWLr4sJYiRgBC5n
         30tVapHMC9WdALyZ30cM2+ZKlaaHNIVKNsNbnQNElnnog6olhVrH3mmck1Q3pV23Wptu
         j92lt8J3HNsMzuTaAGueIOImzqcd58btWR5PtSEX/GdAu/x/Xsv14WShfehyOLJh/a7P
         F1Sw==
X-Gm-Message-State: APjAAAVD3C/ZxhAUmDj06Ca6m+QD6NZ+jI3T2p+ioExi2NUHCQKitKoJ
        fgNqfhCWC8w6gHLyLzIgFPWGjEq0SScYI9RJA4c=
X-Google-Smtp-Source: APXvYqzAaS5x91eisBrBiUd9yh3gyBoa1BMy6JI4p5M2rCh8P5rjFxKBEJ84ucdaMez0uun3rPsL8FDjllogmrn39ZM=
X-Received: by 2002:a37:a685:: with SMTP id p127mr30971238qke.449.1577169379912;
 Mon, 23 Dec 2019 22:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-10-kpsingh@chromium.org>
In-Reply-To: <20191220154208.15895-10-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Dec 2019 22:36:08 -0800
Message-ID: <CAEf4BzYgcez2G1qJW9saJmzfeYirGdH58aAcUk-+YTJF6vyOuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 09/13] bpf: lsm: Add a helper function bpf_lsm_event_output
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> This helper is similar to bpf_perf_event_output except that
> it does need a ctx argument which is more usable in the
> BTF based LSM programs where the context is converted to
> the signature of the attacthed BTF type.
>
> An example usage of this function would be:
>
> struct {
>          __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>          __uint(key_size, sizeof(int));
>          __uint(value_size, sizeof(u32));
> } perf_map SEC(".maps");
>
> BPF_TRACE_1(bpf_prog1, "lsm/bprm_check_security,
>             struct linux_binprm *, bprm)
> {
>         char buf[BUF_SIZE];
>         int len;
>         u64 flags = BPF_F_CURRENT_CPU;
>
>         /* some logic that fills up buf with len data */
>         len = fill_up_buf(buf);
>         if (len < 0)
>                 return len;
>         if (len > BU)
>                 return 0;
>
>         bpf_lsm_event_output(&perf_map, flags, buf, len);

This seems to be generally useful and not LSM-specific, so maybe name
it more generically as bpf_event_output instead?

I'm also curious why we needed both bpf_perf_event_output and
bpf_perf_event_output_raw_tp, if it could be done as simply as you did
it here. What's different between those three and why your
bpf_lsm_event_output doesn't need pt_regs passed into them?

>         return 0;
> }
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/uapi/linux/bpf.h       | 10 +++++++++-
>  kernel/bpf/verifier.c          |  1 +
>  security/bpf/ops.c             | 21 +++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 10 +++++++++-
>  4 files changed, 40 insertions(+), 2 deletions(-)
>

[...]
