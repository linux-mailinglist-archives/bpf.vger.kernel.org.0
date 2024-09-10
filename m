Return-Path: <bpf+bounces-39504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 996A09740D6
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 19:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2B21F219DC
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE41A38CA;
	Tue, 10 Sep 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1/WsbYn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23418EFCE;
	Tue, 10 Sep 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990007; cv=none; b=Rnz5T4KEHTO3/xUnF2BvhRIdonoouZOqWcVx9N8HVbEcpG3zyEqOuVWDtbzVlXKphEJbCSBSgaL66a+YHO/7im+WdxFIumcTrx2wvN3izqh9wskvz335vUi8t2jotBo3Hjcgw4GZ4jHunXMUTlpChYfogRKTMti+fg2T9V979qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990007; c=relaxed/simple;
	bh=fAdgRQqpGF7RrnEDWmOd1mWZuXS+ow/1DruDV+THMfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZKfIGDtFTM7RquHA0vD41GMIKFqdC9T5NsZpEVA5J9N9kxX/svxYLGG+kEBycaIKt7BNahyy6htKMH9ZOiu6bNaq29fsrc4y+LDzzJjMumax5IBehSVXHAlgkjelVeJl4B2MPYlgzqkEPDuEPMjkBbdnCp00kxIPyXXU8U6pD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1/WsbYn; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso788390a91.0;
        Tue, 10 Sep 2024 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725990006; x=1726594806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MGMSWaKWiTq5sp3rVspTPEpv9ZUFzlH0jxiAqGXIZA=;
        b=F1/WsbYnXVj7p+rR44oIzkynACN07XQWQl0xxZpGg+Zt70F2vDY+YrPOnieK7LR8sr
         aYLXZmlngqq1EayDFLqyC6mpYSPwDYfYw2+L9QmwkYm/FJrl3ONxZ8JIVuYRIzmykC6Y
         D1LY0t4NNYv0W0ysDk2KiZ+NASM0HneqqiJKbrGCDL7+FqLyZkp3ynlp0Ey+IJleDQMw
         zSyWs9VBXI7Hr1C86adIpaYYv+oqGpHRdmF+67Xca4UPjTxKZY5s7b+nE5babZaeXOdL
         82IrvC0DN2xjSD9nxExI8l0wpMj///FcPCkjPHGw1cYb5i1dGs2seP6rjbOFbOdxWgIV
         LfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990006; x=1726594806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MGMSWaKWiTq5sp3rVspTPEpv9ZUFzlH0jxiAqGXIZA=;
        b=Xi+guyFcoJqiCf1X9nJuU3uXJHoUCehZSZbJf020kY7+T/26kMVH2DHuCA/ff+4IJg
         36t+SxrjFhOY6pRp8hGbTM64Lfr5mta0F0YsDGTAf2kmE6TrisuuNTXkzlCQjCZpeL9D
         MCrf26FsyxHstdBpTKiqW5jIUrDq2L+5kgkZ+y83PXxVniMbTxtsVlHTO7ecznN6jOtP
         iBhMt7Ul1kPcH4KDLfTwtQQ9dxMeW8kO4QcAs8Y5/WclZmMBAst2389tT7wXir3JvWaG
         hajAubZrXv19rEJrXiDoIFuyyVVfq90OlegRaSy6Mpot6OfwHZZeC7TUBXntXVI9o5he
         MuMw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4A/KP8n+tD8ruogqNf0MOjZv6gJ9q3FrephD9a+FP1gpFoaTmTbGmreMLqe7JyIeacVW77ysXOQYPguT@vger.kernel.org, AJvYcCVAjK/CXJShrg/v4XPaC7PZVWSS4qqMIWERQ+WM1kkAf2wVxqK0cPt1ha4yqozaDqMEp2QDUZaIkOzCFmKXmcGtKQI=@vger.kernel.org, AJvYcCW/+cz1IzCDxyixCHHaPv3rLrXxlsI9jLUGwBNbUYonLwvD+IphfngiqiBETV5oCdv/0uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PYzcqt2cx5TyH9JhWfbIJN7lMe/UxqsOQY74UhnEyz3rfMlB
	8EQmhIPVdnPD857ksBoT8mK9OFf4qXvbaBS0XZf+sQVw0k+PJhfXT0uoBEADHRIIp6Nj+CX0xjd
	GHVXj3F8Pw/7WONwoqj73FUxxbKwUXg==
X-Google-Smtp-Source: AGHT+IFwC9/bCAtbu3BnylH0CaBZ+SRVRLEkQ5XJ/W+s4bXXcz8vdJqdDoPjvCD04EyRJE9iF2bP4Zao7wQxr2ZufXs=
X-Received: by 2002:a17:90a:66c6:b0:2d8:8252:f675 with SMTP id
 98e67ed59e1d1-2db83087f69mr355236a91.39.1725990005526; Tue, 10 Sep 2024
 10:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903174603.3554182-9-andrii@kernel.org> <172554860322.2215.10385397228202759078.tip-bot2@tip-bot2>
 <CAEf4BzbytuSpro9wT7cZY2Qf98zpDz+V0hTwwKP3ZDa866s1tA@mail.gmail.com> <ZuAhUHqAA-ejpN3X@gmail.com>
In-Reply-To: <ZuAhUHqAA-ejpN3X@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 10:39:53 -0700
Message-ID: <CAEf4BzZihPPiReE3anhrVOzjoZW5v4vFVouK_Arm8vJexCTT4g@mail.gmail.com>
Subject: Re: [tip: perf/core] uprobes: switch to RCU Tasks Trace flavor for
 better performance
To: Ingo Molnar <mingo@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-tip-commits@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 3:37=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Thu, Sep 5, 2024 at 8:03=E2=80=AFAM tip-bot2 for Andrii Nakryiko
> > <tip-bot2@linutronix.de> wrote:
> > >
> > > The following commit has been merged into the perf/core branch of tip=
:
> > >
> > > Commit-ID:     c4d4569c41f9cda745cfd1d8089ea3d3526bafe5
> > > Gitweb:        https://git.kernel.org/tip/c4d4569c41f9cda745cfd1d8089=
ea3d3526bafe5
> > > Author:        Andrii Nakryiko <andrii@kernel.org>
> > > AuthorDate:    Tue, 03 Sep 2024 10:46:03 -07:00
> > > Committer:     Peter Zijlstra <peterz@infradead.org>
> > > CommitterDate: Thu, 05 Sep 2024 16:56:15 +02:00
> > >
> >
> > Hm... This commit landed in perf/core, but is gone now (the rest of
> > patches is still there). Any idea what happened?
>
> Yeah, I'm getting this build failure:
>
>      kernel/events/uprobes.c:1158:9: error: implicit declaration of funct=
ion =E2=80=98synchronize_rcu_tasks_trace=E2=80=99; did you mean =E2=80=98sy=
nchronize_rcu_tasks=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>
> on x86-64 defconfig, when applied to today's perf/core.
>

I see, I need to add `select TASKS_TRACE_RCU` to UPROBES kconfig, I'll
fix it up and send this patch separately.

Next time please let me know ASAP about issues with my patches so I
can fix stuff like this quickly.

> Thanks,
>
>         Ingo

