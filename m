Return-Path: <bpf+bounces-61322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44674AE55F5
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 00:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737E518827E0
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 22:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D6229B0D;
	Mon, 23 Jun 2025 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWDF1rfK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA71F7580;
	Mon, 23 Jun 2025 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716893; cv=none; b=JAR37aLtj2CcgY9BPtZkgYODWB+ja1LQoTVpZ1AMNc9Vtfw+zwRv/4scOG+n129l7QGfxKOsXM8LQCZ2S06t0rY1ksC9rhl5jetw9NxhWwksOsJhIks5L3YXd7tOMIYwIv32kchKEjjBExFpkyGSMtf7wOopM9GYVROkAdcgTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716893; c=relaxed/simple;
	bh=yPDyD6fMQpuu5CzW5qPIS75/fU051H7mV4ultDEVDhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfVpfeqpLXyMPVbUuQCYYOlVHcBxxxqoXfM6XWKGBU6oTSbKt93aL7pgwc6qQPuSz0Uj29p7tFXrf8nSVgvenDPiRVeKTqgkXX0IdfqVjD61aUEy9oozy6n8e/n2iVuHnJ0CBMOrtbO8tdj/GEC/mKhzHfvLukDtgiZsK+HrYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWDF1rfK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so3648830a91.3;
        Mon, 23 Jun 2025 15:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750716891; x=1751321691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1x5DL+ydsBkqWRupjQmi46WjCA1eGrD/jI14c5vbzQ=;
        b=fWDF1rfKhubyxz40+0+RVinpAkB5yU7MAJnLOWAtzTW+PpAZIvauQA8oHJhOspcBJK
         8ZavEdSrtw0Sw8Yzf1GVfsGzftd1erAiWwATEO3u5jfcEagqisodZq/WtleNwvs8tizQ
         4EEaD8n3rKBzhmRsW3/FCXI1yBj3/Mf+Ebkq/Q7qaVwhKgqpm3r1lNsamY+WG1fa6k0B
         gQ77NihqhIwG+GkDRp33jHsFJhAzuwPdkGtqEiE3Wd0L4teBGHFwwag2ycsxtn33BXft
         43Sf0lGKYBIcILU7xElk2zo1a3EddyesANBLFh2kX7Y1jJZSku5cOJ/w2TVE2PpV+iKF
         BEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750716891; x=1751321691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1x5DL+ydsBkqWRupjQmi46WjCA1eGrD/jI14c5vbzQ=;
        b=rsW9t8D6jhCPsA6NU/wNzMsLhFwcY1Vfhl8SKzKJwiUu9RQ1WsMy+JYkOvBAA6BLT8
         NyJsYKo8uAwUENqDChb4mDi/iabrUSVuy1hZhtIbxGp0a6icvVuejgzmC+sWfeJedAWa
         +Oacp2yzDlIt9IsF/lSeqSFtnGtaW74TUNRAl64clcZGu+vaJFP43NxmOFTvQlzAoT+W
         D8S5ZhsPqxipFQQuq+KTNax7bGsCAPRad+bEDq1C8DZeay4x86BDLx0Q/6G8k5cr8zhD
         BDoSVUbMbPgJYkwl84sVuH7MyjTCeoPiBA2G/d4BN6zZdvjHs16vaTdTWRFnsGr0yALW
         A2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCU6ryrZqs0erkbSKZFgk1CIWJpZjNpG3zuzUMGF9s+Ulg0xEO2u35coFESk4MC4E7uXWVo=@vger.kernel.org, AJvYcCW8PcRAAgwp+Wt7xNjtB370rG9fS9QAKOWdmmylCFDx+vi3Uz8ZYaWCPtOiYO2el1PzFJUHb2BkauPuyz1hFxxlepwx@vger.kernel.org, AJvYcCWkWCX/3pdQMPKJqc9UNF07zix9j4Mgsl1dd3vyztJfe/QiAe0vSaa54bmn1bvsXW7h+fa2+rZOG1QBScWh@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhF5i2jZRYFO9MEdWuJ4fZWI4eB/oSccmKV15sD9jPXB4sP1C
	y0TBwnFDqtrsazO+hCuE7uIZwLSL+0QsQZimTFQne6Fyg9bWnZ2HOfAxdZ/i56TDPjnSGwi4jcv
	s2QVYvVmbCIUbduQqLGtpg2l8S8HseeQ=
