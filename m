Return-Path: <bpf+bounces-34349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD892C8EB
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 05:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2D91C22270
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C941C28683;
	Wed, 10 Jul 2024 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnN+dntD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B21A28D
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580790; cv=none; b=tHPZDXtyMUgTpVpj9XwR8bm0D/DbSjBL6oh4QYab7T5WK8BI2asFbTbhr9B0300hDEL36/9LmG0Q6Ls8bg3rUp88dy348s/LI0OkSWIwzo97SEhBBhEbsZdzQEdUfeiVERwNbcJhG6+nqFMGgthfWgHThU7mU0Xd0/AwnYdZGNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580790; c=relaxed/simple;
	bh=5azJ6KWYWB3A45UjNNNKYxm8pcJdGfId5IURMc3exVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJIKA7KedWHPuJVihtbTTJsCCu6zy3CwOiwVgf+E9H9NMkaX5xR37e6kKw98zEwe33Xvh7Gt3/JuSvLejWqlLBFrm7tpqhn0hEjuxzQ4i+6+OKvBlU4ehrzN8ZM6YQRt7icHUSpz3LUvnAFr4gD/4rjcIxpjQTZiuKE7+/41kUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnN+dntD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c983d8bdc7so4309904a91.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 20:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720580788; x=1721185588; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5azJ6KWYWB3A45UjNNNKYxm8pcJdGfId5IURMc3exVA=;
        b=cnN+dntDTkLnRM+qNVdRfuIHeRtD/8p7+c98xigDesC75x0HyZIFMAPiL3HzN5q3e7
         OWatS9dhBbbFMqFav7cqMrHEa+tHO1lF1rjWJORzG/MC0VAfFh/je7naKhsPnR1qe/54
         RjYJcE1jM8HJlPq7h8lL34m7duAlkJXsD6X/Pfjq8GDjDkvVShMYeIBuIn6Dd9xhHBDc
         iU03qMU9aP9LzKygS3cgK9xcKVwoqHoZiahQH+TY6UzVLswmEwh+7s/i6q2hDUuAu6va
         ya3SRQUIePgMhJszhLJVuI0vY2kGzgyY5MmrIz1LHbuAQTq/q9PCPfoRrpnunN4+Sh91
         AejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720580788; x=1721185588;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5azJ6KWYWB3A45UjNNNKYxm8pcJdGfId5IURMc3exVA=;
        b=YXR8yWVt4Mu8U0B1hb8T77rSLboQieiCwP/J/bycVj9vJ/mhDgfQh7V5/34DF/+WvS
         0EMswQd4QQux5+vcMV9liyxA7oFOfc97M852WCo5FOjlfl5YXMPi1aTDNzVzOUG+biby
         XXTd3KdQc+2tWE64ZPiQFZt1iUM0walwsLZrznh8asoxJT4ZJkfh1/fz4p7l8B+IEQAX
         Fzp3sAy5q4/iyCKgUzjucLdHflaGnCi/s2S7X+Imm025flBKhF/7CYMcltmNJ7LGmf5K
         t3weQCXBPPsbFqQoF0lxt16578gfa7l98z3jQu6cZIhS32traolGJRBfvEtqKmhH2rqW
         eeNg==
X-Gm-Message-State: AOJu0Yz9k1wM+l7rv/j+NcExfLdmtna4P24tadJ0WlEGHVofLMUtxZ27
	Uu5j0oIZlnhBINigS/0/oIl4/RgSGunvdVElwuEAFRRHdK7TUGpWuTid7A==
X-Google-Smtp-Source: AGHT+IGsu8rOY7aeEqZDB6dRg/gaLWnRlyuKd891pVi4e4+OrePhKyUFb3de2NCh2Afp9eGdV1JlJQ==
X-Received: by 2002:a17:90a:38e5:b0:2c7:c788:d34d with SMTP id 98e67ed59e1d1-2ca35d3d8cemr3547393a91.38.1720580788221;
        Tue, 09 Jul 2024 20:06:28 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca4fc29c81sm1601782a91.29.2024.07.09.20.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 20:06:27 -0700 (PDT)
Message-ID: <631943a53448547ecff22103ddf0f27a9053ecbd.camel@gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Date: Tue, 09 Jul 2024 20:06:22 -0700
In-Reply-To: <CAADnVQ+10YQwcddP=oE_NyUyr1WkfW9JoeuNQg3pZb9qK6X6Cw@mail.gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
	 <20240704102402.1644916-3-eddyz87@gmail.com>
	 <CAADnVQ+10YQwcddP=oE_NyUyr1WkfW9JoeuNQg3pZb9qK6X6Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 18:09 -0700, Alexei Starovoitov wrote:

[...]


> somewhere after spill/fill removal subprog->stack_depth
> needs to be adjust to nocsr_stack_off,
> otherwise extra stack space is wasted.
> I couldn't find this logic in the patch.

Such logic is not present.

> Once the adjustment logic is done, pls add a selftest with
> nocsr and may_goto, since may_goto processing is in the same
> do_misc_fixups() loop and it needs to grow the stack while
> spill/fill removal will shrink the stack.

It might be necessary to move the spill/fill removal to a separate
pass exactly because of this dependency.

I'll think about the implementation, but it might be tricky.

