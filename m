Return-Path: <bpf+bounces-62373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDEEAF8BCF
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 10:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DAB4A6B6E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE06289824;
	Fri,  4 Jul 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUnQgDer"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD028936B;
	Fri,  4 Jul 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617394; cv=none; b=XMupVOfdHkCMs7+z3mnsxs9qaRxOB7x4wq5y4MXOYilCEBip1aHIIslD1H+WZ2XoNIe+RHPhFOMQSgLUfDKiP2ExFY3mtN2+GvHReVsWdq8Lb1nMiRho/1vF+pYHjZxCJargo3Ym3k8XSzDXEcANfm/USL/Sh7K8lg/KK6c371Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617394; c=relaxed/simple;
	bh=MJSI7ivdMdGD+6cRfJB5zzWLZZW8Y6msLof6mcVxiX8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBulfccxp4acDtCsRBJKsSbSkRGfmuq+Gs2KAZivVyrX7wbcK24FFdYhpCxSj/oM0A2YhCOADwZwiY/3nGtHnnXMVuF79x913ezZKohGXtFcEFaI/eehCBj+AxpN4P1OdKk+ORvchRlF2akaEeueSXzWa8QHJ5ErngmA/pvw6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUnQgDer; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so1072127a12.2;
        Fri, 04 Jul 2025 01:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751617391; x=1752222191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aRQZfPqrxNYi05aXszkPTu2ttF+snrJL4n2DEDIxSw=;
        b=IUnQgDerXfCgBaoTCforD1el62tnldMa3DW8zGk/zvoVhrIQ+ASVDvmBiFtuLD4yC7
         F4FAaESCuj3M6WzTy61HBiJFKqVvKG6pKdToN0JjAMRoZnATHfWqBjwnWY9VcCsux0wm
         DFJBTZieBki9f6qYqComeGD+Cbg0TnM0l/YA70+OmJXMseXDf2ca7AJEkQDkjY2loboR
         7faOjNm3ISjrYnTmhIQghltxyNSJj7W+ldE0Qt+J+JlGMnlR9X7B/t60+hJgIWTt0lrj
         toqYDDIG66sjY0zH6n3gk2JgCFXAkFg1eFuxBApPEk+ZQr0DzSxF/xFJJyHel6IFY/r1
         Ns5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751617391; x=1752222191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aRQZfPqrxNYi05aXszkPTu2ttF+snrJL4n2DEDIxSw=;
        b=wHz+PZQyHiEJI03HeJBDmSuVcvrYQPOvDWcSrLaUu7OcdtUZxqhrOcv3ePIFI1XM7+
         64mWEbmSVGEQDKlAVbLYbja0DXqAFhMvDki2N3KFrZtD+SewVMTe5pCOmtD3wbhqQwA1
         gv27RCKUqRm5gDdaIJDYmgkTGvT6ySl2LOiepX5EqFOtwQndxD2Noc7ArbKyFm8gCqdZ
         9of3okk6SCVplnmPLOV4HkBcnjMtilEdBqh66QVCOqMOFkh5QYSfb3JKefsPlmvjQ0Bv
         IXMfpchNq+2/hhDeqCDk3RT/z/aHITQFg0Pm/R6CiLG1YQan2fRF3WchQd7Op0dNR//8
         RHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW22k6JEcLzNqrLHO7Zk4I9vqQX8wcwuALI4Luo6vJ2LC3VtOQuJFb4wwKY848fNL/YJMmd3BAI+liUhmtc1cdrjyPa@vger.kernel.org, AJvYcCWsu52zUZTFBk9B/LXogm2oC7aSHtMO2O1ZGB+Ix7a9M2SEyW+xhUuTP3CrsN1TQ9DnyVo=@vger.kernel.org, AJvYcCXDOJF3aPgNyk/pLmc9x98PfEx24Y0brHG2w+fd1UNwP86f1xC9xO7oxExZgB4b7uGlhvZ97eVbxutl/NCW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Gnzkm4Lv3DofVF4P7kpbU15lAUbzv3iuF3CZ9PC7yFNK4g+o
	wlLEjTiG9Ojf//5V5hzXklSlTMFUXK5c9LsyUxSdGHsd0PP4tLqdNG8L
X-Gm-Gg: ASbGncs8Nwg+IDLKMvkGhdAWROQ1R82foEy3ER5uY9lb55pk+T3Z7KE6KDOaHgjKt9i
	ljLZNA/s00e6/A7ZmhoeZRHVdUefwXOSOs+S5HPQYuHM1B7q3sI3Uh0UnqpbM5JdRjceM8eL4m1
	OP0sCkEPVi57OzdNL7fnhZv3kRCB7RmTmAWG2A2kMg5n39yvpI/H5tYFuUZ98HTbwY5MjaoJHO+
	Z6bgO/4SYAoEA1XyIYQoHHWOJPVp6E3kpnDxVJ0/r2hqfqF0UboXnA4AeH8IpWfxB2RVn7ZsaCI
	/lJjxBUxYv8oazx+MQXssIpGrYDLNNsKMKT0ktvDYvzMkeCjBKOx0IFFwSW2
X-Google-Smtp-Source: AGHT+IGEs6eDc0ZFDT+JKhFDraySpqOdRTr37B5P/2aZpGwd3tYIQpuLSMzAVTGY8OBQK0hNY6pGLw==
X-Received: by 2002:a17:906:f5aa:b0:ae3:de00:3a31 with SMTP id a640c23a62f3a-ae3fbd13713mr140313866b.30.1751617391014;
        Fri, 04 Jul 2025 01:23:11 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b5e6d2sm128943766b.154.2025.07.04.01.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 01:23:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 4 Jul 2025 10:23:08 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <aGePbMh3_yw2makD@krava>
