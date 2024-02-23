Return-Path: <bpf+bounces-22598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE0A86187B
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 17:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC57285D7D
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EC51292D5;
	Fri, 23 Feb 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zWhaWIgx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C1126F12
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707266; cv=none; b=tHv1vJoh9NHrmGscBU4DqcaExzMJRs9ZUoIYavShfBwJj0F3InZsSkeUdAYP95BfZQq8OIn4kJvexHGF2xYlln5G3FkY/B7G1kM4lLVev6STu1/sLRQaBfpHLJ+nQZjalwpdhK65J1VebxrPrvBx6RKLxJfuEe6eVYROQYDCSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707266; c=relaxed/simple;
	bh=ENABmiOJK9f0aTz8zpAbrJ7jwTiC1MtfDZUP7ZLR4Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lW1WmHRqOBKvXzQ28PScnWnEyDO08l9CuOifp8vmD9OXCcWw0eecGilih6tzPXoDYR5oPgEQhPz/4zNBnA/Q1Y27OdxrPQ2pP7z28d4j+WN4RiPLQulWwUBZ7XHhOcITOQlA99XurXNP67MgS9SGNCRpaN2L9CT2KGMymjEQ4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zWhaWIgx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-608c40666e0so6486377b3.2
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708707263; x=1709312063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Be4o53qg9IjORx3qCWTOp328iufYXNqENlXn+m4qD8=;
        b=zWhaWIgxui3Eb/CqPmq0+qOaDV9QpDnL/kYE3YzALAn75nB75L/39+ZgtO6tcTi5DZ
         Fsb5Nr2fsGAWIr74CEHkXjXjhZgvlbztfD3p5TIebp0N8t/yjDjeI0Di2j4ikoaI6z3e
         I4pf9WFTf6fhb5MIPdGpw9ABPbSurStHQQAbj6Nd9X8WQlh4EXDBH1HzVF4vc1OrlvMw
         wEUCSFOHQsy2wCrjEFcTdwEOIcWwlsRBmU+GadbMZPh5aNb6zw8V9mGjbK8BkXyZNSnm
         +XVCls8wJnQAiF4Q2/Ksv53/1v0HKRz+uDBniEQ9ZttFiH0P7A1OnPX2kp9Ta0Nh6ZEL
         WlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707263; x=1709312063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Be4o53qg9IjORx3qCWTOp328iufYXNqENlXn+m4qD8=;
        b=vdi0AoaLbhWAQCOiLA4GWDKeNxe4kErxrz06/sLi9R1F2sFiTypmSNToHa+PrvV79+
         sv1LA67t1LmiyvrvF1ScKUQrISVL+doMa2FFXPVItIO5AyPoCnhPhebaiHyMYdPP+kft
         wI5v05YrsTJ+v0vqo/W1kPTQyHJVaLMPGOP3fRNQRS3yTLEHDm8y4u0DjxxGutjgmmje
         xmJFnq6PxwQ4gB4JTl4NgZFkj1LyuHmoq9V14XjLMsoY6DqtlU2Tr3mffG0fqJGPvpQE
         tMIJFV4yKGGu+nD4kE+PWHUj3u/AQTdOA5TyihACnADvFiPAGqTSi6Fj7ulI8fbjtIev
         2mEw==
X-Forwarded-Encrypted: i=1; AJvYcCWEXoIrNNEiaN4LWcPSrQBJWvHw/Kt2Kayc+lSsp6tEClJWP7gJCA8JcVv8CdPV95IhlbExiyp6eEnS9O3uofavUZkM
X-Gm-Message-State: AOJu0YwXpQAvSZ4+74ujQnXlDbaHOR+kY1y7mpR696YcnoTXYu6hLpI8
	+I0tRN4PohgqbgROS6nDebKoc9kh3ipSuip44PYwNKoqhyhMXYWnXds58yMfzh+VDK3hMxIAW+Y
	f4FXesin7AunVEWfOcT9Y//WrtTDLt9Eq8iOU
X-Google-Smtp-Source: AGHT+IF0/9oau4fCk42rll3Q/uCSAl3qxFiqr47RtnftxC2/3hAbLdI3ivQNZfcwPu0e/8iMrt9X44nXky6ad3kvF30=
X-Received: by 2002:a81:ae60:0:b0:5ff:a9bc:3893 with SMTP id
 g32-20020a81ae60000000b005ffa9bc3893mr350572ywk.12.1708707263461; Fri, 23 Feb
 2024 08:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223131728.116717-1-jhs@mojatatu.com> <20240223073802.13d2d3d8@kernel.org>
In-Reply-To: <20240223073802.13d2d3d8@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Feb 2024 11:54:11 -0500
Message-ID: <CAM0EoMnWdcKtyW_yPkGkan=NYO6To+PeUDV5a5CUi3BLouhLUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v11 0/5] Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, daniel@iogearbox.net, 
	bpf@vger.kernel.org, dan.daly@intel.com, andy.fingerhut@gmail.com, 
	chris.sommers@keysight.com, pctammela@mojatatu.com, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 23 Feb 2024 08:17:23 -0500 Jamal Hadi Salim wrote:
> > This is the first patchset of two. In this patch we are only submitting=
 5
> > patches which touch the general TC code given these are trivial. We wil=
l be
> > posting a second patchset which handles the P4 objects and associated i=
nfra
> > (which includes 10 patches that we have already been posting to hit the=
 15
> > limit).
>
> Don't use the limit as a justification for questionable tactics :|

The discussion with Daniel was on removing the XDP referencing in the
filter which in my last email exchange i offered to remove. I believe
that removing the XDP reference should resolve the issue. Instead of
waiting for Daniel to respond (the last response took a while), at the
last minute i decided to only do the first five which are trivial and
have been posted for over a year now and have been reviewd by multiple
people. I had no intention to make this a conspiracy of any sort.

> If there's still BPF in it, it's not getting merged without BPF
> maintainers's acks. So we're going to merge these 5 and then what?
>

Look, this is getting to be too much navigation (which is what scares
most newbies from participating and i have been here for 100 years
now). I dont have a problem removing the XDP reference - but now we
are treading into subsystem territories; this is about P4 abstraction
and the infra around it, it is really not about eBPF. We dont need
anything "new" from ebpf i.e none of these patches make any eBPF
changes. This is a tc classifier that happens to use ebpf, whose
domain is that?  The exhausting part is some feedback is "you do it
our way or else" thing: I apologize i dont want to lump everyone in
that pool, and it is nothing to do specifically with ebpf people
rather a failure in reaching compromise within this community.

> BTW the diffstat at the end of the commit message is from the full set

Yeah, sorry - this was last minute "should i send all or just these
five to make space for the remainder 5 that we havent posted since
V8".
We have 5 more patches on top of what we posted on V10 - merging these
would open the door to post the rest with 15 limit.
I can repost all 15 if that works better.

cheers,
jamal

