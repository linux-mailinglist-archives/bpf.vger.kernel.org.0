Return-Path: <bpf+bounces-74419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67952C58BCC
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD14335ECFA
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA03030ACED;
	Thu, 13 Nov 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j/dChqOh"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C32F7AA7
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049739; cv=none; b=QYcco0tE7O73uV9LHHwe6mxnOlBVoHRT5/oSnv1fZWSd2zQJiRjNQYBzU2dJ7EMycdVQjjCePGGAXYHqR6/2yFDhID6WP9Nhgwl227sICY0EWSJOzfAvBFQTGicHsqr/Wp/xwjUjHXC0NZ0LiGc31VlATfiKouxBhB1ecMjuWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049739; c=relaxed/simple;
	bh=nHpn1t5ceNIv/uJedoNZpxDlLGnoEkiRUprh6a9Zl3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjiQDvyC1G9OOpS7wxkcFXRzkDgdDMriOxLoHrETYQW6LyoGXt33EGyBFjDRaNrhqJ4zC02zUlJeVvAb9kXaOZpkh1pNzNrwk1zLXsejU9b7NQAl738qShhwUIzBiJqt5Br13NwB9/6hqK267Hl0Cslq1CUF6vicV7KER4PvPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j/dChqOh; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c41372ad-1591-4f2b-a786-bc0e19f8425c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763049725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHpn1t5ceNIv/uJedoNZpxDlLGnoEkiRUprh6a9Zl3Y=;
	b=j/dChqOhWFcOEKzssE4nHa9MiepW7VPaW2caSlwjSo0q+QyNtp7l560tC6ZGBHAKxYsspH
	S8ry6G3MYJpiTN3rGnKQThtd/lHfodvWIZJttxosRIVTaZeVtirH99WtbOd/QFbm+eEBfU
	+aQntCudQxtuP9LBfYLLoGA23wGnbU0=
Date: Thu, 13 Nov 2025 08:01:38 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/2] bpf: Hold the perf callchain entry until
 used completely
To: Tao Chen <chen.dylane@linux.dev>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251112163148.100949-1-chen.dylane@linux.dev>
 <20251112163148.100949-3-chen.dylane@linux.dev>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251112163148.100949-3-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/12/25 8:31 AM, Tao Chen wrote:
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. The perf_callchain_entres has a small stack of entries, and
> we can reuse it as follows:
>
> 1. get the perf callchain entry
> 2. BPF use...
> 3. put the perf callchain entry
>
> And Peter suggested that get_recursion_context used with preemption
> disabled, so we should disable preemption at BPF side.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