References: <20250605132350.1488129-1-jolsa@kernel.org>
 <20250605132350.1488129-9-jolsa@kernel.org>
 <20250625172122.ad1e955ae2bc3957d9fb8546@kernel.org>
 <aFwS2EENyOFh7IbY@krava>
 <20250627150145.15cdec0f4991a99f997a8168@kernel.org>
 <aF6Q9NgCJx5p0MNJ@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF6Q9NgCJx5p0MNJ@krava>

On Fri, Jun 27, 2025 at 02:39:16PM +0200, Jiri Olsa wrote:
> On Fri, Jun 27, 2025 at 03:01:45PM +0900, Masami Hiramatsu wrote:
> 
> SNIP
> 
> > > > 
> > > > > +			return tramp;
> > > > > +	}
> > > > > +
> > > > > +	tramp = create_uprobe_trampoline(vaddr);
> > > > > +	if (!tramp)
> > > > > +		return NULL;
> > > > > +
> > > > > +	*new = true;
> > > > > +	hlist_add_head(&tramp->node, &state->head_tramps);
> > > > > +	return tramp;
> > > > > +}
> > > > > +
> > > > > +static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> > > > > +{
> > > > > +	hlist_del(&tramp->node);
> > > > > +	kfree(tramp);
> > > > 
> > > > Don't we need to unmap the tramp->vaddr?
> > > 
> > > that's tricky because we have no way to make sure the application is
> > > no longer executing the trampoline, it's described in the changelog
> > > of following patch:
> > > 
> > >     uprobes/x86: Add support to optimize uprobes
> > > 
> > >     ...
> > > 
> > >     We do not unmap and release uprobe trampoline when it's no longer needed,
> > >     because there's no easy way to make sure none of the threads is still
> > >     inside the trampoline. But we do not waste memory, because there's just
> > >     single page for all the uprobe trampoline mappings.
> > > 
> > 
> > I think we should put this as a code comment.
> 
> ok
> 
> > 
> > >     We do waste frame on page mapping for every 4GB by keeping the uprobe
> > >     trampoline page mapped, but that seems ok.
> > 
> > Hmm, this is not right with the current find_nearest_page(), because
> > it always finds a page from the farthest +2GB range until it is full.
> > Thus, in the worst case, if we hits uprobes with the order of
> > uprobe0 -> 1 -> 2 which is put as below;
> > 
> > 0x0abc0004  [uprobe2]
> > ...
> > 0x0abc2004  [uprobe1]
> > ...
> > 0x0abc4004  [uprobe0]
> > 
> > Then the trampoline pages can be allocated as below.
> > 
> > 0x8abc0000  [uprobe_tramp2]
> > [gap]
> > 0x8abc2000  [uprobe_tramp1]
> > [gap]
> > 0x8abc4000  [uprobe_tramp0]
> > 
> > Using true "find_nearest_page()", this will be mitigated. But not
> > allocated for "every 4GB". So I think we should drop that part
> > from the comment :)
> 
> I think you're right, it's better to start with nearest page,
> will change it in new version

I wonder we could actualy use page every 4GB (+-) code below seems to work, wdyt?

thanks,
jirka


---

+#define __4GB		 (1UL << 32)
+#define MASK_4GB	~(__4GB - 1)
+#define PAGE_COUNT(addr) ((addr & ~MASK_4GB) >> PAGE_SHIFT)
+
+static unsigned long find_nearest_page(unsigned long vaddr)
+{
+	struct vm_unmapped_area_info info = {
+		.length     = PAGE_SIZE,
+		.align_mask = ~PAGE_MASK,
+	};
+	unsigned long limit, low_limit = PAGE_SIZE, high_limit = TASK_SIZE;
+	unsigned long cross_4GB, low_4GB, high_4GB;
+	unsigned long low_tramp, high_tramp;
+	unsigned long call_end = vaddr + 5;
+
+	/*
+	 * The idea is to create a trampoline every 4GB, so we need to find
+	 * free page closest to the 4GB alignment. We find intersecting 4GB
+	 * alignment address and search up and down to find the closest free
+	 * page.
+	 */
+
+	low_4GB = call_end & MASK_4GB;
+	high_4GB = low_4GB + __4GB;
+
+	/* Restrict limits to be within (PAGE_SIZE,TASK_SIZE) boundaries. */
+	if (!check_add_overflow(call_end, INT_MIN, &limit))
+		low_limit = limit;
+	if (low_limit == PAGE_SIZE)
+		low_4GB = low_limit;
+
+	high_limit = call_end + INT_MAX;
+	if (high_limit > TASK_SIZE)
+		high_limit = high_4GB = TASK_SIZE;
+
+	/* Get 4GB alligned address that's within 2GB distance from call_end */
+	if (low_limit <= low_4GB)
+		cross_4GB = low_4GB;
+	else
+		cross_4GB = high_4GB;
+
+	/* Search up from intersecting 4GB alignment address. */
+	info.low_limit = cross_4GB;
+	info.high_limit = high_limit;
+	high_tramp = vm_unmapped_area(&info);
+
+	/* Search down from intersecting 4GB alignment address. */
+	info.low_limit = low_limit;
+	info.high_limit = cross_4GB;
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	low_tramp = vm_unmapped_area(&info);
+
+	if (IS_ERR_VALUE(high_tramp) && IS_ERR_VALUE(low_tramp))
+		return -ENOMEM;
+	if (IS_ERR_VALUE(high_tramp))
+		return low_tramp;
+	if (IS_ERR_VALUE(low_tramp))
+		return high_tramp;
+
+	/* Return address that's closest to the 4GB alignment address. */
+	if (cross_4GB - low_tramp < high_tramp - cross_4GB)
+		return low_tramp;
+	return high_tramp;
+}

