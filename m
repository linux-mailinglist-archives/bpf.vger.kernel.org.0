Return-Path: <bpf+bounces-76715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D9CC36D2
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 15:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDEC530E64DA
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79280365A0D;
	Tue, 16 Dec 2025 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b8Y6ScLo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17983364E9B
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893629; cv=none; b=o51hgU+2ErtWZHlZwLBLmwVdHm4q+iPJBluzlG8rOVNo1vgF6JPc1/HGsKyPs+Yva7jMlhlOM9wPYHDCPKRh3ZfCcM43rmnfQCK0ea6M1YSUcHKhgleDryMHdjTvMiNT1tAsM1aigMQstKPXjkmCO5tXm+pPhJYSAw4SvWGoJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893629; c=relaxed/simple;
	bh=oo331MyVoc+k3UZL6I7kuvuEyuD++kbF4dU3KtoNNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdfuoHWEk9ThQtvLLbPYpwP2zKrRk6SnsxROkdjxFGNDhYYocrUcUZQW1WSRApji2UFvxuNKUF/fmG1HhAg/BneG0/FDAfM17pV8VLaR/SlDU1J5tftaHoScOJBPPnYmIdJSMrgsXF/Yyljg1yMgHQ+qxY4Rc37nM6zm3tkTPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b8Y6ScLo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-430f57cd471so1427273f8f.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 06:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765893625; x=1766498425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KL96hyDg6qSdwafAtR/5W1zXZLQQAbfSahId8IWk8M0=;
        b=b8Y6ScLoX5CWuU5ef57/9McoGZWMx0ykOvsSKm4b7UvYiKdmD3CwN0uKerpIY9XF9/
         JQZH8ImxB4fww4Ho1kNeL0EVA4UBf9ACX6lvLBBtG8soFak/seqA5KwDYYbKmVEWRuZG
         o0fCJoS2x38q4b6miFoIJ7feIPURndgsaLkASOt1t0F4eb8KNs1chPWrZufgxv0hqinY
         bvlX2fJH6t764FCoHe7bD97P6O9okEz5MKjzBmnf4wwH0L0EqLKjShA+9yIGOkfqan8i
         ys57tB7dh1aSRWjOGzSeBl55LSE1Os4fwnexqjrcY7rPE8nYYV5ZUPwFlwYLfMgmC6oB
         SaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765893625; x=1766498425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL96hyDg6qSdwafAtR/5W1zXZLQQAbfSahId8IWk8M0=;
        b=RU93eZwZRASEy5N2YXr4ToMrUD8Y0BSuyDQA5G2liyU4/7+UppFiGJVQvL0jwRqG8z
         +hmBgE7ayIem4sn8hrMRqgIfWm5RnvL4VsBU75Ux80VFFbsUPfIK2Bm6mSvtiVUDzbWf
         BJOYKts3I3I3L1vse1X0VDMqCRv1xom/ROEFgGJ3A7KZ+e3Rg8ZdP3nkGsnl/qqqlqLe
         1faQy2v3/byh+InAOijSLimLsUZNi5A/CJ6wrJaQg0xvjbp5PtDy0nDydokiJ7L31joY
         hgsbFD2AInmPO37V+SbuNaYvYnxyO+YWTH5dg+7xplcTr74vcHoHEJ5bRedPylSmmlPg
         ciAA==
X-Forwarded-Encrypted: i=1; AJvYcCWRVWgnUh6wydV5tEKiTAOPUEyKkqtv9I0sdYl5/lAt4MkSm514mbGDagRGetUpyT8t36s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBVtR8+2AWD08wkXVqr4bseK+4p8JKzODuWsd2vaZdCdgm9Li
	pToN5p0o/KYXSHAJ5A1XqibqQ0qkWR8bh3SiXR/5EV0l4hTeEEr+r2v2sdoT4cm669w=
