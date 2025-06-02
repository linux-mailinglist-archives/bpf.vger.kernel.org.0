Return-Path: <bpf+bounces-59460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592A1ACBD52
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 00:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4B97AAB46
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA6624DCF4;
	Mon,  2 Jun 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/Dj1bJL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94D182D0
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903290; cv=none; b=NpEMqao3UF0SQzhTgBQnBEnI+gzakJf33EVsXdK2/dFhDr7ey76mz20qm51628lFrSwqAFBTN2QsdNAgnrh15wsN/INgjPwkALWqPiBH0sXUMBg3zejTjDA4Vl8zh2Gzak8Xm0Wdgdej6QF6ePx89HzzsAnEGIKA4BGwDVMHOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903290; c=relaxed/simple;
	bh=A/31KZ4HJ52Aaowwmxj0XDZcl5kF7wBRl+tz9sg2j3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvyK1fXAtPmBriXcW6E2V3QpgX9zqlOlcx9gAs9nsra94s0O0L2icgr7dQzhCxKJKClJ/7KGahNetiG7zeA9Ed5zHsEsRSZjRLdxos5Reb7bxtzVT4CeEq/ldEhwBFcJeD2rX2TFuK1HgU+ZT8eHcHWoLEMH0UbR5mr559argys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/Dj1bJL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d7b50815so14346885e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748903287; x=1749508087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMD9qulnLeIvfFhw5WCavBt/PCPfpEMZ20QNjY1K2c4=;
        b=A/Dj1bJL7FCBEYfmACKyej2qbsVoKZaYMPDm2HH4G2/fiBRNcW9b5/2wiYl64Twxuy
         gp/hCbRVugTnX8paNegvhyZHu0QU09YXb3/2JVB+z600rvhcJqCdEkKSBcWsIH5qCjYH
         lQh9yIcabvYKvDupqys/R2EAEJb5WIbMAItebnzwYdnTUWiqBYkrFgP8DNqXtQ6DP2Em
         ZVkxrh//g2nSJ26bfXvag+cKpp0OV9OBSdjOyVFBS2nCLP87MQDlYyTzf31hzqAqw2vy
         +Yp04wj6DdWEeFOd/ALp+8LFpdVposkQ6zllzsVGqV7K07Q+kgFTEepK4AvocHjjaXeB
         WHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748903287; x=1749508087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMD9qulnLeIvfFhw5WCavBt/PCPfpEMZ20QNjY1K2c4=;
        b=W3cMnmzUvLOqaOl0ljaH+w/eRzp00T0fphFX8AtO6gwyJZ8RFLtMV9CMYXykvhiugc
         n8XLE4PNrDhnMOBc9Wn+eu2fEmE/IyVt07KoihiFrwLfyzky3NVuX3ourSWE61SaYntN
         YLyDA0OVpl2/fZo2sXrIgGAFJlCpENnuNIfb1qqSVaShPsEhGjSic3MuXlBLLeGWcPo4
         PG1uss/mYO7ziydkEZ5odNOpvCwsl0PSRkuLMi6MQXj27OPyGIVe41PfdMVHS+pLfADD
         dsxsOb2/WOuj+EvgutNCb1NqpLczDZxoJHxnadi2uItrWsadnU7qIm2wzGIjRj06MqRt
         rdGg==
X-Gm-Message-State: AOJu0YxB7gYQY8GWQy0wHCpVpAKXvcLRdYNeKV2S0y/8VV1J4k2qFGhb
	NeEwB9MPPRT7n5xj4fn7npySOMMpCfRpjMgVIZ3NoY8RqbKMWcLd7k17z376RdA6esLsZlzXHQY
	2XRK+Bh7glVdmO5Rbggcl+bYDjF2DRd4=
