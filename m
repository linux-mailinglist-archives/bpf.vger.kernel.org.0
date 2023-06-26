Return-Path: <bpf+bounces-3497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3273ED18
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF82280EB4
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 21:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2277C154BB;
	Mon, 26 Jun 2023 21:49:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5314A82;
	Mon, 26 Jun 2023 21:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBCEC433C0;
	Mon, 26 Jun 2023 21:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816175;
	bh=hpK0rbszcXwM0aqV/fAM9k6zUA3q2b9WFoG4zbe4uxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=teoL3iTd7VHqVFZfb24/wcozBy6+g5hCJPhjYgyupsc1xG4Lcsunzor0vvIFrfXxl
	 p1fofHgS1QFRtRBkXLaYgg2RLTW2dUwZ413vBWESEMOsRt1IvTKcB6/N/1E6MJgaW5
	 lWDiCVnbHvEXoejNgu/2TFMIid+GbEDISz5tmaMv8vFtAzfKZ4KBKbDKnHPuIdZ2J5
	 C8lqp5QqXzUxeM9ubpK8uul87Tafz9ttUTXV/WrdImwjiNIsKgeV5wMP77ImqTR+MR
	 MG3kxnGDLpfWJ5tEoeBGzmthZyVK2YAl0U3V13KDmW2sbWAsIXohD2qj+6qdomU9yT
	 QquvwCBqaF6Bw==
Date: Mon, 26 Jun 2023 14:49:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Matthieu Baerts
 <matthieu.baerts@tessares.net>, dhowells@redhat.com, acme@kernel.org,
 adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
 bpf@vger.kernel.org, davem@davemloft.net, irogers@google.com,
 jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 netdev@vger.kernel.org, peterz@infradead.org, sfr@canb.auug.org.au
Subject: Re: [PATCH net-next] perf trace: fix MSG_SPLICE_PAGES build error
Message-ID: <20230626144934.4904c2ad@kernel.org>
In-Reply-To: <CAM9d7che_3z=NgT9OkrNmAQigY3Bo8nv16TVH6fgx8pn76xUbg@mail.gmail.com>
References: <2947430.1687765706@warthog.procyon.org.uk>
	<20230626090239.899672-1-matthieu.baerts@tessares.net>
	<20230626142734.0fa4fa68@kernel.org>
	<CAM9d7che_3z=NgT9OkrNmAQigY3Bo8nv16TVH6fgx8pn76xUbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 14:41:56 -0700 Namhyung Kim wrote:
> > Hi Arnaldo, are you okay with us taking this into the networking tree?
> > Or do you prefer to sync the header after everything lands in Linus's
> > tree?  
> 
> Arnaldo is on vacation now, and I'm taking care of the patches
> on behalf of him.
> 
> As it's introduced in the networking tree, it should be fine to
> carry the fix together.  I'll sync the header later.

Will do, thanks!

> But in general you don't need to change the copy of the tools
> headers together.  It also needs to support old & new kernels
> so different care should be taken.  Please separate tooling
> changes and let us handle them.

Ack, I'm not sure what makes this a special case, from Stephen's
original report:

https://lore.kernel.org/all/20230626112847.2ef3d422@canb.auug.org.au/

it sounded like perf won't build without the fix.

