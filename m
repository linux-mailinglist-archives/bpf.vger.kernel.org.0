Return-Path: <bpf+bounces-57514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB9AAC57E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 15:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4163AF5BB
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8EC28003B;
	Tue,  6 May 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1DrvTwm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8327FD6F;
	Tue,  6 May 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537122; cv=none; b=UpPXxk6T/qV/Wr9mnhEaHuIVrpFovJsfXk+3QKMDwAM4Z9zYIRjqnjzBKI7ta87+0zGkO29Sck3bJg/7BwkIjvSSvcrszbeLtrwdtyS926USoUBhCCQy6yBvdHBqTBIiwP6z3sUCSsPRY0y+xVVPH57yAp8cB+tMDvUQ/oQhSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537122; c=relaxed/simple;
	bh=90HQUUKUTzriwfUVeJS5Q2klum4Y6G1J3o9H497VWHg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eduldDM+hkwyK4w1W8WbNfYJsZiSh12DALA6DrNi10PsrDPvBADdjElhW++QE57SLSmfgmNo8+Wh6z9v4Zdv9uB0Plm7QDKkSaHCDtb6gDtUxPM5+D4zI8nXzcv9HKvs1PMO1zPOFbIAdm5JsNLWictXs4I0eFYIrX6xwkhfyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1DrvTwm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0b308856fso135519f8f.2;
        Tue, 06 May 2025 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746537119; x=1747141919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6z4DI8j6oTUcEftx6nE5ha5TjZEr3u0qLC5LhSNxy5Q=;
        b=b1DrvTwm3dCxVnFURH3wvtit4ly7uEjfnrf0K0V8Gn2GPFsmK4RU1zg0jTDU/dffb1
         pQC1D1rmYfHic0xQq7D6X5oEADJZZPie0hEmj1KTMuiW+3R+gput+zcs4rJi6daj0QfQ
         rhZd+BF5M3NjXjGKzIA880SVu3JfABK0TL5eBLGy4qlilDfeRnBxYxY+Fn6J1ptRxG9L
         782nddpiuhxA0DK2g3MjeFknTB6kMOdVcB64PrjEeCci2p+xfw8wfQZETE4LoyLhb2Do
         cgbiTo+eUeP/g8dNWENfoznLr6QQonQich+GUj4BUL6KunVJNOPCr//Y88a/NF+PfQfv
         Wuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746537119; x=1747141919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z4DI8j6oTUcEftx6nE5ha5TjZEr3u0qLC5LhSNxy5Q=;
        b=TYN5QTVLkyC/RfRn8jo7Kgbbn3iHfnGQ1II6ZE57xqiL1z/6yepS+N3CRaqek3zSeA
         2oLLD6muYyp/NTxa4wJbDRe8oQPCN88l73dRMxU2QPBmQ8Q9pM7UbCuQCCAlZDmJj08I
         TwiKO8PzJ/UDuaOGkIh6fDu0Dza32T7jbgvzQwgNOI/3q6fEGZY5u2yP4Nclpx3c6xFn
         P+jZhxaB4d6WRbUBNTUzwVGUdpOKJ/ukh+jVWoDLSjsAhxN2rmvp5S6VVRs2nIYGGMkf
         Hl3SkOW4QzlZS8/UM9MPB3hxsZD1XbyuXDSB/ycfj+NdblnLA5mWglAGP8AvugStWm+i
         /gPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSw0dHKgAb7jIxnq551GrI0CyXAMqGsc8dNJ2qsUOFkiISnXJ4eTfXynB1+nAKkuzLpzY=@vger.kernel.org, AJvYcCWa8OI1znN/Z3lcaVYSt6oTVbv4FgOPV62QLz7sjKcg+oqM88tBa9gmG6Q2UYNpnEbwN0sZE0t1Pi7AxhpvPDfqgP65@vger.kernel.org, AJvYcCXRWx620wdTg80oIcNJSa/EuZoJahyNnHSzLYuUmJbHX4jGu+4x6kdADO/E9vuOQsikLzdXy8Gh77euIpmt@vger.kernel.org
X-Gm-Message-State: AOJu0YxZi6R1BTI6kI42f2mPPvufF62dEnAccRm9IyXz5wbFnm4+L5vl
	IEQFZmtSUysvP+5BngG0VuqMRjBXF8Oq7gLDCux92LdleRtE27pX
X-Gm-Gg: ASbGncsPIIwhMcOWuxCLP1rPGnyHsnzGIPhkFPqL6h5ejva0gW4/50YwCpfWUXCt60G
	Qt3lRqSU1qGX3HQ/7swssyJq0sBk+73ewSP3jtigdd7QeFoFwKpyaPSedcC+VJGi6+23tMD4Kjw
	tOLTTGYeauC5MUofYaPWAIwwln45a3D7BlN+v1UODKMd3ruNuQluO391R3F3T0adjxFVfugHglB
	g6KR/WZoidvEPTfETEuY6xjJiVJE2fyMJOeegdaor4WJaMszYYYdx5Q5DkBOWys3o29gr4Ndrrx
	0LPmvndhuj6i/KkMuds1u5SSVh0=
X-Google-Smtp-Source: AGHT+IGUVC98ca0kalRXo5g5+zRzXsabvq9+qwfWCr4C94Y1I8eFtg0sW4MbTI+/mJsXiDl+Ifym2g==
X-Received: by 2002:a05:6000:18a7:b0:3a0:9de8:88ef with SMTP id ffacd0b85a97d-3a09fdfc05bmr8621556f8f.49.1746537118919;
        Tue, 06 May 2025 06:11:58 -0700 (PDT)
Received: from krava ([173.38.220.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa7781d0aasm7642970a12.45.2025.05.06.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:11:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 May 2025 15:11:56 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 03/22] uprobes: Move ref_ctr_offset update out
 of uprobe_write_opcode
Message-ID: <aBoKnP4L-k8CweMy@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-4-jolsa@kernel.org>
 <20250427141335.GA9350@redhat.com>
 <aA9dzY-2V3dCpMDq@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA9dzY-2V3dCpMDq@krava>

On Mon, Apr 28, 2025 at 12:51:57PM +0200, Jiri Olsa wrote:
> On Sun, Apr 27, 2025 at 04:13:35PM +0200, Oleg Nesterov wrote:

SNIP

> > 
> > -------------------------------------------------------------------------------
> > OTOH, I think that the current logic is not really correct too,
> > 
> > 	/* Revert back reference counter if instruction update failed. */
> > 	if (ret < 0 && is_register && ref_ctr_updated)
> > 		update_ref_ctr(uprobe, mm, -1);
> > 
> > I think that "Revert back reference counter" logic should not depend on
> > is_register. Otherwise we can have the unbalanced update_ref_ctr(-1) if
> > uprobe_unregister() fails, then another uprobe_register() comes at the
> > same address, and after that uprobe_unregister() succeeds.
> 
> sounds good to me

actualy after closer look, I don't see how this code could be triggered
in the first place.. any hint on how to hit such case? like:

  - ref_ctr_offset is updated

  - we fail somehow

  - "if (ret < 0 && ref_ctr_updated)" is true on the way out

thanks,
jirka

