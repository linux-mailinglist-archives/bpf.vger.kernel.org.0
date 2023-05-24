Return-Path: <bpf+bounces-1172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB6570FB4B
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 18:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954291C20E55
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4F19E4B;
	Wed, 24 May 2023 16:04:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C411951F
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 16:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FE9C4339B;
	Wed, 24 May 2023 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1684944242;
	bh=AvLEpqq/Dfm1IZH9Fj2SEDUypWc1N9U5UTURKsOgFXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlzXFI5cSYkrBMMbmjohePIfZJEJ1wyXXh8nVwQWYHkk8no4B3DZgv+dD2ve05da8
	 pekgyIFhR2BvsiTbttuSUbf8SlIpeOJURyDpYVVmKCeDTjGGj1QtMuuAiz4KNIBzI1
	 smXEPshQji5C5rb14OqzMaF7TjOIJRvLXVEh+RS0=
Date: Wed, 24 May 2023 17:03:59 +0100
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
Message-ID: <2023052435-xbox-dislike-0ab2@gregkh>
References: <20230320005258.1428043-1-sashal@kernel.org>
 <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com>
 <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
 <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com>
 <2023041100-oblong-enamel-5893@gregkh>
 <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>

On Wed, May 24, 2023 at 12:03:43PM +0100, Lorenz Bauer wrote:
> On Tue, Apr 11, 2023 at 4:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > I didn't see anything to do here.
> >
> > And selftests should NOT be broken on stable releases, if so, something
> > is wrong as no other subsystem has that happen.
> 
> Sorry for the long delay in replying, I update the kernels we use for
> CI only infrequently. Here is an example of the build failure I'm
> seeing, from kernel.org 5.10 LTS:
> 
> In file included from
> /work/build/5.10.180/tools/testing/selftests/bpf/verifier/tests.h:59,
>                  from test_verifier.c:355:
> /work/build/5.10.180/tools/testing/selftests/bpf/verifier/ref_tracking.c:935:3:
> error: 'struct bpf_test' has no member named 'fixup_map_ringbuf'; did
> you mean 'fixup_map_in_map'?
>   935 |  .fixup_map_ringbuf = { 11 },
>       |   ^~~~~~~~~~~~~~~~~
>       |   fixup_map_in_map
> 
> This is just doing make -C tools/testing/selftests/bpf after compiling a kernel.

Great, any specific commits that fix this issue would be appreciated to
be pointed at so we can apply them.

thanks,

greg k-h

