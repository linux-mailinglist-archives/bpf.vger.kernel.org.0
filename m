Return-Path: <bpf+bounces-55020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F4A77101
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 00:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3843A9AF9
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE42211A0D;
	Mon, 31 Mar 2025 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zx2ajXAX"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541A21C188
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743461108; cv=none; b=nYmhbSJ0O6KJ/foQILtp54mbW2NdSnZcBOMXv1+tYglHooJgWLqWCpKSwRy7EdOiM+shGBX8XRcVPwxSqsHw/1eGmfnvhTnULS7vkfaareLwJKy9pJ0VHEqx6PXL+m512+czLHv8bSO1FgIQRk77eajICv1MxCQXCkIaaqGv5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743461108; c=relaxed/simple;
	bh=4GUF9RGQCtSfvuNAdauXAgAl8f612VjY80YKNqHmhPg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=PpXNyzd6VaEVqQuc2lO6EIH1UHW83QZJo+wOhvxjnPTjx2Z/+hcNw2Ti0K5lvgU0Qtrou5UkDV5vJrkIkk6RGxYV06LX7Wp0wwCCoUOfYFz8HcG1lS0nmf8UFzrcPRbHGk4ZLJt5L3/P6Uu5A4LbEbSNzeK0qHM0WGGhWlta9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zx2ajXAX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743461103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YNj7l7IZ/dWAKyICg2JZzfB/KWwR6GHByYOJhLbau4=;
	b=Zx2ajXAX1kh2cqLfKEfn7rkYeofs3eCzR7h8wUSnyC7d3xqOuusToCUI5Q25Z7LBZgHu5K
	JoieaWiqzb44c3ywYEnI23R92fl39tNPxiy5DUM8e0MP7aFi7CRwXjF1ynwiuZ31Z9qTcN
	9n3rBMAGWJ7LA4zUUgz0yiYo7Nn3u84=
Date: Mon, 31 Mar 2025 22:45:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <7d55acbf6e6b20f9e8d679883c1e77391e80b304@linux.dev>
TLS-Required: No
Subject: Re: s390x: selftests/bpf are failing on CI
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, bpf@vger.kernel.org,
 kernel-team@meta.com
In-Reply-To: <7adb418e282468fcd5dc10c05790614e622579d4@linux.dev>
References: <7adb418e282468fcd5dc10c05790614e622579d4@linux.dev>
X-Migadu-Flow: FLOW_OUT

On 3/31/25 3:25 PM, iii wrote:
> On 2025-03-31 20:25, Ihor Solodrai wrote:
>> Hi Ilya,
>>
>> After recent merges from upstream, CI started failing both on bpf and
>> bpf-next trees. Yonghong Song and Song Liu submitted a couple of fixes
>> that are already applied to bpf tree, but there are still failures on
>> s390x.
>>
>> https://github.com/kernel-patches/bpf/actions/runs/14163772245
>>
>> Could you please investigate?
>>
>> [...]
>
> Hi Ihor,
>
> Thanks for the heads up.
> I tried this manually with the kernel commit 07be1f644ff9 and the tests=
 are passing:
>
> # ./test_progs -t attach_probe
>
> #12/1    attach_probe/manual-default:OK
> #12/2    attach_probe/manual-legacy:OK
> #12/3    attach_probe/manual-perf:OK
> #12/4    attach_probe/manual-link:OK
> #12/5    attach_probe/auto:OK
> #12/6    attach_probe/kprobe-sleepable:OK
> #12/7    attach_probe/uprobe-lib:OK
> #12/8    attach_probe/uprobe-sleepable:OK
> #12/9    attach_probe/uprobe-ref_ctr:OK
> #12      attach_probe:OK
> Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
>
> So this must be a config issue.
> I'm not sure what is causing __s390x_sys_nanosleep to be notrace, but t=
his doesn't look normal.

Hi, thank you for taking a look. Do they succeed if you run prior
tests too? I remember situations when a test would succeed when run
independently, but fail when running after other tests.

>
> I also see that the newer test runs are green:
>
> https://github.com/kernel-patches/bpf/actions/runs/14182247375
>
> Do you know if something changed in the meantime?

Yeah, I just disabled the tests failing on s390x for now to unblock
the CI. This is temporary.

A little off-topic: it looks like ebpf runners are offline again,
could be due to recent github runner version bump.

>
> Best regards,
> Ilya

