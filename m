Return-Path: <bpf+bounces-57611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7553AAAD345
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 04:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7206798380E
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DF71922DD;
	Wed,  7 May 2025 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWDR+lM8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158CBA38;
	Wed,  7 May 2025 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746584812; cv=none; b=FBHV+Yfb9VIWzvZnVHkj0h9RUVWCHjrbDna4wLdt742zbPxMfGZxnaR/8O3B0e6rs56Qsedkb87yB2gGcI8s3+WhtsK5rLCGzjp9ckiMPx7LpXcUZidQkvSph03Fz3JximSqX60ziRxszFC9oXcT7+HK9aFuOD5KKMNBqQ3aCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746584812; c=relaxed/simple;
	bh=T9tRu5SD300+EflneLEIAzFh5F8Y1bienABnSapwQeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyrNFcy/JdLOHbp5o3GIjqfjkutHdQsEiB25ILSVubTjrlLm7Wdu5XgCNmZC6Q707gQN4bryOMemHg2L+vXFGX6m14/K1qBI7W2aaKqS1yyx8U2h7r5gFE2+5RO7+WkpViE6Um9oxF0Yfsshxp2jvw893GfneWqZWFVegX4kK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWDR+lM8; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fb83e137so61329116d6.0;
        Tue, 06 May 2025 19:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746584810; x=1747189610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpWGvheQhS+DNg7fxr9VaJH2DOJjS8jMhgJEonuQaUs=;
        b=fWDR+lM8PncwLl1kEWKgIMMUjFQoA1LLJOj+MnlDW3WUvLnkKc5QIEcV9EN7oxa1mS
         hzbpa3wwiH8H2eLPaRRUrMjS/yJtSMde3J1QQ/jQdNAeLWVzePPRY9v0POAM7uRG89EX
         EFbLavNYfKGvXdV0QCL3YEJmuiGCjCCB/CKSRzXmnyNMYYA1OL4/m3oeKOIRLH5d3MpF
         FURLIE5osbGeBt5ndubEOnNe/pz+8sg9XVfFeeh+cOooQfw2ldG2rquJF2M874ryMLsJ
         qYjsAXN4iLGgpsACK0u1ImRH4ZPFb0Ah2nwS85XUeWjXYZbhw30tIvTgZEmkWkbz8BOJ
         flwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746584810; x=1747189610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpWGvheQhS+DNg7fxr9VaJH2DOJjS8jMhgJEonuQaUs=;
        b=k9y4I3wnPQd4RbBxt1tpXPo96XolpcT2e1ZyH3MUATfd5wao8F/OfvlUPHBl9htNej
         VEK7F5LqxLqplm0fD5s5RhB2am9f3NApH8+srDp+yniLaQmzWNIdaJmHMOE7Q6x/8KcQ
         zog/AMCUqWMU/wdC3AVlH1RyYugTLpty41JTH/s1u8/scHaRXWSE3++i7mnLpSONk0G1
         lCcmXtDhCI2bVtpDfvZnPjkDQ5e4H0bopvoEbILYtQcJlgNV+l/WjaSEoH+5FdZDWjqI
         WL3YfdjNfv4feDySSr9byq85GcgLhoP8fxO1dY3W6JZaNobsCb89DvMYENYdcRrf+2S8
         yRrA==
X-Forwarded-Encrypted: i=1; AJvYcCVLm+JT4xoz6jwAYuexDETHpdyMd9nMZdTCThH2PV8dMgjIocnSJR9CXIlk0gQcS5mJF1fZh7BTkqZhoHnojdTxSQ==@vger.kernel.org, AJvYcCW+OvnQu0uSiyy0IGBQMEcKeYi7A3tXqWXWWy2aINhY214slb+HPtZ6ZECs/vKo6PvfQ/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqdBu8/dZzaVvuVr0Ovflfq45XydBElko/imGUla/FgVruDmg
	iRdTnu3qzxa8o1ElCH5DQMLU8u3T6LQFvvsL+TxlTK8DzlGWVPZVqWCAjf9VxMOoERlOEnVV040
	+8zec5DAVyr1azXPoDduPf8R8j8w=
X-Gm-Gg: ASbGnct8wKMSrs8K7twDRKtSN7LAlJukSX7DPh4b1WmvKAf7ENQeBZl7DCm5wMqmloq
	iliKAyfBZOZQG9pSGfuYzQTfFF2KzEN3P32gUwebgt/zVufFHEPyNiLTRQ2/pUI/lb6uX/ZKiFP
	1uafs/MftnO0Z05lNpaLC1ix8=
