Return-Path: <bpf+bounces-9616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DD579A081
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 00:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28ADA1C208EF
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 22:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885188BFD;
	Sun, 10 Sep 2023 22:01:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE148825
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 22:01:32 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A1E194
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 15:01:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68c576d35feso3658718b3a.2
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694383288; x=1694988088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EyybjuBSw2AsBAibBPVqGccWs6P0JtTeGBB0Kwx90Dw=;
        b=b1Q+Djrc6DRgK0lSMIXf6OVmm1S98Rb1dJdV/4AjeMobXYoqxa/k4Xb7XAYcmCuvbB
         T8pFPhiJHk/Ig8CcU4is+jZGfReesXQjqK7ULjc+VZz110Uqhy1NjrWTu4Ej2kgb1UEn
         ZHgnS7dDfuM0nrDuRkgBy+D/YOBtPecXxWCyUh6h/0/NlsJyyOwKHQwSKYYxfVY7xjkS
         7I+QxdaDiDVRMV8qekGuV48jZlbOlbc6skR8a29kp5hS8zsrhWfeCv9XIJ/gwMURSkPX
         Ncgzq9d3+KaDgvRq3XsvmeqBjcqt9Lc7ewxeY00IZtUnccPI4WIduUYqP2aDlo+H2VFl
         7yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694383288; x=1694988088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyybjuBSw2AsBAibBPVqGccWs6P0JtTeGBB0Kwx90Dw=;
        b=izCmBEQp1nfTKJZsMPbM/VJPLe0gbB0ncbELHV7nXrWtMJTcshmGd1Gt2YSVooZwDI
         CmPNM/PL6QWm6vUm1RmKDMNP1W1ct2BU512atrckHu2tuD4N+Jz237ToCSv4G8Yx4nIN
         lSaQ61n63wN+9bzW6ATobRREKvkAy+id6bU/VFYhwNRM7Awtsj04yK3cdxh37WTKlcPH
         v9yKX1CBFntJfSOMJ2HvblAJMHWHgEyUKuXLQslJZQ617UHJc1TnF5SCazCAJpAdoaBj
         XbdVB8CrMoIRskfKm5XWpjrVPhCTBgrQEJyDjcYdXajiwfu6fv4x41yEz3dx23vgwSZj
         yodQ==
X-Gm-Message-State: AOJu0YxhmRPpYp4HRNrmeq6GWG1dfFlorPr7ZG3d2tMZJNETGBrXD8xi
	lUWZ6hvCkRRMt4o0NHQPRG3Y/A==
X-Google-Smtp-Source: AGHT+IHSYFPf3w2qdTZr9bikkzuSsvPYQjYYZyW+Zfc616rQWXs3Eeo2BzwinmhhOfJVOtnHj1lBTA==
X-Received: by 2002:a05:6a00:1a0c:b0:68c:57c7:1eb0 with SMTP id g12-20020a056a001a0c00b0068c57c71eb0mr9371853pfv.11.1694383287795;
        Sun, 10 Sep 2023 15:01:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id u10-20020a62ed0a000000b0068a3dd6c1dasm4403641pfh.142.2023.09.10.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 15:01:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qfSUe-00DWBA-0u;
	Mon, 11 Sep 2023 08:01:24 +1000
Date: Mon, 11 Sep 2023 08:01:24 +1000
From: Dave Chinner <david@fromorbit.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Hao Xu <hao.xu@linux.dev>, Matthew Wilcox <willy@infradead.org>,
	io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-cachefs@redhat.com,
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, codalist@coda.cs.cmu.edu,
	linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
	linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
	devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
	Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCH 07/11] vfs: add nowait parameter for file_accessed()
