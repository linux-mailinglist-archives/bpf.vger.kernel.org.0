Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759394568AE
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 04:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhKSDhs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 22:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhKSDhs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 22:37:48 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16419C061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 19:34:47 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id z6so8137847pfe.7
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 19:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6MN2jgEgCfspvh8MxfRDWo8wQJVQ3i+grjC2c9n2FcY=;
        b=jLOOm8Y24/V0jNrKo3DOSrVrYoAkm987/CL0X+IHYYV0aB4SGrjlhXL/l9JfBEcaV0
         Yyjm6Wus0lze1A+siQhuexdsyvu/GVwA2z0dj02KFqWB4hUK8+wjizMLjp4n1rEVujB7
         dTCWP0V0eetZO7GSkGzGUQxK0in05WA/M0z69hNaUzzfsPKR4pxjDIth5oDLXeB/tMwP
         ZiqVMoXjDmEQNSFC4OdrAn453CimfrAhmTW3huakX2JJeCn2/7JuqHabdS8eagFK8mfb
         UJYhtBe+FWncJB4sXiaQLadC70L7Ez1sUAOqOb47qKU0KslXJujAHJNUNyidG8XRjFEe
         lwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6MN2jgEgCfspvh8MxfRDWo8wQJVQ3i+grjC2c9n2FcY=;
        b=S3JySJIu1gessuuGpPy63ST2PWZq5fc+abPBrqRjkXLrcSSatCPJK1F0qw0uUK+G6W
         rJb65aIT9XNdb04o/pE+P5nIClJ7Myl441dBz5i4DUdxs6M6n6dcug0eFhsUWZ6Ou4U9
         TwphxdZK3FTkyhLrFzu16v1vhUfMhqDV7HEv3XYt20chvVT3tUk/6iZhKGPUIBCLe9UQ
         JMNzISYYtG67rwOPp9w5UMCnhlhtTWibj3p6y6ad4ZPF29VkMMGixSEwdWxV5U5NaQHE
         87jHOz+97L9I69+Zwy9Yv0EyoLIGuisM5pCQsQGE5ZHTQV0FCvskgDFauuwlJSyPmCo4
         yBWw==
X-Gm-Message-State: AOAM532hlJMTwqyKAjzV2VpGdmgRyOuCVZolpndt+Q99NKRspNXDAl20
        x8StDR38bowzc86Lrp4TPu0=
X-Google-Smtp-Source: ABdhPJzZJ8TOR8G5R4kSG7nx4U6JpPZQshW/DmdyxYsQBKefOvACNCgTvd9OTfEh1zQSZHv69jbOMg==
X-Received: by 2002:a62:640c:0:b0:4a2:e5af:d2a9 with SMTP id y12-20020a62640c000000b004a2e5afd2a9mr19398348pfb.43.1637292886642;
        Thu, 18 Nov 2021 19:34:46 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e33])
        by smtp.gmail.com with ESMTPSA id j22sm1010050pfj.130.2021.11.18.19.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 19:34:46 -0800 (PST)
Date:   Thu, 18 Nov 2021 19:34:44 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 06/12] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
Message-ID: <20211119033444.hfmnjmbzkgsjkian@ast-mbp.dhcp.thefacebook.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <20211112050230.85640-7-alexei.starovoitov@gmail.com>
 <CAEf4BzaJ4VVBofSetOOyUcpm1avX_TK0RFQmpz2X7Pxw5=U4RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaJ4VVBofSetOOyUcpm1avX_TK0RFQmpz2X7Pxw5=U4RQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 16, 2021 at 05:31:14PM -0800, Andrii Nakryiko wrote:
> > +                }
> > +       }
> > +       err = bpf_core_apply_relo_insn((void *)log, insn, relo->insn_off / 8,
> > +                                      relo, relo_idx, btf, cands);
> > +       bpf_core_free_cands(cands);
> 
> Why did you decide to not persist the candidate list? It is a
> significant slowdown even on moderately large BPF programs, as you are
> linearly re-searching vmlinux BTF multiple times for the same root
> type.

Somehow I convinced myself that it's not a correct thing to do across
multiple relocations. Yeah. Will move the free to be after the loop.
