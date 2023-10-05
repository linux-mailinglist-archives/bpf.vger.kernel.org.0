Return-Path: <bpf+bounces-11462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B17BA762
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E5D3D1C2099E
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C37038F80;
	Thu,  5 Oct 2023 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r96k5lzF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350B1C2AE
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 17:12:49 +0000 (UTC)
Received: from out-201.mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F681706
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 10:12:48 -0700 (PDT)
Message-ID: <49517916-e848-8dfe-48c5-f2240c6e740d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696525966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vii37jAyx8EVIx/ZlExvw6UxL7OjVsc8nrTRMrjp3jc=;
	b=r96k5lzFgpIu5UgPGWtUScIvT9tdI59KRDq1Qp6uzidmZPtdlClwod3r7UgmImziZRh7HP
	3Ibcgvz4nnaVj6KuXwwl2lCn6lfH4bVJDNfKBBmIhTIogjNg9iAMOWal8BqDZp/crUhCKK
	x+m+tF0+JEyAZqwf6tGdkvGFfl3Z3yc=
Date: Thu, 5 Oct 2023 10:12:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 9/9] selftests/bpf: Add tests for cgroup unix
 socket address hooks
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf <bpf@vger.kernel.org>
References: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
 <20231003093025.475450-10-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231003093025.475450-10-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/3/23 2:30 AM, Daan De Meyer wrote:
> These selftests are written in prog_tests style instead of adding
> them to the existing test_sock_addr tests. Migrating the existing
> sock addr tests to prog_tests style is left for future work. This
> commit adds support for testing bind() sockaddr hooks, even though
> there's no unix socket sockaddr hook for bind(). We leave this code
> intact for when the INET and INET6 tests are migrated in the future
> which do support intercepting bind().
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   tools/testing/selftests/bpf/bpf_kfuncs.h      |  14 +
>   tools/testing/selftests/bpf/network_helpers.c |  34 +
>   tools/testing/selftests/bpf/network_helpers.h |   1 +
>   .../selftests/bpf/prog_tests/section_names.c  |  25 +
>   .../selftests/bpf/prog_tests/sock_addr.c      | 612 ++++++++++++++++++

The progs/*_unix_prog.c is missing again, probably due to the rename. Please 
monitor the CI test result:
https://patchwork.kernel.org/project/netdevbpf/patch/20231003093025.475450-2-daan.j.demeyer@gmail.com/
https://github.com/kernel-patches/bpf/actions/runs/6391271804/job/17346211558

A 'git status' to check for untracked file before 'git format-patch' can help also.


