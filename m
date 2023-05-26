Return-Path: <bpf+bounces-1319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C1712AED
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 18:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD81E1C210C3
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 16:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1927725;
	Fri, 26 May 2023 16:44:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9C2CA6
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 16:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE30C433EF;
	Fri, 26 May 2023 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1685119438;
	bh=Z/ch5nJkQyaxrmN1rRuD6Zg08kQpZg1acmK+3khx85E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hT82lZ1GYXwKZ3QyfJyhu12TOwN6oQstsGuNbmlXcwBuDDULVbbZ1dh3lPvrex2DD
	 RF9Ig7Bx4mdzowwgjgWTQkXt9Xagfua8Xh9YmwXQTdHqkztG4L66CaHFmOoXcIJcDJ
	 S/JFEo91ouORTBBrIbDHSZe2CZc1ZIlgiOvUrDlE=
Date: Fri, 26 May 2023 17:43:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, sdf@google.com,
	error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
Message-ID: <2023052647-tacking-wince-85c5@gregkh>
References: <20230320005258.1428043-1-sashal@kernel.org>
 <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com>
 <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
 <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com>
 <2023041100-oblong-enamel-5893@gregkh>
 <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>
 <2023052435-xbox-dislike-0ab2@gregkh>
 <CAN+4W8iMcwwVjmSekZ9txzZNxOZ0x98nBXo4cEoTU9G2zLe8HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+4W8iMcwwVjmSekZ9txzZNxOZ0x98nBXo4cEoTU9G2zLe8HA@mail.gmail.com>

On Wed, May 24, 2023 at 06:04:43PM +0100, Lorenz Bauer wrote:
> On Wed, May 24, 2023 at 5:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Great, any specific commits that fix this issue would be appreciated to
> > be pointed at so we can apply them.
> 
> The problem was introduced by commit f4b8c0710ab6 ("selftests/bpf: Add
> verifier test for release_reference()") in your tree. Seems like
> fixup_map_ringbuf was introduced in upstream commit 4237e9f4a962
> ("selftests/bpf: Add verifier test for PTR_TO_MEM spill") but that
> wasn't backported.

So what tree(s) does this need to be backported to?  I'm confused, this
is a 6.2 email thread which is long end-of-life.

> To restate my original question: how can we avoid breaking BPF
> selftests? From personal experience this happens somewhat regularly.

It can be avoided by people testing and letting me know when things
break :)

thanks,

greg k-h

