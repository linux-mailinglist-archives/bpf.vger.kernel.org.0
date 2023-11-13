Return-Path: <bpf+bounces-15010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180547EA430
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 21:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445FB1C209ED
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880FD241E8;
	Mon, 13 Nov 2023 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRvW+FFd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7C2376E
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41752C433C8;
	Mon, 13 Nov 2023 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699905784;
	bh=W3EUlewgeAFasfE0qi6pZogVjp5Srq3AZgCSS6ODCy0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YRvW+FFdYQE+IlSAvv7bEALUvGig02+6TgvVDecqcKZTK/9asEec34/kxhLYl9OP4
	 CUjPEXmTO4om8c/A+lcukkq2tmIhfd31b7WKOKqWaxcxDU+V3ihmGnxXyRGqVCgUKE
	 KPUVbX2Nd1H4TmiNALsOEHp2kfehevh413H/AVtylQ2rv2WMIjCtoXB4auvL47AQA2
	 7VBw4P5UmT6sA5Zua1ESU518fbPFWMPUbXdR9hzp5q8j/UoVD7UHbBvFKqEKY7SlWu
	 jg1LZcJrzYgS7vbcsChIYfUdpPgoRiwPS+PTNEu+X+Oq1EbcfzYarHPm9ENXlPwYj+
	 1R7TJQccyLBeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D6714CE1BDA; Mon, 13 Nov 2023 12:03:02 -0800 (PST)
Date: Mon, 13 Nov 2023 12:03:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Barret Rhoden <brho@google.com>
Cc: Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
	davemarchevsky@meta.com, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Neel Natu <neelnatu@google.com>,
	Jack Humphries <jhumphri@google.com>, bpf@vger.kernel.org,
	ast@kernel.org
Subject: Re: BPF memory model
Message-ID: <ce0b986c-78e4-4253-a1db-5a710b95553f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
 <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
 <5c3b16c8-63e6-4f80-8fa2-6bacb38cdcb6@google.com>
 <e5c6b7f7-3776-4c2e-9896-fe44e735c1d1@paulmck-laptop>
 <22da941e-384a-4f02-80c4-8b84c0073f8d@google.com>
 <5b23c67b-8b15-4d54-8f38-c201a6842b20@paulmck-laptop>
 <a7ff8638-84b2-467f-89fa-63916a082d09@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ff8638-84b2-467f-89fa-63916a082d09@google.com>

On Mon, Nov 13, 2023 at 01:53:17PM -0500, Barret Rhoden wrote:
> On 10/16/23 12:48, Paul E. McKenney wrote:
> > Hopefully better late than never, here is a draft:
> > 
> > https://docs.google.com/document/d/1TaSEfWfLnRUi5KqkavUQyL2tThJXYWHS15qcbxIsFb0/edit?usp=sharing
> > 
> > Please do feel free to add relevant comments.
> > 
> > 							Thanx, Paul
> 
> thanks for putting this together, and great LPC talk today!

Glad you liked it, and thank you!

							Thanx, Paul

