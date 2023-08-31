Return-Path: <bpf+bounces-9023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE578E593
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 07:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4E81C209C2
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 05:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C771872;
	Thu, 31 Aug 2023 05:15:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B951846;
	Thu, 31 Aug 2023 05:15:24 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB9D2;
	Wed, 30 Aug 2023 22:15:19 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6516bc20f37so1435926d6.1;
        Wed, 30 Aug 2023 22:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693458918; x=1694063718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M8FIm4HOaEvNyGP3mdXlZvY4sb39VihsE/tZdbALed8=;
        b=ME/5KVvmx0h07oVhAwuBXJFRVRZrfEEVdsKNpr6uRho9QjZMP/WSdQB/IonNsiknXD
         GLSPJwjr7M903X41lbctshxgiju8Yl1yxHApkGJgKy6UYzO+wBrMSKP2/zR3oILy6dem
         hIKdLz20tG7q6WFGFH61Oatt580N5g2PESR7NTHg9w7cOeWjDIDEk2UVX83z+j3QsdpA
         JwkF4UTrksMR0B+jFdCW15YQLHLX73ZJkA84EZaWUzt0wATChJjXv+gqTKIAhdFT06pP
         To6tEiHu2Mv6Y6Vvat2TDV0WPxhAyyrR9snaPpgLUhKiWbrw4bLcEzPNobh4EiO98Trb
         EJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693458918; x=1694063718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8FIm4HOaEvNyGP3mdXlZvY4sb39VihsE/tZdbALed8=;
        b=fGRxJyzkpCWXj+ryYep775j2vPjcJc69cTwPqOKtEq+GdzQejlFyzMpPOPrNZndO2V
         uO2BBXWhXoqjn7a29UKyMEwi0JktLcurDDHSECJjlhQo2/3SR3vOzsbsz9IQUfONxPnM
         ikTu9+pKrvi2BQETDyhdG1kdqDF7M7JfyQNMnENjt8NU6I5Rg1imWoY/xGl3P3EKolEq
         GxZLXNvM+/FEVvMv4XsmcJKzEB3qzMFAWtIT1UtcIqbUJgf5yLBJStG0cCKwAHN0FtBt
         hZ8jKTBQP50N5jZUg02PMKCGkwkWAXsoMQ/YK2aJM2G7uYC2KAHVvVjgMarJbdIGbYlH
         2pwA==
X-Gm-Message-State: AOJu0YxijBDSG5q6vW3AXCUy8SGgICgdiXXUOpr818qmy1HzxnPg06yA
	b+UBFkJ2+Aqtf+/tDPlhtJsjowUH6BPyLVCN6UU=
X-Google-Smtp-Source: AGHT+IF7AAV77xKsJCzoV+Bu5gHFIlBoNDuDAlriBlSVpWp/GZ5tmKuBC18U6WnmOilTrcbJTed6WwcZny7OQneFJYg=
X-Received: by 2002:a05:6214:1d2c:b0:64f:8b28:b753 with SMTP id
 f12-20020a0562141d2c00b0064f8b28b753mr4480064qvd.0.1693458918578; Wed, 30 Aug
 2023 22:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830151704.14855-1-magnus.karlsson@gmail.com>
In-Reply-To: <20230830151704.14855-1-magnus.karlsson@gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 31 Aug 2023 07:15:06 +0200
Message-ID: <CAJ8uoz3V+UXc0K1uYA2zU7oxmbOAQPAf3Uti7W3cmH4hK1s9kg@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: fix xsk_diag use-after-free error during socket cleanup
To: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, maciej.fijalkowski@intel.com
Cc: jonathan.lemon@gmail.com, bpf@vger.kernel.org, 
	syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 30 Aug 2023 at 17:17, Magnus Karlsson <magnus.karlsson@gmail.com> wrote:
>
> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Fix a use-after-free error that is possible if the xsk_diag interface
> is used at the same time as the socket is being closed. In the early
> days of AF_XDP, the way we tested that a socket was not bound or being
> closed was to simply check if the netdevice pointer in the xsk socket
> structure was NULL. Later, a better system was introduced by having an
> explicit state variable in the xsk socket struct. For example, the
> state of a socket that is going down is XSK_UNBOUND.
>
> The commit in the Fixes tag below deleted the old way of signalling
> that a socket is going down, setting dev to NULL. This in the belief
> that all code using the old way had been exterminated. That was
> unfortunately not true as the xsk diagnostics code was still using the
> old way and thus does not work as intended when a socket is going
> down. Fix this by introducing a test against the state variable. If
> the socket is going down, simply abort the diagnostic's netlink
> operation.
>
> Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
> Reported-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  net/xdp/xsk_diag.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> index c014217f5fa7..da3100bfa1c5 100644
> --- a/net/xdp/xsk_diag.c
> +++ b/net/xdp/xsk_diag.c
> @@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
>         sock_diag_save_cookie(sk, msg->xdiag_cookie);
>
>         mutex_lock(&xs->mutex);
> +       if (xs->state == XSK_UNBOUND)

Sorry, but I have to spin a v2. There should be a READ_ONCE() here of the state.

> +               goto out_nlmsg_trim;
> +
>         if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
>                 goto out_nlmsg_trim;
>
>
> base-commit: 35d2b7ffffc1d9b3dc6c761010aa3338da49165b
> --
> 2.42.0
>

