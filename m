Return-Path: <bpf+bounces-21156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6468F848F66
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 17:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304E71C20FEE
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4222EF5;
	Sun,  4 Feb 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZZZLcUX"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5CF2374E
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707065200; cv=none; b=km3ghphOc5g745DBZRAfz62LUoYSqtHMuwp4bVd+kFWOPxMqOg59TofgmAkD0JE7g0YzJ8LKnL+wbUxvcCL1+rQu2T1UxLqRaguugbi3FX2YbAGSdYHcj4wtuJWP62/PaaZlRA4mMmIXtFy5q8lDO4oPruhRCR9/2STfYh5CLuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707065200; c=relaxed/simple;
	bh=IMDqCvmNheaUn4gLo12korkagwSBFbStj2I2rISHrPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJR9fRruBACAJim2HDoAIzuSWCWqeiRq0RubJH2ndpujTi+gG96MyDEAYMFxEo3/oU8V/xQdhGx7Zl50y4AYYVuEGbSs6H9SLNxICBtBH+IIRdhln+ltrTXHh5v3xBKwq3x/MJwzSK7uraVOSbyMEw48FQ8WHxAw7CoXJao6zBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZZZLcUX; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <312cb7c0-f10a-4531-bd9d-532a04b5293a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707065194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMDqCvmNheaUn4gLo12korkagwSBFbStj2I2rISHrPY=;
	b=GZZZLcUX/M383X/pE7Qqu4/UYq+wjzVXlU8wAx5dQy/N362agVzLnditJAfqNXB0MwYH73
	amfo//yWfEVOI5HKgRdlxh7hQ4NYLKTAcAFAxT9c2sduFYkjEhwSN64bZWpvIZwnJ0EW+o
	6qJdAxhX8GfMfMKtuI4fL/4imlH+OR0=
Date: Sun, 4 Feb 2024 08:46:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Suppress warning message of an
 unused variable.
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com, kernel test robot <lkp@intel.com>
References: <20240204061204.1864529-1-thinker.li@gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240204061204.1864529-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/3/24 10:12 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> "r" is used to receive the return value of test_1 in bpf_testmod.c, but it
> is not actually used. So, we remove "r" and change the return type to
> "void".
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401300557.z5vzn8FM-lkp@intel.com/
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


