Return-Path: <bpf+bounces-32641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A783F9114A9
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 23:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B912B2381C
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3842823DE;
	Thu, 20 Jun 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZEnLl8t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F20823DC;
	Thu, 20 Jun 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919027; cv=none; b=obqOuuEcHmPYOGdfpaTxis7+QcSEkjM1B0B+gry6o5JtHd72X0Qge5tnKY2gv+CEOlLY5wV8fZ2YFShnVc3KZpsi1IVaLwXa7Eb0w3wlf3DmdEVaFduO28ASY0ir5+JjDbLDTP0DQcfmvZ/E1hIb/f57ZgPhuCXb7IhDAm+tof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919027; c=relaxed/simple;
	bh=A7nh9ivMrpQmnQaH4O/9YbzS8+C1aj+NPgmNiV5aO/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=be0aIT7UvA6kHY8lH+YOrRZSY1dBmAhQResl5cBwwlC8pkzklI/9CgVlXUO8p79wvVsij4cqNFqjeORGxASK/+W2Ehl+g5n3pdQkdzhSiqJzWNE7uHTVhTlqVQJ6GuVpaYQnAE2Vh8CCiLlvmfd1VDJAKxQNd9r2HVpPZs9DlGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZEnLl8t; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c70c08d98fso1178614a91.0;
        Thu, 20 Jun 2024 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718919016; x=1719523816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7nh9ivMrpQmnQaH4O/9YbzS8+C1aj+NPgmNiV5aO/s=;
        b=DZEnLl8tXJC8CogCbeam7vPJlwdh8+rniSH5c4tWrMclyeYIEvXbmm9mv6AL6D+4so
         t9/lDNj3Th7yn0neG4zKWSXT87PHFr0uV2/P1fSIuDuokF2p2+Y6uTk4n97LcXj3uagU
         X+7EB90MDBhppB+M74YUecsMQQZ5p8OKMCLs2AIcX9RDKUes8VmsDOCq1Qyhdwm/yj/x
         WsWrW/C/DwYqX3wOwaQr03MM5JrWYI0Dz6nsBHoHhtZ09OHQIlfm8S2L80QHeS3vHTyp
         ZjVp405imeNUOGmBpzK/v/sVL6MOZNeqEQHe8UxAVIuskKNCJ3tguJFM28G2VpW5MZaj
         RSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919016; x=1719523816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7nh9ivMrpQmnQaH4O/9YbzS8+C1aj+NPgmNiV5aO/s=;
        b=hFRfJn3VQ7FtuZXy4BnCZpRsFCnURXb5Rc+HbTeMIuW/29BdMSPrgcWKE4gJnhJruO
         BeiEcTlW6DuqIeDAaAQq8mkdcm+HcsWTRJbwHAVry66JQSUwd2GO65kM6YFY875YFZ0U
         b+z8VFUcc3O2jtnwdfj/5CleE3hOhnqpenNeGClLlxcIQSwFmKoOvSnE5f6Hps2TzRDH
         3b6i5L/M/ui54BUM/flAg8sdgcsw8AIG3VJY80p3XilV4WOmZ37uvjg8H9LyjjJZ8rsH
         TUpAJuORR8uJGq7uEyizJcscq2UwueNu+3hq0XjcqkxMhU8ohiygprPEGt0Fz2iabnVp
         BoLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9YfbAHRFGqJbgi+Ac4I8LyrQxKXE3RyVKf9WIbwnqcNjxEmv6Aaqw/NQf78PaqsNsMRo5ZOLOqwN4f2EdORSmhpjE4S7agGWdQ8VgY4RQ5SMdAvFxn/Zkp5L92C4RBT1cny32Gb9AqRmIiNTSjvkbBs3xaiKb51sjLHyrxhROGNBS5HPB
X-Gm-Message-State: AOJu0Yy0X3rMaeeppDm1tegJQsFExjRh+4IsZdgXuLOeI9NSz052UcT7
	U2WrfDSJSNfZcAlyYD6M6jCPades7o9IHJxX+bqKpM+cp5InpJeKyLDC5fQY6fPsxvqvhd+wJUZ
	LzPYjOcaWuwSunubCRsj0nOczuAjQbick
X-Google-Smtp-Source: AGHT+IHnEJW6nalEQ9qlOMSA5ukMCj1EHZJH30RaYWAHqhdGw+qorT6gP98OirXJ5WW1i6nqTAGrJvWH7flg5FQbmM8=
X-Received: by 2002:a17:90b:1107:b0:2c7:8a07:bc57 with SMTP id
 98e67ed59e1d1-2c7b5dec045mr6573826a91.48.1718919015985; Thu, 20 Jun 2024
 14:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618194306.1577022-1-jolsa@kernel.org> <CAEf4BzbN4Li2iesQm28ZYEV2nXsLre8_qknmvkSy510EV7h=SA@mail.gmail.com>
 <20240620193846.GA7165@redhat.com>
In-Reply-To: <20240620193846.GA7165@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Jun 2024 14:30:03 -0700
Message-ID: <CAEf4BzaqgbjPfxKmzF-M7nzGroOwKikA0BM7Tnw7dKzKS+x9ZQ@mail.gmail.com>
Subject: Re: [PATCH] uprobe: Do not use UPROBE_SWBP_INSN as static initializer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:40=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 06/20, Andrii Nakryiko wrote:
> >
> > Can we instead ask loongarch folks to rewrite it to be a constant?
> > Having this as a function call is both an inconvenience and potential
> > performance problem (a minor one, but still). I would imagine it's not
> > hard to hard-code an instruction as a constant here.
>
> I was going to ask the same question when I saw the bug report ;)
> The same for other users of larch_insn_gen_break().
>
> But I can't understand what does it do, it calls emit_break() and
> git grep -w emit_break finds nothing.
>

It's DEF_EMIT_REG0I15_FORMAT(break, break_op) in
arch/loongarch/include/asm/inst.h

A bunch of macro magic, but in the end it produces some constant
value, of course.

> Oleg.
>

