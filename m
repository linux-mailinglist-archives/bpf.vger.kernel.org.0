Return-Path: <bpf+bounces-39073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C8B96E47E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F51828197C
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709BC1A726E;
	Thu,  5 Sep 2024 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9c3j/qX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFAA14F125;
	Thu,  5 Sep 2024 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569651; cv=none; b=kLMnAPuxgcZ/RUPfLdTJfvyIyXOItQ8WbEqV8xrPUuuwePyB5Wu2BY1Q90U+wKRWQAdPDSAvWlXQ1hamMz92XM92d2mVO2/suQxGP5fi7vkBFVLg+UPbQ+MxksUBTyD1HJ1Z9543d0VblLbq7Kc1/SI9k9HyuXbmODi+HUnduOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569651; c=relaxed/simple;
	bh=VtVcaTA8kr3xNL3ypmIYlIJ3WomRggFUtrSaomEP5wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdKRmpiMEWkcGQDDJI9RH22Cq7VmvLCi4SaZZlsR328nx5iiPYsLTtmy+NzlDEOgeobnIHh3K5ROnPtYtK+p4Xqy+Y3fanelByOFrY0HxpjJ4HBNCy7O1oklpwvnLJEBY+QUaEEhBx9PwpCUhUmNSit+fl7r0mT8iCZFtf+4Rns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9c3j/qX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d8a54f1250so924615a91.0;
        Thu, 05 Sep 2024 13:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725569649; x=1726174449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/vVqpOqdrwI/OeALxCbnulyGAi+e45HkWSWpudnHpg=;
        b=F9c3j/qXdvv0mT1jhhJ+4xNM5vSppNfos/sLXjKoxXox8ir5GAAE178CyzLiD4drCI
         sy+PzqZrvtg+mlPkHfedW4w9EnuD7RYC8Y6WcOb+cnPmYGD5hHqOqwZ8XNDUu7miu+zZ
         6BktRpp6SL40+xaguZoBSti8pdcWF5k4vFy4dW/g46tmU/jPYi8CtmRJYK/RFLpWTjNB
         SRYH1IbR44+HqejU+qwM4OZKb935uAlPWpvLFx3/RcSriRLqfGxBRB87QZsOcG0EET9E
         Coa9gtFguQ9cmpXe43HQ9QmH1i83EInqNo6SGXnr49c3Wz7C26Albs76dWpKChWRunuL
         ff6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725569649; x=1726174449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/vVqpOqdrwI/OeALxCbnulyGAi+e45HkWSWpudnHpg=;
        b=i8sDACoNsbsahyzSXDJy6ii8pfNshHJFb6A5DjFVjjRrBZJe8zPiVQ2E7GVUXgPVGy
         83l9bmVKOppePD81gS10NVlNd5pgKndEbBqOieYVbocFIU21RuoJ6oTZHrJ6MFhATJRS
         4fBN+Ky2lWugnurSt9eRZ9wPQZDb4sd3ExJ1fgffSDqYsbtmfW4iWZhjLV6KrPIp0Rcz
         vKH17ikc/v02azlAZ8IfDcYJmEL/l8JU8Qc9Q0TdzHPN6MQogfkNkDUfpzl4TUL3Zhzw
         l9eENh/NIx0rs+kXVKTOT9QXr41ULEcrbhZTQa9B3q6uEGAshs5t0lD292sYXLxq9+Od
         3YdA==
X-Forwarded-Encrypted: i=1; AJvYcCVtmnAkwDATrRbeRFEXoXIIy88t+in8uk5w9Bn5dDse1Kg9ishybJC+noZEkJQ0ua7ZShdGMBC76JfUrhJlBsOAms46@vger.kernel.org, AJvYcCW+WKM1cfucTD6DfhPqKEuh5LKf8lYo2aDv6Gbqd8ZzO1i1yBDyau59wU3qm84CCVzpHS7OAzsAFMmkfKsf@vger.kernel.org, AJvYcCX1PXSRqyytKZSaj+QC5LLdIicT0LjQLkEtH7QLQs98tj8tuEctCAyhlYCjM6vDgpfvsT5KwM05GII5QHJaMIJ2Aw==@vger.kernel.org, AJvYcCXGINPb/dAeHuI4+0+eBcO/9ackQtX5WPsaCTbv0CTj5ifUByZrjJ9fnBV6+qhrr2cS9Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkI1+xZh2flR9rz3f22iOkBUw0mSMrdOFmzFO5/280O1M97Gsm
	c8FTMEpgbvRtUbGI0Dpl6KIXuqTiOPtaNoa+0Q9I5xyqnAcC0ylSeCjCrW18RChJ6XEbWoso0Mw
	wD9EjyHEDdmFCuuqyG4lIDzHnam0=
X-Google-Smtp-Source: AGHT+IHOuBGq+ApkrAU0UbGfZKbR2eyqTNiruaFgO7adc5dpEztHv7s7Y4n/YPRGObOuuW2gmX2Yz+GWvEg1scR93j0=
X-Received: by 2002:a17:90b:4b06:b0:2c9:9658:d704 with SMTP id
 98e67ed59e1d1-2dad511280fmr554489a91.40.1725569649131; Thu, 05 Sep 2024
 13:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809061004.2112369-1-liaochang1@huawei.com>
 <20240809061004.2112369-2-liaochang1@huawei.com> <20240812120738.GC11656@redhat.com>
 <2971107e-75e7-8438-c858-b95202d7b5ea@huawei.com> <20240813124737.GA31977@redhat.com>
In-Reply-To: <20240813124737.GA31977@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Sep 2024 13:53:56 -0700
Message-ID: <CAEf4Bza9UYWv1uM38wBbvmGCEtcvOK3DeybQ9+QGwVf3QyTTyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] uprobes: Remove redundant spinlock in uprobe_deny_signal()
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Liao, Chang" <liaochang1@huawei.com>, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, andrii@kernel.org, 
	rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 5:47=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/13, Liao, Chang wrote:
> >
> >
> > Oleg, your explaination is more accurate. So I will reword the commit l=
og and
> > quote some of your note like this:
>
> Oh, please don't. I just tried to explain the history of this spin_lock(s=
iglock).
>
> >   Since we already have the lockless user of clear_thread_flag(TIF_SIGP=
ENDING).
> >   And for uprobe singlestep case, it doesn't break the rule of "the sta=
te of
> >   TIF_SIGPENDING of every thread is stable with sighand->siglock held".
>
> It obviously does break the rule above. Please keep your changelog as is.
>
> Oleg.
>

Liao,

Can you please rebase and resend your patches now that the first part
of my uprobe patches landed in perf/core? Seems like there is some
tiny merge conflict or something.

Thanks!

