Return-Path: <bpf+bounces-51531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E481A35777
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D278188F9FE
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 06:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B63204C17;
	Fri, 14 Feb 2025 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNC6mnMs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B241519A9;
	Fri, 14 Feb 2025 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516221; cv=none; b=Z1i3D61hyZFMr9N2OwfOqhrU7yM2F8u357NaHzSx/xzeX3dk8yKcVy6WknI35xW5L7H1rAD7uviKS9LDKqVjJdpjF/M+ec8w7LFHWJOdTJVnykpp94o538Fl9764nQBnA0z/IGgyWnPA7ooFw9P5bInj6/hRUn7gBXDslsM2XBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516221; c=relaxed/simple;
	bh=Fec+rZk/W9gK1K5DEsZiJ8DtC/dCtMvlJ3l5jhOQiwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXdsEA543VFSFLe2N26XGBCONyAleL5o72SOW4MBojtID7JmKuEp+7FVwMuZko0ZxtFx62FCmIRVgTaFnMmgBYJSBbtiB1JOq9eiAN6yYlcCOJ6cTfj9FRg0PYXqbfxvxWWNseQs/rmJxhqJGsEVB/CLirdWI30tmCkuJ99hmWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNC6mnMs; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d03ac846a7so5476345ab.2;
        Thu, 13 Feb 2025 22:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739516218; x=1740121018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3UYfrgfI+u6YUZkrJkTzUEiGH4tn/5JLev8v5kxCTI=;
        b=TNC6mnMsscQZOWy1eoqNCIqJzc0zD82Jpk7/jRfnu5GvkJ6YC0hzvJuqUSlOrmPzh4
         5pe/nci9iN8MKWdOgzYD2gV1XhkaFan1ZEw682pieFlXTtbYI719ynrj1k/HG9pbg9n6
         vsU444hw+EAJ9QWMdpujlm0He9z4EsVsxzsQ3DndV72JpnoEEkgG4eFbrnozKQ5X56WS
         zjjLge+mNFlPeXM9M015sR2JvOv1XpOiHNKBnxZ1ncqI3v8LNJiOdDniGOu9mEBNDAC+
         OOVLK8eCeoMIR2xLzuXUD+RxjvfW3LAemPg01y2sYolCZPtY+fLM6rtqkQwJ1uaub7vw
         BdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739516218; x=1740121018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3UYfrgfI+u6YUZkrJkTzUEiGH4tn/5JLev8v5kxCTI=;
        b=I8UKcVpb/2nbAc9BAU7LrjLeEUvmoP4vLSpTMRqZQNzb4Ar8Duxss+f0naZmBL6PlF
         y85R73yeN7oqXeCIZoVbVi+U47oEJGCjj/1/GGuhbZnLZEgLTA1u5/G9YIT5kNqLPc5k
         DjQiKj8Oe9H+BO3emEu1/Rs5Juhol8Bi2tuSClb77DUXNp7Tx+pc86mWoDVUaaqzf7JT
         yeHJAf9LGQr+cB8lFa/omuh/pNBH/Hv4lfWdK3yf7ynHOB55Hx9J2UuDdje6ozbRetjc
         WNZSwE2T7q8Qw/0FpdArt8fbZbz3wQnH1yFpch3IBTms/8GF6Drf0gbKUH7hN43w6EFB
         w/tA==
X-Forwarded-Encrypted: i=1; AJvYcCUYuKfDG33uCe2Qi1PZHNVi7xruomA0hG2+/Tw/G8mKy7eH9VcRvcjWypQfN1hXXAQ/hMk=@vger.kernel.org, AJvYcCXRrcvvuhYB3vENzcKqY435bmkTVn6/I8WxegNrATJiVV1uVnM5JwalLV+DLKPRL1w70C564oGy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WlDAiwVbZc1aEdZvHTPZ+WAkn2EmthyNYhb6xJtm/VnHzIaH
	gRAhv0c5ZsjAv5hb74zsaQ8EBrKYNMHgrHnUiEDJl9EIWQRFJO6/Pgc6gtqJaOqCN5FzR+XcCTg
	pT5fEHgRI001NYWjznm3swcZf5sk=
X-Gm-Gg: ASbGnctAt9gthsrHpGm7H86Vi/+UBI9+skOfxHjvLcz36xXcDTD9psW2+kV39aGIrsU
	9I0hIXtPTb4BKAZJuzjm3nOTKgsAJfICIZyZ67qWUMUDjU3KYSUjLhGvKH6R1Lu0gJlzs6KU=
X-Google-Smtp-Source: AGHT+IEQfgHbwxRW6daC4an8k8SMcE/hiFMd/JCnTmBjOqlVHMmb0vJILox+ZEp8Yp2Nme7V0qRYGXPGNu+FX464/jA=
X-Received: by 2002:a05:6e02:368a:b0:3d1:a26f:e241 with SMTP id
 e9e14a558f8ab-3d1a26fe440mr3263835ab.7.1739516218456; Thu, 13 Feb 2025
 22:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com> <Z66DL7uda3fwNQfH@mini-arch>
 <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
 <039bfa0d-3d61-488e-9205-bef39499db6e@linux.dev> <CAL+tcoBAv5QuGeiGYUakhxBwVEsut7Gaa-96YOH03h57jtTVaQ@mail.gmail.com>
 <86453e67-d5dc-4565-bdd6-6383273ed819@linux.dev> <CAL+tcoApvV0vyiTKdaMWMp8F=ZWSodUg0zD+eq_F6kp=oh=hmA@mail.gmail.com>
 <b3f30f7d-e0c3-4064-b27e-6e9a18b90076@linux.dev>
