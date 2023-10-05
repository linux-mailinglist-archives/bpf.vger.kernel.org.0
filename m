Return-Path: <bpf+bounces-11429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE3E7B9B74
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 09:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F1EA3281C6B
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 07:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237096105;
	Thu,  5 Oct 2023 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivhElYd4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D13C53B9;
	Thu,  5 Oct 2023 07:43:52 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4007C7DA5;
	Thu,  5 Oct 2023 00:43:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-9b2cee55056so121729766b.3;
        Thu, 05 Oct 2023 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696491829; x=1697096629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=434RHBUC25tmTHbc0SxjMGW/nyMWNCPZ1Bst5eTtmeM=;
        b=ivhElYd4rVggN+9kl3Xzsj4jDQSDcuYdxNTSa5f6rhrsVyJdknEm32pX+w5BuS/zzV
         KFpUEYvE6hhTURfaVqNnlsYtRuR05ZnlqnI0y2JT8oASQtr9oYMzkAHEiPMB3rmHksS6
         YoqrEY9t4gfqkXriyXERdnhe80zzscAWQVdkRo0dHaiyUCcYNMkteROguJQXydnW1BXA
         jUXUxERj346Xd9lKbV1kj6OWFB7UhjI0zsWTHhbBMcFvu5Pww0Q9ePxma8a+VMQIKCGs
         V2njjowe/7zBasctc+OT10saUR1szLEy2TlhW/ZtlTv4kNEqhrrDYFvajg/6r1wj0I13
         IiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696491829; x=1697096629;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=434RHBUC25tmTHbc0SxjMGW/nyMWNCPZ1Bst5eTtmeM=;
        b=VCcgJ+6Yddx0G/kw9nh1hhyRWHQLJ+IsF1vvly5jD7P2tbcrwSomnHcDs1as9ZcTW2
         wJjfS4cL6KQmv8iMNay1ijHpsMHc78nlM4/3pfajCVdWnvlHgBOiJt/qx7XzJUKnOC4C
         9s7H6sjB7zhFzsG+PDax5W2Git+8Fya5ATk6xcDZKuEuZ3GhCJZvkEAPf5Yk+johO666
         W9BS5Lq/xsaWgNVnCqP0ns5rWDyCTcSJfF7AFnai9Nc9LleCqjBMg1Z9uWcFnG57n11f
         ir+GrgGCl8sMmA6+kE5MB+vbnkxVj/M4xNd2XNzETRgO8rw0kwUoGv0Wlas2MHlfvstu
         H1iA==
X-Gm-Message-State: AOJu0YzdTNbDvyjF96k+6rooLkCEGcX6vi8ww8acAUqhYd22t8YNoFEj
	ZETfVZUkFYLyVgE4WgrwYaU=
X-Google-Smtp-Source: AGHT+IFvDmJPhDO8Jx+ZQXEtd1a2eMdmo4I9tmenB4y4AIYQ55Kkp0YyeiGHG29nPu9RkmJ6ihEApg==
X-Received: by 2002:a17:906:253:b0:9b8:9b4f:1cc2 with SMTP id 19-20020a170906025300b009b89b4f1cc2mr3632778ejl.43.1696491828442;
        Thu, 05 Oct 2023 00:43:48 -0700 (PDT)
Received: from akanner-r14. ([62.4.56.169])
        by smtp.gmail.com with ESMTPSA id j16-20020a170906051000b0099bcf1c07c6sm714925eja.138.2023.10.05.00.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:43:47 -0700 (PDT)
Message-ID: <651e6933.170a0220.f6f76.1a12@mx.google.com>
X-Google-Original-Message-ID: <ZR5nSFVu9XhIHjit@akanner-r14.>
Date: Thu, 5 Oct 2023 10:35:56 +0300
From: Andrew Kanner <andrew.kanner@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, aleksander.lobakin@intel.com,
	xuanzhuo@linux.alibaba.com, ast@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v2] net/xdp: fix zero-size allocation warning in
 xskq_create()
References: <20231002222939.1519-1-andrew.kanner@gmail.com>
 <2f5abbf8-8d50-3deb-19cd-9bfd654e1ceb@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f5abbf8-8d50-3deb-19cd-9bfd654e1ceb@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 12:49:23AM +0200, Daniel Borkmann wrote:
[...]
> > 
> > Reported-and-tested-by: syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/000000000000c84b4705fb31741e@google.com/T/
> > Link: https://syzkaller.appspot.com/bug?extid=fae676d3cf469331fc89
> > Fixes: 9f78bf330a66 ("xsk: support use vaddr as ring")
> > Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> 
> I guess also:
> 
> Reported-by: syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com
> 
> Moreover, this fix is needed in bpf/net tree (as opposed to *-next tree), right?
>

Seems, so - I will check.

> >   net/xdp/xsk_queue.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
> > index f8905400ee07..b03d1bfb6978 100644
> > --- a/net/xdp/xsk_queue.c
> > +++ b/net/xdp/xsk_queue.c
> > @@ -34,6 +34,9 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
> >   	q->ring_mask = nentries - 1;
> >   	size = xskq_get_ring_size(q, umem_queue);
> > +	if (unlikely(size == SIZE_MAX))
> > +		return NULL;
> 
> Doesn't this leak q here ?
> 
> >   	size = PAGE_ALIGN(size);
> >   	q->ring = vmalloc_user(size);
> > 
> 

It is.
Thanks, Daniel, I will fix it in v3. 

pw-bot: cr

--
Andrew Kanner

