Return-Path: <bpf+bounces-39064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3001696E3F9
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BCC1C2312A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541719FA8D;
	Thu,  5 Sep 2024 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB4vooWJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA3156C73;
	Thu,  5 Sep 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567772; cv=none; b=KQMS5vEhoeFvErwysj+SfVHMk4P3PumKeGDf4nTeOVoCJia7mH+VuhWUDR0LNBmLyPxZLkrC73FZcoxHNCtrYhfY6ElapOfpHCIVZXthZJRVCKN3bXTRH3rhJ9iBbjhK9q3/pf9atGkgGidlSyGLKmpjN279haY8QK2LRzKwOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567772; c=relaxed/simple;
	bh=V2/0mgoYuEybPslQozyFRZgog9QYa8pW+w5QiVtaAm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVPo0cHRIkFsowe4b9lQErld+d2VR3gzlZOht2UUCbUzzuWgKxW5gOyEcTWwIR+MCcj07KQwDepmcw6ZRK9MwGtEzC7fr9LP2qn6D1abjki0WGpCamtcfhwVUd3gMApECNw68ESvEvR7pmEvGbVt6d9Kjuhh1LulBXRrKP64pWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB4vooWJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8b68bddeaso932010a91.1;
        Thu, 05 Sep 2024 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567770; x=1726172570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsQ24CLRwdNPp9pKZ4aLVJ4C9sDxViHjLsDm308rB6c=;
        b=XB4vooWJPAeQpySqmADBYBzBoskuWsRIyz1tay4WgG0J738uNiw/ffs4u3vXb6tpvQ
         Gz7tDwWbhQ7bmuKZ6za3WpMBzZNku6c0D3Lro4BdlKXWgETUCXWdrrXylo8SLFuMKv2O
         65E+o7ribpKBKN8aOnHbudDqfn99NfqcDrHM3BmK5EgoyQm7VIjmlD7NwR4pZ7TU3EUS
         /hw5LhYNf6cTUWfM5gNl/xx67FuL8poywuH7rMPf0B6aHqQ4lqcrH6/848+7oyd2Xd3l
         Tu0in37xe7sRXrhh6zbL4VcSf/RGGBBL11Pa5X8fkGuz5Jq5aPLNWD1hX0EyFCJM+H09
         inGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567770; x=1726172570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsQ24CLRwdNPp9pKZ4aLVJ4C9sDxViHjLsDm308rB6c=;
        b=q5PXtF4Cc3Q17aW5Wi/L6Wb37p5jIZ/4YUcxnAuKAflui2kRSqaRq5mlaaGjGwwvEJ
         jnCpyWejbPlmVNPbcnhpaA0Tuw0wYDoiOJsYoaXxXXYkIW8d+Bij+qDLInWtqLaZoLLx
         aAwzkFW9E6v62R78+ndkiyT0b++9dBiYyZDSZkJSaO0lR6hKiyghc51fiDAgEp5nXpTG
         zIIfR+O/UdIDr0SqsOX0GGLgpcnX7xJLYevgbWkkH6pWlxgqR/S0dG6Hx428DtPPnoB7
         MWZ9bu+YWiH9Dkt6bxHQOwPobU0vfLxG9KoGHr18QSouysb7vXWr8sMj9qwRNPrh97qd
         PpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIv4wrt06kosTINkXqrAEDl+d4vR8vArZ4r2vgbj81seh5OPCMKM1RNIK6uy3iR1wxmcA=@vger.kernel.org, AJvYcCWCvtfjexz0Qk8/+bv3Cnx3wyMS7olnmzE8pnROCCpISGdAk2JosGHwR/YqdOXZkS1SOdouCoY+637fk88k+jwW7Q==@vger.kernel.org, AJvYcCWS+9nhkXR763gwno+NnOz8RF6gbe5ZZp31psIAFjnowEti9NPCAP/UdodUf2seNz2EiPEKkqqF@vger.kernel.org, AJvYcCXcwMQq/Hxpw+BUH5eSFgHsjPN8O9xgLI0LJH7GnoDao+BrQXBTWjGLdGBauyDJIsbMZMzZ40xE5h1rtTBM@vger.kernel.org
X-Gm-Message-State: AOJu0YzADYM1KwrC58FyOFR2sc6kwrKDrnA+ut5OXLymCRxxwR53mxEb
	UzvvH1U6k3aVC/zCARfGOzysD62dNaD4O7bqRZMZc/4aSQJsABwxKS7vuSfFl6GelKLjIn+RRej
	hT7srPsKZZ9k7VqxvcgmErhoPtKo=
