Return-Path: <bpf+bounces-65777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031BB28326
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 17:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84481CC0C8A
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8AF30749B;
	Fri, 15 Aug 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0jhIhth"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906F304973
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272697; cv=none; b=PSEhmZBvPKqWm/MbDQL7/L6C8M3rbcn1P9ROouJQDsP0hHPe6GYQioYDfcgBKpBKd3LxtqqrWCLFfJKjW1RxoPJx4P6uAiiy9CFwJBmIXfBSiojdlKDkctIqJvfRlYd0vQAUBs4h1UObU0WgB3CUIRcjdGIFDjIkfONazffRcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272697; c=relaxed/simple;
	bh=KIUZmfoNkGREawgYSwXqhVJUp1Yt0NKgm6U+EiX/2dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtDLwMr3LwdVsz4no/VtpSBBC6r+9Urrf8nGfW/Qdk4oHvFgMUYAMPgdIDwWFJom7sKnVfaP0xfSOLH9/T14kJTjcCvbKDkUT+AsraI9eKD7TzmLySn2mDiAp3/153CEJXQ/eXsWjM0XimI0JcAjueBv13fCpGZEci/cx+iYpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0jhIhth; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so1842857b3a.3
        for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755272695; x=1755877495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bk1FkmzfimQ0BsQSmDLdyH96T4WWjaBIuywfyIKytfw=;
        b=M0jhIhthw7HZX66bzgcOKAW97RDn0BTm1cVeI1Gbjs+YOZ+xQY47oyxAc0X0QBSx6S
         3nfdSzkVCQT6gxsXBe1isqDK4hzxEAEyv4hzuVjUbKmytd6dFrM0RqQoP7g7X/QCzlN3
         x6f3Z7DRgIFFD/9nef+fwiDsi6qjL3ndh1+kg9gHKICo4TJ9Oy75357j4nd7pL/kNJRD
         9IwY7dxN24xFd4C8Ma9lSBlA7s21F7zI4Lu7/RKXnAL5FZwaZs2EgKk7IpEMg4pVbxX0
         OvHrQjqWdIc3dpj3BEkulIpp++r38rO68rBGx9BfsFrwbenMjLNJUrCn/63rXpL23BEL
         2Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272695; x=1755877495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk1FkmzfimQ0BsQSmDLdyH96T4WWjaBIuywfyIKytfw=;
        b=oiQXKPFEL0xzblTDmdG4OCBeBTtpaaAMJKKf2MQn5l+F/c5U6q2cCRnhZ1+THtqbt+
         0svFoaEb7FZO/FhRxhZ8C3K/ksiQMxii1sFc6EVd0y3tmKj1vo45C8+t97u0lP0wc72h
         UZdSfCdL3Qur/aVk55g69+on2uLE1YCe+VNpOaTMwGhLDxKw70uwfQoKlM2w+yf+QYXA
         wIt5+QxWD543jYVIRgrQhEA5yJUxsJSyshbDU3a1nXh/fGFzzFEPvG4XLes7XDge5vP1
         L3j4A8xiswXQk7QhjY1zz3OYcwkT2qRx4m5y363FTvs0ObyyzCIeT3PW+/0+02HYLiC3
         vJDg==
X-Gm-Message-State: AOJu0YzidnPXLZwe+Is9iQPpJqVsneba76CSQl6VFJs8UhjPFEpKU+xE
	8wUYU+O5hyZlHjn08Jc7yPx0azHvFrNZatw/V3wnwp/3BSz+oMqqO/E=
X-Gm-Gg: ASbGncvQhppOrIZb8eVkD32jnX1cuh92dknZ6nodK43cBl7HL5T2CiATiSOu81ZmAzE
	Kk4IdQvX0GUgRGjVv9kix72OMLfnT5A6Y57f+Wx7FQuvyUYPuptzCLX2NfvlDk8F96RFfZu8wGw
	aMhLxVlUl331hi8EMfPzBBPOwBvJnFrIvBAaIwgAuNpMTb8Au2Q+6f3v9fqife+xIar3SaZygLE
	PK8ol8DM2wqDNoxRP3ZpeNoghSVo/FpFlSIctyd9iaQwYVufkUm3qKRlh2l6EFbW5jNFggyZBxZ
	kGdf2zdS7vYQvjPYFZqDNLMPMF5Zegbtq8hBu1lV0uloajiU/Q18IarMnK5Qv2WueZcSPHx8ZSs
	w3FJ5wegvzQVDnKfDPD/Zw83tuRgdcNIWrQHQPg522oNFvEF1QIvp7RQKWnM=
X-Google-Smtp-Source: AGHT+IH0FoASb30i95PQoBbwelFc7/BvQPhqCgRXee4pH+X14JmKx/BoA4D/srz0RFE/KVmvVsxJvw==
X-Received: by 2002:a05:6a21:6daa:b0:240:763:797e with SMTP id adf61e73a8af0-240d316cd15mr4408897637.25.1755272695257;
        Fri, 15 Aug 2025 08:44:55 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b472d794a39sm1555895a12.53.2025.08.15.08.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:44:54 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:44:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com
Subject: Re: [PATCH bpf] bpf/selftests: fix test_tcpnotify_user
Message-ID: <aJ9V9r4U24phxzQG@mini-arch>
References: <aJ8kHhwgATmA3rLf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJ8kHhwgATmA3rLf@google.com>

On 08/15, Matt Bobrowski wrote:
> Based on a bisect, it appears that commit 7ee988770326 ("timers:
> Implement the hierarchical pull model") has somehow inadvertently
> broken BPF selftest test_tcpnotify_user. The error that is being
> generated by this test is as follows:
> 
> 	FAILED: Wrong stats Expected 10 calls, got 8
> 
> It looks like the change allows timer functions to be run on CPUs
> different from the one they are armed on. The test had pinned itself
> to CPU 0, and in the past the retransmit attempts also occurred on CPU
> 0. The test had set the max_entries attribute for
> BPF_MAP_TYPE_PERF_EVENT_ARRAY to 2 and was calling
> bpf_perf_event_output() with BPF_F_CURRENT_CPU, so the entry was
> likely to be in range. With the change to allow timers to run on other
> CPUs, the current CPU tasked with performing the retransmit might be
> bumped and in turn fall out of range, as the event will be filtered
> out via __bpf_perf_event_output() using:
> 
>     if (unlikely(index >= array->map.max_entries))
>             return -E2BIG;

[..]

> A possible change would be to explicitly set the max_entries attribute
> for perf_event_map in test_tcpnotify_kern.c to a value that's at least
> as large as the number of CPUs. As it turns out however, if the field
> is left unset, then the BPF selftest library will determine the number
> of CPUs available on the underlying system and update the max_entries
> attribute accordingly.

nit: the max_entries is set by libbpf in map_set_def_max_entries. 'BPF
selftest library' seems a bit vague. But not a reason for respin.
 
> A further problem with the test is that it has a thread that continues
> running up until the program exits. The main thread cleans up some
> LIBBPF data structures, while the other thread continues to use them,
> which inevitably will trigger a SIGSEGV. This can be dealt with by
> telling the thread to run for as long as necessary and doing a
> pthread_join on it before exiting the program.
> 
> Finally, I don't think binding the process to CPU 0 is meaningful for
> this test any more, so get rid of that.
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

