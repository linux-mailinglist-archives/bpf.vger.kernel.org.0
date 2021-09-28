Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3368041B3FD
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 18:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbhI1QjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhI1QjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 12:39:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E22CC06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:37:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l6so14558417plh.9
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=925DsTITSDrLBVejcK4ZMI1WGCmiSTqn2qBxeYov1qA=;
        b=FvqEHKQ0M2BzhsLcCfllYLsHeK+YQM+7nzFQ+zmLgDFSaKWH1z7i8W/zaXPqATT2nr
         C478PIVHkTFwswrBU5CoQsc3R9s+8p9T3JwnZPnL9LkB8RBwW6zQihz15mTMZbbSdkMF
         XBqaqxu9TnzsAANXMnnd7PbC/6QywSzEJLWqd3umBn2kGiPZAsPfTdFkYRDIkOZ6iRoF
         NiUW25ANG22M2P3n6Jyx+NvhEtvUg4ho/rTf01fqNgFpIw9s5mKJc2B0H6q8Y85K0Cr/
         t3iRZtK3/sw6XtKaHUeoOEClnZoHRMnDPNH7LE3KKNFY0clKt2Nwu4F9ZEwZk2bE9toT
         QL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=925DsTITSDrLBVejcK4ZMI1WGCmiSTqn2qBxeYov1qA=;
        b=M+OXkuxc6mOZY7pIN21I6pzNJsWQyzccn6hvDQIR+KeVdXtJhOLrvXcQnbDovrVKji
         ZJy/MW4T83L1bkFojr1uFGtTNxYx/MbFryW2jWMZxWuS91w3r8mHkcVYky/R/RDTRXKJ
         wyzNkN3zSi5KASNA9yk9/78TZKwn8rDtz9YHz4BMRL1X9IsE0pB67rjK/PBAgvyRptmC
         K7vLm0FqKj6d9el7UTaHFmbTASHZAeqvNLN5wFOyvF2mADnul2Q1k1LhzTqqCAaq6r0z
         xno5C33hgmt1wjlRbgNTIrhb/hjwjU6BLwCDAcR6YlhHNoBjlShXuashzgl8zMrnjj15
         aGUg==
X-Gm-Message-State: AOAM532bOUxLr7R7cbBQyGUmHkR6knZU+ekvDHOIEuWoSnm6q6IRlDa3
        QHyRFpYxQPmfd8OEKXUcp4c=
X-Google-Smtp-Source: ABdhPJxRydWFoDvLIX77H5tc/6mpISKhw/EA22QSPp6QnX9Oh099DxBfjx04eDLPx7gL6PNt3LpprA==
X-Received: by 2002:a17:903:2308:b0:13d:ec2a:2e07 with SMTP id d8-20020a170903230800b0013dec2a2e07mr5984093plh.3.1632847052570;
        Tue, 28 Sep 2021 09:37:32 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::6:e195])
        by smtp.gmail.com with ESMTPSA id w30sm3098134pjj.30.2021.09.28.09.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 09:37:32 -0700 (PDT)
Date:   Tue, 28 Sep 2021 09:37:30 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, lmb@cloudflare.com, mcroce@microsoft.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel
 duty.
Message-ID: <20210928163730.7v7ovjhk7kxputny@ast-mbp.dhcp.thefacebook.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <20210917215721.43491-2-alexei.starovoitov@gmail.com>
 <20210928164515.46fad888@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928164515.46fad888@linux.microsoft.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 04:45:15PM +0200, Matteo Croce wrote:
> On Fri, 17 Sep 2021 14:57:12 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > Make relo_core.c to be compiled with kernel and with libbpf.
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> 
> I give it a try with a sample co-re program.

Thanks for testing!

> I don't know how much of them will stay in the final work, but the
> debug prints are borked because of the printk trailing \n.
...
> -	libbpf_print(level, "[%u] %s %s", type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
> +	libbpf_print(level, KERN_CONT "[%u] %s %s", type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);

Right. It's a known limitation of helper approach.
Currently I'm refactoring all the prints to go through the verifier log.
So all messages will be neat and clean :)
