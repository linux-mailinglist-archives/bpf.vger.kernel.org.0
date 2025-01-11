Return-Path: <bpf+bounces-48613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C2AA09F89
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 01:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F33188F185
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 00:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D949E1442E8;
	Sat, 11 Jan 2025 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="sTAQbxKq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE34438B;
	Sat, 11 Jan 2025 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736555582; cv=none; b=iYOLGhFA23sm595ezDfLEeoc62jIAzM2JOp0+bAsB/Ppjjlo+dmAxfts6TPAqLEtHdZq0obaugAITP0u66XPxxmz/NA4eFBEJDG8aY9JFIHbiAH6IasJLF8KtSM+gSYv59uXXkBTx1dKF+NmguuyGyko/kjV0wwqqM0Juk7aLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736555582; c=relaxed/simple;
	bh=25j4ReVWvYVrz70/PkFeTq3motJ9L8xmi/a7PAXD5Bw=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=ZKtXDQ/rIzJuDixNIbIG7lcEzTmktgd63+qVVXgt8i+WCXi/hn3vKn5pbnAq/qJpLTPuVTleRxlv8X4+2RFX6yvIMDZr2U0ljtUR154r79yLz/No0NXjWELq+Mnbl3iNsNZ+S7V+IfDDJboPHEL+6Lh9Yu6sax339o4MzNNM0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=sTAQbxKq; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1736555579; x=1768091579;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=25j4ReVWvYVrz70/PkFeTq3motJ9L8xmi/a7PAXD5Bw=;
  b=sTAQbxKqn77tFY0FIL9GAZUbMIGn/SwplP+YkxdcH/csxfrLK75tVMN0
   rLOO0L/vHFmnziA/zyv2raQtH85gC0YiJRAHAEtvBPD/IZByk+i5UXnGz
   ncC8a5doI+8cST5W8RNyUyxrlpqOMu2267tWnbrbR+dj4AFptFsypvJ6P
   E=;
X-CSE-ConnectionGUID: BTRKIuMcRPKtuLR45pj1uw==
X-CSE-MsgGUID: udmhc1+QRfKFrLX4r62V6g==
X-IronPort-AV: E=Sophos;i="6.12,305,1728943200"; 
   d="scan'208";a="28483944"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 11 Jan 2025 01:31:53 +0100
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <CAEf4BzbO=R-=4a2s8OF0Vhs+L4g+z0bwLm4q56eVRoWr6m5Zrw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
References: <20241211220012.714055-1-ariel.otilibili-anieli@eurecom.fr>
 <20241211220012.714055-2-ariel.otilibili-anieli@eurecom.fr>
 <26180f2e-1ef7-45de-8e9e-f08a4e6a6d36@qmon.net> <2f7a83-67659b00-a301-5cf12280@99585095> <CAEf4BzbO=R-=4a2s8OF0Vhs+L4g+z0bwLm4q56eVRoWr6m5Zrw@mail.gmail.com>
Date: Sat, 11 Jan 2025 01:31:53 +0100
Cc: "Quentin Monnet" <qmo@qmon.net>, bpf@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Shuah Khan" <shuah@kernel.org>, linux-kernel@vger.kernel.org
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <45fce-6781bc00-f9-4f02af00@63714014>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/1] =?utf-8?q?selftests/bpf=3A?= clear out Python 
 syntax warnings
User-Agent: SOGoMail 5.11.1
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

On Saturday, January 11, 2025 01:23 CET, Andrii Nakryiko <andrii.nakryi=
ko@gmail.com> wrote:

> On Fri, Dec 20, 2024 at 8:28=E2=80=AFAM Ariel Otilibili-Anieli
> <Ariel.Otilibili-Anieli@eurecom.fr> wrote:
>=20
> Seems like this was never applied, right? Ariel, can you please rebas=
e
> on latest bpf-next, add Quentin's tested-by and reviewed-by and
> resend, so BPF CI can do another run on it? Thanks.
>=20
Thanks for looking onto the patch. From this link, I can tell it was ap=
plied on bpf-next. Right?
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit=
/?id=3Dc5d2bac978c5

Regards,
Ariel


