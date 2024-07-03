Return-Path: <bpf+bounces-33793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ACB926821
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 20:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AFE2895D1
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFE2187332;
	Wed,  3 Jul 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqwnK+co"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEEC185095;
	Wed,  3 Jul 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031149; cv=none; b=G9gFLqs3uTxKBhf8FH+FXt/tUcskjGv5o5ISmC2fMhJoj0wfqz6k82VFaeBsc2BKzwbs84kNDhrZq9UtWQBa4LNRoWXu3PytOKfeV+a47jPGYD9CXJw0UUSUd1sXhTddCdXsCRnxEpVQaz0+PvNTP2pqcPTXUf9BHp8MvuB4GQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031149; c=relaxed/simple;
	bh=icuTVd0t56g579KUpSw0hIIB4UFXDJGvd4a2hkPcJAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fn/NDvCRvNkfN8k/FLV3gFQms8Af0SgQn33PSN+6q9IGP6wYmfJPhseazlEWMxVIAK+9e7yjwqxw/I7f4ClW+EdBJPrnb7AvSDS8kB2Zx8Ses8OQXtOX+MIPrCwJB0TUyA5jZ4aK+jJbk31k0pv2Ptu2L9dITRidyZ2M4kDkcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqwnK+co; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7180e5f735bso620509a12.0;
        Wed, 03 Jul 2024 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720031148; x=1720635948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap3DUN9BQkgBm8gM5zdnpaIUYWgH9LtzpwFPs3pRao8=;
        b=WqwnK+cogz8YSUztMnSfG5bfRSZm2YJ5ZGcxfL1/OcxKN38zWZOD2zID5g3ZsTSrCV
         cI9Sw4BF8ZyKBVFEVeQp/Y8Kz8HfuC8UcKg22zaj9lPf7WBSCJIMm2IaQBrb9p6vYfMo
         4NDqleDH8eCxk8VT7iBj1QrhM6kjEGEMZZscFlUBKISTsjAMU1zSp3S7M71GO293KB2r
         oXjke/EIL/W/O8r7LH3Xa5QggTA+llAkSNFt+sbuYWljdhaaISv/e7B8oPGFE11mjjPH
         MBgOOKnckeWUHcVM5dd14IHDq2Q6exCd71Bhf40+7WPrxuBKkwCBI7GOIuDDfZVJP0fm
         1qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720031148; x=1720635948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap3DUN9BQkgBm8gM5zdnpaIUYWgH9LtzpwFPs3pRao8=;
        b=VVYn7RW4Vb4ShXBZGK5ucvBCHzGvx/Lj4Kf+tAQDp6h5c7TZ3hvhH/t33cQb0+rVf1
         N4454xv3dMLU+P2XX/Q1UkM2XJudJ52cBtPHvkPubfshe3PaY0W0YO7XyqC6r8MozGrY
         VCXZe03DUQU7qbKr4ofxo/NARKuhXK2rwVNR3yxZe82tpxLx9H5Gl7XInZ4jWdkdmTl5
         B2R3HcDH1qz6D+PGcUupTIk2jrO5IAJoatzYxMl1hR470ta+BGoWiqSDlOMEvOwXVgiZ
         ZslIQYdpv53xjtCikoPmmA4SDIfn3t3DGHpv/SjM9RahHM9dRH8uKBUSf8DTXfG7xeMo
         T+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo1BSdybdnf3pgyXVgxvbt9ot8l4QDI7SuRB739H01runS2AHSkAdS6tS4dcBRevSS8kIFKUuD7v6qI3yiWTNMA/T+VS+h+ky2A91iYng0VK71EoI5Vcupa/YYGYdvb6z0qLFCmXKu
X-Gm-Message-State: AOJu0YxitVl+Ioh7H/z3Z5us7UipyVQSw4FK8M2X950B13Gg2Nuv9uEG
	gqSdqwo7taHy92vjU5Z84K8T/jcU0Hp0gACx/RIMLJH0jS1nIgN1qnHdCpaL2Ow0HhkEU3wAsMP
	iUO+d4O/Qef4AJN0zCzeBJTPJLOY=
X-Google-Smtp-Source: AGHT+IFaeS9IRACwV0Q3FnYBDoON53crjFzHvfqSEuLXxX7b6OsJrtqVBjv3bX+dA08nzmcIyiyN+LvZOhP3ZY/2G+c=
X-Received: by 2002:a05:6a20:394b:b0:1be:c4bb:6f38 with SMTP id
 adf61e73a8af0-1c0bfed2d4fmr4061979637.16.1720031147837; Wed, 03 Jul 2024
 11:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-3-andrii@kernel.org>
 <20240703221525.dff79d6c71af3921ca7a7232@kernel.org>
In-Reply-To: <20240703221525.dff79d6c71af3921ca7a7232@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 11:25:35 -0700
Message-ID: <CAEf4BzY6k6tomV_Vf51MtmfvrzoNAH8APPuT4=UM3XTzf29P0w@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] uprobes: correct mmap_sem locking assumptions in uprobe_write_opcode()
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 6:15=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Mon,  1 Jul 2024 15:39:25 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > It seems like uprobe_write_opcode() doesn't require writer locked
> > mmap_sem, any lock (reader or writer) should be sufficient. This was
> > established in a discussion in [0] and looking through existing code
> > seems to confirm that there is no need for write-locked mmap_sem.
> >
> > Fix the comment to state this clearly.
> >
> >   [0] https://lore.kernel.org/linux-trace-kernel/20240625190748.GC14254=
@redhat.com/
> >
> > Fixes: 29dedee0e693 ("uprobes: Add mem_cgroup_charge_anon() into uprobe=
_write_opcode()")
>
> nit: why this has Fixes but [01/12] doesn't?
>
> Should I pick both to fixes branch?

I'd keep both of them in probes/for-next, tbh. They are not literally
fixing anything, just cleaning up comments. I can drop the Fixes tag
from this one, if you'd like.

>
> Thank you,
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 081821fd529a..f87049c08ee9 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, st=
ruct mm_struct *mm,
> >   * @vaddr: the virtual address to store the opcode.
> >   * @opcode: opcode to be written at @vaddr.
> >   *
> > - * Called with mm->mmap_lock held for write.
> > + * Called with mm->mmap_lock held for read or write.
> >   * Return 0 (success) or a negative errno.
> >   */
> >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct =
*mm,
> > --
> > 2.43.0
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

