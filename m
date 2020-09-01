Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA62598CE
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgIAQdV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 12:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgIAQdU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 12:33:20 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD4CC061244;
        Tue,  1 Sep 2020 09:33:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so1377056qtv.3;
        Tue, 01 Sep 2020 09:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cIUoMuZZf7xPrNK13nZN7HOLndqPL9CGuSdDJ9qLAL0=;
        b=aHksMkaY0bfOLF4YGWrHpJunXP8ChLZqgymqufhPvjvUlQMBW+zYWk4HxMHMvTG2Rx
         UinjHNyRwK31e5yWlwoPGYLT/1yuO+qMQjHps7S9YWwDHQUDJcVwdBM+lBHx4xU1uzbs
         z0fgBbnUSPd77zq5xVu+vbI9/yIOMilrS+lW8k84TM4dnJOEgPCqN2FxXviCdaupWjXF
         qonvFkgIeq7nhCi+YAZCX89WdgNecvKbGcJE3871lgze99Ekqh4qpZKk4YGe5b/AUfqV
         xhqnSIebVFcwK4Yl7Gsab/RLVgKfOO3dpN/5ycNXwMwHQ2lFEYMYFzUI7By8pGc5758g
         SYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIUoMuZZf7xPrNK13nZN7HOLndqPL9CGuSdDJ9qLAL0=;
        b=FpS42IHBW/JwHK0hHum+e7Oj1Z/0bsA9eSRI1E4fOhtFm7ptblXdre6jCKh1ziSDbx
         eU0fqhOWhFRlb/DwX8J8iXKbMSJnXtcuaMAZ6BIANgRST1MX5O6IFFNhNBOXIObKOlHT
         b7GwNOwbpkuFnazr2uUJCxoSIpuD6rGM+kLqFeAVtBN5EU+YLC5hayklpHfo+r3YEwOK
         nA5ZSd5bVIAmpp1+IepDPro7IiDOnElgubVwB2zD1G2X3tYer/D7OIMMyChTrorJ2tUZ
         JUk14T1cAVJ5sn2nGXaxYKjX0lb0Bgp5ftEfeS/0UMfV4ScsEXF+cL6G77bHeJaRG4Hc
         VI8A==
X-Gm-Message-State: AOAM531AIxEqguTI6clXOyKHqIhuYaNQT5Au+Txvwbhbo7MNDuS3Mf4b
        8QGLE38E5WQXoT5n2kGzABpxASk5/AoYvSIM
X-Google-Smtp-Source: ABdhPJx6dbnFLhZ7MDuFHhM38QkXMiYpll2mngkNeR4LtTxRQ3E4kuhKYb8BAh+NsaRxPUBfrfk9DA==
X-Received: by 2002:ac8:140b:: with SMTP id k11mr2652883qtj.287.1598977999442;
        Tue, 01 Sep 2020 09:33:19 -0700 (PDT)
Received: from leah-Ubuntu ([2601:4c3:200:c230:4970:3d06:3c98:c0eb])
        by smtp.gmail.com with ESMTPSA id t140sm2180065qke.125.2020.09.01.09.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 09:33:19 -0700 (PDT)
Date:   Tue, 1 Sep 2020 12:33:16 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 2/4] bpf: add protect_gpt sample program
Message-ID: <20200901163315.GC5599@leah-Ubuntu>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-3-leah.rumancik@gmail.com>
 <20200813225858.xuy7lbz3kaehvtgq@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813225858.xuy7lbz3kaehvtgq@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 13, 2020 at 03:58:58PM -0700, Martin KaFai Lau wrote:
> Please add new tests to tools/testing/selftests/bpf/.
> 
> Also use skeleton.  Check how tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> use test_sk_lookup__open_and_load() from #include "test_sk_lookup.skel.h".
> Its bpf prog is in tools/testing/selftests/bpf/progs/test_sk_lookup.c.

I'll add this in the next version.

Thanks,
Leah
