Return-Path: <bpf+bounces-33687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FFD9249FA
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39BB1C22A03
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDDC205E07;
	Tue,  2 Jul 2024 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYbU5oeU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170317EEE7;
	Tue,  2 Jul 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956092; cv=none; b=D0uASB1W27zj7hnK2gzAAKOkxs7v39VXhZ5+7da3xDKcHve4WS7+eyJItAhOh5KO910TwJn9rSgwfz3xq/1lidRJ5EmMbjC2oCOxDrMMQmT6/PV8j0fKX/8LHht+NzJ5O7c5P/5jDSTsNm3nxZkxI5EjokohYy9O1ZfHv3otP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956092; c=relaxed/simple;
	bh=pjY9q7p++zS/H2NWRf3PwR6JvPpZA4K0nI+XHDLu7n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvBHNKdIobXWlIppEhPRBYg61jFfaNSWbNLN1Gmz3Mabe1RzUhas8oIbsJ3vw2zyGAdCnE9mIJaPuxbtHOX+1/ZyBbmqknuZ3na41+ZHsDrTBHzDcpeMcdt+t37iKm9BONaYoDpE4iPIJZZcW41IgH8WeqzpyUdQhaOnfQ34G0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYbU5oeU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a724b3a32d2so543751966b.2;
        Tue, 02 Jul 2024 14:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719956089; x=1720560889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNIEBN48BUarwjdlHvfFRLjDjXUEDIAJ8YA1P/t4Ao4=;
        b=gYbU5oeUu4dz/AiRKVvO/24bIo+pZ6reLxJr0iwjiVcbP5cNHHxTahQT4dJL+y90PM
         cUrOUmvLWvV4H34IHDsQ0eB8RNiWv1H2yyOPD3Iry30DClulDnLOJJCTwpUobL26CFcz
         s+0Z++FaYyxq81CT7BB/tPIJGLggx+mq+1iISKySbGyjhQ4qsSBSE24osgU/lzN+CvJC
         Wl7JOkfy+bzQuqNIYlM6m8ZRp+6vyJiGjlv7nNhczABlrqYSgKzKoIFdv/QQbshjxeAV
         Uphr1mBSrQH8WqZcGuDqLjzznZR1Bxt5mXGArpseUIGtjEDXuxHqPe8PB2n56hnZBc3L
         Eo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719956089; x=1720560889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNIEBN48BUarwjdlHvfFRLjDjXUEDIAJ8YA1P/t4Ao4=;
        b=PaPG8GIVe0V1JIGxPsB6P+BAsOUQPJK6D6Yk8X06ERwV79D6QpfKyzKOg+gGuHHxl8
         jSSxZDalmBvs4SH+OLendpKBnsfqAqa87UGj1b4gLBXIwAvsxMp08SUiIaGrvsXdWAYK
         1tAEz20EK6/wBMoAkZd6NpgNUHtMelFBFlLLRc3C1hnoa1vP02zwpL+7tF2A4+/N0X8f
         30NAKDpZiVYm6IQjJzSTF12EL+ovOHYjeiwfm3E641X0DHo2eg6qGjXHO/5lZ+B4zhe/
         cq+ePezyc2Qk/o8pSIjJmuHibNnm9LXUwgMm7Uqi9VnRcDmvot5Tmof8fT19QRxz/pqh
         IRmA==
X-Forwarded-Encrypted: i=1; AJvYcCX5VgNwKEjkqkB1hhY9q7ygjCEQh4IyYFKaWzLK7yDraQljkGJ5GHzWCkQbrKD0FD/ZDsi09ebOHDvuIEkLQTkJiCWogwTth9iPphD9iHrPD4aXiksysOkSocNV91LBZrhW977cFgK0ABe+oQr6G23uHKtu6AuGmHIbckLsjo1tyGk7z0sM
X-Gm-Message-State: AOJu0YxhcKkND3NazWpWvXBGyDzxfzkJ/g1Bblwbd39xf6LDkI4oGOw/
	97rpizDRF5NUsJG0vjwywVF6PmyJELcYjrT7yoFU4AHC8uQgrcrlJ/6ngY/3wwW62PpBIbCagVp
	iYHeNAL9HrkNZ3RTKhPq2QXFPnpw=
X-Google-Smtp-Source: AGHT+IE67kVdBXP1jdj20qhCLnDStDdU9bC2i3kH1m6wJ2m/bIINIsm8LnxomXIX/xLJULhRjCumndLG1zughsNgUz4=
X-Received: by 2002:a17:907:845:b0:a75:2387:7801 with SMTP id
 a640c23a62f3a-a752387794bmr522579366b.61.1719956089136; Tue, 02 Jul 2024
 14:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-5-jolsa@kernel.org>
In-Reply-To: <20240701164115.723677-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:34:34 -0700
Message-ID: <CAEf4BzYP6zW0Mmi_=J5ng+GiUSJpB1JCg-qai0kp_N+_vestxA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 4/9] libbpf: Add support for uprobe multi
 session attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:42=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach program in uprobe session mode
> with bpf_program__attach_uprobe_multi function.
>
> Adding session bool to bpf_uprobe_multi_opts struct that allows
> to load and attach the bpf program via uprobe session.
> the attachment to create uprobe multi session.
>
> Also adding new program loader section that allows:
>   SEC("uprobe.session/bpf_fentry_test*")
>
> and loads/attaches uprobe program as uprobe session.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/bpf.c    |  1 +
>  tools/lib/bpf/libbpf.c | 50 ++++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.h |  4 +++-
>  3 files changed, 52 insertions(+), 3 deletions(-)
>

[...]

> @@ -9362,6 +9363,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("kprobe.session+",      KPROBE, BPF_TRACE_KPROBE_SESSION,=
 SEC_NONE, attach_kprobe_session),
>         SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
>         SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_NONE, attach_uprobe_multi),
> +       SEC_DEF("uprobe.session+",      KPROBE, BPF_TRACE_UPROBE_SESSION,=
 SEC_NONE, attach_uprobe_session),

sleepable ones as well?

>         SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
>         SEC_DEF("uretprobe.multi.s+",   KPROBE, BPF_TRACE_UPROBE_MULTI, S=
EC_SLEEPABLE, attach_uprobe_multi),
>         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksysc=
all),
> @@ -11698,6 +11700,40 @@ static int attach_uprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>         return ret;
>  }
>
> +static int attach_uprobe_session(const struct bpf_program *prog, long co=
okie, struct bpf_link **link)
> +{
> +       char *binary_path =3D NULL, *func_name =3D NULL;
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
> +               .session =3D true,
> +       );

nit: keep a single line?

> +       int n, ret =3D -EINVAL;
> +       const char *spec;
> +
> +       *link =3D NULL;
> +
> +       spec =3D prog->sec_name + sizeof("uprobe.session/") - 1;
> +       n =3D sscanf(spec, "%m[^:]:%m[^\n]",
> +                  &binary_path, &func_name);

single line, wrapping lines is a necessary evil, please

[...]

