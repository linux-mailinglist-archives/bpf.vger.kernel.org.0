Return-Path: <bpf+bounces-78872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC1D1E653
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B04393029BA2
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C028394486;
	Wed, 14 Jan 2026 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuuK1kw3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3786387576
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390035; cv=none; b=lxzg9uNOysDTcxlIbUnIIAFVwlnnbDzYIKIeXkdwHju27gn7O6+yn5ULDyptCFdQ6fvZwvh9AKtzdu5AOzfVSD4J4q3BFWO6IrV4oJQZRyQwJBod8TvP6Js7xSNDJ1pDv/gZKCLRMjEOkc6WaSy16Fltut500j17ak5s2jjyNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390035; c=relaxed/simple;
	bh=TjRPWgqhyUjPxRvze8WCNnZOW3HL1hS/GHohlno25Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTVMMKJSdYVbrDclbbN4qObOMv9+Sgcv9UMsOZwJVRYgDbzERemoK6GNBMzuY/M3yJDQoyGr8rwv6f+G3Ja17F00gSgSNd+atg3EoMzBHA+FtAeyhJqi5UgRbzDm1c/SJvWJlxdm+IIIkeh7m+yit+X8qlIBd371cZtgn+YdLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuuK1kw3; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1233bb90317so24423c88.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768390033; x=1768994833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjRPWgqhyUjPxRvze8WCNnZOW3HL1hS/GHohlno25Xk=;
        b=EuuK1kw3ln98NcxEvqpQnihIP/lbx7LmyHR407dyTlVgL+F8pg9U1SblXUXJckqCvD
         xVb/O8LlYLoyPpqeXR2LK+uMvvaQM19jxy5fjetbYmPc95jEyDKDlCkKs1/+WdaQm2zv
         a4+PZdiBjwMlFEtXZxbytbd7M8C/8Lb4Zp+788Puv8619SYETJvl7iBvsQTC1OT6o438
         FIwkhjLJYRstQ9QQmj5tURP12Hf+eu7KmGhJMY5fSHUYQPECWQp/dwEdE/S6edUdzbFy
         F0pjLje7bByK57HFT4oxv9YhH7Mg9MJtxBlne8PgDCExqvtdKWJP+KPwSYsWzHkdScel
         vEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768390033; x=1768994833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TjRPWgqhyUjPxRvze8WCNnZOW3HL1hS/GHohlno25Xk=;
        b=tx4DItibu17xyS0uOWbZ1Mk0YTTXi+PDyl6LTbAKD+wYXAKDEqFWCoVgStPrBELRMM
         DLDpGiwnuJ6sVnYqLu31A8a3HqtsmablhdTbquFtVGHK4PjqhhNlDzk7QYN56CBw0Chr
         MuCHX3TPpL7F7piscAettFkiR+hFHV0I71BaP9YbarnE1Y01WKi9q30CfvhhrMSB2yUT
         brJLZO/muCSp9U8BoX8nWMMyoyp/r1NsH6MaYpSQ4W+LuAlQvdEadNfJeY1933seJsDF
         Davt3JBOYucco06WGsDVcuXX2HizqBdGikD97MLsOZL84WedsflchxT+EILRxODZdsVq
         tfbQ==
X-Gm-Message-State: AOJu0Yzf+43rWBhx3cYhEphYPRxVRkwtuNAaI3H8gyWn+QPL5W+f+kHO
	kaKmCER4N/vHTTSZjq+91SIkymGyJRWKoe8L/5r1nLcTHwbpOoJDfpEKPV/ygFnMeo0BFWhfyff
	A/We/MMm18fYunBP9G1EOYL2EePWEa5E=
X-Gm-Gg: AY/fxX7UdL1qiwmj+qPEbIsrx982ie5sUi1wjG4HTxP554m7i6ROwpH32Zre4YMIusv
	4j3W05wggjD5XWmpbBfsEMzeQ8svnuU32WSg8YV3kmK2f4lrvsVjlbeBfUpKzYcNiq8v80vVE6l
	fuatPNV3n06hTMr05XS194AvWnc3AyY4q6lMnn+NTbQKZ9CGZDv0bjwbK3meM84K5g7ODKfsWtP
	JV5QrURdaYzcKFbD/N5n3SZTld43eyiZFB73n1xUNYvl+pasY2b8j2qlXZH0J5d5j23ib6V
X-Received: by 2002:a05:7022:f68a:b0:11e:3e9:3e91 with SMTP id
 a92af1059eb24-12336ace7a4mr2799488c88.26.1768390032943; Wed, 14 Jan 2026
 03:27:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com> <87h5so1n49.fsf@toke.dk>
In-Reply-To: <87h5so1n49.fsf@toke.dk>
From: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Date: Wed, 14 Jan 2026 20:27:01 +0900
X-Gm-Features: AZwV_Qjjv2mgU3MAbDzDUxus_gdzmGv4n2OIWAE_fPClkKO4Y6-3eK2vn3SEat0
Message-ID: <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry. I did not know it as this is my first time contribution, and
did not check it.

What about introducing a structured metadata extension area between
xdp_frame and BPF metadata in packet headroom?

Below is the example memory layout:
Current (after redirect):
[xdp_frame 32B][BPF metadata][unused headroom][data]=E2=86=92

Proposed:
[xdp_frame 32B][kernel_metadata 48B][BPF metadata][unused headroom][data]=
=E2=86=92

But, the problem that comes to my mind while thinking about this
solution is that
additional 48 bytes of headroom beyond the 32-byte xdp_frame would be consu=
med.
WDYT?

-Sai

On Wed, Jan 14, 2026 at 7:53=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com> writes:
>
> > When packets are redirected via cpumap, the original queue_index
> > information from xdp_rxq_info was lost. This is because the
> > xdp_frame structure did not include a queue_index field.
> >
> > This patch adds a queue_index field to struct xdp_frame and ensures
> > it is properly preserved during the xdp_buff to xdp_frame conversion.
> > Now the queue_index is reported to the xdp_rxq_info.
> >
> > Resolves the TODO comment in cpu_map_bpf_prog_run_xdp().
> >
> > Signed-off-by: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
>
> This exact patch was submitted before by Lorenzo[0] and was rejected
> with the argument that we shouldn't be adding more fields to xdp_frame
> in an ad-hoc manner, but rather wait until we have a more general
> solution.
>
> -Toke
>
> [0] https://lore.kernel.org/r/1a22e7e9-e6ef-028f-dffa-e954207dc24d@redhat=
.com

