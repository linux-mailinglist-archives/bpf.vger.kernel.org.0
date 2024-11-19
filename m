Return-Path: <bpf+bounces-45148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A74D29D218F
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 09:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A84F1F22AA1
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 08:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAEF19ABBB;
	Tue, 19 Nov 2024 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWrPn2qx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC46198E6D;
	Tue, 19 Nov 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004855; cv=none; b=grNQt7iHh9ZJFv0EsSrswFxfc0fWKszT1aFSpXvWHfDGdJr0If2lTF48GICgY4h5EtdT/A82o1tCT0kzOAXnfrYhdD1K/sX/9UHZvKR7vfpQvkU2XF6IsiFCO7PFic67qBPL0qPkwelvuNHR/3iA5HXiZ4oybkUoF+Xmkrdca4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004855; c=relaxed/simple;
	bh=KShsYABY0HzBnfzl7/ev4x4qjC+imZSWj7i7D9h2PnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+aolqHzsNJRl+9UdnzMxiLOXeIPkDg8ZhUFWL9xWuNCte5kfiGbmB5EZhjbwfv78Pe+q+2XXn8oXuILcphK5iOlQBrUfC+Ya9bk1MiIj7kB1V1f1JbWp/Gf5BX7Cp14+jopfooZOzMkp6euOR4QFboxWVgdIu586Xg/zVxxyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWrPn2qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF192C4CECF;
	Tue, 19 Nov 2024 08:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732004853;
	bh=KShsYABY0HzBnfzl7/ev4x4qjC+imZSWj7i7D9h2PnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWrPn2qxPTFEKrGqyG5rXpR91zwGLGSWqRqxFgK+W8RbzGEPa3ZZJATPTWTZa5A1I
	 hlXvZuSIV0/LQXQuI09cHnHESrpQ7ymOLfpufsINXyAVQ8+/LN87mSGQanP+CCO1eK
	 SBbu9EAcPFPHilF2t9ebtnxRfGYKko5UyEkrc62vAtoHPDkYG2HUpj63iVZ5JbQcan
	 9+XOql4auL96I33MZlX77/bRh0QeEwl9YO3GrzT3uth61Jar+BtjH8aI5ECOKAiKJC
	 ajdqH0RPeaTcVcGujkOVoYVCQ5YSwgC3sJzUfQ4C8WsXQgJ7d0vDNMrwxWDZSjxsE7
	 s3EwBl4LWOFQw==
Date: Tue, 19 Nov 2024 09:27:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Yabin Cui <yabinc@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v5 0/3] perf/core: Check sample_type in sample data
 saving helper functions
Message-ID: <ZzxL8Od8CAEH4_Np@gmail.com>
References: <20240515193610.2350456-1-yabinc@google.com>
 <CAM9d7cjmJHC91Q-_V7trfW-LtQVbraSHzm--iDiBi7LgNwD2DA@mail.gmail.com>
 <CALJ9ZPML-QNcsJfo6tBMfmJzb=wF1qQsMFTbNvtRwH-++J1a2g@mail.gmail.com>
 <CALJ9ZPNkO=_OKPDwdSY9tJw+AETaAVC2m-1UcWScZ0TaFmHRkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALJ9ZPNkO=_OKPDwdSY9tJw+AETaAVC2m-1UcWScZ0TaFmHRkw@mail.gmail.com>


* Yabin Cui <yabinc@google.com> wrote:

> Hi, friendly ping again for review?

Sorry about the delay, this feel between the cracks. I've applied your 
series to tip:perf/core, nice work and thanks a lot!

	Ingo

