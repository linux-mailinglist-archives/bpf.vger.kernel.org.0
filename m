Return-Path: <bpf+bounces-63496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DCAB080B0
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC553567C0E
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 22:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84D2EE987;
	Wed, 16 Jul 2025 22:50:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316A2B9BA;
	Wed, 16 Jul 2025 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706240; cv=none; b=LPT49b4YobHYQbvripyNIZleuIs6onvdKFazI4inRAed60G0rlmn3h+jv18zOEIcM0/WcxX6A7F35+fZtKGHddtRyng4HPfwqE2NWsRA0LMHsrQz0tCk9EucXhWcb2gxK6jaxSfrKmBKDXWNEzwDgnjHqfLeiIOvqGh9AEdUY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706240; c=relaxed/simple;
	bh=CWwZR3vXHcSGmk9jbJwrkcTI+WlgvFDrMWEsoEh6CHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCpxDv0bHo1FCRL2/yiqI51Y7J0vmo7E7sgacjuLvVgwOLYfRpUVfYdCqdJLq1Z2jrMR2dLwom42fjcN3IxXUa0VmF2TMZhHTamBls+6JZ07/ZZ1/r6wREM79I2EwLBgL9/S/af9jdtBm3G7RQwAZalgBXAtETbRiQb1deFNU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 652461101FB;
	Wed, 16 Jul 2025 22:50:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 2635D35;
	Wed, 16 Jul 2025 22:50:34 +0000 (UTC)
Date: Wed, 16 Jul 2025 18:50:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong
 <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, Jiri
 Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
Message-ID: <20250716185053.11026a4f@gandalf.local.home>
In-Reply-To: <20250716184940.17b6b073@gandalf.local.home>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
	<20250703121521.1874196-3-dongml2@chinatelecom.cn>
	<CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
	<45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
	<3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
	<CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>
	<20250716182414.GI4105545@noisy.programming.kicks-ass.net>
	<CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
	<20250716184940.17b6b073@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2635D35
X-Stat-Signature: gxxosfe1go81sakf8wk4oyufjwfcqqot
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/BJkFj3iiMXx1spu5bVz7zXgsz3/uVj+E=
X-HE-Tag: 1752706234-691707
X-HE-Meta: U2FsdGVkX199mFPQImK6Q6bFbaNQ6zSd0Vu4iKQAOkfLW8xOMrpzsK+Ge8+vbiy23HjAHtK1Xi+jVu2+z1DVVCD74+l48LoQw8X1ZeAHCMD6XL11fFbVNjjLyUaT1R9ysOiNahEUO8XWTOY4BGDJUP0xLfyZibUi9w4N3bTUzBnrBRixCm+GqwYFobDdnN11XsMVZPB7BvOG8BHtALYkKJ45KshjvzFSSh+npJov1NYxBNrrR95QWg4EptaLGeqTX5H9ZrOjk7A/V7COBA95zN+/9GhzsGmOcnzGI05AeTCubNVO+941ibTx2Yzfl37do3TlJuya1EXiaFSR4+Qi3x2GdLo468dm3dFN7ZrozyU0PAmDxn5pJ72jROHqzp0c

On Wed, 16 Jul 2025 18:49:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> GNU Cauldron in Porto, Portugal is having a kernel track (hopefully if it
> gets accepted). I highly recommend you attending and recommending these
> features. It's happening two days after Kernel Recipes (I already booked my
> plane tickets).
> 

Bah, I forgot you are on the abstract so you already know about this! ;-)

[ But I might as well advertise to let other kernel devs know ]

-- Steve

