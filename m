Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8892425810
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 18:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbhJGQiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 12:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242297AbhJGQiv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 12:38:51 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93CC061755
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 09:36:57 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r16so6710557qtw.11
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R+nvG1YUcjlBXRbcjhflH1DRtQsxGyawawppd16ek2g=;
        b=A5xp4fqdGPwkI/MCF//eOcPwfi8uSH1Ia3f4IAtTn/OYz2jNeTC4fy1j8j/kQ0tb5B
         fgmqP+xnm/FTnZ1kEGMlZ76vYKRhBqklUmJYXQhfgCMtYZw9/N43EdXzTn2dg0qiQEaV
         2lL39oykZBLCubAh0oIW5HmIKRCSVRMcjsxX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+nvG1YUcjlBXRbcjhflH1DRtQsxGyawawppd16ek2g=;
        b=vZ790SBOTybyct4ShhWQvIuC9OIy/5lAv/s7ZaEXNyFQa3HGonbCUL5nxb9l18q6QO
         14H+xxLYaA0rWXfCY/u2syIz8kmXlAvpYHg2J+7j6LB6hOYFT4xMEPO6GIo9JwXUO9uc
         zLZX7iqSPRaKYyeALhPjAvIlDhlsnkfnlaD84Ch641Dpl1m3gGGf6u7CAu/Q4umB+qPK
         MrL5IoSjg+5PSyMDFcaLi614Q1nExokOIFaa/il4DX0ZyE8aKZ46LgM5SPlCijL7ni+S
         G6n1v3HIUXC9f3XjCNDxrTZ7N14lqOLejAr1adsHXiwA+l3oC7nLeQu8JcAvZtZxY6Eh
         TVoA==
X-Gm-Message-State: AOAM530bLVC6pFNOZwMsHLZqvLLTHpVkF6ngKG4Rm9VHHTpdwERUCJ8d
        XI3kqX4cjCR/XlVNOT8eJnpuyw==
X-Google-Smtp-Source: ABdhPJwZgLJTWRUxz5TniPZJDmnQfLCbw51HS1BmI2bx80OU/NhQ6y2KNQKl3DkhqsfzXnvWnRdwZA==
X-Received: by 2002:ac8:24c:: with SMTP id o12mr6221362qtg.99.1633624616445;
        Thu, 07 Oct 2021 09:36:56 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id b1sm20466qka.34.2021.10.07.09.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:36:56 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:36:54 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Howard McLauchlan <hmclauchlan@fb.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] mm: don't call should_failslab() for !CONFIG_FAILSLAB
Message-ID: <20211007163654.44wiufdolvqkddnd@meerkat.local>
References: <e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk>
 <2dfc6273-6cdd-f4f5-bed9-400873ac9152@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2dfc6273-6cdd-f4f5-bed9-400873ac9152@suse.cz>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 07, 2021 at 05:32:52PM +0200, Vlastimil Babka wrote:
> On 10/5/21 17:31, Jens Axboe wrote:
> > Allocations can be a very hot path, and this out-of-line function
> > call is noticeable.
> > 
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> It used to be inline b4 (hi, Konstantin!)

Congratulations, you made me look. :)

-K
