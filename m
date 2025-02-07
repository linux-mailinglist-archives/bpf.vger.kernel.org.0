Return-Path: <bpf+bounces-50756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7549A2C166
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 12:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44D57A389D
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60C1DE4D8;
	Fri,  7 Feb 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUmUbQcv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6163D;
	Fri,  7 Feb 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926973; cv=none; b=hQk/pO9kKSNZGuU+QQSyMzseh9ESH10CejR33cMh1XcxiJROxEiO+IWOeKsIfNVtBQPiyCs9FjP056+7UOVqkp51+ZzzizA2dHDBlwKJ+lR/PNdaETdGctEbMw9aNRWJXKtWWZpv6TDyuHLbqgR8VZvruguiIP2TyuU8GcxPDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926973; c=relaxed/simple;
	bh=lELPM0gFKqIpB6TQGOsF4JiNvRvpg+B2tbFqtHlFImM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3TiUUULI1X2lppwvxR56xUXw0l8m/BH6AW7B73DdH70FC39AaIB1FcxE0p4l0Kt+6qzGDfPCLJhUhM+nYOZ7CwPiXdZse/yshbpe/syBg5sz7CcSwCrJdo0SVDAxV+Spvp3NniK0zZHGlVA3QvT0MMbq7T4vEWuViDwM2YNeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUmUbQcv; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f6ca3e8cdbso14234487b3.3;
        Fri, 07 Feb 2025 03:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738926971; x=1739531771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lELPM0gFKqIpB6TQGOsF4JiNvRvpg+B2tbFqtHlFImM=;
        b=KUmUbQcvg/grOqta5ghglC2YstsSIKDYmtxvH+RbuQKcuNaVOP6tL0OEjothmv/aHn
         ki5fYSqStaA4WDeGzb+z88CmJt4YlmKhIZ97r+xH1qORP4mi2ETAvRoKnKNd4u2XoYWb
         zAm6pIGYqdMMMInXDZYLLTUnn455kyzP/TzbDYvQUpMcuBga+1emxNlxM/0XQPmOQEF7
         yhv/LxC8Gt25vkzjY0+FVkdbI7CcPRYvdXtFe56nC4sYsn/O3fxkVA3mwrp993Citbwo
         ZXR20J4ikSItrEIK4ExhGkT7T8cd55SxcYZ/HCXdh24svYrTu45PncTNsxyhK6O6CmSJ
         Au7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738926971; x=1739531771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lELPM0gFKqIpB6TQGOsF4JiNvRvpg+B2tbFqtHlFImM=;
        b=Ml2b25xZJqJbj76GJw6fsnmc477EtH76qea2g8t9mpqZambwrCqULvYNPREiawdjBY
         FYs93r6K2PgkBOr/8YwoS4h34O75v+sXnSe/nZL8unt4wz9h5qcIME62zJVB1dHTnxGM
         4/0I9vSLtplxPvu/Rk+DcHvre17oH8EqmnpJtsUxMRcksDschDZ7g3m3dUa6BRWKs0A5
         eXw2TcHH8AKz7Rm+2V76oJG94y/dfnZyZG55aazlil5YU1S9tYh2RZMSKwyOex260NDQ
         QaYVvtzzSHG5KpXXYqNSPQcYna+wOCd8DbsKj7c9Ga/3fMc5vxGccIqWgVl5qTUVCZYY
         4hdw==
X-Forwarded-Encrypted: i=1; AJvYcCW0DHr6Jvh0ooq9aReQnLbIvBkeBIwvhwWvgtQ9Rg5RfsiNZQcCNwWXasdwkMxWUVh67Lo=@vger.kernel.org, AJvYcCXrqBV0m76D2TVIs3ZCbtt0ql5LwPN12K+zuJ1I/czx+HChdorRFuJU7jo3JP3FoJywW7zdFzNCQnXsFtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxh4DnjGV8OQTh9U3lHSz8CUiyIIzNGWYF3BpdDUikcQsosFDG
	aOJL/fhXPZl0U1OjbDS5eDkf0+gu00h3BBa7q3tKkn9rd0CsM+NKS2gODa5KT/C3LQQ4LgXolyb
	sOtB1sCXcUNranFBTtnpS8DnIIro=
