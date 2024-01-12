Return-Path: <bpf+bounces-19391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F582B8C8
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 01:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF609284ACA
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 00:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741754A17;
	Fri, 12 Jan 2024 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD9mXryu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856524A10
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3376d424a79so3951607f8f.1
        for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 16:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705020785; x=1705625585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMeafTQJO1BldHOtBAEa89L5Qyke1/cNRwU4IjdRVw8=;
        b=ZD9mXryu5IjYEhspooQnnkxBEhr328S5+MWfXZcT/hLqXMjy8Pb0yv9GS4822n1uwm
         1glx7ZFExJZ7vgzY8nH1XSCpFqII5lrkUoRtOF58b7gN5B6xVTaqg28yV94uvYI+pq0O
         DNFoV7GyvHvMOdxCRsQvT2/SkucXeliW+gaOCOcW8v3cTOjlsuV1aWOt488sEZn+MIpM
         yd+FdorAArAK8SPVnKtLO/5bvfrBq0QLSn6k8eiwQ4uLOv+EwIGshOiSH+4E06mYtxfL
         KMTdokJFvp/9hREsauIFq86P/pJ70GGG8WpyMQsiCi0lkfq+d9tEYcyBrpRpJKJJ54xx
         Cgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705020785; x=1705625585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMeafTQJO1BldHOtBAEa89L5Qyke1/cNRwU4IjdRVw8=;
        b=adosnPzBOGhUqCMY4d188F6n7EsW8HGIQ6BmpoKRZ9aPTnFj0pAjc1f28WBd+0wIKZ
         MXbizFAkLOiUx1483uzVi7z4c1blI6X0Hd+rFCBGsFKrAwlp20+42O7XGgmj1vkh/Sap
         vrJkERUgh0oyNPKGNwpSeOaXbz2q39F1EAFcsuuGp+qvNz530xk06Mo4MQ90p9CCEWM0
         EAgSk6JRyuIBHo9w5u4qG+S929GomWIUB/6cvZX45IRJMgjnxRVuUedgpSZqk1cUO7sS
         CeBQCKZzhElD62XccuXlhZOePzmUw6Lpxdsxo+sZPx8nCNefjpcSlakV2Xoh813bsQve
         OplA==
X-Gm-Message-State: AOJu0Yyy1Fu0pOvAlyc3gpfpd4WPBtfzC2nphQcYS2cRI+Wci7wXOZgj
	0sysdYmYXU899qKxqMbWwVPCxL4lq5bSYPasdLAsDKlc
X-Google-Smtp-Source: AGHT+IHLIhQCofoip3JVeRtxXT3dGOCgjTjU9EC38uszy+vR46QCr5H9/e7rzCb/fsP+2l4x81Pw5QhAfMikM7zs8A4=
X-Received: by 2002:adf:ce12:0:b0:333:12a3:644a with SMTP id
 p18-20020adfce12000000b0033312a3644amr312041wrn.18.1705020784463; Thu, 11 Jan
 2024 16:53:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZaA6-k5pU5nZJZtI@google.com>
In-Reply-To: <ZaA6-k5pU5nZJZtI@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Jan 2024 16:52:52 -0800
Message-ID: <CAADnVQLg4PMrJs4_uFkbSiEpCcXkYzLGOZeDtCZ0swkz41O04A@mail.gmail.com>
Subject: Re: [ANN] bpf development stats for 6.8
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:01=E2=80=AFAM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> See the netdev posting for more info and context (there have been
> some changes in the methodology):
> https://lore.kernel.org/netdev/20240109134053.33d317dd@kernel.org/
>
> As last time, I'm presenting raw stats without any evaluation. I'm
> posting a link to the previous cycle below so people can do the
> comparison if needed.
>
> Previous cycle:
> 29 Aug to 31 Oct: 4798 mailing list messages, 63 days, 76 messages per da=
y
> 577 repo commits (9 commits/day)
>
> Current cycle:
> 27 Oct to 10 Jan: 5795 mailing list messages, 75 days, 77 messages per da=
y
> 624 repo commits (8 commits/day)

Stanislav,

Thank you for collecting the stats.

Despite several big holidays in this release the messages-per-day
count remained the same.
Which may mean that we will see more patches in the future.
Which means that we need more reviewers and people who develop patches
need to contribute as reviewers.

> 6.7 stats: https://lore.kernel.org/bpf/ZUP0FjaZVL4hBhyz@google.com/
>
> Rankings
> --------
>
> Top reviewers (thr):                 Top reviewers (msg):
>    1 ( +1) [10] Alexei Starovoitov      1 ( +1) [19] Alexei Starovoitov
>    2 ( -1) [ 8] Andrii Nakryiko         2 ( -1) [18] Andrii Nakryiko
>    3 (+13) [ 5] Yonghong Song           3 ( +2) [18] Eduard Zingerman
>    4 ( +1) [ 4] Eduard Zingerman        4 (+11) [10] Yonghong Song
>    5 ( -1) [ 4] Jiri Olsa               5 ( -1) [ 8] Jiri Olsa
>    6 (   ) [ 3] Martin KaFai Lau        6 ( -3) [ 7] Martin KaFai Lau
>    7 ( -4) [ 2] Daniel Borkmann         7 (+20) [ 5] Hou Tao
>    8 ( +5) [ 2] John Fastabend          8 (+16) [ 4] John Fastabend
>    9 ( +6) [ 2] Hou Tao                 9 ( -3) [ 4] Daniel Borkmann
>   10 ( -3) [ 2] Jakub Kicinski         10 ( -3) [ 3] Song Liu
>   11 ( -3) [ 2] Song Liu               11 (+39) [ 3] Christian Brauner
>   12 (+27) [ 1] Christian Brauner      12 ( +1) [ 3] Shung-Hsi Yu
>   13 ( -4) [ 1] Stanislav Fomichev     13 ( -5) [ 3] Jakub Kicinski
>   14 ( -4) [ 1] Simon Horman           14 ( +5) [ 2] Paul Moore
>   15 ( +9) [ 1] Paul Moore             15 (+26) [ 2] Steven Rostedt

Great to see new names in the Top reviewers category.
Keep it up folks and huge thank you to all reviewers!

