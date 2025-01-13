Return-Path: <bpf+bounces-48707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD5A0BEE8
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 18:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7DB3A1380
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668521B6CE3;
	Mon, 13 Jan 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1bj167T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B5190692;
	Mon, 13 Jan 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789497; cv=none; b=dOQVcziUoU/NsnormfCGs1uemIZZHOH+Sx3L/CspMSAzLMVBQWenvqc2ug7EaCDh7uMP96oQLARLV+pPCXzUN9nfu3LYK5rC3Jw11Ku0ImqTUDvIc1JjbTFDX2NpHgeEFr5urBOfGHckdzIW6PklMtkp8tiameh78dI3uQm1Hjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789497; c=relaxed/simple;
	bh=W7U+X60WBv3j+Yw7DI10/ECvBYx1n4vUUezoN4EQtEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzU3i7HF2HCVDdwdJc6uMxG4+pRfR2kth3e3lEX6c+PKlndypeqZNpE21qODdt4VxgIZK1PY7bFDCpgNkX1UI/p/He7pSzJ7PrwhWSj/Q67epDbHl1bS5tG7tQ1ZB16oYS1N7Z39NrFIu/Qpl/+KcXhB6tH895+in4f4/A8JC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1bj167T; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so6930998276.1;
        Mon, 13 Jan 2025 09:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736789494; x=1737394294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpBtrDCior8O34MzUqT/yqPqqHhYm723171PHTvnTNk=;
        b=e1bj167TQ01lOyIvdp0zsDD5dCdhfLV9BBPj9BuC3NyDHIGh7Q4peX1a4/DLquq5Vf
         HjW2LBSTjkYpfTdgfoMSV4RtdBO/B8PWQonS081gqaDSeFGctjUB/jFx8bl+W5ef0bAM
         Mm7ITep5X1L+76gtxXLePqgJL5uo1bBPpZofHzPKYoyUIln/1Bowm5+iPdhA6jvF7qmg
         TvR9DLpmQKBnw3lDkFcC4hQShBCD0R4aaznpx1sGxfxZH7X+bqthkanzTspMBLA3whoZ
         GDFz38Bx5iYaf+gmd41t2oQRYqapwbhrZ4rTcKRQ/4RyE0z6/tRt35x/OZ7aZSI341Ht
         1LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736789494; x=1737394294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpBtrDCior8O34MzUqT/yqPqqHhYm723171PHTvnTNk=;
        b=rM19xV/ozeyfwMqk8VYK0ElkSeanOQzm0OqcRbk/W3JA2uE1/b+LxY/18kmMZrPkzb
         X5605fQG+eJ221NUDEmVmsTwUYGZH0rx+pOY1e/1618UARd6F7bzJDJYqBMBlp5hndbM
         ccVp7PY8kRQEEoQdK+suxMZzmpDonuYfQUysRFawIXmd14vF2cPEcrGECed8gDyJWJIs
         W4MP6UGCMB5AmLzNTqaU8t9FgWrdTCNHK53pB8FRiQIsdq5WeBmK1jit/vbwVP1CGX/O
         nNRcCQD6naq5UV+dovtoLQxwFjRgl1lA17C6wLCfgUjGk4AGfNqBR6vFB/xXBW9ravnT
         fNng==
X-Forwarded-Encrypted: i=1; AJvYcCWumvVYmU266uJOrN0Ox+HihhjrQh6W8v6WYZRXO98G2t8MWF/grrzQMWt43ihHSNdsvlk=@vger.kernel.org, AJvYcCXnffiecuFoQPCRna/EiZ3JZI/NWzlW1gM26/fsg20zUpfeIaRdkMcjQfRw2ibBX2OECbwY9abXz8Ga4z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzueyj0zt8aKfDDQODdBsfm09iMNNy75iDcRJ2Rf/SZMxnXe3jL
	ejVLpMmcY9lxpQqtozqSiLg6BS29JAcszwDnZffHkRFKVgxwVsZ4jls/Sd8YlQ5SuWAmnvc8F7F
	8h5+YKs9DpIwaMnDwtWf3ZHmPUwA=
X-Gm-Gg: ASbGncuZNPKOYw+VFz1F6rzKe/gxFtYn8ZIe5FQL32l+Ankcten6xwI8WMoyDM+KcKE
	PZgry4DCyzrFSiH4OP2nloiMvXiV2+8mNEEMJyBs=
X-Google-Smtp-Source: AGHT+IGIYqrqJhbpEwAM5/MQ91bcPCmKZWFG0YoEFTypIrbLLyMAsNZInZc1ueMG8J/fuioNF/gFOXOTG4k8lQAjtnk=
X-Received: by 2002:a05:6902:18d5:b0:e57:4a0d:4716 with SMTP id
 3f1490d57ef6-e574a0d488amr4980639276.38.1736789492541; Mon, 13 Jan 2025
 09:31:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com> <677c56994576b_f58f29445@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <677c56994576b_f58f29445@dwillia2-xfh.jf.intel.com.notmuch>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Mon, 13 Jan 2025 23:01:30 +0530
X-Gm-Features: AbW1kvY3SmWXc2HmqTHOHcCdiV_aRXeOTyMqdUtAYuxzDS2HNXhoSW9rgdWo-9g
Message-ID: <CAJHDoJZ5rFhgu-R_N6e82bqkY43S-sXKVs2khnnnZrqJH1vcHw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Dan Williams <dan.j.williams@intel.com>
Cc: Song Liu via Lsf-pc <lsf-pc@lists.linux-foundation.org>, hch@infradead.org, 
	yanjun.zhu@linux.dev, linux-block@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks everyone for the detailed technical feedback and clarifications
- they've been extremely valuable in understanding the fundamental
challenges and existing solutions.

I appreciate the points about md-cluster and DRBD's network RAID
capabilities. While these are robust solutions for network-based
replication, I'm particularly interested in the point-in-time recovery
capability for scenarios like ransomware recovery, where being able to
roll back to a specific point before encryption occurred would be
valuable.

Regarding blk_filter - I've been exploring it since it was mentioned,
and it indeed seems to be the right approach for what we're trying to
achieve. However, I've found that many of our current requirements can
actually be implemented using eBPF without additional kernel modules.
I plan to create a detailed demonstration video to share my findings
with this thread. Additionally, I'll be cleaning up and open-sourcing
our replicator utility implementation for community feedback.

I would very much like to attend the LSF/MM/BPF summit to discuss
these ideas in person and learn more about blk_filter and proper block
layer fundamentals. Would it be possible for someone to help me with
an invitation?

Thanks again to everyone who took the time to explain the intricacies
of write caching, sector tracking limitations, and data persistence
guarantees. This discussion has been incredibly educational.

Thanks and regards,
Vishnu KS

On Tue, 7 Jan 2025 at 03:48, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Song Liu via Lsf-pc wrote:
> > On Sat, Jan 4, 2025 at 9:52=E2=80=AFAM Vishnu ks <ksvishnu56@gmail.com>=
 wrote:
> > >
> > [...]
> > >
> > > @Song: Our approach fundamentally differs from md/raid in several way=
s:
> > >
> > > 1. Network-based vs Local:
> > >    - Our system operates over network, allowing replication across
> > > geographically distributed systems
> > >    - md/raid works only with locally attached storage devices
> >
> > md-cluster (https://docs.kernel.org/driver-api/md/md-cluster.html)
> > does support RAID in a cluster.
>
> Also,
>
> https://docs.kernel.org/admin-guide/blockdev/drbd/index.html

--=20
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

