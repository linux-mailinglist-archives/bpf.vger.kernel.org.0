Return-Path: <bpf+bounces-51627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A118CA3693C
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 00:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292DB1892D5E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C0D1FDA6D;
	Fri, 14 Feb 2025 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgTUdcsO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219EA1922DE;
	Fri, 14 Feb 2025 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577271; cv=none; b=DMFdrxWTR0ET32XW4YQJ4t7hkinOk3P4tlFa8lDPLhG1yLb9LRBR5p/ykZEqms7/bVUHkd156IbS3Tlv7mmVOBkCDRt9A5kelDeP8KD9+bKOfmKLrF+L2cfrTwOCgjBgh3fFs42roCeKIcc7uB3+EIB6Bf2ZUy2iLXqR568CK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577271; c=relaxed/simple;
	bh=ZOPeEIgFR7q/76/I060TBjWDbUwcEavTKh4MHFVPP8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqAqLatoqoFZMxzgVtp6pqqwItc/aVjHrvEOV68CEJStuu3fb/d30d6AqQmjFLDxWoy8ZofF8nvwZ4scSuqvGID/68lmE7Cjir9Rt810PF3HJgFA/FuvyCoBwC3S5lT93ijgkdh0xvDSArhq5zVRMVwE3ujLZzEBC4UO7cRew+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgTUdcsO; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d18bf1c8faso6910145ab.1;
        Fri, 14 Feb 2025 15:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577269; x=1740182069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUKvaz7HU+LH0Xz2uTaUnYxfZLa5gormg0dDy6LBhNg=;
        b=hgTUdcsOFcGRq1Lkoox7tHXQU6ieGPbYVjpTtjUuZNyFZSh0zOkD2sh7BZGctOs6al
         brNLIeGAH2WKruMljd8qNGEMK9AM1UBaJeNP2a3NagSLm4n51z8IbpHiXTc4fpKTo5Ww
         C7YaUNzn25d971XxupXVRB6uYCNUpDkQzctvvcVFCJ5JIGhavOtiI2Y1J8OXd3ZDM46P
         sTbbE6aJLn43RCFhhvF1YEcN/SR7CmgRely71X+4EC34TjCzNVBFraRmVA5Nngj6M7+j
         D2MlJTTNnf1aFAyEGFTbc0m3h8whADruPIiGM/H0xugfdgcnEzT7ZbTljifR4CuITLve
         Jq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577269; x=1740182069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUKvaz7HU+LH0Xz2uTaUnYxfZLa5gormg0dDy6LBhNg=;
        b=ofjZePy1dW1FuN8f1MgmjlVUJguQNLAyxEUNRryItXmM+TeFtY8bgkYksllJTiyadR
         XK5osuKRJobVK6+3QVeOACAtYqzxchqSfoMwI2C8VSGRTppQlqmMdbrT3SNKXepdcnh0
         OXCEThDXB5qAqzFd8gmrQLLSV5r65/zenTE/oxAjrcGIjUKLum58AyR3Sn/YxK2K1s+J
         yt9uTxF7aNPFILNbVRWw3DgxwZKVKyz4YePTEOulKG2tWxXSaRbQ0fCyXE4+bBzTwg/r
         oTOEl/QRzlNDnsVESYixVk2L5fvE0QVcqiC94bMiklSatwVr1Xd+HgEHo0ra/4kqtx+O
         IJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXomC4SflcA/7bkLx/n1A/hoAC8Q8qv5VjlFipFyAF/MM0EuxsMDf+bynX6roK4HHsOhcmayXc@vger.kernel.org, AJvYcCXVg4rFv6EDLrb57oS1hgArQg5/zn/zor1e0RBU9ccXxFvqMhV6PhvFvMWDQsnnMqC73nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/3ITb2kNKML49yvzX8GKRokaJ48OzjW0Cz8yf7nK5DEhE4i38
	vmuwjZMmun+WNibSDGZcPTCA2mFQuOwMSSL+7WkBZIXWIE1VFErSlMawaakQDpG9qB4seADIWKG
	NpLxi/qntFU+M63FyMX6oNy7URXo=
X-Gm-Gg: ASbGnctswje3q+uDxwSVIfbhDFiQ5xWWz1BtbeniDKQTJzHNlOY2DISBh9pFFPDPgKB
	5TzLSHYw9Zk6IhXCFYHdgOcOtWqGjZMTETJ6n43NfYTc5ardzglXPb1g0peHRNpfV+q9SoVJl
X-Google-Smtp-Source: AGHT+IF88MdBOZbI0PP3KRQZURIoja8SavVCCp79zwSZ/VgH/OMBHEG+USaUBX2Mxs77tSfe7u6yrdX2E8tuMk7JtSQ=
X-Received: by 2002:a05:6e02:20e1:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3d2807b0c71mr11643485ab.5.1739577269234; Fri, 14 Feb 2025
 15:54:29 -0800 (PST)
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
 <b3f30f7d-e0c3-4064-b27e-6e9a18b90076@linux.dev> <CAL+tcoB2EO_FJis4wp7WkMdEZQyftwuG2X6z0UrJEFaYnSocNg@mail.gmail.com>
 <3dab11ad-5cba-486f-a429-575433a719dc@linux.dev>
In-Reply-To: <3dab11ad-5cba-486f-a429-575433a719dc@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 15 Feb 2025 07:53:53 +0800
X-Gm-Features: AWEUYZndPUdvwvn29ChY16yvi0A5kHU0zE5VuvyBA07TiUxJipDlPRdgp7NzL9A
Message-ID: <CAL+tcoAhQTMBxC=qZO0NpiqRCdfGEkD7iWxSg7Odfs4eO7N_JQ@mail.gmail.com>
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

