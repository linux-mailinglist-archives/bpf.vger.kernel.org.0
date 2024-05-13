Return-Path: <bpf+bounces-29671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5478C48C6
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 23:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB41281BE4
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11748839F8;
	Mon, 13 May 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoJdvybr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D480632;
	Mon, 13 May 2024 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635428; cv=none; b=ovAHdnUoT3khT9VZaYJ58AsoHHjOlLDOdH0IU4aIOuMuzeq9k+b2BpZOmny/Cebkvn/6m6Agveaoo6zrjO6azLbD3Im8fSc88P2erG7ywEtHmQ0oDwTreFNA22ujyFuSsd8W1ci93BQpsD0q5xgauA8nDKAIvpGG6mGR+tDkwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635428; c=relaxed/simple;
	bh=7KDldPh4uI/py/rTFc69LhzcvKPYHuy78Y+cIXzQHJA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIzX6AJxar4HN4bb2IMuhnPQN7polUT+KWev6HTZrx/K9GH7SFAOO8C55eu8U5ZvvgpHioo2YZiAhMuaHuoVw35sC5MC/B3rMTjCQk9A2Xx3YD+TcWD0J+bT9pSnNkZJ91hAKuuHsuVf2EJrhsNLbKcmBSj3wVF/pODBd1Xg08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoJdvybr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b12b52fbe0so3639396a91.0;
        Mon, 13 May 2024 14:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715635426; x=1716240226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RMSuz07A4w5gpVATrv0a4fCRS6KDO8fmqCeo2z7sNeI=;
        b=WoJdvybr4Nld1JPaWS5It0jtEo4KD9n7N7HJ05MAzmi7+uL/DAcmxd+xGIfuiEHN1U
         QaEh6Z8jV9iKnDNQnn3kL3ahbDU93NpBAdoPZGDI8ibR9rwL8HE1+a10B0zoCr05MdYw
         9ubk2Ov/0HVahjlu+jAVwd/rGAdqwbaBcRwJE/WQr/b5d5h/nPai2xX6ZYfvbaladpaE
         JRlMzT/4qyewZH+tzJ3ASz94KtQ51EeyHPzPAgolOBr7JPxCLr7adZfu2+kgnmbHbU5C
         2GGEtTMbi5bdLVaFITF77Ij3wXgS5otxm9S7PkdTpLAoQtaBDoqMhuK+AhD2MqDVQ+zO
         uKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635426; x=1716240226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMSuz07A4w5gpVATrv0a4fCRS6KDO8fmqCeo2z7sNeI=;
        b=py31cA4XOJ91bfAPHo9CK+XbLhy/1AD3YdNGWOfX4vn7TrLGSbV1tHOJfY1j+5vTC+
         hwibSQOM0crIMO3+Km/f0q/4ZKHNRcIq3arsBmu4wArppKkBQz5bLR5caO/DWLdL5ZQW
         Qezu0NZEilfcOGdwMbc2kZMHRAJQQQxnWKouK1enB/2HA1P9IEurP3yrtH0+sKMXMTha
         wSZJJ+NsJMnI7TrvhJixaA3Ll+wcRjzfi/fMI1A+TTZUuk1T+GRbK1co5ajZpVwwHDFk
         KV5qNyrdikFmhixbtfE5uYSvnwpwzCKLS4IBaNIYFwE3+TMZaW95StvSrBO3JD0NscEl
         F9ew==
X-Forwarded-Encrypted: i=1; AJvYcCUDJrJ5VgDDHsy9AXh6OGm2Z/gioi54BzurSVfQdHhdM2XU0Arz+SwNNKKDoBG3OfN0+VzI1Vx4jsZbsbUm/aVPMJ7DN9eU85BjK/t2x67jLBjno9CtL3mM2TpIwZgkH4nI+Vf70NJ9oGQgMT+CjYT8fIzO+tnvnZKMmNfScqGwHKCj7q84tfJH4nVd9d6RM3BcZJmFakoGVXzVTu9y8BBoWNzXytoGZvlgI5MzQhm0zpoeF6/tJX4rQNic
X-Gm-Message-State: AOJu0YyL68tcXMRJ2s7TmiOPYavmyrMTzqXZjk5cV9By2p5+C5MCHkr/
	+1T3OtIUV3GfyUxvB9EUiLwM8cBGr7bXOKJM25MMCXV3GKwGL3j8
