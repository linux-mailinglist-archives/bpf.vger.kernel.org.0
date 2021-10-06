Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABEC4239E1
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 10:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbhJFInj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 04:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231415AbhJFInj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 04:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633509707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=kCM5Cd96ErOWY02ACkCheEUVdabLFYsQ9bA/skAUy2g=;
        b=ctwG8OJAc1AiXva9wVGorpei0pTVlrhej09jNMb06vreb4DrmQajlizmjpAdyZ8FJHskaM
        c2bD2yeGFU9sLFvC6te0YPMJJrZ611ZSKD2Hk1dNPqSE5t8eEmiko0kOUIrusRtxgffCCZ
        0g/7GU2DitmMVyypKx1NdnqMwl9b8DE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-fNctDKR-MYqwnUwSek94YQ-1; Wed, 06 Oct 2021 04:41:46 -0400
X-MC-Unique: fNctDKR-MYqwnUwSek94YQ-1
Received: by mail-wr1-f69.google.com with SMTP id s18-20020adfbc12000000b00160b2d4d5ebso1427057wrg.7
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 01:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kCM5Cd96ErOWY02ACkCheEUVdabLFYsQ9bA/skAUy2g=;
        b=7AtpMF0SRuzvJzUsoxC+OPPQ23pbz8tq3sTRSdPYqCzM5PgbWuFoqVETtUDA/NiB41
         tmW7FW5yzF3Uaqy6e06H4tYOJUp2DjSGfjPbfJ4hjjwCgN1s3sPLzzsxUly1xFZfEATq
         PP3CqQeBbH+/Et5wDm/jZGw6rnbguyNV4MB5Bh96zv5ovuLFJl4PDUmAYD/fnP7Zi7JU
         ACDRNxP0wD+7fpNXQ6X5fS41QxtHEU3PEkrcQLqDg8djcUZtXiVfF/ZlzW9Z9W54ou/i
         YdJAgd0gyWSQCZng5ff/pyeQOTG+/MaO43+qefPoMVFa1GH/yIUA5s3ZHeW/4SZVM8d8
         BAIQ==
X-Gm-Message-State: AOAM531V2eVpDhiwC4WPeCQMV4sAsp3WmSC1nB1pGtXgvdVzCjPsKEHA
        sfOfbWJL64jjA2szLGUbBEJ+iFd2XXTwR+/JZsNoDHr/OPBLmCAp7eLFkyiddI9Rp25nDi+ORQF
        mfu/JJ5YT1Rc9
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr26820115wrz.29.1633509704955;
        Wed, 06 Oct 2021 01:41:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJazLLM1necO1ye/IiTmHNlGHLpHbFM5oSXAMFwHCqJbSbwa09gbfnF4TukdWCIjeWX0UvvQ==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr26820099wrz.29.1633509704757;
        Wed, 06 Oct 2021 01:41:44 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d3sm23167544wrb.36.2021.10.06.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:41:43 -0700 (PDT)
Date:   Wed, 6 Oct 2021 10:41:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC] store function address in BTF
Message-ID: <YV1hRboJopUBLm3H@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
I'm hitting performance issue and soft lock ups with the new version
of the patchset and the reason seems to be kallsyms lookup that we
need to do for each btf id we want to attach

I tried to change kallsyms_lookup_name linear search into rbtree search,
but it has its own pitfalls like duplicate function names and it still
seems not to be fast enough when you want to attach like 30k functions

so I wonder we could 'fix this' by storing function address in BTF,
which would cut kallsyms lookup completely, because it'd be done in
compile time

my first thought was to add extra BTF section for that, after discussion
with Arnaldo perhaps we could be able to store extra 8 bytes after
BTF_KIND_FUNC record, using one of the 'unused' bits in btf_type to
indicate that? or new BTF_KIND_FUNC2 type?

thoughts?

thanks,
jirka

