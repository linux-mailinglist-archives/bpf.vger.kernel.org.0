Return-Path: <bpf+bounces-47993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D04CA02FCD
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 19:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D1D18857EE
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90141DED4C;
	Mon,  6 Jan 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a99Yghzr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA813775E;
	Mon,  6 Jan 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188590; cv=none; b=Ga6FtbgP8uFXMUoc8gREGbL54yLQrqq+JZsXU4AKY7eJV59gfmH66PxWfjWNrkWc5XOT2VjBc4WEU5FnYs63q/XABThneGzGb7PtnkIB5rbNunOnHEJ2+XCurkywfNyDPJ3U6jAHiPRZs3atWZHmq2MU4vmT7UwRg/8THXxE/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188590; c=relaxed/simple;
	bh=+9hUQ3YpUridodcP4SqCTVmkTe1+hPqGvwCRu8P3Aeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2dNrVfOZtTpMYcjLX4x7JySqQNRpfmI6USqWbwvtMVmps3NcUbaLYB5jew4oOtyD7i+MKzUzxOJGKupc8Aa2IXb20EejSJCmwLwjefwTqXld/1eE/LFShbjEBj3T9fu56LksfGb0XEf97FNPjEAkYrLdkkoynrAg9mE+wiY4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a99Yghzr; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso21888832276.3;
        Mon, 06 Jan 2025 10:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736188588; x=1736793388; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VN2w7YY7FSFUfE0QVBg0AB5tbb1kjnD60fsO9HYNczI=;
        b=a99YghzreetlEyYK9kcr7J8DSo4Qz3gtyecfibuPwxA+Uad3kLYYHEWUGAjjcDDs2w
         GptMU6T3DSfmwScLNR1JWVMiArNO3cm7+5GLO+fbFSpyLtLnQoQro8UvMEESAwwRo4B7
         Cbd2vCH2AOiiaZnKCXMWdTVfxBEfNAv2Nbh+Q2+C+3JbJAKCmWlG32ZgUyKbzGfS4RX/
         EWNEzEibTu5qBnGfCPfoPlA3oNFVf8Y5hpC264/knNTIG2Jsa+/4YKJ+8RgpNmEpYLGa
         Muc/MvnWQvP99fLEhrCcQ3qg0gvRJePhcI6CwL+WAl+f7z+eQD+HL6EszZBjNt4hcXhE
         js8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736188588; x=1736793388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VN2w7YY7FSFUfE0QVBg0AB5tbb1kjnD60fsO9HYNczI=;
        b=rJO+UiL4QM7hJqUGwrKen/ffMDlZ71BXdbmdk6gynGbQsUBnBTK5G8K+rMDQJpSTSD
         Y5cpS+5FtvcZyCZqYhsA8Pt5i7Cl5+C9Exc7sCh9DQ7nNxZ3QRCRXIwEm0IKR8ggQnXb
         K2+3tb37DsTWXximDUKPI4NNQT0zyTDSFdzJ+UTQej3g15WUZdlugrNTSFY748KUgfCM
         OasmtbbTgOkOCVGtf64npBXNKidv8oH6JUw50cOGpj75SuJe6hmr5SIC1LdlTbNv40oi
         RYupisLiI0k9CbBoT6sH4e43/3IMBOeU9FITr0zztinc5wGLWYUa5Wq/K3who+u4LdAi
         8+bw==
X-Forwarded-Encrypted: i=1; AJvYcCVbu6452NdpskBK/UorNz/kMBUrwlcAIxbe2RspxwsWXQWSG/rjnpnh76VV3GVDmi4CiRQ=@vger.kernel.org, AJvYcCXFlwZBwF9+mXgJOoWb685b7td2dXwi4zsNXKWCLn/XSfR9E0DrUsTC12czeOYGcnyxkmA2yx5xNpxe1Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUqOpNFAqhh77hDr4Zp8VEoL4SbvgCZdg9w4NwVDff4Q3Ba9h
	nto7+gkC0E/sn+KJZz9n7qVVDoj0rJFh06I3wpgZpvgARDkENyGvhXQl7s/Jr0IdoEjkBcSulXk
	MMSmFnKiqT/IWvxpC5PSBznhrG0M=
X-Gm-Gg: ASbGncsudwknIbrC46blWo9NoSD+u6rNkMTZYH/i4V4sRC5PJShfLR4sZCDYNIyxNts
	MhwCqpmMdr7SKrqammP5oVZnCrfhbqWNtq8f5sW61
X-Google-Smtp-Source: AGHT+IFWoEjaetOCXkyP5M8zxfOMZNipZ8dkUPXy0YYnoPeLo83JBMX14PaoDJCWB3aOTFkvuecUd63rv7lHPEs699w=
X-Received: by 2002:a05:6902:2290:b0:e4b:6380:f4c4 with SMTP id
 3f1490d57ef6-e538c259e83mr41698329276.15.1736188587937; Mon, 06 Jan 2025
 10:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <Z3uIOPxr4s09qS1X@infradead.org> <6c63dd3a-378d-471f-8af0-725edc3785ed@linux.dev>
In-Reply-To: <6c63dd3a-378d-471f-8af0-725edc3785ed@linux.dev>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Tue, 7 Jan 2025 00:06:16 +0530
Message-ID: <CAJHDoJYcqAHqtLVwC=P8Q=CmF1K==A_VA8oBuAc9hhnsUBz5xg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Thank you for the suggestion about fentry/fexit monitoring. However,
as Christoph pointed out, the fundamental issue isn't just about
performance or number of events - it's that the sector numbers
themselves can be modified by drivers during submission and I am not
sure if this is notified back to the kernel somehow.

On Mon, 6 Jan 2025 at 20:09, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>
> On 06.01.25 08:37, Christoph Hellwig wrote:
> > On Sat, Jan 04, 2025 at 11:22:40PM +0530, Vishnu ks wrote:
> >> 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
> >
> > You can't.  Drivers can and often do change the sector during submission
> > processing.
>
> If I get you correctly, you mean, the action that **drivers often change
> the sector during submission processing** will generate a lot of
> tracepoint events. Thus, this will make difference on the performance of
> the whole system.
>
> If yes, can we only monitor fentry/fexit of some_important_key_function
> to reduce the eBPF events? Thus this will not generate too many events
> then make difference on the performance.
>
> Zhu Yanjun
>
> >
> >> 2. Captures sector numbers (not data) of changed blocks in real-time
> >> 3. Periodically syncs the actual data from these sectors based on
> >> configurable RPO
> >> 4. Layers these incremental changes on top of base snapshots
> >
> > And all of that is broken.  If you are interested in this kind of
> > mechanism help upstreaming the blk-filter work, which has been
> > explicitly designed to support that.
> >
> > Before that you should really undestand how block devices and
> > file systems work, as the rest of the mail suggested a very dangerous
> > misunderstanding of the basic principles.
>


-- 
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

