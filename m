Return-Path: <bpf+bounces-35508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D5B93B1E4
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F11E1C234E3
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C9A158DA0;
	Wed, 24 Jul 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu3T/FEI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6C22089;
	Wed, 24 Jul 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828664; cv=none; b=mNFa12er4INYIJYGsGDhYgveeWVWN8o4zzD5/YDu516qAwc0TTY1otFVoG4ng9/PTnSv7rKoyu2A1xyNIim00LgfWyQP0GIXkDwauhW2TUmCgHYU1mFPk1COAXlwTL3JkUjaJUhm2K4ruUfjgIuMezSzSmZ1a05ZocCJpBboDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828664; c=relaxed/simple;
	bh=U1IpdGIm3e5FpXgJZw5veXM4g8H+RADWZIYrXN7ZL3s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CCdFEMvgw//TNh9021TFS0DbH0Iaagu3+1rcbsyZZpgS9beaJx5FwFH0Hts0VGaEsMcrFeCw5FaWjqBP6hnbOuNZ6JZpD5Fgjx/eKeson6ufRtrFTrLct1fCrh5+cz6gsvRQ9VFNQcjZWJJkK67fq0DG2zjExDOaym3aJ1iYvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu3T/FEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EC6C32782;
	Wed, 24 Jul 2024 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721828664;
	bh=U1IpdGIm3e5FpXgJZw5veXM4g8H+RADWZIYrXN7ZL3s=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=nu3T/FEIvv5cwS7hSI3qI/8tclNS1YF1zo1VFTBKjU1vZoL0RrU65SrQRa+uR9NcD
	 v38339sbY1swMAo6kzfXbfeF8QuZeYNlYyP4EZf2KOUN16wOAlcgo6JsGmf3bLQJX2
	 ZMxcV5WKKBOLWjv7sbD6jcvdRyazkXv4vV8lBKF4w+IiRgFz2gb533A8k5ilSiCV8B
	 A3gkL62S9ilKBX0QEG0mAKUZ0gOd/Thtk9+UvboUpxdUVukbUeny7tzyqCzExLX2Mq
	 EQlXyBIFsbQb/968kS3jjOjrpq9qG7hgjHL9vVIjG9G1j464kooISlBJpePg3hyZWV
	 4ydAETA+DEORw==
Message-ID: <860ef013-cb73-4180-b7a8-e3d5042855eb@kernel.org>
Date: Wed, 24 Jul 2024 14:44:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v4] tools/bpf:Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240724111120.11625-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-GB
In-Reply-To: <20240724111120.11625-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-07-24 04:11 UTC-0700 ~ Zhu Jun <zhujun2@cmss.chinamobile.com>
> The format specifier of "unsigned int" in printf() should be "%u", not
> "%d".
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Great, thank you!

Acked-by: Quentin Monnet <qmo@kernel.org>

