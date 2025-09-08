Return-Path: <bpf+bounces-67813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE4B49D19
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250584E746E
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2192ED87C;
	Mon,  8 Sep 2025 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTUcaxh4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363431F0E2E
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371874; cv=none; b=GwWuFMPZS8HeLwL1uzU607P2KJ/4q+XOKMGRoTeETTsRSP9cC2blk/gvKhPZwfLjIQN39tzPly3HQcpy7uhPohOAIoeulTVYWFG4KXGwr7fTFJdLmWkianqXq+yVQg8wVqHu6IawEAUYwTNal+iciy9V03NJ43EjV90+0CjJfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371874; c=relaxed/simple;
	bh=qFS2mws2vhqmK2Y0TVvStAXkqJQRSCiX3HYW46phA/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKHA3f5A3s/6srGADFzX9Ay9mwy1MJKpLcoPGI88/ohvHR0h6gwMrJ+SK3SfpK2YbFzz4AnjDFd9df4Tf0msBo/CkJdgjVtniqGEl4P+DJh2eRHD7Hd8dOG2JWwSAYEgI6RJZPl5BkW346LhWIzqsLxwpZuSpbDIB+nLO+JRBYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTUcaxh4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so40955745e9.0
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757371871; x=1757976671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NU2QOsS03rJGmOtR+vLPmcDUozpau8hqIIMH1wRffoI=;
        b=UTUcaxh4TE4d92pMySiwpnaIJZjikynmuqgSGW1/oEGvxxJ51aDGCrQk7Zcd2umxXc
         wQjMLW2bP2Hsf2GCRYjcB/Uh6GsFbe3wp90ojC7VKmiXHudmlxNjV/iF64lQpfBzfeIo
         LfzpqXtR69+4XH+acm0AQhOyg20qXqnzK/XOgUpPgeIYz6+89F8FQZdpcWFZmO2A63OP
         8xRI0UTaGGiBbyT2ESqfOJO+Wo6wLQ5lrxRiPZuF/ikefal3PCU3n+v8Hjia+nFTAN0Z
         cJ6unWeJJATImiDTWV5i556GdFavOzCDg/HojvzYk0evts72KDycfUNG7Q6LZc9TFHMQ
         oo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371871; x=1757976671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NU2QOsS03rJGmOtR+vLPmcDUozpau8hqIIMH1wRffoI=;
        b=O8qB3lvgX4Y5xoBVwxWUubyhxS7u8RlIz0zIJFIdCL7aqb88miWsPJ2AamWU2Hyeey
         TAv1ccHvbQxxhxy+kmIxLSucNq24OYwGFw5VhpbXx+i/mlR6F4sPDCHOGXnsts3V7jop
         OoF7G25DGl2dk22dPflZiHq2bkNHK4i5uAdIAfV2rhB0P4CwN+CllP+liGMUGCg4OYvH
         UnYxe3dwOnt7OjDQ8oIW2sgs8y6VOYD86BYdUYP1yICl6F9ja7HcSb9iIlkRL+6DFZv+
         3nO99lq3sf+REZqSlLJRXecU1IuPfqbWifuuHOjVmobBNxGbU/E5BMpNnHKrsfIKfBk2
         ke6w==
X-Forwarded-Encrypted: i=1; AJvYcCVqN0jQshcE6D5SA4UZ/XIAFcB9JDjOPS43XRaKo963RVxef7ncBNAZPGwuJT6IptPovRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQ8gyE+0uhqt5jXGKAE9I3SaLjHVsKgXzJ9TCTJhjakrFiKTJ
	0/Woj0umGSQQUuROB86dtwceHbCZbn8VeYsb4NX2NBIapYaMB4IC4LQKSlMBaseM6GeM3+8Botc
	sm5ngcp2MBP559ugKaplaeojifpGgX5E=
X-Gm-Gg: ASbGnctRaBf3eLG6QXqgT+lDjLCglx7oWqBtn7pgDxQtZ1M68VsV/J83fD0AyZJ10KH
	qE1lhexdTKNuisX89MZ1+aN+Iiku4REDYvReNXW2NKMoHyQmTunQYZqEz69E89mYGzUMRFHqXuY
	NnzOjRkTL770Zxx75KXnI1NVqq5Ki54K6Zr+wf3xtQUpDdrIMMR71xOI5LH/xBkbCqNR7aPNq3y
	hb2/CU1GrnttDIfUBmf7mqGhCN0GhLIGbut
