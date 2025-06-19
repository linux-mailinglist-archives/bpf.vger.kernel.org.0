Return-Path: <bpf+bounces-61021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E16ADFB00
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 03:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BADFD17C8B2
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 01:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11F921D3E2;
	Thu, 19 Jun 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLm3gj3z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37142A1BA;
	Thu, 19 Jun 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297633; cv=none; b=d2dP3G70CgfepwdrIQvabgHQ0V7FDI3Re92EIQEwsmKxvrcsHV2XQJtssi3X+JyBuFta4rJuVDZDr5ZsACRZnt9dTjYpecjil3V5nIHTZP9IhrGBXqaGzEJm549ISFwRBXVR8LpOwu3xB1pjCc2vVkfV+uMYU9OMLZDqH8+1vJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297633; c=relaxed/simple;
	bh=L2knx86OQal9XYONCL4sc+TIQOIP3Hzk4meZfCXWWz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIOoknPmRLfEhnrAs6bnNNeMbaElXh3n0qL442TOaWGR4uQSuEQ7Ab4c1TtppoOR8n2PaIqqBgQvhNKe/15FK8YXNXvbZ3VKgbhX5CnZBFja24v/abvFHPzPicMdEpArsXIhvBVOMZEF3jH/UCcEdAPzN0/kXFCH9NBA6FckLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLm3gj3z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cfb79177so1250795e9.0;
        Wed, 18 Jun 2025 18:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750297630; x=1750902430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ij91U4X4EWAUKBdWNI59qUxi343hUgQqe3atlrfEA4=;
        b=nLm3gj3zJQl6L+VFBu9ftUdMRgi5Yed8QlBvorEiyXlUJhsyFyCvaVx5uWe1GrbXj9
         lKoud3zJ0zLrXmiT1ktVccV1mtUdXFTlfAC+YcRQ90pdfTzSeyErbkD3G+PXilblwtLX
         A5MoL19gmAfxU7r0XVbzShSOSpwdiEyymCWnLoIdFLZHCVOcKqEf7s82lN2cL6i8L9Ok
         ym2ChImxFOAVnJ/JUD3dsH7MuY50bhvvk2c5YP9GpSxsFT7i+3wYr1qPipw5PTOjnQeW
         5PXEmvvfCyCU/lrVsu8O6LvWCdz5FEYHyKEo1/IZB0GOALDjT9THqf8b8OXcoker+ZWw
         gTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750297630; x=1750902430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ij91U4X4EWAUKBdWNI59qUxi343hUgQqe3atlrfEA4=;
        b=moRm6sS/pC1dalS/pOXcCqcib0/oz8UzfsQspMspXUS6/yUsbUrZH7StTi0zGvR1RQ
         HWHsSYEIbApGe+8QAwjbrtV/ztgwgbwsLD0ILjzIbHaqPMqbHBTKaejQFi3ZavjQ3r7q
         QzF4+Pe8DzSzsjxw7BTgKKhNSdlUCZdbmI2i/pnLgPDCsFDbybucRhrdX6HHxHG9+86Q
         PM7Ygc4OdOHq0GInG2YEZR7Dwzcz9WEgFy95uIUB+hWrWIu4Sk8IkFk+gvzLtkw4C4XP
         234jZxKPUQ2czcZH12w4bjeJ06Pn2atQEA9N6Uo5sCdIKCJRCrzul/LRgJj1b9vdX5wx
         q4rA==
X-Forwarded-Encrypted: i=1; AJvYcCVFlM++Mf70RAOC/NlR9ANLn29D9VV4uIk9g+0lka7mqiNGQyZ3cg1etto66Q7HtOcE7hU=@vger.kernel.org, AJvYcCX47XaTq5kznMRpFpPH2QWZqgWJ8c9Vmd9zT5F6L+kwrmPDakHbYRmp+YfqmoudURcEb36rX6ONvhGK+7tV094gJgpQ@vger.kernel.org, AJvYcCXKtPFCxCs2Vb8wlDPJhSjP6ELLiw9J0XMIuv/R1lAXJGSxY7Mxp941hyHjEPy50qdz3y7eeikQRO4wDaPH@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+ZDQIqUlrxeR/pzJaqfRmC/3OIn+RtxE6HjzriTFay35yeBf
	0LeseVcQuOR6BHvREc0IN1yhhYGuQfqgzArhwnlbFX9hWcXUvh+q8tdrGZaW9iyI3pW1DDo+dAp
	lMaFeMYiWvhfVJ9HUJUyCFFw5Y3XQGpc=
