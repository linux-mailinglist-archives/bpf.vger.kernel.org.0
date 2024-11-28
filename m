Return-Path: <bpf+bounces-45835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00D9DBAC2
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 16:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1759B2185A
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331DE1C1AB1;
	Thu, 28 Nov 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6ao+QXc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82171BD9FD;
	Thu, 28 Nov 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808453; cv=none; b=XahGQ5vTbws3cDdlFNUfGxARq0Ww2Sz2ltn4iFTDNFfL519NtdxbzQcz+4aHDatdT3NXN6gBZ41hfy01QQwJimXzJetcv/ugLHeLn1YY9UG/F0KTim0nPwQPmsYawyB5EQEnXxO0n0N7fcP+ZFZdQX5AJ86aG5LxTveveB4b9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808453; c=relaxed/simple;
	bh=UR7vF5PqkAdhNcTPHVzsRHePQQ2+prD6qzugAOvNmGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TPT8z05n6Wz2JBoNwK0/TTywvA54VcY5AuO/6xMB3Z4+ImY9t8bR8oKX7/uaFLY62c/nuFdDvifOK0LV65phMjd4tDu5fC7UbY3IJCxq5ZMpW3yFTPDoNXEG6ffb8yb6CvYvqGbjrRG6ASjsbIdMdCtaJlidtLMMmJ7z1NXvgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6ao+QXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366AAC4CED3;
	Thu, 28 Nov 2024 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732808453;
	bh=UR7vF5PqkAdhNcTPHVzsRHePQQ2+prD6qzugAOvNmGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G6ao+QXcYIpzG2c8oMzk/86NCcDmnDqdQdgO2/SL/Y0XIMj2XDdaaEULRiHNjc5TF
	 XCcDTxfsfxZEeOscT/L8Zsqlky1rlmNM89fAbvGHp0srFxjmcGPmSn3uF51pvvdz2Y
	 rI5RL25anWrC6SXHbxNu5zBaxK+gD2WMpCc3YU7C5VZBIpO/RS5WmLZ6H7HQ2l0Bck
	 qXGDBzP9Ae1r8mt6MsctytifOWFZURDWWlDSAgxxkaQkRK/XLoQclxURxESfnqLUna
	 14S6lm8q15nDDjUbxIgi1HW6LvP+r8kbhbQsxxmf/FWrXRJ6N7xDXyA+h/V4mbb3XX
	 Rgg3jbSvaGLYw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
In-Reply-To: <20241127-hid-bpf-cast-v1-1-f26424960e84@weissschuh.net>
References: <20241127-hid-bpf-cast-v1-1-f26424960e84@weissschuh.net>
Subject: Re: [PATCH] HID: bpf: drop unneeded casts discarding const
Message-Id: <173280845196.2348538.17672290510533481005.b4-ty@kernel.org>
Date: Thu, 28 Nov 2024 16:40:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.1

On Wed, 27 Nov 2024 17:42:47 +0100, Thomas Weißschuh wrote:
> In commit 33c0fb85b571 ("HID: bpf: make part of struct hid_device writable")
> the const qualifier was dropped from struct hid_bpf_ctx::hid.
> The casts are now unnecessary.
> 
> 

Applied to hid/hid.git (for-6.13/upstream-fixes), thanks!

[1/1] HID: bpf: drop unneeded casts discarding const
      https://git.kernel.org/hid/hid/c/0b1b0c112437

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


