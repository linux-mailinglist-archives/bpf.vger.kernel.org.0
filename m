Return-Path: <bpf+bounces-44056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA189BD2A6
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 17:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEC21C223D9
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1421A1DAC88;
	Tue,  5 Nov 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3O26zMQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE6A1D9A42;
	Tue,  5 Nov 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824900; cv=none; b=jaAhk/3UiT/JxDyyXfrzOtw8fsUfL7mbsHbrt93vJbkbE36Lh1T2DGcMqnfpP1jhIm9kVy//ogMzGFdSyDw3nmCc4Z1XX5EGrSfokeEglMJOA36HYcJFPF/s547fOYrebs3WZc+TWD1zkoYU/4b95DpK06kTz5ss2aTloV9X5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824900; c=relaxed/simple;
	bh=ddhGO9cFAfhI9o6x1Mpa9cI2mzc8RX4F03f85iZjwyw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mm/HA8HAWn/7BZoHRUPQgfeuTEZgnfaNykcv0WKUcTv5MQYlEeVHevUW8EpxROLpZ0khizOE4WVxemrHFyPnieOXnF7R8sEO+sR9sM6Qkm5YhVI88gLfBs+oLi/jPcFXnchW99Vs+KlMqm74qoyA+wRgug18HxarJCYMxXdCINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3O26zMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14B6C4CED3;
	Tue,  5 Nov 2024 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824900;
	bh=ddhGO9cFAfhI9o6x1Mpa9cI2mzc8RX4F03f85iZjwyw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B3O26zMQ+pAyjJdUE4zVO8DVZPhTxSCC3ii5cW9z/gwCG2eOwot9D7FghmkVoDRGf
	 362Dn+vfxF5FrZdblTKfy8JeFRlwdvLn36fbBhncs5cap0bVO5dcQbIELkae4ExMCM
	 J/ZmAWXNjNz1bfKIk4Q1H7wUFG3C86GHJj72kHgKoZv9W+Rk2NX0NkUuiFgnb4xr8J
	 YqLn+xcJ0Z+FttdR+WphS5N/bX1CV32ecqV8kERK0QjICO9U6sXW1PPQEJKrhcg6/J
	 NnWMwm5X9bhzN8Sss+qJKypSL7SKp+ah2iGCygeuckQWx/Eu4XZcQ893XyhOHBHgIE
	 knp0OwLjstinQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, linux-perf-users@vger.kernel.org, 
 Michael Petlan <mpetlan@redhat.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
 mingo@kernel.org, peterz@infradead.org, bpf@vger.kernel.org, 
 vmolnaro@redhat.com
In-Reply-To: <20241101102812.576425-1-mpetlan@redhat.com>
References: <20241101102812.576425-1-mpetlan@redhat.com>
Subject: Re: [PATCH] perf test stat_bpf_counters_cgrp: Remove cpu-list BPF
 counter test
Message-Id: <173082489981.149345.4034112511557410509.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 08:41:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 01 Nov 2024 11:28:12 +0100, Michael Petlan wrote:

> The cpu-list part of this testcase has proven itself to be unreliable.
> Sometimes, we get "<not counted>" for system.slice when pinned to CPUs
> 0 and 1. In such case, the test fails.
> 
> Since we cannot simply guarantee that any system.slice load will run
> on any arbitrary list of CPUs, except the whole set of all CPUs, let's
> rather remove the cpu-list subtest.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


