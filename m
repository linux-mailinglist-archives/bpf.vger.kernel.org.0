Return-Path: <bpf+bounces-52210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1982CA3FED6
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 19:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB6D3A12BC
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9818024E4A3;
	Fri, 21 Feb 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6tmqAk9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CFC1F03F2
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162684; cv=none; b=PivNZBTiFjf2hKX4wjdIYBMLyg+PRfUu80cinfRAbI6e84s32L2bYXNpU33MycfWyxXStQgCw4mY403w/5TLQCWj+HnO0I9xIWlHIbcpBPJ+0yboVcGdJr5x0AHgLhnwZMAQYfjDCyVJXX6LMBxKqohodJT1GV1Hesk7T5qApJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162684; c=relaxed/simple;
	bh=rE12ZM7sRw1wKwJPEmHy1P+tlU2frDfpvIxEsKV+pqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PG2Nzu9OF5Dg/TRgZnZHRZCkm1ea32EBF28L2Q1HOcpJKHP7y2jhsJsnyL6q2+WlvQS7js7x7YQrJvhCBeTP6I8B0yxLeLqtw2SVv56F4q+WR0Ee7WU8CTXx9oWmPr2oyx6JP6vmXyJQVikKHOEIxtshmHWpTkg4EUDpo2KzAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6tmqAk9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc32756139so3952131a91.1
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 10:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740162682; x=1740767482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BTnOo2YjqSquDTCdAxd2i7qsjhjjRtZFuvn8H27ULQ=;
        b=L6tmqAk984r+clKr/5ZON7jVm13rCm3Xya9dgU7DVGsGPiSmXRbe6YhDDVPC8FishB
         ow4ARReTLilW/1nuRj1F13GtZV8DhCnc1N5v7s2rVGotfGqu2TIJ4P5y8zEknSMIy39Z
         tsgQ9wJY0elTAHrdwWB+RKPBpGyGkQg/YRcQ7WxhNzXXcn1IOqlRTCpNlQl6o8f6tbZF
         Ny8mWr57wdwIZ44Eqj2iNjkvKLmb0D84yamz1cqTGEE0VMGeATQMALFfxNbkiqB34kC6
         EaJJdD3Cx5C8PFvAOaoMvDYR9Sm117N7sx6xPt5W/VWMW1f2W6KcAKA2f4n3xkKUheS9
         3KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162682; x=1740767482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BTnOo2YjqSquDTCdAxd2i7qsjhjjRtZFuvn8H27ULQ=;
        b=BlPTUVv3h9W9PRmtocr4PinsGGwC1DMHt+uRJg36kMgmlmQBKupRaQEn8zGnlqqJqE
         ysoPQZZlsnfKpYKhOtTbKT4AZ16znDWoXVwoQZgH7ffK2EkBRm2crpabFQwmQV+RLH19
         fzM/iedZjyVH/6q6RevYp6eQwixnfzeRo37XOx8tfZf/sZneEPY1q2xtBXa0teVAC0/O
         ZdzqRsrpusopIwuUYKPh36DoAqBXlENs4EizcxtY1Yc6j3Mp6UHhtAACRS53GB8LaYgY
         rm5miNom0U5/O7aH5zggf61T9LnJT4/Ciy4UZYJM367byCKFw+ufZIdIxR1VTc4aXVoS
         9xbw==
X-Gm-Message-State: AOJu0Ywn37HU/O7yf0lG6wmEB8/gvG3OaMjAXn7ID+xjP+j6+vOcV9M/
	rI8b1DKgyKhJ4bvliNMq1MGhr8M01HX4M7YaFmIrpz3/xjzExq54s4H7/pA7KCFLU0SoL1X1/1E
	sUBc+hrEoUH2kSuJSb98vZOF15Mdp5ICP
X-Gm-Gg: ASbGncu89Rs23Ap64bk4tK4XoTzoQ1Up2viB/0RfrITsZOKU6dCrDrO1sFtcuDI8IOA
	CNfNCCcffBA0Rp5oWm5MU5ejcV15XjigDaA/GZ8lmrKJgVZ0H9Uec1vlXrBwZJcDILXBjaSPog0
	oC5sjqXA==
X-Google-Smtp-Source: AGHT+IGcLfnngowKXfdHE6fH4TEAZtFrylrsWtSnisCqpCqzhpoZDM/VPWrnhx6lpkaFUZq0byRMvZ7sZH7y23dhc/s=
X-Received: by 2002:a17:90b:4c50:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2fce86adfe3mr6031080a91.8.1740162682058; Fri, 21 Feb 2025
 10:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eac572ada2fef3516cb1fb7977f721f738d76558.camel@gmail.com> <20250221004104.2855261-1-nandakumar@nandakumar.co.in>
In-Reply-To: <20250221004104.2855261-1-nandakumar@nandakumar.co.in>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Feb 2025 10:31:10 -0800
X-Gm-Features: AWEUYZlOiAFWROkWvWnqFV34ZQRlAOewHO5Guken--2rV0iTu6sLF4LpMZrc664
Message-ID: <CAEf4BzYQ0m0cxFJnJp4MWbv2CjDZvEr8zMvEQN304-68+msA5w@mail.gmail.com>
Subject: Re: [PATCH] fix: out-of-bound read in libbpf.c
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:42=E2=80=AFPM Nandakumar Edamana
<nandakumar@nandakumar.co.in> wrote:
>

You need to provide commit message here explaining (briefly) what you
are trying to do

Also, please use "[PATCH bpf-next] libbpf: " as subject prefix

pw-bot: cr

> Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 194809da5172..1cc87dbd015d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2106,7 +2106,7 @@ static int set_kcfg_value_str(struct extern_desc *e=
xt, char *ext_val,
>         }
>
>         len =3D strlen(value);
> -       if (value[len - 1] !=3D '"') {
> +       if (len < 2 || value[len - 1] !=3D '"') {
>                 pr_warn("extern (kcfg) '%s': invalid string config '%s'\n=
",
>                         ext->name, value);
>                 return -EINVAL;
> --
> 2.30.2
>
>

