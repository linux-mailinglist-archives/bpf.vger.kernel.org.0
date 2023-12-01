Return-Path: <bpf+bounces-16372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC81800799
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5119B211D9
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1D31EB2E;
	Fri,  1 Dec 2023 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIFhVuKN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ECAB2
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 01:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701424522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Awh0v/eo34vSS7sfzNnvvbkAXfXzBFy08uRdtmRmC/0=;
	b=eIFhVuKNdo5QQG8vU3Djc6qbXZ0vPd4OJgnGXS1n9xaJonrrlBtPm4MODCfKOnNOaVnZ7S
	eQu2k7qtbFRcXqWr/fE/Cox3ukOj+PIxs4deQO7FMC56HoZeJ+it4D5nCuc+K4dV+eTE42
	5CmV9INWieUj/7Uynf0UTQtEQXwfLU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-brlE3Yy2O5GUeKCVoJY6Ww-1; Fri, 01 Dec 2023 04:55:18 -0500
X-MC-Unique: brlE3Yy2O5GUeKCVoJY6Ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 377D881B561;
	Fri,  1 Dec 2023 09:55:18 +0000 (UTC)
Received: from wtfbox.lan (unknown [10.45.225.237])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E7AE36E2;
	Fri,  1 Dec 2023 09:55:11 +0000 (UTC)
Date: Fri, 1 Dec 2023 10:55:09 +0100
From: Artem Savkov <asavkov@redhat.com>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZWmtfZlTq2hBn5zp@wtfbox.lan>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-2-9erthalion6@gmail.com>
 <CAPhsuW6J+ZN7KQdxm+2=ZcGGkWohcQxeNS+nNjE5r0K-jdq=FQ@mail.gmail.com>
 <20231130100851.fymwxhwevd3t5d7m@ddolgov.remote.csb>
 <CAPhsuW7Yif_mhaUsiwSFyUD7Pv4sz163DBz73EDhnTGMhwdApg@mail.gmail.com>
 <20231130204134.4i4tloaylxrkrnrt@erthalion.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130204134.4i4tloaylxrkrnrt@erthalion.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, Nov 30, 2023 at 09:41:34PM +0100, Dmitry Dolgov wrote:
> > On Thu, Nov 30, 2023 at 12:19:31PM -0800, Song Liu wrote:
> > > All in all I've decided that more elaborated approach is slightly
> > > better. But if everyone in the community agrees that less
> > > "defensiveness" is not an issue and verifier could be simply made less
> > > restrictive, I'm fine with that. What do you think?
> >
> > I think the follower_cnt check is not necessary, and may cause confusions.
> > For tracing programs, we are very specific on "which function(s) are we
> > tracing". So I don't think circular attachment can be a real issue. Do we
> > have potential use cases that make the circular attach possible?
> 
> At the moment no, nothing like that in sight. Ok, you've convinced me --
> plus since nobody has yet actively mentioned that potential cycle
> prevention is nice to have, I can drop follower_cnt and the
> corresponding check in the verifier.

If you are worried about potential future situations where cyclic
attaches are possible would it make sense to add a test that checks if
this fails?

-- 
Regards,
  Artem


