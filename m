Return-Path: <bpf+bounces-62697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07326AFD075
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 18:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D973AC71E
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661CA2E49A8;
	Tue,  8 Jul 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEci7oaz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384272E2F0D;
	Tue,  8 Jul 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991571; cv=none; b=UErmYkh0dnDv7LATkpGwaUVC2nOcXUonaoExImWo0nRHt3rkU3qIMpSgvpMRBdyjCa7WmIMH1VJL183Hmhg65vmYLWMnD3RJsXQ25h/+fhRoXYsIlFnfAIrVkCDNby0xsDcXUlgt+iO114yiGrktB0damgg9x1u9k1otplADsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991571; c=relaxed/simple;
	bh=FbQxrH/Dw119DQzHrfQwKTJr58MGjxzzu5kNV6dVSq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5IH2QvlLBjMW+IJVNFZOHs5YFdHbqspYcWPpFdZwhOLeGcnpe21xwlvoNeJyTWxzvJpa+PeTx1qaPsRa5aR/z3pvjB04RtjrirHSwcb3Lv6zaDtzHAsZCvDRG6YQM0areejebJEwL8U+3J82Hw7I8TNCBLIqmqAKWO8q9FSsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEci7oaz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4530921461aso32877835e9.0;
        Tue, 08 Jul 2025 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751991567; x=1752596367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNlEKzyKmg+bvMIMD915056OhPGCfIEZ5L+VPCiMkuY=;
        b=mEci7oazFnCGV/FkS4Qux2DDCXa7HtY++0BMKBavKHBYvjOrIZYOg2jNwtT7qfXYdg
         jrrX2A1Ha0WPNyGTPAhORs/R5jpeaksdekBY511kO/0EjgovnpoPevJUk4xArki2x7rW
         FTdJyaOMh0gMnuddxgW6tR/4mZMaWt3hbKJrx+NgLipJbFJ0auC1BXRCuT3r02p0Z1+5
         mk79UzM/5HIS2uDxlLe90rFXGtHY5zZa9wMSCHNVCchRSJsX1HzaIoPzzuT8reOe012s
         3E38qcWLTn9kaVqrA6b2B7LeqmnUVvcBX54YX3mRrfOZImVcB1TrCeRLSlCJ7tl5moaY
         XIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751991567; x=1752596367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNlEKzyKmg+bvMIMD915056OhPGCfIEZ5L+VPCiMkuY=;
        b=fI4kzNY2t1J3TJyjLVOWabSyjvwBRrF7fzHnIwrW6k4Xkz6UcxQkqD07rRyymmHkBW
         D53ZOkCSRl6cjT0ofmdXiv53ei+htPdrDUtgOMWamsehExdnoga21vx6zDlqN9EIM/O8
         srZtSY52SN3Vrh02NARftK9OONUxwDfWyAtUt5Ba3KbUhhpWqU1hQKW52MNz8Rmil1kB
         v/mh9hX+M6JwsvoNQTk26eA5hwQP4XGfopcZN4zyKL2SoGf4oL6h/jrVrRzFrCoowuSE
         76x25EWC1uXDeVbKSC+4f786Vbs8bx755nWRjcoRaESx5Wh0QSzq0FxQ8T9bQ+z/+nEV
         QqXw==
X-Forwarded-Encrypted: i=1; AJvYcCVafXZohcQbTap6i4B4vBVNXLFxHxlc+gM9Z0/+PvKwa3wq6rYebkQMz8puwCKiq0ESMFMJtSSkXqo8lDn6@vger.kernel.org, AJvYcCWO3Fb/WYk6NJD4l9FPj5I2FZHuULEulLk9Q8Fz/LQPJmpjCKphOJhoXWT4dBhj2zLZa9eaDYgb@vger.kernel.org, AJvYcCWybD2fDsS9dFG0GXdxWdT3KL53WCQmmA8ihsmkodvadbRVlL/Nft4yHvXmVQirTRYwg4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJo15gLqXvviiqS2517LZIqPlC7dBT2V3DkJkh3/ANNyV52DJ1
	2GMZgJvImv0rnu8wavcSSgd3sdpUiH0OsTrgRsNp+cbe3ms95o3hpdJO
X-Gm-Gg: ASbGncthZT46PzroKcvHX5gHGZJ2rsJyWfevHPdeO1lkmPCVnEroeKHVD4BJjRmYwvO
	Ml393PknUI7Sm9BVu9N4cQQaTBGsit+GoleaGuoOmCRbJUe6u9ir3uorJqGr0hVyr+m+F7bG3sT
	8Yj3AXSx8dcliPy9znpC6veEW3TpNuTc6Cbz4DlIGmteltxgEs8b3eAKzli7DkKlPF3iVni1Yii
	OAJwdj8+Dh2g6Vt50CpaPLj5YyZCyMuNKDgJBas+79juycfcNxfb2aiU0WVEnsHrS8/dVimwIAp
	WGrW9wNQqXh4NZZq1650jFWiJJuRlHrZCR/ASDOjZ/T1iMzuYTS1kjEsmA23XhsTZxvAyK96WUL
	hiIWTNAEJglWntPQgMepN3tOP/UQLIyTD/pQJgFEzoVRUpExWRFW4Exw8/wo=
