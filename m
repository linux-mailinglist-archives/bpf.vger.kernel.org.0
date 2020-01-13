Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9A13922F
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2020 14:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgAMN3x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 08:29:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35087 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgAMN3x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 08:29:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id 15so6876606lfr.2
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2020 05:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=9ZyL8OSm8vrEXo1UYjGMABGrTGFBa8Ctc4C1U+D88J0=;
        b=NJBo1RzdWcamq73kNcIChwee7ZBvOTqHhmt7OYDK9EBB91iPtjrtdRnkIRluAiialZ
         njkYQdytlvdzA3+4g8mNh96+9bdkWMjeJTL5DYpmzHnVDVXuQIRURO8xfbCDmPUkOL9M
         6Zw91yHHyF1czt0t4ZCacJToI7EoVPZ3QUCOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=9ZyL8OSm8vrEXo1UYjGMABGrTGFBa8Ctc4C1U+D88J0=;
        b=rncW5C831jXgfdVO5Hq6gTJxEDhirQrfVIAoTo77cRifUOY3CsFEDejvAaC1Q0Tr8W
         PC0OQLxZb1rSmM0qSL5imV6zhUTRPf+FbGRcEcF7n0j5WSxBSwK8LPjjsBI/Z2ABLtOP
         HJBJy95rYgBrxU7wo7SFAsUTi/1x6Aeq7khaQQfmlc1ZbJSSEj5G7t8Jl8F0P2UMcl7q
         kCT53PhBCwWI3YTfHFgmccZKYDpeoWzkiAtBPuNvIUJtJOLpbdc/5dB6KAg4R778T6f6
         u8kWYHecPS7Tjvcguh3FqWYp8nUOOWXuLUparaJlIItAbTpMBQKlfnD2pGhgvebNbYrD
         tMQg==
X-Gm-Message-State: APjAAAVg3ogYWpZTf+MNGeylBttS6ghq+Ag+f69WQkFO165khEDfVT2S
        7jhHany0RNONbEO0oFn2AQfrVg==
X-Google-Smtp-Source: APXvYqz/bAdH5V+maVueOYptSS9P4ybmSaqJOve4ssz5VKGDVkL+SywNg4QyFGPA5hEMKTCft6nWEg==
X-Received: by 2002:ac2:4c2b:: with SMTP id u11mr9832482lfq.46.1578922191366;
        Mon, 13 Jan 2020 05:29:51 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id u7sm5683773lfn.31.2020.01.13.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 05:29:50 -0800 (PST)
References: <20200111061206.8028-1-john.fastabend@gmail.com> <20200111061206.8028-2-john.fastabend@gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        ast@kernel.org, song@kernel.org, jonathan.lemon@gmail.com
Subject: Re: [bpf PATCH v2 1/8] bpf: sockmap/tls, during free we may call tcp_bpf_unhash() in loop
In-reply-to: <20200111061206.8028-2-john.fastabend@gmail.com>
Date:   Mon, 13 Jan 2020 14:29:50 +0100
Message-ID: <87pnfnscvl.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 11, 2020 at 07:11 AM CET, John Fastabend wrote:
> When a sockmap is free'd and a socket in the map is enabled with tls
> we tear down the bpf context on the socket, the psock struct and state,
> and then call tcp_update_ulp(). The tcp_update_ulp() call is to inform
> the tls stack it needs to update its saved sock ops so that when the tls
> socket is later destroyed it doesn't try to call the now destroyed psock
> hooks.
>
> This is about keeping stacked ULPs in good shape so they always have
> the right set of stacked ops.
>
> However, recently unhash() hook was removed from TLS side. But, the
> sockmap/bpf side is not doing any extra work to update the unhash op
> when is torn down instead expecting TLS side to manage it. So both
> TLS and sockmap believe the other side is managing the op and instead
> no one updates the hook so it continues to point at tcp_bpf_unhash().
> When unhash hook is called we call tcp_bpf_unhash() which detects the
> psock has already been destroyed and calls sk->sk_prot_unhash() which
> calls tcp_bpf_unhash() yet again and so on looping and hanging the core.
>
> To fix have sockmap tear down logic fixup the stale pointer.
>
> Fixes: 5d92e631b8be ("net/tls: partially revert fix transition through disconnect with close")
> Reported-by: syzbot+83979935eb6304f8cd46@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  include/linux/skmsg.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index ef7031f8a304..b6afe01f8592 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -358,6 +358,7 @@ static inline void sk_psock_update_proto(struct sock *sk,
>  static inline void sk_psock_restore_proto(struct sock *sk,
>  					  struct sk_psock *psock)
>  {
> +	sk->sk_prot->unhash = psock->saved_unhash;

We could also restore it from psock->sk_proto->unhash if we were not
NULL'ing on first call, right?

I've been wondering what is the purpose of having psock->saved_unhash
and psock->saved_close if we have the whole sk->sk_prot saved in
psock->sk_proto.

>  	sk->sk_write_space = psock->saved_write_space;
>
>  	if (psock->sk_proto) {

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
