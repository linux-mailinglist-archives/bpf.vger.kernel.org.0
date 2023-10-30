Return-Path: <bpf+bounces-13597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD97DB81C
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 11:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CB128133C
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451111CB0;
	Mon, 30 Oct 2023 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPfLOFQ4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D084D53A
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 10:29:51 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A7FC0;
	Mon, 30 Oct 2023 03:29:49 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso3622245276.1;
        Mon, 30 Oct 2023 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698661789; x=1699266589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5P0KAfGZ4r/a+034RmSbTATHD3Tt63VpMU8Ct8RXpgU=;
        b=CPfLOFQ4q8HeAjJ1JeIFzQheL8Ar3m1uOJfkbepTqIMbcB3YEMepXQvXqlsEaqNvQr
         6V11uML5YXn2SNeXABEAtbjmgkn4D9SEHTPGM4qWRkBMRNCtWeoBB6c5jLvPZSfvPbev
         8C7gY352/x9xPJ35dYjEf6kiKFgZHroDCJFStkOX6miHsVCsJj3uY8fbzdicjtXAOjps
         ozMBEB/xScqNMO0mXiheynkdiCPXeWRLL0IoQfF5OH9tIIAVQm0j/TWoD33RlLZjwrYJ
         rLiG9sFEiV73d9YbvTH58fIyODP/aNroeABn9KjLAQHBf/EssYYsXZ7WFmQZCIYkpHZ8
         RI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661789; x=1699266589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P0KAfGZ4r/a+034RmSbTATHD3Tt63VpMU8Ct8RXpgU=;
        b=hvADABjWUK16CrryNdlF/Etzy89zoQthOwcOHajSbd2z14kpyj+Iy3hWetxwrpY1cW
         qUmLOSERHfQgsCdK0QQ5lv5f32p+18lo5OgVEe2HzvRTcnXpsitwyUDuITTOisgmM9hQ
         Rxi30IzmtZCooTH/2Lp/zQkXKNY8mcGvAD65D6lG/qwSf+Zxc2E7uogg8V1UemokgJfW
         CQ41xVQxYLhUFT5FJeYoyuNl/xWgqs+L/YqCSv0l8yAR+WGGhBSa5MePUQ3GK2Gf4N6U
         YJz6qa2G/KHHbCX9vrj4VMcRkjthZ7jot1BdW5UkLyLSKMOISy2erkmLheXnxlx/KdSI
         5RWw==
X-Gm-Message-State: AOJu0Yx+W4+ejI+LRrjt5P54/91CgzGX9ZPbLYr+QfsM1LLTUvLyH3ol
	WfTnB1ZJVCoTIEhbJe9Q4MbY8a4NR3cy9GLLjA==
X-Google-Smtp-Source: AGHT+IHmxy7N61wXlg9jCKGsMt+WcfBOhgsVo2CdaUZTDROvujckXfAJje8ufPvPWe3EUFC1hQXz8NqoInEuKgtwxag=
X-Received: by 2002:a25:3447:0:b0:d9a:3c95:a3dd with SMTP id
 b68-20020a253447000000b00d9a3c95a3ddmr7903113yba.63.1698661788793; Mon, 30
 Oct 2023 03:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY22BOUCns43Rza5gXCBtEKbdRqXxOTviZQOjjDySYGHQ@mail.gmail.com>
 <CAADnVQK2nsdzviA1q_tBuh+7g6Xo6wZY2VxGR1H4ag40nNrSgg@mail.gmail.com>
In-Reply-To: <CAADnVQK2nsdzviA1q_tBuh+7g6Xo6wZY2VxGR1H4ag40nNrSgg@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Mon, 30 Oct 2023 11:29:37 +0100
Message-ID: <CACkBjsZ5iYQRc6_EREhKA1cg-dFtopSOKQhDo+6SgDnVrz+vcA@mail.gmail.com>
Subject: Re: bpf: incorrect passing infinate loop causing rcu detected stall
 during bpf_prog_run()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 2:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 27, 2023 at 2:09=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wro=
te:
> >
> > Hi,
> >
> > The following C repro contains a bpf program that can cause rcu
> > stall/soft lockup during running in bpf_prog_run(). Seems the verifier
> > incorrectly passed the program with an infinite loop.
> >
> > C repro: https://pastebin.com/raw/ymzAxjeU
>
> Thanks for the report.
> Did you debug what exactly caused this bug?
> Are you planning to work on the fix?

This bug is really hard to debug. Here is a simplified view of
the original program:

loop:
0: r4 =3D r8
1: r1 =3D 0x1f
2: r8 -=3D -8
3: if r1 > r7 goto pc+1
4: r7 <<=3D r1         ; LSH r7 by 31
5: r5 =3D r0
6: r5 *=3D 2
7: if r5 < r0 goto pc+1
8: r8 s>>=3D 6
9: w7 &=3D w7       ; r7 =3D 0 after the first iter
10: r8 -=3D r7
11: r8 -=3D -1
12: if r4 >=3D 0x9 goto loop
13: exit

At runtime, r7 is updated to 0 through #4 and #9 at the first iteration,
so the following iteration will not take #3 to #4, so #3 can be ignored
after the first iteration. r0 is init by get_current_task, and r5 is always
smaller than r0 at runtime, so #7 to #8 will never run. So, the update
to r8 is only #2 and #11, which together add 9 to r8. Since r4 is set
to r8 at the start of each iteration, so it's an infinite loop at runtime.

Based on the log, the verifier keeps tracking #7 to #8 and to #9, and
at some point, the verifier prunes states and path from #7 to #9, so
it stops checking. The log is huge and hard to follow, the issue is likely
in pruning logic, but I don't have much knowledge about that part.

>
> > Verifier's log: https://pastebin.com/raw/thZDTFJc
>
> log is trimmed.

Full log: https://pastebin.com/raw/cTC8wmDH

