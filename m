Return-Path: <bpf+bounces-66073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DF7B2DA0E
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 12:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE715C05D3
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFFF2E2DE5;
	Wed, 20 Aug 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="lXy/u71C"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285172DF3EA
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685896; cv=none; b=Mb2GwK2f+KwZWtttrZrCftuzy+0rDMN+U6SKErtRvcvL2AgGnEhU3N0NPNC4YnUWw5gogL1yqt1dcq4r3WdycwBEf4zLSdTZzhkQGMMebD+AvbNT5F34XdgIXPRGKiYrOOFKXZkqD5wxRDRRefRXZVw7U15tpa9YjmQgEs3qswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685896; c=relaxed/simple;
	bh=beAMW2ezHFvzf4uMOzEwNmE7NZfp2IITGRpa7snYMEA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=m73CVrHoxL3E0KhavWuu7/v6IC3dDD636Jti0YTQ38/5/MDvf2SJTefepJamt0wDoOv4hsXqipEB8vgniN/Sb81BcWj7qDUZ1rJBHHGwCX4NIniyRmZLx9dsbfIe2XEa2SC/ad7d2oJEo5zgD2uFhwNorRCCbPvEtXmLRJJh6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=lXy/u71C; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [10.128.8.2] (unknown [14.139.174.50])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id DD00244C5F
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755685891;
	bh=beAMW2ezHFvzf4uMOzEwNmE7NZfp2IITGRpa7snYMEA=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=lXy/u71CA0/o+Hzs0j3D4jB8WjslGnJOBPimGgKb92u+0NgOL4Aq5+uiUYrdfQCfp
	 3BVtceLWcq57cgbEF9gm5emq23DPotHZxqt1Y/NTEQkZIA6fFVk7IA154uSaNBZ+fO
	 wLUKnKTepHdUSQOydrxzFNN1aJ0y7K8CLSMDPzHirplOpsJehg1cYI0PTkDNZaI05i
	 FQzWXimZp40C3Z1pbisTpcxZu71cRt8RMF8JESW3kgdY/J37f3v2Nl0YUXugz3h1JN
	 Ja53hBx7CqpVNsYDwQ5bC+Q3i7mMj39zLWT4NijGzhGQSH9cmLbggvjXFiFBp708kf
	 FVi2OjOwX2G9w==
Message-ID: <817fd0ac-5472-466f-ab80-d6a4c810f161@nandakumar.co.in>
Date: Wed, 20 Aug 2025 16:01:28 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of
 tnum_mul
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: bpf@vger.kernel.org
References: <e7cb82ac838e28620324f70907235d2b8c75262f.camel@gmail.com>
 <20250820061512.1072806-1-harishankar.vishwanathan@gmail.com>
 <0ba41cd7-adc0-4c65-b1e0-defd8ebc2d64@nandakumar.co.in>
Content-Language: en-US
In-Reply-To: <0ba41cd7-adc0-4c65-b1e0-defd8ebc2d64@nandakumar.co.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, my reply to Harishankar got detached from this thread due to an 
email misconfiguration from my part. Copying the archive link here for 
future reference: 
https://lore.kernel.org/bpf/c1296815-67f5-4f31-99fe-b9a86bb7a117@nandakumar.co.in/T/#u

-- 
Nandakumar Edamana


