Return-Path: <bpf+bounces-31518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADD48FF35B
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 19:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDF628CFF8
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E5198A3D;
	Thu,  6 Jun 2024 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSKHJw2X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00518224D1
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693766; cv=none; b=awVP9DqNg9GvYY38fhRwbQ2wnY4gQGbI9jfHTC/gQHi6vHedD104Zog1+FrEdCL/ExH25VSOI+M7+s0i1cdDFE/PSw5PcvU8go2lpRuiYUDeQdyDW8x5zpeo+H4fBrTvSda1r82nbBf9A2SE55R0k051zAeOA411GGag79SntBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693766; c=relaxed/simple;
	bh=YXbCntc1KAm7ttmWTIu1DTSpVKRyddIEAlwKjtob9Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUeEsACAMLvX/zucpiHY1HMbWVW4DvSA7LpypVRSEwovH/hdFIi23c2vhgdO+aG+Nhi2s2tacZvb1mRyGR7nJXDW3VGCtkcqQwVXjVY0F38PYvyJoaHPyhocaa7miC7+Q3k1zhW3QSgTFRbYXXgL/QQaHwnyTbGkV+IyAJ8MRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSKHJw2X; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c1b9152848so983745a91.1
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 10:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717693764; x=1718298564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2EC9MfvXuZOie4clCyJbWkHMf/3RWWmPzksnXO9nUU=;
        b=hSKHJw2Xt9ytcdedaGJxydN6XJg+iNxteTQs89ru3c2MjVvllWp7Lu4AeHe1HI8VtB
         MY1ZycVOtyheXYoT/FGJorYJwwyoqYuVr5OL10lBS3ZQAHY1qtKNHAJxNMsxGQFhrrgF
         cfP22xW6+7GmwwagCQxqz/8Vr81JEi2lXu3VzOm+rxVHDvEL0rOU5saj/SNP8hoc3Ghd
         5b1pn79jajHmc0uZEGnWG9Tp6Mu5kOguXpba9pQg/mExqKNbmt4qdA/bxrCZMZWkG3et
         wpK1wee5GDiKpOkjZBGbjTzZ+7HGXzo/KnJZlNLmlneWbnN0KhdpehWV7h6AZf5Wd5aP
         UbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717693764; x=1718298564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2EC9MfvXuZOie4clCyJbWkHMf/3RWWmPzksnXO9nUU=;
        b=r3FfILPWCu/1eVLEX+QaVf85paZW2+iNrf5jvbPaUEuCYaAfVTP23DAceKZbgN/G/6
         GKPO2XVcFA2sEYF2GyVsBdldbxt/33afAZr41DFpylch6tQNDr1stw4A7tWfByj+zDjt
         aqLsqjhMSzpl2IyZUNPGVqKS2S4P9J61WkbFyCnKCrn52nGqrxr6nAFF0v9xiWpmr2ul
         Svz87W73yB6526l2GO+YyxMW3AnICFFUUL63Jb61aB8YwuooQjp21k9nK4klEF3urn+4
         aMl3YX4QpQ/vhovvXeqngpItIfez9L5O+TCNF0JHW/X144ZLuYpdSrkatlEAARxqZw+l
         NCxQ==
X-Gm-Message-State: AOJu0YxH3+yGK95/G/Xs8WY4QwI9fxbp3wlB2usAiMxsLbE2bghRma2+
	lyFjPG06/xqKEZDbo15z4IezsZ8edbgatEFPmtMw5mdpl+95NDWUqoALbUCiav1aGk0HnHWxRm4
	ZHzFHSDKNDBntZFfKRJGuKedfGkU=
X-Google-Smtp-Source: AGHT+IGnxUr/67IanxcSv5t02Vpgtl0pRZsrvTD49hn5jTdbj1oTSm5QgdzzXmqmyWC3IJfBgmH536ZdxgeCCCXOWzQ=
X-Received: by 2002:a17:90a:5207:b0:2c1:b88a:3a22 with SMTP id
 98e67ed59e1d1-2c2bcc6ec40mr98925a91.45.1717693763815; Thu, 06 Jun 2024
 10:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605175135.117127-1-yatsenko@meta.com>
In-Reply-To: <20240605175135.117127-1-yatsenko@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jun 2024 10:09:11 -0700
Message-ID: <CAEf4BzYBvOOowBHm0BM1QqWH3rVsh=tfGgcrpe7r2f2tNH1+bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: auto-attach skeletons struct_ops
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 10:51=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Similarly to `bpf_program`, support `bpf_map` automatic attachment in
> `bpf_object__attach_skeleton`. Currently only struct_ops maps could be
> attached.
>
> Bpftool
> Code-generate links in skeleton struct for struct_ops maps.
> Similarly to `bpf_program_skeleton`, set links in `bpf_map_skeleton`.
>
> Libbpf
> Extending `bpf_map` with new `autoattach` field to support enabling or
> disabling autoattach functionality, introducing getter/setter for this
> field.
> Extending `bpf_object__(attach|detach)_skeleton` with
> attaching/detaching struct_ops maps.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/bpf/bpftool/gen.c  | 36 +++++++++++++++++++---
>  tools/lib/bpf/libbpf.c   | 65 ++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.h   | 20 +++++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  4 files changed, 116 insertions(+), 7 deletions(-)
>

This looks great and finished (see minor nit below which I fixed up
while applying). I know you had a selftest ready, why didn't you
submit it? Please follow up with a selftest so we have this
functionality executed in our selftests. Thanks!

[...]

> +               /* only struct_ops maps can be attached */
> +               if (!bpf_map__is_struct_ops(map))
> +                       continue;
> +               *link =3D bpf_map__attach_struct_ops(map);
> +
> +               if (!*link) {
> +                       const int errcode =3D errno;
> +
> +                       pr_warn("struct_ops %s: failed to auto-attach: %d=
\n", bpf_map__name(map),
> +                               errcode);
> +                       return libbpf_err(-errcode);

there is err variable already in this function, I switched to using it here

> +               }
> +       }
> +
>         return 0;
>  }
>

[...]

