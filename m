Return-Path: <bpf+bounces-18228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E00817938
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5042A1C25CE0
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548B45BFA2;
	Mon, 18 Dec 2023 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoEcdwVj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A3125C8
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso4363822e87.2
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 09:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921992; x=1703526792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EsLUBcRlVOVtG3aPAcSTUCcrhU+3PKi+lH+7oLVNV0=;
        b=eoEcdwVjCr0l2H3qEwOeedB+UXzr74iU0O9y6OyV9dGj5PhWBO+PUSxoCMSKTN/HGK
         1afOZmpinDPdXbzRXAy34Exacump+CrNxpGd0+Llww8/gB4qZDhyE00n3jA2qVr2wsB3
         4c6SXChXzd3WP9qsRDK3Q7w7b26Mv3vTbjjQgHb1t3ZEPVnm722lxcBQxsMcvTnMRMpV
         eEmYMgWEDxLo/iHAY7N+uWFCm5JsF+88bJzyDUKDEm1E2j8CNckY39lFsUTfve4N9HG6
         H8elV5/3i1jKRxQYFKGb2xXTnyM27RMsDbrVkT3VeaFwyzBNYvipRzsCZjc6ZoZeU7kQ
         0htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921992; x=1703526792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EsLUBcRlVOVtG3aPAcSTUCcrhU+3PKi+lH+7oLVNV0=;
        b=VFGGbvmA6z9KkavLxQjCwSC1557YFvBLAji+Ji5mZ6zWnFxsnbZ93rjUMI5Qq6vETk
         F9bHPRz/Uz6CfzBHGZMmqvLOVUxPhyEVcQ2i+YlnABnxIT0zx4aYIU5oCvzKAt8KD18P
         bI1ynom+SvYHw8/sQA6XR/NF93HRCUz4PZSGraaCGTtPj0lSEiGQo4tVf84s6FAHumuM
         KuKs9lRvnuuKWPgbIdcWd1thQ/e7e6T8Hwqex7qaxnFkrJaAmA9sBMB9VlcgaogotZbR
         iGtlcM8MO+NBhnjs6vR4UkU9yaMJx7DNTwMttEC3Vooiq73WFSHNHrvobFj1+NHDiymX
         rzYw==
X-Gm-Message-State: AOJu0Yzs1HlNO87T8RtrHFe2yTkoR9l9G3vc9sfyiRLZoObfkSsDNtP3
	j7ac80+Gbw5VZ5dPEsIi22HPuTVjpULYybjKwWI=
X-Google-Smtp-Source: AGHT+IGFGeaERujednEocrj8GhGs3fNzsg5/qfXW+/zKdvwkkWBRhCZ4ZRYTByF9d49L9xycfkW5n4X3cTWNmGEzZF4=
X-Received: by 2002:a05:6512:3f7:b0:50e:2e66:72e with SMTP id
 n23-20020a05651203f700b0050e2e66072emr1445293lfq.56.1702921992259; Mon, 18
 Dec 2023 09:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217215538.3361991-1-jolsa@kernel.org> <20231217215538.3361991-3-jolsa@kernel.org>
 <CAPhsuW551fE2Fy=8HLAYJkvttZPaC-hT+nwgrDeHQzwvdZ+6XQ@mail.gmail.com>
In-Reply-To: <CAPhsuW551fE2Fy=8HLAYJkvttZPaC-hT+nwgrDeHQzwvdZ+6XQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Dec 2023 09:53:00 -0800
Message-ID: <CAEf4BzZkVufY-gL8ViMfQRWPkHh1tnca-uCcGLeZcb6DZ6=xRA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/2] selftests/bpf: Add more uprobe multi fail tests
To: Song Liu <song@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 8:19=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Sun, Dec 17, 2023 at 1:56=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > We fail to create uprobe if we pass negative offset,
> > adding test for that plus some more.
>
> nit: "negative offset plus some more" is a little weird to me. This is mo=
re
> like "testing error handling paths of uprobe multi creation".

I fixed it up and generalized a bit while applying.

>
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>
> Other than the nit,
>
> Acked-by: Song Liu <song@kernel.org>

