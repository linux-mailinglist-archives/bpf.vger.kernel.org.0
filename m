Return-Path: <bpf+bounces-7759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE877BF2F
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9CE2811B2
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF03CA43;
	Mon, 14 Aug 2023 17:45:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43DBE6B
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:45:31 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F6F10D0;
	Mon, 14 Aug 2023 10:45:30 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7679ea01e16so367205585a.2;
        Mon, 14 Aug 2023 10:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692035130; x=1692639930;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lv7tIQWP+kGGB4aOTB1TlmerpQoccXTqXY8tDL5x1UQ=;
        b=M981JYOJqz5OZ9JrOXuUGs6a009aOHEYb9wiWsVsQDFoBP6wEqgMSvPbUtkctjj6ej
         DCY+29eFrma9DCs2+DLytVK4udY69aWUE43q8On3xL/iuP5Jcymb7ohLXFnhUiTx6aXa
         kgwbkAQkruwEtzQUpjio0BNlaZLaDJh9OZEU1KTnlJlx01DhBZqhMAAk26klmFDVdK+E
         b2h/uKpohzk7A9SMpLA04MnSaI7Px77066VzHl4roCZ6Z/2BXM31D/bKm1ChpJe2rBB8
         7SKZom2rDi9UuQwuhdxhlAI5Rj56zLexFihgoCpPhttKSc1isqNFC4YSzp7gQYKCVMe8
         XngA==
X-Gm-Message-State: AOJu0YwN/fZvF1hCB2h3ZxNrz/2B2K7JfwDJ7FwYX1iSL/onKfa/IH3Z
	rVxpDIIY5yRkvx0B9Yn3jcKqtNMKQH4JIh6N
X-Google-Smtp-Source: AGHT+IHr5c0jzj5Zo0iM7YjbKgSz5YEjhoMSt5LRFJbKufYRkY8Bb2w5YzFejx80GMstoaJpL1XNog==
X-Received: by 2002:a05:620a:f13:b0:76a:eee2:cd09 with SMTP id v19-20020a05620a0f1300b0076aeee2cd09mr12220539qkl.9.1692035129653;
        Mon, 14 Aug 2023 10:45:29 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:93a1])
        by smtp.gmail.com with ESMTPSA id j7-20020a37c247000000b0076cc4610d0asm3166903qkm.85.2023.08.14.10.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 10:45:29 -0700 (PDT)
Date: Mon, 14 Aug 2023 12:45:26 -0500
From: David Vernet <void@manifault.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, tj@kernel.org, clm@meta.com,
	thinker.li@gmail.com, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
Message-ID: <20230814174526.GG542801@maniforge>
References: <20230810220456.521517-1-void@manifault.com>
 <ZNVousfpuRFgfuAo@google.com>
 <20230810230141.GA529552@maniforge>
 <ZNVvfYEsLyotn+G1@google.com>
 <fe388d79-bdfc-0480-5f4b-1a40016fd53d@linux.dev>
 <20230811201914.GD542801@maniforge>
 <d1fa5eff-b0d2-4388-0513-eaead8542b9f@linux.dev>
 <20230811233616.GE542801@maniforge>
 <f10dd9ba-de75-c2b1-a7e9-fd71bdc2f0fe@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10dd9ba-de75-c2b1-a7e9-fd71bdc2f0fe@linux.dev>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 09:55:37AM -0700, Martin KaFai Lau wrote:
> On 8/11/23 4:36 PM, David Vernet wrote:
> > I see, thanks for explaining. This is why sched_ext doesn't really work
> > with the BPF_F_LINK version of map update. We can't guarantee that a map
> > can be updated if we can't succeed in ->reg(), because we can also race
> > with e.g. sysrq unloading the scheduler between ->validate() and
> > ->reg(). In a sense, it feels like ->reg() in "updateable" struct_ops
> > implementations should be void, whereas in other struct_ops
> > implementations like scx() it has to be int *. If validate() is meant to
> > prevent the scenario you outlined, can you help me understand why we
> > still check the return value of ->reg() in bpf_struct_ops_link_create()?
> > Or at the very least it seems like we should WARN_ON()?
> 
> ->regs() can fail if another struct_ops under the same
> name has already been loaded to the subsystem. If another
> subsystem needs another return value to support .update, I
> believe it can be done if that is blocking scx to support
> "updateable" link.

Ok, so ->validate() is a static check that should either always succeed
or always fail, and ->reg() may fail due to runtime circumstances. So a
map that passes ->validate() could e.g. retry to create the link in a
loop or something. Or create a series of validated struct_ops maps and
then have a management layer that destroys and creates links for the map
you want to actually use. Thanks for explaining.

> > > If it needs to validate struct_ops as a while,
> 
> There was a typo: as a /whole/.
> 
> > > 
> > > 1. it must be implemented in .validate instead of .reg. Otherwise, it may
> > > end up having an unusable map.
> > 
> > Some clarity on this point (why we check ->reg() on the ->validate()
> > path) would help me write this comment more clearly.
> 
> 
> hmm... where does it check ->reg() on the ->validate() now?
> 
> I was meaning the struct_ops supported subsystem should
> validate the struct_ops map in '.validate' instead of in
> the '.reg'.
> 
> or I misunderstood the question?

I just meant that I wasn't understanding why we had to check the return
value of ->reg() in bpf_struct_ops_link_create(). Now that I understand
the semantics, I can document them.

