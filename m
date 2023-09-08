Return-Path: <bpf+bounces-9481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06382798430
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 10:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D552819C2
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEAD1FC4;
	Fri,  8 Sep 2023 08:37:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D281849
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 08:37:35 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9941BF1;
	Fri,  8 Sep 2023 01:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m2mOoCZdVj7pmeDm36OhA/JscfgKXxE6u9pjBZaQkDo=; b=FyGArfYvxGSi1Vz2v3YxGyzkWe
	PQ43nPn4Sg5SYPcr65CHtJBC9MrTASzoy7PFvF0X1XxE/s6Kfc/kFeTzNFpsuFdAQfrCXwWHS8FP4
	CRQ3dcpNWnj0slK+Eg360ByChJaR9y/1m6LYs1Q+AXtKNE+xeTX0kaRJlQwinEnViYIDiLnPJWAMX
	ZcXQ/3pcN79rWbpialPHAF0CMs3IwghdolsE8RfjsELzOXeQXq9VSwdtX3PMdTo5WrX89dKY+m4ZH
	285USxApx01x7OL5A+4nU3lt15+7h6qD4okXRs2l4KcrK4LWBykFfMQ24UORt3pHOlvlxy3Ui0LCB
	RcxZv2PA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35230)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qeWzQ-0004k8-2r;
	Fri, 08 Sep 2023 09:37:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qeWzQ-0006jc-WE; Fri, 08 Sep 2023 09:37:21 +0100
Date: Fri, 8 Sep 2023 09:37:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shubham Bansal <illusionist.neo@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 9/9] MAINTAINERS: Add myself for ARM32 BPF
 JIT maintainer.
Message-ID: <ZPrdQEhw4f+TK8TB@shell.armlinux.org.uk>
References: <20230907230550.1417590-1-puranjay12@gmail.com>
 <20230907230550.1417590-10-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907230550.1417590-10-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 11:05:50PM +0000, Puranjay Mohan wrote:
> As Shubham has been inactive since 2017, Add myself for ARM32 BPF JIT.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 612d6d1dbf36..c241856819bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3602,9 +3602,10 @@ F:	Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
>  F:	drivers/iio/accel/bma400*
>  
>  BPF JIT for ARM
> -M:	Shubham Bansal <illusionist.neo@gmail.com>
> +M:	Puranjay Mohan <puranjay12@gmail.com>
> +R:	Shubham Bansal <illusionist.neo@gmail.com>

Don't forget that I also want to review the changes, but I guess my
arch/arm entry will cover this too.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

