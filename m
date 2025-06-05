Return-Path: <bpf+bounces-59786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11946ACF756
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6437D1885C25
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61F727A445;
	Thu,  5 Jun 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co0hf//j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAD225405;
	Thu,  5 Jun 2025 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148932; cv=none; b=YZox5M+3YCPKlgrcfwVh7u7ujJ0dALXaY/0/jJK4lqN5B//qKa0TO1QQoSdk6Rwt0IFlFM8d+PiOM2c25dYDJnVtD5MAXUNnmn3BL9dVnamX5t1XmNDZAz561DxKKeOscKUkG8Tw9UoHz5GS5Z6ncahB/6CiADSTNGHt03JHc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148932; c=relaxed/simple;
	bh=8A1uXNWW2809SvO52PJIvs8C0+8RcTEdczSyPA4VTJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noil+QL8creiGDnn4O0LNWhH9ZSOne4QaQMachGVlzhk/Q/DvG7PnMOfzfkozKidBQoojZWlLvJMFaXDGl6F9K9B/b8c8f3S5RZiHfPkhMcJZ0Sdsh61PdVThFI67hK6zRw0VGk1m61aJnCVGSkQTIXJcBEHrxEwzND9LIW2DRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co0hf//j; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c9907967so1310775b3a.1;
        Thu, 05 Jun 2025 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749148930; x=1749753730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0mxh4Vh4mJ7p/VlQscr8sPVdvImTOagfcs541Xc3GY=;
        b=Co0hf//jrGWWdF1VuHP/8BRZuD1OydJsmpyYR8qTYP2BvsmqQcipPQblQe7U/mDa8Z
         EM1ACunEpku9waKSLVmxapdU6wgnxc3/cp9Gg7bHIUlYWAgbpxwwzuYCNvouuzvTYvKW
         eFBOF+Cg2k/2luOM2mtpBM6KjQ72bqXevluVJZVb7eCYyih/VpBa92a1bqy/Gz+zStua
         qdQ2PaktkP9VQk8f7rFCHT4Wu32AVqeYu9kl0Gq6JjnAriXRywY8Xqmz29jco9gW+QEw
         0jxlDJB2erm3ngGblgVRUwCMJvEqjgLksmW5Pcfbz8tdW5DemL3AbS4O/q8wN3tIsqpe
         73sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749148930; x=1749753730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0mxh4Vh4mJ7p/VlQscr8sPVdvImTOagfcs541Xc3GY=;
        b=QNZ3i7bdiNmISiyzTK/nn90LD+E2l9OLAURH6uj3TQon5XBB2n9u/jqq+HrgKM7pdY
         0EQnbaTJcIEndnTs+ywUSp0QZLvs3LQRy/riv2BgJUWnuTbGmDoLuqRPl+irTbsAvM0u
         YMNDb4828/Oemfk4PBiIprHjBQlF7UgUHngsv9YxDHpIIPKwzhkAUoHq4MX9/YGYBo9O
         sKhG5TmMFU0AXewnU/9Jeh5X2xri9vAu3ULe+c/PrIb1HOy+E0kACaj6BMYLQvhxreKD
         9SFt0lr2kVMcv/HF0HUgQMkJptMlXGKQnER5pjLxDYBOHKIkIABj///qsa4/2kRi7xmR
         WO9A==
X-Forwarded-Encrypted: i=1; AJvYcCWFpW9PoPxHrwanDJpwrcO5/w/9tYduqtgsyVTTojZXVGX6lpRD/u09VM7aoN6jtsjPBKKiYpFo5sF7JDmP@vger.kernel.org, AJvYcCXUwl8sPlfdWBih8FGU2U3lusTBlger1gH72J6NbmN6eojFqyLi2twEfBxfBcJyN+/F3h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9vrCdfe5wqr4e0Yp/L/SSm92OGpWuR82DuxBdin9gM48V2p2
	riEWYrxsDS0g3SyMwr7WA6zuXUc6OS2nHFJbhDZxJxotddxjWXCEmM/AhQcWCUFeOsTOTBBGFFU
	N6hSrkb9hZevxYxtJzz8a4c4VE6k4aqk=
