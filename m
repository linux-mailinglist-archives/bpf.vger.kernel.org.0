Return-Path: <bpf+bounces-32354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522690BDB3
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 00:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85EB282BB5
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102519923F;
	Mon, 17 Jun 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNiPgziZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C91D953B;
	Mon, 17 Jun 2024 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663877; cv=none; b=pgIy+aTqcGlQIe79sF4Ju2VadL+I5Twgq8BfUyARpkn9aD0o02QRaM3SbJSixtyb+Ebn/ZK/7C3vVDIfru4qQ2qbrc/yDoq/NuLAIz0EXVFiM7tug8fqEeOAKD57uD2ebCH+qZQxYUuWVDc5LcNg1lsTfRkwODaqHap8yumIJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663877; c=relaxed/simple;
	bh=taAqYrQF81TVYm65wn4IiMSf/9INwWarAItvrCdiRkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeirDbkXxH1IfcCGfRFBf/eBkBKRI0KlJGHIQgS9D0mxQpQBqA/HLmeboJCS5TuNrW6WOWS+J0IR/x+ZlGtKvz1t6GKzm1SOCN6gpHBiRBcklUfM9F6RRFuNnZ6qFCGEkMA0xmd1PfQ7cRkYK+KD7Nc6V2behz+JPl3n64SMXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNiPgziZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c2ccff8f0aso3923636a91.0;
        Mon, 17 Jun 2024 15:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718663875; x=1719268675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtXXRtEENx+a9+ZeGrwFuPMliabAYCdX3SIp9cwFOvU=;
        b=jNiPgziZ60sAJcy3gCJx6720dVPZxHT6dBGzfrfNddpbBsEzzrBcycTTDRzbtvuxln
         +aoMPOrp8EYWeJBvyD0ofvShXvBCEtUJq91Yu3+ikeVyexV/43A/qJtIK5W6/ZsU2iMx
         SGkRrfDt7ZbNsgIl1nb8jKtlnBJn36Xz1OnoKqngpDYQoWiKtEDkQI/nNp+GMcncCthf
         2jOY+t/muYolWN+H6RkPSpJFGft4gCC5OPYdk1/ecLOvtFDKSyncF3UXC2hN9zyN0wkX
         X3VTllNsD/6yNP1VFUo5biflPrsuTt6oE5xBW5DF0n9mYy02CYTPcx/aFohOMaXcR+HJ
         Qelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718663875; x=1719268675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtXXRtEENx+a9+ZeGrwFuPMliabAYCdX3SIp9cwFOvU=;
        b=TF98mxAZQp0AzM1UpulGWZzFuoP64roEtNzM0XSbUooMVR1y3FIoQDRVbW3dgro2Kb
         UqhjtMXYB19BoG/mt0OH/+N1DZzlenLDva3004MBaFlun2xF1zXZov5Du9uYzIWssL4A
         D9uTv94lAs/RC6mN2vtrTPGWbThlfT5nWzifQyccOAtT4sP/W1foEjUVee9ehZl/TZSk
         6LJXl3nzyEP7C09NTOS+w6Ob0t27WIDDOg3A4izmcY9x9AuAqn3EuJ0CjLzTIvaBVEsB
         sheUatpK2ehTZ4Pq6BkqTAYwotbuHotOhE+wCl7wfkh+CNNjFAKBIIglN1j+I5Bw056t
         /CIg==
X-Forwarded-Encrypted: i=1; AJvYcCWBABApT8ZjLqDsCoByg9ITvRJl7M9hCj/ockR/NKx+FKz2sfO+LDkSht/7ETaYu7tQ4WvGBVZ3RTQcJbr5EvrQCnvjaE5u+s5SamyAWgq0S+9iqvNxYx9MtTgf+IAqSiJywEey8ZwYLOZK0iFDlxZQaDP3MCWiHJsVc3+Zc8rpg0FFW6oWD/AEHQ==
X-Gm-Message-State: AOJu0Yz2me/6u6wCmAok0s3t1R2biiwGu2SZXrYG/QGOB9bA9b/oxQA7
	9O3RxqZPyRX0Avy9+Bqtu/+CJlMvHYQnZip4/JedJ5moJ7NJwmqT8m8zwdNDOkFox5owANix0DY
	oEx61PiIRyaK/YUoT3RhE3R1HQeQ=
