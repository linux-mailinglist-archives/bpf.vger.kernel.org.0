Return-Path: <bpf+bounces-45429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 375A59D5675
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3974EB23F51
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D411D63DC;
	Thu, 21 Nov 2024 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moXadc7Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017DA1C9DC9;
	Thu, 21 Nov 2024 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233329; cv=none; b=OQT4lz6wDjQ5pE7ArXa/GZLzngz2tq3ouMhzuVFDw4Y0MXSt58qbdEic3Lby80Qp5RWI9uGRaHLBtzRH+vG1fMlSVRyDyCVDMP07Dw1CHjLgWMNxuU98Va1hFTiFYolwnWF4DLzaMlwdHx1ZE9cWmKw9j83uAjRQb380ib19fek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233329; c=relaxed/simple;
	bh=OnCE+SO0XrnerPiG8sjnydHk75ALu+nMzMHDMpjOuow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwtkt+LD+EsApGlJd1jxIwlhDZfUqqgtUM5E8S3cny172XewrOSqkQnhlqYNExyLqRbgPSKPdWDKs0gscWYcEOQUKItY+JkbK0bg5aJN8v5KCRo6/DE+CfKl7BfVPuvCI/QtCuTqheYx+X/8uQyCSzZizYssXz87o5UlxofVdMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moXadc7Y; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso1142673a12.3;
        Thu, 21 Nov 2024 15:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732233327; x=1732838127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6V+9ljv1rsXyPIyGaXrtpj7FJjO2EGmTBeAyQCdKIk=;
        b=moXadc7YqGRAknjfF6wAIS6HnsEcDzkithWzCwr885G2GfwgDOoT1YLA71M5YqP+9x
         tB0vN7XheNsUXmE0bqBeqbHjtug1TsvfupUV2E3xuc73MhoiDNTwY1XgnOoFlQmt/CXV
         XkyegZ+Fh1GdY6o4uvg7dg9XK+c3E57X/yaB4fnwld2w/ac5g8THy+ym29f43obZEsWz
         84B/vH106t6cGfm9T5QLo39o2WJzpnzvf/vPEHxal6wpJxXHa7luSGyOSxqppPLAtUCO
         wIxluNP+S8Mnttb/ef8cyoXOi25F/FpSY4EbT5PV+nHCOBH9q4Cs4icCKcSwBKuR/Ate
         fBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233327; x=1732838127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6V+9ljv1rsXyPIyGaXrtpj7FJjO2EGmTBeAyQCdKIk=;
        b=ugubAh5oN6W9GXo2saejeaFV2ZE6wecypGaIY2eLJaS85owXQ8BZsOrNEyy+CZl55A
         KghaQWwF9Rn5JTV4pnCMzqF9TEPFri3SCRJ4W5YiSimTcZZz1SBNpZBPA2sUa+s5rG1l
         o4riz62YZ1jcgzEeqd69ifIGjPIcA4hAxGcx5FyLkwd/tcaKSVIK+24Uo77f7LtFVPLF
         Q/dTuAFCtA1dwEq3tqSFncZLvKMD0lg0GmK7I0GnfrEk55QwKZjREifl1KCaGQLHJPTr
         RCcrW61sIWLOZndYU5ppY4AOHXCwOraX/TMOlvbWh9R1mUiEUb/oNz4AkPwB9kPeQoVu
         9Q3A==
X-Forwarded-Encrypted: i=1; AJvYcCVKJFacxnhEbP0eMR2PHnJGe4ex+eH2u6BI4jq+nujE07zmDQ1hml05/S69CLDvvi2v3Rc=@vger.kernel.org, AJvYcCWpsenG5P/KmLbFpOt2U9np1SpmBdNISTpvSC6crxyGsNHnF1xfSm06gOcXUYgTSEIyseLLAH6+yCwkPWD/@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQ30ejWroKWEwODIXvX4WECi9fyvkqIS+dojyHpS0dxEHahO9
	P5k07mg4yrRlLOCJ8qvaOOm01ssbLsj2JC2g93dtGOdGT9fRDSqLU6c76VYo3dgiv9GqiO1GBPr
	mIwyWyzvy2JHZYdeRZp/4/sM5p5c=
X-Gm-Gg: ASbGnct7embsMXSztablf01L8x8L2ohLjInTZfdIJbPbIoXJMOOr0i5BZ9Msr8IQ9pj
	dS7OV4EVB/p3JaXBZE96KhyKpTV+yT/8pXdaTtp2kW5cO6O0=
X-Google-Smtp-Source: AGHT+IFhOOzFMvNiSDCvh5wIHPV9xYPtb1ZJRlVS9XDdxwraAKYtR+P7HIyCLfalWgYL80q/JlAfY5pY8NmzRRLtV3k=
X-Received: by 2002:a17:90b:3b41:b0:2ea:5e0c:2843 with SMTP id
 98e67ed59e1d1-2eb0e12c704mr920418a91.8.1732233327157; Thu, 21 Nov 2024
 15:55:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zz-uG3hligqOqAMe@bolson-desk>
In-Reply-To: <Zz-uG3hligqOqAMe@bolson-desk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Nov 2024 15:55:15 -0800
Message-ID: <CAEf4BzY8DhvdgRg0GKEfhJ1HHtFGhgDqVNG0B8F6FAyd_c5+0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Improve debug message when the base BTF
 cannot be found
To: Ben Olson <matthew.olson@intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 2:08=E2=80=AFPM Ben Olson <matthew.olson@intel.com>=
 wrote:
>
> When running `bpftool` on a kernel module installed in `/lib/modules...`,
> this error is encountered if the user does not specify `--base-btf` to
> point to a valid base BTF (e.g. usually in `/sys/kernel/btf/vmlinux`).
> However, looking at the debug output to determine the cause of the error
> simply says `Invalid BTF string section`, which does not point to the
> actual source of the error. This just improves that debug message to tell
> users what happened.
>
> Signed-off-by: Ben Olson <matthew.olson@intel.com>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 12468ae0d573..1a17de9d99e6 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -283,7 +283,7 @@ static int btf_parse_str_sec(struct btf *btf)
>                 return -EINVAL;
>         }
>         if (!btf->base_btf && start[0]) {
> -               pr_debug("Invalid BTF string section\n");
> +               pr_debug("Cannot find base BTF\n");

Well, the check indeed checks the well-formedness of the BTF string
section. It is specified that the first byte has to be zero ("empty
string"), unless it's a split BTF.

Base BTF being missing is just one possible reason for this condition,
so I'm not sure if it's completely accurate to specialize this error
message so much. Perhaps maybe emitting "Malformed BTF string section,
did you forget to provide base BTF?" would be a bit better.

pw-bot: cr

>                 return -EINVAL;
>         }
>         return 0;
> --
> 2.47.0

