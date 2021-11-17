Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C2B453F40
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 05:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhKQENq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 23:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhKQENq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 23:13:46 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54343C061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:10:48 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v64so3358397ybi.5
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iftNYVHgsYDVzRqN/VJ4YcxCuwfKCJU520fY+ilF0Ds=;
        b=M9cncc/5KAqetuhhx3+SP2QYRJU91zf1W0hxcOfj8WgQtPfoqSdpeehEt+OUd511gR
         KmQty+qjJzn2Pu76UCbmph6qbKBB13u2icy2ltiOobJAajIWkXY7UoOAaXJBTwcl4QhG
         7yaX6LTCo5qGCBKf1/hZEFzbn9sGxdNekJ0LWdgO0kAZx3s56hpKBVmPYqa1C07Sqd4g
         iuoibxSRb2bNqn32Q1l3jcKonrcly8CU7ATRk4+zZE1DxBooxeb30mvOZIkT0kac7oqi
         fNNKxuO2nLtY9Hnq0UrW3rtlLpOvSPqwTkzj5QZjSQ44qv/ETVNbaHDItO8SZS4LtAdr
         gnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iftNYVHgsYDVzRqN/VJ4YcxCuwfKCJU520fY+ilF0Ds=;
        b=Dy28ssAbc6E7R2XySeCvrvSSGoEQ016fDqZ95ohxhfwwIyQFuE5rqMSx5kQoXBxCMt
         7ybuXOa2fm2cjeoDG9269usBIj6ks2Tzv0Yp4RMVzaa2SEeymKPQ4SXodN93T+npqDez
         7C0kQX6tzzzrSynbirIQj8zGHFpPw5XHqY7xNzG/grijBP+Tc2lyZt8S//f2tfK+btxA
         aAxpnnT6BNwEW7UmEFh3NYwLJ9DepT9ZdzMebqc6wAm8vuIlHNwtvNkBMlZWRRguQCoi
         Rqwwq4bP8qfS44JL6DCFOje3bYUkzo2rtuY27GVHbH5JsgU8vJBmv2PwW71bEW1sCNcX
         jnYw==
X-Gm-Message-State: AOAM533iFIO3HWUUEVkfIAhtxQc123izUCr1kUDZ+LVp6/pFXF4wW5dV
        KYDze73DE8MQwvuiRsvHWncJs5ttogp4oTHpnZI=
X-Google-Smtp-Source: ABdhPJzLpChb6Coy9HHalfXsmr3ovuzOFzI2JEytHcV0hpQx2nU7IuYkry3ugUdzl5R4sn4/53K/kS9FZGoL7W9DXO4=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr13950661ybt.267.1637122247667;
 Tue, 16 Nov 2021 20:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <20211112050230.85640-9-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-9-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 20:10:36 -0800
Message-ID: <CAEf4Bzb616KOPoBwRNMSCv7rrwjk+UAn5Z7AHApTt6xJJV5UMg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/12] libbpf: Support init of inner maps in
 light skeleton.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 9:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add ability to initialize inner maps in light skeleton.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/bpf_gen_internal.h |  1 +
>  tools/lib/bpf/gen_loader.c       | 27 +++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c           |  6 +++---
>  3 files changed, 31 insertions(+), 3 deletions(-)
>

[...]
