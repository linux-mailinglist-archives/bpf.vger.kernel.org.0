Return-Path: <bpf+bounces-41491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5482A9977A6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 23:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA56284455
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 21:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134F1E282D;
	Wed,  9 Oct 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c4fjM8mh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730181E260E;
	Wed,  9 Oct 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509953; cv=none; b=r+7ueQbpreUThVnN53mRnYgRfTVH/MGnPtsP/XyC+u4Y8S67ylVOeerS7EYsirOW1w+Ikxz0/ueQP/F8hxIOmMQI18UWP4HAveQeAwcyJo+aidgEqIhpxiL/6BwcrxM50O3xcNuc+IJLr8OlTqAYAMzVJoLTAD8IKmQ7Sp/a7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509953; c=relaxed/simple;
	bh=CU+bKdiLvhjPIp++UvcHAtv6o7pUO4NwmdT+Nl/+Mmg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XG3fDg437bH3j+ZGINaOoAx0BmIXDAmgUIMKnF429Hgx9H/qb3suxoaivCrd2Z0H4fqG0vMZz3GcpIkKergRw53+/ukFHbyAIOfX/8jpROiPAbKCBZhhxx9CFMcqN9ti9Qd0/h3sK9LLraltGx1TPh2ZEcX/wyfKMF0gE014DKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c4fjM8mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E030C4CECC;
	Wed,  9 Oct 2024 21:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728509952;
	bh=CU+bKdiLvhjPIp++UvcHAtv6o7pUO4NwmdT+Nl/+Mmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c4fjM8mh1xyF18VWzdhvax0bPPTQt/GhWBC3RJnAhZpKuNmkNW+TkHuG1kLn029Qa
	 XRwKFO55BoE1+EI4tUu3cOF83idppwKsknOIr4RZPYc+99gm3eJOLEMRd+XeYshE15
	 H2LUgvyVArQ/IObC2276H0mlt7DtbkVKkiQBGFAY=
Date: Wed, 9 Oct 2024 14:39:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: Marco Elver <elver@google.com>, andreyknvl@gmail.com,
 bpf@vger.kernel.org, dvyukov@google.com, glider@google.com,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ryabinin.a.a@gmail.com,
 syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com,
 vincenzo.frascino@arm.com
Subject: Re: [PATCH v4] mm, kasan, kmsan: copy_from/to_kernel_nofault
Message-Id: <20241009143911.3c394e1bc598f59ce764a67c@linux-foundation.org>
In-Reply-To: <CACzwLxhJTHJ-rjwrvw5ni6jRfCG5euzN73EcckTSuM6jhoNvXA@mail.gmail.com>
References: <CANpmjNN3OYXXamVb3FcSLxfnN5og-cS31-4jJiB3jrbN_Rsuag@mail.gmail.com>
	<20241008192910.2823726-1-snovitoll@gmail.com>
	<CANpmjNO9js1Ncb9b=wQQCJi4K8XZEDf_Z9E29yw2LmXkOdH0Xw@mail.gmail.com>
	<CACzwLxhJTHJ-rjwrvw5ni6jRfCG5euzN73EcckTSuM6jhoNvXA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 00:42:25 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:

> > > v4:
> > > - replaced Suggested-By with Reviewed-By: Marco Elver
> >
> > For future reference: No need to send v+1 just for this tag. Usually
> > maintainers pick up tags from the last round without the original
> > author having to send out a v+1 with the tags. Of course, if you make
> > other corrections and need to send a v+1, then it is appropriate to
> > collect tags where those tags would remain valid (such as on unchanged
> > patches part of the series, or for simpler corrections).
> 
> Thanks! Will do it next time.
> 
> Please advise if Andrew should need to be notified in the separate cover letter
> to remove the prev. merged  to -mm tree patch and use this v4:
> https://lore.kernel.org/all/20241008020150.4795AC4CEC6@smtp.kernel.org/

I've updated v3's changelog, thanks.

I kept Marco's Suggested-by:, as that's still relevant even with the
Reviewed-by:.


