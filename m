Return-Path: <bpf+bounces-47612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378DD9FC69F
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 22:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5811E7A13B4
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 21:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE141B87DC;
	Wed, 25 Dec 2024 21:56:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED57A13A;
	Wed, 25 Dec 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735163764; cv=none; b=FIJWGuhZGRMIg/+pE+koVMp28hjxN7bQK700FV1CwpD6RyQXFcKVS4XNB0vRL0EzYDM1H7tWHGn7Z6WHjeXr8OkD4S7sFl35UYKuKB9rlhlAOaCKEosROBZRJs5YYvQH2N47fS3iZVRxaXU+Kz/cwC45GdCV9kOGPO2krMEIc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735163764; c=relaxed/simple;
	bh=6LCJOnLn9TN2kRkXWdBh2jy0zRv84dMCpHIoNwSAXYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=As/VMlff7qSS5ocGNnjAhhaXjlvACD5v0cKt+uXYdgzVe+UGgt4nmWHabLZ3/qbDBoUfvO748n9LVXmP5FGJxGbqnN+2dHNlRdHbbJGCUuYXtTWG9hYxXnPlSCZIQ97/lfGvls0TCkVCuCRED8AB8/r7PWtSFN64jqPnORQtEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A617C4CECD;
	Wed, 25 Dec 2024 21:56:02 +0000 (UTC)
Date: Wed, 25 Dec 2024 16:56:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Donglin
 Peng <dolinux.peng@gmail.com>, Zheng Yejian <zhengyejian@huaweicloud.com>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ftrace: Add function arguments to function
 tracers
Message-ID: <20241225165601.06c4c0b2@batman.local.home>
In-Reply-To: <Z2x75Yumj1TKYce0@krava>
References: <20241223201347.609298489@goodmis.org>
	<Z2x75Yumj1TKYce0@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Dec 2024 22:40:53 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> hi,
> what branch is this based on? can't find any that would apply patch#2
> without conflict.

Sorry, I should have mentioned in the cover letter, that this is based
on v6.13-rc4 with Masami's fprobe patchset applied:

  https://lore.kernel.org/linux-trace-kernel/173379652547.973433.2311391879173461183.stgit@devnote2/

-- Steve

