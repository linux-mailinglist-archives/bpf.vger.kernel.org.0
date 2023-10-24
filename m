Return-Path: <bpf+bounces-13124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E67D4CE8
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 11:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A75B20F79
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1624A0C;
	Tue, 24 Oct 2023 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32718E27
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 09:50:30 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F7D10CE
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 02:50:28 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99c1c66876aso634850166b.2
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 02:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141026; x=1698745826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OLhZ/2PIt7xVFPx+qBdw/XQ9jguYjepL0mHm+xxkCM=;
        b=q1+rsfwUEU2NgaRsEVE4Wss0iTvkybVW69yIFxFhBxLTERFGTejrRneLfj8FKU5cg/
         htUXmlkKCyDlNoHmLxCSHO3zihPH4ivL1Rih7UAYQqIrACIE8S3RpzGzGcl4cRaWIE0q
         dKaspJgjVdU6qthRli30QQ+jLr90oGY2i3Ngki3N5zsZpiHjDYBZhoARg1xse+CwjeQC
         DMMicD+X6yVe3vwQhL4Z6RzCCO7qZfpupT4X5g/3cSR6g9WEj02fJssZkG2+SMNCgpKe
         LQJG0kV3P2zpcUIRCouFxUk0Vs6hpzsbwj84KGylofZT8QVZnqsJ4HVP299qjfXlglh5
         E98g==
X-Gm-Message-State: AOJu0Yz+uB5FndEz0xLqf9OXp92svUAt5r0C/BQmcy1vN0BbSR+bo0Ly
	oyhjIDknyUA7kw3XjbGlai0=
X-Google-Smtp-Source: AGHT+IHfJidabxRlH49Jck19fVs8SgxHA9LVVWsWttiy14M1nXjDA2ZzMru6Rj7Dxo6Rf6nCTfeTJA==
X-Received: by 2002:a17:907:2cc2:b0:9bd:fe2f:3949 with SMTP id hg2-20020a1709072cc200b009bdfe2f3949mr9807387ejc.51.1698141026264;
        Tue, 24 Oct 2023 02:50:26 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id jp15-20020a170906f74f00b009b2b47cd757sm7911654ejb.9.2023.10.24.02.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:50:25 -0700 (PDT)
Date: Tue, 24 Oct 2023 02:50:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
	x86@kernel.org, leit@meta.com,
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v5 00/12] x86/bugs: Add a separate config for each
 mitigation
Message-ID: <ZTeTXcTy1tsn/msq@gmail.com>
References: <20231019181158.1982205-1-leitao@debian.org>
 <CALOAHbDreP4JpL_C=+mkpwRvMpkVDdE-LNxkN=oyJW2vPjM_GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDreP4JpL_C=+mkpwRvMpkVDdE-LNxkN=oyJW2vPjM_GQ@mail.gmail.com>

Hello Yafang,

On Mon, Oct 23, 2023 at 10:59:13AM +0800, Yafang Shao wrote:
> On Fri, Oct 20, 2023 at 2:12 AM Breno Leitao <leitao@debian.org> wrote:
> >
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
> 
> Hi Breno,
> 
> Do you have any plans to introduce utility functions for runtime
> checks on whether specific mitigations are disabled? Such helpers
> would be quite valuable; for instance, we could utilize them to
> determine if Spectre v1 or Spectre v4 mitigations are disabled in
> BPF[1].

I am not planning to. The check if a mitigation is enabled or not is a
different topic, that also might require some further refactor.

This patch set focuses in the initialization of the mitigation code
at build time. Initializating the mitigation code might not result in
the mitigation being enabled in runtime.

For instance, you can build the kernel to mitigate the GDS, but the
runtime detects that you are running in a guest VM, and depend on the
host to do the mitigation, so, the mitigation might be enabled or not,
even if it is initialized with CONFIG_GDS_FORCE_MITIGATION=y.

Detecting if the mitigation is enabled or not is an orthogonal problem
than the one I am trying to solve with this patch set.

