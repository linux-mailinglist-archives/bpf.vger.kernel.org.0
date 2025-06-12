Return-Path: <bpf+bounces-60529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64557AD7D8C
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A7A7A44C2
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA92D8790;
	Thu, 12 Jun 2025 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlEXkERD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222C42E0B69;
	Thu, 12 Jun 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763684; cv=none; b=dZR7CO4+X4g+RrMnn9Qi595N52MoLbE/0IWHAo8d6g8cjRV/NuEdcZkAPDpLLT8r6pqLJWuXP7nAIhsW/I/nOtlyTNZzhITG5t6FZZk66bNMkFzIftgfGfFwpRrTbxcIjzSGSxSyoheztwVEdcVs2g0WxgOSkbo0J+fwO/AXWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763684; c=relaxed/simple;
	bh=Jy/yZ6vY7PvDZK4lQadHfmUekwMYcxQX96889QzZIQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2jII8QDEKL3vEL71ORPeglFpB+ZGGlEwAGPtqcLNdl1s5qAshhYRERdGQyAZA/wZP1niX2+m8dGWwN9ficz8l9B8t4U5UajRn1sQ/oEVA50LhgUxlNcHHcNmhLIK3PmuBnsmNePfaWwrxilvzDNZTi4WD5c/wAB43NJvpJP2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlEXkERD; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-afc857702d1so1126940a12.3;
        Thu, 12 Jun 2025 14:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749763682; x=1750368482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/jVN4FCRaxQzsD77p3tTDX0LkCrSNulyTd+dxPmoWs=;
        b=hlEXkERDGnlO5hJAj58h8iB83f7lSAt20ubWLlSJ+RzKgmP+WYcb8aj4WQX7Anhr8D
         K6UVGGhckU5DPXifrByKFNYMdzkZEVjx8HwQRdLOAtqAHv5+mlb2wThYkLBH0ix+qqc4
         0meuggSEm9hBFXteJxaw8j9HDhcIQ1yzaioMN9BnGWMGu7lr3EYc8VxBrtWxJBA2q0nt
         2UwHlwq3wwP/wER+8sDOYmizDjFmeWC8bjdUXIRtBwx8cvSRlp0ogdEiw+V1VrmIRQI1
         /4AI/qSQ7V4kulSFLvN8CCichI08kwmqLs+s+/+RpLrHlGZ/r5mggkk8gMpyNLKoc40x
         p+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749763682; x=1750368482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/jVN4FCRaxQzsD77p3tTDX0LkCrSNulyTd+dxPmoWs=;
        b=l9ExXP6KeQYQqOdUeVKjBnTRwSbiWUBJw1/2EPzSGqGbWacPISYrhZBrhMzljwXm0Q
         BkQYOcILRkncYrAf08RbpYWZkiqQ3q4BMM7d/FQZ1wXWAcuqejdJ4toZ1OZgMHkkRBXp
         1RnIBuy7jP8vAGqDEyFIBBB1q1Xwr/D6XLwtxzBqYLpYK/AbeBu/ouIVBDtLacIhTTX/
         I2kGcOYZ7TJUwezsVCr1fNNo7YfyyfV0fnbNXgPq3QF9+piaWMA5lNHgPWudyzb0HEUC
         7SkT9ENXtAvNDKTA/N+Vhl5ZFgADHgT13HXZghc1LifSkHhtNdt7SgNBlxZAFHhLMcK4
         Khxg==
