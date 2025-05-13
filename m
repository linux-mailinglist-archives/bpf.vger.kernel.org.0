Return-Path: <bpf+bounces-58120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95305AB56AB
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24434A4FC3
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 14:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D24728E576;
	Tue, 13 May 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbvjHWnC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80981531E1;
	Tue, 13 May 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144911; cv=none; b=b1hw3YFKjOXeyyjwwbfxs8/wWQAvni4c8gtf9aCfpFZqCyEbpH04K2AYAjInt2DVzUtyDg4T9SkMA0miGP4Y5uWe6De6dheJr9zVO4xwQTesyf1fw2XYG9GLKP/ika+J62nfc9ALcpZfoifaJOfNcJNi8Of3RK7ifLCXLe+Wd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144911; c=relaxed/simple;
	bh=L+9ualEvGQuA8FcA2AgH6dk6YBfy1El9wfGoDFVDAgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k5KLvrxVENINR0ljyEVb5BlM5t0x1ypkaSr3fumbySuzD+ocBZ748U6QjbTqYox2gKuEZ3FaTjSa6OTzG47V0s0T3FbiKgMskIhDUqCJuppFlgFDO1JtHkVWaNm6mMTqi2pqEIoBt7yPl46P29lM6KxGJrglHInEyEJiDWI33vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbvjHWnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0240AC4CEED;
	Tue, 13 May 2025 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747144910;
	bh=L+9ualEvGQuA8FcA2AgH6dk6YBfy1El9wfGoDFVDAgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qbvjHWnCGIZxVMGnSHSBPF4yeUWTQHHfY1WCPXbmCye0Xzu58I3tDv2+vkxn8DAFe
	 PyeMjYhGXkbylhgJWJv3C/HoPZ2GfSWM4CQy+HLywGo0qn/nGue+J2G2JpFabt8pK0
	 faJvG9w3KarMyCMp6Mde9JQhmAleixESmlmRW1w+1iSnCXRS6LyOi0vlOBDJP7Bmq1
	 pNZNJPqsLkRNhLcB12g4UCja7PHQHc7ZhPgTpBCJx749GUXb0kW2BWGcKHdPOUDqDG
	 CnPvqjCcrdQ5N5mbBIhbXDtdSZGEarebU9ww4aVB+UbFBHNexCklrWXusH3HDdFgRT
	 V6+/1EDg3PSWw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Rong Zhang <i@rong.moe>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Brian Gerst <brgerst@gmail.com>, 
 Borislav Petkov <bp@alien8.de>, 
 =?utf-8?q?Petr_Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>, 
 bugzilla-daemon@kernel.org, stable@vger.kernel.org
In-Reply-To: <20250512152420.87441-1-i@rong.moe>
References: <20250506145548.GGaBoi9Jzp3aeJizTR@fat_crate.local>
 <20250512152420.87441-1-i@rong.moe>
Subject: Re: [PATCH] HID: bpf: abort dispatch if device destroyed
Message-Id: <174714490874.1690070.753423275910575017.b4-ty@kernel.org>
Date: Tue, 13 May 2025 16:01:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 12 May 2025 23:24:19 +0800, Rong Zhang wrote:
> The current HID bpf implementation assumes no output report/request will
> go through it after hid_bpf_destroy_device() has been called. This leads
> to a bug that unplugging certain types of HID devices causes a cleaned-
> up SRCU to be accessed. The bug was previously a hidden failure until a
> recent x86 percpu change [1] made it access not-present pages.
> 
> The bug will be triggered if the conditions below are met:
> 
> [...]

Applied to hid/hid.git (for-6.15/upstream-fixes), thanks!

[1/1] HID: bpf: abort dispatch if device destroyed
      https://git.kernel.org/hid/hid/c/578e1b96fad7

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