X-Google-Smtp-Source: AGHT+IFAzAIM1kH/ArteWyFmN+od6TQ5fhVOiBxbTEu37fB1ZEIZVPkjyc49sbtG7lU+LkmZbxXv+bISxuddBPMp86U=
X-Received: by 2002:a17:90a:ce81:b0:2c9:1012:b323 with SMTP id
 98e67ed59e1d1-2dad50cbcf7mr671006a91.27.1725567769844; Thu, 05 Sep 2024
 13:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905180055.1221620-1-andrii@kernel.org> <ddfd906c-83cc-490a-a4bb-4fa43793d882@linux.intel.com>
In-Reply-To: <ddfd906c-83cc-490a-a4bb-4fa43793d882@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Sep 2024 13:22:37 -0700
Message-ID: <CAEf4Bza9H=nH4+=dDNm55X5LZp4MVSkKyBcnuNq3+8cP6qt=uQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: fix wrong assumption that LBR is only useful
 for sampling events
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	peterz@infradead.org, x86@kernel.org, mingo@redhat.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, acme@kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:21=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-09-05 2:00 p.m., Andrii Nakryiko wrote:
> > It's incorrect to assume that LBR can/should only be used with sampling
> > events. BPF subsystem provides bpf_get_branch_snapshot() BPF helper,
> > which expects a properly setup and activated perf event which allows
> > kernel to capture LBR data.
> >
> > For instance, retsnoop tool ([0]) makes an extensive use of this
> > functionality and sets up perf event as follows:
> >
> >       struct perf_event_attr attr;
> >
> >       memset(&attr, 0, sizeof(attr));
> >       attr.size =3D sizeof(attr);
> >       attr.type =3D PERF_TYPE_HARDWARE;
> >       attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
> >       attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
> >       attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_KERNEL;
> >
> > Commit referenced in Fixes tag broke this setup by making invalid assum=
ption
> > that LBR is useful only for sampling events. Remove that assumption.
> >
> > Note, earlier we removed a similar assumption on AMD side of LBR suppor=
t,
> > see [1] for details.
> >
> >   [0] https://github.com/anakryiko/retsnoop
> >   [1] 9794563d4d05 ("perf/x86/amd: Don't reject non-sampling events wit=
h configured LBR")
> >
> > Cc: stable@vger.kernel.org # 6.8+
> > Fixes: 85846b27072d ("perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK f=
lag")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/events/intel/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.=
c
> > index 9e519d8a810a..f82a342b8852 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -3972,7 +3972,7 @@ static int intel_pmu_hw_config(struct perf_event =
*event)
> >                       x86_pmu.pebs_aliases(event);
> >       }
> >
> > -     if (needs_branch_stack(event) && is_sampling_event(event))
> > +     if (needs_branch_stack(event))
> >               event->hw.flags  |=3D PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>
> To limit the LBR for a sampling event is to avoid unnecessary branch
> stack setup for a counting event in the sample read. The above change
> should break the sample read case.
>
> How about the below patch (not test)? Is it good enough for the BPF usage=
?
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0c9c2706d4ec..8d67cbda916b 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3972,8 +3972,12 @@ static int intel_pmu_hw_config(struct perf_event
> *event)
>                 x86_pmu.pebs_aliases(event);
>         }
>
> -       if (needs_branch_stack(event) && is_sampling_event(event))
> -               event->hw.flags  |=3D PERF_X86_EVENT_NEEDS_BRANCH_STACK;
> +       if (needs_branch_stack(event)) {
> +               /* Avoid branch stack setup for counting events in SAMPLE=
 READ */
> +               if (is_sampling_event(event) ||
> +                   !(event->attr.sample_type & PERF_SAMPLE_READ))
> +                       event->hw.flags  |=3D PERF_X86_EVENT_NEEDS_BRANCH=
_STACK;
> +       }
>

I'm sure it will be fine for my use case, as I set only
PERF_SAMPLE_BRANCH_STACK.

But I'll leave it up to perf subsystem experts to decide if this
condition makes sense, because looking at what PERF_SAMPLE_READ is:

          PERF_SAMPLE_READ
                 Record counter values for all events in a group,
                 not just the group leader.

It's not clear why this would disable LBR, if specified.

>         if (branch_sample_counters(event)) {
>                 struct perf_event *leader, *sibling;
>
>
> Thanks,
> Kan
> >
> >       if (branch_sample_counters(event)) {

