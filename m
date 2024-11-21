Return-Path: <bpf+bounces-45370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7439D4D12
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 13:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F76284184
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4B51D5CE0;
	Thu, 21 Nov 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Koq8fBdb"
X-Original-To: bpf@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1B1ABEB4;
	Thu, 21 Nov 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193013; cv=none; b=UYnpqiqpEwW3L9y0z5v+FoC66MAx2jIEPj1sd/wR1j6cp85ZhudfaGAen9dph8O2K4eZSD/T+d8rpZBv2+BWr8hHcslilUj2jXh6eEijbtnxQ+YaJA3eysUWDfyWOmSlC7hBQruyOKlEKXRVIlCNLJBWs92s+ljHdA+2U7fINEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193013; c=relaxed/simple;
	bh=3FPDB5pFeWxuDSHiNmldsGsFExH+uW+NjpX/k8a1w88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SL1nvEpTF5qREvFNxVB4tpqGo4jcewuiUQH7gSie0TG/GvQkgWZpjw1p/y4/aDztdY/HQFQLLaa7a9DGTIcDIL0LJ4zIf9zp69kbzW07NvyuHnWpQV+Kd3w56XjODNFDM9JfttrjrmAaTEjeFFypMH0H4C4eb+evMGf9rvkrC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Koq8fBdb; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 506EAFF80A;
	Thu, 21 Nov 2024 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732193001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SX5vBeR5C2vKqkoX/I6HuAICDcxDqtOoNYVDzuGK2uw=;
	b=Koq8fBdbLPYY8sXDJr7FHMU//D5yRm2pcCerAJcBT5/Bg0n7MhSvr1i24Fxwi5640MDXaB
	a4LhPK0NUW6MCRad2k370LektpUIhRWXEJQxUGKJQYRB0B1wa10KeDniSvWU3i4d1Z+O8w
	RltvZm6girO1IBDWflGz/3znRnotHpklpTh5HDq3ej3d5Kx0S7W1otKlq1EFyOaBgYMu5Q
	IOkdpuw9M/RxT9hhhg+lezeGmhKwRD/aC/2CM7asWX+DlPzaArsuDOe9jq3vsMTRiDTafq
	ebtEvLNDOoZ5Rfg//8hRil4U+b08R0yXVEexJcHp8BQJh4Qz6ASHVXDBQzGC8A==
Message-ID: <edfccd59-007c-411d-8ca0-17bf3b9f1f43@bootlin.com>
Date: Thu, 21 Nov 2024 13:43:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix the wrong format specifier
To: liujing <liujing@cmss.chinamobile.com>, qmo@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241121121712.5633-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20241121121712.5633-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Liujing,

On 11/21/24 13:17, liujing wrote:
> The type of lines is unsigned int, so the correct format specifier should be
> %u instead of %d.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> V1 -> V2: Fixed two other wrong type outputs about lines

This commit changelog line should not appear in the commit message. This is
still useful for review though, so you can keep it in the commit by using a ---
separator (see other patches on the ML), which will make it automatically
trimmed when the maintainers will apply the patch.

Thanks

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

