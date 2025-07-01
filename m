Return-Path: <bpf+bounces-62008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969F3AF0508
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242C7171A34
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9D82FE370;
	Tue,  1 Jul 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/K2hnVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98172EFDBC;
	Tue,  1 Jul 2025 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402393; cv=none; b=XDEt4BjWaxcvFHj20VKTzwRaJBPFgepA7Y0Uahpn8Flji9/sDvE070LqyT+4Sx8CYTCBJJWEME/kt5SrLeoDRd+oTmujbOgY0e57PBsqAOripDhfBKt5TxFyMTM9ks7JSe/7NvcKXcZ+CXs2D0e9IA3FWtbG45470CD03cINx/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402393; c=relaxed/simple;
	bh=KvEAW9ogBRBHR5i+dsQB56CXTAnYOE98VGUFrR9TpVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNlyvuSWXndpx1pVls+9vvJy0JvU5JI9iuItw6QtOwMD5mXsAgfTAD6MSTvv+GEjMAlW4pHHb/EF+ognb748Yj+oomRRU8q90X/ZfwjCJQpzUQrqMd4RbBhpSKc4moQ6JqZVY7YdgB4DrNYK++1r+gdmFDBQmhOfxfyRuuzfcLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/K2hnVN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso35793825e9.0;
        Tue, 01 Jul 2025 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751402390; x=1752007190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XOX/9hw+RJEcjJnWmrVCmdr6SZDbQ2g17tUexPr8iU=;
        b=e/K2hnVNcIF7MNtzZsLhOCPAIDMwZlgZDOGk686mVXQk9pR6blNe90XQcPUJFAU4c7
         lOzfEnKLhdvXEOo6DxQ/YxAiJh9aeuNAJau+o15rBmdLq5OKzkZx87UrRKvltoTTVF3o
         HLPUm3M4JLF4XQkdAlG+FmqUWWzPFHB+ocYHCSZ07Gquu1Mw35hHPUJ4vPrRchzv2giX
         9flmkBxr2FHffi8aK20AtdXKxEWv+Ah7WiNGD7lU0VolTPIx29Des1cHesLQg9EL/CRS
         z2TYwibqSbYdgL9GldRRReafKAKqHtV/dG/D2po4jV2AoOF3xorw+uxKdpHpKXYB0249
         Fufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751402390; x=1752007190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XOX/9hw+RJEcjJnWmrVCmdr6SZDbQ2g17tUexPr8iU=;
        b=N/SUR8FkYjH5R5ZQqvpUTEPJB7eFNCGrRLxKB7QU8NOgtRk73jlOuhWFWI9jiIy6Lr
         T4FUjJI32ML7Ped7RncEyBD4BMbsXNUmdR4qxg16KzTLYvddofhaRQCPu7eOuKStDAJc
         ZBeKJdFj8ZWvlVQtVc8WB7cBUC8sTbj4N+20T3qitGB9A3AF7XOnqzegEpXb8ia/9yLB
         sXeNntMI87ZpF1qPDxtQ2bIsAqLMTU2Jt0HLm5/hj9UQzWj8Z2RUuR9hqU58Z+CwuJBr
         sBFVHMqIN+oFIMwGyT+BLULOACw5qaPop3KdYttiSRrN32M0IWk9pFaqr/YUQ4IviXrU
         N6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2GSw26wWfiJ5CaDLaOlV91BaK7dmhdVa2nL/xQVvSaeCEhEzdXYCrdA05CzfLNlGPPBU=@vger.kernel.org, AJvYcCUMNV8t6wTt/7fhh0vL5jOtDhkG7aY0HslDN2aXPykyg7DJQPkADxG7u5uS0nvb8+5ztlm8Fytn0zvZmH6j@vger.kernel.org, AJvYcCXk3fbuJMV/vaicSrVVoybtUt0qB1oGoPbW8/3oIiM9SKFnHScp6avp45zq9w8DqNldX4y0jkxmsqK/hZDoioFBwqJ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8E4jJRu9axxkDyiTfXT3mvfm8MJixrYj4f5rkw3Uytct81grX
	PqKNbulzI19qXdT8UrSy/b+zps8C8LIePNWEw+fuO877Z3zmNceQj8SvM+7NaRTWb3wlXfydeIb
	U+W0XFgk2pADHU2xncuhasCZF3QUcnXs=
