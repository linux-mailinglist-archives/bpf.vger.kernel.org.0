Return-Path: <bpf+bounces-53596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C980A57026
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 19:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A36516F098
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856F1241684;
	Fri,  7 Mar 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdHEruY7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133623FC54;
	Fri,  7 Mar 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370999; cv=none; b=dHkFvhk7cZTOP3QnMUCb1ztGxTUcL4bjKLjldZXl7g0S4rLOm4xqgK/3vvOE9ofwgJxnc8YQEG6fX+X21SohHoNzhuqX2KuHPlq5+hD56UePo8JD5+Pc8QPXdrNTOSnw38WisEHoSJMvux6VByUFG4pgk8AirHOGvtJe6/yfGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370999; c=relaxed/simple;
	bh=ZXH2okLBE0BeSrBh4QejUu5/oRBYtptmiPXQENjAf3U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QmoonW1CogSOqSfRwqW+UgoTDjGlyEvK2BX6LfyMU8XEr7/3YWZQe0J3xQrvX+jtH9WZQVXT0cVjiDruJk3dMNn26CMDrWXlrxi1kewCvqiDMLOtXiLlLTuq1TqdSwCqCog6EKTYRFvXHD0TJLIw9n2tlwFwzIcJeVI3un6rvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdHEruY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C0CC4CEE2;
	Fri,  7 Mar 2025 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741370998;
	bh=ZXH2okLBE0BeSrBh4QejUu5/oRBYtptmiPXQENjAf3U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LdHEruY7liWJ4PaP1KCMWUbwvuu0r1fKfYGuCe5rnVJVOBytajd7O4xu/MWZw6HvP
	 BTywmlVKNfQhvmnH3m8mq4hGNH8nm0FrAG6518am7PT8eNUeSNvOKcPcOLBdvYnexj
	 EzAihT7X7aEvfhZ8UoRgi6eLDEm52MXG/XkD8tLj6BSwLxL8ZozV0m4pFB9I6tkx7S
	 zJOlpLYlXnMXsmHO8yrd8EJ3v+m063FrJWbCkCi0GMKxV0DXQOWKU9zsR0I16wEg0c
	 dtuFcbTkTq5f6gEkh9m6ikTQFqI74kdj8j2uTwaQStmyaprreYKC6f6//a+acU7T/q
	 yvyzZatgOiuFw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org, Kevin Nomura <nomurak@google.com>, 
 Song Liu <song@kernel.org>
In-Reply-To: <20250305232838.128692-1-namhyung@kernel.org>
References: <20250305232838.128692-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf report: Do not process non-JIT BPF ksymbol events
Message-Id: <174137099810.213280.18383915542896888005.b4-ty@kernel.org>
Date: Fri, 07 Mar 2025 10:09:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 05 Mar 2025 15:28:38 -0800, Namhyung Kim wrote:
> The length of PERF_RECORD_KSYMBOL for BPF is a size of JITed code so
> it'd be 0 when it's not JITed.  The ksymbol is needed to symbolize the
> code when it gets samples in the region but non-JITed code cannot get
> samples.  Thus it'd be ok to ignore them.
> 
> Actually it caused a performance issue in the perf tools on old ARM
> kernels where it can refuse to JIT some BPF codes.  It ended up
> splitting the existing kernel map (kallsyms).  And later lookup for a
> kernel symbol would create a new kernel map from kallsyms and then
> split it again and again. :(
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



