Return-Path: <bpf+bounces-60611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99092AD92E6
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 18:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A231BC0810
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1D20E330;
	Fri, 13 Jun 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv5PLTlt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798D215078
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832509; cv=none; b=gcHzb7ryWZhyNAYk+YqBsIAtsvYJ5gSicEnqjQywakErJXGYnG5OijTHOg4AyzeG37uybIIN9mgAODjo8jx8pDL0UNYlxVOlJBImG9+5+v9t9Bb4CHk6Tsw84IXEIh4JKPgduKf5rJgvjes6+Iwot9ypgCGjU1hPMgdknm1jT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832509; c=relaxed/simple;
	bh=K5Pxk7i1+2PO0H3ADt4t4WDsFNHaNJkeXgBSNQ6yDRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3aCzVAfTMonCAnwzmrIrq+fJZNMuT53WF0fFd1ZlQ0f/gYq21mQ8LRiG4tqLpF+n3O6hwotBmHb4XoiGRRLhESbJ9K987yjLfZgYATbZ6CO0LTFT/uZA16zNUqfoMOpMkcSC9wBhUz8MXgrY5uWZBca+4RgHrcECuiUi+v3N2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv5PLTlt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af6a315b491so2065234a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749832507; x=1750437307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax9ln1X+J6KYDVYWIxH/Cc0XXGJ0auxIRE7Gd6ZvdPk=;
        b=Gv5PLTltp6NZkQyIy/dPuVGGIn3jjsM5xC89iGc1Cy2TMKy4U8buHxAqJKDCx6Wxz9
         CC9H86HgfmZvWu2zbvMVlDQ2N5RCmma57Hr8oR12t2mZleNgagpZjN3NDjfO2FtyCBrR
         SiRAdfo+Rf6l+zkvLLP+ZaetdnjTM7dhMfdgFP6lNgaucEies/+XGEauOA9gmbnJfh4G
         i3MrwZUdCkFJevp1+Kum7Jztxxa87k4F+Gqp9W0+4dSEmV1h3swSemivb9hWH8qmnwXx
         L/cgn+04NMMBvEJ0gYEy8fBUzNScbULANdrPcHfnCznDQxRIwuyFlSQOthHGlK2rn2Nm
         blPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749832507; x=1750437307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax9ln1X+J6KYDVYWIxH/Cc0XXGJ0auxIRE7Gd6ZvdPk=;
        b=gM+eik6aMbC1ysgYoyUGcJCBYEvWB0pNGYgrNmtff7Z94+Db6V026RsfYuIgCDt+Hl
         gMHwddHE/OXjXiEIHpXp0sropYn9rBtj/JCcRKc9l7BnBDmw7uIfgIaaxEXaCBs/VYe+
         YPOKL+Pqqj4b//e6qeH4k5Bzn+2wnhCLOASqe6Kd1z8pCHzrMg/UTAsklBQIc6NvY63U
         8qfcJwvahz0KE2/GkABGJN7dQEihvmLA7EbjoqmB+Oyc860PUe8sgu+G6wt40OJrvs81
         5MjMhApU9MsQ4As3QSlEqDwexgkhahRnmu56Hu8v5I22C+UrpTmcX21rk9n2HekFT6Xh
         8eAg==
X-Forwarded-Encrypted: i=1; AJvYcCWuv3A4goPr1cmeiR4JyMGvE8TAHxZlF3ebo/WndOukCYeCwAVaAXCI8nyOGQSYCC5+30U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IJb1ogmi4zqrvLYJNC2tjn0AIXic+4Qb3hEX33i8W/6635af
	XWWzE3KIFp39XmsZ9A034VtVrisMmg8UrzuOlDjTcdhHMb0X8ki6t4QRAO0v6X1RXOqkMm8HS/W
	5rrV76ybYpSrcQhkRMTBy39cGMYrOFsw=
X-Gm-Gg: ASbGncsWHXirprHXfNs8xizf+JgvjMSfViRy1t6xpjXvSNmbzM9XaYFSCkJVreHaE5/
	LOdN5klxDZjeqiG0QF1/xIDoYw31F5Zs9uL5q75TQun2dTTuWXXDA23eNYxMCembs2DFSOHdbJS
	/QHuwejZ5ZRkya/jETC7HFFmYHiVq5ZKrPE6nnZFgwQSbny4HX2SToD++Ada2NVfkM+3Bdlw==
X-Google-Smtp-Source: AGHT+IHwFKEvaE0XpqQX0dJc20XRX9z16i7gxsU95Uc34i5n/DMfI/HEnirogR19pDH76aF73K0Lz6hiPs9gUjqAYF8=
X-Received: by 2002:a05:6a21:338c:b0:21f:4f34:6b1 with SMTP id
 adf61e73a8af0-21fbd4bbd75mr57817637.14.1749832507101; Fri, 13 Jun 2025
 09:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com> <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
 <c1cb9bd3-c99d-4af3-bbcc-2ff3c2250ca1@gmail.com> <8134154a25af0153411c263df923acd350253c25.camel@gmail.com>
In-Reply-To: <8134154a25af0153411c263df923acd350253c25.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Jun 2025 09:34:55 -0700
X-Gm-Features: AX0GCFvkjtr0ciZ64AHPqfMMAvi31B7qHiWOmQJc0CVRccWraToektmDFAh-JPM
Message-ID: <CAEf4BzahEMFWhFX_1AzYeKHY5FkVQiD5J8x69PrRUGhqNHyu6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> What do you think about a more recursive representation for presets?
> E.g. as follows:
>
>   struct rvalue {
>     long long i; /* use find_enum_value() at parse time to avoid union */
>   };
>
>   struct lvalue {
>     enum { VAR, FIELD, ARRAY } type;
>     union {
>       struct {
>         char *name;
>       } var;
>       struct {
>         struct lvalue *base;
>         char *name;
>       } field;
>       struct {
>         struct lvalue *base;
>         struct rvalue index;
>       } array;
>     };
>   };
>
>   struct preset {
>     struct lvalue *lv;
>     struct rvalue rv;
>   };
>
> It can handle matrices ("a[2][3]") and offset/type computation would
> be a simple recursive function.
>

Why do we need recursion, though? All we should need is an array specs
of one of the following types:

  a) field access by name
    a.1) we might want to distinguish array field vs non-array field
to better catch unintended user errors
  b) indexing by immediate integer
  c) indexing by symbolic enum name (or we can combine b and c,
whatever works better).

And that's all. And it will support multi-dimensional arrays.

We then process this array one at a time. Each *step* itself might be
recursive: finding a field by name in C struct is necessarily
recursive due to anonymous embedded struct/union fields. But other
than that, it's a simple sequential operation.

So unless I'm missing something, let's not add data recursion if it's
not needed.

