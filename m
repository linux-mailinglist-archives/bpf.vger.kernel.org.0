Return-Path: <bpf+bounces-61583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9942AE9046
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95E67B43D3
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89242522B5;
	Wed, 25 Jun 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l79AbRhm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99526C8EB
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887793; cv=none; b=EZy1BDtPQOdyOJj5YQ3/0aevj5aH9IMFY+8VR7qOrfga3zEPBcKYHIdtEyOMbMv/5952vbNFAvW4vXYkAADi48/whVsycpmjrwwpxtzvcnnnYS1baOESnoB/ICVMxNcB7mcBSCjGMW7qvHJbXNT38Q5A+Oefz4Fejc13JFF5BdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887793; c=relaxed/simple;
	bh=8Dsmpq2/gSkgVPzR1NtEGFtcAjanPgCgRA/UOYAzYm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUj58MwwvuTiIDH8JRzgerYRyJAcpdCEZaIjWGircCJ49rdz9CrpAW6F+V4ErSbed18l+CofWLS9aVBFuM2ziK1cnOeAmIdLq7lnI5IySl4AtJK81Jr6NjkStJ1EkaAGQKfjK4kdM/Bjadb2SqalymqLVCsPFlBmKHDJQJ2Sjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l79AbRhm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45348bff79fso2855115e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750887790; x=1751492590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JrjIxmYcmqPKI2/9rD1U+nNvTScVKCflYUg8fT6QeBQ=;
        b=l79AbRhmYHaSfi/a0SBf4ybm1svnPpc675foXDz6uBF56yI6r1F0m1OBGRLY9jeHG/
         SuNC6RLs4eui4FiIm2ZuNeZAF9bEyn286cTMYKeI9G31UWuuk7iLCIO+CkS4wohbIRPv
         zVDTqa/9Pg2NaklSTnpXsgQ2wh1lD84yH9LVCCGqDsOdf1pWno3P9Rr6z458yk+XtwzB
         wIQp+77cFmwZM0guGick2LMydhhH3R9EvgD3S7h3UFl8Euv1V9AOzFyWkrSFuKLBta66
         ahjOxgjT9p8Iyvj9zsYslfYrtTYbrlIsQM8cwFaTz3hqVZVj1FztaFZj1faOy8K1bi+m
         5/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750887790; x=1751492590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrjIxmYcmqPKI2/9rD1U+nNvTScVKCflYUg8fT6QeBQ=;
        b=ljzYBgY4LcI8vODzk5I4FKd2Az2Nbu9OnEKoXpkbht321AtP+KeQOH1a83PPq546mu
         FtrptA2dV6gR0fu0nkfgi//9+Tp3VLtyICqUV0xO4zj5Aqcz8vu0TTpF87GjN4salDkd
         wrITkiASmgvJEFmgarXp2h5liRV2I77kGJAb2/da1weUIdRE//LdbfdybvnWCMwMyPSB
         PlTtIBu5LVTxFSliliIEqIOVE6Do4ajLakiif5pkFza/zLrBdCoFyYhWSTKiQ480Hc26
         cqMjtNOivlFzGRbTQjIyztmukQ4zqWDx7LIbfwpvFSsPLKUu1ZYNlcfb0Q+8vZQJywax
         Ah8w==
X-Gm-Message-State: AOJu0YwEotBBCV/Op+cGeJVo734/WwBd3GsNEl+tRx/2fo5HhQfEnslL
	O5Casw1MGStZ1pI+LWqYJcItaiijhDLhff9ovGnHyRkQ2ewnny8CuSiY
X-Gm-Gg: ASbGncuHtWDUYYl/NozBoFGFFpo1iB/q/ACV2u3OLbktMxbqSMuwFVRfuf+02rzoco5
	3+V3Vv+h5vXWUz9/A1ICCI5VJHz2Yib/NRM7bfdxmxLkCRIwEjK0k1NFARW5jtEh0Qjt4z7wCyu
	308Nbma5NJo+hjh5xkYPkNFcVOu6GiGm0WoUymgDrHIh7Jf+tulyAWoJLBJyhFMG8tlal8m5tHL
	EPqxqCP5loPNZo3r1Y5RRpQgYbIn48JLvV3UOdEFIJijLcP/FY/ab5rwn5ob5WJtgxZfhjKWJMl
	GjsJ+1Znp3/7sRLFigWveZ9jw8jnxXDPKpm6QC89KwVNHBfvXv9PgFX5yMLj7Bmtu6uer7k3bIC
	pl0XviwsOcblcUUJpbaa1jo6m7c4fTs8779RADark1tYG5apDBtPw+9km9Sb8BA==
