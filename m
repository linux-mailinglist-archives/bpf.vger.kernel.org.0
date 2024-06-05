Return-Path: <bpf+bounces-31464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4958FD80B
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 23:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C2A287F99
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 21:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D015F3F9;
	Wed,  5 Jun 2024 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+9SPlJH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8A15F30F;
	Wed,  5 Jun 2024 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621287; cv=none; b=QrZ27wKoTzgZDx4+HTrhucULPfo8msVZkC4GNu7FA4gX6s8cLkGAzfhCiOzyL2P1W1JleI3czZXpRtPm7wv3knVWLpEgc5cJOkr/YdG2TJys/12J4BS99qEV3WBFbOWZs0ikQ6hDVQauSDb7OfFgQmXwXbvxPBGeg6kSniNkOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621287; c=relaxed/simple;
	bh=TPSfXDJGTWIMSUF3vFBgVX55rJYpyau9urwiUFj8xvE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv+yTSI+582cs3nOr5ltngu+7+iH5e6rUM2t4caRH9ATXo09bPvldt+RbSVm4SeeE0vX4CKmoNkCWrt+G0ByyVawPRnn4baIEBdC4TrhHYCbKsW1OtNNYnUxnEbHPbzI2qosBygK/P6aqenQBjFAxT82/Hs+9xLEH+JKJZfrrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+9SPlJH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35e4aaa0f33so262798f8f.0;
        Wed, 05 Jun 2024 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717621284; x=1718226084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPJbSr0brM/HxZcgIyd9JYBo30Gl5LizEvrWrWRCKGs=;
        b=S+9SPlJHb9SP4jYfVB1Xgo+6KVUhBXrcCtso/V67ipSqn2owYwcM7tb6+oGO/I2qPa
         9iS4KX2Z6Bo2LVBcfh+21eAbKl1Fk7WhPFgR489hHA1OBCcA0wZFKJ5wAyu3xay0phxL
         hPTRdFcBcn0vPLfda7iW6gNGZMlZE28xnBepK9Cw0AzSLNgKv8Uc6IfsKCYASjY3/jKp
         kl3TGGk92VzsknSLAtVidE9eZZBTYbAZI/qSUTY/3jBTQHMSNUitGw7qHd0R8CfFViAD
         LiY4YC/qw/N3XEOVxbPlCNaavI8BFuvnJJy89ZNLdOUE3AFZOed6fsNa16NkQfvhfz9N
         SNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621284; x=1718226084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPJbSr0brM/HxZcgIyd9JYBo30Gl5LizEvrWrWRCKGs=;
        b=CuqXxUWJX2AHRRQgQEOvNm/RHwvwQGyryed29q7DI8UAOPQl0W3iFSq8vwTzS7UpX/
         3lmAhGvOQD1bMccraFGfYYEFvclnpWhJc4F/gFVO5KhqAdHeJYGD1PGRgGPU+SHwz70i
         32E9+PWQpLE8UH9AF+bnu4r0VJdr9BnkZBt2XlQiZQd4YiXDALyoXMvI7x+1c3BcV2cu
         MML9gWUACIvCL/xYxyUkptEw1eP5p4TNMaVmlou7fd8wRAoyjL6dQG8sNCnY994UNIKD
         9ZR8KX8qtn3u2keDkIioY9r2pbZFnQzv88sI6nngjwHoRSkNtjA17BVRAkIUJI+ZX9JA
         fx8A==
X-Forwarded-Encrypted: i=1; AJvYcCWMi9CqAW+pjHSI2RtV41fBxjY+KIjQeJGDkhQQffaSalEcnnWzerEnBXoaiTGFbcP/LDfZzp9a/sGR7iSBj6TH04XrkjhfIOuHw6AQAxLXND5qlr6G+7tRRr3qnLYpXbGdSGQ4SmCaw8ht9V9gTavuKrZG1SYoB13nQRWYubz4JxL3jXhG
X-Gm-Message-State: AOJu0YyjMxGKuUi8JcgoTl1wT0oJ7Gc+CIL1JPDGL84ZdW4b+YOBrRdQ
	+3JNaIP71IOBi1gXy9sQuCDTVZootpPV/a6Oe5Rupe+C1AzLTBH3
X-Google-Smtp-Source: AGHT+IHabqkIBd/I9/cwYKH0t5gb0Si4YN9cnDv5QFLWNg3ZF/c2YFNROHCJq5sq6KWb0suC7tloDQ==
X-Received: by 2002:adf:e3c5:0:b0:35e:eaf:697e with SMTP id ffacd0b85a97d-35e8ef080c3mr2916169f8f.28.1717621283807;
        Wed, 05 Jun 2024 14:01:23 -0700 (PDT)
Received: from krava ([83.240.63.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04ca981sm15560711f8f.33.2024.06.05.14.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:01:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 5 Jun 2024 23:01:21 +0200
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
Message-ID: <ZmDSIfnU4vUMCBz9@krava>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>

On Wed, Jun 05, 2024 at 10:25:56AM -0700, Andrii Nakryiko wrote:

SNIP

> > ---
> >  include/linux/uprobes.h | 18 +++++++++++
> >  kernel/events/uprobes.c | 69 +++++++++++++++++++++++++++++++++++------
> >  2 files changed, 78 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index f46e0ca0169c..a2f2d5ac3cee 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -34,6 +34,12 @@ enum uprobe_filter_ctx {
> >  };
> >
> >  struct uprobe_consumer {
> > +       /*
> > +        * The handler callback return value controls removal of the uprobe.
> > +        *  0 on success, uprobe stays
> > +        *  1 on failure, remove the uprobe
> > +        *    console warning for anything else
> > +        */
> >         int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
> >         int (*ret_handler)(struct uprobe_consumer *self,
> >                                 unsigned long func,
> > @@ -42,6 +48,17 @@ struct uprobe_consumer {
> >                                 enum uprobe_filter_ctx ctx,
> >                                 struct mm_struct *mm);
> >
> > +       /* The handler_session callback return value controls execution of
> > +        * the return uprobe and ret_handler_session callback.
> > +        *  0 on success
> > +        *  1 on failure, DO NOT install/execute the return uprobe
> > +        *    console warning for anything else
> > +        */
> > +       int (*handler_session)(struct uprobe_consumer *self, struct pt_regs *regs,
> > +                              unsigned long *data);
> > +       int (*ret_handler_session)(struct uprobe_consumer *self, unsigned long func,
> > +                                  struct pt_regs *regs, unsigned long *data);
> > +
> 
> We should try to avoid an alternative set of callbacks, IMO. Let's
> extend existing ones with `unsigned long *data`, but specify that
> unless consumer sets some flag on registration that it needs a session
> cookie, we'll pass NULL here? Or just allocate cookie data for each
> registered consumer for simplicity, don't know; given we don't expect
> many consumers on exactly the same uprobe, it might be ok to keep it
> simple.
>

ah, I did not want to break existing users.. but it's not uapi,
so we're good, ok makes sense

jirka
 
> 
> >         struct uprobe_consumer *next;
> >  };
> >
> > @@ -85,6 +102,7 @@ struct return_instance {
> >         unsigned long           func;
> >         unsigned long           stack;          /* stack pointer */
> >         unsigned long           orig_ret_vaddr; /* original return address */
> > +       unsigned long           data;
> >         bool                    chained;        /* true, if instance is nested */
> >
> >         struct return_instance  *next;          /* keep as stack */

SNIP