X-Gm-Gg: ASbGnctvjw6G2A4F1ADEWDc5VMEeYEpSoxh7LXir0WJ31XEr/gykwoVQGaZAwBt6bfq
	qc4324fMaH5uBBVPDlSML6S2BegT3z3o3Nlp4vPbiSff426mMuy1Kta7iwH6FSFs7oNxw/nklz1
	vNJYI7CL6nzeq5G7GiA/IKEk0uKhwwTDrZWfHQmfRjAU0vUGeDXzq6AoFT47A=
X-Google-Smtp-Source: AGHT+IFkD3VKzjNhJyz1lQhSkSumIJYVNMubG2GpXJQWVqc+L8fe8lkb2VZPKQSY1cwv6eJm5RePzDUyG2wS/o0W3tM=
X-Received: by 2002:a05:600c:4688:b0:453:81a:2f3f with SMTP id
 5b1f17b1804b1-454a372df70mr5999675e9.30.1751402389960; Tue, 01 Jul 2025
 13:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627082252.431209-1-chen.dylane@linux.dev>
In-Reply-To: <20250627082252.431209-1-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Jul 2025 13:39:36 -0700
X-Gm-Features: Ac12FXxZHD5m2DWz8uVFdq-SqPDe-6gXNykWOwpyJs2uf2haLluZbHq7yK9bv0M
Message-ID: <CAADnVQLWZH0sQk6ni-AWb+SRJ+H_sE=Gvwn3wdu+UC=mJiPPrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Show precise link_type for
 {uprobe,kprobe}_multi fdinfo
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 1:23=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Alexei suggested, 'link_type' can be more precise and differentiate
> for human in fdinfo. In fact BPF_LINK_TYPE_KPROBE_MULTI includes
> kretprobe_multi type, the same as BPF_LINK_TYPE_UPROBE_MULTI, so we
> can show it more concretely.
>
> link_type:      kprobe_multi
> link_id:        1
> prog_tag:       d2b307e915f0dd37
> ...
> link_type:      kretprobe_multi
> link_id:        2
> prog_tag:       ab9ea0545870781d
> ...
> link_type:      uprobe_multi
> link_id:        9
> prog_tag:       e729f789e34a8eca
> ...
> link_type:      uretprobe_multi
> link_id:        10
> prog_tag:       7db356c03e61a4d4
>
> As Andrii suggested attach_type can be recorded in bpf_link, there is
> still a 6 byte hole in bpf_link, we can fill the hole with attach_type
> soon.
>
> Co-authored-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/linux/bpf.h      |  1 +
>  kernel/bpf/syscall.c     |  9 ++++++++-
>  kernel/trace/bpf_trace.c | 10 ++++------
>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> Change list:
>   v5 -> v6:
>     - Move flags into bpf_link to get retprobe info
>       directly.(Alexei, Jiri)
>   v5:
>   https://lore.kernel.org/bpf/20250623134342.227347-1-chen.dylane@linux.d=
ev
>
>   v4 -> v5:
>     - Add patch1 to show precise link_type for
>       {uprobe,kprobe}_multi.(Alexei)
>     - patch2,3 just remove type field, which will be showed in
>       link_type
>   v4:
>   https://lore.kernel.org/bpf/20250619034257.70520-1-chen.dylane@linux.de=
v
>
>   v3 -> v4:
>     - use %pS to print func info.(Alexei)
>   v3:
>   https://lore.kernel.org/bpf/20250616130233.451439-1-chen.dylane@linux.d=
ev
>
>   v2 -> v3:
>     - show info in one line for multi events.(Jiri)
>   v2:
>   https://lore.kernel.org/bpf/20250615150514.418581-1-chen.dylane@linux.d=
ev
>
>   v1 -> v2:
>     - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
>     - print func name is more readable and security for kprobe_multi.(Ale=
xei)
>   v1:
>   https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux.d=
ev
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5b25d278409..3d8fecc9b17 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1702,6 +1702,7 @@ struct bpf_link {
>          * link's semantics is determined by target attach hook
>          */
>         bool sleepable;
> +       u32 flags :8;

There is a 7-byte hole here.
Let's use 'u32 flags' right now and optimize later if necessary.

