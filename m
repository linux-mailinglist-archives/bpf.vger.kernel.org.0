Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2658353C733
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 10:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbiFCI6O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiFCI6N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 04:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C485533E13
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654246690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhqVdvEqM5kO/wrETIb3lvjWdcZaXOxBj2pduQg40js=;
        b=WeXHdLiMk/o/6kE0E0Ts1lrpH0l5Gxg9KE+sNTZ5eTLjmZ5MXAW86bhbJm8bOtX58vHc34
        dLXH0T2AdBSJL3X0nMoiX5Do7zo2RRYkbAUGuaQWVhuZt5gacQQC3N2itt+Gn5h/z6zRSj
        lga72eTz1rhuwddeiOtMMrj71UhKEZw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-71sWc48FOx6ZZV-Wi35QtA-1; Fri, 03 Jun 2022 04:58:10 -0400
X-MC-Unique: 71sWc48FOx6ZZV-Wi35QtA-1
Received: by mail-wr1-f71.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so1167137wra.15
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 01:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xhqVdvEqM5kO/wrETIb3lvjWdcZaXOxBj2pduQg40js=;
        b=N9KVu9LbfmN9fzP3iyxYjEjSFyBo72aVI0T7DdiF4w9vFRBpwbFIEGW69Yol/G9JSC
         P54Upe7xMJgiqxHqntk1PwghE8nbVhq+DUrzgRZGqMFp2nwDF7MPjEPVBzMWEjhHUJ2r
         V4boLw+xUDb8dPK5Vu2ymYRbfN7rTXiQcq3V5wjueUhx83LUWo122VhGdH8zeMNICtwj
         0VJhMjBmbbNegbEgrZ5rFCDIH2oBVIouebn5sMKmqyi36gb+5X6vvMYnr6J+8Jx2Ljbl
         3VgJTs65hmfDaLf+PZ1HvcSr+bdEPkfGLyKyHBXJF+Zcnz1jCX44J+6KuTgmtqlX2hx9
         vZ9w==
X-Gm-Message-State: AOAM531DPiWGYcYo/xNMog3pzQRlIXcogbwv5lzj3+BFNdR6UF59fNwW
        y67P/py01ynVodb2joletDUYji+pdmLi76r31LkW8D+hpoi4CQcAW6volEZmlGLfsXPWkR5WAEB
        DkJ3R5lgzCUeH
X-Received: by 2002:adf:d206:0:b0:214:d2b:7141 with SMTP id j6-20020adfd206000000b002140d2b7141mr1469192wrh.706.1654246688352;
        Fri, 03 Jun 2022 01:58:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcaDXm8m9t+jcAu893YKwev/nsl62c8pnFnctr6zZttsoCMxLweZJTTfNE01hXoUoBNioM9g==
X-Received: by 2002:adf:d206:0:b0:214:d2b:7141 with SMTP id j6-20020adfd206000000b002140d2b7141mr1469170wrh.706.1654246688109;
        Fri, 03 Jun 2022 01:58:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b003958af7d0c8sm7770037wmq.45.2022.06.03.01.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 01:58:07 -0700 (PDT)
Message-ID: <34c12525e133402e9d49601974b3deb390991e74.camel@redhat.com>
Subject: Re: [PATCH net-next v4] ipv6: Fix signed integer overflow in
 __ip6_append_data
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Wang Yufen <wangyufen@huawei.com>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, edumazet@google.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Fri, 03 Jun 2022 10:58:06 +0200
In-Reply-To: <20220602090228.1e493e47@kernel.org>
References: <20220601084803.1833344-1-wangyufen@huawei.com>
         <4c9e3cf5122f4c2f8a2473c493891362e0a13b4a.camel@redhat.com>
         <20220602090228.1e493e47@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-06-02 at 09:02 -0700, Jakub Kicinski wrote:
> On Thu, 02 Jun 2022 12:38:10 +0200 Paolo Abeni wrote:
> > I'm sorry for the multiple incremental feedback on this patch. It's
> > somewhat tricky.
> > 
> > AFAICS Jakub mentioned only udpv6_sendmsg(). In l2tp_ip6_sendmsg() we
> > can have an overflow:
> > 
> >         int transhdrlen = 4; /* zero session-id */
> >         int ulen = len + transhdrlen;
> > 
> > when len >= INT_MAX - 4. That will be harmless, but I guess it could
> > still trigger a noisy UBSAN splat. 
> 
> Good point, I wonder if that's a separate issue. Should we
> follow what UDP does and subtract the transhdr from the max?
> My gut feeling is that stricter checks are cleaner than just 
> bumping variable sizes.
> 
> diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
> index c6ff8bf9b55f..9dbd801ddb98 100644
> --- a/net/l2tp/l2tp_ip6.c
> +++ b/net/l2tp/l2tp_ip6.c
> @@ -504,14 +504,15 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>         struct ipcm6_cookie ipc6;
>         int addr_len = msg->msg_namelen;
>         int transhdrlen = 4; /* zero session-id */
> -       int ulen = len + transhdrlen;
> +       int ulen;
>         int err;
>  
>         /* Rough check on arithmetic overflow,
>          * better check is made in ip6_append_data().
>          */
> -       if (len > INT_MAX)
> +       if (len > INT_MAX - transhdrlen)
>                 return -EMSGSIZE;
> +       ulen = len + transhdrlen;
>  
>         /* Mirror BSD error message compatibility */
>         if (msg->msg_flags & MSG_OOB)
> 
LGTM. Imho this can even land in a separated patch (whatever is easier)

Thanks!

Paolo

