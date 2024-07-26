Return-Path: <bpf+bounces-35742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BBA93D73D
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 18:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117CA1C228C4
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8C517C7CD;
	Fri, 26 Jul 2024 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V5i8zv2C"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4128DCC
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722013143; cv=none; b=mTGjTj88LJ0zNO5xk+ssgCQ5dRU1EOeIer20pye9WoblxUPhY0wDUHG0Hr4tsMHTZp3ln9jCOTGyqXl/LMz85baRQXQZkg83krTGjMpKLxULfuEBUu3ICmHJZN1w8sMVrCdRAeP/7LRPFYpYovzLr76eI7tP497PQC6kW5Duw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722013143; c=relaxed/simple;
	bh=ckFjhxBtKaQbq8JRIVByyXVebct9aJJ1dpU0RfTlqWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YY5X2cD4FhFCI3Bk+m6PjUFlmxZpqVd+o1Lw7XPIgYh7l6J/c4X186llwKLzw0d3BFhCEw6dtiW5wT8YEOqEGpTJhwj1v882SjFz5zLWLt3G6FVhjVma4yNgQJkGUzHUgBnbDxa5WWkXOfPCsdUNt/CngXfB0rkmLP9W8Z5LbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V5i8zv2C; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ab6fbc6-2f05-4bb1-9596-855f276ab997@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722013138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckFjhxBtKaQbq8JRIVByyXVebct9aJJ1dpU0RfTlqWU=;
	b=V5i8zv2CmuZ0/rB9t2ZcP4FQ9J50yEUpNzXIcgWO7yUBqyk3+AnWvIIQW8yZJlLctzN7s4
	Ku3Y5WepsoSoyfKNkvpwXl84AmhyPFWcdQt0dgPK3n1lXVdE8wDUoxI9Hwn+nrVbk/+FER
	5KzXg79KMbWDD0KvMV2A3yvi2xbZTbs=
Date: Fri, 26 Jul 2024 09:58:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: perf_event_output payload capture flags?
Content-Language: en-GB
To: Michael Agun <danielagun@microsoft.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
References: <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/25/24 6:42 PM, Michael Agun wrote:
> Are the perf_event_output flags (and what the event blob looks like) documented? Especially for the program type specific perf_event_output functions.

The documentation is in uapi/linux/bpf.h header.

https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L2353-L2397

  *         The *flags* are used to indicate the index in *map* for which
  *         the value must be put, masked with **BPF_F_INDEX_MASK**.
  *         Alternatively, *flags* can be set to **BPF_F_CURRENT_CPU**
  *         to indicate that the index of the current CPU core should be
  *         used.

>
> I've seen notes in (cilium) code passing payload lengths in the flags, and am specifically interested in how the event blob is constructed for perf events with payload capture.

Could you share more details about 'passing payload lengths in the flags'?
AFAIK, networking bpf_perf_event_output() actually utilizes bpf_event_output_data(),
in which 'flags' semantics has the same meaning as the above.

>
>
> Thanks,
> Michael

