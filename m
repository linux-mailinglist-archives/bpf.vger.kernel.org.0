Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12830455A03
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbhKRLWF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:22:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343686AbhKRLVQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKXECwlKJnTuqjg74qLzINg8XoDTxb+Cw8qUtCf34/U=;
        b=C5TE8+TsuQnxPyi6HhX2/pBSFhJw+afMpowpZO9mTsG5aPnS3XHBc3gNqbYjU2be+f+hq1
        Np/lWnjtHsr9Fy6czxjLkDeYzqyK/um5I5HUJ8TiSE1/yz3nIl1A5uN3f5tDfaMARszoss
        Hg1VcpsizC64h0Mfih904MD7C6RhyME=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-WauS0tnyOKu5Z94I30lM_g-1; Thu, 18 Nov 2021 06:18:14 -0500
X-MC-Unique: WauS0tnyOKu5Z94I30lM_g-1
Received: by mail-ed1-f69.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so4985902edx.4
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dKXECwlKJnTuqjg74qLzINg8XoDTxb+Cw8qUtCf34/U=;
        b=4MYPri06J0sdLdq9lBooY3dtRlIKb42KC1sv4XSNPumtFDFPSqwHW5Iv9CgSTzxFFM
         I8/GuKCI/jmDn4t37UPH3Hov1hD+2EMZhc+sx9ZYSB5SLqDseUAo9XkMInI4pNlFDVOi
         ufHZKQcUth9G84j7FsUykdzyHIvbOvzfxyzXKLhGXe2lNBGp1V1aETdIlwwWJgOyZm7y
         xVOo+H+gSVx0OxREE1jsZX20xOAM00MWDE6AmLB6zEviHTEKHSMbPLbxiVojTvTg3rHB
         YNtp0+OPIar7eiRIOVvCR6q0tfNB3MB8u6SHVBdejUKChHHVxFGay8WrAUgDxzZWDvDi
         aB8g==
X-Gm-Message-State: AOAM530ryy0cxi/b/dH6DcmtFugkgTLPdPCb+uwmW2YUVuW30BpGt0kD
        dXKBtfcVnhKMhJCnNFsv8zV0gNdANoC3dn91vCXL9ELeZayVLqYy/I5AtDnsWjrFleHyYde5O/F
        BzR2ZLFVm0Hpw
X-Received: by 2002:a05:6402:350e:: with SMTP id b14mr9988128edd.271.1637234293223;
        Thu, 18 Nov 2021 03:18:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycfpd8FyPDsOWxIIs09OGFO5ontBJH3Lb/jXifie7TtVIftImAorFWh/vFwPcodLAiBFYxzw==
X-Received: by 2002:a05:6402:350e:: with SMTP id b14mr9988073edd.271.1637234292959;
        Thu, 18 Nov 2021 03:18:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x15sm1445991edq.65.2021.11.18.03.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:18:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BFC21180270; Thu, 18 Nov 2021 12:18:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, Kernel-team@fb.com, Joanne Koong <joannekoong@fb.com>
Subject: Re: [PATCH bpf-next 3/3] selftest/bpf/benchs: add bpf_for_each
 benchmark
In-Reply-To: <20211118010404.2415864-4-joannekoong@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
 <20211118010404.2415864-4-joannekoong@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 18 Nov 2021 12:18:11 +0100
Message-ID: <87r1bdemq4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> Add benchmark to measure the overhead of the bpf_for_each call
> for a specified number of iterations.
>
> Testing this on qemu on my dev machine on 1 thread, the data is
> as follows:

Absolute numbers from some random dev machine are not terribly useful;
others have no way of replicating your tests. A more meaningful
benchmark would need a baseline to compare to; in this case I guess that
would be a regular loop? Do you have any numbers comparing the callback
to just looping?

-Toke

