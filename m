Return-Path: <bpf+bounces-66053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC766B2D0E6
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 03:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5364C1C247BE
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 01:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3742C19CC3E;
	Wed, 20 Aug 2025 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+YW9mQ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2DEACD;
	Wed, 20 Aug 2025 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651855; cv=none; b=aDzUL8qt4QetKFzo4aotnuCCc11JI2yYP1xwjMh+inKODR+SByQLlaGXE13yTEqa6b9JheYBvuMh9bHIGKgR6vMIncG8SdgMXN6wGTPrRNsPVY5iZPVmd9vDhQbJA7xN6VjHzDWNN/Db9s9sRnmfg/a1wOYnIKUFoP6z7SEXZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651855; c=relaxed/simple;
	bh=CaKKkh153u9GLBk0kCqBuDIf3yq1IIvzlzXYnFY/Tt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmhkUE8QPVZFCDEJnRyBjAvr8r90/dd6utvCZiZzuvA5aMG4tFU/O/blouAzQDkXCD0a1TbhhR79bhS65DFk/IjHqX7TvfYaemG3KSQimIjd5Oenej3R7P9I4/GS21qON54A3wppsmiCxzH44bsl0LDC3/tfwH9UI7eo3flG6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+YW9mQ3; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-71d601859f5so48093837b3.0;
        Tue, 19 Aug 2025 18:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755651853; x=1756256653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdjS7sR1ZSNNMgzu0GMB7zE1WJRP3IJ5P2CpnU3zZJ8=;
        b=f+YW9mQ33rtoTb1KgI/QVice7+EqNSUaEdyCMu85h3mrrZ9wmZVXVUKwnPY9dzBDJT
         7FFW6XJ5XodmTzneQis6TkwdLX9SrdEooUujBZH2viHrieoIyMVkfn7/JEcM0PHFEP5U
         QTQ1EhZ0ymUDgf0NP+JJSvu2aOJL10ULiT0fj63Yc2vepCTJOSRWr1kIcfGyPYtf0hRK
         lPEBWHdn8Igzx/DcNhu6VLc06RMBGXXUTYLXTQaVoaz+LiBQ+65C/U3l5Ppg/t590VAk
         eyfr7DLAiSxdLze1s7ou2VeKSHrGb18WsYOOr9uT5Y5Ic1zqCbLeq1qSj83jDi0MsMdr
         JBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755651853; x=1756256653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdjS7sR1ZSNNMgzu0GMB7zE1WJRP3IJ5P2CpnU3zZJ8=;
        b=Ew9yRFqXt7wPFvS8zFjrJaKLCAo1Pe6Gumr6L0xHLikba5bQehcmuRyS3NHokq0vKZ
         LY+hQAylvpukqKbqolPsYT2braUr4RssZLrejvxmtyLPq/GRPFPuE9YlWSymaOEMcuYx
         HF2KGmiQ4FbsCQaT1S3cAArkT13tETgg0+sh5BhpiisXev/4V1xPaJJC7cj7gAmkNrrC
         y6Jvm3ZvObevg58eEU4Uc9HA8U4PFCi56Fws7BYlDXOnbhPv1lzurqyT8px/iteDlHlJ
         eSbgIQQG/CMY3V4+V1irqvmuuoaBcxWN3132Td/5KSETsw6JtLo8h9k6jpwyCgJjnSY/
         4xSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+GRy+D14JQO35iWH3Hrjr52wCyayPmhfY8FcqdnuPtbj3wJyUs0ukFNZbA+Y182JtQG8=@vger.kernel.org, AJvYcCV39jyxcHDUOw0Yz3gjgiu4C1qgXbD2NdytolumgZaFRMJh9DcEui5phE5Qg1Vbb/QDmHLB@vger.kernel.org, AJvYcCW9g33rJmd/c7r5Ow7pb2uW1Aa8Dj8qQu2RwJQjtAQ8YvCC+c2HnIZEypFe577Ye0bniYJLyPLazJeIdg9+@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgO+nEprZWyaGouLskTT3FNB6ClbGemC0q7KcwDPJQQ5vjztd
	X9/QK3id4YwU5k1wURHiGj1O8UOzhBhhFnZ1Ovgbedu1DVD9nX/EzGDXLbGCle0R0odCzSFti+L
	Ep4VcTiAUX1I7jOw5HUKYzpLZm2vMSnM=
