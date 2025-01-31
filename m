Return-Path: <bpf+bounces-50248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8069BA24560
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 23:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B6C18898D4
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 22:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB901F03F5;
	Fri, 31 Jan 2025 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZZ33WyO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE894EED8;
	Fri, 31 Jan 2025 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738363880; cv=none; b=eqwNB1hR7djLCAGResVNPf7QNmokmvxQ0NjrR41yAMZbM7GajKn7KWtJNvwAFkpx0k6zLKNtAKeH/NWUeGtZW+Vvs3K9Pb4W8Jfp3mRxh5WEJbpozV5jh23joTmpWzJWjGXd5/wk6aDoOVs+F20EU6Sr80hqQ7LOjyNLec06Tns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738363880; c=relaxed/simple;
	bh=jOa95FFfZufHLOW8WJbM+fip1bYLf0qW6B7+kDD67no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpzMl8T8MXGAeEkPD3ZcjX/Q/CpbZAp++9y9orlQ6LKAQ4sVI/Y82fjfx1v/9JWH9cp1NKbqN3iMsb/baf2Qn6WRYlmDlVmMAqtWfIVblKjrNlmbXCsVdHyl5R7LiXNLv+LgNpyRjl00monWTER5YVEoret1h0N5ejLfhzdMVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZZ33WyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB85AC4CED1;
	Fri, 31 Jan 2025 22:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738363880;
	bh=jOa95FFfZufHLOW8WJbM+fip1bYLf0qW6B7+kDD67no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZZ33WyOAZqpaeYP1D15OzwWQpAErvGZJ/nqGfRhxvwn8/um93D62FhYlghB0WB/j
	 2OG0TSnqgMyKeqMBmFVdl4EjpM/jUwqNEDUQu+k2ZTq+PZFPxCwidGZiuvYKQ/9PkT
	 N0MrEz8OihYE7OPEMN2Mx46ndW80LflPIyY6nIJqmtfaCKj+OqS+TXajOhLBl0VoCP
	 Vt4+7cDvKL0OP2B1iR9FlGk2uk9ZC0BJHA4qco06W1fUnvxDw3L0hDK6FtcEmQiGke
	 NfMJMTDO2cDiPZhjPROisL3Mrwj9gUcaiaInenNAli+LHts5cLQVveHrizq7XoJnv4
	 TecgnBtkx+vCA==
Date: Fri, 31 Jan 2025 14:51:18 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Tracing contention lock owner call stack
Message-ID: <Z51T5tNkGGbiXZCi@google.com>
References: <20250130052510.860318-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130052510.860318-1-ctshao@google.com>

Hello,

On Wed, Jan 29, 2025 at 09:21:34PM -0800, Chun-Tse Shao wrote:
> 
> v4: Edit based on Namhyung's review.
> 
> v3: Edit based on Namhyung's review.
> 
> v2: Fix logic deficit in patch 2/4.

This change log doesn't give any meaningful info.  You'd better say what
exactly you changed.

Thanks,
Namhyung

> 
> Chun-Tse Shao (5):
>   perf lock: Add bpf maps for owner stack tracing
>   perf lock: Retrieve owner callstack in bpf program
>   perf lock: Make rb_tree helper functions generic
>   perf lock: Report owner stack in usermode
>   perf lock: Update documentation for -o option in contention mode
> 
>  tools/perf/builtin-lock.c                     |  59 +++-
>  tools/perf/util/bpf_lock_contention.c         |  68 ++++-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 281 +++++++++++++++++-
>  tools/perf/util/bpf_skel/lock_data.h          |   7 +
>  tools/perf/util/lock-contention.h             |   7 +
>  5 files changed, 405 insertions(+), 17 deletions(-)
> 
> --
> 2.48.1.362.g079036d154-goog
> 

