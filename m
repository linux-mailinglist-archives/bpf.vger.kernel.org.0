Return-Path: <bpf+bounces-9819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1695A79DC70
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C801C21267
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319BC121;
	Tue, 12 Sep 2023 23:04:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A833D2;
	Tue, 12 Sep 2023 23:04:26 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C510CC;
	Tue, 12 Sep 2023 16:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8Xnsts4Cfn+cOT3sGgRWXdJJo7XuO0f7Sydd31WHTcA=; b=l1RiQBK7aQEeAsxzffD6ydEe/f
	NM+7cytrM7BkaxV8cbnuaUSMNBrvTLl+1kI6ycPclYye8dQeFhv6BYOZ5d5lDyTkq7p8yRsWccYMq
	nOLM5MDkKFXrsC52KEyCubDJflkn4N4KzOpbwIvg1CK8cVHV2xeX2HXhLWZbjB7Jgqvkw5IfPB2/4
	jnlEVaw8jyP5ATaifqb6WdAKZa8ftjMdlEbrSPwalEPFEKYIdhoeGJZwtWyqW/TQR/kxWH4hdDs5j
	5PRd3ZFf+lSo0hiVCswIub4eXPhFv0buNl6FdPSAq3eSvp599F4IZ2+mb2sAbrNukx9zu++JWJt+3
	FmxzjG+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33570)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qgCQF-0001kz-0s;
	Wed, 13 Sep 2023 00:03:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qgCQ9-000384-3j; Wed, 13 Sep 2023 00:03:49 +0100
Date: Wed, 13 Sep 2023 00:03:49 +0100
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
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Wang YanQing <udknight@gmail.com>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 5/6] bpf, arm32: Always zero extend for LDX with
 B/H/W
Message-ID: <ZQDuVTSycDcjDkvi@shell.armlinux.org.uk>
References: <20230912224654.6556-1-puranjay12@gmail.com>
 <20230912224654.6556-6-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912224654.6556-6-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 12, 2023 at 10:46:53PM +0000, Puranjay Mohan wrote:
> The JITs should not depend on the verifier for zero extending the upper
> 32 bits of the destination register when loading a byte, half-word, or
> word.
> 
> A following patch will make the verifier stop patching zext instructions
> after LDX.

This was introduced by:

163541e6ba34 ("arm: bpf: eliminate zero extension code-gen")

along with an additional function. So three points:

1) the commit should probably explain why it has now become undesirable
to access this verifier state, whereas it appears it was explicitly
added to permit this optimisation.
2) you state that jits should not depend on this state, but the above
commit adds more references than you're removing, so aren't there still
references to the verifier remaining after this patch? I count a total
of 10, and the patch below removes three.
3) what about the bpf_jit_needs_zext() function that was added to
support the export of this zext state?

Essentially, the logic stated in the commit message doesn't seem to be
reflected by the proposed code change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

