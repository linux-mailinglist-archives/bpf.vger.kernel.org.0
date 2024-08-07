Return-Path: <bpf+bounces-36620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C76494B140
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 22:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEC31C20C13
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947B0145B18;
	Wed,  7 Aug 2024 20:27:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21113DDC0;
	Wed,  7 Aug 2024 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062459; cv=none; b=DWZcZh3OISmh3SMblu+tNnWBF+5CjpxJovPvyEtp2u7qZoy7Lcb9HTH0UE7l/xcupGFrFYsrWRWM0axszmZNPoKeh3TfRAbOfWCIyDtYYT0g225MfUbOY+YfyumqkHi/qhk0lFX59ItNaYweZr8/OcEqW/sHYlRIIDHykZRthu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062459; c=relaxed/simple;
	bh=kWzeeeEWflSkWrZ7uE+UJrYood+eEW8LK3yF5WzZ8p8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7l2JDCJQ4ugoCnOGnqnwYbvXQQ7/npnMinubp00RZ63EDKdGvDkt/dx0xL11azQwyrz9OY9Sve5UGOO0CV9MQ95a3XROv/CK/QLr7xrKRFu1zxY5MI6xhIEXT2QSGfK6HSNGypkWmR1WwOv9oC+daeoTB6dLF/jYzuj7oWxAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505C7C32781;
	Wed,  7 Aug 2024 20:27:36 +0000 (UTC)
Date: Wed, 7 Aug 2024 16:27:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo
 Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv8 9/9] man2: Add uretprobe syscall page
Message-ID: <20240807162734.100d3b55@gandalf.local.home>
In-Reply-To: <3pc746tolavkbac4n62ku5h4qqkbcinvttvcnkib6nxvzzfzym@k6vozf6totdw>
References: <20240611112158.40795-1-jolsa@kernel.org>
	<20240611112158.40795-10-jolsa@kernel.org>
	<20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>
	<3pc746tolavkbac4n62ku5h4qqkbcinvttvcnkib6nxvzzfzym@k6vozf6totdw>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 16:49:24 +0200
Alejandro Colomar <alx@kernel.org> wrote:

> Hi,
> 
> On Tue, Jun 11, 2024 at 11:30:22PM GMT, Masami Hiramatsu wrote:
> > On Tue, 11 Jun 2024 13:21:58 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> >   
> > > Adding man page for new uretprobe syscall.
> > > 
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Reviewed-by: Alejandro Colomar <alx@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>  
> > 
> > This looks good to me.
> > 
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > And this needs to be picked by linux-man@ project.  
> 
> Yup; please ping me when the rest is merged and I should pick it.

Just in case nobody pinged you, the rest of the series is now in Linus's
tree.

-- Steve


> 
> Have a lovely day!
> Alex
> 

