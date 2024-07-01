Return-Path: <bpf+bounces-33498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C5991E115
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E611C2151B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AF15EFAE;
	Mon,  1 Jul 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scHpz+h6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B9715ECEA;
	Mon,  1 Jul 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841603; cv=none; b=TAatlxL3dwtvNAGa6xAEdFH+uca21wwZQETcCUUB1R/XVmMGYG3vXxtwhzBzjF/r8K7lF1lVCJFDBPNWfRRooAZ+YOPsGLQ3Sajc9FUdnYbV9gMZf9uji9AK4HtCILW18OJhYQ8BMb37lznpO4bB4v8IxjX4TmRYTTBw4ZpXnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841603; c=relaxed/simple;
	bh=yOQivT421DdQX+XSo94Vz7zP0uqqGn78GjmZjtGzag0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=STqons4msoPnMWCODFU5GQ78bixSE2KrwLhBgOeI/Kd2p8nbHfyjXTxSSyAAhsGxniZ/GAQFcti/Ri83j09DvwCmOs+yQj/jhQMR2mQEmsQ3ql60NVcYDZx/8jy8T5sGmW7tlhunrL9bBs84OGUzKqS8FNSThZOiQyr2Lb67FPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scHpz+h6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85064C4AF0D;
	Mon,  1 Jul 2024 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719841603;
	bh=yOQivT421DdQX+XSo94Vz7zP0uqqGn78GjmZjtGzag0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=scHpz+h6Lz1YehXmBFKh9rL63zhAPmrNkaQr2mlu+DlDh8CooF5S1ErqqYVDbxg51
	 NHFyanz6QNMKz71yWimnAeRmMFQdjYg4HZKPZKnRlxH3CVDmFRNIL0fwfkSWruNPyg
	 k70H/9Rx3sOl/Q7o4aD88whsmSu1kq5B/94nrxhYrbac2DxGO453/IUO2tilh/UFBh
	 01lri0KPw5QtNxD30/16l0d0JkaPYMhiw28nAfyEhnBlM5/N0b5pGuNqmmni9vA4TW
	 RRb/eJ8Wa85oWK0LP/onAK8zkk5k1brI/P0XetMvTIUWR0pIZMeckWhK6yYvEXL3hj
	 YCJHLEngYJGCg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>, 
 K S Iyer <kumar.s.iyer65@gmail.com>
In-Reply-To: <20240627-import-bpf-v1-0-0dbcda4a5b1f@kernel.org>
References: <20240627-import-bpf-v1-0-0dbcda4a5b1f@kernel.org>
Subject: Re: [PATCH 0/6] HID: bpf: import some more fixes from udev-hid-bpf
Message-Id: <171984160126.804118.1988566013648655002.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 15:46:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Thu, 27 Jun 2024 11:54:16 +0200, Benjamin Tissoires wrote:
> This is a batch update to sync up the testing directory of udev-hid-bpf
> and the kernel. The development happens there, and once we are happy,
> we merge the bpf there, and then sync up with the kernel.
> 
> I've added all of the signed-off by from the various authors, as we
> require them there as well.
> 
> [...]

Applied to hid/hid.git (for-6.11/bpf), thanks!

[1/6] HID: bpf: Add a HID report composition helper macros
      https://git.kernel.org/hid/hid/c/8a89db51873c
[2/6] HID: bpf: add a driver for the Huion Inspiroy 2S (H641P)
      https://git.kernel.org/hid/hid/c/09c555faedb8
[3/6] HID: bpf: move the BIT() macro to hid_bpf_helpers.h
      https://git.kernel.org/hid/hid/c/c4015aa7d8fa
[4/6] HID: bpf: Add support for the XP-PEN Deco Mini 4
      https://git.kernel.org/hid/hid/c/f03741540dba
[5/6] HID: bpf: Add Huion Dial 2 bpf fixup
      https://git.kernel.org/hid/hid/c/9b52d81115db
[6/6] HID: bpf: Thrustmaster TCA Yoke Boeing joystick fix
      https://git.kernel.org/hid/hid/c/f58e7f404da4

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


