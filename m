Return-Path: <bpf+bounces-78088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CAFCFE22C
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 137CD313CCF0
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313232AAC1;
	Wed,  7 Jan 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7vFa3A0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F132AAA4
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792031; cv=none; b=QQZrP/dpOlXAkxebd0lt9fxjrqhNfqtBkonByquSvQOhFNKVZ6m7uNtzgzQK6pqM1e/rdEOiVnQXbjeEkNKmBR3DYTA63WesAvI2640+9K4L8maiGnHkG5x7fkpIuE7kn7PfbA6KHleQ9kik77HFjKP9Cy0o9AL6kTLfHGEet9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792031; c=relaxed/simple;
	bh=eoUYiccCPfQCG3U2pquAI7WoxvfBiLnWgqIySjCZ4Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LISz6szp3F1ApLETZRkWGHaWdkz6M6upxMNb7CismOL652cjD7OQ9JIGa67WqgBd3WjftSjd2PZC9zhUx8eQ5DWMis5IOP7HwnIrWU7I5Xw2QuUl3YHMhd+ETYlmTFw5NsmkwwvbyZXhEPJmtXIMS0146RIuqlQ8UEOo9NjQ+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7vFa3A0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767792028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FAV0wASxR2yI419oALk6fAKqfLd6t7b3o1j99zRYxc=;
	b=D7vFa3A0OaejeWVZlcShlbd2raLLi0gHvJ6eXgkNaAbKQm12P78wBHUxhO3S3J1F5fRjD6
	yf9t+pnpbPKdet2ebzec8f4QSBaeKYiGA6f7sJ11JRb+wD/gCfYiHcH1bgiIOvR/PC2NoT
	p7+0ubUDZNQ4sgZfwEAcrHymHIN34z0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-i6Ps_J66N5GEMwFJO0n70g-1; Wed, 07 Jan 2026 08:20:24 -0500
X-MC-Unique: i6Ps_J66N5GEMwFJO0n70g-1
X-Mimecast-MFC-AGG-ID: i6Ps_J66N5GEMwFJO0n70g_1767792023
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-59b6ab3cceeso1369090e87.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 05:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767792023; x=1768396823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0FAV0wASxR2yI419oALk6fAKqfLd6t7b3o1j99zRYxc=;
        b=Ga69Gy7YOZNzW2prSawP7zdp1ILwf2NqXfVvwT18XyJr/lXojhCPMZiKtTsGk38Izc
         mzCSf5AFr/mRNYpUDJrIoQ53Ak6PKRVeKdl/cz0QgDcXi+gG1gHowcgW7LrkW/0LKOXm
         8kjR/wYfk8kIciXRbsxuvA9fHsnrVm2RtD2MJikg5GiD+UivcEjWC5XY5XAeH5oBYWmi
         EYDgd6KRary3UgTyBRcPBSVd+m+uqxQ1ceDaLY1bnDFP2YmYfP648m/VFI2HPeP9txli
         +QrMS1NWiEIvNBFvNAhnQlm4tbswSAY4b/YGPKu8lhSNYPNOcV61FRFRV1ETgEstoqpq
         HEPg==
X-Forwarded-Encrypted: i=1; AJvYcCVBc1vz8m1KBIBDV5SeP7tiJrunDcs7iwTHXpGNbBq4LLK5Xx050rcFBOBMNeBvdoVwd58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzocrc7ZSEwmMvoccAJBn8WLTNL1GC1hiAk56nMadDaXvmIoArq
	kypGScwGYDM4qr1veOMhdEvvwZG+C5CwEDpmRVF9F5/1Ba3cKvp6BpVOboos5zc+Ib79Hr/klUN
	iEhWRRvELXODPdednrWn++8gAelvk2KAIQAJUcoDp6obDjxORjrxhYkXi+78ALxmjqm5Nm4+jEg
	ledC9BTi8JO1WnsYlqpRTAiYeG8jD8
X-Gm-Gg: AY/fxX5g6PNCbk1yaJzurdKVFeDvOImSkaFVnvWA+ZLyoL+3jbfnvDOjuJz940rBUk9
	ndvzoAkBz1yUr06cjkcdEn8Ip9RKO6euDNFaL7U3KQ10c9JNdM/4M1aCJC+yhyz2cjHIUjymTJa
	AYSfl8+tPXLAyMNntieaCUVi3RZ8Q3/KoEuTAph1E9rrpXhrrWjMM98q2ly7csuTjrCnoKWs5O4
	i0kwY+qwQVOJvw9a8nNeL+Q6Z9LMaD2aHS52os4BcZ/vva0LcNkTs56sMsoxlwoG9kTHq0LwkQ4
	Yj6F2aHK3ouf
X-Received: by 2002:a05:6512:3ca4:b0:59a:1a54:2d1d with SMTP id 2adb3069b0e04-59b6ed1347cmr923467e87.11.1767792023011;
        Wed, 07 Jan 2026 05:20:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM4Wg/31yJtJLWCgaWo53ubArkeBsnxRGahv7hLfjQV7fqcR9f965ACY/ViRie6Vo/bTJVv4065z0C0SGKiSE=
X-Received: by 2002:a05:6512:3ca4:b0:59a:1a54:2d1d with SMTP id
 2adb3069b0e04-59b6ed1347cmr923449e87.11.1767792022589; Wed, 07 Jan 2026
 05:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-14-wander@redhat.com>
 <20260106110332.4b46ed80@gandalf.local.home>
In-Reply-To: <20260106110332.4b46ed80@gandalf.local.home>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 7 Jan 2026 10:20:11 -0300
X-Gm-Features: AQt7F2o5LZDQmwZo2GzGL3PipkTd_z5ELpWMtWI3IvYa0sletpWe6Q_7-50shWk
Message-ID: <CAAq0SUnzMjbsV-Q9yXi1e29yLh27_+L6zC_=uKMV+aa1yGWojQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] rtla: Fix buffer size for strncpy in timerlat_aa
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 1:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue,  6 Jan 2026 08:49:49 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
>
...
> >       unsigned long long      run_thread_pid;
> > -     char                    run_thread_comm[MAX_COMM];
> > +     char                    run_thread_comm[MAX_COMM+1];
>
> The reason why I suggest strscpy() is because now you just made every thi=
s
> unaligned in the struct. 24 bytes fits nicely as 3 8 byte words. Now by
> adding another byte, you just added 7 bytes of useless padding between th=
is
> and the next field.
>

Hrm, I missed that issue. Maybe I should have set MAX_COMM to 23.
Anyway, in v3 I will switch to strscpy() (maybe strlcpy() does the job).

> -- Steve
>
>
> >       unsigned long long      thread_blocking_duration;
> >       unsigned long long      max_exit_idle_latency;
> >
> > @@ -88,7 +88,7 @@ struct timerlat_aa_data {
> >       /*
> >        * Current thread.
> >        */
> > -     char                    current_comm[MAX_COMM];
> > +     char                    current_comm[MAX_COMM+1];
> >       unsigned long long      current_pid;
> >
> >       /*
>


