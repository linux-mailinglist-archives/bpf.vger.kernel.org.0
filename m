Return-Path: <bpf+bounces-22786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7AB869FFE
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C671F23BC3
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 19:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6F451C47;
	Tue, 27 Feb 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5WhXT9C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79051009;
	Tue, 27 Feb 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061434; cv=none; b=QI3W3/frX94iRZgebjRIjApJ0Fgmy50bwbsIuZzWpPwUYjBBkL4+FQTKGDorjWWpfg85TNuzfagYhnx0NE8FAZq1b/7tuwzEyBSpLEATdBTBmvI3kfOVVZoH/GtFVSogSgCptFSzq90gjDrgajx8sgQ9QB8d1SFbvPNFFWVMZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061434; c=relaxed/simple;
	bh=qBzTwOoOVdZGvWfwhMIPBvViZVyBZ+zCsfhtr7smb0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLLsEVwvwpTGWAqf+z+jM2d0z/wbJIU+qNwKWV4agp2c7JkBlajjYrLe2AAhhX6VTOztKIVysD6F95OzoSVAjZiSXNNynenVkEMRPp5mrQVKA9aCHHng5v8ZJYiScTPWoLTMF6ckfFRwkpsxh6wLYf+WcybsCeJM3dOfLe1xb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5WhXT9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F78BC433C7;
	Tue, 27 Feb 2024 19:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709061434;
	bh=qBzTwOoOVdZGvWfwhMIPBvViZVyBZ+zCsfhtr7smb0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5WhXT9C66TbTBGpzsx6WCAtyUeG0AqvPJZG1FXMdh+28LuTBL+zeb3vuOjb7KVUx
	 HYUZcIM9VtpWtbfBX+XtyT6UE7fdzS/+BhrT4DXCd2qS/syxgJ5ZnrJOYw3GDRLcCI
	 oBEPIm7OgdtStxzhlyU3Z8k+xCkyPGhM2HOfsOGTHfVPVqykWYawWdCY2vcsGsbS4Z
	 EWSI5eEwdDTq1e1CuFUtUcZRwblg9/348rTaXYmhzEyk8MsIRbCSdcNAvDlmgg8nMH
	 m7RGA7DsDXd4fX5u0f9AaOGJfm9mK+T7mhh629m0eQ3njU6Oucjfm3oJMHJB/2NEsv
	 N57HWrvenVhzA==
Date: Tue, 27 Feb 2024 16:17:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
Message-ID: <Zd41Nltnoen0cPYX@x1>
References: <20240214063708.972376-1-irogers@google.com>
 <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
 <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com>
 <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com>

On Tue, Feb 27, 2024 at 09:31:33AM -0800, Namhyung Kim wrote:
> I can see some other differences like machine__findnew_thread()
> which I think is due to the locking change.  Maybe we can fix the
> problem before moving the code and let the code move simple.

I was going to suggest that, agreed.

We may start doing a refactoring, then find a bug, at that point we
first fix the problem them go back to refactoring.

- Arnaldo

