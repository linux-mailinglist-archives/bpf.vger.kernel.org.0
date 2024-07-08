Return-Path: <bpf+bounces-34081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8FC92A489
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCCE1C21B1B
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5735713C667;
	Mon,  8 Jul 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GeAGRNvg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF525745
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448632; cv=none; b=n016ImRQeGKwKGooSp08c93z3FbtoJb0JkAxLyuKKDcbimpqoUR5rnrnBknu55Ey0uaYxSPrbp4badfZPKWG6cPVApXhnz/MGJSdVlb0V5BZ1sZe9OpNfLiE2hf9QP6uJxZGxGB6KzxkOAJOPm5A3oe95pEJTMR5g3DEbw4AJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448632; c=relaxed/simple;
	bh=OM54P7B3r4HdTh4sRoFHFY4s8HxyUb3roHfXF1U4dqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPLYYfSz/YahRmH1QP98kdVAFVytBaqC65t8Ebh0k90CB3exu8521qyx16mXJd6c+ZJS0MY/swnDP9MLCTw4pAeuhsqTy2sKapWY9QKmzu/dIbaDf8wB/NvZo7UcjocM/vGk9EdVNcO2FfyaBlqV5ou/6M/+i2sm/uaeHF3wiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GeAGRNvg; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-64b101294c0so36124727b3.1
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720448630; x=1721053430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFjrQp5ph1Z3A3x+y2fXNj7/rwBzKHFY9KimN30WTes=;
        b=GeAGRNvgFOvvxHONg/n3+QalYHksVBzpqUz4sCnhoNF8xWFHjs7348nzEZJwwpXe6R
         lhciWaZ6ftqc7tGSJ9mdqS7nYYqN3UIxFy1bPwWxZwWfPjoW/F/zNDTovXct8148bdJX
         itCkrkYsvNFF3O6tZO+FUXCxR7B2VpStYWgFk9oEwA9K2lZ9Lb9IjnCuYTlVY0MFyH1A
         WZUgUbPMxUAAYqPsnr+l+FQMq7TD1HVGqJ2s/m1O6xLZh21uxo6oyLEkNYI3YiH7woPx
         yg7TUMgzy8JrsWYdquFeJVcEouA9dPQxIWJeLQFsqSNV3FHAHQ5dbhLL49vpvcWDfHLB
         k+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720448630; x=1721053430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFjrQp5ph1Z3A3x+y2fXNj7/rwBzKHFY9KimN30WTes=;
        b=bgg0lkj5PHn/YCX4kcH2Hn8xCoxOYJlDIcEc5xE/oYPj1gb13//zd25gycBFYeKavG
         D1fbb6aFvC8+vUN5G2tvclT+8pCqZ68wI8L6bnGkYkGysorhLCuWn9a8wuT3C61sRiI6
         tjHdgAWIVGaRn7mR7cmzg7mlgzl0NBqn3UdZSU8B7Zs6bG+nDAziFrdVX5JJgzIpr/Kc
         4Ylw2AMoB3FbfxPR7T469XPPR1JGtXC/gZEtt8PO1uk1sv3tlReeSCkz2yNXvThGs98V
         BrzNVdwbYfvVMONv1Kak3X3wUlOzH18O08plYEbLqKxMfKO6pwipaVMV4O3htv575XCM
         E4lw==
X-Forwarded-Encrypted: i=1; AJvYcCWPmCtI0E9a2eJxbHEyYlxJ+/KphbM7NGqOgkJ50t8+RCnDEoRQg2uo6UiXNDNhM8n7P4724ZzVrSsQr4QUyzj8ZNEh
X-Gm-Message-State: AOJu0YwmDJjfJof1T7EVXeWkxlFpqMiG++/V4MR8WGdnKgyg/uN4TGr3
	Hnt3wqtnAaBmWA0aWjSwNEWpwd2rBZlk6llaN4yY4ztXnoD1iUeEYL5QUxaT4RGpw0kw/EsmEyj
	/Y5vDr70ZgEkqhEFGde+4Tpc+UOsALaJGQXZE
X-Google-Smtp-Source: AGHT+IEo7g9vTZEwAQP7psKA2oJOxY8RD4WA9EMmzXZT73rG+FZ8uLqMXWa58cNv3ZW3OtOwVlaiEr5ClrgMLJWZe0M=
X-Received: by 2002:a81:844a:0:b0:61a:ed1e:ecd with SMTP id
 00721157ae682-652d892592bmr109385627b3.50.1720448630409; Mon, 08 Jul 2024
 07:23:50 -0700 (PDT)
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
 <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com>
 <CAHC9VhQQkWxMT3KguOOK7W8cbY-cdeYTJSuh=tSDV4jsqp6s6g@mail.gmail.com>
 <CACYkzJ5gAnbXX_aWy6952s2O5L2p3Mw14OUfo9Z-Od6_Dp2HLQ@mail.gmail.com>
 <CAHC9VhQ+KkqTZdvo0cT6-F1fJaG3QgBEnMQqHkiN-GToH37BuA@mail.gmail.com> <CACYkzJ6mR9mRGS8Df_U1yTBSamW2VRt4v9-6WQnkbhGDuH5KGQ@mail.gmail.com>
In-Reply-To: <CACYkzJ6mR9mRGS8Df_U1yTBSamW2VRt4v9-6WQnkbhGDuH5KGQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Jul 2024 10:23:38 -0400
Message-ID: <CAHC9VhR+6ePv3ce5rMB+42935dsKo6Xok=qzcH6o08ZEx32F+w@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 9:52=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> On Mon, Jul 8, 2024 at 2:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Mon, Jul 8, 2024 at 6:04=E2=80=AFAM KP Singh <kpsingh@kernel.org> wr=
ote:
> > > On Sat, Jul 6, 2024 at 6:40=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Fri, Jul 5, 2024 at 3:34=E2=80=AFPM KP Singh <kpsingh@kernel.org=
> wrote:
> > > > > On Fri, Jul 5, 2024 at 8:07=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > > On Wed, Jul 3, 2024 at 7:08=E2=80=AFPM KP Singh <kpsingh@kernel=
.org> wrote:

...

> I think you are ignoring my point that BPF does not want to add
> extraneous function calls which at the least result in extra overhead.

I haven't been ignoring you on that point, see my previous comment:

"Correctness first, maintainability second, performance third.  That's
my current priority and I feel the maintainability hit doesn't justify
the performance win at this point in time.  Besides, we're already
expecting a big performance boost simply by moving to static_calls."

https://lore.kernel.org/linux-security-module/CAHC9VhQQkWxMT3KguOOK7W8cbY-c=
deYTJSuh=3DtSDV4jsqp6s6g@mail.gmail.com/

>  You have ignored the fact that BPF LSM never wanted these empty
> callbacks and you still continue to ignore it. Sigh, I will drop it
> now and will propose it as a separate patch so that we can at least
> unblock the static call series.

I didn't comment on that because it isn't very relevant at this point
in time, what matters is the current status quo and the proposed
change.  In this particular case I'm not going to debate decisions
made by previous maintainers, my focus is on what we currently have
in-tree and what/how/why people want to change.

You've got a path forward with the bulk of this patchset, if you want
to scuttle it over the last patch in the series that is up to you, but
in my opinion that seems like a lost opportunity.

--
paul-moore.com

