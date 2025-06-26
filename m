Return-Path: <bpf+bounces-61695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC281AEA48C
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7623D4A0345
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404A82ED859;
	Thu, 26 Jun 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAUVqbDU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9322ECE8D;
	Thu, 26 Jun 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959685; cv=none; b=n4kehmzM+qVDytFAwvko3SDTrQkJ86zgaunpBmG6pZxBGiwquvsH38V8jl9sgYFHSw4wScQW/7zQyXJwfaZ4piRkYKGYzOP8vr7M7/89H76xH6jei05aquEDD3PE/Cy+5fv4TGc2jtgoYYIDswcrgo+fB14jhSNQ9kCqp0hpppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959685; c=relaxed/simple;
	bh=ahu7b8h0/NS1zVvXZWP+eDKOIDBXGlxQOOeuTnPcU5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WpeLfD+CUKAx73/T9hMyJhuZIlwUppq1wmoI2Va5TMC68929BeRjIGaHRh3uEFNkgMhpkVxhuI/gaiwUccsIeKttON5saJCgW4BV5ZAe3OirW4qTg0JlPem5GeD9ou2tpFjAlizkkPzjc48BbFyDy/a+Ku2q8kKBu9pPu70mCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAUVqbDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11182C4CEEE;
	Thu, 26 Jun 2025 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750959685;
	bh=ahu7b8h0/NS1zVvXZWP+eDKOIDBXGlxQOOeuTnPcU5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZAUVqbDUZD+a0kiN0Om7EaZvqcvUG8kOiE6BCVsV6rTd/pHhyhgEfih95vYm3zS7a
	 /paQaeusn1W+w3mcMoLEqh3lRHmVMgKZVC3n2mtzO/2CjR/D36hUlTQ/CMep4B2w2p
	 RQ7oZnpgfesHr1bqEG9O0ZU9S9GHrPM324Q6HcYjMkvuK+Sctn+VH6Fn9DAF5dnBW6
	 fu6goiF6T3Eu322AplhVrjrfnKjqCT+z7pxGsNcsjBJW8lfx9SGrin4Grde/nrlvdv
	 GQ3eovw7RFjTDpqhbWIIVBuK7ZlOTj9TOKNtcPv1UYXBnY88Wg5si3sUmaX1IOGLYS
	 7pSleJtyTCh9Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, Nick Terrell <terrelln@fb.com>, 
 David Sterba <dsterba@suse.com>, Collin Funk <collin.funk1@gmail.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 bpf@vger.kernel.org
In-Reply-To: <20250623-james-perf-bash-tests-v1-1-f572f54d4559@linaro.org>
References: <20250623-james-perf-bash-tests-v1-1-f572f54d4559@linaro.org>
Subject: Re: [PATCH] perf test: Change all remaining #!/bin/sh to
 #!/bin/bash
Message-Id: <175095968503.2045399.16026333437061068793.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 10:41:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 23 Jun 2025 10:00:12 +0100, James Clark wrote:
> There are 43 instances of posix shell tests and 35 instances of bash. To
> give us a single consistent language for testing in, replace
> all #!/bin/sh to #!/bin/bash. Common sources that are included in both
> different shells will now work as expected. And we no longer have to fix
> up bashisms that appear to work when someone's system has sh symlinked
> to bash, but don't work on other systems that have both shells
> installed.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



