Return-Path: <bpf+bounces-19319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F498299E1
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 12:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9D61C21AAB
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 11:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8E447F57;
	Wed, 10 Jan 2024 11:55:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7544038DE0;
	Wed, 10 Jan 2024 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2a1a584e8bso407307166b.1;
        Wed, 10 Jan 2024 03:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704887746; x=1705492546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4iKGaZccjg1i1z4b53D4lvLZtxTImDFeDZiPP01Gww=;
        b=ovDBX8WblbhXjSPwtaRmGoKQgRAC824TN9Vl+ZK8ptUaeraLeFbIPmnwQ35ID05vpQ
         1eOkfHAIesecTZEXCQcJk03bBxynWhCAJVElkZTsOmEXCXp+KV1ZVZ1hsN0gz4nHVOkU
         CBDQ37i4vu9Guff5+n46lU8SVaVqpJJwbd0/D8i3Oufhg6pEfyCikQwbmW2/yn08X/2f
         zAr8kOYllFgbYK6PZutssGMdPKXFs189iaopKM6OtO2+mlhxKeswAJ5QKLT6OYmN2qcA
         S1j2PjHmirK7UJp+bROxFFCwGtnCaq/u7H+XHUiGAoiPbrmfib+ux/9q/EbXSRMlSzUc
         702Q==
X-Gm-Message-State: AOJu0YxA+EsnFeuXQ1eZwbGM6XJxH8KPRTMaXElgrzVNd4fMz6BlXcNS
	V/03Oh3fHWpo+7vtbYYlRbU=
X-Google-Smtp-Source: AGHT+IFmAe2+SZr6Pc6/cb4mqYYBt0goGvCGNC6eFy+acfj9VZH4n6c910KO3L9RmEJ0pZnI3SKBAg==
X-Received: by 2002:a17:906:16cb:b0:a2b:9f69:95b8 with SMTP id t11-20020a17090616cb00b00a2b9f6995b8mr475672ejd.76.1704887746594;
        Wed, 10 Jan 2024 03:55:46 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id ld12-20020a170906f94c00b00a2362c5e3dbsm1998949ejb.151.2024.01.10.03.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 03:55:46 -0800 (PST)
Date: Wed, 10 Jan 2024 03:55:44 -0800
From: Breno Leitao <leitao@debian.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
	x86@kernel.org, leit@meta.com, linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com, bpf@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 00/13] x86/bugs: Add a separate config for each
 mitigation
Message-ID: <ZZ6FwMTRppSa2eOG@gmail.com>
References: <20231121160740.1249350-1-leitao@debian.org>
 <ZZ5p3vdnTtU5TeJe@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ5p3vdnTtU5TeJe@gmail.com>

On Wed, Jan 10, 2024 at 10:56:46AM +0100, Ingo Molnar wrote:
> 
> * Breno Leitao <leitao@debian.org> wrote:
> 
> > Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
> > where some mitigations have entries in Kconfig, and they could be
> > modified, while others mitigations do not have Kconfig entries, and
> > could not be controlled at build time.
> > 
> > The fact of having a fine grained control can help in a few ways:
> > 
> > 1) Users can choose and pick only mitigations that are important for
> > their workloads.
> > 
> > 2) Users and developers can choose to disable mitigations that mangle
> > the assembly code generation, making it hard to read.
> > 
> > 3) Separate configs for just source code readability,
> > so that we see *which* butt-ugly piece of crap code is for what
> > reason.
> > 
> > Important to say, if a mitigation is disabled at compilation time, it
> > could be enabled at runtime using kernel command line arguments.
> > 
> > Discussion about this approach:
> > https://lore.kernel.org/all/CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com/
> > and
> > https://lore.kernel.org/lkml/20231011044252.42bplzjsam3qsasz@treble/
> > 
> > In order to get the missing mitigations, some clean up was done.
> > 
> > 1) Get a namespace for mitigations, prepending MITIGATION to the Kconfig
> > entries.
> > 
> > 2) Adding the missing mitigations, so, the mitigations have entries in the
> > Kconfig that could be easily configure by the user.
> > 
> > With this patchset applied, all configs have an individual entry under
> > CONFIG_SPECULATION_MITIGATIONS, and all of them starts with CONFIG_MITIGATION.
> 
> Yeah, so:
> 
>  - I took this older series and updated it to current upstream, and made
>    sure all renames were fully done: there were two new Kconfig option
>    uses, which I integrated into the series. (Sorry about the delay, holiday & stuff.)
> 
>  - I also widened the renames to comments and messages, which were not
>    always covered.
> 
>  - Then I took this cover letter and combined it with a more high level
>    description of the reasoning behind this series I wrote up, and added it
>    to patch #1. (see it below.)
> 
>  - Then I removed the changelog repetition from the other patches and just
>    referred them back to patch #1.
> 
>  - Then I stuck the resulting updated series into tip:x86/bugs, without the 
>    last 3 patches that modify behavior.

Thanks for your work. I am currently reviwing the tip branch and the
merge seems go so far.

Regarding the last 3 patches, what are the next steps?

Thank you!
Breno

