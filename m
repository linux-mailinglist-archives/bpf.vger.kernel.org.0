Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635032F593F
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 04:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbhANDW6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 22:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbhANDW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 22:22:57 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7079DC0617B1;
        Wed, 13 Jan 2021 19:22:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g15so2823081pgu.9;
        Wed, 13 Jan 2021 19:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CTVTbkumnoEU1uD8jeXUwaSLTKMW7UIby0+r1GJ/mQU=;
        b=HOKsM+IQEJkdY4froDriO6Lqn1yDmr/mfX8mE4/Z7gP6r6Zmkd8EYzgRUUe0zIufFI
         wq/r81L7aMknI8S1OYLKVTHQA5mz7V0Uzf1NLSOX+exGPoreIjj4HxKMpVz05Ml4IVSv
         AG4fmn1zWcfyS/OTpGDqQfuMmryj9rXRJzObpf+0zqSAJBCJVvNjDTsH8yLy/3QZ6tIw
         S9MlbbILOAvo9wOYTp9y/3LM6HKE77wbKn1oGsUiQ7qgFlhLY5roMf0UXZh4cMTtOnOw
         mjX0Bxjb1VJSwZY6NF72hk4XGU/q67zRcL+4at/2aD/ZsfA8bNR24nLfVPRC2NeRIKj1
         8F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CTVTbkumnoEU1uD8jeXUwaSLTKMW7UIby0+r1GJ/mQU=;
        b=cgdqgOIb4ejUX6etWQEmByf4vjjpIQYtOOHiOqZyHdjT+23XcfqsrtnWX9+E/9PKnv
         FYvkQ6B2xi9QLkXBIBDmv/o/YN460x9PQKll3Cqb1yn5NdDnJ4uRJtBQ6rNTFl/g5+wq
         cMkijbxvtwmIqtqZevlkbdd/hGSWKj9U2Vk6hE5N13PigCOiv9QhBteY5eNuKk3DGZoD
         QGCk8DNbT18J2uuZH7IEghmEFcWPWHASOnbXRfuNV/ZnjTPA9LgfEiqnz0znNTqVTXX3
         dGIWPd8mTS/Jn0VJhsNkmcOjGPaaaSJ6BRd0akZsTuQyBjOi6SVx8Q70NnpPRAaycDN3
         OFcw==
X-Gm-Message-State: AOAM532Zg6kCAARgwVruRIKPiDRUK7JJ3MYytHbFgilXedmhlzYZmBO9
        3GAb1VQJmIdogQXSOebfl5E=
X-Google-Smtp-Source: ABdhPJwxTugB+JHU93MxVdDPdyHO33wJrVeX/cP1LOwxXHHk52vfGUBghXOxmxVWZv3+pNrVbvCjGA==
X-Received: by 2002:aa7:81d6:0:b029:19e:2987:7465 with SMTP id c22-20020aa781d60000b029019e29877465mr5425258pfn.29.1610594534941;
        Wed, 13 Jan 2021 19:22:14 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:54a])
        by smtp.gmail.com with ESMTPSA id h17sm3742463pfo.220.2021.01.13.19.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 19:22:14 -0800 (PST)
Date:   Wed, 13 Jan 2021 19:22:11 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v6 00/11] Atomics for eBPF
Message-ID: <20210114032211.ynhesnthmsrfotfv@ast-mbp.dhcp.thefacebook.com>
References: <20210112154235.2192781-1-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 03:42:24PM +0000, Brendan Jackman wrote:
> Happy new year everyone, and thanks once again for the reviews.
> 
> There's still one unresolved review comment from John[3] but I don't
> think it needs to block the patchset as it stands, it can be a
> separate patch. Hope that's OK.
> 
> Differences from v5->v6 [1]:
> 
> * Carried Björn Töpel's ack for RISC-V code, plus a couple more acks from
>   Yonhgong.
> 
> * Doc fixups.
> 
> * Trivial cleanups.

Please fix riscv build and resubmit.
I think that's the only outstanding issue left.
