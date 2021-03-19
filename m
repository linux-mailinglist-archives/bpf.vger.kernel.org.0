Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646023419D9
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 11:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhCSKX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 06:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCSKXA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 06:23:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A048AC06174A
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 03:22:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b9so8544518wrt.8
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WaWuXQsfpErmiG92ePlLANdoUT94BhT69NFiv2QX2sI=;
        b=C2bp4nAy4BcKicv2NezOvUicQlbnKX+dcmN2djxiud1Xh+b8VVF58TAcQCQHediD4U
         HQSUDHI6ssznO6kl8aed4ClIhjBzlbO7l+ZFJyI7pGTZDFUPP5620gGGPv0vX15gAvVD
         gZuOltjCXbuSiGOePA0DjboJ3oDkVYR/PaNmwB5+IUjDRz8xoCCxMYbpIax5qbTgqUwa
         A58MYDfSo//nDaLpuFqGgPO0ZaC204gIhqUb1BztRUssRi9laCXuNxMhlVnZUOnSGp78
         aDvNjHq5zM1SLbqPok8oPo/kiEu54xZt6YBv9fNiGWROxKRP02ceIk4d3dZDq3SbW9iI
         IfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WaWuXQsfpErmiG92ePlLANdoUT94BhT69NFiv2QX2sI=;
        b=gLh23FuNRfvUXICZ3xjslEctQukADm7hWxafRjDAUYjhf7N9wPfTkjl46O8DmVNWBS
         BoxeVnkiM8MxLyfP1yYdpNmrwgRpKA+0yQTtWpB9YbJGdigy/P3BxObMIgrzF7tfj+XW
         V3nghZZWW+gromM3wFIIq+enCqTPmWR4btK+H5lUQwnFrscPQRfpsWsEvNY6MR1PN1Dl
         RB8DyT/2RhFCKYtq16KklnPDXu24tsBHOGwz2E47xM4Ck5z7zJGZnk/iSLsurvHm+wUp
         8Gzxaur6yqYX2AsXEdo1vfMYHPCTSW5+HTQbRLExLpSpLa4BmjHdxrl5ifzR9S9HoAi0
         FpaA==
X-Gm-Message-State: AOAM530F0WkO2gJpnss6mDDWX++Sg+aoAmUQ+VY9xd++3V8RJ+QoxQii
        SI45BRGjUKQfr46AoMZieelkfw==
X-Google-Smtp-Source: ABdhPJzY6vsffNpzW5B/zJVglBC5c54GWTcZG4nBFTG3oj9ua0WtFE4JDggT/MTIYh0uc9mXJX6tmg==
X-Received: by 2002:adf:a1d8:: with SMTP id v24mr3667772wrv.378.1616149378239;
        Fri, 19 Mar 2021 03:22:58 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s84sm6032177wme.11.2021.03.19.03.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 03:22:57 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:22:40 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] libbpf: Fix BTF dump of pointer-to-array-of-struct
Message-ID: <YFR7cOIV+kyHYzgJ@myrica>
References: <20210318122700.396574-1-jean-philippe@linaro.org>
 <CAEf4BzZzXxYxjzH86VYh0TvpW8u2+4qgAD1wMkRncYiiJ+2-0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZzXxYxjzH86VYh0TvpW8u2+4qgAD1wMkRncYiiJ+2-0g@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 10:08:36AM -0700, Andrii Nakryiko wrote:
> Yeah, makes total sense. I missed that array forces a strong link
> between types. The fix looks good, but can you please add those two
> cases to selftests? There is progs/btf_dump_test_case_syntax.c that
> probably can be extended. Please think about a way to specify types
> such that the order of BTF types doesn't matter and the issue has to
> be handled always.

Sure, I'll add those selftests. I didn't figure out a way to trigger the
error unconditionally, but given that the selftest is always built with
clang it's still a good regression test.

Thanks,
Jean

