Return-Path: <bpf+bounces-47992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CCBA02FC6
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FA51885DA2
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA621DF97F;
	Mon,  6 Jan 2025 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQOU365r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A21DF725;
	Mon,  6 Jan 2025 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188313; cv=none; b=RY5aQszWmQyo7PucJj/l711Ns99BBM1xjgEf8PI0rt36GVLVjqLfhmx3xLd5IXQf8P/s8cU/qZSo04dLnnIfiJq4ImXgLzWdoE1x3MaFQDCrQLkdeWVPNo0pF87swGCe/fN5pdQz9aiqjAboG7ht79GosqSM1q/tYNbmCBkN108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188313; c=relaxed/simple;
	bh=9HZzPJWHTk5YAskikcZokYIOER25V29feEjHy2JNJ7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SelH046RLpRzrERiNTkPm7LNiHkeTBb57I5/RrJzFxQgKkmvFLwf8zgpZ53MZ7Nv26TmwCtS98MZPi0+uAQ8GXruk0oCKWmZfCF9WDtf8Y/hknskAPN69FC3CdtWmSsArB8XZG5dQV3Ng5q3V8TDph2uOrxEdgO/AhSocLTYXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQOU365r; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e399e904940so17521201276.2;
        Mon, 06 Jan 2025 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736188311; x=1736793111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4UtI+O2C+ipmEMNnb8ze2GlLUjDCgToFX00Vv4aTUQ=;
        b=mQOU365r2/7UYmPEyLkugAvbthZJMXN77poYfc3LLi3KZA0o+lUVqaoJm0M354njsh
         dftg5WbZ+McmvRCk4BJa9JLu4IyI4ugTSDDf1kZSvak+6I2tf6CofUtNWkEFI0o97UyS
         fJWZmphupiAhS+Y90WWCEQDQHf6Ot7RKWW/ZvGWVjT1KXud2un/e2DXvTxFxkfRAsw7c
         OrtPnUYEbyFB+OhPfmOauZtTCUrqiw9dLe2x66JbJ+VEnptCfFtvxKoNOnLwKuGZbT9O
         NtLmXjuV72wBhWHjPKaEKUY9u8RQEoAjIBLi+Yw+1+r/8FXlsfmv6sQkuMF3AzPVsSjM
         DvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736188311; x=1736793111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4UtI+O2C+ipmEMNnb8ze2GlLUjDCgToFX00Vv4aTUQ=;
        b=orsR5qKKf8djyqCHPzYaiEn26BW6ohRRkJAqxuAH217u8rH+n8RyyLMhTSFy+PFlxL
         00GCxzu2DUvxp9cmf4aVVF5XlSXZb8ifJ5OUx6vXGFVXFpe0y0CxoB0tVvuZQTIb/4lM
         41oC3vWvHIddQ43IwtPTN6vWXjuE7pxrYLO3wj355ragkkMx+k5jTOkfSS7f6Wxmj9k0
         LHRCqqydMJzlAyju/2hTZkPQ48Z/+NGAITXMVcGu0Xl8/ALbDjwbw2Ro+F5SN2eA5Rnj
         q6PBS/XU632yc7F6ECsyTIKBuQhqgYKuHcDo5YpAU9mip1e3Jq+T1zXxqyF1BzObmZ5+
         ZAQA==
X-Forwarded-Encrypted: i=1; AJvYcCVYX2o7FkIA7dItWgk8soU358xeL8neYgcv7Wxqshx1vC3txTvy8iH5H2mrkKzS86STmM1j1WOo077xNuM=@vger.kernel.org, AJvYcCX1EWBPl/6rzAK7qLCu9zbdjDPtWuZigMrJzUOd6ohbrn2annmQv5tLX2zEkTW5gDYOang=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8JQ327mk+DgsM3Yt4uZFBRpyE+83Ss93SLKLe5MTjm2JL/XS
	ZiVVdGobWe6/NuZXhb0ZvmF+jrNwZsoqfiludFDkCCsv24BYL3NTxgPgj9Jr2nnta4QSI2J+fGJ
	4Ic9VK2O+czdPM7YJlUxZOyKfYn4=
X-Gm-Gg: ASbGncvKOUOjitzboo2vgyji8PghkRJhyUtHKAxsf8jz1WWCux997T6UpdYzQHaEkxm
	0CV2AmtUz3A96w2MKiMgAy48sgfNeh50/hjgcGhS+
X-Google-Smtp-Source: AGHT+IGdL3AYLUBSEON5gNiuIQ+2Prh9q/GSoTmC9qNYgbc363YVs89zzoKH878KkRuBJlsOIvE1B5C9fAT/BmzCEc8=
X-Received: by 2002:a05:690c:60c1:b0:6ef:6f24:d093 with SMTP id
 00721157ae682-6f3f80e42e9mr477565047b3.6.1736188310767; Mon, 06 Jan 2025
 10:31:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com> <Z3uIOPxr4s09qS1X@infradead.org>
In-Reply-To: <Z3uIOPxr4s09qS1X@infradead.org>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Tue, 7 Jan 2025 00:01:39 +0530
Message-ID: <CAJHDoJbvdEajX_hkuF4GqCULjSERZzMgc3FsMf4qmO_TrdNz8Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Christoph Hellwig <hch@infradead.org>
Cc: Song Liu <song@kernel.org>, yanjun.zhu@linux.dev, 
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Thank you for pointing out these critical issues:

1. The sector tracking approach is fundamentally flawed because
drivers can modify sectors during submission
2. I'll look into the blk-filter work as it seems to be designed
specifically for this use case

Could you point me to resources about the blk-filter work? I'd like to
understand it better and potentially contribute to its upstream
efforts.

You're right that I need a better understanding of block devices and
filesystem fundamentals. Could you recommend any specific
documentation or reading materials on these topics?

On Mon, 6 Jan 2025 at 13:07, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Jan 04, 2025 at 11:22:40PM +0530, Vishnu ks wrote:
> > 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
>
> You can't.  Drivers can and often do change the sector during submission
> processing.
>
> > 2. Captures sector numbers (not data) of changed blocks in real-time
> > 3. Periodically syncs the actual data from these sectors based on
> > configurable RPO
> > 4. Layers these incremental changes on top of base snapshots
>
> And all of that is broken.  If you are interested in this kind of
> mechanism help upstreaming the blk-filter work, which has been
> explicitly designed to support that.
>
> Before that you should really undestand how block devices and
> file systems work, as the rest of the mail suggested a very dangerous
> misunderstanding of the basic principles.

-- 
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

