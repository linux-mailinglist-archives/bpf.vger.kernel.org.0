Return-Path: <bpf+bounces-34591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62C492EFBD
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 21:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B66D281236
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 19:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B428C17839F;
	Thu, 11 Jul 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xJ3wwrYJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B614176FA4;
	Thu, 11 Jul 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726599; cv=none; b=Ri9gR8klpjxXxNw1+WAcB2LRgCXgWQ0zhJmgNZvvr10ExRiRCAK5/Swbh0UH4J0vaLPvjWiVAtJlFCG9Uj1NlDnbgCDA9Y4RXpABZ3eMUOxzfzFO6JINjhZoiUGLoH2bSV/5R7OYcPtwvDODhTZm5MnSpkrFD8HJa5lHJh+aOSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726599; c=relaxed/simple;
	bh=CWjV5ZkshnVIKL5DaN+i3TMiIirKXnryXO1FZcmoAX8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sANqouFLvCtK0oQ9M3705z4E515as5ZJlaH29czn7iS9v0ZaLPh9EdliK6QihophQxE/3uzDLFqtpc+U02BU6xzxC5AljmPOXGjnJ2UZhtFMsxFHI5OSrO7gRaOqLhpv5z2HsuOl3341kWVt7IyOchdQsZUcwWEYLS91NrCu9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xJ3wwrYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB793C116B1;
	Thu, 11 Jul 2024 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720726598;
	bh=CWjV5ZkshnVIKL5DaN+i3TMiIirKXnryXO1FZcmoAX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xJ3wwrYJMLG33Dl6VGEtv5RMdGbHxPmCMHgqdradHwUZOJml1DoeRyu8DF2En5k4x
	 WKEvyHrEXVSsMJRLctvEfk77G0BO5cPl5xxPSix9tQlfHcguFjNioAh/vhnz09RNYV
	 W6qZDO1kcOnlKBvGUMO2uFRGQLabtx2bCxvGFpWs=
Date: Thu, 11 Jul 2024 12:36:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Akinobu Mita
 <akinobu.mita@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] revert unconditional slab and page allocator fault
 injection calls
Message-Id: <20240711123637.508e81d2b25ac8e0c9b726c0@linux-foundation.org>
In-Reply-To: <20240711-b4-fault-injection-reverts-v1-0-9e2651945d68@suse.cz>
References: <20240711-b4-fault-injection-reverts-v1-0-9e2651945d68@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 18:35:29 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> These two patches largely revert commits that added function call
> overhead into slab and page allocation hotpaths and that cannot be
> currently disabled even though related CONFIG_ options do exist.

Five years ago.  I assume the overall overhead is small?

