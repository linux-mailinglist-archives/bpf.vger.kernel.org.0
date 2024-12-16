Return-Path: <bpf+bounces-47047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74E49F361B
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 17:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA6F1647A8
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494420627D;
	Mon, 16 Dec 2024 16:30:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42054146A71;
	Mon, 16 Dec 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366638; cv=none; b=q7kkTatEYB9F60UaImhPh8X/ZNdr9Ekuglglp1ppZ550TZDj85685+/V7hGJTqmyN3EkZcQ8S72fAI0lmLU5d2bL4liV00nK/pyWrEMmkKANnpMaBsAcvrA/1mXlV6BUtN7Y67+75SnDwEVZOcpFmoLJic6NCNcYU4umuvyipRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366638; c=relaxed/simple;
	bh=sCqdfmo73408B6gVlFr/HnzDiWGiX3aBba9aNEYskhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9ehYkBK5vS8tq25aYE9pzQ5W2wwCKfHNt14XSUjeSNxsaiO6O1luiGzYz3fg1c1oX7RjxHKWG4GRYQVEtGgrNexd4C/D9jHhQLUGItFr7hK2zI0WR3mjg56KRuFN7R1cxuCl1kBZ30o5ubU6AF2r6dR27zzNMVyg3X8RMYhzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F3601063;
	Mon, 16 Dec 2024 08:31:03 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBD003F58B;
	Mon, 16 Dec 2024 08:30:34 -0800 (PST)
Date: Mon, 16 Dec 2024 16:30:33 +0000
From: Leo Yan <leo.yan@arm.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Guilherme Amadio <amadio@gentoo.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 3/3] bpftool: Link zstd lib required by libelf
Message-ID: <20241216163033.GA700645@e132581.arm.com>
References: <20241215221223.293205-1-leo.yan@arm.com>
 <20241215221223.293205-4-leo.yan@arm.com>
 <fa534569-b3e0-486d-a0f9-25523f404aed@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa534569-b3e0-486d-a0f9-25523f404aed@kernel.org>

On Mon, Dec 16, 2024 at 11:23:29AM +0000, Quentin Monnet wrote:
> 
> 2024-12-15 22:12 UTC+0000 ~ Leo Yan <leo.yan@arm.com>
> > When the feature libelf-zstd is detected, the zstd lib is required by
> > libelf.  Link the zstd lib in this case.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > Tested-by: Namhyung Kim <namhyung@kernel.org>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> 
> Thank you! And thanks for the updated commit description in your first
> patch, looks great.

Thank you for continuous review, Quentin!

Leo

