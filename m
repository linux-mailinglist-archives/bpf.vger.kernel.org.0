Return-Path: <bpf+bounces-63374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A552B068DA
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 23:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3036564F50
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127792C158F;
	Tue, 15 Jul 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7aKBVln"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805584039;
	Tue, 15 Jul 2025 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616318; cv=none; b=iGyA8qdtJ1C3T4Qm9aaTGMWI9riJLLwDXGcLE3WMXnYsq+WOgKHmHR8J4Ydhrmo4w41bKnyDETDQn0z8tg/W3hUoTI1ZjufBTbge/yTtri/M//DhteQ05Quib91S6IW3KnoQ1KD6lTHlztJVDniufM9nOcegAlGxLHHyPYVvC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616318; c=relaxed/simple;
	bh=3NHyVHuHJgcVKZ3sL3MmzKCi5uYAP3gMLlsZ9/5QWWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyxqLWKBbf4XwToabetTb8tPtX/OqffmzDJ+OjrIhSTD5ZcaXEn6E2fSfpWgZ4wyGNXJvev8vTDbMYSvWPKiehPMzcMrUkUADHI2HXPNo1iRRJiPSgxyU/skyWRLmc10au3m3/DfxTbmZk/SYp6SYGYh1FtP3EJ3nui5ho/p5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7aKBVln; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23c703c471dso3234655ad.0;
        Tue, 15 Jul 2025 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752616316; x=1753221116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgww63Xej9ViNp3S/jj9kRM9seb1BA7S5yGgNs2PDI0=;
        b=c7aKBVlnFCteX+tUfvAtiKcAqBEZaO00MKVeKQs+x2jbJ3E5aEa6nri8Nn9J+0rvyi
         CxLbrho/aqxwD3kS560LDSGAdLJgzW9C5gwnevoXIAvgcKu/8jVs+80/2FmNLOea38DH
         Lc7vWQCNS7m3VzF+YGwCvBaazeWEYnlW89jM+tGLiKMo49H9CXkMyP3hISk0lVvUuaND
         HS9gMHViHVeIxoGPpEpX5jr5Fnb7qRaYg6G+SwWoKXMHoCEy5IMHtuXaNjACDDrKIAWA
         tDsEvC/X6IjaCGDhYSt2+Mn3bkQp7eHx/zCrd/GSVTZlJ5RppUpUMaEoGrY8mXfL+KCr
         8jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752616316; x=1753221116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgww63Xej9ViNp3S/jj9kRM9seb1BA7S5yGgNs2PDI0=;
        b=ZoNd88OyhgD93SxUib04taOGoRp5AQF6Jkr2c3hyaZJaFCkJuRbzHTdBxtFJetcPeM
         zc42+eW6ihLH69PfSXi1eE7pci0y+pyqjn/fbEHIMrcxF2iuX7a4cpAWUXRh74tyYTH0
         HVb8+rAglCka4mnp0iA4TTRnETH9dp+92y5z4TkPgpmE4DdNQ9Lf7iWw8mPkxz75IOrf
         U6ND0KLDkMTcGGoSkQCGS4JjhB+E2yySYRMGnk8Dj+kIlItnyw1AUyZ0w+z/RIGkLWDz
         epLhoICVMZLlJyhRgvHsF172dkEJEnBm6rz/FOsUh8YH+w20w0WXov6ml39oXgeKczZU
         kK1w==
X-Forwarded-Encrypted: i=1; AJvYcCVtjIgCaUAI/2ubmLhb7CqkiLjcxNOjJ++5k3lCLsaqqT8MlM3V1piL7TxBUyis3TIzFjI=@vger.kernel.org, AJvYcCXJAxa22xqvSN/jIzot+04UTHNJKuZqz2Rgs35chw7sigBHo/GBR6sJxTCnzDMsIZRpEsYXBASlNsoZGKun@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1Bh51rC77yC7Qcf6yEGl/KwEnv7Hrlhd3id4kvvuuWi1mATl
	Fs09hZ4Mo4z+P3UVB1HU5a52i25zKZl7EgteBW08rLqNBNDSTPR5fhCQbLZtdBiAdnEMGKSGfCG
	WNMTJaYaHqTkZZI+53ceAAribnY5nPCg=