Message-ID: <ZP48tAg2iS0UzKQf@dread.disaster.area>
References: <20230827132835.1373581-1-hao.xu@linux.dev>
 <20230827132835.1373581-8-hao.xu@linux.dev>
 <ZOvA5DJDZN0FRymp@casper.infradead.org>
 <c728bf3f-d9db-4865-8473-058b26c11c06@linux.dev>
 <ZO3cI+DkotHQo3md@casper.infradead.org>
 <642de4e6-801d-fcad-a7ce-bfc6dec3b6e5@linux.dev>
 <ZPUJHAKzxvXiEDYA@dread.disaster.area>
 <6489b8cb-7d54-1e29-f192-a3449ed87fa1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6489b8cb-7d54-1e29-f192-a3449ed87fa1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 08, 2023 at 01:29:55AM +0100, Pavel Begunkov wrote:
> On 9/3/23 23:30, Dave Chinner wrote:
> > On Wed, Aug 30, 2023 at 02:11:31PM +0800, Hao Xu wrote:
> > > On 8/29/23 19:53, Matthew Wilcox wrote:
> > > > On Tue, Aug 29, 2023 at 03:46:13PM +0800, Hao Xu wrote:
> > > > > On 8/28/23 05:32, Matthew Wilcox wrote:
> > > > > > On Sun, Aug 27, 2023 at 09:28:31PM +0800, Hao Xu wrote:
> > > > > > > From: Hao Xu <howeyxu@tencent.com>
> > > > > > > 
> > > > > > > Add a boolean parameter for file_accessed() to support nowait semantics.
> > > > > > > Currently it is true only with io_uring as its initial caller.
> > > > > > 
> > > > > > So why do we need to do this as part of this series?  Apparently it
> > > > > > hasn't caused any problems for filemap_read().
> > > > > > 
> > > > > 
> > > > > We need this parameter to indicate if nowait semantics should be enforced in
> > > > > touch_atime(), There are locks and maybe IOs in it.
> > > > 
> > > > That's not my point.  We currently call file_accessed() and
> > > > touch_atime() for nowait reads and nowait writes.  You haven't done
> > > > anything to fix those.
> > > > 
> > > > I suspect you can trim this patchset down significantly by avoiding
> > > > fixing the file_accessed() problem.  And then come back with a later
> > > > patchset that fixes it for all nowait i/o.  Or do a separate prep series
> > > 
> > > I'm ok to do that.
> > > 
> > > > first that fixes it for the existing nowait users, and then a second
> > > > series to do all the directory stuff.
> > > > 
> > > > I'd do the first thing.  Just ignore the problem.  Directory atime
> > > > updates cause I/O so rarely that you can afford to ignore it.  Almost
> > > > everyone uses relatime or nodiratime.
> > > 
> > > Hi Matthew,
> > > The previous discussion shows this does cause issues in real
> > > producations: https://lore.kernel.org/io-uring/2785f009-2ebb-028d-8250-d5f3a30510f0@gmail.com/#:~:text=fwiw%2C%20we%27ve%20just%20recently%20had%20similar%20problems%20with%20io_uring%20read/write
> > > 
> > 
> > Then separate it out into it's own patch set so we can have a
> > discussion on the merits of requiring using noatime, relatime or
> > lazytime for really latency sensitive IO applications. Changing code
> > is not always the right solution...
> 
> Separation sounds reasonable, but it can hardly be said that only
> latency sensitive apps would care about >1s nowait/async submission
> delays. Presumably, btrfs can improve on that, but it still looks
> like it's perfectly legit for filesystems do heavy stuff in
> timestamping like waiting for IO. Right?

Yes, it is, no-one is denying that. And some filesystems are worse
than others, but none of that means it has to be fixed so getdents
can be converted to NOWAIT semantics.

ie. this patchset is about the getdents NOWAIT machinery, and
fiddling around with timestamps has much, much wider scope than just
NOWAIT getdents machinery. We'll have this discussion about NOWAIT
timestamp updates when a RFC is proposed to address the wider
problem of how timestamp updates should behave in NOWAIT context.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

