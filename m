Return-Path: <bpf+bounces-19335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346D82A013
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913FFB22051
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753D4D5A2;
	Wed, 10 Jan 2024 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9qgtmHq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929E4D59E;
	Wed, 10 Jan 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28e31563ebso471815766b.2;
        Wed, 10 Jan 2024 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704910072; x=1705514872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImSW9dJ5OhIFxXDfouCu83AUqDIEdVU3BTvjdmmGKUI=;
        b=T9qgtmHqFwmb29lpzqmFTb+LnA4pb6emAYRhdmI4Gx0QXtGr/b50wkYdyYKGVwcD4A
         /WYu80zBhBOLfTb7DqovOtLaas33f0K+j1R3OEPZd1YYY/vlEAKX9P3X7ttX5xnhxDug
         2gW80drUW5EW1CBpeKnQakunAfOAmCbF6JqbxYQ1xfeEoAUsKTtRYR4Blz3FuO5s8RoT
         yPYPVDuzaWlluvQEtFnzanDZUIDXStMWZIPdsw6sta3xZXhdlPQYLTvvnaQvtT6+zKpZ
         mNY0FItC6hai4zKlKun1x60jLhSKvvXYr8crEhVyUt0K+9CD6wZOHbTZ+AH6WfF1+2yt
         iwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704910072; x=1705514872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImSW9dJ5OhIFxXDfouCu83AUqDIEdVU3BTvjdmmGKUI=;
        b=GAne3IAXP/VhnAXnOxklk7IB+16hmr0o0uFYjlXmHGRFDe4b6MgmS6NNx0Vv0EaiyY
         ISBhVZOWXrnCWgQxpL4dB2jjOjT67nBZv6+Vhkin0nAiR1tJ1bXv3tmA/BhN3eDr8HdC
         +WcClSdy53uS3siXdcRbcwxh9MYw538ya6rzgb6kY9udMRh6VbqQs4VjoTAH4c3L8ldY
         SYp0kjFENYt7VHR+d3C+YTK3G5Jno6OuQDqE4ePcYicc0X6noDfgqrKj0V3NKXQ3IER1
         tOUZCL+T9vKN1ESPa3BvNKFh8gUATXjMIVWJ6mQ8ykn31Z1kq1DksQ5jNSqOdxWEKh8A
         b26w==
X-Gm-Message-State: AOJu0YyOnaFQ3NxGcR4VLel/k8gBpMcY7x3fInRQxWnfA0dv0IlX6pdK
	MmIikuEgQegzHIPgtjxHxos=
X-Google-Smtp-Source: AGHT+IHVmkSlaMO6nXyB7+3eYD0Hr+K1p/Xyu5oUuWWOw8m59EPJYxlo5t3gG4VHD10OXbxzOCmCbw==
X-Received: by 2002:a17:907:510:b0:a26:fb5e:15e9 with SMTP id wj16-20020a170907051000b00a26fb5e15e9mr688896ejb.119.1704910071704;
        Wed, 10 Jan 2024 10:07:51 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709061e0700b00a26abdff0ebsm2331937ejj.142.2024.01.10.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:07:51 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Jan 2024 19:07:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
	x86@kernel.org, leit@meta.com, linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com, bpf@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 00/13] x86/bugs: Add a separate config for each
 mitigation
Message-ID: <ZZ7c9EbJ71zU5TOF@gmail.com>
References: <20231121160740.1249350-1-leitao@debian.org>
 <ZZ5p3vdnTtU5TeJe@gmail.com>
 <ZZ6FwMTRppSa2eOG@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ6FwMTRppSa2eOG@gmail.com>


* Breno Leitao <leitao@debian.org> wrote:

> > Yeah, so:
> > 
> >  - I took this older series and updated it to current upstream, and made
> >    sure all renames were fully done: there were two new Kconfig option
> >    uses, which I integrated into the series. (Sorry about the delay, holiday & stuff.)
> > 
> >  - I also widened the renames to comments and messages, which were not
> >    always covered.
> > 
> >  - Then I took this cover letter and combined it with a more high level
> >    description of the reasoning behind this series I wrote up, and added it
> >    to patch #1. (see it below.)
> > 
> >  - Then I removed the changelog repetition from the other patches and just
> >    referred them back to patch #1.
> > 
> >  - Then I stuck the resulting updated series into tip:x86/bugs, without the 
> >    last 3 patches that modify behavior.
> 
> Thanks for your work. I am currently reviwing the tip branch and the
> merge seems go so far.
> 
> Regarding the last 3 patches, what are the next steps?

Please resubmit them in a few days (with Josh's Acked-by added and any 
fixes/enhancements done along the way), on top of tip:x86/bugs.

Thanks,

	Ingo

