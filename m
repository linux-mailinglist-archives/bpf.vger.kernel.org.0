Return-Path: <bpf+bounces-30527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A18CEB7D
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45FF282A04
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 20:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650F17E796;
	Fri, 24 May 2024 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu9n/tyk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD3722334
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583713; cv=none; b=RZmDM0No4vcywqRT6czrr+zKmG7AAknvGYN1p1UAE/gwfqJsi9PwIFM09NS/vrZT5n3y0Mhl2xiMoE/ekKsh7liUV6UbY0oqLl9/piLRQZhGil7yV+AM9reQ1PFjE8/2gFztzflC7qC1nr8BWH/lMytsBtiP9j85bsr86Y0XyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583713; c=relaxed/simple;
	bh=o4bq4gpTKUpm6psscsvmWAwfr6ktqC47DH6KftntyZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDksR6zl23DPcSGIRpO1S6jel49gC1rWY1G1NYKOrmuQUI+xHqXbjJgOCvaL28xxCSNZbVhWYyoN3GWC0kGZXG2mh6BooKB2brS3QXPZnCWrBaAPYExpVttVBsic1sYIMT4ElNnPhJRYzGV0/nZDmVJx+uTavSEDPbVJJCtp7yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu9n/tyk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-351d309bbcfso2450855f8f.3
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716583710; x=1717188510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZf6pqdsxL8oudsN+unF8mLiD0050nwWhDydXKK2Its=;
        b=Uu9n/tykIZNyfxqsdZiL/oEZlgakUh/kUgrrAG5UXZRm4HZ/nltaYCklwlubc3wRyB
         BULbspYljl+XodevKycX8h2yQeGF4QBxp3gSDbaLd9/5KziiHXlLGX1vqI6TtfibiPQ1
         U6LOKDFZr/7Z8BrVMhCxKXvTD4wpvRFwyo7tJgE4wLVnqn1wA+qLwGQe6mLyt2EAG/Wp
         Wg8jo0drs/KuRAv8AU7akNckY52AyFqZaQnuOtMwAFUy9nwJbnNMaPndMGNoYzTeHz9a
         Sn5YCSqjsUL7nEJMszZ+uwZ7bwKpc4HO7e3BaCiACH0k7JCn1qZVM1SOglggQemD5rIm
         M3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583710; x=1717188510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZf6pqdsxL8oudsN+unF8mLiD0050nwWhDydXKK2Its=;
        b=oBr5RhvGB4Y4OD2mvUz7yMPo7UF2Ami6Uu0/VyrtAQPOXatqB/pXH/2KhoGBp6VRnz
         TXMDXN3va3ot4u6//W+XTIeHrmgP5a8gIfD4KzVL7sirqcl7un8zpigd5/IAusDFoKdO
         QFYtLduRZyDd6/T7mTWZWzDeymgkZlcIbw9SO7FXQ3zt0KTw6AZdWkaJB5JSE1QijlsN
         KShs4Jq3LXHR6THbtSQ+c742Je2phH0OzNDVd4aGTMETSIVIuAwM8YWJyPCKpD8gAdFL
         RQqdk58XSceZTpPj8KDwGIiJfXajEMnmOUiwrEPLiKFFgShcwNaTs92UphZGzDsjxWF4
         Ve7A==
X-Gm-Message-State: AOJu0Yxt0Y8CzArI1tfqzzOzCfoqYIwmDRi1KIzi1VkfmxXrPAhlSJgk
	Vg/Z8s+s73K4l5uzcwgZKLPbOROabjTH6VBt+y91AptiD75vbQQCl+S5WhtIW6ZPch0wwByxl+c
	tslWk+j5K1u6PazC16hm4ulnukA5GAw==
X-Google-Smtp-Source: AGHT+IEedplB68baiTPU0ox/ySM451I9V6Rkzc4iPp5T7be6mvZyygTAMphtZcXlOpKUyOyQ8gdLf9irPBlToANptsg=
X-Received: by 2002:a5d:5452:0:b0:354:eb32:6d1a with SMTP id
 ffacd0b85a97d-3552fe020c4mr1855183f8f.59.1716583709465; Fri, 24 May 2024
 13:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3faf9614-d61c-47a4-b8ba-6d97ae71fd44@google.com>
 <CAADnVQJw=mEX7ZEKffGMUm9my1Di9wFHwayhz+4vno_fypmnsQ@mail.gmail.com> <28aaad42-3859-43ea-8a45-dbe83bcfd5d0@google.com>
In-Reply-To: <28aaad42-3859-43ea-8a45-dbe83bcfd5d0@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 May 2024 13:48:17 -0700
Message-ID: <CAADnVQ+Ct5Airbr+pniWu2tCB=+jfskoX+N41wBj0n7Ja=MYTw@mail.gmail.com>
Subject: Re: BPF timers in hard irq context?
To: Barret Rhoden <brho@google.com>
Cc: bpf <bpf@vger.kernel.org>, Dohyun Kim <dohyunkim@google.com>, 
	Neel Natu <neelnatu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:42=E2=80=AFAM Barret Rhoden <brho@google.com> wro=
te:
>
> On 5/22/24 16:03, Alexei Starovoitov wrote:
> > On Tue, May 21, 2024 at 2:59=E2=80=AFPM Barret Rhoden <brho@google.com>=
 wrote:
> >>
> >> hi -
> >>
> >> we've noticed some variability in bpf timer expiration that goes away =
if
> >> we change the timers to run in hardirq context.
> >
> > What kind of variability are we talking about?
>
> hmm - it's actually worse than just variability.  the issue is that
> we're using the timer to implement scheduling policy.  yet the timer
> sometimes gets handled by ksoftirqd.  and ksoftirqd relies on the
> scheduling policy to run.  we end up with a circular dependence.
>
> e.g. say we want to let a very high priority thread run for 50us.
> ideally we'd just set a timer for 50us and force a context switch when
> it goes off.
>
> but if timers might require ksoftirqd to run, we'll have to treat that
> ksoftirqd specially (always run ksoftirqd if it is runnable), and then
> we won't be able to let the high prio thread run ahead of other, less
> important softirqs.

Understood. That's fair enough.
It's not jitter, but that softirq in general cannot satisfy the requirement=
.
Please add this explanation to the commit log.
I think another example would be to implement a watchdog with
bpf_timer in hardirq for things that run in softirq like napi.

> >> i imagine the use of softirqs was to keep the potentially long-running
> >> timer callback out of hardirq, but is there anything particularly
> >> dangerous about making them run in hardirq?
> >
> > exactly what you said. We don't have a good mechanism to
> > keep bpf prog runtime tiny enough for hardirq.
>
> i think stuff like the scheduler tick, and any bpf progs that run there
> are also run in hardirq.  let alone tracing progs.  so maybe if we've
> already opened the gates to hardirq progs, then maybe letting timers run
> there too would be ok?  perhaps with CAP_BPF.

bpf_timer already requires cap_bpf. No need for extra restrictions.

