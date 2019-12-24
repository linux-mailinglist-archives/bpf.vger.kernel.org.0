Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C7A129E2C
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2019 07:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfLXGpG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Dec 2019 01:45:06 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43297 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLXGpG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Dec 2019 01:45:06 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so15368716qke.10;
        Mon, 23 Dec 2019 22:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBwbpDsBTx0TBXWTathQ7eBqCJIKnOlRHIXajiSIAMk=;
        b=CV5XJmeC5AhbgrwvDGaT3y2ih3+FWhLu1miFdFmpTnQ4hL3fABuC2zB2M5aVLg0bEK
         8Z9pS4cBYe3rHNVK70fWYBoLkkc3bnEqIF8pw4OTlz/m7Imk3MkARYVKgQ40UvqKgRmt
         Fyh+qBh4Wc+uytZWSDOuTPXoqGpRwKe6Ve1T6k60dxO/5m79IjFjbp333KwjOWq3cden
         Cvpn9UdTqhUygXOEOm//DikMHNMBUshdunGaX8ZuE6/QRUVzdlZcLSzpWkK2HIJr/N3M
         4R2Bs0wx1JXv8G8cADzS416vjKKSHfJdcVho0PiLKUT8OaPsHPMkmz2Or01d854a3afl
         VQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBwbpDsBTx0TBXWTathQ7eBqCJIKnOlRHIXajiSIAMk=;
        b=nskMdpAdmLSjNkrrkc4PtHg+bv5wUp0xXOvLrXxbmJ8/m9qLM8PXOR5hA7QlvgYDJL
         hU8MAa64NgFDAApGNyKrSXCXOmKEPdTsJHbB1c/Zeh7C6nYhEOFTZB7KhWDhnZSISWHr
         xRsxGajJIbwkss1dUE55vCH7HbABRljIa0U0oqSEQOgeXV0Z/BiDu96ks+t+2BzKqiBm
         WFsm5puAC+OAe3RSZTOTrDb1LGUTRZueRKJzUETtk2ZfKNZkzqmk5/jGMmWMqeJdtcXc
         sQxiO8ZtiqJlqQdOAhfPzLK6j4ZsRh0Z6HCLPOZL2MO/sk967mBt7WJWBAUC302DatL/
         r0XQ==
X-Gm-Message-State: APjAAAXLjnUE8XZEvGnae/38sblKFKXJUAj6UULzemhkmSefXEg1xTph
        eXQVvG2AESmMV3D9j0nzk/aZCLrcytEQ1btm8h4=
X-Google-Smtp-Source: APXvYqwprX+GZsxqu4aOiFRTl+Wg4TNP/ha2IvNFmVWrlVvYQbkPTvJO+OxYjhMk0oQjBaTTk6Pl33xM/mp65XF+p7M=
X-Received: by 2002:a37:a685:: with SMTP id p127mr30990481qke.449.1577169905101;
 Mon, 23 Dec 2019 22:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-12-kpsingh@chromium.org>
In-Reply-To: <20191220154208.15895-12-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Dec 2019 22:44:54 -0800
Message-ID: <CAEf4BzZFi_h_9t+u=BSOLA8KYxs2BsnFywLOrhvKckD2xDuLpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 11/13] tools/libbpf: Add bpf_program__attach_lsm
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

On Fri, Dec 20, 2019 at 7:42 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Add functionality in libbpf to attach eBPF program to LSM hooks.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/lib/bpf/libbpf.c   | 127 +++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.h   |   2 +
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 126 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b0b27d8e5a37..ab2b23b4f21f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5122,8 +5122,8 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
>         return -ESRCH;
>  }
>
> -static inline int __btf__typdef_with_prefix(struct btf *btf, const char *name,
> -                                           const char *prefix)
> +static inline int __btf__type_with_prefix(struct btf *btf, const char *name,
> +                                         const char *prefix)

Please do this rename in a patch that introduced this function, there
is no need to split such changes between two patches. See also my
request to rename and generalize it a bit.

>  {
>
>         size_t prefix_len = strlen(prefix);
> @@ -5149,9 +5149,9 @@ int libbpf_find_vmlinux_btf_id(const char *name,
>         }
>

[...]

>
> +
> +static int bpf_link__destroy_lsm(struct bpf_link *link)
> +{
> +       struct bpf_link_lsm *ll = container_of(link, struct bpf_link_lsm, link);

struct bpf_link link being a first field is a requirement for
bpf_link, so you don't need container_of, just cast link to your type.

> +       char errmsg[STRERR_BUFSIZE];
> +       int ret;
> +
> +       ret = bpf_prog_detach2(ll->prog_fd, ll->hook_fd, BPF_LSM_MAC);
> +       if (ret < 0) {
> +               ret = -errno;
> +               pr_warn("failed to detach from hook: %s\n",
> +                       libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
> +               return ret;
> +       }
> +       close(ll->hook_fd);
> +       return 0;
> +}
> +
> +static const char *__lsm_hook_name(const char *title)
> +{
> +
> +       int i;
> +
> +       if (!title)
> +               return ERR_PTR(-EINVAL);
> +
> +       for (i = 0; i < ARRAY_SIZE(section_names); i++) {

section_names have been renamed to section_defs a while ago, please rebase

> +               if (section_names[i].prog_type != BPF_PROG_TYPE_LSM)
> +                       continue;
> +

[...]
