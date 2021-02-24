Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6639324583
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 21:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBXU7f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 15:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhBXU7f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 15:59:35 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F841C061756
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 12:58:55 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id c131so3224231ybf.7
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 12:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1udcBUQ++/B/GUIMJqRMPLIt0Nik/LTQetK4DJqgM0=;
        b=YSMYd1VhpVm36zQvkwR8O60myGHaPZLbBGrQv9J26TYHQRmmv9nF78dPzft5cjyVOC
         hsSvMEhqzKmPkgsSZk5MwHsjZMBpClEs0oIoXb2XEAktW3/ftDwM+t56BxXeKJ6oSCQc
         oErOV2ayQuhphgYHVX0TXDqL2c0I32oJOYf5xmk9he8MLf5Ep4k8JkV/1MULMp55ISk4
         GvlWpeDiScKtt78rhLrGxuxA36F+Z7Z+Kk+Ci+pV+ax/LkWL/LxssGUPaVefpiPeNQ4P
         pKsQZSWTZ+nS4SOTXqGPe5wq9pnp2GgXAZrP/fSIAAVa9j2SrDpgBOofxryRScllQfWJ
         8XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1udcBUQ++/B/GUIMJqRMPLIt0Nik/LTQetK4DJqgM0=;
        b=C8siYmDiF3PTycTR8F0HrFshi/Do5pz9Bzht0DgBrT4dGuyurPcjLcGFQWxV/zdrgX
         ipQdixXh22U5nsT1FF8AuMO7iKX20jDqBRoaZiott1D4LT2JnzUNiaqYOS0G14iPB7lC
         yMlpJ+vLDGGjitP2fP+cib6voTUBX7vVFsJNASoHr2BypdPFq8WZZo4wmXmCGqUWcnaC
         NR9axGxYdrBGWCAs8P+dIqJn9oc2cG3AjuD1bVyXudifBNbLgGoDxfucQO2u6XHACE/E
         tGeC1Pnlhw59KmS3Yez/Cu5m8sI2+yKz32xX+KTEREfPk2AuGTrRuDClYHfNdwABJxh9
         n6rw==
X-Gm-Message-State: AOAM532+bslIh2A31n6uJXcAvmvwz3d2rXviHlRUMdBeb3LeFp2+nTtc
        HO/VzmhInYBnjgKanVqTkD+a+cuKC2D2U26/XyM=
X-Google-Smtp-Source: ABdhPJyU9IAOvka6e2Fz1F1rISdGMBzu5GwU4fGULzt0EHi+m9c9F5ml4kMF5sbGUnY0oeyx+/KfHmki5g6V2B/M12Q=
X-Received: by 2002:a25:cc13:: with SMTP id l19mr21077306ybf.260.1614200334573;
 Wed, 24 Feb 2021 12:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20210223231459.99664-1-iii@linux.ibm.com> <20210223231459.99664-8-iii@linux.ibm.com>
In-Reply-To: <20210223231459.99664-8-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Feb 2021 12:58:43 -0800
Message-ID: <CAEf4BzY+dUO8SLvA9P56qQ-v4VnLjoa0YPYUE=b2dDe-3xOQGw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 7/8] selftests/bpf: Add BTF_KIND_FLOAT to the
 existing deduplication tests
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 23, 2021 at 3:15 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Check that floats don't interfere with struct deduplication, that they
> are not merged with another kinds and that floats of different sizes are
> not merged with each other.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Thanks! LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/prog_tests/btf.c | 43 ++++++++++++++------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>

[...]
