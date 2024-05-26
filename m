Return-Path: <bpf+bounces-30605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FF18CF274
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 04:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F1E281332
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 02:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA217FD;
	Sun, 26 May 2024 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxNbPKGQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3F7FD;
	Sun, 26 May 2024 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716690889; cv=none; b=sOF3RAwXp6R0ep2LiD4qJRJBLLWgHCVJMC/U1Vu6goJvYOm42q6DwNksU9cUk8hbtesoTru8s9kBaydx0saAsCLAVCYcXZQmRlf0DV4D/eqNv4wH7rQGrsZXNRJ50qndz1YQ4+kXw13kEmxQJUYX95ZhkBvnOZB6gWfsN07rWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716690889; c=relaxed/simple;
	bh=DIA5pybZR9SEnmC5+DeImOXnefIy8D/nCYVJLB4fFno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KE7hbvqJZwKStTOkn282u9NVscHIVtbY06mp9pjl4nnyl1Vq6t9yXKd6DHrHYUe2n5EgokVzM0TC3k0qrJbBdHbXm8sC52j2mYEpCUpKhfu8ndUSTL3BUtehsQj6uPQV2gmsEkRwa0yvP2k5fj2bnTAVwhi1j60hKQfwgc35Y4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxNbPKGQ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df771b6cf71so2376357276.2;
        Sat, 25 May 2024 19:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716690887; x=1717295687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIA5pybZR9SEnmC5+DeImOXnefIy8D/nCYVJLB4fFno=;
        b=FxNbPKGQ+0b7FL6S1hmL6zW1q4xMuJjowP/Obp3ukzDMDmIlDVs2mnhO1IBbPw+rwI
         zVKdhzTfj0WHYbmI8BSBn9G3DSE8wCQ3s0gDJHKWRiarCkdJ7v1B8lp7g/Vts5ydKwUI
         KiILsZ9bDoZ5XVlgCoLE7H8iefvj52lh8NYRdsJKCKJaV71xOwyURWqaJvlXaUVB7JrO
         gyV1vYpzbN3baIg2Q2S+3v75op5OYhjJi4junOnYF+zoIG+VpXEZC2z2Bv8StWJyMGLm
         1+svAhyHUNDXiU14n1W+pSgeWkKGiIyuModS+/O3zVvStmSFamRVKNxgn47ThbKjCJYV
         YcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716690887; x=1717295687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIA5pybZR9SEnmC5+DeImOXnefIy8D/nCYVJLB4fFno=;
        b=qdG0JFlFdRXvOkjtCdxyIjHzzHkMwv4FYvydA2Q+o3Ktop+uXOIuU66ug0UwWUd5A3
         Mv0+DCWUpUGAs1DrnUTXAagQ9RWYsyeXPlcDP3e7ipLy976MDuGtSASKROL9k4XXkezg
         V0y+3csd8xbPTrenF+EwBti9CFNugCgVdRfEia+k+hdAq9iYV3x4yT3xdD8c0Rpxk32w
         Q70dEdTwxZ6NCY4QMfRDLN9XNOdlH/Xq3qC9mIfLWtH/LlUFbytXWsdk/xhr8SXKKvZI
         9wCps0TRHrxNFd5Zv2TA1skYCmxAbVc11WtRntnLAbNyVLmbNBG1oJppJBFIx2YBe1hE
         O9nw==
X-Forwarded-Encrypted: i=1; AJvYcCUXcQKIaXchHhFaw23M+KqUMVskMv4osYh1iTgRWW4N67d60iqejhlANc2MTGjpLQn712w0po0LRE6jbzkvTk2Pz1XD9xRWZquZ4iFH
X-Gm-Message-State: AOJu0Yzr5PkUeiPHRh7rhsjkgO+NMdGrcy/T6KkDEmtaLxpc9w3BsO9R
	bTdGpsFm43nyVrwx5tbvQBOcQVUPWAVxOAl3rPkGGW5w7FJuXQg5uNwH9xD0bplAI+iVqt2QfOF
	dmV/c5AeEClxcVPCHihTe2aVGjlQ=
X-Google-Smtp-Source: AGHT+IGxnh6lmwJCz/IqjigbqR3/kbl6EF9Xnb4m6brrSjVJtjG4roLzHD3Mebdx/nIMvMwVKHKTFIO+sKYtQr0++2E=
X-Received: by 2002:a25:bccc:0:b0:df7:8291:d109 with SMTP id
 3f1490d57ef6-df78291d1dcmr3791368276.59.1716690887359; Sat, 25 May 2024
 19:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org> <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
 <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com>
 <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com>
 <CALOAHbAAAU9MTQFc56GYoYWR3TsLbkncp5QrrwHMbqJ9SECivw@mail.gmail.com>
 <CAHk-=whwtEFJnDVrkkMtb6SWcmBQMK8+qXGtqvBO+xH8y2i6nA@mail.gmail.com>
 <CALOAHbD0LdbQTWyvDiLcgGupcQJKmadzWhoZiUTj126Rqqn6fQ@mail.gmail.com> <CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com>
In-Reply-To: <CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 26 May 2024 10:34:08 +0800
Message-ID: <CALOAHbDCykYBi__Aq95tQU7eAbN9rJ_7vNME_wREab+X1oORtA@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>, 
	Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 10:58=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 24 May 2024 at 00:43, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > Actually, there are already helpers for this: get_task_comm() and
> > __get_task_comm(). We can simply replace the memcpy() with one of
> > these
>
> No. We should get rid of those horrendous helpers.
>
> > If the task_lock() in __get_task_comm() is a concern, we could
> > consider adding a new __get_current_comm().
>
> The task_lock is indeed the problem - it generates locking problems
> and basically means that most places cannot use them. Certainly not
> things like tracing etc.
>
> The locking is also entirely pointless\, since absolutely nobody
> cares. If somebody is changing the name at the same time - which
> doesn't happen in practice - getting some halfway result is fine as
> long as you get a proper NUL terminated result.
>
> Even for non-current, they are largely useless. They were a mistake.
>
> So those functions should never be used for any normal thing. Instead
> of locking, the function should literally just do a "copy a couple of
> words and make sure the end result still has a NUL at the end".
>
> That's literally what selinuxfs.c wants, for example - it copies the
> thing to a local buffer not because it cares about some locking issue,
> but because it wants one stable value. But by using 'memcpy()' and
> that fixed size, it means that we can't sanely extend the source size
> because now it wouldn't be NUL-terminated. But selinux never wanted a
> lock, and never wanted any kind of *consistent* result, it just wanted
> a *stable* result.
>
> Since user space can randomly change their names anyway, using locking
> was always wrong for readers (for writers it probably does make sense
> to have some lock - although practically speaking nobody cares there
> either, but at least for a writer some kind of race could have
> long-term mixed results)

Thanks for your explanation.
Let's proceed by removing the task_lock() inside __get_task_comm().

--=20
Regards
Yafang

