Return-Path: <bpf+bounces-62565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC9EAFBDE7
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C743BB506
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7289728A1DC;
	Mon,  7 Jul 2025 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz1yy+7e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DFB16DEB3;
	Mon,  7 Jul 2025 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751925473; cv=none; b=pzu+Q6d5H/HJTS6xLLsLp/4QUsrHv1Le8GErPKHsfCobz6o3HJM2nHLdQNW76APwxLAKFq/GmzGCohAd7jeDlZdvNux/Mdk7LiSmCqzJVWOR9/giepr5/M89SoSqIKYDCZy4mFCFk3pDOAK1zEGq9CG/FtJ7mIpyJS3LrMesPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751925473; c=relaxed/simple;
	bh=wn4KLgMQi0FkygQy/dhVswDwIcW8jJc1HjU5vZfPamo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN/lSab2r+yU/U44KEAgCwa2FJzFdEp5K7Ai8FQ+qnWbxUBwsVAhP0xERDI1VPzGEMlgqBo8Cq47R4fMt29y2Zrra/6gRRiqDGigOIwvz6CaKKOcypHz7Bs5OFyfUgmOAGqXGauLSDWBy/DpgAhiEbLrguNsFSOVwg2c/w3dS1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz1yy+7e; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so18895595e9.2;
        Mon, 07 Jul 2025 14:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751925468; x=1752530268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmbxv3PdqFKnk2A9UCW4ls9PEGqEY+FhX8JmesHWPR8=;
        b=jz1yy+7el4Mr1r7g24xjbx1LmrwfAFnFvKzaYqjNWg9Nf1IoYT+kLpzU8xu6NYKGEK
         qslW2YIOrcdJBovhPlqXZJzCFvrqPM+joTMRNHBkjD2lqHjpNAA1APkOvyS2kpqL+rYw
         tsNIgoFV8GL1HhhzSXd2vjTvexz/JK961wCYuU5ng0pAbq+C5QV7Igo7/JwgB3AGGc7e
         kq4tVyI6ndfpXdu6xxPoTZpEXYalSYtdvIPcYcjoDaLTmCprs6XFPs62h3u9SiFOUf7M
         qRtxsWCuxYe+UzA9RWquS05082ndqKf568uIInC4GC73YdoKZNfaBcsuvLmC9wJuiFEX
         q0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751925468; x=1752530268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmbxv3PdqFKnk2A9UCW4ls9PEGqEY+FhX8JmesHWPR8=;
        b=XQoWAzagi65Xkg/PbECAZ3KhBZAdrYlo5nQ6nIwDaiAXKgS0h17Pe+cCfRcrQErT8X
         2qwiqRMuan59DZtY2q1Kua7Nz6vGp4IQ4kRkKEgCvEOPZB+tMtHYyne/zVLbpEZyNfVE
         y9/QcDsHn09F2k2K80HvPsaKBsI8xFZd9NB/X9Mh4V+TG3P3WhrJTODtr0Dy+gMQPFLd
         1n220Vbm1gFxHXU74B7ycjTF6pfV4QscNm1JH35mIgkIUR9S5khgLFmJbkr02m3plEb3
         NFmOT/H4bM6oCCLAU+urWDFgz6ag8wyHU+Y1hjbc+3mySAwixXwn/WJG9fAfa58roNh5
         sZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe7t9OTwiqeeZQiQY2L8kHExKS7Qv3nCfrGG8DTrdOwizdHl9wij3imqy8sDres/9HE6byfhzdMe1hPHoM@vger.kernel.org, AJvYcCWQFahxHjwOn4mA6i45XHRgVqpZh6nhH3e7B80beaqIHwUn1hLc7ZIBb71XPcYShg6zCwQ=@vger.kernel.org, AJvYcCWupgBuRYODU/NCfYG3z/0pYKr9fpcTEy9/y5FEbRnd//54LBDjonvs7WngzPxLnoGj+UzGHlVZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzCpVMQmF2wdQJ6Q3yrbXT2lVQULF6dyPKRVOLHjbqJVIt0ppDU
	sK9xK9BDGJuE0s1ebn5XTK9BaLcR1s3ysjJQYA2CqDHzU70c6WqnQTyx
X-Gm-Gg: ASbGncuqhVq35NRi2yPhav4UjBgnyiYPhSpcJWX7K08M1E3TEAtlQXmeIT/JxIT5JU0
	cIAwHwETFEdl+RqnK2uUOPpGajeFQQaRniImFbKl08wJnSsBHl5GhohSkeioGWYPcqbgOhzR5kN
	yddBItJuhsp4Gp7avOEkHCiDCJGxQyDK17BSlyZCW6DnRLBETGq8dwT2rRLmGLXnui1Dr9pWMnN
	W9YrPAd6GqMXuEoesjJSqeohvLdAyfWRZ87ZYcASa3res8BeM7mqBe8vnc/MLheu3UGXouUHnDB
	3F4Mw1/s+C2Rt71O9rHE5xts7OVwExKavxvw/a1D+hWfLSD2MUIBvp6k0ulqr41kJIsBSthhACV
	CuQHDIMax8Soot5XGtMoC3IIkKtV5hNv3iKCZ6A3N3ilcXKvBYV7Lg/gEKbvlxodPlVbxoU0=
X-Google-Smtp-Source: AGHT+IEhIg4l6YStNvu65lWOa+vurZo381w6ywFHfdsoVupncE1hKIfHVv61bQAlipenXd9yoVNn3Q==
X-Received: by 2002:a05:600c:a20f:b0:453:c39:d0c2 with SMTP id 5b1f17b1804b1-454cdab07cemr604855e9.24.1751925468311;
        Mon, 07 Jul 2025 14:57:48 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f536999e2663c8dd.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f536:999e:2663:c8dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd4943bdsm3303855e9.20.2025.07.07.14.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 14:57:47 -0700 (PDT)
Date: Mon, 7 Jul 2025 23:57:45 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
Message-ID: <aGxC2aVjAm4m7oTU@mail.gmail.com>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
 <aGa3iOI1IgGuPDYV@Tunnel>
 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
 <aGgL_g3wA2w3yRrG@mail.gmail.com>
 <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>

On Fri, Jul 04, 2025 at 10:26:14AM -0700, Eduard Zingerman wrote:
> On Fri, 2025-07-04 at 19:14 +0200, Paul Chaignon wrote:
> > On Thu, Jul 03, 2025 at 11:54:27AM -0700, Eduard Zingerman wrote:
> > > On Thu, 2025-07-03 at 19:02 +0200, Paul Chaignon wrote:
> > > > The number of times syzkaller is currently hitting this (180 in 1.5
> > > > days) suggests there are many different ways to reproduce.
> > > 
> > > It is a bit inconvenient to read syzbot BPF reports at the moment,
> > > because it us hard to figure out how the program looks like.
> > > Do you happen to know how complicated would it be to modify syzbot
> > > output to:
> > > - produce a comment with BPF program
> > > - generating reproducer with a flag, allowing to print level 2
> > >   verifier log
> > > ?
> > 
> > I have the same thought sometimes. Right now, I add verifier logs to a
> > syz or C reproducer to see the program. Producing the BPF program in a
> > comment would likely be tricky as we'd need to maintain a disassembler
> > in syzkaller.
> 
> So, it operates on raw bytes, not on logical instructions?

Both I would say. The syzkaller descriptions for BPF are structured
around instructions [1], though they may not always match 1:1 with
upstream instructions. Syzkaller then mutates raw bytes, taking some
information from the descriptions into account (ex. known flag values).

1 - https://github.com/google/syzkaller/blob/master/sys/linux/bpf_prog.txt

