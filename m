Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C01F3695
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 11:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgFIJDu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 05:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgFIJDs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 05:03:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705AEC05BD43
        for <bpf@vger.kernel.org>; Tue,  9 Jun 2020 02:03:48 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t21so12998987edr.12
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2020 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=9f22rJL4VIrAu8fDizdaN/kAIljAWzM52xMFa+9jhcE=;
        b=lETBsvPl/e6m7cD1GW80ZZstOjK1s+8vpzxkkt56DthnbNGvhoVJpuEhXvgqlodADS
         CdMQ73miTju/tPFRCg6+leMzxLZwNNkzsiB4LSJ2hTV2UBabUQzluHIS/D8WWT4u9U8P
         17JymPfEoXvTcDmJyAXIp7BbttZ84+8/V1Z+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=9f22rJL4VIrAu8fDizdaN/kAIljAWzM52xMFa+9jhcE=;
        b=fkf36VmS/fAmRzWuzO7fm2FtAjFH7+ABG07iysX+vrNAHePfVIhbytE2JBpL+tICRl
         KEWYn7+3v13o4pBlj0oJOGgH+GXg+YcmSfNZNTQDHj/OSD9j05ifQeYU/iRejws3jV3V
         3eVNcu+Ge1JSAUubh2k4w2KPExaDsGxFQTDpUDOdCJLreVz0xNMPUIr8ZSR36QVUiJDX
         xtDxjAR0ZIljAJIRT+s7cvhtbV23bMDPJUm7KvRiP/BXCE2SmfgY9pQ3JxCjzGu9GIcm
         BiVm8g8JIMJ7J/f7dEVBN9JU4TmDu07IxlaNJuSid/PnCcQSGEiNRgLvS3S1485LjlKR
         CPCQ==
X-Gm-Message-State: AOAM531R25XmcaP1r8QjdrZEbndq1W3UE8B3EThylfBIu7KADstj2kTX
        4OCxZ1uFV/oYLhLkhK6PcxChv/1LHw8=
X-Google-Smtp-Source: ABdhPJwmO5mlkYxhnPgEdMGvz+/409+hPu5jLZh2LYxy6w/sxaKeJWimzsdAz6wvi799qO2cj7C/IQ==
X-Received: by 2002:aa7:c682:: with SMTP id n2mr25139091edq.18.1591693427077;
        Tue, 09 Jun 2020 02:03:47 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id k23sm490495ejo.120.2020.06.09.02.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 02:03:46 -0700 (PDT)
References: <20200605084625.9783-1-anny.hu@linux.alibaba.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     dihu <anny.hu@linux.alibaba.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] bpf/sockmap: fix kernel panic at __tcp_bpf_recvmsg
In-reply-to: <20200605084625.9783-1-anny.hu@linux.alibaba.com>
Date:   Tue, 09 Jun 2020 11:03:45 +0200
Message-ID: <874krk391q.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 05, 2020 at 10:46 AM CEST, dihu wrote:
> When user application calls read() with MSG_PEEK flag to read data
> of bpf sockmap socket, kernel panic happens at
> __tcp_bpf_recvmsg+0x12c/0x350. sk_msg is not removed from ingress_msg
> queue after read out under MSG_PEEK flag is set. Because it's not
> judged whether sk_msg is the last msg of ingress_msg queue, the next
> sk_msg may be the head of ingress_msg queue, whose memory address of
> sg page is invalid. So it's necessary to add check codes to prevent
> this problem.
>
> [20759.125457] BUG: kernel NULL pointer dereference, address:
> 0000000000000008
> [20759.132118] CPU: 53 PID: 51378 Comm: envoy Tainted: G            E
> 5.4.32 #1
> [20759.140890] Hardware name: Inspur SA5212M4/YZMB-00370-109, BIOS
> 4.1.12 06/18/2017
> [20759.149734] RIP: 0010:copy_page_to_iter+0xad/0x300
> [20759.270877] __tcp_bpf_recvmsg+0x12c/0x350
> [20759.276099] tcp_bpf_recvmsg+0x113/0x370
> [20759.281137] inet_recvmsg+0x55/0xc0
> [20759.285734] __sys_recvfrom+0xc8/0x130
> [20759.290566] ? __audit_syscall_entry+0x103/0x130
> [20759.296227] ? syscall_trace_enter+0x1d2/0x2d0
> [20759.301700] ? __audit_syscall_exit+0x1e4/0x290
> [20759.307235] __x64_sys_recvfrom+0x24/0x30
> [20759.312226] do_syscall_64+0x55/0x1b0
> [20759.316852] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Signed-off-by: dihu <anny.hu@linux.alibaba.com>
> ---
>  net/ipv4/tcp_bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 5a05327..b82e4c3 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -64,6 +64,9 @@ int __tcp_bpf_recvmsg(struct sock *sk, struct sk_psock *psock,
>  		} while (i != msg_rx->sg.end);
>  
>  		if (unlikely(peek)) {
> +			if (msg_rx == list_last_entry(&psock->ingress_msg,
> +						      struct sk_msg, list))
> +				break;
>  			msg_rx = list_next_entry(msg_rx, list);
>  			continue;
>  		}

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
