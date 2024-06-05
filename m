Return-Path: <bpf+bounces-31466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4BC8FD83B
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 23:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267631C2554B
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A615FA65;
	Wed,  5 Jun 2024 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUlEZslh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26C15F416;
	Wed,  5 Jun 2024 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622253; cv=none; b=fKswC/dOVcugGAhV96trFYLWqhYG1fmm2fmi3g5BLOd3kE+FY7AgoibzG07o8kCy7wfADlPhh5Gx2OIQakaembNM5Mg9PNBZUKjM/mE2JqSZv/s4/U6oOvatyY4KSaMeCxP2LmPrW/VDn+vzwTphufTUOqvU4RUkWH+i/XtOndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622253; c=relaxed/simple;
	bh=rcNT+VkwiI4GjlerZjKyIVuJ8X+qsikybUwdV8yPp6U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opczzx3slC0i20AdONdZ5BCArxDSkzC61J4uYMWufGjbFiyBYjSyUwVqf8c0f2SwPwhaPfiwr6aMNhg+TQPJSs9evnUub2g/KS1HzwoE+VE1ZkYrEKc4mpE7UlalR5jhb0ryuhFIL+fl646gKLjuO2XXdXj1L+zK84M0Gj6owoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUlEZslh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68a9a4e9a6so29860766b.3;
        Wed, 05 Jun 2024 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717622249; x=1718227049; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=COrz65pOh/yQ2I4pAQH6V+4/UFcJFquCRwFewpYu7HI=;
        b=UUlEZslhekOFnZFyuoIZFoMaTBxUz70B1X312OEfXd+yQWNVuTXIR72EJeeMOoL7ZQ
         +mLWKgFWolPCUludk+6a09Rta0/0Ae3yrcP6R30JJ7OGdo/rU5HPviearNkCsrmkylFb
         2UoDH9IjqebvhsPb5gLYCNj+8A2eb7vbGSpM7OYUD7kEYa8sWFLBrnNZN8ehxAhbhX/X
         cqpvUCUY17j7qJuSEBlkQIyrfs/gz9VtNLIGXf4taVh6g0hPO/2kpvaH5tH1yrtL1V8H
         Kv7kIkCgNR7NZXKskquCnBIRXs/O9f/Zj04oAMbBl0BtZPRARiClDU9Cv5TLmmpLlU7m
         X7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717622249; x=1718227049;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COrz65pOh/yQ2I4pAQH6V+4/UFcJFquCRwFewpYu7HI=;
        b=JmvS4IezryROLIsUZrE3xJyJyCde/xcWd3FK79sQM1GAhozRTlOIyFTifbTmfdj4ck
         E7xDWM1FimP/9zKpCmZfLLdVg6V8EOrkvXfqvwgGbgf5GVdLjfbausQVtuFet6HTbnSR
         Rfrga21Y/nwBY2Iv1n2YOkqD0IpSliWZKIAx/Uz+JZMFR8nF6VR2BufDGooPwS3dsjPb
         SD8H+7iVRkmEwcWXClc0TTxEVz9JCCcArYW4kirOGMLs+zdXoJ7k1gPFru3s+c5ds8cm
         5CFyRC3VcUf06svWZAkljeDzqM3fzKrX6yvgSkG/raJXT70U0Bn/xLvWcvhiHDf49Ibp
         KJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Vp6SgsX4Y2jksXFTlYlVJYMdP2OW8Tyx2XhnB+uVx+QR4TTktpJRVUf0kW84U2EiBlHNYZ5BLiBCD+rXeXs6YsTAFTztdjmTYt9/SKhU9dDX79xM6ca0KsajBdnXubTpGuH9K3JDWjs4n4aj/rQFgoPS120kkMHZ1WrmUE5+fJvpgftl
X-Gm-Message-State: AOJu0YzweswMsLebvc3Kr24wMKFkr91NOq+sd5JM76/Iv/bxfItyyxws
	4Va4//aRdNLs6AJ2itFZP9gtCh8qUqgc+WPbznJiXUKYGIr5tngs
