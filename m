Return-Path: <bpf+bounces-70263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F6BB5A42
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 01:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE64A1B2F
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 23:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF872C15A6;
	Thu,  2 Oct 2025 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnOXgBHZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79052C159A
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759449127; cv=none; b=SwbcjQrNG64AFOeNQh+6SCSDVPaHQU4zZMLpp91RTntn2Kw3wxMx2nDPbjUYqLbl1Dika5aY2HvfQe3W/L1tPKNFxB095v5ZoZz+/RhEV2ALm6QJ5oTEid/ZYFsiN2Bn42OGug2ripn9ik81Od3+baNzqIN/VNsXuwwrGAgSZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759449127; c=relaxed/simple;
	bh=LYvstTWSajhmk7asjh8R2tUDkoC33rTG9pIJmqnQl/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKHaq8aGxOYCGcgHYHfqPi+nyiE2xKeM+M27gC2Dg5JDMUeiBm4QD3WQGQ4WZnL+qiWc9Ef0+AMymRGaBa8W7dKUL/Sh/J51p5479qLVM+oGdWt9NWTEl2c443U//mue4NsvToHvvdl2p4ACWkUIp4nGv7wnFeS1CAo+P/DjRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnOXgBHZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1523751f8f.3
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759449124; x=1760053924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpQkx72gZh40m5E2SgnmFYAHaNDmgmnkHriKtpKNtN0=;
        b=HnOXgBHZGfJC6ZfcTAdtPbWKsfKhfCeRXUbhkDzDRsGkgikBMeTstYPRxBsXuHNbhI
         Az94jUJLhBBXB104pD7vviHIPJ1i+QeTMRt88OJY+FWLXeDbGBFFv/+3mPKhdw460UMo
         s4eqvzW2YS4ZEDz4HuvnM/FVGtdPnoqbhZjSslbp8t3OH/qgtRsZoD6IMGo8ABBeJz7Q
         MwVtuEa8NjPQpaLlXvaE4pOihfEAEb4VrLiCR4NSII8zrkw3Gtay45EmgrbRLrjMYHDa
         LufhTRlOUpPrwaFB1ulQZWQ54GoSMq1gSOZ79HFnNl/hV0ZxfZjyki39jikcow5oO4qy
         SwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759449124; x=1760053924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpQkx72gZh40m5E2SgnmFYAHaNDmgmnkHriKtpKNtN0=;
        b=H/Kib9y8/kuPYNlfpT/O9jrZqFBaslu1SXhvE0kn8Ug08PppElShiHdvSWd11B6G90
         lzB1oMgVuTegILv4XIzzSy26bRgfRyiNIAcLaUQhhaGpX/NIb2LYGVwMFLS+Zx+qZiEJ
         JFSq3g24KieFylrKK0W93esJ+QLPZlZCXKi00FKOEAHELwNmD5a4bLOlPncge9KpsRqT
         4dwkUchjqJhFjzrb6isljxlx9klPynvV9m66UQOIl1aKYSlfWrSvIaAzuXaRkhd5bLY1
         Wjcd2UpttlZGrXcAZiTy6/QgJhrkUuOFOLGOAu1GVfGvHMuv0RF1AMEoj43FjL0+/Q8u
         Ogjw==
X-Gm-Message-State: AOJu0YzX3T23GYmEJgdnd+RG4uMBcRug/SeMahzbe7gcv+Pz2bMotnQ6
	Ztr2QwWd1qaEegD21OkRh4Pi+LlUCqufhw3Qoq31gK/oPgegnbRsb5pa9sspyyC//ggoDfGJipE
	enyeTzAd/tGUWYOF0fByroqbQ4y75Wio=
X-Gm-Gg: ASbGnct0xSzcp4YhRsUM1tECoOUhlHqO9IbQunREhYWLhjQ54Y7QZn5X0l4FR4PDBNr
	PBjDTCXc9ZGEQkpANE2z8kpgmH77hZyUQJj6asaz5dIl6o8IxwiHvPVWbFmNZRFATcaj19yjlWW
	6jJ+S4+23Jefm3py/5AaqYmgLHRiK7ezUfrMMAdPl3NN7gVUbLtRFdXICS23n6Kuemx2gp8vWgl
	KdtgvX2VeS81V7UXpu/RPredXb3+NrtOEWTGbEbw8LGISuagoS3DZWkWgpa
X-Google-Smtp-Source: AGHT+IFLQ0rd2Is5fIz4RVK0yA26fm5rkdXlgaoXmkUSMG5KqvSSAW5P7OMwaqf/p6lz8p6R6G8AyE5iFs9oTvj/HaM=
X-Received: by 2002:a05:6000:2c0e:b0:407:4928:ac82 with SMTP id
 ffacd0b85a97d-425671bec4fmr631382f8f.53.1759449124029; Thu, 02 Oct 2025
 16:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002154841.99348-1-leon.hwang@linux.dev> <20251002154841.99348-5-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-5-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 16:51:52 -0700
X-Gm-Features: AS18NWD_yhjY5ZYA4WDT53hfwBQ3aCiRHCGg0DBUjgAhtLAVAhu0lW4-lZc6YAk
Message-ID: <CAADnVQ+WcMp5bgw_hHON+unufO=Mm5f7Em2kUeqmkyBZwMU0nQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 04/10] bpf: Add common attr support for prog_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 8:49=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> The log buffer of common attributes would be confusing with the one in
> 'union bpf_attr' for BPF_PROG_LOAD.
>
> In order to clarify the usage of these two log buffers, they both can be
> used for logging if:
>
> * They are same, including 'log_buf', 'log_level' and 'log_size'.
> * One of them is missing, then another one will be used for logging.
>
> If they both have 'log_buf' but they are not same totally, return -EUSERS=
.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/syscall.c | 55 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 2bdc0b43ec832..698c30ff99486 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6092,11 +6092,57 @@ static int prog_stream_read(union bpf_attr *attr)
>         return ret;
>  }
>
> -static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t u=
attr, unsigned int size)
> +static int check_log_attrs(u64 log_buf, u32 log_size, u32 log_level,
> +                          struct bpf_common_attr *common_attrs)
> +{
> +       if (log_buf && common_attrs->log_buf && (log_buf !=3D common_attr=
s->log_buf ||
> +                                                log_size !=3D common_att=
rs->log_size ||
> +                                                log_level !=3D common_at=
trs->log_level))
> +               return -EUSERS;
> +
> +       return 0;
> +}
> +
> +static int check_prog_load_log_attrs(union bpf_attr *attr, struct bpf_co=
mmon_attr *common_attrs,
> +                                    bool *log_common_attrs)
> +{
> +       int err;
> +
> +       err =3D check_log_attrs(attr->log_buf, attr->log_size, attr->log_=
level, common_attrs);
> +       if (err)
> +               return err;
> +
> +       if (!attr->log_buf && common_attrs->log_buf) {
> +               *log_common_attrs =3D true;

I feel like a broken record.
Do not use 'bool' arguments. There is always a better option.
'bool *' is even worse.

