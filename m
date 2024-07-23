Return-Path: <bpf+bounces-35311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE99397B0
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B89F1C21960
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58831132139;
	Tue, 23 Jul 2024 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eos0tHbt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5BDDD9;
	Tue, 23 Jul 2024 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721696298; cv=none; b=qLbC5+2selHKcupsaFJSI7XiB/r/9n3o0Z7yTuzAK5ezAEZAAh+aGsqJfE6UCiem4luKz6uGLn0Umnn0yLGGC2cPbepix8CDiKmVV9oXOiwgv1axJoDY4MM3xI/V2gGryK0TxuvSE4EyTY4cUpxeKDRmbXtPUAItMGkWqgU2yZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721696298; c=relaxed/simple;
	bh=jNKx+8ksTum/QjvOZDoSVUzlNUyt+hfcwx9HPLkiOgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p05xVlUFtxfqxY3+dFQAJ9W9ATQ2uJrkhlxJ/fnP7v34IDx9o5j1GagIRH24juY2kWvGYrd+EQDBNwLCO7Gh/OtR0ezfZtpubK42dx+v+hOXZBrttA0tQZr50Ay86YLTtgJgwoKIK2B6vGTuzPI41b+FIfR8Bf/UbFO4j6wyxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eos0tHbt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3687f91af40so2539927f8f.0;
        Mon, 22 Jul 2024 17:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721696296; x=1722301096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+Obr/KwoU/zR+6X5+KgACiZFY8A9TGNwEdB+W563Uc=;
        b=Eos0tHbtuIJ0DSH4KdBKeaFrGTe+JPdrYKLKX7YeLdoRY8FiKcr7SEsFi8FWygVCkl
         gZYf/nazvxpbm0DOgwQWCTwAs/kG7nqCZkQra5f8/1XwU7ptlCdFg8pAq6QuBqldBt5A
         QcRGYD7G2WfmIJ3wrMRzxXnGU+9vE4tjCp9IrhFeU3Vt7GelnAW2vTWn/ghznTPgDsw+
         O8kgHfE9/70ENiLYCfi3roCXMKV8zmNzoqySWV/qTUHwR276eSIu0cVq1UB3xJuEYZoG
         31Xar+EsFWpWI27mSsrykxyAyhwX/OU3cKbX5yQDUDaV8g0OK4wMvk967frnBFN3NadS
         YS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721696296; x=1722301096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+Obr/KwoU/zR+6X5+KgACiZFY8A9TGNwEdB+W563Uc=;
        b=iwr6Iasgp9zrfMq2L6uOal+mzZTqesPco1yRjJk3uIE7PG3L02PHYj77Sv8ibotHdq
         zBue+cN+fd4LgkX8zQHDRfDbzhk4ejXuSimRoTcuMCdmftQtU3hNotxFmNri/LICZrW8
         5JfE40rkKSgi0DZxdEl5mr34Q5lIg8j+C1fUT/R07uo6VJbJJI3Ei1aOR6bLIJiUOOFG
         7Ev2RvIHI4EjLOHYa8t6IBnxi8JC/hOXMr4IhN9AFBoLwkAhYOnF6TQYEsk/v+zqYvhu
         x32VJpVv2awH9HsEjMyACYwCOe5s8weyQVcX5t9WL/gZJzBZwEq19dSyuR+8rWJAjlnK
         bjPA==
X-Forwarded-Encrypted: i=1; AJvYcCVAyYpmu38/aBWYcuTAWVnF85qwPS2j1+2ebKS45qU8mk4kTYj9w93wiFV5ycFNPGtFVwo5qHmCAmPGHApQBCOMWEjGuQIr7ZsqfET5m39WXUyWDhUCs/qKteQV0YB3wIfsNua1or1BW095SM5+S3rjr0Rw/Kjt6HVI
X-Gm-Message-State: AOJu0YykQ6eLNVp28pISisVEgQ8d7jpaV2aOCFw7RLLjR6zQl6nP6JWX
	JCJ8ht+vn04EH9dV/2g2DXEDCFLabtun8MpEjlgoAeMxRkRNf+a562oHL/o/K6WIHlI1VGdr0Gn
	yiQm+CmjhKPRqklK4RReZx/3+5Pg=
X-Google-Smtp-Source: AGHT+IFT/fNclE641GX8kuYdrFL94P7RRUtXO5Miq33OffuA+Er07QYSgmK1Rg7mPlUHdrdlZI+YsM7z3lOSZ9e9QBQ=
X-Received: by 2002:a05:6000:1284:b0:368:7564:5a1d with SMTP id
 ffacd0b85a97d-369bbbd886amr5657301f8f.35.1721696295508; Mon, 22 Jul 2024
 17:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so> <CAP01T76LCr5GdihuULk1-qB9uLdn99B1fMmb2vMHBJUos+yHKg@mail.gmail.com>
In-Reply-To: <CAP01T76LCr5GdihuULk1-qB9uLdn99B1fMmb2vMHBJUos+yHKg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jul 2024 17:58:04 -0700
Message-ID: <CAADnVQLsqV2q3Ury+p3_6n4eph+TWAVRFSVWst803k6XV_qf6g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next RESEND 00/16] bpf: Checkpoint/Restore In eBPF (CRIB)
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrei Vagin <avagin@gmail.com>, snorcht@gmail.com, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 5:50=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> >
> >   > Currently we cannot pass the pointer returned by the iterator next
> >   > method as argument to the KF_TRUSTED_ARGS kfuncs, because the point=
er
> >   > returned by the iterator next method is not "valid".
>
> I've replied to this particular patch to explain what exact unsafety
> it might introduce.

What do you mean?
I think we can make the return value from iter_next() trusted in
certain cases.
For example bpf_iter_task_next() returns task_struct and it
can be safely marked as MEM_RCU, since the whole iterator is
KF_RCU_PROTECTED.

