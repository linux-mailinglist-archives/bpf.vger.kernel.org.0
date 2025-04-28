Return-Path: <bpf+bounces-56830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E93A9EB5B
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7472188C83B
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248725E82E;
	Mon, 28 Apr 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD72F4Pi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353519CD07
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830910; cv=none; b=iVdAX2BTfz9NsGxO3d8q4PHCa7aCz9KRKsIqiEjiCdRAWhZcymijjt9G+hmW2kQJKCfVWlCjhPjOolalyrUKIa5HgvHFm7mvczVhrsslz6AIYOAyg8hJQajZsWiRdPLO5ZbCIA25/RzEGwlHUM4MRBa2iDv+lhdpfBnhQsAzJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830910; c=relaxed/simple;
	bh=gaXr/FlBVU3ERYkwWKBs4eWi0XUK3mSGMtzipa6+gW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyjykE2R8JHLu9I1hukoRK9zUqS3qZjAbd8O25BhxxnBB2dfsE0i3AssRz66p8h2FefRVZb710OeYjaZ1OfnwHRyZOvXTID2YkfM1YkQFKmsowtFCoEKxz1nvOwiYKk5jLHtJr/fZf4NH4KpTJwat6ufaiZZRKwiTqAunDcFz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD72F4Pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C43C4CEE4;
	Mon, 28 Apr 2025 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830910;
	bh=gaXr/FlBVU3ERYkwWKBs4eWi0XUK3mSGMtzipa6+gW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GD72F4PimqPjiRFHoJb041B+77FS0nptY9Mlk4E+pvZoUK5HCMXYxGF9PICs4yVxU
	 l78QtFb6g5clea+hjDxAZ7ppotA/1e1QuxYJUkG5b2xKwT2GkgvW50TIoVurVQYw1Q
	 G+5oe4m/gu4hYtfb23Q4FmbSH3ybvTNmnpQ7atZRHfIIXJi3FZtpUxZF6c2OXdxy0l
	 /Ii1N2rKXP7Nzuw2rV98HDT/Y1GVYbFBW4kEKfBp2/RyrsUSfF+ZvaJtYF52SZIjJR
	 vkW8kRP29zS5XssmBIyWui9DDgS5qJ+ir36QVubc8ShfQyoDmNk04FlHUGv5amfDR4
	 mCVmspiNoBf9g==
Message-ID: <86adf004-b9dc-416c-a7e8-9e2d92b0a469@kernel.org>
Date: Mon, 28 Apr 2025 10:01:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in backward compatibility of "bpftool cgroup tree" on
 older kernels
To: YiFei Zhu <zhuyifei@google.com>, Kenta Tada <tadakentaso@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Ian Rogers <irogers@google.com>, Greg Thelen <gthelen@google.com>,
 Mahesh Bandewar <maheshb@google.com>, Minh-Anh Nguyen
 <minhanhdn@google.com>, Sagarika Sharma <sharmasagarika@google.com>,
 XuanYao Zhang <xuanyao@google.com>
References: <CAA-VZPm4uD5h1FSgJPuqJAkoKFnou4+UZcxXr3B=EScgfK2BYg@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAA-VZPm4uD5h1FSgJPuqJAkoKFnou4+UZcxXr3B=EScgfK2BYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-04-25 14:02 UTC-0700 ~ YiFei Zhu <zhuyifei@google.com>
> Hi
> 
> We've been using the "bpftool cgroup tree" command in some of our
> regression tests, and recently after a bpftool version bump we saw
> this error popping up that was not previously there:
> 
>   Error: can't query bpf programs attached to [...]: Invalid argument
> 
> After a quick look at the code I located commit 98b303c9bf05
> ("bpftool: Query only cgroup-related attach types"), where this block
> was changed:
> 
> -       for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> -               int count = count_attached_bpf_progs(cgroup_fd, type);
> +       for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
> +               int count = count_attached_bpf_progs(cgroup_fd,
> cgroup_attach_types[i]);
> 
> -               if (count < 0 && errno != EINVAL)
> +               if (count < 0)
>                         return -1;
> 
> It seems that it was suggested [1] to remove the `errno != EINVAL`
> condition since it's no longer necessary, but the kernel we are
> testing against does not yet support  BPF_CGROUP_UNIX_CONNECT, and the
> syscall from count_attached_bpf_progs returned with errno EINVAL,
> causing the function to fail where it previously succeeded.
> 
> Would it make sense to restore that condition or is there a better way
> to fix / workaround?
> 
> YiFei Zhu
> 
> [1] https://lore.kernel.org/all/e7ca0725-9cf7-49e3-b362-93430e3c649f@kernel.org/
> 


Hi, I think it would make sense to restore the check on EINVAL indeed,
thanks a lot for reporting this. Would you mind sending a patch?

Best regards,
Quentin

