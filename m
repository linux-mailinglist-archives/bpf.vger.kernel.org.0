Return-Path: <bpf+bounces-40109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF19197CEBB
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 23:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282E1B220DD
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 21:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5E1419A9;
	Thu, 19 Sep 2024 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zjsyjf/y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5422612
	for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726780674; cv=none; b=eyplvZG91YP+g2X6f6nKhJUSJjccXcVQggsDUBxosZDOhihP7wTy0jMkeiQm8zG2ABjwE9OcJO8F2QQTEV5r4mg6VTW/AF75O1LuFLIPBeXaw/pvJngpoM/LVywmjzYDOepIwdDxIAXNLc36J3FaVGmsIjwkrWphX3Cjx2rspJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726780674; c=relaxed/simple;
	bh=3e/ldCppbzIZhbUc3nGQGHuSz7LYIi+xVArqOB65To4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9zOmfqCPd3MPenuD/DwYQUrLNcUObWoMRXnAmQsRSQedUJXcFtOsp4XWOu56UL2REMaTn3Lsy3jfrrqkG+zFhsKW6K8t1H9vuTQSqWxe0cMUU/YZ+8yB5EGnVd3Md1gkH3r7KbIoCEZ1CKn2nAr5KpB/fz+1E6cUL3dkn++1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zjsyjf/y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso15951885e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726780671; x=1727385471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv4batBtoDBjI0QZrQGt5I5mDqayFHqTcFgRwPmQOHE=;
        b=Zjsyjf/ykcZPZKZ2aNz5/IxCsUVZV8pVNW1HTA8up8VjZlobjxlbS20nIwo+3FKHB0
         vZib3IJNcd/LHCnu0q4zpT/3U4favEkuEftnLVsr4mIwuybddAgyimY2SVtXilE8I0UG
         m6t1kIWrtmPKfYUJ8TLBKIvOBy5kFu9x04/VROklBpjIY3IUGdeX3acdmOMbbHRjl+bf
         S8pLUp3rWIP+ogFu5Z6krrywwldGlWKtDLhB+yt8hpTNnZcjFtw28E0bZyjSpELaxuXd
         oTOqSSrP79GnOBXdT3EimcqPeCB4C2lfcdtXojID/IBX0Yvt96+1saBTG6GbBpYbM4Bw
         QdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726780671; x=1727385471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gv4batBtoDBjI0QZrQGt5I5mDqayFHqTcFgRwPmQOHE=;
        b=WFn7mE6vXk72N3mkhVzlZH7MFv1RLcfxHnWVqQT11O29AywKCbzx0D1CsDf/OETCL1
         3s70t0AHsCOOMygwIkhYGfR32h9KCFTcDX3Hk+tPq4Ws9WqwJ4xBwcKcyGSVsSbhLnHY
         cjgSPf7lLjLUshLZk7ZqAo4UNqBq1obvgK0gHhGozzUzIkOagkldeXtu0xCBr3ChNDWW
         ajj1QEf0O6QNPrHCUKun6QV1+cI7wW7hVSlOeCgMvaTHvSz2sNM1MhCvGZBVLWdvr4sZ
         XUQ5tI3l2Ea99Jcgprj+tKF4hwTOQxMFMAk2/qEIEOIKOI0/Ca3I7nQgF7C+NgnQYRO5
         jUcw==
X-Forwarded-Encrypted: i=1; AJvYcCWUJ2um94uZaTt62u77GRcteEs/XrW+4a6vdzh7k3A/Gn940aaQYNiV9xYNYnyYvo0QcVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZqyh7g87oioWZxH+t1XW6aLVDb3ay7XMzOmrzBwy2RliWFmj
	w9tbQe4IxDo6hz5nX606qtwB3TLCQ3uORmaphjcp6hQFxLEveZvxV6IdV+6aFkB+IVBHqsbxM2Y
	YuL+T/uovZ2iMT2+bOalg59VOZHQ=
X-Google-Smtp-Source: AGHT+IEMTDECO9j+7tG9YqxF/m0OjCU76OHbS1/+5MuEYAGVPMGKe75KHU3ejEWo/zjFzun22abe8mcakhZLM2DQsWs=
X-Received: by 2002:a05:600c:1908:b0:42c:c8be:4215 with SMTP id
 5b1f17b1804b1-42e7abe3ef3mr5635275e9.4.1726780670968; Thu, 19 Sep 2024
 14:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919195454.73358-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240919195454.73358-1-kerneljasonxing@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Sep 2024 23:17:39 +0200
Message-ID: <CAADnVQJUd_1y-Ecgw3pgd6z2jw6=ZEm5wnxQqwUnhCobw752fQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: syscall_nrs: fix no previous prototype for "syscall_defines"
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 9:55=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In some environments (gcc treated as error in W=3D1, which is default), i=
f we
> make -C samples/bpf/, it will be stopped because of
> "no previous prototype" error like this:
>
>   ../samples/bpf/syscall_nrs.c:7:6:
>   error: no previous prototype for =E2=80=98syscall_defines=E2=80=99 [-We=
rror=3Dmissing-prototypes]
>    void syscall_defines(void)
>         ^~~~~~~~~~~~~~~

samples/bpf/ doesn't accept patches any more.
If this samples/test is useful, refactor it to the test_progs framework.
Otherwise delete it.

pw-bot: cr

