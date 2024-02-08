Return-Path: <bpf+bounces-21529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7685984E8A9
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D3F1F257EF
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB02560F;
	Thu,  8 Feb 2024 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACFNWVEM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D125601
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419121; cv=none; b=mnV3iKhE044kEedXrf4MBZz6cIZjZm8p95OLDh56DLHqpDIiKZyE/T0F2prkdteZf7qttQYDOzj+p+pqfU2qOklE/vYSgmfeDdus8S4xYcuPl+6Dv5Hw9KFcbn97U+3QLyhKJJ1lSeOEGJi/Em6fASfqNOtSvPNoYGCyMIjD2Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419121; c=relaxed/simple;
	bh=R9JyY02D/Ws0UtKuPN6ugsHbDZcoI1KUzwgN3zgwCII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOT/0KqXMvVfVuk+SZKn2hUjDwqT8F9aRrpHvZIvYTCyXu7eE8f94qGQzmEZHwh5+MSH8YNlltdMWFDyKo6hz+LQ1Ijkf7xZpfE7/LKYvrZa4W/esJVcQ4NGVB+pbDIRU7fq1XDE/CWR00Uou7LJVj8TWQHQ6+iA/tueBuhX0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACFNWVEM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b5cb49837so21685f8f.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707419118; x=1708023918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNlJhbflPV9uP8yqHl4RsirPZjL40gC8g7Gbn5d3u30=;
        b=ACFNWVEMx+6xZBp5Ce9b8P5sXRuBXlBZCi87zDFTloxN55bQ4k/QIsDGvvUtdktHGD
         9r8cggzTQcvUtve5rAJc7zBO/X6JybwuPSEtc6Bq1sWbqmTJekiJLgVUzBxbnu+RGPGb
         rDYTQ4TpX052rG8kOB4obYoxD3hMohUI8ZjUumNv7S7gi8UALeRuNA3eNuBALWcqRHLQ
         RsD56bViM4H8frKb/i6f9d1NNjXTi7a6QBt2SSsw1TVxL4vd5oJBj/QcQ4+qpQK5YK2J
         WyLuRZqNhaIOy4ewZD1Amo0/D2VV5Ady/YyjmxwX4AsS2liUJXnbB0Yx4APab6Qo6PnA
         b1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707419118; x=1708023918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNlJhbflPV9uP8yqHl4RsirPZjL40gC8g7Gbn5d3u30=;
        b=GpmNCSSSXtrMEOhA/qKjiRILGm7ZhtBZsSdcGGbVPZ5JBSt+Jdjj89fcM7UYdGvxPc
         6CKrD5Qtpe/QugkaaH7SOPdd5FjrO+ycgWVXgVFBDL7nuq+ui+9KWq649E1IJfleKW0k
         PYBzL0N864cDm3Y+e/tMe5e7npdfNsExUtIyfD+gAH6h7L5ENk+2XG11WGtc1lg5bvt6
         rf1pbFzfFRLrECiJPGTzTh/KGOMXM52Wu/P0iGtEgoi0/3ftb2nG6GciOXu8Re+iQAaI
         iw5UIj/5h6raW0oWZpB02v365HBjOO0uiKC/J4UyUM1W4XpRpkAADfGnEATfbGSZJbn8
         Lwpw==
X-Forwarded-Encrypted: i=1; AJvYcCVA/qymUpXYZUmrTnscUCeVA4jxcwUrojuAoHAYMiqigJxiHtMtZcmz+SwcrQSYNbZm5/qsQA79+pkYA/WDO8DCViLF
X-Gm-Message-State: AOJu0YyBT0DUDKe19Im6RLM5ttZ1dFi8T8wQRfcLp17qrEbqkjSrDNKA
	FYphGP6rL+fLejrkRCB2pwY2aN1Fqsvbqhcx7i3cYfe0uVE0lRvqNSaqXza2LeiaY9HcoLNqiVU
	M6oYQXheY6/PaCy5BmuYmyyrVdCU=
X-Google-Smtp-Source: AGHT+IFX2On3vUQXuvhqQ/ikp6NGn8zjWTMNJ4JjNN2vvMb4sd3StZER6dAU1lwpcsVTQBpWj4d0CpoPBxLxk/lMKKU=
X-Received: by 2002:a05:6000:1c7:b0:33b:187c:4ca0 with SMTP id
 t7-20020a05600001c700b0033b187c4ca0mr298557wrx.62.1707419117630; Thu, 08 Feb
 2024 11:05:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207153550.856536-1-jolsa@kernel.org> <20240207153550.856536-3-jolsa@kernel.org>
In-Reply-To: <20240207153550.856536-3-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Feb 2024 11:05:06 -0800
Message-ID: <CAADnVQKi+o5LE+oLCvpL5PmVX2BjJdt9a2HEQiXmTgXRLYV+zA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/4] bpf: Add return prog to kprobe multi
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 7:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
>
> In addition it's possible to control the execution of the return probe
> with the return value of the entry bpf program. If the entry program
> returns 0 the return probe is installed and executed, otherwise it's
> skip.

Let's not sneak in a big change in behavior like this.

> @@ -2828,8 +2832,8 @@ kprobe_multi_link_handler(struct fprobe *fp, unsign=
ed long fentry_ip,
>         struct bpf_kprobe_multi_link *link;
>
>         link =3D container_of(fp, struct bpf_kprobe_multi_link, fp);
> -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> -       return 0;
> +       return kprobe_multi_link_prog_run(link, link->link.prog,
> +                                         get_entry_ip(fentry_ip), regs);

This is big.
What motivates this change?