X-Gm-Gg: ASbGncvDTOGC1QhQYoLC1qT2RPBT4loDvO48fwjWLt2mxED7x4wM3Iev3vQBZG9VxJl
	qoHTa2SRzYReJ7pzT1S1eYt9VMc+HuKR0xS71mWl8xzfVN2XGhXXmwqLUkhHO2ojx+rn+xVRaV8
	7oPGrNDtlSQV9xmSzldKQIoZ7vGBfDetQO1ZaeFPo65vMyaR3G
X-Google-Smtp-Source: AGHT+IFqfyYxtIAbk45UebUFLib9TE4AwrdAOQ8dQjfv0i8SmVPLhjpFLEuxtTuvVn3ycy+/MMBp1Wxq/Blh+0YNl+k=
X-Received: by 2002:a05:6a00:1390:b0:737:678d:fb66 with SMTP id
 d2e1a72fcca58-74827e4ebddmr976443b3a.5.1749148929823; Thu, 05 Jun 2025
 11:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604163723.3175258-1-chen.dylane@linux.dev>
In-Reply-To: <20250604163723.3175258-1-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Jun 2025 11:41:57 -0700
X-Gm-Features: AX0GCFs7Ti8oMoMVNO8WJhBo2K6eC9zHWIcD5LPUdthDUVuA-lwdu2IWi7uzBZo
Message-ID: <CAEf4BzasaZYD7y+4Po=K=jBq3Q7JSUMpJ_NSQv7B9=v6fieZ7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add show_fdinfo for perf_event
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 9:37=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wro=
te:
>
> After commit 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event"=
) add
> perf_event info, we can also show the info with the method of cat /proc/[=
fd]/fdinfo.
>
> kprobe fdinfo:
> link_type:      perf
> link_id:        2
> prog_tag:       bcf7977d3b93787c
> prog_id:        18
> name:   bpf_fentry_test1
> offset: 0
> missed: 0
> addr:   ffffffffaea8d134
> event_type:     3
> cookie: 3735928559
>
> uprobe fdinfo:
> link_type:      perf
> link_id:        6
> prog_tag:       bcf7977d3b93787c
> prog_id:        7
> name:   /proc/self/exe
> offset: 6507541
> event_type:     1
> cookie: 3735928559
>
> tracepoint fdinfo:
> link_type:      perf
> link_id:        4
> prog_tag:       bcf7977d3b93787c
> prog_id:        8
> tp_name:        sched_switch
> event_type:     5
> cookie: 3735928559
>
> perf_event fdinfo:
> link_type:      perf
> link_id:        5
> prog_tag:       bcf7977d3b93787c
> prog_id:        9
> type:   1
> config: 2
> event_type:     6
> cookie: 3735928559
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/syscall.c | 126 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9794446bc8..9af54852eb 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3793,6 +3793,35 @@ static int bpf_perf_link_fill_kprobe(const struct =
perf_event *event,
>         info->perf_event.kprobe.cookie =3D event->bpf_cookie;
>         return 0;
>  }
> +
> +static void bpf_perf_link_fdinfo_kprobe(const struct perf_event *event,
> +                                       struct seq_file *seq)
> +{
> +       const char *name;
> +       int err;
> +       u32 prog_id, type;
> +       u64 offset, addr;
> +       unsigned long missed;
> +
> +       err =3D bpf_get_perf_event_info(event, &prog_id, &type, &name,
> +                                     &offset, &addr, &missed);
> +       if (err)
> +               return;
> +
> +       if (type =3D=3D BPF_FD_TYPE_KRETPROBE)
> +               type =3D BPF_PERF_EVENT_KRETPROBE;
> +       else
> +               type =3D BPF_PERF_EVENT_KPROBE;

maybe use "kretprobe" and "kprobe" strings?

> +
> +       seq_printf(seq,
> +                  "name:\t%s\n"
> +                  "offset:\t%llu\n"

llx, hex makes most sense (we had similar discussion within the
context of bpftool reporting)

pw-bot: cr

> +                  "missed:\t%lu\n"
> +                  "addr:\t%llx\n"

ditto, address -> hex

> +                  "event_type:\t%u\n"
> +                  "cookie:\t%llu\n",
> +                  name, offset, missed, addr, type, event->bpf_cookie);
> +}
>  #endif
>
>  #ifdef CONFIG_UPROBE_EVENTS
> @@ -3820,6 +3849,34 @@ static int bpf_perf_link_fill_uprobe(const struct =
perf_event *event,
>         info->perf_event.uprobe.cookie =3D event->bpf_cookie;
>         return 0;
>  }
> +
> +static void bpf_perf_link_fdinfo_uprobe(const struct perf_event *event,
> +                                       struct seq_file *seq)
> +{
> +       const char *name;
> +       int err;
> +       u32 prog_id, type;
> +       u64 offset, addr;
> +       unsigned long missed;
> +
> +       err =3D bpf_get_perf_event_info(event, &prog_id, &type, &name,
> +                                     &offset, &addr, &missed);
> +       if (err)
> +               return;
> +
> +       if (type =3D=3D BPF_FD_TYPE_URETPROBE)
> +               type =3D BPF_PERF_EVENT_URETPROBE;
> +       else
> +               type =3D BPF_PERF_EVENT_UPROBE;

strings, just as above

> +
> +       seq_printf(seq,
> +                  "name:\t%s\n"
> +                  "offset:\t%llu\n"

hex

> +                  "event_type:\t%u\n"
> +                  "cookie:\t%llu\n",
> +                  name, offset, type, event->bpf_cookie);
> +
> +}
>  #endif
>
>  static int bpf_perf_link_fill_probe(const struct perf_event *event,
> @@ -3888,10 +3945,79 @@ static int bpf_perf_link_fill_link_info(const str=
uct bpf_link *link,
>         }
>  }
>
> +static void bpf_perf_event_link_show_fdinfo(const struct perf_event *eve=
nt,
> +                                           struct seq_file *seq)
> +{
> +       seq_printf(seq,
> +                  "type:\t%u\n"
> +                  "config:\t%llu\n"
> +                  "event_type:\t%u\n"

string?

> +                  "cookie:\t%llu\n",
> +                  event->attr.type, event->attr.config,
> +                  BPF_PERF_EVENT_EVENT, event->bpf_cookie);
> +}
> +
> +static void bpf_tracepoint_link_show_fdinfo(const struct perf_event *eve=
nt,
> +                                           struct seq_file *seq)
> +{
> +       int err;
> +       const char *name;
> +       u32 prog_id;
> +
> +       err =3D bpf_get_perf_event_info(event, &prog_id, NULL, &name, NUL=
L,
> +                                     NULL, NULL);
> +       if (err)
> +               return;
> +
> +       seq_printf(seq,
> +                  "tp_name:\t%s\n"
> +                  "event_type:\t%u\n"

string

> +                  "cookie:\t%llu\n",
> +                  name, BPF_PERF_EVENT_TRACEPOINT, event->bpf_cookie);
> +}
> +
> +static void bpf_probe_link_show_fdinfo(const struct perf_event *event,
> +                                      struct seq_file *seq)
> +{
> +#ifdef CONFIG_KPROBE_EVENTS
> +       if (event->tp_event->flags & TRACE_EVENT_FL_KPROBE)
> +               return bpf_perf_link_fdinfo_kprobe(event, seq);
> +#endif
> +
> +#ifdef CONFIG_UPROBE_EVENTS
> +       if (event->tp_event->flags & TRACE_EVENT_FL_UPROBE)
> +               return bpf_perf_link_fdinfo_uprobe(event, seq);
> +#endif
> +}
> +
> +static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
> +                                     struct seq_file *seq)
> +{
> +       struct bpf_perf_link *perf_link;
> +       const struct perf_event *event;
> +
> +       perf_link =3D container_of(link, struct bpf_perf_link, link);
> +       event =3D perf_get_event(perf_link->perf_file);
> +       if (IS_ERR(event))
> +               return;
> +
> +       switch (event->prog->type) {
> +       case BPF_PROG_TYPE_PERF_EVENT:
> +               return bpf_perf_event_link_show_fdinfo(event, seq);
> +       case BPF_PROG_TYPE_TRACEPOINT:
> +               return bpf_tracepoint_link_show_fdinfo(event, seq);
> +       case BPF_PROG_TYPE_KPROBE:
> +               return bpf_probe_link_show_fdinfo(event, seq);
> +       default:
> +               return;
> +       }
> +}
> +
>  static const struct bpf_link_ops bpf_perf_link_lops =3D {
>         .release =3D bpf_perf_link_release,
>         .dealloc =3D bpf_perf_link_dealloc,
>         .fill_link_info =3D bpf_perf_link_fill_link_info,
> +       .show_fdinfo =3D bpf_perf_link_show_fdinfo,
>  };
>
>  static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_p=
rog *prog)
> --
> 2.43.0
>

