Return-Path: <bpf+bounces-21868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899A8853982
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45675282FCC
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B68605BA;
	Tue, 13 Feb 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkAUp+/7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6D605A3;
	Tue, 13 Feb 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847772; cv=none; b=cxwKDRHhvHvfP/fyljH7j+J7aqxiYcg4XzPsKc/khWivyrGPDqE+OiyTSWinoxWpUfYCrIhRkvG4egcVSy0VBxae1507E0KI0/sb9AbXDjqIBAbxzLD8ghFuTQxXygKcL7hdRVRJkNm4Ts44zuqBMq+aeZdCFwsxbcNzb35gQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847772; c=relaxed/simple;
	bh=jHPT/qAi90K3x80LqW4wHfI6oWmG31Izn2I6ZSvWKmk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXlwJ1wZ9ns+JEQ1k3WXiTNfxkE/ejOqkqZ5Vk2ILp2aq8UdAto8bttY3qMvuq0v98qnfq+1IT1nzHP7c8k0DRpAsiOt7Yr3bG1q8mn7mxL3smDqHa0xHDfZIS9YgnsbZool9Zt4wzJE6tjwX97yPeYCy9SxU+mOkIuB9QR2OAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkAUp+/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFF6C433C7;
	Tue, 13 Feb 2024 18:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707847772;
	bh=jHPT/qAi90K3x80LqW4wHfI6oWmG31Izn2I6ZSvWKmk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HkAUp+/7D98agr+WJCnlwfMX8G20ahapk4yzOMv3s7uSqzSPOkPFgFk1CAsEha0GZ
	 RXyu1mVUVKCNcbusshGVB4QB8oxQvI2FTiBMlV0kqQSAnXa/Gb0JhJlSi2nlAt1s00
	 3bdRITlLsdXj1hYM6Lqr5gdeZFv9ajt9mvDIzEd/OZ0fPKot3luILb3nm7kBpE/kr5
	 Z9S46UnP0MdFf6mciU2LFiy9ELIsDS7ga9XZTjtcIu383cYO8nc06Oo8c2GvNpdo9U
	 lvRxSWmSNy9FYrw/XSHrM3K+woGoGXgWVq5Bj5qnkVvpABa00YgzSfR6LBXfrisyS2
	 PHliLn0IanttQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Song Liu <song@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Ingo Molnar <mingo@redhat.com>,
	Artem Savkov <asavkov@redhat.com>,
	Leo Yan <leo.yan@linaro.org>,
	bpf@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 0/6] maps memory improvements and fixes
Date: Tue, 13 Feb 2024 10:09:28 -0800
Message-ID: <170784747634.4188477.9115348718072311064.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210031746.4057262-1-irogers@google.com>
References: <20240210031746.4057262-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 9 Feb 2024 19:17:40 -0800, Ian Rogers wrote:
> First 6 patches from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
> 
> v3. Fix latent concurrent modification bug in maps__for_each_map.
> v2. Fix NO_LIBUNWIND=1 build issue.
> 
> Ian Rogers (6):
>   perf maps: Switch from rbtree to lazily sorted array for addresses
>   perf maps: Get map before returning in maps__find
>   perf maps: Get map before returning in maps__find_by_name
>   perf maps: Get map before returning in maps__find_next_entry
>   perf maps: Hide maps internals
>   perf maps: Locking tidy up of nr_maps
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