X-Gm-Gg: ASbGncvdVNTDOZbDPwKFZJGJJ5OucXIuOuN1gFfvxnz9YpV4doZHHYbldI4hoIMYhb+
	+Xjz6bizoVH5KMpZuFRax/6+JPUY5grhrvi2bWaKhmYJvpvf2ypfrw/DI3TmEV6wiV05fz0M3EP
	0=
X-Google-Smtp-Source: AGHT+IFFVSHnPt+eL5wAiG6E+J60NEM+2l3Y5dSqvOtEam+TtljaI/VuuJrH8GhWVebw58UUdhZPJ1qQFPNm2Mx4w64=
X-Received: by 2002:a05:690c:6890:b0:6f0:23da:49a3 with SMTP id
 00721157ae682-6f9b2802330mr22270597b3.8.1738926970909; Fri, 07 Feb 2025
 03:16:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com>
 <677c56994576b_f58f29445@dwillia2-xfh.jf.intel.com.notmuch>
 <CAJHDoJZ5rFhgu-R_N6e82bqkY43S-sXKVs2khnnnZrqJH1vcHw@mail.gmail.com> <Z6Vqlo3s3sK6d0ng@fedora>
In-Reply-To: <Z6Vqlo3s3sK6d0ng@fedora>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Fri, 7 Feb 2025 16:45:59 +0530
X-Gm-Features: AWEUYZkRQC9nK96x4IHETx4pwTTJEBBjwQxJocZ-yPlBoO60Z-qgsBSnuBIAuvQ
Message-ID: <CAJHDoJaaO8eG5pJLLZkL2iEywVkccUdgN1eRatuvJw6JHCqLug@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Ming Lei <ming.lei@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Song Liu via Lsf-pc <lsf-pc@lists.linux-foundation.org>, hch@infradead.org, yanjun.zhu@linux.dev, 
	linux-block@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Thanks Ming for the insightful suggestion about struct_ops pairs for
bio handling. Moving these operations to eBPF aligns perfectly with
the goal of keeping non-essential business logic outside the kernel.

As mentioned previously, I've open-sourced our implementation (blxrep)
which demonstrates this approach. While simple in implementation, it's
proven effective for capturing incremental changes on data disks with
sync frequencies above 3 minutes:

BPF implementation:
https://github.com/xmigrate/blxrep/blob/main/bpf/trace-blocks.c
Documentation: https://blxrep.xmigrate.cloud/

Your suggestion about generic bio/bvec kfuncs is particularly
interesting. Would you be open to providing feedback on our current
BPF program structure, particularly regarding how we could better
leverage these proposed bio handling capabilities? I would also like
to hear what others think about this approach.

Thanks,
Vishnu KS

On Fri, 7 Feb 2025 at 07:36, Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Jan 13, 2025 at 11:01:30PM +0530, Vishnu ks wrote:
> > Thanks everyone for the detailed technical feedback and clarifications
> > - they've been extremely valuable in understanding the fundamental
> > challenges and existing solutions.
> >
> > I appreciate the points about md-cluster and DRBD's network RAID
> > capabilities. While these are robust solutions for network-based
> > replication, I'm particularly interested in the point-in-time recovery
> > capability for scenarios like ransomware recovery, where being able to
> > roll back to a specific point before encryption occurred would be
> > valuable.
> >
> > Regarding blk_filter - I've been exploring it since it was mentioned,
> > and it indeed seems to be the right approach for what we're trying to
> > achieve. However, I've found that many of our current requirements can
> > actually be implemented using eBPF without additional kernel modules.
> > I plan to create a detailed demonstration video to share my findings
> > with this thread. Additionally, I'll be cleaning up and open-sourcing
> > our replicator utility implementation for community feedback.
> >
> > I would very much like to attend the LSF/MM/BPF summit to discuss
> > these ideas in person and learn more about blk_filter and proper block
> > layer fundamentals. Would it be possible for someone to help me with
> > an invitation?
>
> If one pair of bpf struct_ops are added for attaching to submit_bio()
> and ->bi_end_io() in bio_endio(), lots of cases can be covered:
>
> - blk filter
>
> - bio interposer
>
> - blk-snap
>
> - easier IO trace
>
> ...
>
> Then both bio and request based devices can be covered.
>
> It shouldn't be hard to figure out generic bio/bvec kfuncs for helping block IO
> bpf prog to do more valuable things & fun.
>
> Thanks,
> Ming
>


--
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