X-Gm-Gg: ASbGncttPlde2KzVrYK6FOweA/I9tF1dgICovpb/zhtvEQp5bm5SDWMUAo6qw+2BqAL
	wuWPBHyDgfll3kkCdB5U7hmNGMg/4gBzybAdr9t4iGpR+/JHTa8GNRzqMuQyo6ErITSXdAxAQIe
	aCKtwIMIkyArjPf6PUjMOw4M2Ou6CTGEo1t1nUoRCcSbVf5fer+hhwefIrTfg2LihtD8/T3OIGe
	Mjl1AO0sKfroxIVbp41OyCooCG3fJih
X-Google-Smtp-Source: AGHT+IGbtcjZT2+kIxES4d+B9Bd7dHSuYxgckqYmu++uJHhkIQMdBhXQapEL1l9e9ovCien4W9dt8qzOGjv7e6zh6TE=
X-Received: by 2002:a17:903:230f:b0:232:609:86c9 with SMTP id
 d9443c01a7336-23e1a43ad9amr66710635ad.9.1752616316244; Tue, 15 Jul 2025
 14:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715035831.1094282-1-chen.dylane@linux.dev> <20250715035831.1094282-2-chen.dylane@linux.dev>
In-Reply-To: <20250715035831.1094282-2-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Jul 2025 14:51:41 -0700
X-Gm-Features: Ac12FXwHaeiZoIHkXsb0DYnv4I8SIh0AMo_Nj24JJ9Ji5ZcnShi8culOgjfHXyI
Message-ID: <CAEf4Bza8FVL55qLds5ZWaKuz5Hw_r+bwg-MeXWX9H7ZsA_8ZJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf/selftests: Add selftests for token info
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, willemb@google.com, 
	kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 8:59=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> A previous change added bpf_token_info to get token info with
> bpf_get_obj_info_by_fd, this patch adds a new test for token info.
>
>  #461/12  token/bpf_token_info:OK
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  .../testing/selftests/bpf/prog_tests/token.c  | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
> index cfc032b910c..a16f25bdd4c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/token.c
> +++ b/tools/testing/selftests/bpf/prog_tests/token.c
> @@ -1047,6 +1047,36 @@ static int userns_obj_priv_implicit_token_envvar(i=
nt mnt_fd, struct token_lsm *l
>
>  #define bit(n) (1ULL << (n))
>
> +static int userns_bpf_token_info(int mnt_fd, struct token_lsm *lsm_skel)
> +{
> +       int err, token_fd =3D -1;
> +       struct bpf_token_info info;
> +       u32 len =3D sizeof(struct bpf_token_info);
> +
> +       /* create BPF token from BPF FS mount */
> +       token_fd =3D bpf_token_create(mnt_fd, NULL);
> +       if (!ASSERT_GT(token_fd, 0, "token_create")) {
> +               err =3D -EINVAL;
> +               goto cleanup;
> +       }
> +
> +       memset(&info, 0, len);
> +       err =3D bpf_obj_get_info_by_fd(token_fd, &info, &len);
> +       if (!ASSERT_ERR(err, "bpf_obj_get_token_info"))
> +               goto cleanup;
> +       if (!ASSERT_EQ(info.allowed_cmds, bit(BPF_MAP_CREATE), "token_inf=
o_cmds_map_create"))
> +               goto cleanup;
> +       if (!ASSERT_EQ(info.allowed_progs, bit(BPF_PROG_TYPE_XDP), "token=
_info_progs_xdp"))
> +               goto cleanup;

nit: there is no harm in just doing a few ASSERT_EQ() checks
unconditionally, it's cleaner and more succinct (and either way you
return err =3D=3D 0 in this case)

> +
> +       /* The BPF_PROG_TYPE_EXT is not set in token */
> +       ASSERT_EQ(info.allowed_progs, bit(BPF_PROG_TYPE_EXT), "token_info=
_progs_ext");
> +
> +cleanup:
> +       zclose(token_fd);
> +       return err;
> +}
> +
>  void test_token(void)
>  {
>         if (test__start_subtest("map_token")) {
> @@ -1150,4 +1180,13 @@ void test_token(void)
>
>                 subtest_userns(&opts, userns_obj_priv_implicit_token_envv=
ar);
>         }
> +       if (test__start_subtest("bpf_token_info")) {
> +               struct bpffs_opts opts =3D {
> +                       .cmds =3D bit(BPF_MAP_CREATE),
> +                       .progs =3D bit(BPF_PROG_TYPE_XDP),
> +                       .attachs =3D ~0ULL,
> +               };
> +
> +               subtest_userns(&opts, userns_bpf_token_info);
> +       }
>  }
> --
> 2.48.1
>

