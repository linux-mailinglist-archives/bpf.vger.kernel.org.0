Return-Path: <bpf+bounces-42210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38089A1031
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 18:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890EE281120
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D6C20FA8B;
	Wed, 16 Oct 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw/rlcnt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460631DA26;
	Wed, 16 Oct 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097842; cv=none; b=NyTpkS+H5RI7k1WSJU7EWpDCosaOjn14FRhbPhnBY5W3MgdRltM0jO2jT3BPdH/XA98NFoXlRySS2H8W3x+Ac0J6JiVdPOyVfdxbXijLB10GCNV163xmbMU0tRDDXtVNSSL+pbnQweLbqchlcPivgzrgBl/3x5If+uAdOC3OwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097842; c=relaxed/simple;
	bh=1pLBOPVtd3wAwlT8/eeZLm5s5+/gi8fPENNYqrloduk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fI3XEmuJqvjRbny+t3YBTHrs+og3jzcc07r3fGXYE2Kv08v3nSXdgOSqTqmvkv2Ug/KbFU/KPtambswN1hGRRso6dYoVj7hY4inmzV3BG5ujZfVzuROA1Gi3qNq/OJHGlLcVukifD1W9sqqhw9ldP42w1auHK/yZeYc6/pdLOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw/rlcnt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d3ecad390so832106f8f.1;
        Wed, 16 Oct 2024 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729097839; x=1729702639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKPLX1dcY2XtDrqW6+v78Ilvqk1xQVBH75n5ZmCvJXg=;
        b=Hw/rlcntXwurJoFigqUKdXfm59SQE/c85GIHXLhlEbISlT7HvdNzVjR/irVc0A9zdl
         ByracNQinmJu7NGFp2UG7Ig5fC22YjNw2qNRNFqi+/IJBK6ry1w1mk/DeO8zY5luC+a4
         EynRzTu/XJy3KjmXHkFTa9xXroWADowUfwzKKTqHZe874jfat+rJ012hTMxSCB+43h8t
         zyoz1vX3pezrN6btrHnIIOOvisL7rJmXK4+GCHXG8xxDTqDlpSeyT9LqQRJzobyz5LeS
         hfHSfxYx+sPlSmFCEX6a5sbvgR/vKdR4LfoCpg3zCYLuG6KVSTEJ46BbxD8GcI70Pvj8
         RGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729097839; x=1729702639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKPLX1dcY2XtDrqW6+v78Ilvqk1xQVBH75n5ZmCvJXg=;
        b=OCCAQipXnRFX77amc3rqz0TCgGpq5kLBuYhMDXwMCVjHJsqTjEq+bN3On3OyY2bEL5
         IXD5XGGPRrsbZrouZz0nD0h32CQEM5htriHfNQ+fTltHzksm7gf1E6rWd1EwgUsmez8V
         MBohPkmYzzeiilVV3r9jrnhhqI5lbEk9/eDCEI8dTZtXmEZ7Tprv4tsLsOpUjp2WziWZ
         S/aWRBWrQ/WMq9sKQBulUzSmSsD60gnBrOQ/lOIeYMWnVlaUyx5Ykv7Dlw5zWP0JwUJ2
         aDIfHDYsfhXHCJsfIFLl9KMXxFXbRbV84Man9BR/sBYuU0nze9c3M/LblnzvSYo1+HRq
         j2rA==
X-Forwarded-Encrypted: i=1; AJvYcCUfIXoP9rnWyBe2wlLZv5wV7bLng9wptZDv8gxa+zqB3c2n3Uv68u/7CwNRSHKYTVtsa5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqGJd1ORVQ/hJmKzpJUPlIhGiZmGKBJEXm8dQRTSi9k3MjWnZU
	CkIo5SU+UOoN0Go40rfLp+24VgmFffq3kJFAyI92lJbAwvQ03DkHhAbopTLwq/jZ/HqXiDLqumo
	8m3Q7z0IeOV/ywMB5XvMqZcX1obF1RPb4
X-Google-Smtp-Source: AGHT+IGVfl6Bh8udrquNYv4mNu/UPkw/vYmp9soRD2vGFse0TwD/OfqyJgeDi9a3rmvQG2SaSfkIHsgQA5TQJR3UAuM=
X-Received: by 2002:a5d:58d2:0:b0:374:adf1:9232 with SMTP id
 ffacd0b85a97d-37d93e19efcmr159965f8f.19.1729097839278; Wed, 16 Oct 2024
 09:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016024100.7409-1-dtcccc@linux.alibaba.com>
In-Reply-To: <20241016024100.7409-1-dtcccc@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Oct 2024 09:57:07 -0700
Message-ID: <CAADnVQ+gL48HGcs0JyLfq17D-qXyeZEoBJwGgGTO1JcJ3Ykqtw@mail.gmail.com>
Subject: Re: [PATCH] sched_ext: Use BTF_ID to resolve task_struct
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 7:42=E2=80=AFPM Tianchen Ding <dtcccc@linux.alibaba=
.com> wrote:
>
> Save the searching time during bpf_scx_init.
>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>  kernel/sched/ext.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 609b9fb00d6f..1d11a96eefb8 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5343,7 +5343,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops=
, struct bpf_link *link)
>
>  extern struct btf *btf_vmlinux;
>  static const struct btf_type *task_struct_type;
> -static u32 task_struct_type_id;
> +BTF_ID_LIST_SINGLE(task_struct_btf_ids, struct, task_struct);
>
>  static bool set_arg_maybe_null(const char *op, int arg_n, int off, int s=
ize,
>                                enum bpf_access_type type,
> @@ -5395,7 +5395,7 @@ static bool set_arg_maybe_null(const char *op, int =
arg_n, int off, int size,
>                  */
>                 info->reg_type =3D PTR_MAYBE_NULL | PTR_TO_BTF_ID | PTR_T=
RUSTED;
>                 info->btf =3D btf_vmlinux;
> -               info->btf_id =3D task_struct_type_id;
> +               info->btf_id =3D task_struct_btf_ids[0];
>
>                 return true;
>         }
> @@ -5547,13 +5547,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_=
link *link)
>
>  static int bpf_scx_init(struct btf *btf)
>  {
> -       s32 type_id;
> -
> -       type_id =3D btf_find_by_name_kind(btf, "task_struct", BTF_KIND_ST=
RUCT);
> -       if (type_id < 0)
> -               return -EINVAL;
> -       task_struct_type =3D btf_type_by_id(btf, type_id);
> -       task_struct_type_id =3D type_id;
> +       task_struct_type =3D btf_type_by_id(btf, task_struct_btf_ids[0]);

Good optimization, but it's also unnecessary.

btf_id is already in btf_tracing_ids[BTF_TRACING_TYPE_TASK].