X-Gm-Gg: ASbGncsg0F0dq6DEMAAT3bOjMOB1DpqMraRmCx6k1dpIG4mUvkd0e7CdAa4YXsym3jg
	54KYDmyGvO5yW1hw1xEgpWhLTgPYlYmiBFel5mxIiwDO1n1D/2Rb4ZIlfaSyZkHD1um9y6Ld4n1
	3rHs12l9TDc+Y06T4S4YNmohIo929kNeus4d3Z8p34r4d+T7hkVClM2/VoMpuuFVcUeJzgKg==
X-Google-Smtp-Source: AGHT+IFDoDhxWxrNXqIJaOmTrHpBS+nETWY9h4SC9l1RgAgLh5moA2BQmQPpHCQo+bG3D5libjRg7iaMqy+XJcwf6XM=
X-Received: by 2002:a17:90b:4b42:b0:311:d670:a0e9 with SMTP id
 98e67ed59e1d1-3159d8c603bmr19744056a91.21.1750716890670; Mon, 23 Jun 2025
 15:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623134342.227347-1-chen.dylane@linux.dev> <20250623134342.227347-2-chen.dylane@linux.dev>
In-Reply-To: <20250623134342.227347-2-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Jun 2025 15:14:38 -0700
X-Gm-Features: AX0GCFsoVaK6eAp65GPDX_6j6F9YUbYSTlGifiy00duSswry1yj84jR3KIGL-6s
Message-ID: <CAEf4BzY2dZ5KgcCH59rrQwZYaDZPt_-p4GHK8zMFP+RNPnNa=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Add show_fdinfo for uprobe_multi
To: Tao Chen <chen.dylane@linux.dev>
Cc: kpsingh@kernel.org, mattbobrowski@google.com, song@kernel.org, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:45=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Show uprobe_multi link info with fdinfo, the info as follows:
>
> link_type:      uprobe_multi
> link_id:        10
> prog_tag:       7db356c03e61a4d4
> prog_id:        42
> uprobe_cnt:     3
> pid:    0
> path:   /home/dylane/bpf/tools/testing/selftests/bpf/test_progs
> offset           ref_ctr_offset   cookie
> 0xa69f13         0x0              2
> 0xa69f1e         0x0              3
> 0xa69f29         0x0              1
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 8ecb1a9f85d..90209dda819 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3171,10 +3171,54 @@ static int bpf_uprobe_multi_link_fill_link_info(c=
onst struct bpf_link *link,
>         return err;
>  }
>
> +#ifdef CONFIG_PROC_FS
> +static void bpf_uprobe_multi_show_fdinfo(const struct bpf_link *link,
> +                                        struct seq_file *seq)
> +{
> +       struct bpf_uprobe_multi_link *umulti_link;
> +       char *p, *buf;
> +
> +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_link, =
link);
> +
> +       buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +       if (!buf)
> +               return;
> +
> +       p =3D d_path(&umulti_link->path, buf, PATH_MAX);
> +       if (IS_ERR(p)) {
> +               kfree(buf);
> +               return;
> +       }
> +
> +       seq_printf(seq,
> +                  "uprobe_cnt:\t%u\n"
> +                  "pid:\t%u\n"
> +                  "path:\t%s\n",
> +                  umulti_link->cnt,
> +                  umulti_link->task ? task_pid_nr_ns(umulti_link->task,
> +                          task_active_pid_ns(current)) : 0,

nit: either keep stuff like this on single line, or if it's too long
or awkward, add a local variable. Formatting it like this is very hard
to follow and looks pretty ugly...

> +                  p);
> +
> +       seq_printf(seq, "%-16s %-16s %-16s\n", "offset", "ref_ctr_offset"=
, "cookie");
> +       for (int i =3D 0; i < umulti_link->cnt; i++) {
> +               seq_printf(seq,
> +                          "%#-16llx %#-16lx %-16llu\n",
> +                          umulti_link->uprobes[i].offset,
> +                          umulti_link->uprobes[i].ref_ctr_offset,
> +                          umulti_link->uprobes[i].cookie);
> +       }
> +
> +       kfree(buf);
> +}
> +#endif
> +
>  static const struct bpf_link_ops bpf_uprobe_multi_link_lops =3D {
>         .release =3D bpf_uprobe_multi_link_release,
>         .dealloc_deferred =3D bpf_uprobe_multi_link_dealloc,
>         .fill_link_info =3D bpf_uprobe_multi_link_fill_link_info,
> +#ifdef CONFIG_PROC_FS
> +       .show_fdinfo =3D bpf_uprobe_multi_show_fdinfo,
> +#endif
>  };
>
>  static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> --
> 2.48.1
>