X-Google-Smtp-Source: AGHT+IEGWTE3MHYNhB+l4fsMscRQStPnlTAYm+5JecWWnmIWqbiz7K6pxe7+vydecNCwHESC8qBSk0WkdCudvLhv66U=
X-Received: by 2002:a17:90b:785:b0:2c2:daf4:5e5d with SMTP id
 98e67ed59e1d1-2c4db44aa13mr9326491a91.24.1718663875160; Mon, 17 Jun 2024
 15:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522013845.1631305-1-andrii@kernel.org> <20240522013845.1631305-3-andrii@kernel.org>
 <20240604231314.e924c51f7b9a18428a8a7f0f@kernel.org> <CAEf4BzbneP7Zoo5q54eh4=DVgcwPSiZh3=bZk6T2to88613dnw@mail.gmail.com>
In-Reply-To: <CAEf4BzbneP7Zoo5q54eh4=DVgcwPSiZh3=bZk6T2to88613dnw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 17 Jun 2024 15:37:43 -0700
Message-ID: <CAEf4BzY0VWXDo_PUUZmRwfGZc3YfNy4+DDLLPT3+b3m6T57f8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf,uprobes: fix user stack traces in the
 presence of pending uretprobes
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, x86@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org, Riham Selim <rihams@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 10:16=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jun 4, 2024 at 7:13=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
> >
> > On Tue, 21 May 2024 18:38:43 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > When kernel has pending uretprobes installed, it hijacks original use=
r
> > > function return address on the stack with a uretprobe trampoline
> > > address. There could be multiple such pending uretprobes (either on
> > > different user functions or on the same recursive one) at any given
> > > time within the same task.
> > >
> > > This approach interferes with the user stack trace capture logic, whi=
ch
> > > would report suprising addresses (like 0x7fffffffe000) that correspon=
d
> > > to a special "[uprobes]" section that kernel installs in the target
> > > process address space for uretprobe trampoline code, while logically =
it
> > > should be an address somewhere within the calling function of another
> > > traced user function.
> > >
> > > This is easy to correct for, though. Uprobes subsystem keeps track of
> > > pending uretprobes and records original return addresses. This patch =
is
> > > using this to do a post-processing step and restore each trampoline
> > > address entries with correct original return address. This is done on=
ly
> > > if there are pending uretprobes for current task.
> > >
> > > This is a similar approach to what fprobe/kretprobe infrastructure is
> > > doing when capturing kernel stack traces in the presence of pending
> > > return probes.
> > >
> >
> > This looks good to me because this trampoline information is only
> > managed in uprobes. And it should be provided when unwinding user
> > stack.
> >
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Thank you!
>
> Great, thanks for reviewing, Masami!
>
> Would you take this fix through your tree, or where should it be routed t=
o?
>

Ping! What would you like me to do with this patch set? Should I
resend it without patch 3 (the one that tries to guess whether we are
at the entry to the function?), or did I manage to convince you that
this heuristic is OK, given perf's stack trace capturing logic already
makes heavy assumption of rbp register being used for frame pointer?

Please let me know your preference, I could drop patch 3 and send it
separately, if that helps move the main fix forward. Thanks!

> >
> > > Reported-by: Riham Selim <rihams@meta.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/events/callchain.c | 43 +++++++++++++++++++++++++++++++++++++=
+-
> > >  kernel/events/uprobes.c   |  9 ++++++++
> > >  2 files changed, 51 insertions(+), 1 deletion(-)
> > >
>
> [...]