X-Gm-Gg: ASbGncukCwu4h/iP85bgonPKfbdjpB5PuCqYNA51ixvxv6yyxNCQhTFs4umgsVgEu5O
	VOX+CXYqUNlHXwOvvlBzmVzu6ENNFCAGLgpfGKiXG/t+HlZlpJ554v5+kypiU1tH9AEPUxtj8X/
	VityueUnM0zdVYUiINE/EDJQkcL/+nrIHmVAoaxeEcH6FAV7viDQWR4o6k5ivYkgTCfK/hRj6a
X-Google-Smtp-Source: AGHT+IG2AmEqikm1qvA0RevRw7p4TlVqDQPzSrbP0KQ0SvsyLwz3eYX++EPeknhtKepln57fyxGIhPWQvrkz48gQCgg=
X-Received: by 2002:a05:600c:1e1a:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-453501b41d8mr122650995e9.13.1750297629958; Wed, 18 Jun 2025
 18:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616130233.451439-1-chen.dylane@linux.dev> <20250616130233.451439-2-chen.dylane@linux.dev>
In-Reply-To: <20250616130233.451439-2-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 18:46:58 -0700
X-Gm-Features: Ac12FXwy_GewLg35jF0VBUl4jY7PzBERUzs9sxbsB_bcuvlfJNZYNNXGe7Gr65U
Message-ID: <CAADnVQ+hT6nCGoR5a0Z+52SrJzO9-ReBRds23mBfrG3SbwGFdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:03=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Show kprobe_multi link info with fdinfo, the info as follows:
>
> link_type:      kprobe_multi
> link_id:        1
> prog_tag:       a15b7646cb7f3322
> prog_id:        21
> type:   kprobe_multi
> kprobe_cnt:     8
> missed: 0
> cookie           func
> 1                bpf_fentry_test1
> 7                bpf_fentry_test2
> 2                bpf_fentry_test3
> 3                bpf_fentry_test4
> 4                bpf_fentry_test5
> 5                bpf_fentry_test6
> 6                bpf_fentry_test7
> 8                bpf_fentry_test8
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2d422f897ac..fcf19e233b5 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2623,10 +2623,42 @@ static int bpf_kprobe_multi_link_fill_link_info(c=
onst struct bpf_link *link,
>         return err;
>  }
>
> +#ifdef CONFIG_PROC_FS
> +static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
> +                                        struct seq_file *seq)
> +{
> +       struct bpf_kprobe_multi_link *kmulti_link;
> +       char sym[KSYM_NAME_LEN];
> +
> +       kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link, =
link);
> +
> +       seq_printf(seq,
> +                  "type:\t%s\n"
> +                  "kprobe_cnt:\t%u\n"
> +                  "missed:\t%lu\n",
> +                  kmulti_link->flags =3D=3D BPF_F_KPROBE_MULTI_RETURN ? =
"kretprobe_multi" :
> +                                        "kprobe_multi",
> +                  kmulti_link->cnt,
> +                  kmulti_link->fp.nmissed);
> +
> +       seq_printf(seq, "%-16s %-16s\n", "cookie", "func");
> +       for (int i =3D 0; i < kmulti_link->cnt; i++) {
> +               sprint_symbol_no_offset(sym, kmulti_link->addrs[i]);
> +               seq_printf(seq,
> +                          "%-16llu %-16s\n",
> +                          kmulti_link->cookies[i],
> +                          sym);

Why call sprint_symbol_no_offset() directly ?
%pB is fine.
+off doesn't disclose anything.

pw-bot: cr

