Return-Path: <bpf+bounces-9423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDAD7976E3
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF9E1C20C5A
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DC4134BA;
	Thu,  7 Sep 2023 16:18:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5AA134A8
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:18:32 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC25F59E6;
	Thu,  7 Sep 2023 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k88EuUMY0b0fVqwKK7YcLe5ATGkcAlIQr4gjeYVQGL8=; b=h0GtiSVvoU6g32+4BVLdEU6Y25
	gvaqeiWdfEMR0//f+bP7UMCaUE9ZOtW7Xw7IOHS1DebWpigkZ0mXVIBVtZ2uuUcEtF/rHXbJTmu6H
	PtwePEmJxM/fg77yCk8JKKd4QZTl9x1C9U1DoW4HkeqVraQp+dsVoPjo77G8beVqctDXbrprc4UED
	9ieWBvqQzk081qIsjPeY5+s1yXIzDqoY3SiCHtJgNm6miONTqzLO34jynit8W/fXXwosxivBLpwCm
	rl2a8D61Ek4PdEsdvxqXVmNnsVLT1vgU3UTf9GH+f4KTYsrtaCulGRRQQOU+ZWCjmTWFQuAMtWXC2
	qgdzGMBg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42168)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qeAgT-0001eu-2u;
	Thu, 07 Sep 2023 09:48:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qeAgT-0005hI-UU; Thu, 07 Sep 2023 09:48:17 +0100
Date: Thu, 7 Sep 2023 09:48:17 +0100
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
Subject: Re: [PATCH bpf-next v2 4/8] arm32, bpf: add support for
 unconditional bswap instruction
Message-ID: <ZPmOUYBdRxR1/8vw@shell.armlinux.org.uk>
References: <20230906183320.1959008-1-puranjay12@gmail.com>
 <20230906183320.1959008-5-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906183320.1959008-5-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 06, 2023 at 06:33:16PM +0000, Puranjay Mohan wrote:
> @@ -1633,8 +1633,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  	/* dst = htobe(dst) */
>  	case BPF_ALU | BPF_END | BPF_FROM_LE:
>  	case BPF_ALU | BPF_END | BPF_FROM_BE:
> +	/* dst = bswap(dst) */
> +	case BPF_ALU64 | BPF_END | BPF_TO_LE:
>  		rd = arm_bpf_get_reg64(dst, tmp, ctx);
> -		if (BPF_SRC(code) == BPF_FROM_LE)
> +		if (BPF_SRC(code) == BPF_FROM_LE && BPF_CLASS(code) != BPF_ALU64)

With the addition of the BPF_ALU64 case, I'm wondering why this if() is
affected. If you were adding:

	case BPF_ALU64 | BPF_END | BPF_FROM_LE:

then maybe there would be a reason, but the BPF_ALU64 | BPF_END |
BPF_TO_LE case will never match even the original if() statement.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

