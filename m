Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB31BB62
	for <lists+bpf@lfdr.de>; Mon, 13 May 2019 18:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfEMQ4i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 12:56:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35489 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbfEMQ4h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 12:56:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id t87so7528355pfa.2
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZTunAawGG6Myt+jxe91Uo1Ppj3bzXWKypWe86M5rVDI=;
        b=hkGUQLKUIgY9dbypNGFJ+IhYmBOCswH0acvSqO1TD5UBWkRX+Abh+jEsvGajMkJhoo
         gXzJrJ9WXGlsJ+KN+Gnujzfmc/99zKyudedfANUGmhBmtWlsZFB8+DZ1dQSOwq6Ctyj+
         3ohd9vtPjsWb1lmk6FN8iGH+yrz88+S8W5uCQetpiscRePmxRXVs+SXcoizpUnmIRUgn
         ik52GXSuD7A7JWpxjQdKFVEpBLaCFWVzNHXJhjps/wlomTeuaA5uS1d3v8zKEM0VO/tp
         LYj7y7EMqbbSCZ1Kqi+UEL5lqCZi3hNjKlOeB5NqkWY4NVC1l/LIFQaxSKPIZ6s5c2b0
         kHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZTunAawGG6Myt+jxe91Uo1Ppj3bzXWKypWe86M5rVDI=;
        b=nLyE5q0M20h2CORvi0nC9hf5X6bih/xGxrEwtkhjf/kedJWhXhivioDGLMo9eZqqzZ
         YXAG7pUWTTxqIX867Osh0DgsmnF4EH6vO6go3mV39Za1QmjeQddX5dkygH04Q4eZZf/K
         FId+36jo04LDhh+frDpTRCyKSBqwfmRWNaEiV2ps7DulFQwVWk6nDPBJOBRRRwUl92Bl
         xknpE+SXvU/Bdgew8LcmRIM9euvN5yxhEyH1HwZ3IYiGUhn6QsPkB07tDJx2yPc1T9HM
         FJ2OaIjk7+aZtap0YTvKgzsXx/3D+XAsF+Vi6k8ChyChT/LMMCpMTICXyhvknA+vazJi
         qr/Q==
X-Gm-Message-State: APjAAAUB2O//SwUN6a2vCx5GGOLBN0j1bjBbIA9GcCx7SAcWlyfLCCHf
        cqaeMrs8os3lC0h8sB7rWnhWuw==
X-Google-Smtp-Source: APXvYqzET4SOofg1VytMu7GDR/sCpooVJvGPWJbxBlSm5m3EPL7kpy7yd6XMw11P7xXHucN2/26UQg==
X-Received: by 2002:a63:5d44:: with SMTP id o4mr32362137pgm.15.1557766597076;
        Mon, 13 May 2019 09:56:37 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id e123sm12952412pgc.29.2019.05.13.09.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 09:56:36 -0700 (PDT)
Date:   Mon, 13 May 2019 09:56:35 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Eric Dumazet <edumazet@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        bpf <bpf@vger.kernel.org>, syzbot <syzkaller@googlegroups.com>,
        Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net] flow_dissector: disable preemption around BPF calls
Message-ID: <20190513165635.GA24057@mini-arch>
References: <20190513163855.225489-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513163855.225489-1-edumazet@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/13, Eric Dumazet wrote:
> Various things in eBPF really require us to disable preemption
> before running an eBPF program.
> 
> syzbot reported :
> 
> BUG: assuming atomic context at net/core/flow_dissector.c:737
> in_atomic(): 0, irqs_disabled(): 0, pid: 24710, name: syz-executor.3
> 2 locks held by syz-executor.3/24710:
>  #0: 00000000e81a4bf1 (&tfile->napi_mutex){+.+.}, at: tun_get_user+0x168e/0x3ff0 drivers/net/tun.c:1850
>  #1: 00000000254afebd (rcu_read_lock){....}, at: __skb_flow_dissect+0x1e1/0x4bb0 net/core/flow_dissector.c:822
> CPU: 1 PID: 24710 Comm: syz-executor.3 Not tainted 5.1.0+ #6
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>  __cant_sleep kernel/sched/core.c:6165 [inline]
>  __cant_sleep.cold+0xa3/0xbb kernel/sched/core.c:6142
>  bpf_flow_dissect+0xfe/0x390 net/core/flow_dissector.c:737
>  __skb_flow_dissect+0x362/0x4bb0 net/core/flow_dissector.c:853
>  skb_flow_dissect_flow_keys_basic include/linux/skbuff.h:1322 [inline]
>  skb_probe_transport_header include/linux/skbuff.h:2500 [inline]
>  skb_probe_transport_header include/linux/skbuff.h:2493 [inline]
>  tun_get_user+0x2cfe/0x3ff0 drivers/net/tun.c:1940
>  tun_chr_write_iter+0xbd/0x156 drivers/net/tun.c:2037
>  call_write_iter include/linux/fs.h:1872 [inline]
>  do_iter_readv_writev+0x5fd/0x900 fs/read_write.c:693
>  do_iter_write fs/read_write.c:970 [inline]
>  do_iter_write+0x184/0x610 fs/read_write.c:951
>  vfs_writev+0x1b3/0x2f0 fs/read_write.c:1015
>  do_writev+0x15b/0x330 fs/read_write.c:1058
>  __do_sys_writev fs/read_write.c:1131 [inline]
>  __se_sys_writev fs/read_write.c:1128 [inline]
>  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1128
>  do_syscall_64+0x103/0x670 arch/x86/entry/common.c:298
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: Petar Penkov <ppenkov@google.com>
> Cc: Stanislav Fomichev <sdf@google.com>
> ---
>  net/core/flow_dissector.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 9ca784c592ac8c9c58282289a81889fbe4658a9e..548f39dde30711ac5be9e921993a6d8e53f74161 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -734,7 +734,9 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
>  	flow_keys->nhoff = nhoff;
>  	flow_keys->thoff = flow_keys->nhoff;
>  
> +	preempt_disable();
>  	result = BPF_PROG_RUN(prog, ctx);
> +	preempt_enable();
>  
>  	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
>  	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 
Reviewed-by: Stanislav Fomichev <sdf@google.com>

Thanks!