X-Gm-Gg: AY/fxX6z2CrVD+8jmWcz3Skc91H96TYlsV5mR+WQRVlzH+3lrSDQDKur7zxRd4YH2QP
	yhnsbOux9HSuaOD+nLIm+PqT2KLk+YPPC0uoev54+bYfYB4Nkp1VVvrdAGTmPT293tfVjtuIUcd
	psnXu2qNxtYJ8yb1c+apFWPn19uofpgD6s56YWB6ivxCrjE3b7k4L14+AvH9B6sXOzEE0wSNug+
	z38ZxcPmA9yysa024rfj3erCv8hq1hb+K4FbkeIqr8JVrSRoV2EKFfW+TYUL4fsXfjfEGHQgUa1
	kTAUGyOqsfJFUG3+BblfDN/FZPwHQghRNTNdn2AJFIOijXdPZ1EPtsIZTrH2xgvc8vsdPKXaEUA
	WjM7bLFKONViIEwCJMwcjldRa3D+kxgv/hkM21bm1kf7OvamNETqJp+4DixowCh5dzdzS8LwhDl
	ytRqzovTzDwtxalQ==
X-Google-Smtp-Source: AGHT+IEvNNp/GFZ2IQ7L7fWWzVzKQJ39p1H+1gouoPgfCo05L1mXn72S5xo0BtukHnsmhWUV5hIWfw==
X-Received: by 2002:a05:6000:2585:b0:431:8bf:f07c with SMTP id ffacd0b85a97d-43108bff231mr1464493f8f.9.1765893625280;
        Tue, 16 Dec 2025 06:00:25 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43009dfe5b3sm24065754f8f.39.2025.12.16.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:00:24 -0800 (PST)
Date: Tue, 16 Dec 2025 15:00:22 +0100
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kallsyms: Prevent invalid access when showing
 module buildid
Message-ID: <aUFl9n3b8DWnYGyJ@pathway.suse.cz>
References: <20251128135920.217303-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128135920.217303-1-pmladek@suse.com>

Hi,

I wonder who could take this patchset.

IMHO, the failed test report is bogus. The system went out of memory.
Anyway, the info provided by the mail is not enough for debugging.

IMHO. this patchset is ready for linux-next. Unfortunately, kallsyms
do not have any dedicated maintainer. I though about Kees (hardening)
or Andrew (core stuff). Or I could take it via printk tree.

Best Regards,
Petr

On Fri 2025-11-28 14:59:13, Petr Mladek wrote:
> This patchset is cleaning up kallsyms code related to module buildid.
> It is fixing an invalid access when printing backtraces, see [v1] for
> more details:
> 
>   + 1st..4th patches are preparatory.
> 
>   + 5th and 6th patches are fixing bpf and ftrace related APIs.
> 
>   + 7th patch prevents a potential race.
> 
> 
> Changes against [v2]:
> 
>   + Fixed typos in commit message [Alexei]
> 
>   + Added Acks [Alexei]
> 
> 
> Changes against [v1]:
> 
>   + Added existing Reviewed-by tags.
> 
>   + Shuffled patches to update the kallsyms_lookup_buildid() initialization
>     code 1st.
> 
>   + Initialized also *modname and *modbuildid in kallsyms_lookup_buildid().
> 
>   + Renamed __bpf_address_lookup() to bpf_address_lookup() and used it
>     in kallsyms_lookup_buildid(). Did this instead of passing @modbuildid
>     parameter just to clear it.
> 
> 
> [v1] https://lore.kernel.org/r/20251105142319.1139183-1-pmladek@suse.com
> [v2] https://lore.kernel.org/r/20251112142003.182062-1-pmladek@suse.com
> 
> 
> Petr Mladek (7):
>   kallsyms: Clean up @namebuf initialization in
>     kallsyms_lookup_buildid()
>   kallsyms: Clean up modname and modbuildid initialization in
>     kallsyms_lookup_buildid()
>   module: Add helper function for reading module_buildid()
>   kallsyms: Cleanup code for appending the module buildid
>   kallsyms/bpf: Rename __bpf_address_lookup() to bpf_address_lookup()
>   kallsyms/ftrace: Set module buildid in ftrace_mod_address_lookup()
>   kallsyms: Prevent module removal when printing module name and buildid
> 
>  arch/arm64/net/bpf_jit_comp.c   |  2 +-
>  arch/powerpc/net/bpf_jit_comp.c |  2 +-
>  include/linux/filter.h          | 26 ++----------
>  include/linux/ftrace.h          |  6 ++-
>  include/linux/module.h          |  9 ++++
>  kernel/bpf/core.c               |  4 +-
>  kernel/kallsyms.c               | 73 ++++++++++++++++++++++++---------
>  kernel/module/kallsyms.c        |  9 +---
>  kernel/trace/ftrace.c           |  5 ++-
>  9 files changed, 81 insertions(+), 55 deletions(-)
> 
> -- 
> 2.52.0

