Return-Path: <bpf+bounces-28212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D78B663F
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F485B2041F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22448194C69;
	Mon, 29 Apr 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="H/fVaNW6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DE17B503
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433461; cv=none; b=DKkAxzTMr49h9cbdc0sJQ/YEMLrwtnsJJBGzz7kQqz2N8B6q3wPA8fVIId873fNb+xhPBf2oVAjfPbZWCFVVgNIeuycCkd9TaV7ZWkeSpfwJXSnoDF7kUutj8o03Bvn3bakg1aYntTsFLDI6bOFyeJmWDyyGOmIOG7aVFYvkgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433461; c=relaxed/simple;
	bh=S+dPFVEkBSO1+Lekql8lRjMu0h5ao+3tKW3x9Y61x5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQWAdVmU93DgBIsOBd3XsmcrDUHFCpISTaEWoE+X2HjRfEUJaLLwHyxQdIra1EcA/5M5BGMxfDRHLhewEK1kBp11PbMGwmBK9EYtm3PSZyV7WrcVJPCrKIL9m0q7t4f2YSz1iRmrQtA1o6DRUB4e0yscaNsN9/jnEdPvyNtsPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=H/fVaNW6; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4dac5a3fbeaso2020814e0c.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1714433459; x=1715038259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdB1a9j5b9pnV9/YAndgEj8zAneUUJ873X3soEfLy4M=;
        b=H/fVaNW6PHLXWfQAEhfo5fNSBAvny2mVGwgE1Qvz4jpTVXz3x9puL9r7C7rEVFzCOd
         OJoBMxv8AGi2Gwtr3/v4gOqscbN84xNtloe1NFxvrIWCyNosG4yKhScGSrbO0qu6qRK2
         3UR90uh6k7pdHjN5F2qQMoBHZqVR2OWw4ToKzBbwsbSz/9DReqQnHvxvymBrW8PK+3DW
         10x0/v4NbIFPp/7OrqpST/UP0P+pZW4g8UAmlGct0s412y7Oyl4oB76O+LQVEHGWtkui
         0Aw3puXgirt0LupgMhv6uc+RVYFjfOzJJ6IzBjW5tt5sqjfTZvZCzUsE8wWm8bHAzDmh
         M2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714433459; x=1715038259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdB1a9j5b9pnV9/YAndgEj8zAneUUJ873X3soEfLy4M=;
        b=ZtJ4uygQcDxqEUzXf89RPq9lWZI/9/aESjiAed/BzPxo5OOAJ/Mwf2gsrA0O4T5Z7G
         TB552YJ4WCr6DgIqcmPTxQTtMLIGvc9E6tKFdGzzSCvARRl7MbIjMgQHgtH38rrr0A/n
         3y4sNnM4bUXeEwbF+Z9pGuHvGupfg8cdIOPdzP21VuSMRy3yCP94P4QrTUA5j6auGUWn
         06TzKWvtSrRRtDvSFcBv2V5OqXiaXybP3pQnw1nm8JfKiaONQNZ4iBr9SRVdlxR1PpD7
         4fjJaup782Qku9q8yTYZG2D2jlqlI3wlLsLjLFsjU6tAvsGvQmVcWrRkQy9qnma8p7HM
         na0A==
X-Forwarded-Encrypted: i=1; AJvYcCVonin1xADN/aiHZN8MIjkBBE4I8IzGsFTuq2oFdf2YXBlNRntKlgcRwyu3iWEaotPQQqCAd3+rIASiGLMoQLQJZYIo
X-Gm-Message-State: AOJu0YyAzREmLdNZv7clHmSRAx5I+thINv0NVXEgdcUxWl99NAbhp30R
	Tr50hbTf4yMDsSjYLVxtrYDyv6nwI2x1ICkFgJRngk71ZII3QCRWPjpgTueITG2r28lf1WrGNsG
	LPUiPVRs1J6j7eMqKdtmOtTzsqwwOIJ4J1FsO
X-Google-Smtp-Source: AGHT+IEyRjAcGfJRvUwcUnwiNyKDxzkAamKGUS14YMsy/dxwXWe/Fei7hW9Hmpxn9s8N9fSZhCPyVeoDb9ErL8VjVLQ=
X-Received: by 2002:a05:6122:1695:b0:4de:8eb7:a8b8 with SMTP id
 21-20020a056122169500b004de8eb7a8b8mr11132092vkl.3.1714433457692; Mon, 29 Apr
 2024 16:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com> <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
 <Zi9Ts1HcqiKzy9GX@gmail.com> <Zi-l8xKhMbdJ-NBo@krava>
In-Reply-To: <Zi-l8xKhMbdJ-NBo@krava>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 29 Apr 2024 16:30:46 -0700
Message-ID: <CALCETrUUOU55ctJwxZeV7N-a_hadV7ejYnacEDbhmc5PFb0fvw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Hillf Danton <hdanton@sina.com>, Peter Anvin <hpa@zytor.com>, Adrian Bunk <bunk@kernel.org>, 
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 6:51=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Apr 29, 2024 at 10:00:51AM +0200, Ingo Molnar wrote:
>
> SNIP
>
> > The attached patch looks like the ObviouslyCorrect(tm) thing to do.
> >
> > NOTE! This broken code goes back to this commit in 2011:
> >
> >   4fc3490114bb ("x86-64: Set siginfo and context on vsyscall emulation =
faults")
> >
> > ... and back then the reason was to get all the siginfo details right.
> > Honestly, I do not for a moment believe that it's worth getting the sig=
info
> > details right here, but part of the commit says:
> >
> >     This fixes issues with UML when vsyscall=3Demulate.
> >
> > ... and so my patch to remove this garbage will probably break UML in t=
his
> > situation.
> >
> > I do not believe that anybody should be running with vsyscall=3Demulate=
 in
> > 2024 in the first place, much less if you are doing things like UML. Bu=
t
> > let's see if somebody screams.
> >
> > Not-Yet-Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Link: https://lore.kernel.org/r/CAHk-=3Dwh9D6f7HUkDgZHKmDCHUQmp+Co89GP+=
b8+z+G56BKeyNg@mail.gmail.com
>
> fwiw I can no longer trigger the invalid wait context bug
> with this change
>
> Tested-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Andy Lutomirski <luto@kernel.org>

