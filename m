Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DAA4059AB
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbhIIOue (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 10:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235943AbhIIOuP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631198931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9JDbGLr6dkNUoEd0zlqfw7GomTfOIulFrb+2DtUYJA=;
        b=B5M6iD8/K4Z+0ryZ6P9C5iJ8iTkROoppGr4NM+Sk8/spmB5Y07HkrGwrLKEq+DoDUolk+9
        IsXYdR1qQIugo5SlrFqRHElcviVLBWLQPYRHbl5gRj75q7t2M16IMre3/+PZt2ZddJvPjG
        qgi2usmXOilo0hqluxKiQjnL2Y4LbFU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-pCx_YAy1NmWBSxj6vXvuDw-1; Thu, 09 Sep 2021 10:48:50 -0400
X-MC-Unique: pCx_YAy1NmWBSxj6vXvuDw-1
Received: by mail-io1-f71.google.com with SMTP id e2-20020a056602044200b005c23c701e26so1929917iov.21
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 07:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u9JDbGLr6dkNUoEd0zlqfw7GomTfOIulFrb+2DtUYJA=;
        b=MZs9KXWDtdyQbL9wU0wRACu60BPe8oXIfhbqK4h/F5W/577fBznSVCSWz+g06aTGlo
         BjuW8A4JQ5cYwRjptsW6lJCknOBNU3NfQcT/56m6/yTycJG1EeexGuPj9RgOPvAaz6NY
         eZW6U7RNOQPflTi20/wkEGtCTt9BD4MvIgKlira22x/Q8R5h+cB0LaU2yg8tBAAhkp5z
         ihFK42qMAmreB4Vf72Vg9hVXJg+YzXTDqXTFIGpU9BqlDNpdq4RS1eG1uXetCnPw3fln
         Wcmr+sgWvvUiRx8YyESGBeOBllizq/cHs7BCdzpN0tWCvMjYKyceW2k2WLuZ0rslh652
         2AwQ==
X-Gm-Message-State: AOAM532+azlBySbpcNZ/EA0tjEsL0qDcpdyNKywdHNblnuGfCf3mH+n8
        +Jp7/CDlXhJ0WR6OjZ0P3FI6qSJA32ZUcSh1C1zWXgsJIXYqw6FEHXiAGDEN3s+8w4iAXrOHDCw
        iQYazCDqBksV9A72zthtNK1F83FPA
X-Received: by 2002:a6b:3f02:: with SMTP id m2mr2975595ioa.136.1631198929421;
        Thu, 09 Sep 2021 07:48:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG1bHzR6MK4Ss51+mBC39dYSC8m50NMcEX5BeZwpBtCi4rKCrXEQfCjjQYKDJ4jPW6l0G3Uz+rBGHTewBW09Y=
X-Received: by 2002:a6b:3f02:: with SMTP id m2mr2975576ioa.136.1631198929227;
 Thu, 09 Sep 2021 07:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210909092846.18217-1-ihuguet@redhat.com> <5233eedf-42a7-f938-67cd-e7acc5f3bbce@gmail.com>
In-Reply-To: <5233eedf-42a7-f938-67cd-e7acc5f3bbce@gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Thu, 9 Sep 2021 16:48:38 +0200
Message-ID: <CACT4ouf64jvpjUcmfJ=hc0SjrSGYx4QFL0j6sEitMWi-kjp47A@mail.gmail.com>
Subject: Re: [PATCH net 0/2] sfc: fallback for lack of xdp tx queues
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     habetsm.xilinx@gmail.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 9, 2021 at 4:39 PM Edward Cree <ecree.xilinx@gmail.com> wrote:
> Patches LGTM, thanks for working on this.
>
> However, I would like to grumble a bit about process: firstly I would
>  have thought this was more net-next than net material.

I intended to send it for net-next, but by mistake I tagged it as net.
Sorry, my fault.

> Secondly and more importantly, I would really have liked to have had
>  more than 72 minutes to review this before it was applied.  Dave, I
>  realise you never sleep, but the rest of us occasionally have to :P

I go to sleep now too, or at least rest a bit  :-P
--=20
=C3=8D=C3=B1igo Huguet

