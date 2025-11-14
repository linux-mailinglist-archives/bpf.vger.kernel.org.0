Return-Path: <bpf+bounces-74545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8FC5EE6A
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634A73A2C4E
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19992DC773;
	Fri, 14 Nov 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC0M2kIn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B52DA762
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145729; cv=none; b=ebNO7J58gU8whncdMb6a1ZyN/Wz7qeCZVOPskXAfhRmZf8u59eSre5+0IBXfwPA5DWJVIvDeZmVwZyL+/jWuwqtjSnaXSurK80xSl4tvKu66Cd/FgyEmJIgtYaH+ZPpMsg+lFcIF5wO7L4M5P5Qy572s4eVF/R9/IULyamFT0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145729; c=relaxed/simple;
	bh=Yr+QYXSio/Vt6yezILbjQ/kPLtEqHWKN4wAJumxy6qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhXu/TT0AVLXJ86yHk3dB2Ykaikmlc+Od0wWXUNVtpGNOhZAw144Pg9P8t+PRBuxJLQuZQM3Ywp9JQpoM6Sl3jbkHa3zxCXuV4iGDYHEJHuVtymseMKGsDhPC8XsvtQFaiEXwKNmXEHgiYBFxBsQ7knO21SGseFMNZV2j7fLQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC0M2kIn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so1983269f8f.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 10:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763145726; x=1763750526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXikbDMo1y0MhesOpF400bT9rLKaVPJBJqU/w2OePJs=;
        b=MC0M2kIn8tdiRweUAuArxzleG4xIgqXU3xr21TJbY0S78mbKd+rwNBfsw4rBrN0O/a
         zmiJpNqPPmhwiFdy5GFPoZH68RvGM9e2o4MQQxRM5t3akI4RdCYcNNjXWB1KRC9aOLYS
         etepWVrjMSHvr4ryykvL7TXgeucE4bVAAOhfIqGnGe6eMG73TOB4Bo8LfApMQPD1WHKu
         NW+wyaTMN5MYydexMRqTW8q8ARs3X5Q070xd6h0feaokQGw57s80EN371fNt78PTIJoc
         Z1eHjodiAs42sijDHmxib6NZqakxqeaOkWgM+BqLn7yuNcLvvwNWyChlgkQxrImZtvE4
         nFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763145726; x=1763750526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jXikbDMo1y0MhesOpF400bT9rLKaVPJBJqU/w2OePJs=;
        b=wxVSwh6TyVbvY1QtPyM6TsYnufI2/Qb7SbxtiUMbM1rGxotriaFS3PzKq1IodB5XH3
         xt1D+N5POiZcyKqVddTIuggnE+cFoH81UInTG24docHebGxHETjO5CyArRjL6VNqWwzK
         6h6QAXcUxnCJGjf5zn622RnQdBoeSp0Q4MoQ2dRz3FnbE+uMIKBCBETYS6Vf+hxUW+Yw
         7PMcC6C3zTQrdNaE1TPqpcNcX3zvAo1CJgSokSYUXknneub7xt9xGV4YIuNw0UaeOXY4
         BPTUk13YyWKoLjb/qZesfBQYdDdWRGloMINjQ1v5YRYTQnZoMccpg3uveaTGtIJhK0ol
         24XA==
X-Forwarded-Encrypted: i=1; AJvYcCVf9DKcKPapVKM5+w+LjMKHjrDWut8RvfqxlLEC14f+1pZHQTFzidkLhrppKHZCi9PJX4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTq3KCu08wWxuOZ17l1FKXf5YFLCfP8V5xpoFCxJein8hx2Eyn
	/XFn6vI9Pcq5652aDx6sRuRLbrcGeC1ygBvt6KaP+uToMYzRHmoHhuDazuMga71hQKi98Q4kzdz
	78DJgoVGw6zxTpY/67PtohNPWYvCYSJg=
X-Gm-Gg: ASbGncvkryGRCQuLPO7lox/kjmtX96tLet+2kfabg+stqmpQdOlVYsAoVS2tu0z5mfm
	5tFo0qZAIIsJX+MkwM9+Zn0uj/VrC9nrIQtaycmdnI/KT4x8piMNaATkmxacfW1Zp8lk1zJQGM4
	sVDrUrSI5MaYNawd1YOLVOTNawTgq+ZPUuZAYZWoaEPPti4T40ZCaj07laeelluOQ/l0tj0IoRU
	fN5Gtrx54UV3KrAhLRULbfyMwO0s1yJNTu9YnEST0VdPcbuy6gxrsLB9p7MXo51fvU14mcCIuqo
	GJoXtKbKEGrP8on+5OPg/FQns/J6
X-Google-Smtp-Source: AGHT+IEwNUK/Pn1NIOkddN345K3xYtvPkS+urQ1M5vbjd/Sue+SZbGJFokCEzoWcyWa4lCoV5KaAN5xxaFCYElb+/fI=
X-Received: by 2002:a05:6000:3104:b0:42b:3ab7:b8a8 with SMTP id
 ffacd0b85a97d-42b59341539mr4087488f8f.17.1763145725905; Fri, 14 Nov 2025
 10:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn> <20251114092450.172024-6-dongml2@chinatelecom.cn>
In-Reply-To: <20251114092450.172024-6-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 10:41:54 -0800
X-Gm-Features: AWmQ_bkjvU9z2EP9HEX18ZUpIH2hTIcIwoCeBxuk2sjgbg9_DACCoNFlr-aYKGs
Message-ID: <CAADnVQLemtF-m5et+c5pWppNZoWnWBehtMCHVJU9Yagvi+dRZA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 5/7] bpf: introduce bpf_arch_text_poke_type
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Introduce the function bpf_arch_text_poke_type(), which is able to specif=
y
> both the current and new opcode. If it is not implemented by the arch,
> bpf_arch_text_poke() will be called directly if the current opcode is the
> same as the new one. Otherwise, -EOPNOTSUPP will be returned.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/linux/bpf.h |  4 ++++
>  kernel/bpf/core.c   | 10 ++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d65a71042aa3..aec7c65539f5 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3711,6 +3711,10 @@ enum bpf_text_poke_type {
>         BPF_MOD_JUMP,
>  };
>
> +int bpf_arch_text_poke_type(void *ip, enum bpf_text_poke_type old_t,
> +                           enum bpf_text_poke_type new_t, void *addr1,
> +                           void *addr2);
> +

Instead of adding a new helper, I think, it's cleaner to change
the existing bpf_arch_text_poke() across all archs in one patch,
and also do:

enum bpf_text_poke_type {
+       BPF_MOD_NOP,
        BPF_MOD_CALL,
        BPF_MOD_JUMP,
};

and use that instead of addr[12] =3D !NULL to indicate
the transition.

The callsites will be easier to read when they will look like:
bpf_arch_text_poke(ip, BPF_MOD_CALL, BPF_MOD_CALL, old_addr, new_addr);

bpf_arch_text_poke(ip, BPF_MOD_NOP, BPF_MOD_CALL, NULL, new_addr);

bpf_arch_text_poke(ip, BPF_MOD_JMP, BPF_MOD_CALL, old_addr, new_addr);