X-Google-Smtp-Source: AGHT+IGMIx5GTk6vK6cbKg4CZgRx+oouSfAzl44B+vmJPTIVjSC83366ig2FbO+jkHjw/44yxi1aHw==
X-Received: by 2002:a17:90a:da04:b0:2b3:d512:d487 with SMTP id 98e67ed59e1d1-2b6ccd97a79mr10878206a91.39.1715635426267;
        Mon, 13 May 2024 14:23:46 -0700 (PDT)
Received: from krava ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671056503sm8371975a91.3.2024.05.13.14.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:23:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 13 May 2024 15:23:42 -0600
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <ZkKE3qT1X_Jirb92@krava>
References: <20240507105321.71524-1-jolsa@kernel.org>
 <20240507105321.71524-7-jolsa@kernel.org>
 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
 <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>

On Mon, May 13, 2024 at 05:12:31PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2024-05-13 at 18:50 +0900, Masami Hiramatsu wrote:
> > > I guess it's doable, we'd need to keep both trampolines around, because
> > > shadow stack is enabled by app dynamically and use one based on the
> > > state of shadow stack when uretprobe is installed
> > > 
> > > so you're worried the optimized syscall path could be somehow exploited
> > > to add data on shadow stack?
> 
> Shadow stack allows for modification to the shadow stack only through a few
> limited ways (call, ret, etc). The kernel has the ability to write through
> shadow stack protections (for example when pushing and popping signal frames),
> but the ways in which it does this are limited in order to try to prevent
> providing extra capabilities to attackers wanting to craft their own shadow
> stacks.
> 
> But the HW features have optional abilities to allow extra patterns of shadow
> stack modification for userspace as well. This can facilitate unusual patterns
> of stack modification (like in this series). For, x86 there is the ability to
> allow an instruction (called WRSS) such that userspace can also write arbitrary
> data to the shadow stack. Arm has something likes that, plus an instruction to
> push to the shadow stack.
> 
> There was some debate about whether to use these features, as glibc could not
> perfectly match compatibility for features that play with the stack like
> longjmp(). As in, without using those extra HW capabilities, some apps would
> require modifications to work with shadow stack.
> 
> There has been a lot of design tension between security, performance and
> compatibility in figuring out how to fit this feature into existing software. In
> the end the consensus was to not use these extra HW capabilities, and lean
> towards security in the implementation. To try to summarize the debate, this was
> because we could get pretty close to compatibility without enabling these extra
> features.
> 
> So since this solution does something like enabling these extra capabilities in
> software that were purposely disabled in HW, it raises eyebrows. Glibc has some
> operations that now have extra steps because of shadow stack. So if we could do
> something that was still functional, but slower and more secure, then it seems
> roughly in line with the tradeoffs we have gone with so far.

so at the moment the patch 6 changes shadow stack for

1) current uretprobe which are not working at the moment and we change
   the top value of shadow stack with shstk_push_frame
2) optimized uretprobe which needs to push new frame on shadow stack
   with shstk_update_last_frame

I think we should do 1) and have current uretprobe working with shadow
stack, which is broken at the moment

I'm ok with not using optimized uretprobe when shadow stack is detected
as enabled and we go with current uretprobe in that case

would this work for you?

thanks,
jirka

> 
> But shadow stack is not in widespread use yet, so whether we have the final
> tradeoffs settled is still open I think. For example, other libcs have expressed
> interest in using WRSS.
> 
> I'm also not clear on the typical use of uretprobes (debugging vs production).
> And whether shadow stack + debugging + production will happen seems pretty
> unknown.
> 
> > 
> > Good point. For the security concerning (e.g. leaking sensitive information
> > from secure process which uses shadow stack), we need another limitation
> > which prohibits probing such process even for debugging. But I think that
> > needs another series of patches. We also need to discuss when it should be
> > prohibited and how (e.g. audit interface? SELinux?).
> > But I think this series is just optimizing currently available uprobes with
> > a new syscall. I don't think it changes such security concerning.
> 
> Patch 6 adds support for shadow stack for uretprobes. Currently there is no
> support.
> 
> Peterz had asked that the new solution consider shadow stack support, so I think
> that is how this series grew kind of two goals: new faster uretprobes and
> initial shadow stack support.
> 
> 