X-Gm-Gg: ASbGncsfOYY64RnOEW9IRrG8hfk94lW+TAuZ45MjAJlQ3A4zKgdyqPGQDmenrOnB8Zh
	kasbR/O09gjqe6wHHS3RH2/rlqWa6Eo0q7JbUHKjCl36ISgWOQ8+hqhX7vP5KIH0G86Rk+55lBt
	WI7VdZ39p8DNh+hLw/LsyJIpreV4UclQU1e4fiwaGjL8hyTBqJoNC0g6MqFgCILg==
X-Google-Smtp-Source: AGHT+IEcd6xgeD1J8DryV+Bh2mc6vqQXVQQfewjxylJ9b+6fAN8q88XRG9bFFVBLnZlD3REsCsRpolSuELKxtwVzDTo=
X-Received: by 2002:a05:600c:681b:b0:450:d5a5:e6c5 with SMTP id
 5b1f17b1804b1-450d887a4bamr106598135e9.26.1748903286504; Mon, 02 Jun 2025
 15:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-7-memxor@gmail.com>
In-Reply-To: <20250524011849.681425-7-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 15:27:55 -0700
X-Gm-Features: AX0GCFvN3htEnwygUNgpkZcglfTz12M_hqTmxobYyB-xXA7EQBn1KxED_Moi13M
Message-ID: <CAADnVQKZ6MwegovctyozRDBgQ6G03NsYKjtg3pzYdmA5bcPc1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/11] bpf: Report may_goto timeout to BPF stderr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 6:19=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Begin reporting may_goto timeouts to BPF program's stderr stream.
> Make sure that we don't end up spamming too many errors if the
> program keeps failing repeatedly and filling up the stream, hence
> emit at most 512 error messages from the kernel for a given stream.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h | 21 ++++++++++++++-------
>  kernel/bpf/core.c   | 19 ++++++++++++++++++-
>  kernel/bpf/stream.c |  5 +++++
>  3 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index aab5ea17a329..3449a31e9f66 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1682,6 +1682,7 @@ struct bpf_prog_aux {
>                 struct rcu_head rcu;
>         };
>         struct bpf_stream stream[2];
> +       atomic_t stream_error_cnt;
>  };
>
>  struct bpf_prog {
> @@ -3604,6 +3605,8 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *d=
ata);
>  int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
>  void bpf_put_buffers(void);
>
> +#define BPF_PROG_STREAM_ERROR_CNT 512
> +
>  void bpf_prog_stream_init(struct bpf_prog *prog);
>  void bpf_prog_stream_free(struct bpf_prog *prog);
>  int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id strea=
m_id, void __user *buf, int len);
> @@ -3615,16 +3618,20 @@ int bpf_stream_stage_commit(struct bpf_stream_sta=
ge *ss, struct bpf_prog *prog,
>                             enum bpf_stream_id stream_id);
>  int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
>
> +bool bpf_prog_stream_error_limit(struct bpf_prog *prog);
> +
>  #define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARGS_=
_)
>  #define bpf_stream_dump_stack() bpf_stream_stage_dump_stack(&__ss)
>
> -#define bpf_stream_stage(prog, stream_id, expr)                  \
> -       ({                                                       \
> -               struct bpf_stream_stage __ss;                    \
> -               bpf_stream_stage_init(&__ss);                    \
> -               (expr);                                          \
> -               bpf_stream_stage_commit(&__ss, prog, stream_id); \
> -               bpf_stream_stage_free(&__ss);                    \
> +#define bpf_stream_stage(prog, stream_id, expr)                         =
 \
> +       ({                                                               =
\
> +               struct bpf_stream_stage __ss;                            =
\
> +               if (!bpf_prog_stream_error_limit(prog)) {                =
\
> +                       bpf_stream_stage_init(&__ss);                    =
\
> +                       (expr);                                          =
\
> +                       bpf_stream_stage_commit(&__ss, prog, stream_id); =
\
> +                       bpf_stream_stage_free(&__ss);                    =
\
> +               }                                                        =
\
>         })

I think this part can be in the macro in some prior patch
from the start to avoid the churn.
To me it's easier to review all key things about it in one go.

