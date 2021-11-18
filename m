Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5864559EF
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbhKRLTO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:19:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343878AbhKRLRM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cwjBk07zXYcKGpaRmrmPvG4R3vqEmjUBjh2ceUBglfA=;
        b=Vc7jhzKOPEVQnL330GUFfOaZ8LdAM2ofxA2Ha28m1d7Mo8ZnQ9TSN0a0TVDMP7tNLJ1Nlz
        4E2g7PJJkHh9wabD3jRULNx+HipjbTdItqV88BC+y5DXB4J6GRwuyc/uova6t2fgUkaZl9
        qzCI1nrRoy1NRYkye+y/Y3648DojQlo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-UkRAVlQ_O2aX1G7VC3x3cA-1; Thu, 18 Nov 2021 06:14:11 -0500
X-MC-Unique: UkRAVlQ_O2aX1G7VC3x3cA-1
Received: by mail-ed1-f69.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so4995975edx.9
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cwjBk07zXYcKGpaRmrmPvG4R3vqEmjUBjh2ceUBglfA=;
        b=vvUSTjcNCRUmu5e0MoMGgZzdVrMO6S+1uHM8O4x0FtR/UEzQAHvXBFucEiKi8QTdBC
         sVLV1+iXw+EmTLYG+B+R3cmEE/8hTKYakFepFVubUqQyt+ALfoX2jRbt7e+ZFfH1OTcb
         J7J22jyeTsa5rJ5HNxsJ0gilDXZCpHLe+kIoUji2QBHj32ZIqPsgEUF8iJ7gI31A9m3o
         USZ3pI9dIwPkas8fj8Jb+2tDnolRJjB4BxUr20hTAUCyFHXuI+5x3XrlQzow8eC6QQdW
         5t2u84XnvJu7JA95pkdTDbUiVNBpQ6sMpiXMLho03uIvWAsPL6jHetoUkgORCxmwcavd
         UluQ==
X-Gm-Message-State: AOAM533pPWxBY+kS3rLlx1EowvRGyDxUSfc3JsAI05DAK+wXD9VCzgKH
        NFPcgay2+nxGwZq/q2aXhdehcxEk0rl49UrCpUu+OHInhZvB8abuRoSirCpJjodp9Ge622jt9BC
        mI2DTtJjY5CPI
X-Received: by 2002:a17:907:a40c:: with SMTP id sg12mr32057378ejc.408.1637234049813;
        Thu, 18 Nov 2021 03:14:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmN3VkLWSHUc4C5oPjY9zQNp+iDtapM+L03o89XfSWtdwW76Zc7YzK+1v8bn4B0evS9aD09A==
X-Received: by 2002:a17:907:a40c:: with SMTP id sg12mr32057330ejc.408.1637234049531;
        Thu, 18 Nov 2021 03:14:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id sh33sm1199383ejc.56.2021.11.18.03.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:14:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 89CE5180270; Thu, 18 Nov 2021 12:14:08 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, Kernel-team@fb.com, Joanne Koong <joannekoong@fb.com>
Subject: Re: [PATCH bpf-next 0/3] Add bpf_for_each helper
In-Reply-To: <20211118010404.2415864-1-joannekoong@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 18 Nov 2021 12:14:08 +0100
Message-ID: <87tug9emwv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> This patchset add a new helper, bpf_for_each.
>
> One of the complexities of using for loops in bpf programs is that the verifier
> needs to ensure that in every possibility of the loop logic, the loop will always
> terminate. As such, there is a limit on how many iterations the loop can do.
>
> The bpf_for_each helper moves the loop logic into the kernel and can thereby
> guarantee that the loop will always terminate. The bpf_for_each helper simplifies
> a lot of the complexity the verifier needs to check, as well as removes the
> constraint on the number of loops able to be run.
>
> From the test results, we see that using bpf_for_each in place
> of the traditional for loop led to a decrease in verification time
> and number of bpf instructions by 100%. The benchmark results show
> that as the number of iterations increases, the overhead per iteration
> decreases.

Small nit with the "by 100%" formulation: when giving such relative
quantities 100% has a particular meaning, namely "eliminates entirely".
Which this doesn't, obviously, it *almost* eliminates the verification
overhead. So I'd change this to 99.5% instead (which is the actual value
from your numbers in patch 2).

