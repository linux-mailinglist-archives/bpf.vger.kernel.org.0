Return-Path: <bpf+bounces-15712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0A07F5386
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBA01C20C06
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 22:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67790200C5;
	Wed, 22 Nov 2023 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0jslJAWZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3161B5
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 14:41:54 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4acb1260852so96408e0c.2
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700692914; x=1701297714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4SMbocbWnJdm+k5jMBSfAgEQvGDfASA2vw4jhGFa9s=;
        b=0jslJAWZvusSSeiQ16KICG/YoE8kc4OPPaTtOtgjyQTY+kSJ0EAxlU+sEX32vCeul0
         KcPpEazBIg0a8Dx/oXGzg/ISf4uD1AFzcAVYerV+1raezOKZkn7DzWPtcrLAn1Iswhvr
         MgoJehetiG2w810TUGa9mhOVhYsiUnSM60+u4vN72BKMsHoLuceoGZQjyItM0CdhB3GO
         9aWHLhijKiF7aaT6P446FmLSTZyr6zHAVLTot6skv0lMWukoa5FFRMdpZIf9/PGzAM51
         52fIDeTwAoCxt1C7ZSYfsn73/n1Ze9+zcyohJ2ZfvB9YCL/R/0iiShIco1MfcNPHDLaT
         zZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700692914; x=1701297714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4SMbocbWnJdm+k5jMBSfAgEQvGDfASA2vw4jhGFa9s=;
        b=q/uEdfAJeIJSXyEaOAzoOeBJyGuL1FSGLjm89OS6RTBuHuqG5Otn5/6NpJAxLTzZEV
         kSeMGqqI0FfrCKRgj91b6gnZFOp58A6n8BZui3rydB2mqyzhoWXIP28qyxpDSIBEgZgx
         2TEtwVvDmKBHxde5G3RoYrd+10Xjlj0yaeywEjeB8LU5FcREqx5w5xLUdoPoKDJfu7En
         FSyEsY72eRFEIjvqvXFsz+7Zm82J5wCXSLIPFJ5zFTwPY3W+pzwoRNZcMxjgKR7xjYbn
         bbQ1nZbR3in8OF1mZtvrCFyu0g85AS5bxZJphnDnutjPKDTMgNkDrr3Y6/TqLqi6NVNn
         /2pQ==
X-Gm-Message-State: AOJu0Yx92yupG7D02sb2pM9MHNIvLLyNj07PJ7B2qY1eEISmu9XfRrig
	c996zCyNIGFD2k9W6zoyeRMayEcGLZSccYBish7iOCeTATdUxCRafuA=
X-Google-Smtp-Source: AGHT+IHQGQER2FBfxTdQgaBtnTtXB7ofPb+Zcrg32USEuUe5LciQcu83mDQJSILFZ0QbvEWi/Ydyxx6ZSt3GwvIV4qM=
X-Received: by 2002:a1f:c9c2:0:b0:4ab:fc1a:ae93 with SMTP id
 z185-20020a1fc9c2000000b004abfc1aae93mr3800308vkf.16.1700692913679; Wed, 22
 Nov 2023 14:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114045453.1816995-1-sdf@google.com> <20231114045453.1816995-3-sdf@google.com>
 <49538852-1ca0-49bb-86c2-cb1b95739b91@linux.dev> <b4854a4b-a692-8164-5684-4315939966f3@iogearbox.net>
 <ZV5C7099HylvusQO@google.com> <20c42052-8cb7-4b8b-a7f8-d9311e37479d@linux.dev>
In-Reply-To: <20c42052-8cb7-4b8b-a7f8-d9311e37479d@linux.dev>
From: Stanislav Fomichev <sdf@google.com>
Date: Wed, 22 Nov 2023 14:41:40 -0800
Message-ID: <CAKH8qBuk=+1Xr6wM3N50SJW5QS3Kv-Vnq2z1dncHoVqL9DvNVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: bring back removal of dev-bound id from idr
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, andrii@kernel.org, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:40=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 11/22/23 10:05 AM, Stanislav Fomichev wrote:
> >>>> Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT=
_UNLOAD
> >>>> and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
> >>>> idr when the offloaded/bound netdev goes away. I was supposed to
> >>>> take a look and check in [0], but apparently I did not.
> >>>>
> >>>> The purpose of idr removal is to avoid BPF_PROG_GET_NEXT_ID returnin=
g
> >>>> stale ids for the programs that have a dead netdev. This functionali=
ty
> >>>
> >>> What may be wrong if BPF_PROG_GET_NEXT_ID returns the id?
> >>> e.g. If the prog is pinned somewhere, it may be useful to know a prog=
 is still loaded in the system.
> >
> > bpftool is a bit spooked by those prog ids currently: calling GET_INFO_=
BY_ID
> > on those programs returns ENODEV. So we can keep those ids around, but
> > need some tweaks on the bpftool in this case. LMK if any of you prefer
> > this option.
>
> I think it is in general useful to improve 'bpftool prog show' to keep go=
ing for
> the next prog id if possible. May be print an error message after the pro=
g id
> and then keep going for the next prog id?

Replied with a v2 where I mark those progs as 'orphaned'!