X-Google-Smtp-Source: AGHT+IHck3whkXJkexNBhCky/liPLCcdzr0pwds9wgG7c8v/oMOnB4eS5sc35Hf3le2ntF8Tk3v3wdgBdYwpEm3QHKY=
X-Received: by 2002:a05:6214:f05:b0:6f5:436:9e46 with SMTP id
 6a1803df08f44-6f5429fc37amr26406666d6.15.1746584809795; Tue, 06 May 2025
 19:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506135727.3977467-1-jolsa@kernel.org> <20250506135727.3977467-3-jolsa@kernel.org>
In-Reply-To: <20250506135727.3977467-3-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 7 May 2025 10:26:13 +0800
X-Gm-Features: ATxdqUGqu4CSpwD4XlH84XS6zttaYkOi3zAYlyMUh_MeHJm9kLB5LYfq_ultkUw
Message-ID: <CALOAHbAWHz_64QHXEaiRk1xaCQDU77b7EwY3dpkPrSyNYxcayw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add link info test for
 ref_ctr_offset retrieval
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 9:57=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding link info test for ref_ctr_offset retrieval for both
> uprobe and uretprobe probes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

LGTM
Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  .../selftests/bpf/prog_tests/fill_link_info.c  | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> index e59af2aa6601..e40114620751 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -37,6 +37,7 @@ static noinline void uprobe_func(void)
>  static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, =
long addr,
>                                  ssize_t offset, ssize_t entry_offset)
>  {
> +       ssize_t ref_ctr_offset =3D entry_offset /* ref_ctr_offset for upr=
obes */;
>         struct bpf_link_info info;
>         __u32 len =3D sizeof(info);
>         char buf[PATH_MAX];
> @@ -97,6 +98,7 @@ static int verify_perf_link_info(int fd, enum bpf_perf_=
event_type type, long add
>         case BPF_PERF_EVENT_UPROBE:
>         case BPF_PERF_EVENT_URETPROBE:
>                 ASSERT_EQ(info.perf_event.uprobe.offset, offset, "uprobe_=
offset");
> +               ASSERT_EQ(info.perf_event.uprobe.ref_ctr_offset, ref_ctr_=
offset, "uprobe_ref_ctr_offset");
>
>                 ASSERT_EQ(info.perf_event.uprobe.name_len, strlen(UPROBE_=
FILE) + 1,
>                                   "name_len");
> @@ -241,20 +243,32 @@ static void test_uprobe_fill_link_info(struct test_=
fill_link_info *skel,
>                 .retprobe =3D type =3D=3D BPF_PERF_EVENT_URETPROBE,
>                 .bpf_cookie =3D PERF_EVENT_COOKIE,
>         );
> +       const char *sema[1] =3D {
> +               "uprobe_link_info_sema_1",
> +       };
> +       __u64 *ref_ctr_offset;
>         struct bpf_link *link;
>         int link_fd, err;
>
> +       err =3D elf_resolve_syms_offsets("/proc/self/exe", 1, sema,
> +                                      (unsigned long **) &ref_ctr_offset=
, STT_OBJECT);
> +       if (!ASSERT_OK(err, "elf_resolve_syms_offsets_object"))
> +               return;
> +
> +       opts.ref_ctr_offset =3D *ref_ctr_offset;
>         link =3D bpf_program__attach_uprobe_opts(skel->progs.uprobe_run,
>                                                0, /* self pid */
>                                                UPROBE_FILE, uprobe_offset=
,
>                                                &opts);
>         if (!ASSERT_OK_PTR(link, "attach_uprobe"))
> -               return;
> +               goto out;
>
>         link_fd =3D bpf_link__fd(link);
> -       err =3D verify_perf_link_info(link_fd, type, 0, uprobe_offset, 0)=
;
> +       err =3D verify_perf_link_info(link_fd, type, 0, uprobe_offset, *r=
ef_ctr_offset);
>         ASSERT_OK(err, "verify_perf_link_info");
>         bpf_link__destroy(link);
> +out:
> +       free(ref_ctr_offset);
>  }
>
>  static int verify_kmulti_link_info(int fd, bool retprobe, bool has_cooki=
es)
> --
> 2.49.0
>


--=20
Regards
Yafang

