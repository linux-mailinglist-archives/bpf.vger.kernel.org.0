Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49AD40CB47
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 18:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhIOQz7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhIOQz7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 12:55:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07025C061574
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 09:54:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j6so3232872pfa.4
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtsvVAL/ItXC2fwOtn1d1vwMu3nzn136pwdopYAdZhk=;
        b=WXi2z4w3QVqX2AR06wiCfD/CXVFR7etkVYESTsEoNRgPg7mYUrU7L5bO4agtvybx//
         nroBKFGQVUg96vSFGJBKStmNJ9pL9/e2M5LdUDYuksRh32Owuigko+wXAAGN+Gt+lXfR
         g33Ha9MYzYkYF6EZZvZIbei94U5DF9d9f5ZlAxKkYf2qBKqnjZ6FOu5R/VBPOtr5dYcs
         +GpMEJUVbu5b6EfSbAQGvm0wz+kIZtn+gNmzFrFcPY/UIUFSSJVKXXkWBML2Jlj41/i+
         aO1kTCFIPk/vnFCdm8aqUqzxTlBrCH4B2l/l4+G/EJtSGcjFBAGQ+5YRF+5bWgqLpC8u
         F2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtsvVAL/ItXC2fwOtn1d1vwMu3nzn136pwdopYAdZhk=;
        b=kPZGPMJTxdPIOif/F4zPvVV3zyHYezWtg4pNUJqEbVoWE1Ypdp7DvbQpequmdBARwD
         Fb6gUI08d3K2du4hwMrEnNPuAMZ1lYyC0h4YFCzL4NdXhu6YH++Odae0QXFdQw8xst14
         gGnKl7fpuedZQvvKYhLb44dytFfZ8hI6EzteJtchHKtzOqB+b3wup/Ef2q99WloDKUVs
         lIMzeZUzpq5A7oo+cm+FChtyLwOPV7ISohnGdtnViyWLJt/bvX/Y8d3TgqAju0ygUdVu
         IcEqi8NXKNNxQ82t9hk1Y+HICZ59ulSm5s6bqQ+QJcMx6bW1CGFncLpHdCrxJHSmNNWH
         Luvw==
X-Gm-Message-State: AOAM530lqCuaR0bxS9hX8l3A7lSgRveH0kFGHs8eu2n+Zbn66JBzmaSK
        susukaGCcxNRWbK4+/LQF6315jqUpg3aqNA+34E=
X-Google-Smtp-Source: ABdhPJzquukqb7Yp/Y/Z7yPFHOq77Q8VY4/HlNeTjJlN7ZK4fYkVc1mJqsBevTefi2ix+dWqyzzPz2GZtPCNv6bqx7U=
X-Received: by 2002:a63:7012:: with SMTP id l18mr655249pgc.167.1631724879493;
 Wed, 15 Sep 2021 09:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com> <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
 <CAJygYd24KySBLCL2rRofGqdPkQzonxBfihRxLQ=O8Xg=AWAowA@mail.gmail.com>
 <CAJygYd3M1E3N9C02WCmPD6_i9miXaCe=OP-M32QTnOXOajBPZA@mail.gmail.com>
 <CAADnVQJB3GKKr1hMWHNKYhoo8CzrDQ83LEnO8c+ntOBtEkjApA@mail.gmail.com>
 <CAM_iQpVw-5dG8Na9e851bQy2_BcpZQ5QK+r554NZsP0_dbzwNw@mail.gmail.com>
 <CAM_iQpUG30QL03Uh9D_ACy_29TLWG+YfDO9_GvcqzW2f0TbpYw@mail.gmail.com>
 <CAJygYd2f8S5Oq_B8724p-3rQvXaJKMBGgBKLS_0R7fxTew2oeA@mail.gmail.com>
 <CAM_iQpWt8F18_B5b9cYyT7Ri3sua2T2B5ztEGg2h3v9u2-i+Fg@mail.gmail.com> <CAJygYd2uJNEvX4MWruAZ2a3uJ2HJbnoCmMkuS2fFY59S6x=Sww@mail.gmail.com>
In-Reply-To: <CAJygYd2uJNEvX4MWruAZ2a3uJ2HJbnoCmMkuS2fFY59S6x=Sww@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 15 Sep 2021 09:54:28 -0700
Message-ID: <CAM_iQpWpP5SfLyt_aNGAD3hnmC7MdJjrKnxRj6MphwLpMX4mCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 6, 2021 at 7:24 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> Hi Cong, sorry for the back and forth. Let me clarify the problem here:
>
>  If you apply following patch on bpf-next, running ./test_progs -t
> sockmap_listen and you will observe full timeout on all the select()
> calls for these read() , it looks like select() won't work on
> redirected socket, which I think is a issue, but would love to hear
> what you think.

Ah, I see, we do call the original ->sk_data_ready() when redirecting
the packet, via sk_psock_data_ready(), however it looks like those
->poll() still reads the original queues (e.g. ->sk_receive_queue) but
misses the sockmap queues (psock->ingress_skb).

Let me think about the right fix of this.

Thanks a lot for the details!
