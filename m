Return-Path: <bpf+bounces-13560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B42E57DAA47
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 02:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD811C209AE
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 00:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFAF37F;
	Sun, 29 Oct 2023 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGAceRgF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FD194
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 00:35:10 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3890CF;
	Sat, 28 Oct 2023 17:35:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso25250395e9.0;
        Sat, 28 Oct 2023 17:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698539707; x=1699144507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS7Y559AL9PnRQo40p95lHzJM1VgGmHa3eWt5sGpaX8=;
        b=lGAceRgF8Sanw6zwh5OuwT3SptdnFc8Le+hXV9ls06h0K8mnLgGG/xNGGeh2j4b06f
         060Oas/UW6aBR9K8Lph+3IyHKvdeFWi6khsaCAnszZA6shr45zVsby49sV6Fh4YTF5QE
         h46puIhwOeaZReu7uu3iIL1+KC8Kt9WgXPm1OJrxE9qRPMm4hlIYspXkyWej5twMyY9F
         ZCJTgfutSBEsVj7AxlLX7UUykwh1RagQVqx1osz39uyj6U5y76XxSjfOrqgUWPPvyEYV
         0Gob06JGzNJ2l+o//y0EkV8ZBQ2Y+1IXCn6KXwYICqQM4hveIocIyPUnIQ/Va1xzddTj
         FlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698539707; x=1699144507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS7Y559AL9PnRQo40p95lHzJM1VgGmHa3eWt5sGpaX8=;
        b=mWa7wIWmwzHM90sUdEarST5IQhVzImUBQqTy4sdWgvCq+2RU9G2RozC3SEgANmBA6Y
         +DMKxDIDwLGUNB3tteizvjJ271RFXr23RiyxWXs//ZdRK96IS/45VhlteUnpTr5GACEl
         bbb03DOflh3PMP84IZ/yLOgtaGj9jniWUjzgAwFFrDK6r8kNNVWJDiouKu6vZLkLX4iw
         pJHFXZPif+b2TguPDTB/ZcAD92tvC9Uf7LZspVITVyf+N8SmgKbNhtehmcQx6bLMmRjz
         YhLmoZhpsEkFHzmUfTehfAdobA8b2nOjU0/2DDhULybJ9Y4jckhuP7un1mGcfEbd1HO3
         LEEQ==
X-Gm-Message-State: AOJu0Ywm0RbyfwIZFmBchwOpnm1dKq9H/gCvO5FR2V1to8yfNCM9xo1K
	ReVRQTDTPx/Prw6gFThkQ5eCYqgrvtTbvzfuKdbUGRh0
X-Google-Smtp-Source: AGHT+IE2dFXcFRmLhFcEU5hNSnkvWZ0TCNnYHDviVbzpwbXG6rdroqwG485AvDQhZNdTBN3Qza1LBrFDDMBHcMQIHWg=
X-Received: by 2002:a5d:6dab:0:b0:32f:7bf7:857f with SMTP id
 u11-20020a5d6dab000000b0032f7bf7857fmr2720029wrs.18.1698539707131; Sat, 28
 Oct 2023 17:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY22BOUCns43Rza5gXCBtEKbdRqXxOTviZQOjjDySYGHQ@mail.gmail.com>
In-Reply-To: <CACkBjsY22BOUCns43Rza5gXCBtEKbdRqXxOTviZQOjjDySYGHQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 28 Oct 2023 17:34:56 -0700
Message-ID: <CAADnVQK2nsdzviA1q_tBuh+7g6Xo6wZY2VxGR1H4ag40nNrSgg@mail.gmail.com>
Subject: Re: bpf: incorrect passing infinate loop causing rcu detected stall
 during bpf_prog_run()
To: Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 2:09=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> Hi,
>
> The following C repro contains a bpf program that can cause rcu
> stall/soft lockup during running in bpf_prog_run(). Seems the verifier
> incorrectly passed the program with an infinite loop.
>
> C repro: https://pastebin.com/raw/ymzAxjeU

Thanks for the report.
Did you debug what exactly caused this bug?
Are you planning to work on the fix?

> Verifier's log: https://pastebin.com/raw/thZDTFJc

log is trimmed.

