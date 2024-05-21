Return-Path: <bpf+bounces-30136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0638CB285
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA3283CDB
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F95F130A54;
	Tue, 21 May 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSKrLQqr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE911799D;
	Tue, 21 May 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310460; cv=none; b=H/e0WhxmlEiMDi/hFTgeFxRDQzYp6vcgYwivCBVMsQaUuQzUtyoFUbjGnL47g8Qq0WjaChjF2IL9FSczqvJDu7rGY5AnGRKQen1HZYTlnCt00h+f1Hu/lhR1WdOMzdz42Iul7BS3H3/oo7m8X+JS8uarzWJ+8xG3PJp0pDOa6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310460; c=relaxed/simple;
	bh=+vtfrcRqf77D03066rTOmGDjG3OT3H/KHdFfQBL6VIM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbiWBmWjcSQmW8Wi3vMkgQz8k59IoEavuILAyiPxd4tIoMqmBr3HmxViclwabe90ij+a7aqGH1VyEOewiJxsFefhoy9dtfXe0TooLR5/wTjV6qn0fQbw9xZMZPBZEYcfNEYX2vp/6iW79jeRGXWtby0Nvk8/0uNLOciWTzmB2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSKrLQqr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a621cb07d8fso19116266b.2;
        Tue, 21 May 2024 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716310457; x=1716915257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iog+LV8+cUjTXWrVLrD8l3qRhz72G5h5/sZmX6riTd4=;
        b=lSKrLQqrCrO0Aur6CBDOaFBxwcZIsz/2FgYWfsiqLPvnEXnX+cDkRpUhyJbvKN7C7m
         37qmaqcIMF3aIsfQx7A1s5VGJMHjeqbS7eKVrsgxOhf9wJt3OhfOrGHXVzAMCSRBzwpi
         ZPHbl99qju08vyExwz0Fh1Vb/eawPrlKMizNZGznppmZPW6i3zBQs/kaB71EZ1jXjU+t
         gLE/4h0szmLaH+7xI56cgfJhgxDlogZzimVJw1Unzy9gU7p3/YCc0YMHyLoZt7OeW6jp
         rb6a7X1Sxn3a4fr/nXK1VCYffvsBPVoHdx9URNlimTDtcG6GImNEpRw0mGaEFHgNRGTt
         AZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310457; x=1716915257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iog+LV8+cUjTXWrVLrD8l3qRhz72G5h5/sZmX6riTd4=;
        b=BVgp97lOOTJWq/Nvn6fUVqCVaEWymHmMSJnkZOkcfMi4cDSNXbXXMRXpSOU68j6pJD
         pMXONZkkMTdol6ynXpBGqLcOoWlmttb9oPvM4Ed8yLhcJ1r4doq97+qKuy0RHYOllZZ2
         hU0NwG4DBXmECoxH0iK3dqYPYNx8S2PHGeW1qz2dhtRH2Zgr5306gMdmcElzZLkX3aSH
         qL1VEx0bla9nAVQZIKrYIp4/ESUIKzhtLjd5LNgbbj6RmBQxR6jvmC/+HlmdX6/lr0g5
         9DdLxBLdJdnDRMtyRt1p7zu7VW0D+Ocz3uBENBeDQHJYJ45nEPzO++AnxmNiGUccnBqP
         cqmw==
X-Forwarded-Encrypted: i=1; AJvYcCWpB/N72P5GElmuTSsCTMSkzz2WfCl/KKlEczh5faZbZ2C6n0/+rMIwJTuTorVUqCRfCtkPLSsfgsnB22v+cOuWNcM057Mkb6L0mw9So7FqaC9g/dvTX1CU9CknWjk+H+T4TJ5oQZskPjvZijPyawA6hJwRCfhwAXyzhnFcbBNxOKOj8ECEAUlmFe1wGuGiPu9xsoLs1jaItPqfo0mJKZDmjwYQQOFqsdSedutELQWMfW+HZsQUPrMU2fkT
X-Gm-Message-State: AOJu0Yw+5Og7oyeQqzSAI070x8Yne8pIoLRCk7RQc0V4OYqIkylSQIVI
	zQ5N+tljMkc9hXhvIzCSggBDim+0y3S2OKAAn8WBH0EQMXMg1e4X
X-Google-Smtp-Source: AGHT+IHihcWtHfnN1F+F4jj7X3d2CSrOlvQTa629P5Jl56OpV1qeh7unKFtsHyiUf9ptGT/xBAvQLQ==
X-Received: by 2002:a17:907:77cd:b0:a58:e71d:d74 with SMTP id a640c23a62f3a-a5a2d55a8c7mr2386588366b.13.1716310456605;
        Tue, 21 May 2024 09:54:16 -0700 (PDT)
Received: from krava ([83.240.61.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d342sm1645720066b.6.2024.05.21.09.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 09:54:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 May 2024 18:54:13 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv6 bpf-next 1/9] x86/shstk: Make return uprobe work with
 shadow stack
Message-ID: <ZkzRtTI72YPAMhIp@krava>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-2-jolsa@kernel.org>
 <20240521142221.GA19434@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521142221.GA19434@redhat.com>

On Tue, May 21, 2024 at 04:22:21PM +0200, Oleg Nesterov wrote:
> On 05/21, Jiri Olsa wrote:
> >
> > Currently the application with enabled shadow stack will crash
> > if it sets up return uprobe. The reason is the uretprobe kernel
> > code changes the user space task's stack, but does not update
> > shadow stack accordingly.
> >
> > Adding new functions to update values on shadow stack and using
> > them in uprobe code to keep shadow stack in sync with uretprobe
> > changes to user stack.
> 
> I don't think my ack has any value in this area but looks good to me.
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> 
> > Fixes: 8b1c23543436 ("x86/shstk: Add return uprobe support")
> 
> Hmm... Was this commit ever applied?

should have been:
  488af8ea7131 x86/shstk: Wire in shadow stack interface

will send new version

thanks,
jirka

> 
> Oleg.
> 

