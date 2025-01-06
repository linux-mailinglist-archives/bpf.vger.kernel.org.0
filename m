Return-Path: <bpf+bounces-47991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3C6A02FC0
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 19:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0AF7A1B00
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116B1DE3CA;
	Mon,  6 Jan 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2sELTGS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388923597E;
	Mon,  6 Jan 2025 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188097; cv=none; b=IKi71zJfopRvv5M7Z3by+MFc2qc27PfJbhJ3cdqfL4dmywgyE+IC6CVgEOvTEr2uf1VQpqyW2k7oCeNKDW0XI4GwEtATDTg9JYwhvxIenQ/kPob31l0vT2hqzPgBH+PfTJ7swYflukJu+eV5FKWrRbHFFUUReVuTckmiciEYYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188097; c=relaxed/simple;
	bh=PLYppKAR9Vsz82j9ir6WJgFicNCIVx3C5iFKiJJOcuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8/S+iNryCVzLoiIyOG7HfUzd4Nhmz01DOnHO88y2c69uk7DVtBirqiHe3afg6ahzX5iRqrl8o5HD4m13l3Z2UrORQkvSA+3LJ/u6OgSgUbAaqHlxKYDzlaJrATVEgs35nvg16RKNOKusaM9vCqGxV21t5jrIkQFMSm0bAH1ePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2sELTGS; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e46ac799015so18045908276.0;
        Mon, 06 Jan 2025 10:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736188095; x=1736792895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=As/URpSAXT2ejTMt8LEuxKVlrJ2og5Cxcx8BJolaDe8=;
        b=O2sELTGSfey/IXw6ktViZJ7Wp15XRLLlgmpuc5ood6L27ZoGXP2fgMTC9+/Lb3wigd
         undOK0I53xcmcyiTHx6pNm2WelQCK+q+vmWkDPfmt3i5wZlQtS9So1oNsQocR7gxmpvL
         jYyzY0rZfH7ugx2qF6cEQC12et3ZHlFhtv+Z4VTutpL+6e5n9U1GhWN+oJaYM2WUgISu
         QuuJrjN6ebRk8JAivqgg1S1FIVnG1K1Y8DVyNUJB5c7zwfG3Shv+RbM8smrEaz8lQ74E
         EXP7cfpHKPtU7EyDb/i8qvEQCLdjNvd5TgjErt+BMeUt+TUPf6meGYSw4IZhXRZ91Jin
         f7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736188095; x=1736792895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=As/URpSAXT2ejTMt8LEuxKVlrJ2og5Cxcx8BJolaDe8=;
        b=hc9kgqkOsih0ic0LSIylZhwx2JHTFaSlkbe43+3q+4ljDbFNdifDk1TeIf/MAQ9X5X
         rjQhtQn6K8+YZA41U/hWIZmoh0R+WUZJyrhh6UE2myjAR8x41O+HRBlQz7cCTemJ8y8r
         NlQifmmJI+X8/v0qPG2RLS5/+ulYb+/8uZNOnW0QaRJ3R1ykxfLvKEaweNjoYYZZl5ZL
         EsJp0vzDULHICD3ljNQw/t+tCl3yC6SYn8I/vgo8VB6DAFj4CNoIQp2BD+6fYlzG8/2V
         UxKlvbeaDI7uj5gNRxfnkDRGRRPJJEuT2Jv35GQ+aGKkt8n6JZSYb17CroZNmHvXd9VT
         /v5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/wS3QbK0MvvL+/32Zy+ePSNA/geYLws+4RZkLBBk79NHyH0aw9yBqPO8c2i2UjroLj8uIAtgLrW8vxZo=@vger.kernel.org, AJvYcCXZLa0DjjIIlwwmtMzRYF4yjBUq22a+kf9MzHbgh4xTDScLi0raG8/FIKzyA3CzNJv4kRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/tf7Qq+fW14YsMjVXm5RsByWhBnWHj9knhA7sYhF45rHpuT1
	2SHOj+ZmIvh6ZNnG/jbEwk4ycy19szdR3JfEu9337HJKVKURJsISNomn6wt72rGbsClq7LSkpdg
	+FfoOlOgt4zqX3rS18gsWtVOeYnI=
X-Gm-Gg: ASbGncuG2T+IwAesH5AVfjSknqL5QadAh8uOqEvxAqOy6a1OD8Lw2J/eeENABHxxcaI
	y4x4LhVxtpPBBnNOSMTqM5X9gHirx+r/+VsS9g5kB
