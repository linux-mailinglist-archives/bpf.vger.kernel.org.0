Return-Path: <bpf+bounces-20403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E15783DDA1
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 16:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2058CB22C6C
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D21CFB2;
	Fri, 26 Jan 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l67yu1d9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5231CD26;
	Fri, 26 Jan 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283469; cv=none; b=dSJLvCG8KbRMiewP7qR+uDJu1b07JT2amihvUSj8v1AH7Rc5wYox+rhVA4jl9BAYLJrnRphpbCRoVk5N9L3w/ITNlR54fSlOsYXjgTWT+z0HQPRS/o5powSIJRDtknxT9salLheBpWe9EbmzXR0kckDh3PwDSmKszeangyGz66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283469; c=relaxed/simple;
	bh=o9PbZ6qTkUkkoOd5FrVKVyruIlMkOqYiBzgq/Uwmp10=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nx78X6B3F4WRKudwyIxnUf34MZXMchus0X3Zj/W96EyFq3JX+5oo7tDIQTrLr6/x54RJwzbD4P+lSswX++2MQZNvU1+Tt2/h7W8lddsrOQmEYMTIhQCuloAE+O0lOUC0C7kZ3GsgCk/Hj4uB3Hfhh4B3xORLxKidAgTaA7W0VoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l67yu1d9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so317582a12.3;
        Fri, 26 Jan 2024 07:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706283467; x=1706888267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayw4r0Wmkcdsa6cA6rwExvEfPd3csfaaOOWLYyKhGg4=;
        b=l67yu1d9g29PUhhojMZxM7HUr25kXdg+NkfKkgIkkED1Z34Gz/NNkpFzg8+h/jAsAQ
         gKFLE/Mu5/gAjLcWzUyfPlRYC6P2Aw3XhqVtVWFj622B2of73m1R/WrufW8n8i3UHObg
         9V+FBqELBqkpQPUL0FAAvFgvzYreb5KwfO3C/Aoz6Q2VXnyhI6rQj4tM8X6Mixk1xT5p
         LyCu/+g+x/Y9svsO2w6zJEXuMCmMNbeSuGfCmFVHhE2om3ptJr985Fb9f++OWTAzyzph
         gTGQQZLoqIBTsyIsIexvRDSkqJrYNP61QKlra9ejDT6I+nQpzey6I3u1mqIu3sDK1Y2h
         C6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283467; x=1706888267;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ayw4r0Wmkcdsa6cA6rwExvEfPd3csfaaOOWLYyKhGg4=;
        b=DLYGcDifmCFiO8C993CkLkGycsxOccsee/GvvNR/Wip4yy0X/6/mbbVPC5ZDYr3cve
         ihAYYpFY3C6M70LBYI8h0tJXfq+IdU7KEBQ/3hwDySB0A2tA8suz07tQQmvq1yD4WtXv
         nvdkrAY2rLh2bwWYvfj5gNQwgkwPdP2Y+TtdHRnidrfRYLjf3YdAfiEoJQIUausfefP7
         D2/E7g39qF2OQqQaU1BfIMj0/bzWyT2grh6MYonYeRjymrUzVnnVs9up3LU4CoUel8Yh
         kAj4thA9Y8fFYgyaqmR0lpIZBXc6nO8Eb1Pq1k1KgMJr6piD7QcBa791HoghnxWNLUSU
         PJCw==
X-Gm-Message-State: AOJu0YznAJON1jVxbYa5IPToaZFmJSyUg+X4qzxbDUyuJfVpP5/Sg4/V
	f32pSMKhops8ZqplWnnCJFcXC7McfzFfLAINjHOUL+XJBevaeOH6
X-Google-Smtp-Source: AGHT+IErRpi8O9/RaHPT0VXt1dOGf9juvVtykqoUqaL+CyHtLSnUodwPjG+TpPZKPKlf4nFFqmjUtw==
X-Received: by 2002:a05:6a20:bf04:b0:19c:18b6:8d71 with SMTP id gc4-20020a056a20bf0400b0019c18b68d71mr962127pzb.72.1706283467376;
        Fri, 26 Jan 2024 07:37:47 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id f8-20020a056a001ac800b006dde10cb03esm1222402pfv.151.2024.01.26.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:37:46 -0800 (PST)
Date: Fri, 26 Jan 2024 07:37:45 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 andrii@kernel.org
Message-ID: <65b3d1c9e2c4_15499720899@john.notmuch>
In-Reply-To: <874jf0ffza.fsf@cloudflare.com>
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
 <20240124185403.1104141-2-john.fastabend@gmail.com>
 <874jf0ffza.fsf@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: sockmap, add test for sk_msg prog
 pop msg helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> On Wed, Jan 24, 2024 at 10:54 AM -08, John Fastabend wrote:
> > For msg_pop sk_msg helpers we only have older tests in test_sockmap, but
> > these are showing their age. They don't use any of the newer style BPF
> > and also require running test_sockmap. Lets use the prog_test framework
> > and add a test for msg_pop.
> >
> > This is a much nicer test env using newer style BPF. We can
> > extend this to support all the other helpers shortly.
> >
> > The bpf program is a template that lets us run through all the helpers
> > so we can cover not just pop, but all the other helpers as well.
> >
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---
> >  .../bpf/prog_tests/sockmap_helpers.h          |  10 +
> >  .../bpf/prog_tests/sockmap_msg_helpers.c      | 210 ++++++++++++++++++
> >  .../bpf/progs/test_sockmap_msg_helpers.c      |  52 +++++
> >  3 files changed, 272 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
> >
> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> > new file mode 100644
> > index 000000000000..9ffe02f45808
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> > @@ -0,0 +1,210 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2020 Cloudflare
> 
> Thanks, but we can't take the credit for this brand new file ;-)

Ah yep seems I cut'n'pasted it from one of your files. I'll
update it.

> 
> > +#include <error.h>
> > +#include <netinet/tcp.h>
> > +#include <sys/epoll.h>
> > +
> > +#include "test_progs.h"
> > +#include "test_sockmap_msg_helpers.skel.h"
> > +#include "sockmap_helpers.h"
> > +
> > +#define TCP_REPAIR		19	/* TCP sock is under repair right now */
> > +
> > +#define TCP_REPAIR_ON		1
> > +#define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
> 
> These defines are not unused by this module. Copy-pasted by mistake?

Yep first iteration I used these will drop them. Thanks.

> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
> > new file mode 100644
> > index 000000000000..c721a00b6001
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
> > @@ -0,0 +1,52 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2020 Cloudflare
> 
> ^ :-)
> 
> [...]



