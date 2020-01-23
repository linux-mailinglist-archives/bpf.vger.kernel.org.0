Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAE5147038
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 19:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAWSAw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 13:00:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44406 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWSAw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 13:00:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so4280050qkb.11;
        Thu, 23 Jan 2020 10:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjajhBuUHgmsUmSOzJHuUV6Zb4Qt2oP329J3QSODkhs=;
        b=AyFF7cdv99soMyTaRXnu+Z5Db/pAg2xMOJRoJ+y/wzJosfTzilFHht/1w6KWm055qT
         LBDkFuCMDYC5+zm3ixghCDggrQogGF5D1O4YMLpHNH1/h39nA2v25cPesevzGFwqqnKv
         bu1SA7hpordVgK/c/xYIr6DQ21oebGyBqQBqnCZ+xr+H/AZHtg4KKiAzgubIUFGESl8f
         Ok6IGfoTFV+0jwTm5NKJrYb3APGEha2ctps9d0CiEB7dJbXK5Rl4/qwaN/KfuJJesAHO
         +JDmLXLHFCjA4FCFh0FIltvtPgsPP+VUoPzXd84hQk6nK1ksXlGOSbXSMu5Kxio5Mi2O
         fpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjajhBuUHgmsUmSOzJHuUV6Zb4Qt2oP329J3QSODkhs=;
        b=Ll/aIywT5t01dipImFSrdSepHlQblt8UvsVRta68PBKp5Z8VWVznkmP4wkcKXOkRI4
         zrRN9J+cPJgCCM+EBOnIDthgduCCYrWHh+HEclVWpsSwxYl7sV3UrerH0HaasZqJBpaD
         3U/fL4MrfknhogC5jEoUdmCJkEvtmUl7vpgKyUkFY+hK4R+3Yy15/A50Lul4eSgpMYok
         qBn5Q/lXEFVNLNWQFsx1HK+dtZ9ny4e6BZgqcg2xNwPk5rsSVO36nwwuB0q4eCOdqY95
         Mno+EpUxtD8sgbVPh4nntubWSQ5SBRkTNNhdSpU1TYjqy5LDIglxSfUbHoLE/fSc2NAr
         FAwA==
X-Gm-Message-State: APjAAAV2g6Mym+8c08WdDCDPoyoFxgPW0LpbqsqEKTvElojIyU9Znd/v
        +t+UTau6bPN/sFRekw9VqMaDwNGywKYHMRF5mbY=
X-Google-Smtp-Source: APXvYqzTbm7nV2a/ShavuV2TKnmHRmJ7wzGMM3QJ7cfNiA3ZBb4lNlsX9/ki1ngSIWhs23JMSjqg4hOZfHIs3t8qzAI=
X-Received: by 2002:a37:a685:: with SMTP id p127mr18070215qke.449.1579802450607;
 Thu, 23 Jan 2020 10:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20200123152440.28956-1-kpsingh@chromium.org> <20200123152440.28956-9-kpsingh@chromium.org>
In-Reply-To: <20200123152440.28956-9-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Jan 2020 10:00:39 -0800
Message-ID: <CAEf4BzZ7gmCTzxw4f=fp=j2_buBQ3rV8m3qWH8s-ySY6sGVPzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/10] tools/libbpf: Add support for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
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

On Thu, Jan 23, 2020 at 7:25 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> * Add functionality in libbpf to attach eBPF program to LSM hooks
> * Lookup the index of the LSM hook in security_hook_heads and pass it in
>   attr->lsm_hook_idx
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> ---

Looks good, but see few nits below.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/bpf.c      |   6 ++-
>  tools/lib/bpf/bpf.h      |   1 +
>  tools/lib/bpf/libbpf.c   | 104 +++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.h   |   4 ++
>  tools/lib/bpf/libbpf.map |   3 ++
>  5 files changed, 114 insertions(+), 4 deletions(-)
>

[...]

> @@ -5084,6 +5099,8 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
>                 if (prog->type != BPF_PROG_TYPE_UNSPEC)
>                         continue;
>
> +
> +

why these extra lines?

>                 err = libbpf_prog_type_by_name(prog->section_name, &prog_type,
>                                                &attach_type);
>                 if (err == -ESRCH)
> @@ -6160,6 +6177,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)       \
>  }                                                              \
>
>  BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
> +BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
>  BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
>  BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
>  BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
> @@ -6226,6 +6244,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
>                                       struct bpf_program *prog);
>  static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
>                                      struct bpf_program *prog);
> +static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
> +                                  struct bpf_program *prog);
>
>  struct bpf_sec_def {
>         const char *sec;
> @@ -6272,6 +6292,9 @@ static const struct bpf_sec_def section_defs[] = {
>         SEC_DEF("freplace/", EXT,
>                 .is_attach_btf = true,
>                 .attach_fn = attach_trace),
> +       SEC_DEF("lsm/", LSM,
> +               .expected_attach_type = BPF_LSM_MAC,

curious, will there be non-MAC LSM programs? if yes, how they are
going to be different and which prefix will we use then?

> +               .attach_fn = attach_lsm),
>         BPF_PROG_SEC("xdp",                     BPF_PROG_TYPE_XDP),
>         BPF_PROG_SEC("perf_event",              BPF_PROG_TYPE_PERF_EVENT),
>         BPF_PROG_SEC("lwt_in",                  BPF_PROG_TYPE_LWT_IN),
> @@ -6533,6 +6556,44 @@ static int bpf_object__collect_struct_ops_map_reloc(struct bpf_object *obj,
>         return -EINVAL;
>  }
>
> +static __s32 find_lsm_hook_idx(struct bpf_program *prog)

nit: I'd stick to int for return result, we barely ever use __s32 in libbpf.c

[...]
