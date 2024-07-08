Return-Path: <bpf+bounces-34124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF9892A956
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 20:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECE6282790
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D914B086;
	Mon,  8 Jul 2024 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBRBSqI7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D3143C47;
	Mon,  8 Jul 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464966; cv=none; b=GcLAo3/ilzS7FPBBBMFZioKj2M9cn1Pt92bAXR3+jyZCNvsioWK9DqjUHLMA0OCBvRSif2XcP4bPeiyaJI994pt4E0IEihBW3KrmlzutXqYgStXT3UNHYUYtEfwoqmJEONHcuu9sh5xwdCm89wj/2WsU2Aw4Ic1Pma+htM3oybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464966; c=relaxed/simple;
	bh=YBhwDk8+/hN+5WEzRNlXfwzDdZvi/xKGXK5EZzUR9sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkILDJSWxOfeQOWrAdhX5T1gKp7Cyys+TZg230ObMEMAE6+NCMSenxC+oOZAUaX9c4HU4+ZPUTaoxaoXVlR0SXA6YfyUr6KFTHrF0asgPYPzhm6Ws7vMZbmxPDhB9hoQG+v+FYckF1YxRI/0Sr3npgHeTdDeByYkeRJrprKz+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBRBSqI7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-75fe9e62048so2171907a12.0;
        Mon, 08 Jul 2024 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720464965; x=1721069765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLQr+BhZ7vYI0wjrn/T3ufkFu6pcWZl0xbw8E+/p0jQ=;
        b=QBRBSqI7MzpfOD4lMGRDbPFCHadytOtSxuxcha7Y5f11uyHKuSU2x4p9WGUi7oLGRX
         z0yEuRZ4RjyoikqEKxNfMfv1DRNNJs9NzPQ0+uR3xPJxRwtSfGAg59HQTmE/oZibPyZX
         5LFr/nTctf94x2HqrSFB/gsoEZpoueHUqMu/16nrGhsCQ4IflMxkEUD6GVtvctcObaRM
         lODlxVqmWKujDdFcvKhd5NXjBkXmGy0alg0rV+h81iuCO7rTRR6C3rOMrnhUpeU3V4Lu
         1ZW3JcQM2ZBqjAhRN7taevlt+9mT0XWD0mWF+S1ArQ9jC22MfNgezuDOqtVHq5SquXgx
         ZK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720464965; x=1721069765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLQr+BhZ7vYI0wjrn/T3ufkFu6pcWZl0xbw8E+/p0jQ=;
        b=PqO2ZU21Tu0CBUSiHhaixWvX9++IGVrGzKpNG7R13Be3hcSNvqSwflMHOdstVNRmz0
         Cg/Zfc5ImJB16T4N3tNkGXjueSrYBuX80lZHB+Uw14j4B7E5VsYmbCXhLWa5316CsmYv
         MQcm7tl0Jwm8uNDxKLR21oRURl9MBhUqhg7sV7L3VjSsyfSGx68F5qd6Z69u+NsQy+FT
         lT8gzRx1XKb4jH9ZBJMXmDNSinyS1hHrbYWeTf5ShH0d2m2uKdyztcd//IiNkNp204kQ
         dMzWSUJYya4Gq48yn49SIU32W2W0inWL33zD34Cb/NkCtn2BvahM46/zCJXYtxmWd8jH
         jRiA==
X-Forwarded-Encrypted: i=1; AJvYcCUN9H7Az9jNftB32mW+FY2embODtGDfBxlby3gni6HnyhMrY7EXwMuEMSGyeLmT6McQo3oe8GWCxTH5ttVagwsdgh44XqEJ0IyyMTk0kQ4SU/mPeduuYIBnfr/NkzeTrazW
X-Gm-Message-State: AOJu0YwPFVxns2u5MBtLwjA45UiLevzfUdnmkyRwruNT/4+/o31FQvyY
	+nLDOsN0yyHMY1soEWRLKTbGt9Ld4QIkBIlIz38Q+PR6rOJh4J3P
X-Google-Smtp-Source: AGHT+IH26Zo8WJAu4rCBLnw9sASpbiPTAVlg6hndnpS6v5JoxYckJeB+RIdcSE0Gno4/9LhfN8w69g==
X-Received: by 2002:a05:6a20:a112:b0:1c0:f2d9:a453 with SMTP id adf61e73a8af0-1c29820b87fmr362570637.8.1720464964791;
        Mon, 08 Jul 2024 11:56:04 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6d0dsm1944165ad.167.2024.07.08.11.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:56:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 08:56:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Simplify dl_prio()
 case handling in sched_fork()
Message-ID: <Zow2Qls3UF26u5Y1@slm.duckdns.org>
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
 <ZnSJ67xyroVUwIna@slm.duckdns.org>
 <20240624093426.GH31592@noisy.programming.kicks-ass.net>
 <ZnnUZp-_-igk1E3m@slm.duckdns.org>
 <ZnncZcJFbN86-b4Y@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnncZcJFbN86-b4Y@slm.duckdns.org>

On Mon, Jun 24, 2024 at 10:51:49AM -1000, Tejun Heo wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> sched_fork() returns with -EAGAIN if dl_prio(@p). a7a9fc549293 ("sched_ext:
> Add boilerplate for extensible scheduler class") added scx_pre_fork() call
> before it and then scx_cancel_fork() on the exit path. This is silly as the
> dl_prio() block can just be moved above the scx_pre_fork() call.
> 
> Move the dl_prio() block above the scx_pre_fork() call and remove the now
> unnecessary scx_cancel_fork() invocation.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: David Vernet <void@manifault.com>

Applying to sched_ext/for-6.11.

Thanks.

-- 
tejun

