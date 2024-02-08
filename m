Return-Path: <bpf+bounces-21514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2179284E691
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 18:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5434B251DD
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC0281204;
	Thu,  8 Feb 2024 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1aBe8kQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F2823B4
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412879; cv=none; b=m1qnSGWp2ZKe0i7Se8Qzxg73P4cuz/N4cFHYU6H+AOp2YdAbHBT1O03/UkOVR3skOd3VtMMNRZLC6GwzzsWFWeuzWJpHgiOuhq+m7iscrWTSnrvCZs0NR6V99QP6YsnxoI8qHc4hHueScCxIzj96paI3QsYw2x2wRCUrEVo6F8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412879; c=relaxed/simple;
	bh=iD5nj73SAwNd6KWDLrzxIKGCpci6dTkKMZgacfaAQNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9mYBzWyOJM0Xzzee+/W20QIFCddt8DlJRZsrSprpJ/Bc7Gkw9BPrJWScwoeyrsN0wzMTeB0nFDxBhXUj1yTP0AMw3GH16NFxm0YMarM3wVR2Y1UPAy7HTuVivibh5Zc3XL7Xb4lLfHbMCSqRckbeRk2zfq1q5pJs4eZ5enFmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1aBe8kQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b401fd72bso1589720f8f.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 09:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412876; x=1708017676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbIGXYXM0zm/7abXwEgnFQSDlqSTq7f7A/7P45RQWww=;
        b=H1aBe8kQ5aS70CEHWL3qOVxpGUj9cAL4QGFeAJBD2WGP/2bOSyglAvD7Rg4p+cDUMg
         Uz8XkWlfpdKGNkH6johKUzZmAnv6MRTpfyTSNl9vGyOuAMhR7DJyKFbCK5sc+nO7MIvx
         eu1SmmFNesCce0/kci8nVQoJTWRxo3WWJSviD2RW8u64QqxGWwmjWroJJdpTLaDph28H
         05Dd0gE9dGlGrflNAmAbmlYk8354FTsah2gQSjrjkWHXhmCskx1kErsOVVr7hPevvmJV
         nM78I/xNOu1rmG7rLcyTagM0fQBFxCc2eSp2rcg6IBpE7D/CZLnCSMKat15y3W5ukn8u
         3coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412876; x=1708017676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbIGXYXM0zm/7abXwEgnFQSDlqSTq7f7A/7P45RQWww=;
        b=GAi1LecDu9bNUOhlOkf1IkMvp12ThYkTZuWmSjPL3ESWbk/4WEH142W46rsDVXy/o3
         wScNgZHdkXsoEyY0mP9IvPVhUI2NmMdw8pyUksAZEG4gCToxk4AfkqkiFt/ZKFGy8d9T
         SOQURnCTpXXS3Gr3PQuCkPefRKBMI2bMth1Y9m0R2lq8XIEuolbhk0h2mP75zH+g8LwV
         bSrXanK0VPzXWlw1/7dP4vyUHvof6WURFL5H0NBqKjjOcpZQ0jWRU7YNLQbvTO7FIXNX
         7sQ06NhhAn8wTQhgfHrHwhQzz/6/QF+7bAaQ6bz4wYWJ/ze8XintFBLgrR8A3Gbr/h8X
         SsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6yvQ9JMfYoFpTVo0Ph3ID6UCS6W7A9d6mu78jpp7BrGscYNVArXPd+l+yqZo+moWPxIqEJI1Lqp6FcTkSh2usrLDG
X-Gm-Message-State: AOJu0Yz2vbtsut9Qpe83Ye2zktBtP7zsIvKcFwh2PqNcnTsPe3JDqPQz
	vKW6D4U4Pf6PJ99q4PakssEcysvC/dzwFMPxDbRIvOd7JrN1iNOvt5HEhmejDb+3c8UuPbkW5a5
	YAUtJAU3ZW7KwNPemG8mLaMRNYjs=
X-Google-Smtp-Source: AGHT+IEBzpfEgd3d4r59ij4J0BvP4mjras25obegtWe4Mdy8E2NwzO+fufPOte6vcTWaE5SHR6oFOrbuS6lF+XtZFnM=
X-Received: by 2002:a5d:664d:0:b0:33b:53d0:a4a3 with SMTP id
 f13-20020a5d664d000000b0033b53d0a4a3mr104172wrw.4.1707412875555; Thu, 08 Feb
 2024 09:21:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208090906.56337-1-laoar.shao@gmail.com> <20240208090906.56337-2-laoar.shao@gmail.com>
 <bbe097d6-b9be-46d1-bc66-630c23d0f9a8@bytedance.com> <c8877cc4-3d38-42ec-99bc-f968519e9f91@linux.dev>
In-Reply-To: <c8877cc4-3d38-42ec-99bc-f968519e9f91@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Feb 2024 09:21:04 -0800
Message-ID: <CAADnVQL2MFhUfWmJFDq-QH+EfF2UM3tk6bsDkiV1+TB2YdRu3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Fix an issue due to uninitialized bpf_iter_task
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 7:53=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 2/8/24 1:41 AM, Chuyi Zhou wrote:
> > Hello,
> >
> > =E5=9C=A8 2024/2/8 17:09, Yafang Shao =E5=86=99=E9=81=93:
> >> Failure to initialize it->pos, coupled with the presence of an invalid
> >> value in the flags variable, can lead to it->pos referencing an invali=
d
> >> task, potentially resulting in a kernel panic. To mitigate this risk,
> >> it's
> >> crucial to ensure proper initialization of it->pos to 0.
> >>
> >> Fixes: c68a78ffe2cb ("bpf: Introduce task open coded iterator kfuncs")
> >> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >> Cc: Chuyi Zhou <zhouchuyi@bytedance.com>
> >> ---
> >>   kernel/bpf/task_iter.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index e5c3500443c6..ec4e97c61eef 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -978,6 +978,8 @@ __bpf_kfunc int bpf_iter_task_new(struct
> >> bpf_iter_task *it,
> >>       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=3D
> >>                       __alignof__(struct bpf_iter_task));
> >>   +    kit->pos =3D NULL;
> >> +
> >>       switch (flags) {
> >>       case BPF_TASK_ITER_ALL_THREADS:
> >>       case BPF_TASK_ITER_ALL_PROCS:
> >
> > LGTM.
> >
> > Actually commit c68a78ffe2c ("bpf: Introduce task open coded iterator
> > kfuncs") initialize it->pos to NULL. But it seems the following commit
> > ac8148d957f5043 ("bpf: bpf_iter_task_next: use next_task(kit->task)
> > rather than next_task(kit->pos)") drops this initialization.
>
> Sorry, I missed this during reviewing commit ac8148d957f5043.
> Your change LGTM.

Ohh. Pls cc Oleg when you respin.

> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
>

