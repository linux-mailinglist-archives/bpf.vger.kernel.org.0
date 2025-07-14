Return-Path: <bpf+bounces-63270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DBDB04AAF
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C4D4A347B
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEF3278142;
	Mon, 14 Jul 2025 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8zaKZwB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894BC126F0A;
	Mon, 14 Jul 2025 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532200; cv=none; b=cYP7/WonwQp+aHtPReR3MrURNkf662AKxk8EhJ6rmaMWe/aX3NL+k8vpvThfYDgbYEAjiK5ZOdWsOdK9W+dP8THL5U8GJ0r8ns1aj9l1QTS3GgT78ifqsc4Knicit+6zvTKGfFT6cRPGVsuhHBye8/aUQUbyWIInBXtDgz5QNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532200; c=relaxed/simple;
	bh=M0PZUEikwZplgsTp5pCh0WMPeVdma/lYCtz7xVZ+LUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QrVKpsbbnb+qgkKjKnkhVYMF+NmiX4iAt6BUgYDSQHfrjySNCCUCm0UvVaqxGLC2XXLESTjGr5IDY7VH546jNg2OhOXfBdYhW1OMtBF3Zvo3JkpYscQ8YCPhNNFaxuj2SnWlZXudB9l4PDXB5qnaHKwozdoUsKONbKUzDHywWbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8zaKZwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA0DC4CEED;
	Mon, 14 Jul 2025 22:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532200;
	bh=M0PZUEikwZplgsTp5pCh0WMPeVdma/lYCtz7xVZ+LUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y8zaKZwBCt+WmYCbsPSZfpJ1aHjxuSnwRYDxK38vvBBXLhKL9Z7t7mC95INXkyY6w
	 2Xa33caw7jycaGFBrdrHIISwS+Tz2ZdNv8soFBW8IgWZiuuChnNSitx1AmFztQ9ufs
	 SG1lFyyC9rXUWrT35VusMrhEPRy+p0dxTJnznQGNtR8mK+rflEHNg+UjyMmpNMedKC
	 z6XtXzlkhFb9lr7jdYV1Yi+VV5hJO0ZBI2y1DCLAf27oKO2TUG77hg6ah/95uetYu2
	 QTJttpI5RweBPnkW35ojVSVgLghg7skfa2o1v+x/qVxAsacoAaNV/mqxt3WiuZPMj4
	 kamQgOnFJ9ReA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE8383B276;
	Mon, 14 Jul 2025 22:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175253222101.4006958.10212169466412631754.git-patchwork-notify@kernel.org>
Date: Mon, 14 Jul 2025 22:30:21 +0000
References: <20250714180919.127192-1-jordan@jrife.io>
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, willemdebruijn.kernel@gmail.com, kuniyu@google.com,
 alexei.starovoitov@gmail.com, stfomichev@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 14 Jul 2025 11:09:04 -0700 you wrote:
> TCP socket iterators use iter->offset to track progress through a
> bucket, which is a measure of the number of matching sockets from the
> current bucket that have been seen or processed by the iterator. On
> subsequent iterations, if the current bucket has unprocessed items, we
> skip at least iter->offset matching items in the bucket before adding
> any remaining items to the next batch. However, iter->offset isn't
> always an accurate measure of "things already seen" when the underlying
> bucket changes between reads, which can lead to repeated or skipped
> sockets. Instead, this series remembers the cookies of the sockets we
> haven't seen yet in the current bucket and resumes from the first cookie
> in that list that we can find on the next iteration.
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
    https://git.kernel.org/bpf/bpf-next/c/8271bec9fc1c
  - [v6,bpf-next,02/12] bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
    https://git.kernel.org/bpf/bpf-next/c/cdec67a489d4
  - [v6,bpf-next,03/12] bpf: tcp: Get rid of st_bucket_done
    https://git.kernel.org/bpf/bpf-next/c/e25ab9b874a4
  - [v6,bpf-next,04/12] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
    https://git.kernel.org/bpf/bpf-next/c/efeb820951eb
  - [v6,bpf-next,05/12] bpf: tcp: Avoid socket skips and repeats during iteration
    https://git.kernel.org/bpf/bpf-next/c/f5080f612a1c
  - [v6,bpf-next,06/12] selftests/bpf: Add tests for bucket resume logic in listening sockets
    https://git.kernel.org/bpf/bpf-next/c/da1d987d3b39
  - [v6,bpf-next,07/12] selftests/bpf: Allow for iteration over multiple ports
    https://git.kernel.org/bpf/bpf-next/c/346066c3278f
  - [v6,bpf-next,08/12] selftests/bpf: Allow for iteration over multiple states
    https://git.kernel.org/bpf/bpf-next/c/f00468124a08
  - [v6,bpf-next,09/12] selftests/bpf: Make ehash buckets configurable in socket iterator tests
    (no matching commit)
  - [v6,bpf-next,10/12] selftests/bpf: Create established sockets in socket iterator tests
    (no matching commit)
  - [v6,bpf-next,11/12] selftests/bpf: Create iter_tcp_destroy test program
    https://git.kernel.org/bpf/bpf-next/c/8fc0c5a82d04
  - [v6,bpf-next,12/12] selftests/bpf: Add tests for bucket resume logic in established sockets
    https://git.kernel.org/bpf/bpf-next/c/f126f0ce7c83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



