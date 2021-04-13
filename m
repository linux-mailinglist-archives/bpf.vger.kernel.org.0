Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4261935E734
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 21:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbhDMTmL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 15:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231747AbhDMTmL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 15:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618342910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3Xd6e7Tcsaita/bxhL5mEvFZaDd27wDdsSc3xDLpDY=;
        b=Aa6gDRSKhUshAR6qSEXtbpEG4TdGFHzZvJJy4NrdZlSfn/z63bz8ODUl4hz1l2tnCoigzl
        DcjU1NRDrpEQvs7J5aQdymiL48vMikWOWHw2/QoeUQFTCA9Iw92Mco2Fh6bMYAEnj1WzE9
        6zHMeG/oPZjOcrKyahpUTn++Z7Je3Ds=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-swGJErCpNe6kdlOVJ9i3Ng-1; Tue, 13 Apr 2021 15:41:49 -0400
X-MC-Unique: swGJErCpNe6kdlOVJ9i3Ng-1
Received: by mail-ed1-f71.google.com with SMTP id w15-20020a056402268fb02903828f878ec5so1825457edd.5
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 12:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=l3Xd6e7Tcsaita/bxhL5mEvFZaDd27wDdsSc3xDLpDY=;
        b=O2d5onzlt5UYuL8pYMTYuhBlZCqTNJzwXJQRUZZgii4y4MWJkbb6/NnzArbPdcM7Fq
         w9eHdn6IEXN0q8TuSpTtGzCnvZSR5rbt5fuFCm+Fy7TIv7GZhSNu4E/rG10Oia0ufWzJ
         R8QrVEtsHaSxVleowRV799k+z4qQZtLA78orr8PepOoPbqGGwtXBYP2CJpvk8ejbl16H
         THTTWzqnpnK361Bc4kcf1Vm+OxPVNTbxytT2X1Tq6a+dWHxJe3SHo6ouLpdAUsYc1YcP
         /Q0TG4LkR5jR9rMtRWUwyXgbxx3K2NWvGCbJIQEywKWbUgP4O/qprL/Z0x5+CiPYuWR6
         fqqA==
X-Gm-Message-State: AOAM533zHd2MukY0INePjZ5CRguEUxU9zdSJjZxtxsS514o1hL22FyZY
        zt+ou70EkZW+Tdr3uRCrt57FTz/k/nFDyvgx9RudDCHJkVTM8a/f1nmMpxBHMOSUnSnm+CaLSJT
        Ij5c1j04QvPTj
X-Received: by 2002:a50:ee17:: with SMTP id g23mr23348811eds.45.1618342907855;
        Tue, 13 Apr 2021 12:41:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvpdeF9svdWjMVbV2DfqtSl2u4QrSYZVmGOD039HoFJzj67/OERJjVYP3+RQd1Uuii9f5eAg==
X-Received: by 2002:a50:ee17:: with SMTP id g23mr23348779eds.45.1618342907425;
        Tue, 13 Apr 2021 12:41:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s11sm10026689edt.27.2021.04.13.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 12:41:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 443771804E8; Tue, 13 Apr 2021 21:41:46 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, brouer@redhat.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next] cpumap: bulk skb using netif_receive_skb_list
In-Reply-To: <bb627106428ea3223610f5623142c24270f0e14e.1618330734.git.lorenzo@kernel.org>
References: <bb627106428ea3223610f5623142c24270f0e14e.1618330734.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 13 Apr 2021 21:41:46 +0200
Message-ID: <87lf9mm0p1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Rely on netif_receive_skb_list routine to send skbs converted from
> xdp_frames in cpu_map_kthread_run in order to improve i-cache usage.
> The proposed patch has been tested running xdp_redirect_cpu bpf sample
> available in the kernel tree that is used to redirect UDP frames from
> ixgbe driver to a cpumap entry and then to the networking stack.
> UDP frames are generated using pkt_gen.
>
> $xdp_redirect_cpu  --cpu <cpu> --progname xdp_cpu_map0 --dev <eth>
>
> bpf-next: ~2.2Mpps
> bpf-next + cpumap skb-list: ~3.15Mpps

Nice! :)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