X-Google-Smtp-Source: AGHT+IEYbYdDAFkjlLenxf2M1NjsaOnz0kDXHZIk5aRzxYXZ1Tms5El2p1fzMCVv9TrIt3eXyI3F3AkhnuOtHLdT9eg=
X-Received: by 2002:a05:6000:4211:b0:3ce:f0a5:d597 with SMTP id
 ffacd0b85a97d-3e64c1c34aamr7905870f8f.47.1757371871403; Mon, 08 Sep 2025
 15:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908044025.77519-1-leon.hwang@linux.dev> <20250908044025.77519-2-leon.hwang@linux.dev>
 <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
 <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com> <aL9bvqeEfDLBiv5U@google.com>
In-Reply-To: <aL9bvqeEfDLBiv5U@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Sep 2025 15:51:00 -0700
X-Gm-Features: AS18NWBMjGLBbjU0IQnX8DUxnE6Urn7prZmBEm5_N91NsfNTS8laJMqbEGhAxIw
Message-ID: <CAADnVQ+56_gvS328irDEuGoDGFH6iywKriACtsre7h5a7eiJbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
To: Peilin Ye <yepeilin@google.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:42=E2=80=AFPM Peilin Ye <yepeilin@google.com> wrot=
e:
>
> Hi all,
>
> > > > [   35.955287] BUG: sleeping function called from invalid context a=
t kernel/locking/spinlock_rt.c:48
>
> FWIW, I was able to reproduce this pr_err() after enabling
> CONFIG_PREEMPT_RT and CONFIG_DEBUG_ATOMIC_SLEEP.
>
> On Mon, Sep 08, 2025 at 12:29:42PM -0700, Eduard Zingerman wrote:
> > On Mon, 2025-09-08 at 12:20 -0700, Eduard Zingerman wrote:
> > > On Mon, 2025-09-08 at 12:40 +0800, Leon Hwang wrote:
> > > > When enable CONFIG_PREEMPT_RT, the kernel will panic when run timer
> > > > selftests by './test_progs -t timer':
> >
> > Related discussions:
>
> [1]
> > - https://lore.kernel.org/bpf/b634rejnvxqu6knjqlijosxrcnxbbpagt4de4pl6e=
nv6dwldz2@hoofqufparh5/T/
> > - https://lore.kernel.org/bpf/lhmdi6npaxqeuaumjhmq24ckpul7ufopwzxjbsezh=
epguqkxag@wolz4r2fazu2/T/
>
> [...]
>
> > > The error is reported because of the kmalloc call in the __bpf_async_=
init, right?
> > > Instead of disabling timers for PREEMPT_RT, would it be possible to
> > > switch implementation to use kernel/bpf/memalloc.c:bpf_mem_alloc() in=
stead?
>
> Just in case - actually there was a patch that does this:
>
> [2] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.c=
om/
>
> It was then superseded by the patches you linked [1] above however,
> since per discussion in [2], "use bpf_mem_alloc() to skip memcg
> accounting because it can trigger hardlockups" is a workaround instead
> of a proper fix.
>
> I wonder if this new issue on PREEMPT_RT would justify [2] over [1]?
> IIUC, until kmalloc_nolock() becomes available:
>
> [1] (plus Leon's patch here) means no bpf_timer on PREEMPT_RT, but we
> still have memcg accounting for non-PREEMPT_RT; [2] means no memcg
> accounting.

I didn't comment on the above statement earlier, because
I thought you meant "no memcg accounting _inline_",
but reading above it sounds that you think that bpf_mem_alloc()
doesn't do memcg accounting at all ?
That's incorrect. bpf_mem_alloc() always uses memcg accounting,
but the usage is nuanced. bpf_global_ma is counted towards root memcg,
since it's created during boot. While hash map powered by bpf_mem_alloc
is using memcg of the user that created that map.

