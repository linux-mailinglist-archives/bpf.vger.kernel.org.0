Return-Path: <bpf+bounces-3320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE08273C35B
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 23:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DFC1C2135F
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD737156EA;
	Fri, 23 Jun 2023 21:55:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510B134C4
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 21:55:26 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1ED2685;
	Fri, 23 Jun 2023 14:55:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fa7512e5efso15020595e9.2;
        Fri, 23 Jun 2023 14:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687557323; x=1690149323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNHvy2FZDK77FbGlvskF8mraHXZccLrDtu5C69OuJYA=;
        b=GaV2EnZ6S7cA1YZSU3cvAGBY6qSvHRNBXJxqk7uIdJidCdfEF79SOaNER0Q8COcsZ/
         Bd3r6S32SMX4mXcaCgZRcfuWj1dJnLU1CZerPOyi/+qbiQfMBLtRfMXQoPiG+oINFnbf
         lbOkfa1Le15jRwJadFgNDjJwh51EJhdS5VOsN/kIhzHl+DM8YQQUtAcZfrJV1FrBQlNZ
         A1dTIiqG5tVxTY57MCaEDfMbYdaL3VygQjxWoo5WGMYbFdcxd7drxzHIR06AtZE8gI1E
         8k9lGpxSyP3RePlOAOupo83wCChfshVp2MSbfpSJNSEiSlW1C5C/uGzhIwku1NOyeM/8
         81aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687557323; x=1690149323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNHvy2FZDK77FbGlvskF8mraHXZccLrDtu5C69OuJYA=;
        b=fYOVfxfKggFYRAcBWxMbW+Y/mOxacb4HRvo2kkG4m9nodTc+8mC0+gOOXxz6pPSQ1A
         ykEeyhvkQRt9pEKnf+r3RyLSHZTrq8WdbVtOBlFXM+eBaxeHpIwLW6tB/s4i7xQHRgeS
         5gTXEOHlRLt69k6qX/urErj+wgSJnNToHLq91MVZlEQXOyKe9H4jNftVsUPWjEC0s/ov
         gVJco7Kx6CIdANEggCStlTfODw8f2udhud08a5t1I+uaXKIByXgOXN3LHL8c/ohOm9RP
         NJ8nqmEpYFq3oNbg7X0P/gBi//xHiJmLFPSutICpJdrOVs9Gme7O0qwuZnb6Zp8M06tq
         X3QA==
X-Gm-Message-State: AC+VfDwcbffcdZ2N673h0Vv7ZamDkntdjX9lV1tB33T9eLYciXhcVRO2
	aTRjFkCPBbKYWDQ13IMXh683c81BYga3GGF9utQ=
X-Google-Smtp-Source: ACHHUZ5lgcrMxcbzz2QqkoO4lheLirdPHjlH+xVr88x8NIHtCI8mbAiksDSA4sTOAdJqYvdfsqKfYPcwR8CQQkUjUOs=
X-Received: by 2002:a7b:c5d8:0:b0:3f1:789d:ad32 with SMTP id
 n24-20020a7bc5d8000000b003f1789dad32mr23556933wmk.11.1687557322879; Fri, 23
 Jun 2023 14:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623141546.3751-1-laoar.shao@gmail.com> <20230623141546.3751-10-laoar.shao@gmail.com>
