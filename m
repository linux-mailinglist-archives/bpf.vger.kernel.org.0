Return-Path: <bpf+bounces-79305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A80DFD337C1
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848FA302E730
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C6E393412;
	Fri, 16 Jan 2026 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcrL0aEv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A40B33B6D4
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580737; cv=none; b=Lg7oxZJaUjq29z2vrBVJzfMSVw8MYnP2KHXhuQ4t4tsvsH1FU9Rd4mKvDRyQSEpLu/PBtHLRnzI6tDIvsthN6z+RoK8YnW0Tkyp6zWFfDg49RKC3lSiE+zzYVD6sxl2ktc98nT1Eg5vzSbY+OL7xfVzKFsidklEQJEU5lHTrrXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580737; c=relaxed/simple;
	bh=dOKj0/JK7OfvnTn0dixbyXshDUTrP+3ndLaxK3a9PWo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYB/BXaikxRqyqlEfgfmwWCghMb2q1NV6coyuomXaWaVxh0dKNWjLL29rb7VbrPaimf2yvxE+yZmQJvVYT9tlUXdhZ8WpSOLnjJdfgqHomLS85xNwcwG+sD3p7dI5xdFuBsLiXu3F3HFY5UKuHdtlDS0CTSdg/K9q0MGJGJrdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcrL0aEv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-480142406b3so10909895e9.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 08:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768580734; x=1769185534; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vvgJzVvJv7PbyEtTqGfnd9wooDAN3oVwv00PlCPZZ2c=;
        b=AcrL0aEvytlNQWXUuRUxGYiS/zZSJSo/ugnf2pBLntmt5vIgRHS4ySffKvdArYy3EL
         jvs61HcLTIDVfAfMrgZHSU9HY9nLUQOhnIcxlYfPihYxqKFgPuo8aOc7PjfF3Aigfzc9
         smOh0DmZScbAJDa1IiYLu3mKWi6k/dzxX9yLPWf30UfcTzliAYFRX4IZYH46fjJryShA
         wG2PVKdFbMZqdAfoe//BBnoCCB/h7fAPXFXE0vg4wvdrNiq8vxitDplEBoLr74yVWllZ
         +w65oIdaYcMMksXUyw2ne1E0cY8bCZVjq/Aux2Zn1x/WEcaZM3EB7wBk4okywhZXb+Fo
         e+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768580734; x=1769185534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvgJzVvJv7PbyEtTqGfnd9wooDAN3oVwv00PlCPZZ2c=;
        b=Ai+QdNLcp4hW4dTiidTl5KzZfqKm5F8DTogbWGmgSJeIn9xIbvl+Bn3WlAwoPy9ZRf
         CDaPL9fTNZubQk8X5QLsEM7uFaFDBn3rIZ7HSbTOa+TNqU+b2dLSWqH/L9fGe/nZizCc
         l29lig+oNiwbGh7CsK0ifmRwUjefCdjH/D8EgORIrHokaiHueCsVv1UHo9w3euTryN3K
         F5v9zEVovHiJh1saWWdu0atM4NbGZpHqWsPF56g17CkYKhnFe+4cjd4pgqOz46nEhBDe
         x2r6HRZ7va9W6uJN8vmf4dCRrTBDTibEuCYYMtImQrnw3wXst02FMlNQQND5DK7Lpej6
         +1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWb/bItAQQVJd7xMXMjN21pIDdkcpEt91K8T5ApJoBX3uF+zWt4Tt57ouaipEpkrZNs0Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLVSKdQKhzD+soNe7ERyOj1GkVcrw0PFFoE3y8hg28mbV6/yP
	1oa8hom/HAgpIyyn+H3mQB+GzVuw4lvEdfeTKK5LjR1TcdpDY6TyosKS