X-Google-Smtp-Source: AGHT+IFnb64xQ1qSxXPcxMC7Hor7Srx4NaFUp7d+kUMZUsj7sIO4ReIPyJI3upqwhIC/WA0U+tP5tA==
X-Received: by 2002:a05:600c:630a:b0:441:ac58:eb31 with SMTP id 5b1f17b1804b1-45381ade9c9mr43266235e9.20.1750887789623;
        Wed, 25 Jun 2025 14:43:09 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e009f0e9cdfcab31167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9f0e:9cdf:cab3:1167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a406489sm450075e9.27.2025.06.25.14.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 14:43:09 -0700 (PDT)
Date: Wed, 25 Jun 2025 23:43:07 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Luis Gerhorst <luis.gerhorst@fau.de>
Subject: Re: [PATCH bpf-next] bpf: Fix unwarranted warning on speculative path
Message-ID: <aFxtazVRQQzhgfmO@mail.gmail.com>
References: <aFw5ha9TAf84MUdR@mail.gmail.com>
 <402ecbeabdd090b81ae35d2187c344779ff926c7.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402ecbeabdd090b81ae35d2187c344779ff926c7.camel@gmail.com>

Thanks for the review!

On Wed, Jun 25, 2025 at 01:19:01PM -0700, Eduard Zingerman wrote:
> On Wed, 2025-06-25 at 20:01 +0200, Paul Chaignon wrote:
> > Commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1") added a
> > WARN_ON_ONCE to check that we're not skipping a nospec due to a jump.
> > It however failed to take into account LDIMM64 instructions as below:
> >
> >     15: (18) r1 = 0x2020200005642020
> >     17: (7b) *(u64 *)(r10 -264) = r1
> >
> > This bytecode snippet generates a warning because the move from the
> > LDIMM64 instruction to the next instruction is seen as a jump. This
> > patch fixes it.
> >
> > Reported-by: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
> > Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 279a64933262..66841ed6dfc0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -19819,6 +19819,7 @@ static int do_check(struct bpf_verifier_env *env)
> >  	int insn_cnt = env->prog->len;
> >  	bool do_print_state = false;
> >  	int prev_insn_idx = -1;
> > +	int insn_sz;
> >
> >  	for (;;) {
> >  		struct bpf_insn *insn;
> > @@ -19942,7 +19943,8 @@ static int do_check(struct bpf_verifier_env *env)
> >  			 * to document this in case nospec_result is used
> >  			 * elsewhere in the future.
> >  			 */
> > -			WARN_ON_ONCE(env->insn_idx != prev_insn_idx + 1);
> > +			insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
> > +			WARN_ON_ONCE(env->insn_idx != prev_insn_idx + insn_sz);
> 
> Could you please elaborate a bit?
> The code looks as follows:
> 
>                  prev_insn_idx = env->insn_idx;
>                  ...
>                  err = do_check_insn(env, do_print_state: &do_print_state);
>                  ...
>                  if (state->speculative && cur_aux(env)->nospec_result) {
>                          ...
>                          insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
>                          WARN_ON_ONCE(env->insn_idx != prev_insn_idx + insn_sz);
>                          ...
>                  }
> 
> The `cur_aux(env)->nospec_result` is set to true only for ST/STX
> instructions which are 8-bytes wide. `do_check_insn` moves
> env->isns_idx by 1 for these instructions.
> 
> So, suppose there is a program:
> 
>      15: (18) r1 = 0x2020200005642020
>      17: (7b) *(u64 *)(r10 -264) = r1
> 
> Insn processing sequence would look like (starting from 15):
> - prev_insn_idx <- 15
> - do_check_insn()
>   - env->insn_idx <- 17
> - prev_insn_idx <- 17
> - do_check_insn():
>   - nospec_result <- true
>   - env->insn_idx <- 18
> - state->speculative && cur_aux(env)->nospec_result == true:
>   - WARN_ON_ONCE(18 != 17 + 1) // no warning
> 
> What do I miss?

In the if condition, "cur_aux(env)" points to the aux data of the next
instruction (#17 here) because we incremented "insn_idx" in
do_check_insn(). In my fix, "insn" points to the previous instruction
because we retrieved it before calling do_check_insn().

Therefore, the processing sequence would look like:
- prev_insn_idx <- 15
- do_check_insn()
  - env->insn_idx <- 17
- state->speculative && cur_aux(env)->nospec_result == true:
  - WARN_ON_ONCE(17 != 15 + 1) // warning

I added a verbose() and recompiled to confirm those numbers.

If that makes sense, I'll send a v2 with:
- A better description, probably with a walkthrough.
- A test case simplified from the syzkaller repro.
- insn_sz renamed to prev_insn_sz for clarity.

> Could you please add a test case?
> 
> >  process_bpf_exit:
> >  			mark_verifier_state_scratched(env);
> >  			err = update_branch_counts(env, env->cur_state);

