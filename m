Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753A922FEB
	for <lists+bpf@lfdr.de>; Mon, 20 May 2019 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfETJLI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 May 2019 05:11:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44780 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbfETJLH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 May 2019 05:11:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so2919772wru.11
        for <bpf@vger.kernel.org>; Mon, 20 May 2019 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iY4bjmFlTOU+kWVhdgeuaCtlCIwIcKYJkRN4xoBuL9k=;
        b=ifu2MzurmOzynu/ICMLIcSkuvuAQbd897GSJqVWzgm3XShjERBZYAj4Y1Ve4DSGfcz
         SPwcFOcZgYG6DMitgEdtcmt+m/Jbf79eqaXJKHOF2KRKZkqW9C2jy2XHSZzrzvWWgOtq
         JMM1ZYqRVSCIzaiRVBwdNQiRI4YajZduxj1JsRep7Up3fXUiYq34h3GVDSMdtkZNZ4m9
         jBUu2PePFB4B8Ktow1i2E8/RTItnSEzYl4f5VFPbYuM9gpTyeaE4ycRbsDCqM5i3G5KK
         DFtZQDsn71yUc4/VTyOSoMqKRs4ABYIcaVJ7BZrzDBFNDHcK8pKv9PUek0HE2OJ2nSA/
         HvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iY4bjmFlTOU+kWVhdgeuaCtlCIwIcKYJkRN4xoBuL9k=;
        b=b5I5to8FJDlm8YDMihu/ngCCuCQ+RE6rMEi4xMb6466Wj6aXbh1OyMn5g2Qq3Y/qfr
         l3m0ez+0psTdZAUJxbyDO9lPvXK0njOhVORDSEMsdHfrbRGMFpfouAazLC0NGRQUpqRk
         y+FKXIj1jbAE8aoPRTL16xjZbJ0zNjvjQs2qVQkR8eFvdu03UoR+jUoz2bgc0P70nyWc
         FXzNooBBXoXIZX6o3luNSlVMjUkZmObHhoKfaU8h5DIzjwbNHml/GThbEcgvjaDgQ9tz
         hyhwOdCmg5lUklewLuDnn+7TmMTvO2nVVOiaxQACFKCNFUgkde069F5QfPwGTfvDKdEe
         m0fg==
X-Gm-Message-State: APjAAAXrQkEv6N8cCuCj7cScvmuTjh3lFqlUhySNxD5PiEiw0Qr/kvDp
        w7gxebspx9rz7goPUx7bxN6U0g==
X-Google-Smtp-Source: APXvYqxLuUKh4+K19lqHo2rP6Vtuu/r9TgPMvae5Zvez0WEKspDuCUYCzvnYcSMwxk6FH+UzPuvh+w==
X-Received: by 2002:a5d:4d84:: with SMTP id b4mr1962859wru.102.1558343466709;
        Mon, 20 May 2019 02:11:06 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id s13sm14350662wmh.31.2019.05.20.02.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 02:11:06 -0700 (PDT)
Date:   Mon, 20 May 2019 11:11:05 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 net 2/2] net: core: generic XDP support for stacked
 device
Message-ID: <20190520091105.GA2142@nanopsycho>
References: <20190519031046.4049-1-sthemmin@microsoft.com>
 <20190519031046.4049-3-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519031046.4049-3-sthemmin@microsoft.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sun, May 19, 2019 at 05:10:46AM CEST, stephen@networkplumber.org wrote:
>When a device is stacked like (team, bonding, failsafe or netvsc) the
>XDP generic program for the parent device is not called.  In these
>cases, the rx handler changes skb->dev to its own in the receive
>handler, and returns RX_HANDLER_ANOTHER.  Fix this by calling
>do_xdp_generic if necessary before starting another round.
>
>Review of all the places RX_HANDLER_ANOTHER is returned
>show that the current devices do correctly change skb->dev.
>
>There was an older patch that got abandoned that did the
>same thing, this is just a rewrite.
>
>Suggested-by: Jason Wang <jasowang@redhat.com>
>Fixes: d445516966dc ("net: xdp: support xdp generic on virtual devices")
>Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
>Acked-by: Jason Wang <jasowang@redhat.com>
>---
> net/core/dev.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index b6b8505cfb3e..240d0b2de1a8 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -4921,6 +4921,16 @@ static int __netif_receive_skb_core(struct sk_buff *skb, bool pfmemalloc,
> 			ret = NET_RX_SUCCESS;
> 			goto out;
> 		case RX_HANDLER_ANOTHER:
>+			if (static_branch_unlikely(&generic_xdp_needed_key)) {
>+				struct bpf_prog *xdp_prog;
>+
>+				xdp_prog = rcu_dereference(skb->dev->xdp_prog);
>+				ret = do_xdp_generic(xdp_prog, skb);
>+				if (ret != XDP_PASS) {
>+					ret = NET_RX_SUCCESS;
>+					goto out;
>+				}
>+			}

I'm always scarred of changes like this. The history tells us that this
codepaths are very fragile. It took us non-trivial efford to fix bonding
here, not to mention vlans (that was pain).

The reason for troubles was often fact that different flows were treated
differently (vlan accel/non-accel).

This patch calls do_xdp_generic for master device in different point in
the receive patch comparing to lower device. Would it be possible to
unify this? E.g. by moving do_xdp_generice() call from
netif_rx_internal()/netif_receive_skb_internal() here,
to the beginning of __netif_receive_skb_core()?



> 			goto another_round;
> 		case RX_HANDLER_EXACT:
> 			deliver_exact = true;
>-- 
>2.20.1
>