On Sat, Feb 15, 2025 at 7:45=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/13/25 10:56 PM, Jason Xing wrote:
> > On Fri, Feb 14, 2025 at 2:40=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 2/13/25 10:12 PM, Jason Xing wrote:
> >>> On Fri, Feb 14, 2025 at 1:41=E2=80=AFPM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> >>>>
> >>>> On 2/13/25 7:09 PM, Jason Xing wrote:
> >>>>> On Fri, Feb 14, 2025 at 10:14=E2=80=AFAM Martin KaFai Lau <martin.l=
au@linux.dev> wrote:
> >>>>>>
> >>>>>> On 2/13/25 3:57 PM, Jason Xing wrote:
> >>>>>>> On Fri, Feb 14, 2025 at 7:41=E2=80=AFAM Stanislav Fomichev<stfomi=
chev@gmail.com> wrote:
> >>>>>>>> On 02/13, Jason Xing wrote:
> >>>>>>>>> Support bpf_setsockopt() to set the maximum value of RTO for
> >>>>>>>>> BPF program.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Jason Xing<kerneljasonxing@gmail.com>
> >>>>>>>>> ---
> >>>>>>>>>      Documentation/networking/ip-sysctl.rst | 3 ++-
> >>>>>>>>>      include/uapi/linux/bpf.h               | 2 ++
> >>>>>>>>>      net/core/filter.c                      | 6 ++++++
> >>>>>>>>>      tools/include/uapi/linux/bpf.h         | 2 ++
> >>>>>>>>>      4 files changed, 12 insertions(+), 1 deletion(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documenta=
tion/networking/ip-sysctl.rst
> >>>>>>>>> index 054561f8dcae..78eb0959438a 100644
> >>>>>>>>> --- a/Documentation/networking/ip-sysctl.rst
> >>>>>>>>> +++ b/Documentation/networking/ip-sysctl.rst
> >>>>>>>>> @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
> >>>>>>>>>
> >>>>>>>>>      tcp_rto_max_ms - INTEGER
> >>>>>>>>>           Maximal TCP retransmission timeout (in ms).
> >>>>>>>>> -     Note that TCP_RTO_MAX_MS socket option has higher precede=
nce.
> >>>>>>>>> +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket optio=
n have the
> >>>>>>>>> +     higher precedence for configuring this setting.
> >>>>>>>> The cover letter needs more explanation about the motivation.
> >>>>>>
> >>>>>> +1
> >>>>>>
> >>>>>> I haven't looked at the patches. The cover letter has no word on t=
he use case.
> >>>>
> >>>> The question was your _use case_ in bpf. Not what the TCP_RTO_MAX_MS=
 does. Your
> >>>> current use case is to have bpf setting it after reading the tcp hea=
der option,
> >>>> like the selftest in patch 3?
> >>>
> >>> Oops, I misunderstood the real situation of the tcp header option
> >>> test. My intention is to bpf_setsockopt() just like setget_sockopt
> >>> does.
> >>>
> >>> Thanks for reminding me. I will totally remove the header test in the
> >>> next version.
> >>
> >> If your use case was in the header, it is ok although it won't be the =
first
> >
> > I was planning to add a simple test to only see if the rto max for bpf
> > feature works, so I found the rto min selftests and then did a similar
> > one.
> >
> >> useful place I have in my mind. Regardless, it is useful to say a few =
words
> >> where you are planning to set it in the bpf. During a cb in sockops or=
 during
> >> socket create ...etc. Without it, we can only guess from the selftest =
:(
> >
> > I see your point. After evaluating and comparing those two tests, I
> > think the setsock_opt is a better place to go. Do we even apply the
> > use of rto min to setsock_opt as well?
> >
> > What do you think?
>
> Adding to sol_tcp_tests[] as Kuniyuki suggested should be the straight fo=
rward way.
>
> Please still describe how you are going to use it in bpf in the cover let=
ter.

Sure, I will.

Another related topic about rto min test, do you think it's necessary
to add TCP_BPF_RTO_MIN into the setget_sockopt test?

>
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> I will add and copy some words from Eric's patch series :)
> >>>>
> >>>>
> >>>>>>> I am targeting the net-next tree because of recent changes[1] mad=
e by
> >>>>>>> Eric. It probably hasn't merged into the bpf-next tree.
> >>>>>>
> >>>>>> There is the bpf-next/net tree. It should have the needed changes.
> >>>>>
> >>>>> [1] was recently merged in the net-next tree, so the only one branc=
h I
> >>>>> can target is net-next.
> >>>>>
> >>>>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-nex=
t.git/commit/?id=3Dae9b3c0e79bc
> >>>>>
> >>>>> Am I missing something?
> >>>>
> >>>> There is a net branch:
> >>                 ^^^
> >>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> >>>
> >>> But this branch hasn't included the rto max feature. I was trying to
> >>
> >> Which branch? I was talking about the **net** branch. Not the master b=
ranch. Try
> >> to pull again if your local copy does not have it. The net branch shou=
ld have
> >> the TCP_RTO_MAX_MS patches.
> >
> > Oh, I always use the master branch, never heard of net branch. You're
> > right, I checked out the net branch and then found it. Thanks.
> >
> > One more thing I have to ask in advance is that in this case what the
> > title looks like? [patch bpf] or [patch bpf net]?
>
> [PATCH bpf-next]

Thanks. Will do it.

Thanks,
Jason

