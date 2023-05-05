Return-Path: <bpf+bounces-113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A056F8288
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 14:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141BD280FE6
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509A4A93F;
	Fri,  5 May 2023 12:04:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B4156CD
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 12:04:37 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0C39EDF;
	Fri,  5 May 2023 05:04:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E468D5C02C1;
	Fri,  5 May 2023 08:04:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 08:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1683288268; x=1683374668; bh=LAgUMsID5w2avzf9PFHv2O+viyYgaFw1o+N
	MLyWqG60=; b=H/bh1YSV4eq+4ZpRFAv55gNbJuhPtakE72182LsFotC8j2DgTIu
	oXRjQ3r1ylDPH9UnBsOZZUYBJmGYmQXCLMb6viGJomasYQWeHOwZ7dDuiEThl3F4
	CyrqrwejtER3OgqzazlYNnLJhDNIoHOb6Mfqd7GOpfW9CUMA/t43ruOSI/KrvBse
	pb800EY/VOQmwZufAWJ/nOZoIJtk1yB1d32srLnvHxD+Tu4pp7JYVsL1sMwg9VHl
	jgmplK0vxqzEjENNnL3IGOgAT4r0JewN+T+3OMNhOPq+Z+TiD9QkcQ2Wws/0LxwM
	fSi/CQ8wBV7wpYIKsNQsKVmOEn6gs86yfnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1683288268; x=1683374668; bh=LAgUMsID5w2avzf9PFHv2O+viyYgaFw1o+N
	MLyWqG60=; b=XylrgE/FzpOkXP/38f7IkiLZCII9CBUuA/C0RjqY0nZtqr0hqGf
	Er7A6zovX6ZSrGHXF06ocW3kOCRuzgOv/xGTpJulhNQTKVfxt29zjaa/G5iJ0lqt
	KjSvcMrONnO05OBuI0KS1as3b1P1THDQtH+bFBQ1TSitaRCdy1iLQZuoZ6uZcCsU
	3fs1C2g2OqupuruP9j2k+QzxXlssNm28Wvpje/URAZ16jYRL1vR/naHswlqJhY+r
	/hSL662sDvMg09gEMJKGchvUNrJO9Iba3QU4HIxjJK13TJGD+HT2B1hke8LID+l2
	Qy3IG/BJhm0l+wH8ALOK1YVSFRQvxAiaVBA==
X-ME-Sender: <xms:zPBUZCenFASlTO_pgLzfRhj3VVhq5d0yCoMby11dH9buDUo_3bu2Nw>
    <xme:zPBUZMNR4nxREst3JYpTtvPollr2prRiNpAkDIFvIyjALP4EVamT9MY--NhAiiTxY
    71yZ2NNPKQ4VngPUNI>
X-ME-Received: <xmr:zPBUZDha9vKFH-z6S4gVhLTI6TvDejELWo4Qgy4zw5DxGonu_EQgHF0zJ_poyXZRFZVX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepkeevieelveeiueekveejgeekfffhffekkeeikeejffdvkedt
    geevfeejuefggeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:zPBUZP8ldsgMnfy2UvAp7WN6LsBGx5BMLD1pUlozbj2itgMI3nc2uQ>
    <xmx:zPBUZOsLyeVqlHCu9HoNlDHUwGFWdpRRYEoe3WzyZN4aXOf85u9fdg>
    <xmx:zPBUZGHR2b64arDeGudEgVNbPolyQvcVusVBFG8xKk7SMuVY2Kvxcg>
    <xmx:zPBUZPluBgGBZ9t0c67HhrGKaSt-vb7M6DnNQK__cSvc9MmKcGMvCg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 08:04:26 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH AUTOSEL 6.3 08/59] bpf, mips: Implement DADDI workarounds
 for JIT
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230504194142.3805425-8-sashal@kernel.org>
Date: Fri, 5 May 2023 13:04:14 +0100
Cc: linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <50FCC591-D86A-46A3-AF4A-DD68D2FACC78@flygoat.com>
References: <20230504194142.3805425-1-sashal@kernel.org>
 <20230504194142.3805425-8-sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B45=E6=9C=884=E6=97=A5 20:40=EF=BC=8CSasha Levin =
<sashal@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> [ Upstream commit bbefef2f07080cd502a93cb1c529e1c8a6c4ac8e ]
>=20
> For DADDI errata we just workaround by disable immediate operation
> for BPF_ADD / BPF_SUB to avoid generation of DADDIU.
>=20
> All other use cases in JIT won't cause overflow thus they are all =
safe.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Link: =
https://lore.kernel.org/bpf/20230228113305.83751-2-jiaxun.yang@flygoat.com=

> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi Sasha,

I think this patch should count as a functional improvement instead of =
regression fix.

Please drop it from stable queue.

Thanks
Jiaxun

> ---
> arch/mips/Kconfig            | 1 -
> arch/mips/net/bpf_jit_comp.c | 4 ++++
> 2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index e2f3ca73f40d6..edc7d8790f1e8 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -64,7 +64,6 @@ config MIPS
> select HAVE_DMA_CONTIGUOUS
> select HAVE_DYNAMIC_FTRACE
> select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
> - !CPU_DADDI_WORKAROUNDS && \
> !CPU_R4000_WORKAROUNDS && \
> !CPU_R4400_WORKAROUNDS
> select HAVE_EXIT_THREAD
> diff --git a/arch/mips/net/bpf_jit_comp.c =
b/arch/mips/net/bpf_jit_comp.c
> index b17130d510d49..a40d926b65139 100644
> --- a/arch/mips/net/bpf_jit_comp.c
> +++ b/arch/mips/net/bpf_jit_comp.c
> @@ -218,9 +218,13 @@ bool valid_alu_i(u8 op, s32 imm)
> /* All legal eBPF values are valid */
> return true;
> case BPF_ADD:
> + if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
> + return false;
> /* imm must be 16 bits */
> return imm >=3D -0x8000 && imm <=3D 0x7fff;
> case BPF_SUB:
> + if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
> + return false;
> /* -imm must be 16 bits */
> return imm >=3D -0x7fff && imm <=3D 0x8000;
> case BPF_AND:
> --=20
> 2.39.2
>=20


