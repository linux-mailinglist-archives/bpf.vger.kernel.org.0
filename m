Return-Path: <bpf+bounces-47532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 994769FA2FF
	for <lists+bpf@lfdr.de>; Sun, 22 Dec 2024 01:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F56188AC42
	for <lists+bpf@lfdr.de>; Sun, 22 Dec 2024 00:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0F8802;
	Sun, 22 Dec 2024 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIuOUNFf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB92184;
	Sun, 22 Dec 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734826051; cv=none; b=ueG1R3pMZQN47Eb1vjnKjRo59YRxpVATI641LKShSyK/LUT8O4Cau4LJtZE+ZxUtTtHoocYjEoL3x9QSTu38OqzmD514aN7vGWCb+dzsfQTRxn10H4Y8VO99ixTfyg/jJvXdFPu6xrVSqT7iCYGDL5XCYmvfJ5u1ubkn31ohN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734826051; c=relaxed/simple;
	bh=FUcfCMbBX9AUk8WTsOMD+TEr0rfc1Xvc4FMJl67sJtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnaJEmWeFJS4rd5iVHPW3LfC2ds8bBYez3bjYH/rExd6QSzUYM61lCP8yWyRtmh9r5M3qeSzDyfiakOvPa9szMgi9HfE8xFXmIRqWhkYQa62+IX8AHNjMZHIl3Wq67I/C5xJeFF4gbjG3wh+Rsjk5fVgs8FCUCoQyr5gIA7RD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIuOUNFf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so4767165a12.1;
        Sat, 21 Dec 2024 16:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734826048; x=1735430848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnxkX7Kcr3an19F9Rw9g540AyDG5QsOKbjB2O+/g66w=;
        b=cIuOUNFfrIdsOmx1Kk8Trb4jJslkB4TVQ63JcwZFV+QgTz3AplaSAcyA7gdtVMYrMs
         HK4nLj6ZwxFmq8iWlnOatPTHQJT6TDwslhEnGBgkCfvvC+k9rPoEyGnFh8g6afVUJbWk
         ecxaqENIYT1ABVcwJOZUXU7B7/qCJrNgEtMYWn61ucGz3NpFpVScx8Zmgq+CMruGMWW9
         0yFAlKuBEHHIZ73YrasNkVp6uehtmEAaNaN5IzNhBC03W4yadb9b/hXEYtwZ2YtPIRge
         fK5FP4ChpFhAskgaZXW1hT4POZ0mft+DAkexK2MeLdBbuAVaY3+9AwJlDpCXdkwIOIpU
         N2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734826048; x=1735430848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnxkX7Kcr3an19F9Rw9g540AyDG5QsOKbjB2O+/g66w=;
        b=tzUWVIdNuiv2qQG8xZ8fM7Lhc7lho01sonGEDbEu6xQGF1KP4xC0RIhhcaLTJ0Pnwk
         gXW4ZWHoaCgK4MYKegCi9v6PpjJjx6a0wiRubfyP0gOsmkEuIJnmaQwL1xoLg88NKi4U
         e3PnVz//nxQFCGYPuVr26BZUNwiJZuxjLTlhC/8Jj/ykX2ekfuCbqsJtuh2/Do3epVEO
         SwppPg/RIsGbXpSzczwVRQNvNEjZiTusYKIUINp1/lptVMwkggVN7Lc91CaMmh+OlegP
         9lHbO2QCaMBnxGmJ47D8xAJPkGFBHTXk071uD8L/OYyoqKQcHsbQIbSPtfV0H0QjGiLj
         dLmA==
X-Forwarded-Encrypted: i=1; AJvYcCUWf7mtKl7EKGfdY3+vamd0eKFE9ePbfk1UHHBoifUUTLIUZ0Rfx4I1pdLdOX3upSrA5qE=@vger.kernel.org, AJvYcCVXHAAkNpHS28sp/VLTyQsuiO0G5fqJDmDE8E4/IdmfdtYP5KMcsl/7mHoptrFJlVI1R9v5jD6sLZOs2Hmf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8zRhNPjo8Cv+VASu4aqkOahpp96G//EvJIcs0AtonfGItHa31
	sEG8d3KqW7AVlsYR+kKQ7wYmW7Ii/6HYP9JOD80D5nXB7dximihj+ZYsauJmpk/a52Kfs5/5Art
	PLgembCR0S3PtrXqWQR/IKHJGml0vQLAN
X-Gm-Gg: ASbGncvzslS3E0TPdn5/MeFyd6cvQQ7iSgIhHVMWaPauhO+u75UQC5/0islZwdgbAsQ
	0waaQiHrNoVmQeuyhrdeGknNQyphBynve4a4Lkr7niwfC3nt6XO4VC0/pCxwDf4tWWcK4GX4p
X-Google-Smtp-Source: AGHT+IHaP4uSyW4jv/16OoRWaYOmaMtu1mfd9UZ2c9BQx5ZSFZhqNzGXTCHUD2ddxH2wqGMZy+PKCjaKnf6siXLdW34=
X-Received: by 2002:a05:6402:5255:b0:5d3:cfd0:8d4b with SMTP id
 4fb4d7f45d1cf-5d81de38c45mr6556081a12.33.1734826047694; Sat, 21 Dec 2024
 16:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221210926.24848-1-pvkumar5749404@gmail.com> <CAADnVQLC0hNpg_M_54netES5Q2ugSSULcSMzFPGcPG2aLCH8=g@mail.gmail.com>
In-Reply-To: <CAADnVQLC0hNpg_M_54netES5Q2ugSSULcSMzFPGcPG2aLCH8=g@mail.gmail.com>
From: prabhav kumar <pvkumar5749404@gmail.com>
Date: Sun, 22 Dec 2024 05:37:15 +0530
Message-ID: <CAH8oh8W_j3-yc9oyOa4mck_6kfFb6i_-ZHpYnkweajreyH2G4A@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next] BPF-Helpers : Correct spelling mistake
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 5:17=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Dec 21, 2024 at 11:09=E2=80=AFAM Prabhav Kumar Vaish
> <pvkumar5749404@gmail.com> wrote:
> >
> > Changes :
> >         - "unsinged" is spelled correctly to "unsigned"
> >
> > Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
>
> Are you trying to land a trivial patch to get on the record?
> Please focus your efforts on something better than typo fixes.
>
Sure Alexei.
I wanted to send in my first patch to know how to work with open community.

Apologizing for something I posted wrong.
> pw-bot: cr