In-Reply-To: <20230623141546.3751-10-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 14:55:10 -0700
Message-ID: <CAEf4Bzadyzhncvqv85W=tF+EZLjnUww_ZRCAr6mf-aL5p9P1SA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 09/11] bpf: Support ->fill_link_info for perf_event
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 7:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> By introducing support for ->fill_link_info to the perf_event link, users
> gain the ability to inspect it using `bpftool link show`. While the curre=
nt
> approach involves accessing this information via `bpftool perf show`,
> consolidating link information for all link types in one place offers
> greater convenience. Additionally, this patch extends support to the
> generic perf event, which is not currently accommodated by
> `bpftool perf show`. While only the perf type and config are exposed to
> userspace, other attributes such as sample_period and sample_freq are
> ignored. It's important to note that if kptr_restrict is not permitted, t=
he
> probed address will not be exposed, maintaining security measures.
>
> A new enum bpf_perf_event_type is introduced to help the user understand
> which struct is relevant.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/uapi/linux/bpf.h       |  35 +++++++++++++
>  kernel/bpf/syscall.c           | 115 +++++++++++++++++++++++++++++++++++=
++++++
>  tools/include/uapi/linux/bpf.h |  35 +++++++++++++
>  3 files changed, 185 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 23691ea..1c579d5 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1056,6 +1056,14 @@ enum bpf_link_type {
>         MAX_BPF_LINK_TYPE,
>  };
>
> +enum bpf_perf_event_type {
> +       BPF_PERF_EVENT_UNSPEC =3D 0,
> +       BPF_PERF_EVENT_UPROBE =3D 1,
> +       BPF_PERF_EVENT_KPROBE =3D 2,
> +       BPF_PERF_EVENT_TRACEPOINT =3D 3,
> +       BPF_PERF_EVENT_EVENT =3D 4,
> +};
> +
>  /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
>   *
>   * NONE(default): No further bpf programs allowed in the subtree.
> @@ -6443,6 +6451,33 @@ struct bpf_link_info {
>                         __u32 count;
>                         __u32 flags;
>                 } kprobe_multi;
> +               struct {
> +                       __u32 type; /* enum bpf_perf_event_type */
> +                       __u32 :32;
> +                       union {
> +                               struct {
> +                                       __aligned_u64 file_name; /* in/ou=
t */
> +                                       __u32 name_len;
> +                                       __u32 offset;/* offset from file_=
name */
> +                                       __u32 flags;
> +                               } uprobe; /* BPF_PERF_EVENT_UPROBE */
> +                               struct {
> +                                       __aligned_u64 func_name; /* in/ou=
t */
> +                                       __u32 name_len;
> +                                       __u32 offset;/* offset from func_=
name */
> +                                       __u64 addr;
> +                                       __u32 flags;
> +                               } kprobe; /* BPF_PERF_EVENT_KPROBE */
> +                               struct {
> +                                       __aligned_u64 tp_name;   /* in/ou=
t */
> +                                       __u32 name_len;
> +                               } tracepoint; /* BPF_PERF_EVENT_TRACEPOIN=
T */
> +                               struct {
> +                                       __u64 config;
> +                                       __u32 type;
> +                               } event; /* BPF_PERF_EVENT_EVENT */
> +                       };
> +               } perf_event;
>         };
>  } __attribute__((aligned(8)));
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c863d39..02dad3c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3394,9 +3394,124 @@ static int bpf_perf_link_fill_common(const struct=
 perf_event *event,
>         return 0;
>  }
>
> +#ifdef CONFIG_KPROBE_EVENTS
> +static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
> +                                    struct bpf_link_info *info)
> +{
> +       char __user *uname;
> +       u64 addr, offset;
> +       u32 ulen, type;
> +       int err;
> +
> +       uname =3D u64_to_user_ptr(info->perf_event.kprobe.func_name);
> +       ulen =3D info->perf_event.kprobe.name_len;
> +       info->perf_event.type =3D BPF_PERF_EVENT_KPROBE;
> +       err =3D bpf_perf_link_fill_common(event, uname, ulen, &offset, &a=
ddr,
> +                                       &type);
> +       if (err)
> +               return err;
> +
> +       info->perf_event.kprobe.offset =3D offset;
> +       if (type =3D=3D BPF_FD_TYPE_KRETPROBE)
> +               info->perf_event.kprobe.flags =3D 1;

hm... ok, sorry, I didn't realize that these flags are not part of
UAPI. I don't think just randomly defining 1 to mean retprobe is a
good approach. Let's drop flags if there are actually no flags.

How about in addition to BPF_PERF_EVENT_UPROBE add
BPF_PERF_EVENT_URETPROBE, and for BPF_PERF_EVENT_KPROBE add also
BPF_PERF_EVENT_KRETPROBE. They will share respective perf_event.uprobe
and perf_event.kprobe sections in bpf_link_info.

It seems consistent with what we did for bpf_task_fd_type enum.

> +       if (!kallsyms_show_value(current_cred()))
> +               return 0;
> +       info->perf_event.kprobe.addr =3D addr;
> +       return 0;
> +}
> +#endif
> +

[...]

