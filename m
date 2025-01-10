Return-Path: <bpf+bounces-48573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99D2A097FB
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF43A84B9
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4042C2135A8;
	Fri, 10 Jan 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="YnGjYsjT"
X-Original-To: bpf@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37781A23B0;
	Fri, 10 Jan 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736528270; cv=none; b=YLg73Gy3/m3H3iS5EbN0qF1YNtBwa5zzpdkNANNc1ocrdYELbXx90IcTHwsHOESbKu4+1WJeydP/zfrz+brWDi2KAT9FlWJ3k1X4rhnn0+sWk5hxQS/rFw55mnkIngNm0GsdKDQeDEeyidXmrRlNeZl1vQOECiAzFapzzTALHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736528270; c=relaxed/simple;
	bh=jaR6XyLLItzgBaZXqL3c99zg9I8sWDgj/4VKxw4etDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pi3jHa8QbLiGIIyWBQVHjOY21SPMF6alTubI6Gm8wl1LtrChCwIajF2/0cZ4M5kUTI5G0sRCTUAO/3v7DQslCdPGCnNuvmxRaWp2hgoiAnRG1ris0A4gg9XiUjn+RfMNtUkPH1GVQqKJpAJal9BOA3ZcTfsEEdzIEWoDTLcEIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=YnGjYsjT; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e5946e.dip0.t-ipconnect.de [217.229.148.110])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 9DE8E2FC007B;
	Fri, 10 Jan 2025 17:57:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1736528265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gs792kudWwrIFfcsrnzu9n7RM7ZEPErzN15aiC7Hr0Y=;
	b=YnGjYsjT8MPDY0L5Yg6/p/Eq8aGB7Qnctnw52pTVm3dYOiUC/CkxXZVN9lN/ZJSlQfOU3H
	lQA6Y3I+dZJCpuzlBhRaCdeteOAs0TZd58cQZXySD1ep7GyAtBHby1DAf+V16Z0vnzmiDn
	2T3i6co9bDFHt32WO8h6KEKSqDi4ozw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <864114f2-e2b2-410c-98bd-d9e18da74aec@tuxedocomputers.com>
Date: Fri, 10 Jan 2025 17:57:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Suppress bogus F13 trigger on Sirius keyboard full fan
 shortcut
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250109183723.190507-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20250109183723.190507-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 09.01.25 um 19:37 schrieb Werner Sembach:
> The TUXEDO Sirius 15 Gen1 and the TUXEDO Sirius 15 Gen2 Notebooks have an
> additional "fan" key next to F12.
>
> Pressing it alone sends a F14 key press which can be bound by user space.
>
> Pressing it while holding the FN key triggers two things:
> - The EC firmware locks the fan speed of the internal fans at 100%
> - F13 key press is registered which by default is already bound in xkb and
>    desktop environments (e.g. in KDE Plasma it launches system settings)
>
> To avoid this unexpected double duty of the FN shortcut, this bpf program
> suppresses the F13 key press.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
This patch is also discussed (and more up to date) here: 
https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/166

