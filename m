Return-Path: <bpf+bounces-33072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154A916E19
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 18:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328121C21E98
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A2174EC5;
	Tue, 25 Jun 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh0H7Ayj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE5017333B
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332803; cv=none; b=BeDDerEdhKRvqAzye9TzDOLpLO+w24cTewXJlcdCrl4aE+efYSaRpFTtlmwUWHijf9imOObRVsJ6WrFa/p9mWaABLa1G5SRdETcLFFG4SUk1AwZtd/skC3mBF6CgqUcie8C6pS94LOWcH7k+KCiP7rQaql1L1zDz17pFP8HYSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332803; c=relaxed/simple;
	bh=LLciHxb6G2sJPGIv53Tqk5AgX9q/t8C4jhnVNYTaFcc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ove5Bf4c7/+gA9qP7UWrwVOMECeaa92RGbhahTI+8ZShKf0lCHCSSjqTDK1nlCDdnt/odkqO+4F9dRZ8CaimVPUKuingiMIJ7XA3HJ6zdGk9MDtnV4nzpsv2+tKC0fkU0mPlF29e3pEEJR6HroVv6Mx57tJk+nJKw18A3qAPInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh0H7Ayj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so6728354a12.0
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719332799; x=1719937599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSIh8W8JzKZZqKFQl+p3EevzPsIOBEp3bHiTm6l4HFc=;
        b=gh0H7AyjCPjXH9q59E/q0lR/oW7hq45yVexJ7xxYafKD+XPka7sn+E1xEDfdxPeF8x
         eAtsvKidi5RdV4nz1LdSKLvRTkxD4IOsvBxwHf+U1PV4swX2a7AY4ohQkIr5LQV73LoX
         5S+64IWBnmAcgGzksJVOUhbmCR76TkQwEaxgD6DQdXjcED14zGN1t3MTQVu7A0yTI+pH
         zmTOxMd5wh4tn6FABZGnPqc+87kxfGcRSEKRL/D7EKLEM5k4uaZioMyqylqlmIg7tyv8
         FDbyOmH7G8cJQJAqgwV5WBXNwAmF2muANiUU/YIItFtqfHXt0tOmxRvEHrlbXSlAG98Q
         Dksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719332799; x=1719937599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSIh8W8JzKZZqKFQl+p3EevzPsIOBEp3bHiTm6l4HFc=;
        b=LKfZ/PB9xyF2zQKdzz1A1uZJheZY8HAMCkSFsnCwjDxCejSlC9dS3Yww3Rhxt/zofu
         rHJqD/FM0Ybog5QpJSoQOABDySN9zd9LH4b80lwucCHGkqzt6psHZ47LkzkZb/LwrxJ0
         47OBwGho14ewMD9dqv1d2vwfQi+sEOpbbe4LIMDRaWX3zW8dkejJenynLbjtTdxvIyq5
         r3u1zFZaN/Ypx1TNakpXi8xzf5MQsA65DL/4piZ3wCfcd7ZcYpba7Xk9LDyNI+nFBjrP
         ExgyafUw8IWOMIiLKvBxIGbYL4AQ5rZJeERQBYlX9zLANCwkvP499y745hDyMswWH9zN
         WgjA==
X-Forwarded-Encrypted: i=1; AJvYcCVC3ZYVgleCLXs2Du921OFf+BSuuJUI2OAiMg8Kmhmhjlr0LVnPsYk0DFgSrINxFyk1DAVrPfUG05Di/jAdZsnMm4hb
X-Gm-Message-State: AOJu0Yw6xOz3+6Ivcv8eqcpj0BfNGQjJeRaZeL3OJqSzhfmSG9Iw0Vk4
	WP+7Jg0KvPfQfxAxH3COK5OxHyg7JBzM8hYxY31ualb2HNCKUgTq
X-Google-Smtp-Source: AGHT+IHpkATykEL71z2fzjA1SLTF6vLU2nijq/9IlbyDP4x5DhSgYSprsx8vkBrwJaNIfJzVBswhBw==
X-Received: by 2002:a50:c056:0:b0:57c:5eed:4ebf with SMTP id 4fb4d7f45d1cf-57d4bd79d81mr7633280a12.19.1719332799086;
        Tue, 25 Jun 2024 09:26:39 -0700 (PDT)
Received: from krava (net-93-147-243-244.cust.vodafonedsl.it. [93.147.243.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303da254sm6107889a12.1.2024.06.25.09.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:26:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 25 Jun 2024 18:26:35 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
Message-ID: <Znrvu4luJqftqWy8@krava>
References: <20240625052741.3640731-1-jolsa@kernel.org>
 <808ae131-447e-433d-bd01-f04898b87497@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <808ae131-447e-433d-bd01-f04898b87497@oracle.com>

On Tue, Jun 25, 2024 at 09:46:55AM +0100, Alan Maguire wrote:
> On 25/06/2024 06:27, Jiri Olsa wrote:
> > ARRAY_SIZE is used on multiple places, move its definition in
> > bpf_misc.h header.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> good idea ; one very optional nit/suggestion below but
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> > ---
> >  tools/testing/selftests/bpf/progs/bpf_misc.h                 | 2 ++
> >  tools/testing/selftests/bpf/progs/iters.c                    | 2 --
> >  tools/testing/selftests/bpf/progs/kprobe_multi_session.c     | 3 +--
> >  tools/testing/selftests/bpf/progs/linked_list.c              | 5 +----
> >  tools/testing/selftests/bpf/progs/netif_receive_skb.c        | 5 +----
> >  tools/testing/selftests/bpf/progs/profiler.inc.h             | 5 +----
> >  tools/testing/selftests/bpf/progs/setget_sockopt.c           | 5 +----
> >  tools/testing/selftests/bpf/progs/test_bpf_ma.c              | 4 ----
> >  tools/testing/selftests/bpf/progs/test_sysctl_loop1.c        | 5 +----
> >  tools/testing/selftests/bpf/progs/test_sysctl_loop2.c        | 5 +----
> >  tools/testing/selftests/bpf/progs/test_sysctl_prog.c         | 5 +----
> >  .../testing/selftests/bpf/progs/test_tcp_custom_syncookie.c  | 1 +
> >  .../testing/selftests/bpf/progs/test_tcp_custom_syncookie.h  | 2 --
> >  .../testing/selftests/bpf/progs/verifier_subprog_precision.c | 2 --
> >  14 files changed, 11 insertions(+), 40 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> > index c0280bd2f340..ac6ab1b977a1 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> > +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> > @@ -140,4 +140,6 @@
> >  /* make it look to compiler like value is read and written */
> >  #define __sink(expr) asm volatile("" : "+g"(expr))
> >  
> > +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> 
> nit: would it be worth bracketing the #define in an #ifndef
> ARRAY_SIZE/#endif? A few cases you're replacing (like
> progs/linked_list.c) have the #ifndef/#endif protection.

sure, makes sense, will send v2

thanks,
jirka