X-Google-Smtp-Source: AGHT+IF0ZMCknLrmT7qh1gyO8kpo7oCxWKy5Dp7jYz7jRf/ZV+TWhUe6iYr01ytCngHImp9Vd6EgBg==
X-Received: by 2002:a17:907:609:b0:a68:b5f0:3b4a with SMTP id a640c23a62f3a-a699f88b0a9mr293725066b.39.1717622249280;
        Wed, 05 Jun 2024 14:17:29 -0700 (PDT)
Received: from krava ([83.240.63.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fe33c561sm542617866b.70.2024.06.05.14.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:17:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 5 Jun 2024 23:17:27 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <ZmDV52JUrASljxTh@krava>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com>
 <CAEf4Bzbz3vi6ahkUu7yABV-QhkzNCF-ROcRjUpGjt0FRjfDuKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbz3vi6ahkUu7yABV-QhkzNCF-ROcRjUpGjt0FRjfDuKQ@mail.gmail.com>

On Wed, Jun 05, 2024 at 01:47:00PM -0700, Andrii Nakryiko wrote:
> On Wed, Jun 5, 2024 at 10:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 06/05, Andrii Nakryiko wrote:
> > >
> > > so any such
> > > limitations will cause problems, issue reports, investigation, etc.
> >
> > Agreed...
> >
> > > As one possible solution, what if we do
> > >
> > > struct return_instance {
> > >     ...
> > >     u64 session_cookies[];
> > > };
> > >
> > > and allocate sizeof(struct return_instance) + 8 *
> > > <num-of-session-consumers> and then at runtime pass
> > > &session_cookies[i] as data pointer to session-aware callbacks?
> >
> > I too thought about this, but I guess it is not that simple.
> >
> > Just for example. Suppose we have 2 session-consumers C1 and C2.
> > What if uprobe_unregister(C1) comes before the probed function
> > returns?
> >
> > We need something like map_cookie_to_consumer().
> 
> Fair enough. The easy way to solve this is to have
> 
> 
> struct uprobe_session_cookie {
>     int consumer_id;
>     u64 cookie;
> };
> 
> And add id to each new consumer when it is added to struct uprobe.
> Unfortunately, it's impossible to tell when a new consumer was added
> to the list (as a front item, but maybe we just change it to be
> appended instead of prepending) vs when the old consumer was removed,
> so in some cases we'd need to do a linear search.

also we probably need to add the flag if we want to execute the return
handler..  we can have multiple session handlers and if just one of them
returns 0 we need to install the return probe

and then when return probe hits, we need to execute only that consumer's
return handler

jirka

> 
> But the good news is that in the common case we wouldn't need to
> search and the next item in session_cookies[] array would be the one
> we need.
> 
> WDYT? It's still fast, and it's simpler than the shadow stack idea, IMO.
> 
> P.S. Regardless, maybe we should change the order in which we insert
> consumers to uprobe? Right now uprobe consumer added later will be
> executed first, which, while not wrong, is counter-intuitive. And also
> it breaks a nice natural order when we need to match it up with stuff
> like session_cookies[] as described above.
> 
> >
> > > > +       /* The handler_session callback return value controls execution of
> > > > +        * the return uprobe and ret_handler_session callback.
> > > > +        *  0 on success
> > > > +        *  1 on failure, DO NOT install/execute the return uprobe
> > > > +        *    console warning for anything else
> > > > +        */
> > > > +       int (*handler_session)(struct uprobe_consumer *self, struct pt_regs *regs,
> > > > +                              unsigned long *data);
> > > > +       int (*ret_handler_session)(struct uprobe_consumer *self, unsigned long func,
> > > > +                                  struct pt_regs *regs, unsigned long *data);
> > > > +
> > >
> > > We should try to avoid an alternative set of callbacks, IMO. Let's
> > > extend existing ones with `unsigned long *data`,
> >
> > Oh yes, agreed.
> >
> > And the comment about the return value looks confusing too. I mean, the
> > logic doesn't differ from the ret-code from ->handler().
> >
> > "DO NOT install/execute the return uprobe" is not true if another
> > non-session-consumer returns 0.
> >
> > Oleg.
> >

