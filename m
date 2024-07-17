Return-Path: <bpf+bounces-34967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51649934409
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 23:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD73F1F221ED
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 21:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF170187857;
	Wed, 17 Jul 2024 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qskNN5cY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EAA4688;
	Wed, 17 Jul 2024 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252616; cv=none; b=Ky/eGJuiTwCwRPagUjzS+9Ac2pJL9KfwgQoE1gP4qbyHHkOhJDkAQNOgH758YXEhYQpQStQxiHOyRvAuuDyeW4pocgAMonIFIDz4YVh3etbleCUuU29solfJvXAd65VoxPb6iQnwlOx3fOY2W3ATEHsyRuXlArqmpckZ72Ws44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252616; c=relaxed/simple;
	bh=OhMZ6JPmmRAQB96lc3+j/NAdZCbcu4mgi9Yk+fU7hYc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=li4OICwY7HeiyDdrxA9lazSwKONa2a8KnkXZPWgv8MmCIHDOYLU/tup6v247s2ibKGj/z4wva4sVRFfi5sJ0u5iROAf8gxN8QASamROzmlli1fc34CjSB2boUEUB4eN7eA0S4bOsKsSfyomW95+3pTFOyudnLUgD79lpbVF3vgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qskNN5cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EF9C2BD10;
	Wed, 17 Jul 2024 21:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721252616;
	bh=OhMZ6JPmmRAQB96lc3+j/NAdZCbcu4mgi9Yk+fU7hYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qskNN5cY8/32q5xajK5X8srmhh3M7uxeR+f4O3QVFaSl0Y/cMDT8nRmEjQ5XYjF/M
	 y2CS5Iipf6I67QhYQSsSeKIEniw7ezKHgu5s8oxRko/auO5sDtTzxC9UyNW25OFt1g
	 dMySQg64gb/DJHfRYVs2OrR3W7DIneq6Ni26b9p2UlLfSOLPAOyzOt9f/13iOBCVUW
	 I/wl1VPUD9OoJ3N2Xa4EslsNb17LL+E9lAPKyFdAuoB07TaKMNtKhSyBKl2XtiKoSB
	 g+ShumMYnHCRxN/k0PsSygRhShOCx+h117HqtJfwANB6ZbLu7f7ffuWLLldjNrmu4w
	 Gvt4z+yVyZeYQ==
Date: Thu, 18 Jul 2024 06:43:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Hari
 Bathini <hbathini@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 1/2] MAINTAINERS: Update email address of Naveen
Message-Id: <20240718064331.834e1359f9c3f285f2dd7eb5@kernel.org>
In-Reply-To: <87sew8wtxw.fsf@mail.lhotse>
References: <fb6ef126771c70538067709af69d960da3560ce7.1720944897.git.naveen@kernel.org>
	<20240716190222.f3278a2ef0c6a35bd51cfd63@kernel.org>
	<87sew8wtxw.fsf@mail.lhotse>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 13:58:35 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
> > Hi Naveen,
> >
> > On Sun, 14 Jul 2024 14:04:23 +0530
> > Naveen N Rao <naveen@kernel.org> wrote:
> >
> >> I have switched to using my @kernel.org id for my contributions. Update
> >> MAINTAINERS and mailmap to reflect the same.
> >> 
> >
> > Looks good to me. 
> >
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Would powerpc maintainer pick this?
> 
> Yeah I can take both.

Thank you for pick them up!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

