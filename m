Return-Path: <bpf+bounces-47057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85B9F38E8
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 19:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D7F1887902
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39747206F14;
	Mon, 16 Dec 2024 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl+bXONP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E025205E11;
	Mon, 16 Dec 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373627; cv=none; b=sbolpeNyI0BFq4UPh1SsyIFsUTxTizyypiqOccJjqTSRh69gbVrH0lz701XSjS9ljm13q1iVQBenCEUdYI4oWNXLvSJR+KnGD0bo+ZUXWjV4S6GBE68kDkU9nNZZ/SwNKIFXyPkpSPfdJR+VxnteuSNQn0s2q7bOV8EhyHQ6OWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373627; c=relaxed/simple;
	bh=peQztMcshPa/GyXWLb1xn1u3goLQ4a1w0elREhsTn3I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uf/TnpvSK79KfyR5Rj0ZopKe9n6t7QHTrSyVdMVQTlvGeCRVxgci77mMwG2mXriPQ/1NNy86BEIFLYOjB0nAK93ujHqrLn8UyHTSLsDoyaMANPKZdGYr183I1fqDMe0DaDNf25YZ2d+cjShH47jAHEUTYfNXP1wthvJXCnHDwFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl+bXONP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f4325168c8so1839517a12.1;
        Mon, 16 Dec 2024 10:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734373625; x=1734978425; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=570qyQ95MyqKtEn6RjLsmFDhC4N5AWY32KuxxTRb1BY=;
        b=Kl+bXONPzgu7K74xoIx46hR4wsBxFG/+iNEMfPWCFYlCBxrEDyzwpWZzqPbqKehs8O
         FguY/jV/VKecxw9I3phs9L8MU1oaEeHkMpA4ixmGuxYJSMrZxe7mxbheSJfAbgAvZ+hk
         BOMqc947WKVBewLSpO6JXigwGERLs1DDl+v1k8pWpcr3CNLt/d+U3m5JJ6rgwTAWAFHc
         STvJKsTqcS+dsGHJAVcfExAMVey9nrkIa0m1gXgSwN0DEmS0bD8Pewd/xC8ZGHPa7jpr
         ZgZzoqUVqT71hopVafG6et7uVZtl0X9cPwd2OQFvfWp2SSsZRIVMPk0vMlosG9PKNnfB
         j8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734373625; x=1734978425;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=570qyQ95MyqKtEn6RjLsmFDhC4N5AWY32KuxxTRb1BY=;
        b=LamBjqyQjIVTxaVx74PxCk+O0aUbWXGZBkfv3l7fcEJr1g5KbuGQFh8LKtiwzALiiK
         qu/fKTunvlumJSF3BUL/fYfmMHRjxRkHaAIo55rGgLPvRJhhruuFrP42sVuwYRTHJNpT
         ztkRnyhvBVFa/ScBT/qJ3M11ygIWBxrw900058MU1aA1SHvoUaHCOvBpk1QlduCDZa0l
         w/BpivonJDYX4+ReETj+UKW+A9Em1yO72eaBM1gVeJQKu54LmkvoM25WxPNJoFBSAqHK
         L0Hx1xB6Xmdj4oYgJwymM0zYnyknM4sasdp3c7JsgeuDamK7tSNswZ3e6CXX+0N3BLlL
         /NLg==
X-Forwarded-Encrypted: i=1; AJvYcCV1rgiYD94eihrdYsm8NWPPHp6+j6Q9b1tqHPrsKbX7FA8qETuS3YribfGfe13G66A8eB0=@vger.kernel.org, AJvYcCWSSocnWGwHBP/ltY8m0nNnkT30c/XmIsJwBaiqVRVgJx/rLWo/cCh4ymuAHVxfB67a+8sWUEJ0vTnP159J@vger.kernel.org
X-Gm-Message-State: AOJu0YzvrW2YjpBg7z1qu7vqCNROj2CBpzA5uQZLZO6DPk3FdZor87lf
	Td1fRtOmtQskiMwFjb6COESXotkVehkTkN7EGPhnAx7qwEHqzXmL