X-Gm-Gg: AY/fxX6EREQsCoALj19q3e4OSpld1SiRvnF/OKRVCYntB3iUXmvTgNvQrbMfmZsLNOP
	iCVvByVr8sWeZFBy3iUHEyb3SdZeQB1CpmO9tRClb05ku8EgPAFeW0XN5HadfNBQ8qvzkWFk3fE
	zplvq1nZuw9xda+GXDD//zhXPm2IYsYF9bq5T1hfHcUAh1HItCTzXOXSkX1aJ91tl66byBFdU2C
	zB3m5lC4b6JSFjTbYXHniZN5/HAlPlz+xF9/6wsXqi8yFJnH10kIGU0+QuOYwZ+EQBpKV5XVlsQ
	y9RDgkeYIJv8CNQUAr/Wd7h4akk395rPm76y7laTmvTT0cA5cApSJIiGE2yhjcGaq66KYUqqwhe
	3Lomqtabin3+0OLgAo9rUn9fCWhthouc0F68yRGpR1PE3aSjkXzFCWYx/bPTIQ6UW9M4GcetL6N
	fsXLA=
X-Received: by 2002:a05:600c:1f12:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4801e2fc37bmr38539825e9.3.1768580734380;
        Fri, 16 Jan 2026 08:25:34 -0800 (PST)
Received: from krava ([2a00:102a:400f:3ccc:ffd6:980:bac0:cb06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e879542sm53017165e9.4.2026.01.16.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:25:34 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 Jan 2026 17:25:31 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 2/4] x86/fgraph,bpf: Switch kprobe_multi program
 stack unwind to hw_regs path
Message-ID: <aWpme7kBw9xyzRFP@krava>
References: <20260112214940.1222115-1-jolsa@kernel.org>
 <20260112214940.1222115-3-jolsa@kernel.org>
 <20260112170757.4e41c0d8@gandalf.local.home>
 <aWYv6864cdO2PWbb@krava>
 <CAEf4BzZ-sPD4UZF-TL2ep-zQOyeOC3K5XC2o3Gsx4Q6XpN-zQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ-sPD4UZF-TL2ep-zQOyeOC3K5XC2o3Gsx4Q6XpN-zQw@mail.gmail.com>

On Thu, Jan 15, 2026 at 10:52:04AM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 13, 2026 at 3:43 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jan 12, 2026 at 05:07:57PM -0500, Steven Rostedt wrote:
> > > On Mon, 12 Jan 2026 22:49:38 +0100
> > > Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > > To recreate same stack setup for return probe as we have for entry
> > > > probe, we set the instruction pointer to the attached function address,
> > > > which gets us the same unwind setup and same stack trace.
> > > >
> > > > With the fix, entry probe:
> > > >
> > > >   # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
> > > >   Attaching 1 probe...
> > > >
> > > >         __x64_sys_newuname+9
> > > >         do_syscall_64+134
> > > >         entry_SYSCALL_64_after_hwframe+118
> > > >
> > > > return probe:
> > > >
> > > >   # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
> > > >   Attaching 1 probe...
> > > >
> > > >         __x64_sys_newuname+4
> > > >         do_syscall_64+134
> > > >         entry_SYSCALL_64_after_hwframe+118
> > >
> > > But is this really correct?
> > >
> > > The stack trace of the return from __x86_sys_newuname is from offset "+4".
> > >
> > > The stack trace from entry is offset "+9". Isn't it confusing that the
> > > offset is likely not from the return portion of that function?
> >
> > right, makes sense.. so standard kprobe actualy skips attached function
> > (__x86_sys_newuname) on return probe stacktrace.. perhaps we should do
> > the same for kprobe_multi
> 
> but it is quite nice to see what function we were kretprobing,
> actually...

IIUC Steven doesn't like the wrong +offset that comes from entry probe,
maybe we could have func+(ADDRESS_OF_RET+1) ..but not sure how hard that
would be

still.. you always have the attached function ip when you get the stacktrace,
so I'm not sure how usefull it's to have it in stacktrace as well.. you can
always add it yourself


> How hard would it be to support that for singular kprobe
> as well? And what does fexit's stack trace show for such case?

I think we will get the bpf_program address, so we see the attached
function in stacktrace, will check

thanks,
jirka