X-Forwarded-Encrypted: i=1; AJvYcCUdLSZ8mDNPYiZDR2RkVadGQg70cex18RXOVigRaTCqeZfDpE0wWb+7YwqmJsHo5/ATK8db8ee9IlgLojOvPqE11gJy@vger.kernel.org, AJvYcCWZD2Qxr/8NBtMkWfcOrUdG9619rVMs+D6b7R3xfCOHPTBCt9gOAOa1odpWfiFV/6hm7a4=@vger.kernel.org, AJvYcCX7rDzY9ga6KSwwx3LzNgI6gaUZ9HKDEul3pnTaDwhqQ1o/ouGzSE3mRSkOrV4d8HE+PVU5RXcJEXAU1N2c@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNaUabELnaHwIwpp6sbDjY7NNlAHLL5h9XCdlZo6AkXA2dhpW
	N9e+44oQm5CPczceGhbgaO8cu22yECfyvk/g1hkv2i3iJy3wN7MRGWgNXCjjk23AhjVFFsc1HLb
	LoeIg1uI6gUIUGadq8hhGMUOaBFwCwFQ=
X-Gm-Gg: ASbGncs9H5F68jZgfyPOS4j6ITe6AfNwAD8krJuv7xm0W4enKLmyZwBCq0iVd+B12Yj
	kEdfEnJF1VbxqUq9PQ8HdLzkRgYrKLbTffKgmM8qyX9YKa1WHw/27pcClmo46UFbFsEfYj4wzz2
	GeJLyan/uNa5Cvkm3plOQ9tBVtKqoszzPd8ItNOkrSv3DI+a48wmnJy/rONPM=
X-Google-Smtp-Source: AGHT+IHC71UZaYX6LBU/R1I5IFL9TBpwhd5z6utXefL5DI7/jMlJA/Vzpc/3QGBxhZAe7aFb0RkhQsxJO9pQouTlCgM=
X-Received: by 2002:a05:6a20:7fa3:b0:1ee:e33d:f477 with SMTP id
 adf61e73a8af0-21facbc3112mr701553637.15.1749763682304; Thu, 12 Jun 2025
 14:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612115556.295103-1-chen.dylane@linux.dev>
In-Reply-To: <20250612115556.295103-1-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 14:27:49 -0700
X-Gm-Features: AX0GCFttX6D2UIAegCADzLgzq3nurhhoxgD7HPEfDH6erHkUkFSrCjNJPjF5G_k
Message-ID: <CAEf4BzbxGS85nKK8qAYkSE1HEj7hVshmr9xGsZcP5di0Fu02xQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add show_fdinfo for uprobe_multi
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:56=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Show uprobe_multi link info with fdinfo, the info as follows:
>
> link_type:      uprobe_multi
> link_id:        9
> prog_tag:       e729f789e34a8eca
> prog_id:        39
> type:   uprobe_multi
> func_cnt:       3
> pid:    0
> path:   /home/dylane/bpf/tools/testing/selftests/bpf/test_progs
> offset: 0xa69ed7
> ref_ctr_offset: 0x0
> cookie: 3
> offset: 0xa69ee2
> ref_ctr_offset: 0x0
> cookie: 1
> offset: 0xa69eed
> ref_ctr_offset: 0x0
> cookie: 2
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 48 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 24b94870b50..c4ad82b8fd8 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3157,10 +3157,58 @@ static int bpf_uprobe_multi_link_fill_link_info(c=
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
> +                  "type:\t%s\n"
> +                  "func_cnt:\t%u\n"

it's not really *func* (e.g., for USDTs it's basically guaranteed to
be somewhere inside the function, potentially in many places within
the same function), I'd use generic "uprobe_{cnt,count}"


> +                  "pid:\t%u\n"
> +                  "path:\t%s\n",
> +                  umulti_link->flags =3D=3D BPF_F_UPROBE_MULTI_RETURN ?
> +                                        "uretprobe_multi" : "uprobe_mult=
i",
> +                  umulti_link->cnt,
> +                  umulti_link->task ? task_pid_nr_ns(umulti_link->task,
> +                          task_active_pid_ns(current)) : 0,
> +                  p);
> +
> +       for (int i =3D 0; i < umulti_link->cnt; i++) {
> +               seq_printf(seq,
> +                          "offset:\t%#llx\n"
> +                          "ref_ctr_offset:\t%#lx\n"
> +                          "cookie:\t%llu\n",
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