X-Gm-Gg: ASbGncutQhTO0DD2kHOiNpk9w4K7zKPAzo76SW3nKthy1xIZcqnSSRORSsQpk7Vw3NZ
	BndDPnMuHH+rqPIVnFr1GBmqjGZz2cDyMr1LQW/A3AoUm/Cjs7gi35c2S5aeVu3oiJ0otwA5vJV
	559bkqt3HT2TAZLhCasMMBlBL2u6n3gYGh4RFTg8DthSoW9m5gXn0lfDqU6CPllLkR7Elb4Ufsw
	ErnwBXmoXmuLqNPEFqesCsGMaqFyN05r1QQbsiLgZxZvLcKsGzOOw==
X-Google-Smtp-Source: AGHT+IEY7zjkNVI5yJ5SkMTDb1v2zTwA60kE/oy5BUWvi/5nVDLfJfu5OJsU4IgBMi2nQ3hiXgQQ1w==
X-Received: by 2002:a17:90b:3884:b0:2ee:c9b6:4c42 with SMTP id 98e67ed59e1d1-2f28fb64a91mr21209603a91.16.1734373625506;
        Mon, 16 Dec 2024 10:27:05 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2449873sm5026403a91.44.2024.12.16.10.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:27:04 -0800 (PST)
Message-ID: <49407656def0054fb62c47907c2338bfc36df47e.camel@gmail.com>
Subject: Re: [PATCH] bpf: do not inline bpf_get_smp_processor_id() with
 CONFIG_SMP disabled
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrea Righi <arighi@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, John Fastabend	
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 	bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 16 Dec 2024 10:26:59 -0800
In-Reply-To: <Z2BiWTcp-CnC5cCz@gpd3>
References: <20241216104615.503706-1-arighi@nvidia.com>
	 <5e7c4b07-f5f0-400f-a84f-36699f867a4a@iogearbox.net>
	 <Z2BiWTcp-CnC5cCz@gpd3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-16 at 18:24 +0100, Andrea Righi wrote:
> On Mon, Dec 16, 2024 at 05:16:33PM +0100, Daniel Borkmann wrote:
> > On 12/16/24 11:46 AM, Andrea Righi wrote:
> > > Calling bpf_get_smp_processor_id() in a kernel with CONFIG_SMP disabl=
ed
> > > can trigger the following bug, as pcpu_hot is unavailable:
> > >=20
> > > [    8.471774] BUG: unable to handle page fault for address: 00000000=
936a290c
> > > [    8.471849] #PF: supervisor read access in kernel mode
> > > [    8.471881] #PF: error_code(0x0000) - not-present page
> > >=20
> > > Fix by preventing the inlining of bpf_get_smp_processor_id() when
> > > CONFIG_SMP disabled.
> > >=20
> > > Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> >=20
> > lgtm, but can't we instead do sth like this :
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f7f892a52a37..761c70899754 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -21281,11 +21281,15 @@ static int do_misc_fixups(struct bpf_verifier=
_env *env)
> >  			 * changed in some incompatible and hard to support
> >  			 * way, it's fine to back out this inlining logic
> >  			 */
> > +#ifdef CONFIG_SMP
> >  			insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_=
hot.cpu_number);
> >  			insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> >  			insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
> >  			cnt =3D 3;
> > -
> > +#else
> > +			BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0),
> > +			cnt =3D 1;
> > +#endif
> >  			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> >  			if (!new_prog)
> >  				return -ENOMEM;
>=20
> That works as well (just tested) and it's probably better since we're
> basically inlining the return 0. Do you want me to send a v2 with this?

I think both Andrea's and Daniel's versions of the fix are good.
Note, however, that I missed one more configuration variable when
making bpf_get_smp_processor_id() inlinable: CONFIG_DEBUG_PREEMPT.

Helper body:

    BPF_CALL_0(bpf_get_smp_processor_id)
    {
    	return smp_processor_id();
    }

smp_processor_id definition:

    #ifdef CONFIG_DEBUG_PREEMPT
      extern unsigned int debug_smp_processor_id(void);
    # define smp_processor_id() debug_smp_processor_id()
    #else
    # define smp_processor_id() __smp_processor_id()
    #endif

Thanks,
Eduard.


