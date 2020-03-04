Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518E01789BA
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 05:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgCDEtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 23:49:15 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44924 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCDEtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 23:49:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id f198so380317qke.11;
        Tue, 03 Mar 2020 20:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLh2t8ZxrQBaE7gNcsphAEc0sv2uDeMMUkAe4uCR56E=;
        b=HCInrvUhEUF02OYcK6mqXOlHVZL0s9reDN2rTvIbiPTBOSzaRK9Do71mx1576p4F+N
         bv4uKyqWe2Dr4Thtu9gu7hJ/aoKMqPA4k5XFCGbzIonR6tQwc/wCkisy4UAVSSp5GA6c
         fUjhUDxXy59ieUrYiBZeVCe18ewiyzVkjgDOhuCuqAIXNL9UdT39sUACcpiLSvbWde2q
         GmtVJ5ubTTylyiKCpK2c6xvjXBMpsUwjg4kc33x42yU/cbS5p4yWfyjVoGIYViZ3A1N4
         tvx7t9/6Hx/2KooiORFGr3cwgkdANj8RYKjt62MrvYQZW+YehRpuhrooViVvgOapYnoM
         QG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLh2t8ZxrQBaE7gNcsphAEc0sv2uDeMMUkAe4uCR56E=;
        b=IuLD8ynFmDa0GGsCPLz+TnmRoWYoUROvDVFwlpdrUyxwjQ0mrczbvV2vml41Do5vAf
         kW9m7oxHDs5cKQ5CbJM/90wT93OKEduzfKhbUVaYsAdym6dJKq130Bmw9TIOekMkDah6
         +cmsZZnrZDKVSyYsOaJHTPhPQxL2DqbbTSnJ7j+bRDlZHMs7MVha6nZCRQWZnjkteQTx
         LB3CI4D3wZF37bkp4XXGiiujD0Xe/h2xC5NFvo/Q86J/+fqzqifNN7mBPzrSO6Rp5jVq
         VkBfP9ttfAe20vhF1S/Vi22Ia4tRuphWfqOz0pfTEsYzCIUlAbWDDd+u1TszxucGQxzO
         fjDw==
X-Gm-Message-State: ANhLgQ1O0PJrPIqHGYN7dUKf+6UU5ZRk5upgYR2Jn1VXXrzsSg/xodQL
        T5ix6uAg83VSXNUzbI2K/5FQzDnwZA+bRkfv1NU=
X-Google-Smtp-Source: ADFU+vsd9kw2Aw/vR4b8MZQEChp3C4LPMq0HGJoVad+NcWeQ67Fguaa5Imjp/4V9DWD7WH+znJfMXEJmiAk273+dS6g=
X-Received: by 2002:a37:a2d6:: with SMTP id l205mr1319554qke.92.1583297353989;
 Tue, 03 Mar 2020 20:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20200304015528.29661-1-kpsingh@chromium.org> <20200304015528.29661-2-kpsingh@chromium.org>
In-Reply-To: <20200304015528.29661-2-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 20:49:02 -0800
Message-ID: <CAEf4BzZ58iymCdqqCe=p-7BSF_kt+Dd19taEjTJBEt_ZBZz0=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Refactor trampoline update code
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> As we need to introduce a third type of attachment for trampolines, the
> flattened signature of arch_prepare_bpf_trampoline gets even more
> complicated.
>
> Refactor the prog and count argument to arch_prepare_bpf_trampoline to
> use bpf_tramp_progs to simplify the addition and accounting for new
> attachment types.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

See note about const-ification of trampoline and naming suggestion,
but looks good overall:

Acked-by: Andrii Nakryiko <andriin@fb.com>


>  arch/x86/net/bpf_jit_comp.c | 31 ++++++++++---------
>  include/linux/bpf.h         | 13 ++++++--
>  kernel/bpf/bpf_struct_ops.c | 12 ++++++-
>  kernel/bpf/trampoline.c     | 62 +++++++++++++++++++++----------------
>  4 files changed, 73 insertions(+), 45 deletions(-)
>

[...]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 704fa787fec0..cfe96d4cd89f 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -190,40 +190,49 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>         return ret;
>  }
>
> -/* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
> - * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
> - */
> -#define BPF_MAX_TRAMP_PROGS 40
> +static struct bpf_tramp_progs *
> +bpf_trampoline_update_progs(struct bpf_trampoline *tr, int *total)

reading the code again, seems like bpf_trampoline_update_progs is
really more like bpf_trampoline_get_progs, no? It doesn't modify
trampoline itself, so might as well mark tr as const pointer.


> +{
> +       struct bpf_tramp_progs *tprogs;
> +       struct bpf_prog **progs;
> +       struct bpf_prog_aux *aux;
> +       int kind;
> +

[...]
