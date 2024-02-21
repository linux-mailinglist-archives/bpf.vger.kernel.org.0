Return-Path: <bpf+bounces-22372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D86EF85CE8F
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 04:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64DA6B22E93
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 03:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7E2E842;
	Wed, 21 Feb 2024 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="P9ZEzL06"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880012B9D7
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484793; cv=none; b=AfDPcgo6nEr2ZbPsnNyXcKIuoG2Q8T6JsXgnwIv9LG+v161x5ldUywm9JVvMM6cGdsgBav+IaqBk8OkH67cYvBP7/XgJmQSOGeQyPrL45ZdTGFEiGmd7hVxAJ8SuTWlztXB9DTMQttC9/m61db46B3PoBHGyUHlD8N8MnHnoLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484793; c=relaxed/simple;
	bh=7Qyykz5fB4a0+o7/sN39zAOQibndEWz+FsTBhS+hLSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aw1UmInfIm+UTFSK2HNXbBifB6rNDjMbNZAeSYMFiG2LatPQH1nZwMCSSuWVwcrwT+hvBWc8Hr0tI+KFydES2bcnloW2CI7dVwhIXywPgN5Gj/lXxLxaty1vZCnXEXVxbS+t7w7fXI/clniaf3Z/+p8RF0QtJK4FZEmiCxUXW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=P9ZEzL06; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so3995292a91.1
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 19:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708484791; x=1709089591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qyykz5fB4a0+o7/sN39zAOQibndEWz+FsTBhS+hLSs=;
        b=P9ZEzL06fOZFwiwCAvAXlrsctbsf+MGECVUWo6H8SLp53IAzSgnXUtLeKsL9e2O00r
         lhJZMvFDQAUJ6LSo139PnadTxM7b3GZTrQiYCZ5+F5V4ILwDV4Wq1SKGNyMbYG1fsvpR
         NTFNKDsvXqhdpuKblV/7VxGGMzCS+WkBlydlMuJmRlLmYpDabOzlvk5jQv5GSlydaDlI
         btNoHiVH2sGECweU9ZhVxPOXbDtWHzoHEM7EkZIN6A9njOnhZKstzGJaQOcFHNJxdNq0
         RlsmIy419HOd+EztIYYCN/8yDtUH54sb+kOxPBW/XoYaQf8xvMJl/4VlJdCraWw/QuiP
         ddyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484791; x=1709089591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Qyykz5fB4a0+o7/sN39zAOQibndEWz+FsTBhS+hLSs=;
        b=NsUS+vOuy0wIU2DT9OUTwuOIYP1wNwhfBid0//Sb5vAq6HIhn2SF5bqNcTOLGOEsM8
         OJ7cBptQhCKHy3WiaETMXOWxpP8KGZXLHAnRv3fYHePGgV6X31TIwMfq7+jiz9/47767
         Mk9iRx52YZ48NO0wjZrhhqqUCmr8k75aWjlK67oeZbxolC0LNC0BKsP8NbjXYLAyuZc6
         95oIBNOL8/dKWgit/ZQTKy9OAscZpNh//Se/7q1d1B96hnDbcqrg8CZXuogOcQFeULXo
         tolHNoAu1IuOUJ0QwJ7Lp8GePKb7qS5Wv+YD2bgF2f2B2nfeSEJa0tvzL67lmrnAzEVX
         UKQw==
X-Forwarded-Encrypted: i=1; AJvYcCVchYkySaQQ/AeOHAYc1AW0dhAOXpNiwggNy5LR7sr7xkNBUxSRZDDI6uhZx5A9iIb3L5KQPu6NhCfAyWxuFfFszCMo
X-Gm-Message-State: AOJu0Yxpp62oJnvqIGTm2jEBicub2BqQ9gOFZe2MSG87kL/BNCkeHnP8
	Ymiyn+DesLDuVHz4Ig5XX41XhB6Fr0FkzjHGtjm4LFsCADdK88ofcnrAnRHlE0RsS5dqcN/h6P+
	u+DAN2xFb9qm2mK1I1+pGEZBSm7VCLzUIEkZgoQ==
X-Google-Smtp-Source: AGHT+IG3cmZn0y1k/Co1iZTZhM0M3UdbM2Nc78xLp+KeD+3W703kJkSFPbNvwzYDxLMM6p/A3k8QRN1yRX7txCHLsec=
X-Received: by 2002:a17:90a:9a94:b0:299:1777:134c with SMTP id
 e20-20020a17090a9a9400b002991777134cmr12773740pjp.33.1708484790860; Tue, 20
 Feb 2024 19:06:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <CAADnVQ+E4ygZV6dcs8wj5FdFz9bfrQ=61235uiRoxe9RqQvR9Q@mail.gmail.com>
 <CALz3k9g__P+UdO2vLPrR5Y4sQonQJjOnGPNmhmxtRfhLKoV7Rg@mail.gmail.com>
 <CALz3k9h8CoAP8+ZmNvNGeXL9D_Q83Ovrubz9zHECr6C0TXuoVg@mail.gmail.com> <CAADnVQ+bOhh1R_eCoThyNg50dd4nA4-qhpXxOWheLeA_44npXg@mail.gmail.com>
In-Reply-To: <CAADnVQ+bOhh1R_eCoThyNg50dd4nA4-qhpXxOWheLeA_44npXg@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 21 Feb 2024 11:06:20 +0800
Message-ID: <CALz3k9jDsmNMrXdxdx152fgvBxDoY4Lj_xMf8z-pwPtpm75vXQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 0/5] bpf: make tracing program
 support multi-attach
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Kui-Feng Lee <thinker.li@gmail.com>, 
	Feng Zhou <zhoufeng.zf@bytedance.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 20, 2024 at 6:45=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
> >
> > On Wed, Feb 21, 2024 at 10:35=E2=80=AFAM =E6=A2=A6=E9=BE=99=E8=91=A3 <d=
ongmenglong.8@bytedance.com> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, Feb 21, 2024 at 9:24=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 19, 2024 at 7:51=E2=80=AFPM Menglong Dong
> > > > <dongmenglong.8@bytedance.com> wrote:
> > > > >
> > > > > For now, the BPF program of type BPF_PROG_TYPE_TRACING is not all=
owed to
> > > > > be attached to multiple hooks, and we have to create a BPF progra=
m for
> > > > > each kernel function, for which we want to trace, even through al=
l the
> > > > > program have the same (or similar) logic. This can consume extra =
memory,
> > > > > and make the program loading slow if we have plenty of kernel fun=
ction to
> > > > > trace.
> > > >
> > > > Should this be combined with multi link ?
> > > > (As was recently done for kprobe_multi and uprobe_multi).
> > > > Loading fentry prog once and attaching it through many bpf_links
> > > > to multiple places is a nice addition,
> > > > but we should probably add a multi link right away too.
> > >
> > > I was planning to implement the multi link for tracing after this
> > > series in another series. I can do it together with this series
> > > if you prefer.
> > >
> >
> > Should I introduce the multi link for tracing first, then this series?
> > (Furthermore, this series seems not necessary.)
>
> What do you mean "not necessary" ?
> Don't you want to still check that bpf prog access only N args
> and BTF for these args matches across all attach points ?

No, I means that if we should keep the

"Loading fentry prog once and attaching it through many bpf_links to
multiple places"

and only keep the multi link.

Both methods need to check the accessed args of the target.