X-Google-Smtp-Source: AGHT+IGFIuClLgsY3lb0dQaW9I9uaZLJqJRGUpTACufcAPdItHQEZq95+4sZp2nCEUmrqM7FEfhZcQ==
X-Received: by 2002:a05:600c:4e56:b0:442:f482:c432 with SMTP id 5b1f17b1804b1-454cd518095mr42881425e9.18.1751991566889;
        Tue, 08 Jul 2025 09:19:26 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e003c0e09e1a0a8eb8f.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:3c0e:9e1:a0a8:eb8f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3dcf35sm26426625e9.36.2025.07.08.09.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:19:26 -0700 (PDT)
Date: Tue, 8 Jul 2025 18:19:24 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Network Development <netdev@vger.kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
Message-ID: <aG1FDHAu-H2oH4DY@mail.gmail.com>
References: <aGa3iOI1IgGuPDYV@Tunnel>
 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
 <aGgL_g3wA2w3yRrG@mail.gmail.com>
 <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
 <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>
 <aGxKcF2Ceany8q7W@mail.gmail.com>
 <2fb0a354ec117d36a24fe37a3184c1d40849ef1a.camel@gmail.com>
 <c35d5392b961a4d5b54bdb4b92c4e104bd7857cc.camel@gmail.com>
 <CAADnVQKKdpj-0wXKoKJC4uGhMivdr9FMYvMxZ6jLdPMdva0Vvw@mail.gmail.com>
 <4ae6fd0d54ff2650d0f6724fb44b33723e26ea49.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ae6fd0d54ff2650d0f6724fb44b33723e26ea49.camel@gmail.com>

On Mon, Jul 07, 2025 at 05:57:32PM -0700, Eduard Zingerman wrote:
> On Mon, 2025-07-07 at 17:51 -0700, Alexei Starovoitov wrote:
> > On Mon, Jul 7, 2025 at 5:37 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > On Mon, 2025-07-07 at 16:29 -0700, Eduard Zingerman wrote:
> > > > On Tue, 2025-07-08 at 00:30 +0200, Paul Chaignon wrote:

[...]

> > > But I think the program below would still be problematic:
> > >
> > > SEC("socket")
> > > __success
> > > __retval(0)
> > > __naked void jset_bug1(void)
> > > {
> > >         asm volatile ("                                 \
> > >         call %[bpf_get_prandom_u32];                    \
> > >         if r0 < 2 goto 1f;                              \
> > >         r0 |= 1;                                        \
> > >         if r0 & -2 goto 1f;                             \
> > > 1:      r0 = 0;                                         \
> > >         exit;                                           \
> > > "       :
> > >         : __imm(bpf_get_prandom_u32)
> > >         : __clobber_all);
> > > }
> > >
> > > The possible_r0 would be changed by `if r0 & -2`, so new rule will not hit.
> > > And the problem remains unsolved. I think we need to reset min/max
> > > bounds in regs_refine_cond_op for JSET:
> > > - in some cases range is more precise than tnum
> > > - in these cases range cannot be compressed to a tnum
> > > - predictions in jset are done for a tnum
> > > - to avoid issues when narrowing tnum after prediction, forget the
> > >   range.
> >
> > You're digging too deep. llvm doesn't generate JSET insn,
> > so this is syzbot only issue. Let's address it with minimal changes.
> > Do not introduce fancy branch taken analysis.
> > I would be fine with reverting this particular verifier_bug() hunk.

Ok, if LLVM doesn't generate JSETs, I agree there's not much point
trying to reduce false positives. I like Eduard's solution below
because it handles the JSET case without removing the warning. Given
the number of crashes syzkaller is generating, I suspect this isn't
only about JSET, so it'd be good to keep some visibility into invariant
violations.

> 
> My point is that the fix should look as below (but extract it as a
> utility function):
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53007182b46b..b2fe665901b7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16207,6 +16207,14 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>                         swap(reg1, reg2);
>                 if (!is_reg_const(reg2, is_jmp32))
>                         break;
> +               reg1->u32_max_value = U32_MAX;
> +               reg1->u32_min_value = 0;
> +               reg1->s32_max_value = S32_MAX;
> +               reg1->s32_min_value = S32_MIN;
> +               reg1->umax_value = U64_MAX;
> +               reg1->umin_value = 0;
> +               reg1->smax_value = S64_MAX;
> +               reg1->smin_value = S32_MIN;

Looks like __mark_reg_unbounded :)

I can send a test case + __mark_reg_unbounded for BPF_JSET | BPF_X in
regs_refine_cond_op. I suspect we may need the same for the BPF_JSET
case as well, but I'm unable to build a repro for that so far.

>                 val = reg_const_value(reg2, is_jmp32);
>                 if (is_jmp32) {
>                         t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
> 
> ----
> 
> Because of irreconcilable differences in what can be represented as a
> tnum and what can be represented as a range.

