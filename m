Return-Path: <bpf+bounces-77551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9297CEAF6D
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 01:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22193302921A
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 00:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3E21A0728;
	Wed, 31 Dec 2025 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CN4c/cgQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3F19F13F
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767140956; cv=none; b=LkA256EjKAJxdsyS7/bFWNQOLKFpUlh+AqdPqkIZ7U/EmFA/EWpElNQE8gMvoQlgQ+1kMBySs/tTG1fzZ6B7VLe5r9BoeApE0tN6vhX2SHFBII2ycF35kKDltsj3+Vdk0yimoY0sjaMG6mgBldwagnkbV78k/L6eSmmpYw+z+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767140956; c=relaxed/simple;
	bh=15ICW73KVhuAlu61i5qNM0mcwffa26obfmQBnWlEZUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXj17gBaIQGtSkVVysY9iMLpyvlwnBidPHleHHLZxYhHZBumFFeoaD5/lMnI7nmYEeesAb1bGQZ8xx/9sSjjoPgQhdkXYC+wJAVlJn7ZIAqfFSDj+sPmqpvHuPEKxhGuD+/dEHxWdly5B7fQC6o8H3CR5fHuv7rgRJUEDr6UPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CN4c/cgQ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b24678f-b2eb-4139-8fe1-0834c8c8b75a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767140940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptXwDTCaK6ovB3BEaXkKwky5ITyBb7mrkOQOmGqq/MU=;
	b=CN4c/cgQePYijuUb8rRQVJiLgZpUjHOaW5DFgIQbLMqe4TviIHm5qCJuufACfixORJz9Lu
	jOkAQEA/y0h6+q2HMbqte/KBDpz2CdTHKQ8nr06+8Od67oi6+y4fnHWuBbUfF3PX7xvFga
	0/K8sYyxJeio+Fs7P5O1H1RTKhQfguQ=
Date: Tue, 30 Dec 2025 16:28:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] resolve_btfids: Implement --patch_btfids
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 nathan@kernel.org, nsc@kernel.org
Cc: bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, martin.lau@kernel.org,
 yonghong.song@linux.dev, clm@meta.com
References: <20251231000702.1625600-1-ihor.solodrai@linux.dev>
 <bba828ccd8d2ef3871375809d56c8d66c161bc453f03df80090dc03cf31f50aa@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <bba828ccd8d2ef3871375809d56c8d66c161bc453f03df80090dc03cf31f50aa@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/30/25 4:26 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 2cbc252259be..1269efa06853 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
> 
> [ ... ]
> 
>> +static int patch_btfids(const char *btfids_path, const char *elf_path)
>> +{
>> +	Elf_Scn *scn = NULL;
>> +	FILE *btfids_file;
>> +	size_t shdrstrndx;
>> +	int fd, err = -1;
>> +	Elf_Data *data;
>> +	struct stat st;
>> +	GElf_Shdr sh;
>> +	char *name;
>> +	Elf *elf;
>> +
>> +	elf_version(EV_CURRENT);
>> +
>> +	fd = open(elf_path, O_RDWR, 0666);
>> +	if (fd < 0) {
>> +		pr_err("FAILED to open %s: %s\n", elf_path, strerror(errno));
>> +		return -1;
>> +	}
>> +
>> +	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
>> +	if (!elf) {
>> +		close(fd);
>> +		pr_err("FAILED cannot create ELF descriptor: %s\n", elf_errmsg(-1));
>> +		return -1;
>> +	}
> 
> [ ... ]
> 
>> +	err = 0;
>> +out:
>> +	elf_end(elf);
>> +	return err;
>> +}
> 
> Should the file descriptor fd be closed here? Looking at elf_collect() and its
> cleanup in main(), the pattern is to call elf_end() and then close(fd)
> separately. Without close(fd), error paths that reach 'goto out' after
> successful open() and elf_begin() will leak the file descriptor.

Correct. I missed close(fd) on the happy path.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20608784032


