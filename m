Return-Path: <bpf+bounces-9480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C44B4798429
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 10:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A2E1C20C6F
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320F1C32;
	Fri,  8 Sep 2023 08:36:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC41FC4
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 08:36:36 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26C173B;
	Fri,  8 Sep 2023 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bAIlNlhSV1vyCOAvZ0nrlCVU+qTundSRL1Lq1G06UzQ=; b=gTaNmUqodxA7w0bp9tF29M1hyU
	ChQH1P4/YxuWR5GtCnihZaBtrzFmFc4r9ix/MbSbSERy078XQHUTEbxJn0L3vb0hQsKy/ishrdGrp
	PbedoLIyM/F3CEunWh+oFhVx7aD4TxZ0ZroRkj+tjsdE8c925Y62zebaSWEjiUYzxU8MJHr7Z0day
	M9XB22CVADPIZUGLDTtwyDOMXpMiQYjPnTvfO8lghM0kaNqVMtasooz+rLxnxWhFv6rvUQYiVEkM/
	AS4pZasAnWNCQ2Ao4Gr16ZCxqIzYo1MNHIBtw2AM4B7nP/FntCZhHiTGZOMZplg7COE18ojqj9wFK
	hNaIBJ7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60418)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qeWyT-0004jo-0U;
	Fri, 08 Sep 2023 09:36:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qeWyT-0006jV-7w; Fri, 08 Sep 2023 09:36:21 +0100
Date: Fri, 8 Sep 2023 09:36:21 +0100
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
Subject: Re: [PATCH bpf-next v3 6/9] arm32, bpf: add support for 64 bit
 division instruction
Message-ID: <ZPrdBeHZp8nsBsRq@shell.armlinux.org.uk>
References: <20230907230550.1417590-1-puranjay12@gmail.com>
 <20230907230550.1417590-7-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907230550.1417590-7-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 11:05:47PM +0000, Puranjay Mohan wrote:
> ARM32 doesn't have instructions to do 64-bit/64-bit divisions. So, to
> implement the following instructions:
> BPF_ALU64 | BPF_DIV
> BPF_ALU64 | BPF_MOD
> BPF_ALU64 | BPF_SDIV
> BPF_ALU64 | BPF_SMOD
> 
> We implement the above instructions by doing function calls to div64_u64()
> and div64_u64_rem() for unsigned division/mod and calls to div64_s64()
> for signed division/mod.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

