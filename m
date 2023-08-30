Return-Path: <bpf+bounces-9004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1678E157
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9ED32812BA
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4F8481;
	Wed, 30 Aug 2023 21:21:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911C749D;
	Wed, 30 Aug 2023 21:21:15 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34631B0;
	Wed, 30 Aug 2023 14:20:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso4523091fa.0;
        Wed, 30 Aug 2023 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693430369; x=1694035169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4psNkqj89xux4H+AA7JbQFWm4KxeS2hQZPtuR6IUzYY=;
        b=YPoBjZvwVUBeddv0B3Ile+zxx7zAxlQWXO5ZhydQ0gxDpdZkppIxB0U4F80+NcdLyW
         9aoO83PbFb6Eu+Xab3+RzEjif5wDu5QNxTeMBF/CGm46fWWaCo6lnGLFcOM3aj1TPmzr
         wnTyieIUzTctpXvIbkzLpbQMRzyh5IYMvGV9YAPwX8KkZHmkpa4UTB2EBxBAxAxC7+Kv
         Gz+rjh9I9BgWAc1VjOd7OF//7fRc1+Byav0jwwdYrzQiahHDrzAVkOPjj5PdNY+A7dMZ
         36Zi6A+/VDUGo/6TTK6uZ8zMktRzEnZqFv56aXvB8fDTdawFFpYli9zP2MfGruUjtOpE
         8hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430369; x=1694035169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4psNkqj89xux4H+AA7JbQFWm4KxeS2hQZPtuR6IUzYY=;
        b=BBCWJcUQwC8VobF0SdzlFEhoBHUdgG/6kHhsUfCMNZyoI+SUDaCGiHvDHGz7Qvk9Zy
         SDtS2+IVtRVOm3f2B3E3W5oVfNQ12UbgVa+TiAk0PD+krJbpIl9sBdZAJ0soGLjJvyfq
         yFFdkXInf9H88nvWtht6p7TQ5ChR7hl9nsWwcJHGf679FQFZk7iqb54kj22po+vYEM4B
         NRT1EVPldw7BrWKdQUgnIRxEJblt6sI5P9OYh+bkg9nYcRHdW+rrkUKjn1q1vbXLldrX
         xoTjKKcHdoQiYAwOwbCmiDjFINqCXBN/+oj2CML7V+WlhfRIZB/XqQpqdDIzGkeHim/e
         HNTw==
X-Gm-Message-State: AOJu0YwjxPO1TAH8+KoM6n8aG0s4gSQbEgC9c0nOFC8cY+qjGCbZ2Pyw
	0WfVMiiSj2yURrib+TvubcDKiSlR1rc=
X-Google-Smtp-Source: AGHT+IHuFQ+XWhGf4reoCvZyYtukzz/782pewCH3lcZgpbTJGlYqWIGGWy2ZyTuntNV6+3heHDexHg==
X-Received: by 2002:a17:907:2c4b:b0:99d:6b3c:3d40 with SMTP id hf11-20020a1709072c4b00b0099d6b3c3d40mr2474062ejc.6.1693429629263;
        Wed, 30 Aug 2023 14:07:09 -0700 (PDT)
Received: from krava ([83.240.61.136])
        by smtp.gmail.com with ESMTPSA id f24-20020a1709067f9800b00977eec7b7e8sm7610646ejr.68.2023.08.30.14.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:07:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Aug 2023 23:07:06 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>
Subject: Re: [BUG bpf-next] bpf/net: Hitting gpf when running selftests
Message-ID: <ZO+vetPCpOOCGitL@krava>
References: <ZO+RQwJhPhYcNGAi@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO+RQwJhPhYcNGAi@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 08:58:11PM +0200, Jiri Olsa wrote:
> hi,
> I'm hitting crash below on bpf-next/master when running selftests,
> full log and config attached

it seems to be 'test_progs -t sockmap_listen' triggering that

jirka

> 
> jirka
> 
> 
> ---
> [ 1022.710250][ T2556] general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b73: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI^M
> [ 1022.711206][ T2556] CPU: 2 PID: 2556 Comm: kworker/2:4 Tainted: G           OE      6.5.0+ #693 1723c8b9805ff5a1672ab7e6f25977078a7bcceb^M
> [ 1022.712120][ T2556] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014^M
> [ 1022.712830][ T2556] Workqueue: events sk_psock_backlog^M
> [ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80^M
> [ 1022.713653][ T2556] Code: 41 48 85 ed 74 3c 8b 43 10 4c 89 e7 83 e8 01 89 43 10 48 8b 45 08 48 8b 55 00 48 c7 45 08 00 00 00 00 48 c7 45 00 00 00 00 00 <48> 89 42 08 48 89 10 e8 e8 6a 41 00 48 89 e8 5b 5d 41 5c c3 cc cc^M
> [ 1022.714963][ T2556] RSP: 0018:ffffc90003ca7dd0 EFLAGS: 00010046^M
> [ 1022.715431][ T2556] RAX: 6b6b6b6b6b6b6b6b RBX: ffff88811de269d0 RCX: 0000000000000000^M
> [ 1022.716068][ T2556] RDX: 6b6b6b6b6b6b6b6b RSI: 0000000000000282 RDI: ffff88811de269e8^M
> [ 1022.716676][ T2556] RBP: ffff888141ae39c0 R08: 0000000000000001 R09: 0000000000000000^M
> [ 1022.717283][ T2556] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88811de269e8^M
> [ 1022.717930][ T2556] R13: 0000000000000001 R14: ffff888141ae39c0 R15: ffff88810a20e640^M
> [ 1022.718549][ T2556] FS:  0000000000000000(0000) GS:ffff88846d600000(0000) knlGS:0000000000000000^M
> [ 1022.719241][ T2556] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> [ 1022.719761][ T2556] CR2: 00007fb5c25ca000 CR3: 000000012b902004 CR4: 0000000000770ee0^M
> [ 1022.720394][ T2556] PKRU: 55555554^M
> [ 1022.720699][ T2556] Call Trace:^M
> [ 1022.720984][ T2556]  <TASK>^M
> [ 1022.721254][ T2556]  ? die_addr+0x32/0x80^M
> [ 1022.721589][ T2556]  ? exc_general_protection+0x25a/0x4b0^M
> [ 1022.722026][ T2556]  ? asm_exc_general_protection+0x22/0x30^M
> [ 1022.722489][ T2556]  ? skb_dequeue+0x4c/0x80^M
> [ 1022.722854][ T2556]  sk_psock_backlog+0x27a/0x300^M
> [ 1022.723243][ T2556]  process_one_work+0x2a7/0x5b0^M
> [ 1022.723633][ T2556]  worker_thread+0x4f/0x3a0^M
> [ 1022.723998][ T2556]  ? __pfx_worker_thread+0x10/0x10^M
> [ 1022.724386][ T2556]  kthread+0xfd/0x130^M
> [ 1022.724709][ T2556]  ? __pfx_kthread+0x10/0x10^M
> [ 1022.725066][ T2556]  ret_from_fork+0x2d/0x50^M
> [ 1022.725409][ T2556]  ? __pfx_kthread+0x10/0x10^M
> [ 1022.725799][ T2556]  ret_from_fork_asm+0x1b/0x30^M
> [ 1022.726201][ T2556]  </TASK>^M

