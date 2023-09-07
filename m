Return-Path: <bpf+bounces-9412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4752B79755F
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6078E1C20B4E
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819712B89;
	Thu,  7 Sep 2023 15:48:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A532D12B76
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 15:48:26 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD48A267E4;
	Thu,  7 Sep 2023 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OoBwAxDpan9uBfWRYsikSiGI5qln4oQ9IXlfWDXOufw=; b=y80+uZ0EYmbQk6lLT3Lep7TBKi
	4vJcAnE3xZIpYzFOHrhBHlX2fWWN20T90ZPYtBr2a8ROFrBGZcNIuPUYf2i50fnnJuOLdfbdx/X/J
	x/6topeBqYe4CGDpu7YBI/2i+RMskTOOqun2DGlm8fflMvp9QP7l0XR9mX6mjAz/uNZMwWZMnOt/+
	D+Qq4tV2JtPjfRbeK8aIRKq1WL6O1/SiPGOkCIe+2OVkXkJdxAsaKhVxmZmo0p/fzg9+0iv9IqXmx
	FbxvwVCH7i7BtLxFWq3cCs/VX8KBg8+0lDmBaH4mOil5RMbdJaMLQiAZgZUnx0c1POtThLUmxr/vq
	jlbD/QVg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49130)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qeAih-0001fa-18;
	Thu, 07 Sep 2023 09:50:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qeAih-0005hW-B2; Thu, 07 Sep 2023 09:50:35 +0100
Date: Thu, 7 Sep 2023 09:50:35 +0100
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
Subject: Re: [PATCH bpf-next v2 6/8] arm32, bpf: add support for 64 bit
 division instruction
Message-ID: <ZPmO26r8zEVo33QS@shell.armlinux.org.uk>
References: <20230906183320.1959008-1-puranjay12@gmail.com>
 <20230906183320.1959008-7-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906183320.1959008-7-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 06, 2023 at 06:33:18PM +0000, Puranjay Mohan wrote:
> +	/* Recover {R3, R2} and {R1, R0} from stack if they are not Rd */
> +	if (rd[1] != ARM_R0 && rd[1] != ARM_R2) {
> +		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
> +		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
> +	} else if (rd[1] != ARM_R0) {
> +		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
> +		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
> +	} else if (rd[1] != ARM_R2) {
> +		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
> +		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
> +	} else {
> +		emit(ARM_ADD_I(ARM_SP, ARM_SP, 16), ctx);
> +	}

As mentioned in the continuing discussion of the previous patch series,
all these cases aren't reachable.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

