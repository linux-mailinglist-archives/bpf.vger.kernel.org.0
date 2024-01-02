Return-Path: <bpf+bounces-18774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F2E821FAA
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 17:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3471D1F22B18
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A502914F8A;
	Tue,  2 Jan 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb3BWjjz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C514F89
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d858c56cbso26085825e9.2
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704214206; x=1704819006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kifUNfB7WuRC0Omn+nwZXatIcHGB/vUmIlXEFB2647o=;
        b=eb3BWjjzdJx4sxH6rjT9UvNvzVWOLt0FhTZpGnMfRbaftcbU9agqYLNeCNUVeuBWAa
         ekz+ynI06bbYXqHopuFEpJeB7iemPhcSi7gvBi4CwbzD4pDUE6Gt59aHptivtxp2vIFz
         cOH5kVZ1Ay3sS3Ph0JHDb5wV+c7Hz/3WZ117gAPRJOukKDSHFhzi6jZ2NSmR1NmMLwW3
         tP3K+L+i7DzFlaXW008kJyVRFd77XGdgQ7o5QY9AmO/DGYFTQz4yLjSUsY8qDu5NJ6El
         r2ZO9n69QmQsP0OML4bFxsHUCXA2HKHuDRRgAftOq50K4se+tyECXmOGjbagg+Pa1N+5
         Bs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214206; x=1704819006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kifUNfB7WuRC0Omn+nwZXatIcHGB/vUmIlXEFB2647o=;
        b=TFYjDD1SQnLs4M5HxJjy21CjoVOYjVOVub1BbzgU/neXF/gtMaVq3zmujtceQiR+vw
         5N2cA702a+FMvFAyq0pBfFp+DXBp46FC7srNcD8PmMtWfDvxgreKwuW3jOnA3F951Crc
         WQIvaxjEBkJD5oiO8VRAJQto8Sk3X8eyGgOyG1uqKKcW7dlOjSGV5oyDu7hdVx9YIt7B
         Ww4zvJfDzPCxD8SAhy7UnR+MEQJXchNrNCnUaUuDKk9+5Na2lE3ncxmfbLORYNGwsHV/
         JAzdqYC5YUWt8ArL7bqxy8tHXOSFkLWrwa66UJkligFy5cj94T+zaQlMlqEuflu7Lz8c
         P1Tw==
X-Gm-Message-State: AOJu0YymUZGUBo4KpRZSVbkOyAluSQvlIU8/OmenNUtyEgNmeq9JQaFI
	mUYPQx88fvMV8mNOairhjaQwLMsNE26M8IHelgg=
X-Google-Smtp-Source: AGHT+IF55Bwrm7cly0oHJDbum6eaFYhSpuBC6hMwZcJdhPT2GjDmsEC5iVJVglLlE0mjFOdwzRrxE3jOBi90hH+nvV4=
X-Received: by 2002:a05:600c:19cc:b0:40d:5fcc:3a76 with SMTP id
 u12-20020a05600c19cc00b0040d5fcc3a76mr5621385wmq.142.1704214205611; Tue, 02
 Jan 2024 08:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220233127.1990417-1-andrii@kernel.org> <20231220233127.1990417-7-andrii@kernel.org>
 <jzw4oh2atn2lt6fu7atewdnklmtvojmljb7k4dzkiakbio7n67@l7m5ekf46imv>
In-Reply-To: <jzw4oh2atn2lt6fu7atewdnklmtvojmljb7k4dzkiakbio7n67@l7m5ekf46imv>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jan 2024 08:49:53 -0800
Message-ID: <CAEf4BzahBp79YUBb8-m9jHcBGAF=YYSeoJOq=C9EfCaddkzFEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/8] libbpf: move BTF loading step after
 relocation step
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 5:13=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 20, 2023 at 03:31:25PM -0800, Andrii Nakryiko wrote:
> >
> > -static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
> > +static int bpf_object_load_btf(struct bpf_object *obj)
> >  {
> >       struct btf *kern_btf =3D obj->btf;
> >       bool btf_mandatory, sanitize;
> > @@ -8091,10 +8091,10 @@ static int bpf_object_load(struct bpf_object *o=
bj, int extra_log_level, const ch
> >       err =3D bpf_object__probe_loading(obj);
> >       err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
> >       err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
> > -     err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
> >       err =3D err ? : bpf_object__sanitize_maps(obj);
> >       err =3D err ? : bpf_object__init_kern_struct_ops_maps(obj);
> >       err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? =
: target_btf_path);
> > +     err =3D err ? : bpf_object_load_btf(obj);
>
> Here and in the previous patch:
> -bpf_object__create_maps(struct bpf_object *obj)
> +static int bpf_object_create_maps(struct bpf_object *obj)
>
> Let's keep __ convention. No need to deviate for these two methods.
> Otherwise above loading sequence looks odd and questions pop on why
> one method with single underscore and others are with two.

I agree about consistency, but these are internal "methods", and since
at least libbpf 1.0 we established a convention that only public APIs
will use double-underscore naming. We've been lazily converting old
code as we touched it, but I'll just include a pre-patch that will
rename all the remaining inconsistently named ones in one go to not
have to worry about this going forward.


>
> pw-bot: cr

