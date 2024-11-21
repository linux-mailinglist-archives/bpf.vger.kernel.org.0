Return-Path: <bpf+bounces-45402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77C9D5261
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 19:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96301F2387A
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F51A0704;
	Thu, 21 Nov 2024 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCVCrWK8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70468139579
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212799; cv=none; b=Kn4+BBmDNBIK09NB6qYp+8ncoz1ENJ3kaIuaTwWWJ3u98sekgtNuukmF7wMp9EU6nCu9NlOP3hI+lWbaXmWzqt1GW81oWnrJChmaNnRTj7dXSOpcxUm390L+JDBOMEhbNbO0u8hbCKd1ppGdS6QFAZia+bI71tvAcZdl5MuBnSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212799; c=relaxed/simple;
	bh=W47o1pKtfC6MAN3PZKScJUXXNREVPvg51Ycw0Vn9Eag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOCQxcl9Ed33DTFZUBZZGW2IC4CxI0optBVuo4MoYf33F9mo8yVz17yM7JciMgBnXHoA4XnpC+2Uo+GELzrU7AoeGOZXGmdimj6Do6Nj1Cu8v49Ji5sdt01s8NGh+e62Ah5LMR2BNaohSbWpjKyzpv/kiBzaHbqSXT9EBlxPHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCVCrWK8; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so13725281fa.3
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 10:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732212795; x=1732817595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8rrdm/xdhd7OwgurO9YkY6oP6ZLIfTmfbYbCXuQeTZ4=;
        b=OCVCrWK8xhhLuLozPcVTMzxl2HaTSlsFVoa9rwRcXrE+VUxTcdJA4YXv3IbBROrpnC
         QlSN7/khR9yUOM0E8rUWjhUQGuZbveF1s6CkMB2Idh9Dfc6Mg9kNI4WJAmvWpuklb34J
         153oPFPvotMgyHWuDHJLLtin1M7Hw4sj725tta+OuLMpotYC/cTFKuVZAugnpIij8IFe
         ECqeNttTzQ7ofXzP2OE0YE1k713cKx5MpFgqL8w68ErcjrRlB+pUdtdCAp07kPyseECG
         s2Oct3gqaTviwX1a7YBT+5fdGe6A2iGxeHbF1ts8DfXVDb+K3Rp99xqZqtef0/x7YDVb
         uk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732212795; x=1732817595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rrdm/xdhd7OwgurO9YkY6oP6ZLIfTmfbYbCXuQeTZ4=;
        b=SHFSE+t8L85pNM6KDc6mhViy1Z5jymMNugYdJV5EagOAQYK90r8EI7AWS50FWpuL2l
         w3gZkCmMazPe+QUpDWDIPErKGO5SgQ/xOoHYQP8Yq8sIX7+WXkf7dw2/DpWF0nVe0JqF
         Xj0xaeFTGrInco7+bvwT6fh3UBc8O0ffJxphJbUlbFP66kHZ4YQAz7HzrrqNUe5aYgmi
         nxnsG9Nnj/N0AYy+HfW6VzR4WttecDZX2k9nRuOW5rbg7DrdX895+AiWBDHRXSxppK1G
         8u6lasvNplbCh9RoAhmYFs29gnAvzN51pcMJGAd6W2IuUg+fLMOzTVPvpcN4atT3WGIw
         4Kcw==
X-Gm-Message-State: AOJu0Yyyb7opXJBimoaCTNuyxR6Rn6IrME2F6SbTzcKv97VWzAmyYVgB
	tSauRFaV/CXA/HcANxOLAU/U+kKv1AO94lzcjEdQLwQxFxff1MYuGppllqJBBAKbf0QOy95k2tw
	xYaSPQ4v9GAcLLLsveB56nFGewpE=
X-Gm-Gg: ASbGnct3OXaBX3FjXXWZNsl2bMzMOh1Wj3bg1lFcu2kKmVmnlIbTCt/KWiUwkqwXn19
	nQU8GsbWOwLa/Lnrcn8nb+X33gKwuwrPj1Q==
X-Google-Smtp-Source: AGHT+IFqE2gMoS4ZQ6fUeKwTpJa8Qxzog6nqFKRhD1sJOV3ya8Co3/94VsbBxg7kFi/IpsJCGpHvC3eba583u6J7RXg=
X-Received: by 2002:a05:651c:88d:b0:2ff:5a42:9205 with SMTP id
 38308e7fff4ca-2ff8dcb2af6mr49954871fa.31.1732212795203; Thu, 21 Nov 2024
 10:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121005329.408873-1-memxor@gmail.com> <20241121005329.408873-4-memxor@gmail.com>
 <dfe594d893ce83a3be0ddaa3559043908465eaec.camel@gmail.com>
In-Reply-To: <dfe594d893ce83a3be0ddaa3559043908465eaec.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Nov 2024 19:12:39 +0100
Message-ID: <CAP01T75sz0YB7dj3fchyw-E2kjftaewcXhWJP_=hf_OBnWBDQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Consolidate RCU and preempt locks in bpf_func_state
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 19:09, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> > To ensure consistency in resource handling, move RCU and preemption
> > state counters to bpf_func_state, and convert all users to access them
> > through cur_func(env).
> >
> > For the sake of consistency, also compare active_locks in ressafe as a
> > quick way to eliminate iteration and entry matching if the number of
> > locks are not the same.
> >
> > OTOH, the comparison of active_preempt_locks and active_rcu_lock is
> > needed for correctness, as state exploration cannot be avoided if these
> > counters do not match, and not comparing them will lead to problems
> > since they lack an actual entry in the acquired_res array.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> This change is a bit confusing to me.
> The following is done currently:
> - in setup_func_entry() called from check_func_call():
>   copy_resource_state(callee, caller);
> - in prepare_func_exit():
>   copy_resource_state(caller, callee);
>
> So it seems that it is logical to track resources in the
> bpf_verifier_state and avoid copying.
> There is probably something I don't understand.
>

This is what we were doing all along, and you're right, it is sort of
a global entity.
But we've moved active_locks to bpf_func_state, where references reside, while
RCU and preempt lock state stays in verifier state. Either everything
should be in
cur_func, or in bpf_verifier_state. I am fine with either of them,
because it would
materially does not matter too much.

Alexei's preference has been stashing this in bpf_func_state instead in [0].
Let me know what you think.

  [0] https://lore.kernel.org/bpf/CAADnVQKxgE7=WhjNckvMDTZ5GZujPuT3Dqd+sY=pW8CWoaF9FA@mail.gmail.com

> [...]
>

