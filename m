Return-Path: <bpf+bounces-32087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F223E9074B7
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 16:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA651F21BD8
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA2145A16;
	Thu, 13 Jun 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egs4SJDu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A71459F3;
	Thu, 13 Jun 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287848; cv=none; b=Q2Gl3aJZ2Rxdn2DpW5WzJnZnkHtSYAsN3ThzLa/pwCKZLvaqM5GFp3mBWPN3ccv9wPVwkp3alt/ImBfhT/veitG+lQ2KGAdxNMXlniFZfRZTLEUuAiW8CX6Uailnn3rdTd23NZhcprD7lI3iBMqONxAnqnTTafeyTzSEGvfs/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287848; c=relaxed/simple;
	bh=dv9A01TA9xjZbgc+DNQkcTYDgrGwnMovOaQAcNnXn3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUYSsYWp+NXdzhXUzQImvbkaLX2zeLrmSzukHLiwL3K2E9RQWT3ZW61HFEsl38I+CQ+ZnAAh+7FZSA8icX+SNox7IMviJ5lmk54RgWCaj4pbUCQyN42cZ3J25lXmnP4SoPdnne+79aEvEiWuvejDAaB2Yn2Sijr78bnSMosyBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egs4SJDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D53FC2BBFC;
	Thu, 13 Jun 2024 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718287848;
	bh=dv9A01TA9xjZbgc+DNQkcTYDgrGwnMovOaQAcNnXn3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egs4SJDumCcvLr8/Jqc+1qr2WuYchZktSRDlH1/iIjL9FbXnK0w3AZt6A+HbeaEKK
	 KqydAZbU2Bik7JkZCZvfnEA8aRnbPA/ztR2mPbJCkung14wOFpbM2xmHsJfeV3/QrP
	 hUBJZZc2795HhCLeo/wzKwXATuyl6/BBEWas+N/Q5YmorDTsd02PSLTsyQMxQqFvSY
	 DaKU4z8JZ5rfDFkM6pAfiouYwy1Mkh4AyQhF6n8jWOdzlwQ5UfAlAjMhWKJ0pg0cUv
	 q+DqDzcHt8E41sA+6IPwtwsUJpp5+LhaNwaJ6tQgPwdfhmwXd+RjMrqd1y1Nqbq8n5
	 j2QycU/UMjryw==
Date: Thu, 13 Jun 2024 11:10:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, mic@digikod.net, gnoack@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4] perf trace: BTF-based enum pretty printing
Message-ID: <Zmr94cx8pYvXi9Hj@x1>
References: <20240613042747.3770204-1-howardchu95@gmail.com>
 <ZmrqQs64TvAt8XjK@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmrqQs64TvAt8XjK@x1>

On Thu, Jun 13, 2024 at 09:47:02AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 13, 2024 at 12:27:47PM +0800, Howard Chu wrote:
> > perf $ ./perf trace -e landlock_add_rule
> >      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_NET_PORT)                  = -1 EBADFD (File descriptor in bad state)
> >      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_PATH_BENEATH)              = -1 EBADFD (File descriptor in bad state)
> > ```

> > Signed-off-by: Howard Chu <howardchu95@gmail.com>

And when someone suggests you do something and you implement it, a
Suggested-by: tag is as documented in:

⬢[acme@toolbox perf-tools-next]$ grep -A5 Suggested-by Documentation/process/submitting-patches.rst
Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
----------------------------------------------------------------------

The Reported-by tag gives credit to people who find bugs and report them and it
hopefully inspires them to help us again in the future. The tag is intended for
bugs; please do not use it to credit feature requests. The tag should be
--
A Suggested-by: tag indicates that the patch idea is suggested by the person
named and ensures credit to the person for the idea. Please note that this
tag should not be added without the reporter's permission, especially if the
idea was not posted in a public forum. That said, if we diligently credit our
idea reporters, they will, hopefully, be inspired to help us again in the
future.
⬢[acme@toolbox perf-tools-next]$

- Arnaldo