X-Google-Smtp-Source: AGHT+IHVzTtKwzkbKFSzXa7l07tGcQew3Dxqacu5wnrYGdfYfCLuolpWPcrhn7wb5mCcrbaglujhU+O1jf5NrLHWmFw=
X-Received: by 2002:a25:aad1:0:b0:e54:ab05:4505 with SMTP id
 3f1490d57ef6-e54ab054d62mr4665827276.44.1736188095031; Mon, 06 Jan 2025
 10:28:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com> <ee32c284-aeda-4efa-adb1-bb4af724d097@kernel.org>
In-Reply-To: <ee32c284-aeda-4efa-adb1-bb4af724d097@kernel.org>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Mon, 6 Jan 2025 23:58:02 +0530
Message-ID: <CAJHDoJax9dw3TjG9bNifOUP29_neTaNX-NNHkbxDfbytRocBzQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Song Liu <song@kernel.org>, hch@infradead.org, yanjun.zhu@linux.dev, 
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Thank you for the detailed explanation about write cache behavior and
data persistence.
I understand now that:

1. Without explicit flush commands, there's no reliable way to know
when data is actually persisted
2. The behavior we observed (3-7 minutes delay) is due to the device's
write cache policy
3. For guaranteed persistence, we need to either:
   - Use explicit flush commands (though this impacts performance)
   - Disable write cache (with significant performance impact)
   - Rely on filesystem-level journaling

We'll explore using filesystem sync operations for critical
consistency points while maintaining the write cache for general
operations.


On Mon, 6 Jan 2025 at 07:24, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 1/5/25 2:52 AM, Vishnu ks wrote:
> > Thank you all for your valuable feedback. I'd like to provide more
> > technical context about our implementation and the specific challenges
> > we're facing.
> >
> > System Architecture:
> > We've built a block-level continuous data protection system that:
> > 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
> > 2. Captures sector numbers (not data) of changed blocks in real-time
> > 3. Periodically syncs the actual data from these sectors based on
> > configurable RPO
> > 4. Layers these incremental changes on top of base snapshots
> >
> > Current Implementation:
> > - eBPF program attached to block_rq_complete tracks sector ranges from
> > bio requests
> > - Changed sector numbers are transmitted to a central dispatcher via websocket
> > - Dispatcher initiates periodic data sync (1-2 min intervals)
> > requesting data from tracked sectors
> > - Base snapshot + incremental changes provide point-in-time recovery capability
> >
> > @Christoph: Regarding stability concerns - we're not using tracepoints
> > for data integrity, but rather for change detection. The actual data
> > synchronization happens through standard block device reads.
> >
> > Technical Challenge:
> > The core issue we've identified is the gap between write completion
> > notification and data availability:
> > - block_rq_complete tracepoint triggers before data is actually
> > persisted to disk
>
> Then do a flush, or disable the write cache on the device (which can totally
> kill write performance depending on the device). Nothing new here. File systems
> have journaling for this reason (among others).
>
> > - Reading sectors immediately after block_rq_complete often returns stale data
>
> That is what POSIX mandates and also what most storage protocols specify (SCSI,
> ATA, NVMe): reading sectors that were just written give you back what you just
> wrote, regardless of the actual location of the data on the device (persisted
> to non volatile media or not).
>
> > - Observed delay between completion and actual disk persistence ranges
> > from 3-7 minutes
>
> That depends on how often/when/how the drive flushes its write cache, which you
> cannot know from the host. If you want to reduce this, explicitly flush the
> device write cache more often (execute blkdev_issue_flush() or similar).
>
> > - Data becomes immediately available only after unmount/sync/reboot
>
> ??
>
> You can read data that was written even without a sync/flush.
>
> > Proposed Enhancement:
> > We're looking for ways to:
> > 1. Detect when data is actually flushed to disk
>
> If you have the write cache enabled on the device, there is no device interface
> that notifies this. This simply does not exist. If you want to guarantee data
> persistence to non-volatile media on the device, issue a synchronize cache
> command (which blkdev_issue_flush() does), or sync your file system if you are
> using one. Or as mentioned already, disable the device write cache.
>
> > 2. Track the relationship between bio requests and cache flushes
>
> That is up to you to do that. File systems do so for sync()/fsync(). Note that
> data persistence guarantees are always for write requests that have already
> completed.
>
> > 3. Potentially add tracepoints around such operations
>
> As Christoph said, tracepoints are not a stable ABI. So relying on tracepoints
> for tracking data persistence is really not a good idea.
>
>
> --
> Damien Le Moal
> Western Digital Research

-- 
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

