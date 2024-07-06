Return-Path: <bpf+bounces-33984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F89290C0
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 06:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D742283E26
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 04:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E611758F;
	Sat,  6 Jul 2024 04:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gCMiF6Qo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60DDDA0
	for <bpf@vger.kernel.org>; Sat,  6 Jul 2024 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241221; cv=none; b=nq4ErLGNBZl/LzxtB4BwBbF8q9WwbtbOvbbjaB8WAEF/I/Qs7GCYopnwxQOBHicEmpzVa9C4gOMRK6oWacJ+S54bM9u3It/H/ToMw5ZuxSm0KKWOxwamiPzoYE3jEJvmfNmJQG1gsm6lHsjYNlV98bfDVzonTAYYfUBjM54yXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241221; c=relaxed/simple;
	bh=ani/Ws6gj+Bh+HUFplEvKnkRxhXqcVsBFd8gEalCrhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy+umZIeDLIldJBlQzCxc7x4d1/LJOnlUU+gVUprc6J6selrSs6x+xtP++jYMWmzo40gM/zH68S0pMgTQOUTPi96fvBHIeDOPtuD36PJvr9GjzSQdIhAt6fk5QfBPhXZXmKHKvzhB+ZfPA44dgAkmzB5CamUXkG0OhMejZPfNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gCMiF6Qo; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-651815069f8so27856817b3.1
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 21:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720241219; x=1720846019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ani/Ws6gj+Bh+HUFplEvKnkRxhXqcVsBFd8gEalCrhk=;
        b=gCMiF6Qo9GCtt+HZv+Z39T0ryzqdJS6F7s8tAXAON81TcRYrcK+Nr8f317MW6KooKU
         +7GLpciihqUzNsOGwk8FWz7fYBty0km9aLYn4c1+xaiwd104oIRE9IljIh6wNfs3kYBD
         vyAuCsuKBt76Tay872AJYTRpmh/pJLzX9P+hubI6y1JQdp22De72Q1HIugGUnHF5HQXg
         VhVk9jLUo6BepeCa0PYImpESq+qZcRK+vqShNFNXVUOt2QzcWGvdqyp5YPXpac5Zlv28
         FdkWkPdP7ogvPdgVIGmPwCwdW46rrjfk+Ho0kXBZwfGSMlTQdoAY42hzingcoUCMgrEW
         0kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241219; x=1720846019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ani/Ws6gj+Bh+HUFplEvKnkRxhXqcVsBFd8gEalCrhk=;
        b=TzZdsQbQLhjDg29cECl+jlCTY9gf2uu/o3lmvz9H4rKIA7+g7PCdilmVA96ccYbz62
         6BXJctQJ4xTaVJK9dMzHWQkG6GwxJqmH+1ltacvR3a9NWNDfu90S/mIYdPqb1q7e0dDE
         bRGFbdO6o3EgytyMRghCNVc/0MlDMT3D8Tlu7PZBq3hdNz4WNpYa9NZKan6jhq1X78Dp
         fPOzkH4ex4sdCcHUD7tVcy+kwSU8RX27pYU2paqFo9RvLSNK2sPY7TiF0LcZ+EHBPRsb
         s2LHsTiT4MjfREd6xUcRu/wZSbjCMBOaIjOWM0qN8wTCGdUpSTRQ0NGmnIz5LmMEsE8H
         sD5A==
X-Forwarded-Encrypted: i=1; AJvYcCW4XXVTDTrjABg0Oy6uhSuqzziZ2P2F/AVBFlS4njmV8Z0xA+BZFLbw2/UvVRuIKI29wzgH+E032vG1Fkd300XPlDlq
X-Gm-Message-State: AOJu0YxcHYZCRUgWXFtXHxaS11WscREbMgqHMeeC9pnJd/ClJV3DG2Y7
	1GlXa+VuF7LyVxPG3IwRxZPZEFUTF5zuCM6Hghqe3NjslYd/h04b7SLt7rfooZwGNsfC1fQXNG6
	MTsRVnwgvF23oTGUuxTMTnu8k3ERtXAOpmYfD
X-Google-Smtp-Source: AGHT+IFt+7isOZ77HeE2Ou+NTvAVyfaYr/5P3eMweiFxDOf24NKrbo+DQAho7bHGmTo7K13A9996B7f4dfgwjB4ve/4=
X-Received: by 2002:a0d:e8c6:0:b0:64a:445c:6 with SMTP id 00721157ae682-652f65fea90mr36026927b3.17.1720241219507;
 Fri, 05 Jul 2024 21:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-4-kpsingh@kernel.org> <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
 <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
 <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
 <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com>
 <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
 <CAHC9VhRA0hX-Nx20CK+yV276d7nooMmR+Q5OBNOy5fces4q9Bw@mail.gmail.com>
 <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com> <202407051714.0AAC2D4A9D@keescook>
In-Reply-To: <202407051714.0AAC2D4A9D@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 6 Jul 2024 00:46:48 -0400
Message-ID: <CAHC9VhQtbSs9KLR3+AcsnBz6PRJpQs1Qhpvmuq1DtiBZjz+hwA@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Kees Cook <kees@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, casey@schaufler-ca.com, 
	andrii@kernel.org, daniel@iogearbox.net, renauld@google.com, 
	revest@chromium.org, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 8:17=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Let's take this one step at a time. I think patches 1-4 are fine and
> stand alone and solve a specific problem without creating any new
> immediate problems.
>
> After 1-4 is accepted, we can come back around to what patch 5 is trying
> to do, and work on whatever issues may remain at that time.

Kees, whatever technical review you may have for any proposed patches
is always welcome, and if you want to provide process advice,
solicited or otherwise, to people posting patches that is up to you.
However, after your last comments regarding the management of the LSM
tree, I want to make it clear that I'm not interested in your opinions
on what should be merged into the LSM tree at this point in time.

--=20
paul-moore.com

