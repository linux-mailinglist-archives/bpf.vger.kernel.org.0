Return-Path: <bpf+bounces-39560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919F69747CC
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 03:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA485B21745
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 01:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DFA22066;
	Wed, 11 Sep 2024 01:32:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD42748A;
	Wed, 11 Sep 2024 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018362; cv=none; b=tuQhr10LJEk6vb/u4/MjV1/D7n6jz3Q/fwm9Q/AQ6zdZGNGY4y1CCXuylv5Qi91O80nuMkhvy5fmaj/4Yb+a5Hi3L08ISNDRB/nOlxfdso5DEQOdeyaTrnG7MUSPuEWZJ0YqyWUSm7+Xs1I4KEgiwiUP7bMSQBkfvi2RH6LXzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018362; c=relaxed/simple;
	bh=6OHIbjwU8eKxONQCPlbkcdc0N5e6VMnGSTw9VrDajQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOzvB7aKMY0zkN9CGQAvmQbitp8BGIvnq6N51ykzGrlmjoyL++yRKauBHphYF/XKe6TUZjX4gqECTpaXlkI3AOUX7xym6yrlL/bMmroyc6VHt8Xq28yhl5qHFcFsulJTVd43LyD4uj3LRAuPZXCMBOm1BjOVXAdoEfSuidwqPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E0FC4CEC3;
	Wed, 11 Sep 2024 01:32:39 +0000 (UTC)
Date: Tue, 10 Sep 2024 21:32:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh
 <kpsingh@chromium.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Florent Revest
 <revest@chromium.org>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
Message-ID: <20240910213241.58da3e43@gandalf.local.home>
In-Reply-To: <20240910212702.6679f507@gandalf.local.home>
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
	<CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
	<20240910145431.20e9d2e5@gandalf.local.home>
	<CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
	<20240910182209.65ab3452@gandalf.local.home>
	<CAEf4Bzb12RE6QvLLb1ptSedO2Q2zEZCvxM73BcKXUodJpi5tiw@mail.gmail.com>
	<20240910212702.6679f507@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 21:27:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Does Linus have to be in CC to get any reply here? Come on, it's been
> > almost a full week.  

Moral of the story is, if you had left out the above sentences, I would have
updated you nicely and this would not have been an issue.

-- Steve