In-Reply-To: <b3f30f7d-e0c3-4064-b27e-6e9a18b90076@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 14 Feb 2025 14:56:21 +0800
X-Gm-Features: AWEUYZmGuuAbDAB7AOdm5fCDp5ql6QQtZvUW4793IHuvA53AYBy76HVgsR7U4cg
Message-ID: <CAL+tcoB2EO_FJis4wp7WkMdEZQyftwuG2X6z0UrJEFaYnSocNg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 2:40=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/13/25 10:12 PM, Jason Xing wrote:
> > On Fri, Feb 14, 2025 at 1:41=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 2/13/25 7:09 PM, Jason Xing wrote:
> >>> On Fri, Feb 14, 2025 at 10:14=E2=80=AFAM Martin KaFai Lau <martin.lau=
@linux.dev> wrote:
> >>>>
> >>>> On 2/13/25 3:57 PM, Jason Xing wrote:
> >>>>> On Fri, Feb 14, 2025 at 7:41=E2=80=AFAM Stanislav Fomichev<stfomich=
ev@gmail.com> wrote:
> >>>>>> On 02/13, Jason Xing wrote:
> >>>>>>> Support bpf_setsockopt() to set the maximum value of RTO for
> >>>>>>> BPF program.
> >>>>>>>
> >>>>>>> Signed-off-by: Jason Xing<kerneljasonxing@gmail.com>
> >>>>>>> ---
> >>>>>>>     Documentation/networking/ip-sysctl.rst | 3 ++-
> >>>>>>>     include/uapi/linux/bpf.h               | 2 ++
> >>>>>>>     net/core/filter.c                      | 6 ++++++
> >>>>>>>     tools/include/uapi/linux/bpf.h         | 2 ++
> >>>>>>>     4 files changed, 12 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentati=
on/networking/ip-sysctl.rst
> >>>>>>> index 054561f8dcae..78eb0959438a 100644
> >>>>>>> --- a/Documentation/networking/ip-sysctl.rst
> >>>>>>> +++ b/Documentation/networking/ip-sysctl.rst
> >>>>>>> @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
> >>>>>>>
> >>>>>>>     tcp_rto_max_ms - INTEGER
> >>>>>>>          Maximal TCP retransmission timeout (in ms).
> >>>>>>> -     Note that TCP_RTO_MAX_MS socket option has higher precedenc=
e.
> >>>>>>> +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option =
have the
> >>>>>>> +     higher precedence for configuring this setting.
> >>>>>> The cover letter needs more explanation about the motivation.
> >>>>
> >>>> +1
> >>>>
> >>>> I haven't looked at the patches. The cover letter has no word on the=
 use case.
> >>
> >> The question was your _use case_ in bpf. Not what the TCP_RTO_MAX_MS d=
oes. Your
> >> current use case is to have bpf setting it after reading the tcp heade=
r option,
> >> like the selftest in patch 3?
> >
> > Oops, I misunderstood the real situation of the tcp header option
> > test. My intention is to bpf_setsockopt() just like setget_sockopt
> > does.
> >
> > Thanks for reminding me. I will totally remove the header test in the
> > next version.
>
> If your use case was in the header, it is ok although it won't be the fir=
st

I was planning to add a simple test to only see if the rto max for bpf
feature works, so I found the rto min selftests and then did a similar
one.

> useful place I have in my mind. Regardless, it is useful to say a few wor=
ds
> where you are planning to set it in the bpf. During a cb in sockops or du=
ring
> socket create ...etc. Without it, we can only guess from the selftest :(

I see your point. After evaluating and comparing those two tests, I
think the setsock_opt is a better place to go. Do we even apply the
use of rto min to setsock_opt as well?

What do you think?

>
> >
> >>
> >>>
> >>> I will add and copy some words from Eric's patch series :)
> >>
> >>
> >>>>> I am targeting the net-next tree because of recent changes[1] made =
by
> >>>>> Eric. It probably hasn't merged into the bpf-next tree.
> >>>>
> >>>> There is the bpf-next/net tree. It should have the needed changes.
> >>>
> >>> [1] was recently merged in the net-next tree, so the only one branch =
I
> >>> can target is net-next.
> >>>
> >>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.=
git/commit/?id=3Dae9b3c0e79bc
> >>>
> >>> Am I missing something?
> >>
> >> There is a net branch:
>                ^^^
>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> >
> > But this branch hasn't included the rto max feature. I was trying to
>
> Which branch? I was talking about the **net** branch. Not the master bran=
ch. Try
> to pull again if your local copy does not have it. The net branch should =
have
> the TCP_RTO_MAX_MS patches.

Oh, I always use the master branch, never heard of net branch. You're
right, I checked out the net branch and then found it. Thanks.

One more thing I have to ask in advance is that in this case what the
title looks like? [patch bpf] or [patch bpf net]?

Thanks,
Jason

>
> > say that what I wrote is based on the rto max feature which only
> > exists in the net-next tree for now.
> >
>
>

