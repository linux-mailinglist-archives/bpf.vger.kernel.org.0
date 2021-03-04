Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A06D32D4B5
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 14:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhCDN5H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 08:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbhCDN4s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 08:56:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2582C06175F
        for <bpf@vger.kernel.org>; Thu,  4 Mar 2021 05:56:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m9so6398710edd.5
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 05:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNqt364yKc9AWMgU3gsE1glWEHnIX0hXdX9QnycDgAE=;
        b=h2MDWr0x+l/RRdWo87aMtBHYHL/EZs/ptnrUUCflnO+hIHY6vAI41jyhBF0syGZn/p
         Op3XhjCGwMm/0GobwqzZwPc69RXJUMVBpaN54DUECA4S9O2T7SxDqu9P5GR5Jr7JAbBi
         3xonWuM81lIInxPJBH7AABQqrezhq0wiLKqZ3ZlAe+DGtoWj1MDjKFDuYmVNT7cnvCPF
         T0rSDDmILzCUYwmNsoKGMDS9ZJL5wEpQlVfEbc3MQ7EJiBMu/tmUiZ8qVGTACDpnUggm
         P3z4cHSInsJnZ/lId4G3SFSzObh7UJ/sVc/zw8IB+ofkt/INH7XSoSiqfsvpVZu6L36d
         KfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNqt364yKc9AWMgU3gsE1glWEHnIX0hXdX9QnycDgAE=;
        b=ByuPDVnx/C8wLxxumSD2YSWosOiINPK5LY/bDv8iJg2Qh1XYvHFOhssKmSeaSfeROj
         e7HFRZnOXUFwf/9hpUQwPi192ESf5/aM6c9gRWhhoGqhx8FvdIKSJZFRen3SKV+ng4Lj
         6iH3Oj6zUat+/nV0v0ecGQJktLguhAVZEKuzVluWyH9QfcszTadHvSnalOmrI5MkHnBj
         sm7S60mBPnVH4FN7kVF/6XDC5sjZlY8tyxnqZ0GEv8ao5jao+1oonCRnW6qy0cGhPMRn
         prCyIFqs0dD7iHmV06hatq7trGIsQ4G6wqKZS6l/c1zew2tZTIF1rBMHAjHfgxU237eG
         XXuQ==
X-Gm-Message-State: AOAM533EJLWOhpUAfhlsxcbm4trUsKlWz8BhsJoiUlvbgpT5tlXuZUvt
        +sDKefLZfmtyBol8QHD1C3wiYHLlzGw=
X-Google-Smtp-Source: ABdhPJwXTJWytIsyWSpwSKDWlZQfF1hqo+lwl/A9iGQNVcWc4EWtFXn7X9rDyujpn/GUznvwqmFrHg==
X-Received: by 2002:a05:6402:cb8:: with SMTP id cn24mr4528528edb.105.1614866166173;
        Thu, 04 Mar 2021 05:56:06 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id cw14sm23509803edb.8.2021.03.04.05.56.04
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 05:56:04 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id f12so23948871wrx.8
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 05:56:04 -0800 (PST)
X-Received: by 2002:adf:fa08:: with SMTP id m8mr4317031wrr.12.1614866163865;
 Thu, 04 Mar 2021 05:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20210304064046.6232-1-hxseverything@gmail.com>
In-Reply-To: <20210304064046.6232-1-hxseverything@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 4 Mar 2021 08:55:26 -0500
X-Gmail-Original-Message-ID: <CA+FuTSc3W9jcL97OF+ctRWLhFoUdNxb3P0MyPm9k7W8nTvWX0Q@mail.gmail.com>
Message-ID: <CA+FuTSc3W9jcL97OF+ctRWLhFoUdNxb3P0MyPm9k7W8nTvWX0Q@mail.gmail.com>
Subject: Re: [PATCH/v5] bpf: add bpf_skb_adjust_room flag BPF_F_ADJ_ROOM_ENCAP_L2_ETH
To:     Xuesen Huang <hxseverything@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Xuesen Huang <huangxuesen@kuaishou.com>,
        Zhiyong Cheng <chengzhiyong@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 4, 2021 at 1:41 AM Xuesen Huang <hxseverything@gmail.com> wrote:
>
> From: Xuesen Huang <huangxuesen@kuaishou.com>
>
> bpf_skb_adjust_room sets the inner_protocol as skb->protocol for packets
> encapsulation. But that is not appropriate when pushing Ethernet header.
>
> Add an option to further specify encap L2 type and set the inner_protocol
> as ETH_P_TEB.
>
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Xuesen Huang <huangxuesen@kuaishou.com>
> Signed-off-by: Zhiyong Cheng <chengzhiyong@kuaishou.com>
> Signed-off-by: Li Wang <wangli09@kuaishou.com>

Acked-by: Willem de Bruijn <willemb@google.com>
