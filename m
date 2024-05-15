Return-Path: <bpf+bounces-29767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D298C68E4
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC89F1C21B74
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807D6155730;
	Wed, 15 May 2024 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAJGhgAy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98FE145B1B;
	Wed, 15 May 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783770; cv=none; b=IoDtnFmLERHiqZJAlfNcAPpseGWwyKp2guf/W6IxaWp/SgINmf0ASNFKJ0npN1i/fWugcg1R++e+E97AFx3FnG7vyH4BkHEN5mEQOcMrAtVcis/8pW+1v75wemnl7Negd4s7p/rJd8HT/2wIAlnJ2P0HsglfkgTBR3LSConWn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783770; c=relaxed/simple;
	bh=v0/BK2yo6D0HmXUHcm3GIq3kIfESRAEZE0OJMyRY6yk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZZBhYPLmwr54JcITy2KeTngnqMzNGRIH5v+5mQP7CbRdo79r7sb7YQLWeXtZ5sLmXYbHlvZufBw+mSTjlGoTkJrwohP2qaLiCGpfg7uZDZCcSm1rMxjRpbK2/DoU70Panako5M3eUIEW6nEH3aSk+PpmZzZeZID7BYHGMiMbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAJGhgAy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f08442b7bcso17627165ad.1;
        Wed, 15 May 2024 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715783768; x=1716388568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWssvw+tkze5cYj9060HrB4qYTJQkyrlcfUG/7N3/dU=;
        b=RAJGhgAyrQtrO6bqQEVCU5RRsevmr5wewnUfzz/djq9SR4A9hr7Hqwq1QLymg3OCpo
         x6TTbmPy96UNPm57YBw3KSk6akpkjCfD7CinIY94lGr2c5rao8bECQPDu/ORKFR3/S1k
         jYc1LawGRoztPKKMkLtu6FYmBxt9EWls/J7erHIwHu79RLa4q0f1aKaduVCKFj1WjhBb
         AwS3tdruPhTygnwBIi06vcD8ziMSmXvoVfylB3dN+gLG7Ba55/+3FqqjOPMAsYxriipp
         hC/NNFvnkfUon4qqyj9ZqemCHEJO1RkexErnJvVqO2sn8kcrzX2zsDk8xW50nrFBNoxo
         lRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715783768; x=1716388568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWssvw+tkze5cYj9060HrB4qYTJQkyrlcfUG/7N3/dU=;
        b=TBQTgECfGGZShCtzwK8c9v55rrqfZYRLN/kz7+jRkt+wlso6lb8jN2qnVj8kxPLWW0
         fO0q5hQtXroeY73toyNg/b+Grb1fHrKaM7PZO82Nv3tiTJ/h5LOxLkZkZA5Uh83l5g3Z
         4YenL945MUuT8rpxlWVplJ4oPt8bnMm8qWs1Zgflzo38DmMh4JDDmbVZL8Y52LPDiOjy
         o2YEd4/0BqzT7U8KTq2YG1Hzi/f20DpeZPVflx6T8CwpKMFEXiof6HWvux66cTwRGzA1
         d3GB5LFAibMbPKgav3jJZS2vw8Po1mioUU+xtg1gva9V59XBv6nnsgD0ffMD4YaToakJ
         SiOw==
X-Forwarded-Encrypted: i=1; AJvYcCVoXatuy+UEn2Af9JoTSqkhwJoVlhl8bZZRDU6Z+AvFGHANLzn9piTqRRvs6BpO+tcWN37rfUmwVWKI0LP70Hw6eH/qgdJ1xeMMEHuuO+lM5qGOuljDVisaA1oo7oat+wAqN7F/4XJc9V5fFHZq702VWUhPgAGf2K6YeEDQRuQ5GxKeucl5i5RM4xExliK3YuB14RugEdSV6TpeajC4uie1NKUzeJsmFBT9QMeUy+gZnsxCcWs+Jfq2GZEG
X-Gm-Message-State: AOJu0YysNdfebqgO3GvpX9K9e5zQrfOyXybkaYT/03RaOjKIteWymfFo
	GcaoX2EVEtbgdglpGG0E2g7ryV1SSFp3gUhujSftNfABuAOwVCHA
X-Google-Smtp-Source: AGHT+IF+zwFopeo4D3oy7EAAwNuOttr7vOSCB03BUtkMTfZ5yoVJmDJ1HAG/zQN4JI1sjFOB51fwPA==
X-Received: by 2002:a17:903:228d:b0:1e5:a3b2:3dad with SMTP id d9443c01a7336-1ef43f51f2cmr209886835ad.42.1715783767774;
        Wed, 15 May 2024 07:36:07 -0700 (PDT)
Received: from krava ([76.8.218.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30fc7sm118608255ad.133.2024.05.15.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 07:36:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 May 2024 08:36:03 -0600
To: Oleg Nesterov <oleg@redhat.com>
Cc: Deepak Gupta <debug@rivosinc.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"olsajiri@gmail.com" <olsajiri@gmail.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"yhs@fb.com" <yhs@fb.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <ZkTIU1QUAJF0f0KK@krava>
References: <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
 <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
 <ZkKE3qT1X_Jirb92@krava>
 <3e15152888d543d2ee4e5a1d75298c80aa946659.camel@intel.com>
 <ZkQTgQ3aKU4MAjPu@debug.ba.rivosinc.com>
 <20240515111919.GA6821@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515111919.GA6821@redhat.com>

On Wed, May 15, 2024 at 01:19:20PM +0200, Oleg Nesterov wrote:
> Sorry for the late reply, I was on PTO.
> 
> On 05/14, Deepak Gupta wrote:
> >
> > Question,
> >
> > Is it kernel who is maintaining all return probes, meaning original return addresses
> > are saved in kernel data structures on per task basis.
> 
> Yes. task_struct->utask->return_instances
> 
> See prepare_uretprobe() which inserts the new return_instance with
> ->orig_ret_vaddr = original return addresses
> when the tracee enters the ret-probed function.
> 
> > Once uretprobe did its job then
> > its kernel who is ensuring return to original return address ?
> 
> Yes. See instruction_pointer_set(regs, ri->orig_ret_vaddr) in
> handle_trampoline().
> 
> 
> 
> I know absolutely nothing about the shadow stacks, trying to read
> Documentation/arch/x86/shstk.rst but it doesn't tell me too much...
> Where can I find more documentation? I didn't try to google yet.
> 
> 	Upon function return, the processor pops the shadow stack copy
> 	and compares it to the normal stack copy. If the two differ, the
> 	processor raises a control-protection fault.
> 
> grep-grep-grep... exc_control_protection I guess.
> 
> Let me ask a couple of really stupid questions. What if the shadow stack
> is "shorter" than the normal stack? I mean,
> 
> 	enable_shstk()
> 	{
> 		prctl(ARCH_SHSTK_SHSTK);
> 	}
> 
> what happens when enable_shstk() returns?

I think it will crash, there's explanation in the comment in
tools/testing/selftests/x86/test_shadow_stack.c test

that's why ARCH_PRCTL is using syscall instruction directly and
not calling syscall function

jirka

> And what is the purpose of fpregs_lock_and_load() ? Why do we need to
> fpregs_restore_userregs() in shstk_setup() and other places?
> 
> Oleg.
> 

