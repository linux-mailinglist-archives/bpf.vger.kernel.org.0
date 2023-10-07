Return-Path: <bpf+bounces-11599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2AC7BC53D
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 08:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DF728249A
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D495E848C;
	Sat,  7 Oct 2023 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj3qB/xT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4201847B;
	Sat,  7 Oct 2023 06:56:18 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D4BB9;
	Fri,  6 Oct 2023 23:56:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99357737980so505544666b.2;
        Fri, 06 Oct 2023 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696661775; x=1697266575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YUw7XoLsz41SiLTdb8LgB9w87N22enKZ40wW5PzF0/s=;
        b=Xj3qB/xTm90gCZC5IKOl4Y6sD1W0MctKmOMnv1E3fjThlh2W9ZlCq2ujt4BovS+t1n
         E9WhCeJOAWClG2+0zBkYRwACQKVuNBQq7yokibdBrP/O99rTT6+RAQojoVoPCGvNjN/k
         mlpMYJCVWxvJn5tbgdcuFGr7KGCw+pl7p2Gl47H0iuYM0Z6mIHeCpZHxBBdd6tHzX7x8
         zuwzqPAITDNFpeMenVI//nNv911GJz3DZBD5maDOf0kTa55hGq34eJe/oI5fBAY0hNmv
         9gwQgVXwT7vDZzjvzHvMW3u2Av2Q+VT2P4FBDmquAF/LwGLUmlS17amj2iDU3mroBMB0
         dMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696661775; x=1697266575;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUw7XoLsz41SiLTdb8LgB9w87N22enKZ40wW5PzF0/s=;
        b=FuE9rgVxxLLYXOrhpnq1rJXyKVt+kqqXK7Q+WoboFgXtecn6NvRno2JJBBY4+TQbHk
         6UarWNAKLEtncfZJxQTGPjW+Xfg0i7Jf1rn12CK+fcnZrnn/dNlsaspObGl922DZXHhF
         FuPUxdFoF+OO6aYqhxM68hcA2BILXn/ESd8rcKt52a/0w/Jq1AU/5kRdN3RcXg73jWjj
         eEN7JkX/2KoiKt7cFBQGiolftg4pmYGdJwoi5RXHdIXvRWTsfTesxsY/TJXapL7RYYED
         S7WBJAcHB+SyTSuk2IE7oFjtggUL5jqz2DXIa+usKeTDs8dtfsK6HvoeF9YyBJZL2q4V
         Kc6g==
X-Gm-Message-State: AOJu0YwIlrBypx3rN/VVAriqotkSTusOFMbzS4c8TpfBACwy6bs5Gl4e
	kFD+QxV6X+HFAxH7cjbzix4=
X-Google-Smtp-Source: AGHT+IE9bYWCnyZHBnyoiDrTEX9fuL1lMn3ATCGlp1Qxp0RTtKHcxZd4K4z8vLp4+Z+7rjnr4qBHKA==
X-Received: by 2002:a17:907:7888:b0:9ae:68dc:d571 with SMTP id ku8-20020a170907788800b009ae68dcd571mr10124154ejc.46.1696661775293;
        Fri, 06 Oct 2023 23:56:15 -0700 (PDT)
Received: from akanner-r14. ([77.222.24.57])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b0099bc038eb2bsm3858516ejb.58.2023.10.06.23.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 23:56:14 -0700 (PDT)
Message-ID: <6521010e.170a0220.1f5b5.aaa6@mx.google.com>
X-Google-Original-Message-ID: <ZSEBBY1Xb7vjm0ua@akanner-r14.>
Date: Sat, 7 Oct 2023 09:56:05 +0300
From: Andrew Kanner <andrew.kanner@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
	syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, aleksander.lobakin@intel.com,
	xuanzhuo@linux.alibaba.com, ast@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, daniel@iogearbox.net
Subject: Re: [PATCH bpf v3] net/xdp: fix zero-size allocation warning in
 xskq_create()
References: <20231005193548.515-1-andrew.kanner@gmail.com>
 <7aa47549-5a95-22d7-1d03-ffdd251cec6d@linux.dev>
 <651fb2a8.c20a0220.8d6c3.0fd9@mx.google.com>
 <57c35480-983d-2056-1d72-f6e555069b83@linux.dev>
 <6520971d.a70a0220.758e3.8cf7@mx.google.com>
 <eb61966f-8666-80f6-1eab-c89bffe496b8@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb61966f-8666-80f6-1eab-c89bffe496b8@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 04:58:18PM -0700, Martin KaFai Lau wrote:
> On 10/6/23 4:24 PM, Andrew Kanner wrote:
> > > Thanks for the explanation, so iiuc it means it will overflow the
> > > struct_size() first because of the is_power_of_2(nentries) requirement?
> > > Could you help adding some comment to explain? Thanks.
> > > 
> > The overflow happens because there's no upper limit for nentries
> > (userspace input). Let me add more context, e.g. from net/xdp/xsk.c:
> > 
> > static int xsk_setsockopt(struct socket *sock, int level, int optname,
> >                            sockptr_t optval, unsigned int optlen)
> > {
> > [...]
> >                  if (copy_from_sockptr(&entries, optval, sizeof(entries)))
> >                          return -EFAULT;
> > [...]
> >                  err = xsk_init_queue(entries, q, false);
> > [...]
> > }
> > 
> > 'entries' is passed to xsk_init_queue() and there're 2 checks: for 0
> > and is_power_of_2() only, no upper bound check:
> > 
> > static int xsk_init_queue(u32 entries, struct xsk_queue **queue,
> >                            bool umem_queue)
> > {
> >          struct xsk_queue *q;
> > 
> >          if (entries == 0 || *queue || !is_power_of_2(entries))
> >                  return -EINVAL;
> > 
> >          q = xskq_create(entries, umem_queue);
> >          if (!q)
> >                  return -ENOMEM;
> > [...]
> > }
> > 
> > The 'entries' value is next passed to struct_size() in
> > net/xdp/xsk_queue.c. If it's large enough - SIZE_MAX will be returned.
> 
> All make sense. I was mostly asking to add a comment at the "if
> (unlikely(size == SIZE_MAX)" check to explain this details on why checking
> SIZE_MAX is enough.

Ok, I got it. Will add in v4.
Thanks.

-- 
Andrew Kanner

