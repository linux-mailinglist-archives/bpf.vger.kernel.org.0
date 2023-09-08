Return-Path: <bpf+bounces-9479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9FC798422
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00382819A7
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC2E1FC4;
	Fri,  8 Sep 2023 08:35:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCD7E9
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 08:35:22 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F8E173B;
	Fri,  8 Sep 2023 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nlXYeDkgqdEWDoL9g1us3S9iH/v3r5oCkU5/ox/kGTs=; b=ExIYtBWMcLwufDORWjo+AhWUX/
	MBg+qQEB0Ojx4Wz4w7uxeSbo/rxuNI70ZeCi31y4y1nMNlbzr+cMlFivk9aBg+nOdufsuBPZ/ApoK
	b9JLteaPz0zFJMVSwIak04Vo7WjKuk2sJZrzOJm4Al/906iy7DbisAI2Qs6zXg8zuIQU/9wPZnWFb
	pTBD6yrwBpcMefCdGt3cS5anLOLGiHcH7DLNx0qLvBfKJ7UXnhHABe4OpUW8L0wsrsgNP/vhWxf4n
	RINiib4ATxD7jCrhesfIuwPFeglcDihj+hN3lluToCC7/JR3Uy7wLfKXhA9qtB5nMw2UmK9KMmjOH
	SFbGJRjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35434)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qeWww-0004jT-1o;
	Fri, 08 Sep 2023 09:34:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qeWwv-0006jO-Li; Fri, 08 Sep 2023 09:34:45 +0100
Date: Fri, 8 Sep 2023 09:34:45 +0100
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
Subject: Re: [PATCH bpf-next v3 4/9] arm32, bpf: add support for
 unconditional bswap instruction
Message-ID: <ZPrcpZyHWsF+g8DR@shell.armlinux.org.uk>
References: <20230907230550.1417590-1-puranjay12@gmail.com>
 <20230907230550.1417590-5-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907230550.1417590-5-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 11:05:45PM +0000, Puranjay Mohan wrote:
> The cpuv4 added a new unconditional bswap instruction with following
> behaviour:
> 
> BPF_ALU64 | BPF_TO_LE | BPF_END with imm = 16/32/64 means:
> dst = bswap16(dst)
> dst = bswap32(dst)
> dst = bswap64(dst)
> 
> As we already support converting to big-endian from little-endian we can
> use the same for unconditional bswap. just treat the unconditional scenario
> the same as big-endian conversion.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