X-Gm-Gg: ASbGncuGuYYEPjP8v0LZGKlTorK7ibzSIq9vgsCeefWIBpVjxk93CKGJXjC0Ce/cj7W
	SqyDWxqveOo/8J1yWSvf3Lj4gs9t1z9Z9jxTkQxQF6FIT9IwePvxjECk23F613fsyo9JAmEDBBy
	e8tMJtHdzGcBhcVxkwV0tVJwajVIbBQNV27P5G6QjZYLIcub/SfTyF64d3iIJG5TAfndRWQeVzL
	v48vfY=
X-Google-Smtp-Source: AGHT+IEMwYXVMOnJAFhWv4+HfLt5EYfC8NnPxDufSKJt173KemP5IdIFX3eF9JUl7VJn5OQaf9D174oFfK6Zklou4no=
X-Received: by 2002:a05:690c:6489:b0:71e:6f7d:ae11 with SMTP id
 00721157ae682-71fb3246ff4mr16023037b3.40.1755651852895; Tue, 19 Aug 2025
 18:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
 <20250819093424.1011645-2-dongml2@chinatelecom.cn> <38a57013-6c0d-4a98-a887-54ff2133817d@paulmck-laptop>
In-Reply-To: <38a57013-6c0d-4a98-a887-54ff2133817d@paulmck-laptop>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 20 Aug 2025 09:04:02 +0800
X-Gm-Features: Ac12FXxBVxHMkYxZlDnkhaNzK9Ra4teZ7i9WcRPeUDauIaA_Ui6nQsVUELnI6tM
Message-ID: <CADxym3bWd6RJvpPXxYDiFuVisK4W=70_2hQzdwzygwdin78_uA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] rcu: add rcu_read_lock_dont_migrate()
To: paulmck@kernel.org
Cc: ast@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com, 
	urezki@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:58=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Tue, Aug 19, 2025 at 05:34:18PM +0800, Menglong Dong wrote:
> > migrate_disable() is called to disable migration in the kernel, and it =
is
> > often used together with rcu_read_lock().
> >
> > However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_lock(=
)
> > will always disable preemption, which will also disable migration.
> >
> > Introduce rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate(),
> > which will do the migration enable and disable only when !PREEMPT_RCU.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> This works, but could be made much more compact with no performance
> degradation.  Please see below.
>
>                                                 Thanx, Paul
>
> > ---
> > v2:
> > - introduce rcu_read_lock_dont_migrate() instead of rcu_migrate_disable=
()
> > ---
> >  include/linux/rcupdate.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 120536f4c6eb..8918b911911f 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -962,6 +962,30 @@ static inline notrace void rcu_read_unlock_sched_n=
otrace(void)
> >       preempt_enable_notrace();
> >  }
> >
> > +#ifdef CONFIG_PREEMPT_RCU
> > +static __always_inline void rcu_read_lock_dont_migrate(void)
> > +{
>
> Why not use IS_ENABLED(CONFIG_PREEMPT_RCU) to collapse the two sets of
> definitions together?

Yeah, that's a good idea, which makes the code much simpler.

Thanks!
Menglong Dong

>
> > +     migrate_disable();
> > +     rcu_read_lock();
> > +}
> > +
> > +static inline void rcu_read_unlock_migrate(void)
> > +{
> > +     rcu_read_unlock();
> > +     migrate_enable();
> > +}
> > +#else
> > +static __always_inline void rcu_read_lock_dont_migrate(void)
> > +{
> > +     rcu_read_lock();
> > +}
> > +
> > +static inline void rcu_read_unlock_migrate(void)
> > +{
> > +     rcu_read_unlock();
> > +}
> > +#endif
> > +
> >  /**
> >   * RCU_INIT_POINTER() - initialize an RCU protected pointer
> >   * @p: The pointer to be initialized.
> > --
> > 2.50.1
> >

