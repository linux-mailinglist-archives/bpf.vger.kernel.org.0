Return-Path: <bpf+bounces-36235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D139D945112
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 18:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490AF1F23F9D
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46431B8EAD;
	Thu,  1 Aug 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmxNuipP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BE1B374E;
	Thu,  1 Aug 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530999; cv=none; b=FeIcmqmGacozJY9xUoBsAhhO2jKLEb43HbffWU7oKSfkYmAjdd6bFmCjRE2DdmevE805lsLwnIm0wkqR7YZj1TUxEt01hUrpptH1Xg85a5SDXE54UhUqMJEgghUc6rGVC030NAmCsdR5UrcE5c/HvYWv7i+sX0F6nef1BfUqfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530999; c=relaxed/simple;
	bh=VmN+ciVamVCWXPacA2OkyRwy8YfAcUdP/15DO2z/o8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gi/pmroRAwc/0TnqW+7vEsBZ3Hq6vA5il+cBpvfVNyWc0QyZR29Sh+FTq8/PNSqcptMmQxCyBuviG+0yOUy6FBRH7/u5LyGsVWRY6T01Uekxb9yFUQ/m+6JYIE43TvAoDMzIzNOwoB02xjUJpnPXgbeXrjhslzee70q2BmhYkmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmxNuipP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so4729709a91.1;
        Thu, 01 Aug 2024 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722530997; x=1723135797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QMaEFXeMcfeDQrT5wUNO+Khfx/T99W3/45SChk4z5A=;
        b=NmxNuipPdnZYpvibOilNE8TwIKn3Gf1SCmIk7vQuFIhY3IAqln1lUURy4iani3SN+t
         K2jFfuT9l8huKbLxP2ZDARV+QAhFS2LNfheHWoKaBLvCI+CpAVn9FpAX1jmYcmv9gihu
         B5c5V9t5E7hshsICwiL7VDAQ/Rgivj0m50RlE5NayWFXUqsoJtwisRKdaLcmOc6hEUX0
         N5lThC6Yv1H3Doks/ExaYjkrQB52bxpxxnw2KBcm0UjK9esQNIfZmWMuSdr/Nvruf6sO
         ih2TTYHFHZznbcawPVb5ZCQPOL7izk/+qihESS/8PuUEGa4X2FNsEzaMQjLu45EJYcyk
         thYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722530997; x=1723135797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QMaEFXeMcfeDQrT5wUNO+Khfx/T99W3/45SChk4z5A=;
        b=UzrrfZythxsZ5x2psDwpX1ct83UB85uZs+0YeQOlCNpX21kjh0wk4KHoyuw8BPdd06
         F4LzYjCUBb6nQfkpCI+7eGkHH0p9MaSEQIKVAmiPyq3yBR6OEwRXN997p7yiIWBhEu+z
         TuV5LeDo9b2sP8pY8PTX2VH+uZUmu2OdiNwtxkA1jJ8+vdwCIb53c4yMX67rzMIj/eUz
         gjsAd/RS/0OapcshgyRR6rrhi64CcGP6iq5Suao8QUXWc7O6i5SOFzP2rk7D/T2GwABV
         zK0AgpFIhIRxAr0jk2LQv6Gaiby7H7QKeLueu8f0//ivc9ml3mpefR4iMarvy+NB0lJ2
         EDDg==
X-Forwarded-Encrypted: i=1; AJvYcCWbEBYoXM0iN3swx+x0L8GLkIo3YSZ4NA9Qez2QhqufntMZCUT5ET4l8crvSR6UGbt906CdguCyFEioi++99jdUV77tbN5iWC5e1bV+g0UNokiiDiKdKhW7fDLqR1g18YjfzPfizRKTOWmOEZyY2Ht8cpxBWD5ipioLkhrFTgfxcA3yFo/+
X-Gm-Message-State: AOJu0YwaqCjYoh8nm7bUu2Mc+L7V1PIqm6zscJKjj5ZFJQBZsqBwnicv
	5181bhCSED7X23qbuv9iPF1CByUzivC+E76C4DB57K0ZKuNYEjZ0yE4740bE0R0m5oc9sJg5bMm
	OxO551JXeoM8U9fUuhcmwmtTOn7QNsA==
X-Google-Smtp-Source: AGHT+IFNbKLhV7ZEbhI8pR8HWXluJ205NsVykW9+ptDh5tUVdDZBjZfPUZVsfGdhn4wpJmM7UAqSZ5WMRVFdRc8Ujxg=
X-Received: by 2002:a17:90b:4ac7:b0:2ca:8684:401a with SMTP id
 98e67ed59e1d1-2cff952809fmr909331a91.32.1722530997117; Thu, 01 Aug 2024
 09:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-4-andrii@kernel.org>
 <5cf9866c-28bc-8654-07c2-269a95219ada@huawei.com>
In-Reply-To: <5cf9866c-28bc-8654-07c2-269a95219ada@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 Aug 2024 09:49:45 -0700
Message-ID: <CAEf4BzYzqw7zO1dBXSgh1sQoFtdg2sa5avOch8jJW=_iRJuquQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] uprobes: protected uprobe lifetime with SRCU
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 5:23=E2=80=AFAM Liao, Chang <liaochang1@huawei.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/8/1 5:42, Andrii Nakryiko =E5=86=99=E9=81=93:
> > To avoid unnecessarily taking a (brief) refcount on uprobe during
> > breakpoint handling in handle_swbp for entry uprobes, make find_uprobe(=
)
> > not take refcount, but protect the lifetime of a uprobe instance with
> > RCU. This improves scalability, as refcount gets quite expensive due to
> > cache line bouncing between multiple CPUs.
> >
> > Specifically, we utilize our own uprobe-specific SRCU instance for this
> > RCU protection. put_uprobe() will delay actual kfree() using call_srcu(=
).
> >
> > For now, uretprobe and single-stepping handling will still acquire
> > refcount as necessary. We'll address these issues in follow up patches
> > by making them use SRCU with timeout.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 93 ++++++++++++++++++++++++-----------------
> >  1 file changed, 55 insertions(+), 38 deletions(-)
> >

[...]

> >
> > @@ -2258,12 +2275,12 @@ static void handle_swbp(struct pt_regs *regs)
> >       if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
> >               goto out;
> >
> > -     if (!pre_ssout(uprobe, regs, bp_vaddr))
> > -             return;
> > +     if (pre_ssout(uprobe, regs, bp_vaddr))
> > +             goto out;
> >
>
> Regardless what pre_ssout() returns, it always reach the label 'out', so =
the
> if block is unnecessary.

yep, I know, but I felt like

if (something is wrong)
    goto out;

pattern was important to keep for each possible failing step for consistenc=
y.

so unless this is a big deal, I'd keep it as is, as in the future
there might be some other steps after pre_ssout() before returning, so
this is a bit more "composable"


>
>
> > -     /* arch_uprobe_skip_sstep() succeeded, or restart if can't single=
step */
> >  out:
> > -     put_uprobe(uprobe);
> > +     /* arch_uprobe_skip_sstep() succeeded, or restart if can't single=
step */
> > +     srcu_read_unlock(&uprobes_srcu, srcu_idx);
> >  }
> >
> >  /*
>
> --
> BR
> Liao, Chang

