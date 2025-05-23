Return-Path: <bpf+bounces-58821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB5AC1D97
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 09:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA334A3306
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 07:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D0421CC43;
	Fri, 23 May 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZSApMKd/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E91C5D7B
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985013; cv=none; b=dEP90wTTuP5xgSSO/8chAP63aGNY0wZn8kZ5uovaLfUFW3l+lznmAZVKe+Sq2sNTOoU1uATRrxl+ciB5j24baEWA4JAAjUG6E4lU1yGBKVAlrGSFllxRbTStDpw1Ywj3jUeB7olME2EpuGsP1wdWKl8q6OqnQ4QMuT/vf9/ojNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985013; c=relaxed/simple;
	bh=ihoBSshL0YGNXRQl56dbipBQPrtOpSxEgiCWKUyk9SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nByH3jKplGCYZDI8Y0DNELMDvrzS9vKKbVBjUJyb9jQx0MQ23hRaTQ5yZYscD4WG4m824YfouKlKqmIvAyJv+C4b5D95z2tZbE7W/5NclcVrYO5IIhZuaNWe5Nn88DvAamwE1rW9KGEAfU0xFTuMOIhjE5nbHMpOwo1sKSkdbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZSApMKd/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231e98e46c0so59024975ad.3
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747985011; x=1748589811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9oFOTJY+jM52XUB7bJEkukbArm9m+yq0+hVZWj+z6wQ=;
        b=ZSApMKd/qXasRPEv96HmP7k/98vVq6536qVucvH8vxog9RWDEf7spQauOjwmkwHmBx
         gUmxF7DR2GL+JLeIzD7NQj0N/X4Tx4ddnS8+nucnGF+N14V8ICvbsR9DMI5vOAQBEcpO
         zde+VvdBU3hcXQ/MpSvrLCAcsKYrITRKhfWls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747985011; x=1748589811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oFOTJY+jM52XUB7bJEkukbArm9m+yq0+hVZWj+z6wQ=;
        b=YY/EvFq3TL/Em38m54vlLzLiy5L4htlajN+3/zE56ZN3pnnzyNPHYzBC/0r2TjHS/B
         /ggnEY5L5e4avNZLJhPUpIuJItMPmhQm+l8SeDq2ky8psglwgL2sWie13/WF5kLBRyGq
         9iJr7paMd60+GDAxPD7RzPE8jUHT9bRn43Ys8sT/G7wsKk9FgvN2NQGzDI7k9MSzdXFQ
         FNh4jKkKKuWyFSeRxBhkQSkc/2B/LqHR1enAo+7sovpvohXBPxF/G5umQtEmwqtE9ret
         xjETCqXQDqql9KWbX/38mla3HZq4Uj2FgNpkdRxoWdqMIIzeces6ArloMANV2s7c8bXB
         HTVA==
X-Forwarded-Encrypted: i=1; AJvYcCUoQ2GZc8bQrMZXtVnIGgOlTRxFi+sdlDneP2G7pOXvwHI99ce6uqZ20IFm+gzK3tBudT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfmDOo6WU3JV7XnJvVZoKuBCmGhzWWgtbw2SDwCWpt4aj7ZrdL
	KBDaHuc1cIuDtWwYX/ToJxqlm8cGlnp05uEFAwtnNIT5wxYVlK9GVrWiT6LEL8QRcQ==
X-Gm-Gg: ASbGncsUYWx0XRTojNzwBVA8jGsSvGrsMHoGKcYrFiX8ESRhwdfWnLgvGlZqTrwVpSo
	QZuOF2/MBCb5PV5x3Msa4HE8PooW1a2M27e2gFFDTsWDR+8AfkjDHTVf5uQntnGq8QF4LqLTU8C
	iPuIh/QVrnQ+Ahqsf5ptL204xO5Ma8NKKD7Ldys/TNi7KhJhrB8sHUWa/kE2pftY+pYOsK2b4Xb
	cgqsbYwKr/qEggghOFVPqRLJ9aiv7xhydLxAK0N86SAZ5CubDNu9szZc1OQnC1jY/wtysxi1r4e
	FliIGTZhsnDq8sneQnEddpm+fE0vurG4JPGmBI/aaXb9GHe4K5a2Spc=
X-Google-Smtp-Source: AGHT+IGV7jMy68tNUPRjmOEfAPOqB8BQm0nYihPU/YOpSm86JVssQhjOtx/DD3XxmepL/d4sIa0A8g==
X-Received: by 2002:a17:903:3d04:b0:223:f9a4:3f9c with SMTP id d9443c01a7336-233f21c7ccamr28916195ad.9.1747985011352;
        Fri, 23 May 2025 00:23:31 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:17f7:e82e:5533:af02])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed897asm118688185ad.250.2025.05.23.00.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 00:23:30 -0700 (PDT)
Date: Fri, 23 May 2025 16:23:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] bpf: add bpf_msleep_interruptible() kfunc
Message-ID: <z4gvqyk3ktqhd4wmi7ju3qw67c56brf5klxcer3vqmp3v6sujn@2xq7j3ji4kic>
References: <20250515064800.2201498-1-senozhatsky@chromium.org>
 <CAEf4BzYTiPuOUbQgkNvT2haAupeep79q0pVu=fcD5fEgnAjR_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYTiPuOUbQgkNvT2haAupeep79q0pVu=fcD5fEgnAjR_A@mail.gmail.com>

On (25/05/20 16:26), Andrii Nakryiko wrote:
> On Wed, May 14, 2025 at 11:48 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > bpf_msleep_interruptible() puts a calling context into an
> > interruptible sleep.  This function is expected to be used
> > for testing only (perhaps in conjunction with fault-injection)
> > to simulate various execution delays or timeouts.
> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >
> > v2:
> > -- switched to kfunc (Matt)
> >
> >  kernel/bpf/helpers.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index fed53da75025..a7404ab3b0b8 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/bpf_mem_alloc.h>
> >  #include <linux/kasan.h>
> >  #include <linux/bpf_verifier.h>
> > +#include <linux/delay.h>
> >
> >  #include "../../lib/kstrtox.h"
> >
> > @@ -3283,6 +3284,11 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
> >         local_irq_restore(*flags__irq_flag);
> >  }
> >
> > +__bpf_kfunc unsigned long bpf_msleep_interruptible(unsigned int msecs)
> > +{
> > +       return msleep_interruptible(msecs);
> > +}
> > +
> 
> What happened to the trying out custom kernel module for
> fuzzing/testing use case you have?

Oh, my bad.  I think it wasn't clear to me that this was the final
conclusion, it looked to me that the conversation ended up with a
number of open questions.

> I'll repeat my concerns. BPF maps and progs are all interdependent
> between each other by global RCU Tasks Trace "domain". Delay one RCU
> tasks trace grace period through the use of msleep() will delay
> everything BPF-related in the entire kernel.
> 
> Until we have some way to give some of BPF programs and its isolated
> BPF maps its own RCU domain, I don't think we should allow arbitrary
> sleeps inside BPF programs.

I see.  How are sleepable BPF programs operate wrt RCU currently?

