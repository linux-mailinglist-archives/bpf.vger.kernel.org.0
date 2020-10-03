Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECBE2825E8
	for <lists+bpf@lfdr.de>; Sat,  3 Oct 2020 20:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgJCSnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Oct 2020 14:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725841AbgJCSnW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 3 Oct 2020 14:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601750601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWM0RfrM0HZAs25gIGx3NLfFo36RAwB9ram8EBWXtH0=;
        b=NzL8+jxeAT74Xoye5npss0OvEUdXZQIqDGyUesVHTbcMOakxAgGGW0EhLyybungMtHp5r9
        n9aO2gLq03wr+xNYAtifB7yTHUJFgmCtRiL94hZqJOldVnZMFhIg0NIys/VRfJKKkGhCcA
        2urgq237/GVFZlc/1+JvIyldM5ZApXw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-8F7NJxjRNTinWg-VgS12cw-1; Sat, 03 Oct 2020 14:43:19 -0400
X-MC-Unique: 8F7NJxjRNTinWg-VgS12cw-1
Received: by mail-wr1-f71.google.com with SMTP id f18so2053993wrv.19
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2020 11:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HWM0RfrM0HZAs25gIGx3NLfFo36RAwB9ram8EBWXtH0=;
        b=fmjEsvZ+n4XZL2MXNe3ZGtxmyb+vK1gwjjZ6ql8+bF20RI8jbmb0LtNKmbz9GaT28U
         mj2HFCmg268S4xp0QV0o4p8AcfLCRars4vzELEuWMacsCv2dyQNcia+2tGbVQwpXa17J
         hG6VM7liX5kRJlq7thq+KCQ1sowChBkfH1G0Y3iYY2POpeJvwcqh3tHbxNk9nGL6dgX7
         jNjEqP8vv9tU5aOY8MyrLTSJZ3bnBQMlbIE2mdnsWGU9Pqaq7dNWffOkrFnDjUb4AF25
         D3uo2slnorQZUiTtYvOk3RpuDHPUeSSxcOp7oi6cGvRw+2PqgwObzsMV3rMyVj+VaI2/
         mJ8A==
X-Gm-Message-State: AOAM5333GOwSrnCxEpnREhlYzSV/2UV0nrq8H+syrIklS99OkeNIZLt+
        5FycZkr2Dta0CNw6dGb0Tpigq2hi3jLbwpvIdxndKcQ+YHPXrT/fPUjwHsrH2pi/wZy9ANTCk0w
        YYj+XhjrT+xAB
X-Received: by 2002:adf:e852:: with SMTP id d18mr9744697wrn.40.1601750598391;
        Sat, 03 Oct 2020 11:43:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy038Yccnpob9//W8sOr1lm3wbsl6dgaQoAhcFw98vUjFVu1T3n44Gs2WlgxSmLiPyyNgs9bw==
X-Received: by 2002:adf:e852:: with SMTP id d18mr9744690wrn.40.1601750598224;
        Sat, 03 Oct 2020 11:43:18 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id z127sm6091271wmc.2.2020.10.03.11.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 11:43:17 -0700 (PDT)
Date:   Sat, 3 Oct 2020 14:43:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     anant.thazhemadam@gmail.com, jasowang@redhat.com, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH 0/2] reorder members of structures
 in virtio_net for optimization
Message-ID: <20201003144300-mutt-send-email-mst@kernel.org>
References: <20200930051722.389587-1-anant.thazhemadam@gmail.com>
 <20201002.190638.1090456279017490485.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002.190638.1090456279017490485.davem@davemloft.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 02, 2020 at 07:06:38PM -0700, David Miller wrote:
> From: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> Date: Wed, 30 Sep 2020 10:47:20 +0530
> 
> > The structures virtnet_info and receive_queue have byte holes in 
> > middle, and their members could do with some rearranging 
> > (order-of-declaration wise) in order to overcome this.
> > 
> > Rearranging the members helps in:
> >   * elimination the byte holes in the middle of the structures
> >   * reduce the size of the structure (virtnet_info)
> >   * have more members stored in one cache line (as opposed to 
> >     unnecessarily crossing the cacheline boundary and spanning
> >     different cachelines)
> > 
> > The analysis was performed using pahole.
> > 
> > These patches may be applied in any order.
> 
> What effects do these changes have on performance?
> 
> The cache locality for various TX and RX paths could be effected.
> 
> I'm not applying these patches without some data on the performance
> impact.
> 
> Thank you.

Agree wholeheartedly.

-- 
MST

