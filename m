Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77741B2F01
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDUSYM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDUSYM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Apr 2020 14:24:12 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D4AC0610D5;
        Tue, 21 Apr 2020 11:24:12 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h6so3520340qvz.8;
        Tue, 21 Apr 2020 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1MpibdzZKUcWDPxbG1corhK5+ajDsK8Y+8yjQ5ScihQ=;
        b=B5ZLuleRvVuEnP3GDHokJgx7lo+qLJYkVM0wzkxOrBWtY0WKsdpbmFVbxW819LaToB
         VRj00+31R6wouGqtzN3SnitnTZ1cEN6GlaVGdEo3+0u8rdwCv0U8HJeZJ6ZASV4roWpg
         ueA9YujFUn1j5pr/C+XW2RjJ5CTYf2J++wt4z3cQAC8WBRyyWDOv9QiX536GXeTxdOOj
         lANT7y6quUtL2IfixkMG3WbXMolwfa5LWu4Mcz/h59ptEU6NnnZ60E+sbk79JcUnlx38
         LHiUnnuSWMsoJBCkfeTFGUrtHrJyfgS/KZ7VmSxdmhOLfJtmVjcVCWC0VYcKGPOhH0s/
         BD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MpibdzZKUcWDPxbG1corhK5+ajDsK8Y+8yjQ5ScihQ=;
        b=Qzfw7aCe6fpNYEB/5eirCY7k6Dv83VO5cpsEaKjNoTehg0JR3jaEDLine3sQypX3OZ
         DJ6ijREubJx+Udu3rKt2ARGvHso8IvXnGSbUxtVvAYWZ7MKj/DYePC/RsTlSfvxkxPsu
         83WFgdxpIgMtLyl8Cqyl0k5aI2qYO6pyR2I2U//rc8PPm5yK4yi78SQXqXtud0TE6v5n
         q0Ui0KAzNYaO9Nxfv8OCV1+16rZMZPvUYfQpqCSsnaxgH0AcsY/ZAnwBEI1Aj7TH0NIz
         bxqqCR/Vegf5yPtFyNo5m6Iy3Id7gMKVrInEMs/PpWc8fXrXF71iDo50kPNgDWNRkqFv
         FP1A==
X-Gm-Message-State: AGi0Pub6KZrCARDIYHhf3pXxHZSXMtBGIrUHI7ct1zYMfuHPUwq1RvJq
        HHRKLxtcVpjTsc8mxjnXpeI+N3x44I/2+gkQIfg=
X-Google-Smtp-Source: APiQypLGodTlsU/FAWNnj/SkZhv8GRJUUU4rOCqNo0xwHflyuX+RI+UJFU5cv3dzgb+x29ge1yIlVVY3hzaQxFf4PG8=
X-Received: by 2002:ad4:4c03:: with SMTP id bz3mr8359756qvb.224.1587493451343;
 Tue, 21 Apr 2020 11:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200420083046.GB28749@infradead.org> <C266KL0CLET8.Z2G09QJ83ZWK@maharaja>
In-Reply-To: <C266KL0CLET8.Z2G09QJ83ZWK@maharaja>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Apr 2020 11:24:00 -0700
Message-ID: <CAEf4BzYfEuiMsn_MWAFHRHYSMB0dFP10dgdKixXATD=65F6SqA@mail.gmail.com>
Subject: Re: [RFC] uapi: Convert stat.h #define flags to enums
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 20, 2020 at 9:39 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Christoph,
>
> On Sun Apr 19, 2020 at 6:30 PM PST, Christoph Hellwig wrote:
> > And that breaks every userspace program using ifdef to check if a
> > symbolic name has been defined.
>
> How about shadowing #define's? Like for `enum nfnetlink_groups` in
> include/uapi/linux/netfilter/nfnetlink.h .
>

FWIW, we did #define to enum conversion for big chunks of BPF UAPI
headers ([0]) and that greatly improved BPF user experience. A bunch
of other kernel headers are already using enums for constants. I think
converting more Linux headers to use enums for constants and capture
them as part of type information is a good step forward that should
further simplify writing all kinds of introspection and monitoring
tools.

  [0] https://patchwork.ozlabs.org/project/netdev/patch/20200303003233.3496043-2-andriin@fb.com/

> Thanks,
> Daniel
