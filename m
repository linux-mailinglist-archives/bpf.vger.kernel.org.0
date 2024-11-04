Return-Path: <bpf+bounces-43895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 499099BBA43
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A44B2291B
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496871C243C;
	Mon,  4 Nov 2024 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxXJF08E"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724D16C854
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737319; cv=none; b=OnxaYy9WBYjjFrG4gZlzVoAqIFQgdWRWqz0IXoF0FVGyAgiSiiqr6BnAwTbQTUU522XaPVYVOWeiHJuOa/08w82I6kYWltmFnlneJb0fah7DwZItKkIvsPxhVUnFuGmzFEiCg9Xv+NUaOVTAujDdprv5k6RjDbyAGtUKsxUIhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737319; c=relaxed/simple;
	bh=wAsv6Hzd+vLzoBRefi30adxZHlxiXeAGF9icWVXVSmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFd0Szu8+DBNs24YdR6Sc8lGXGx1JtEEd1f3oI2Fe2BzDk7T/1O5xBQYLNrrTd9DbkaZMXTVawxT8cARHXmv++MSN+MuPLFVO1f3GRwi6cLl3OJB+/Bzp08n1KEka6NZSFWtuPxdMnC823KQXIdkUfGuIa9jqPVLIwjcJWMVg48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxXJF08E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730737317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3bnz91kXN/ZEAzBQSwkUWrou7I1msisykoc+Lw0NZ9U=;
	b=AxXJF08EY1Lv7XHOCXzTzjdXyYhexVxrkF4/K/DMgFal/eUvyk7tvFPViqfVY76yh/cjW7
	r91sa35xK09YuM1XPtlni4OHD/3oEeV4WzM5UGkX2dwdHWSHvoPIxqrJIRikW5slP2vi42
	xDOFEGdhygZaKWxULHUgu20FFzlkV8E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Rtlh9aeFM2yMIP_1oABG1Q-1; Mon, 04 Nov 2024 11:21:55 -0500
X-MC-Unique: Rtlh9aeFM2yMIP_1oABG1Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4cf04be1so2316342f8f.2
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 08:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737315; x=1731342115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bnz91kXN/ZEAzBQSwkUWrou7I1msisykoc+Lw0NZ9U=;
        b=uGOceCGrpGjIvGy7Ep/xgXZPia10T4BpgHpcHB+EB4IXPdlIJMecnzfVuPQhctOarU
         TqXT8P2zgOG71g4+eP8IsQPB2diQKw4POkSWf/Miw5blbOeHpA5zu9pOE/TXSTUfsqCg
         4zJstWeI71ZnXj/jGAWjzL7x5deuQRZHlrIhNLovO7tqJ92/AMcoZL1Svgt2kZcZzPoD
         Fz1l9wJxZrNwZvdaMZlKuTfUz2X0WqWUTdVHvmCdpOKPYTrYHEnKrp9naRp4DIj2rUfh
         FY4GTUz8kfdMfoUYHt/bv37e4arooYqrE+R7awV1T3rsqPDYEaSYA51CxQRkMZwXkyr1
         YQFg==
X-Gm-Message-State: AOJu0Yyx+IeAeW1WWtgC53vMUAZ/TQK4/T+ufOtg3R7qEAe0IskYa+TM
	Ysds8GZv2preMK+ZsPU7G8VdFk0OUo2ydaFn/bYiaLEWiY2QFHsSCPLTBBJn7Lva2QL7x9r7U12
	HY+gcT2VaxGI93kXm01rTOXZL///Lu5I5gf38MlbqwHV/MF7atQ==
X-Received: by 2002:a5d:6c65:0:b0:37c:cbd4:ec9 with SMTP id ffacd0b85a97d-381be7add43mr11641452f8f.5.1730737314758;
        Mon, 04 Nov 2024 08:21:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiNz2DAmZDBpA/TUJ4mXu18j5OCnCv216So36vS1aCJUcD4MmGjqSXsaNebnA9dQ/OhNSrtw==
X-Received: by 2002:a5d:6c65:0:b0:37c:cbd4:ec9 with SMTP id ffacd0b85a97d-381be7add43mr11641429f8f.5.1730737314294;
        Mon, 04 Nov 2024 08:21:54 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.142.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e5d6sm13581941f8f.76.2024.11.04.08.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:21:53 -0800 (PST)
Date: Mon, 4 Nov 2024 17:21:51 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <olsajiri@gmail.com>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 0/3] Handle possible NULL trusted raw_tp
 arguments
Message-ID: <Zyj0n3aWgNd5MmA2@jlelli-thinkpadt14gen4.remote.csb>
References: <20241103184144.3765700-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103184144.3765700-1-memxor@gmail.com>

Hello,

On 03/11/24 10:41, Kumar Kartikeya Dwivedi wrote:
> More context is available in [0], but the TLDR; is that the verifier
> incorrectly assumes that any raw tracepoint argument will always be
> non-NULL. This means that even when users correctly check possible NULL
> arguments, the verifier can remove the NULL check due to incorrect
> knowledge of the NULL-ness of the pointer. Secondly, kernel helpers or
> kfuncs taking these trusted tracepoint arguments incorrectly assume that
> all arguments will always be valid non-NULL.
> 
> In this set, we mark raw_tp arguments as PTR_MAYBE_NULL on top of
> PTR_TRUSTED, but special case their behavior when dereferencing them or
> pointer arithmetic over them is involved. When passing trusted args to
> helpers or kfuncs, raw_tp programs are permitted to pass possibly NULL
> pointers in such cases.
> 
> Any loads into such maybe NULL trusted PTR_TO_BTF_ID is promoted to a
> PROBE_MEM load to handle emanating page faults. The verifier will ensure
> NULL checks on such pointers are preserved and do not lead to dead code
> elimination.
> 
> This new behavior is not applied when ref_obj_id is non-zero, as those
> pointers do not belong to raw_tp arguments, but instead acquired
> objects.
> 
> Since helpers and kfuncs already require attention for PTR_TO_BTF_ID
> (non-trusted) pointers, we do not implement any protection for such
> cases in this patch set, and leave it as future work for an upcoming
> series.
> 
> A selftest is included with this patch set to verify the new behavior,
> and it crashes the kernel without the first patch.
> 
>  [0]: https://lore.kernel.org/bpf/CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com

This indeed cures the issue for me! Thanks a lot for fixing it.

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


