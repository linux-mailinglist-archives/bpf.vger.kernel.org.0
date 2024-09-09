Return-Path: <bpf+bounces-39333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57161972053
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 19:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F00B1F244C9
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 17:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563816F8F5;
	Mon,  9 Sep 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OyDIEQ01"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436511865C
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902499; cv=none; b=eqLXZArJ01aCrShmNdbsgARquTr/vCqto60d+4lytAuNnUyzPUIU0hUaUvqrGRBLqXKwn+YXz4RMTKidKfTKqsL2Wq1CQj+p5VxgnC3cRI9SEgE5+74bKrKBC+bJf3aBTTWPJhmmT4olLQkpq1Xwvg7G1blS2xi/CgjE1ry9TUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902499; c=relaxed/simple;
	bh=gNETDG9/uKrKQd87khaJc8sUNTf44Di4z51FtwQrDuI=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=lPKcDOc2sKtjtZAEGAIzJS0GaU+uAZ6fDpcdi6HRb4B+H1GkRHombQkrNpAMspOpwc4F4MTNmfpqxAI+3+kjcIKn8PGf7GeR1HA2gmJEzRakz3kkTknY5dtLBffoouRIeEPbyCXI/0LU47A3PHhIVQgSbngBU0P1HzmrRyb6Vkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=OyDIEQ01; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1725902495; x=1726161695;
	bh=Cob38hEzzx7zGAliutenKvBSphUuVLDtw5PEvdLsxE8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OyDIEQ01buCSo8RoArdgGAcOt5mafzlwQIJIESG4pSlQb7bKev2tA/uCN6xRWWNiK
	 bvIpG4mIuYeATJZQ45TCdtEdcO3lC2le93j4fWMzNgRmmNuEiE+wNTGaYSXx7ci+Vh
	 NM6Y1Swxm9AAu9DHMXn05AuVH0qP6YhnAnS+baHsrj+IzzodKjNClgBsJ2i9RnAmoe
	 ayMNylSYEvhPsxCE89r49jdsn4tNUyu3nouakoYJk/O7rInZucMFZGoMpM+M3j/QA1
	 NVE3tL9t6OaxUMpc+jJ82YyY2RuRTVCmdrYVc4zlGcj0q86dCnAi2tBcmb2OpKDc+d
	 AkcuShvtkjTeQ==
Date: Mon, 09 Sep 2024 17:21:24 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Zac Ecob <zacecob@protonmail.com>
Subject: Kernel oops caused by signed divide
Message-ID: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
Feedback-ID: 29112261:user:proton
X-Pm-Message-ID: 994beece32795725f0b93ddec5c2c54dc2385578
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I recently received a kernel 'oops' about a divide error.=20
After some research, it seems that the 'div64_s64' function used for the 'M=
OD'/'REM' instructions boils down to an 'idiv'.

The 'dividend' is set to INT64_MIN, and the 'divisor' to -1, then because o=
f two's complement, there is no corresponding positive value, causing the e=
rror (at least to my understanding).


Apologies if this is already known / not a relevant concern. 

