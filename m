Return-Path: <bpf+bounces-16146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C357FD8F0
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 15:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E217283032
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF5F30322;
	Wed, 29 Nov 2023 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8GO0jgL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1870B5
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 06:07:08 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50aab20e828so9528180e87.2
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 06:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701266827; x=1701871627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWGrpk4iqpJ8cMGGmWvasOZVJ9bGl0VOzgfbxYsBLtc=;
        b=W8GO0jgLKsBs7kHsvbrI16FeLEETD9sUfSouilUPSkC0r8ssBfyv6PhFC6b/fmVIKg
         hY5qsB5qjgzEt0MmqSONu3PU7fHbvPDJ95bvwlkbOi/NXacyxDgOsUIAVo/8JE0kHMma
         Zwt4UTg99dWDHhXgdRqrfrkTplUdGYu7mn3aj8HROh/3rjxfgvuEbakyOLvrN+yuMbsq
         4W5DT0N9N2A1xHAA2SdzWJAPW1UVH5WMgFZ02/71g3TSMl6O3tdLwvQZWqPDRkuQMLSt
         Sk8je4kk8xdaxj9chfspuTZrNM6wkH+nsCXHagPpLQ+B7Rlf1l8fwRJx34TT3yya5jCr
         XpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266827; x=1701871627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWGrpk4iqpJ8cMGGmWvasOZVJ9bGl0VOzgfbxYsBLtc=;
        b=t8hXFc+6QYCZnf2bs6r3IK/9ycGHqtQshNkovcJ3rj7X/hIxtuLKUxjkggMFCDf0gO
         0YlN+6OFGGoeOniL6VgAMRNuuZWttecJoYXAOyzyZupdv0gCM3L/t/5UZc9ikaBlLdKj
         E7AkB/MHp/2xx4wBcPNkVLjREZbsjE9WpQKxtUNTgpIJooAEQw40EyNpVA2f8zkyR40u
         ijZrqLWUgzSQksIIBjhKG6r63Esf15s7APkk7dilR8SEGT8oPstv2cZ/tC5EDLR9qVm4
         PXX/j6ZhUivNs51vSYfxq3Qg+L9qxSIQG6UUxLZmJ1Zm3zIHD3jCYeMbzBw1jsYKzoP9
         yCsA==
X-Gm-Message-State: AOJu0YxTctfIHhMT5VuFuRqcgw16sUzdJ9AvFpTPedhfQvMCB4ZqU/xo
	iAFflJnHXfXZhe2Hvaq10iU=
X-Google-Smtp-Source: AGHT+IH0Y+J5fbcTz4S/Vx6tpKXyxUq8fiFtmRtAz2PTZ/sHyiVmjImPeAmJeeJZIN4b/vMbTQ9DqA==
X-Received: by 2002:a05:6512:3b22:b0:50a:71e1:e1d0 with SMTP id f34-20020a0565123b2200b0050a71e1e1d0mr14841595lfv.6.1701266826810;
        Wed, 29 Nov 2023 06:07:06 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b0040b347d90d0sm2326930wmq.12.2023.11.29.06.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:07:06 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Nov 2023 15:05:21 +0100
To: Stanislav Fomichev <sdf@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCHv2 bpf 1/2] bpf: Add checkip argument to bpf_arch_text_poke
Message-ID: <ZWdFIUSXcZnCWax-@krava>
References: <20231128092850.1545199-1-jolsa@kernel.org>
 <20231128092850.1545199-2-jolsa@kernel.org>
 <ZWZafkt97qhgHynh@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWZafkt97qhgHynh@google.com>

On Tue, Nov 28, 2023 at 01:24:14PM -0800, Stanislav Fomichev wrote:
> On 11/28, Jiri Olsa wrote:
> > We need to be able to skip ip address check for caller in following
> > changes. Adding checkip argument to allow that.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/arm64/net/bpf_jit_comp.c   |  3 ++-
> >  arch/riscv/net/bpf_jit_comp64.c |  5 +++--
> >  arch/s390/net/bpf_jit_comp.c    |  3 ++-
> >  arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
> >  include/linux/bpf.h             |  2 +-
> >  kernel/bpf/arraymap.c           |  8 ++++----
> >  kernel/bpf/core.c               |  2 +-
> >  kernel/bpf/trampoline.c         | 12 ++++++------
> >  8 files changed, 32 insertions(+), 27 deletions(-)
> > 
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index 7d4af64e3982..b52549d18730 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -2167,7 +2167,8 @@ static int gen_branch_or_nop(enum aarch64_insn_branch_type type, void *ip,
> >   * locations during the patching process, making the patching process easier.
> >   */
> >  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> > -		       void *old_addr, void *new_addr)
> > +		       void *old_addr, void *new_addr,
> 
> [..]
> 
> > +		       bool checkip __maybe_unused)
> 
> Any idea why only riscv and x86 do this check?

so arm does the check as well, but needs the data from the lookup
to patch things properly.. but IIUC it does not suffer the same
issue because it does not implement direct tail calls [1] which
is used only on x86

> 
> Asking because maybe it makes sense to move this check into some
> new generic bpf_text_poke and call it in the places where you currently
> call checkip=true (and keep using bpf_arch_text_poke for checkip=false
> case).
> 
> (don't see any issues with the current approach btw, just interested..)

I tried to add new function for that, but it did not look good for arm
because it needs to do the lookup anyway

hm maybe we could use new arch function that would cover the single
tail call 'text poke' update in prog_array_map_poke_run and would be
implemented only on x86 ... using __bpf_arch_text_poke directly

jirka


[1] 428d5df1fa4f bpf, x86: Emit patchable direct jump as tail call

