Return-Path: <bpf+bounces-12313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41867CB025
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BD61C209DD
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0303330D00;
	Mon, 16 Oct 2023 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmZP/kgt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CA286AF
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 16:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB6DC433CA;
	Mon, 16 Oct 2023 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697474901;
	bh=Du5olcr2HsZbkAiknYLGEU8DD2R2iqZnIhhmZjezp48=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qmZP/kgt4AP6k3C3Zf2o9jsUXUypxeMXela0c9NqnRk6YRRhO7AdtjtSiCeAQZLEb
	 bBp5Fh+cdScd6voqQgkXIPkgKQWvYaRGfYBv9KfAHpdq90zBLRcJ6ybk3mNRn/0XuO
	 YFkeCOrUPBmTooHpnI0t+sQp0uFNOIEsdDbSB/U4+/gPliDf37XWnJpZX8XOL/PNTg
	 skcS7n6a58t5jj5ptOKRE4N0nbNGQEzcDxkVKmqrzRMqLssPF6shFXvF8oJGMSxA2X
	 IvpQEuHnGVCRl5pyaFoDHEHtvOXVe5Uq4hhW4zTY4KkPKW1HoQi66H+SnQzLhygxWG
	 +UGlCwcTUeJDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 78C9DCE0868; Mon, 16 Oct 2023 09:48:21 -0700 (PDT)
Date: Mon, 16 Oct 2023 09:48:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Barret Rhoden <brho@google.com>
Cc: Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
	davemarchevsky@meta.com, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Neel Natu <neelnatu@google.com>,
	Jack Humphries <jhumphri@google.com>, bpf@vger.kernel.org,
	ast@kernel.org
Subject: Re: BPF memory model
Message-ID: <5b23c67b-8b15-4d54-8f38-c201a6842b20@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
 <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
 <5c3b16c8-63e6-4f80-8fa2-6bacb38cdcb6@google.com>
 <e5c6b7f7-3776-4c2e-9896-fe44e735c1d1@paulmck-laptop>
 <22da941e-384a-4f02-80c4-8b84c0073f8d@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22da941e-384a-4f02-80c4-8b84c0073f8d@google.com>

On Tue, Sep 19, 2023 at 11:55:42AM -0400, Barret Rhoden wrote:
> On 9/19/23 05:52, Paul E. McKenney wrote:
> > Just to make sure that I understand, the idea is to compile from (say)
> > __atomic_load_n() to BPF instructions, correct? Or is this compiling all
> > the way to the target x86/ARMv8/whatever machine instructions?
> 
> correct; i'm compiling with clang -target bpf to BPF instructions, which
> should be spitting out the appropriate BPF atomic ops.  then i hope that if
> i get the compiler to emit the reads and writes in the correct order, that
> the JIT maintains that order when it turns them into x86/whatever.

Hopefully better late than never, here is a draft:

https://docs.google.com/document/d/1TaSEfWfLnRUi5KqkavUQyL2tThJXYWHS15qcbxIsFb0/edit?usp=sharing

Please do feel free to add relevant comments.

							Thanx, Paul

