Return-Path: <bpf+bounces-16700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5922B804861
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 05:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C4C281554
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 04:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C2CA53;
	Tue,  5 Dec 2023 04:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bht1qm6e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8463FD3;
	Mon,  4 Dec 2023 20:02:31 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9f72176cfso28742961fa.2;
        Mon, 04 Dec 2023 20:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701748950; x=1702353750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4qYujN8YUPBa0JNq4UyKlX+K5Ufzv+oENh6Wntp8sY=;
        b=bht1qm6eBerJutEyflOG3GXNXxz+sYZR8/ArFmmHMsmQwSLI4HMgFYzD0toJWWt5hi
         IMAljHPyT2ua53eGnawGvOYMdaKG+joWmgTg8Fna+OuspJ+BE0/jLsRpGJrQyUp55lRY
         zaWv4CQiBKHbawfYXBE1zEoPUpLxKp2NtHiZRVt4rqnuzA3Iqwfdy5mN2//bOCaskWLb
         3DlwglbHbozMMgpdQYYCVs2pMKjRCajajl512G4Ro/2ImlK+CVlA1bbDYqpXoXNxQnNb
         4LUK8eIT3H6pH5GBpL+vUPygF808Vm7TEV8V9sgP8nxK/Uw8ui5mEnK/9WfSxJo7MS+s
         kU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701748950; x=1702353750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4qYujN8YUPBa0JNq4UyKlX+K5Ufzv+oENh6Wntp8sY=;
        b=Q6wkk4hZDGOvxIW2GC1rNamxCMg5sUh0NCQ62e8f2pr9j4T+tCzQnRsUYxaNaFAKaw
         qzDYwY8VRkyVVCNttGltzsjqv+YHtHWuKPllQe/tROx7gLT0de3oB8bkKSstQtJEp37G
         9ARtb0rcxhC4hsWDIr24D+pHSv7sIjf5A9UJe4BRu84o70z/KigfvsWrBmcXPkrmDd83
         KaEc8Bzc/yfevMAiu4sh8piU27+iF6QjZTG6neqsGZL67Wo337TcaAtjqdHyg0wlA07V
         9LFg0B8Py7IeFkT7sa/gwCSW0OLxqCBrsrjoqcywz0CSmGf5fN1CsqhG7M9Kgmel4N/n
         huIQ==
X-Gm-Message-State: AOJu0YzRqs4xRcO+SZDRA4JpszHrY1KZriTRf2BW+TXCA0GjYKtlPIGO
	NyNW67TOiNB0k7xWc68eeUw=
X-Google-Smtp-Source: AGHT+IHrIx2fsWidponzd79suuBm27EcmeV4zktJOvf/4l1bUyw4rU/TKKv5cOob2nfnnFf9tcKDNw==
X-Received: by 2002:a2e:a1c5:0:b0:2c9:fde5:a359 with SMTP id c5-20020a2ea1c5000000b002c9fde5a359mr663370ljm.20.1701748949460;
        Mon, 04 Dec 2023 20:02:29 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id q8-20020a2e8748000000b002ca0a1f489asm384152ljj.52.2023.12.04.20.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 20:02:28 -0800 (PST)
Date: Tue, 5 Dec 2023 07:02:26 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Richard Cochran <richardcochran@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: stmmac: EST implementation
Message-ID: <d3e5i54yw5vqcnn67lw6jflgxgkqlsk3witwufoeqfqcf66p5u@7cnxjf2ddaf2>
References: <20231201055252.1302-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201055252.1302-1-rohan.g.thomas@intel.com>

Hi Rohan

On Fri, Dec 01, 2023 at 01:52:49PM +0800, Rohan G Thomas wrote:
> Hi,
> This patchset extends EST interrupt handling support to DWXGMAC IP
> followed by refactoring of EST implementation. Added a separate
> module for EST and moved all EST related functions to the new module.
> 
> Also added support for EST cycle-time-extension.
> 
> changelog v2:
> * Refactor EST implementation as suggested by Serge and Jakub
> * Added support for EST cycle-time-extension

Thanks for the update and especially for keeping your promise in
refactoring the EST code. The series has already been merged in, but
anyway here is my tag:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

* which at least for Patch 1 you must have forgotten to add since v1
* seeing the patch hasn't changed.

Regarding the multiplier and the MTL_EST_Status.BTRL field width info
you submitted earlier:

On Fri, Dec 01, 2023 at 14:49:09PM +0800, Rohan G Thomas wrote:
> Managed to get DWC_ether_qos_relnotes.pdf for v5.20a and v5.30a. But I couldn't
> find anything related to this. So for refactoring, I'm keeping the logic as in
> the upstream code to avoid any regression.
>
>>
>> Also please double check that your DW QoS Eth v5.30a for sure states that
>> MTL_EST_CONTROL.PTOV contains value multiplied by _6_. So we wouldn't
>> be wasting time trying to workaround a more complex problem than we
>> already have.
>
> Yes, I checked this again. For DW QoS Eth v5.30a the multiplier for
> MTL_EST_CONTROL.PTOV is _9_ as per the databook.
>
> Also noticed a similar difference for MTL_EST_Status.BTRL field length. As per
> the upstream code and DW QoS Eth v5.10a databook this field covers bit 8 to bit
> 11. But for the xgmac IP and DW QoS Eth v5.30a databook this field covers bit 8
> to bit 15. Again nothing mentioned in the release notes. Here also I'm keeping
> the logic as in the upstream code to avoid any regression.

Thank you for digging into the problem. It's strange that Synopsys
hasn't mentioned about so many EST CSRs changes in the Release Notes.
Anyway if nothing in there my next step would have been to reach
somebody from Synopsys to clarify the situation and find out the
reason of the change. But seeing it's an additional burden and vendors
reply not that swiftly as we would wish I guess the best choice would
be indeed keeping the semantics as is, at least until somebody finds
that problem critical.

-Serge(y)

> 
> Rohan G Thomas (3):
>   net: stmmac: xgmac: EST interrupts handling
>   net: stmmac: Refactor EST implementation
>   net: stmmac: Add support for EST cycle-time-extension
> 
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   4 -
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 137 ---------------
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  51 ------
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  16 --
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  53 ------
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    |  21 +++
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  22 ++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   1 +
>  .../net/ethernet/stmicro/stmmac/stmmac_est.c  | 165 ++++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_est.h  |  64 +++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |   4 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   8 +-
>  15 files changed, 276 insertions(+), 275 deletions(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> 
> -- 
> 2.26.2
> 

