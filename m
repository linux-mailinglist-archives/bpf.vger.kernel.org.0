Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06064A8B24
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 19:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiBCSES (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 13:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244530AbiBCSER (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 13:04:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739F5C061714;
        Thu,  3 Feb 2022 10:04:17 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i30so2868895pfk.8;
        Thu, 03 Feb 2022 10:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HV0xgY+A1CKwVGFVRLBbClyjgU0eAWxQoYGk3uDgk08=;
        b=RZUEsIC1A+j6wWueZqUonlzipWqWA1NClQtgZiPCslJwg7a7gLTdzxIrRbgRZ1qByT
         kx1Q3dwQiqlJrCay5zpiydVFi0k7WdAQgcZr1uAAUKSoWeyvHMM1HjXiBOAgmyjE3CTq
         PyNT1sPl1/f3AMNNevF6IhT+9Pk0RWnxMANQjV4p4y7AP/Zj3tz1YOE8AOIXjZKsxaFR
         /9mCA7NCKMt6J9UiN6B304hAxACQgW4ceo9JOeG67TeIkm/pzo50u3lbP0WOivGDpTiN
         DWPbK/Sc2j6RuEbI6wrA1Uj5LPzDtS1VqWY0hxbhRZGMrhiWhSeCFcjzb3falSw+kH7P
         ftgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HV0xgY+A1CKwVGFVRLBbClyjgU0eAWxQoYGk3uDgk08=;
        b=Fr706xOu6Aq4199F+SWzo63SEdUpfoMT/qDBWyu3uRIiMXwzpq3HQR7igHpxSgHyyz
         efxiXS9xExh/fTi3hfenFUSm4iCZ/1/g+kYXXi5WzHKUI+2n6u5gHVax6BO11N0S8r9e
         fG4idYt03XFUXH3FPMtSpBBn+G2QS1aBWlUnxFalL2em55UMaILhcrqz8MYJ8swUSo+R
         wrzh57Z8R4+nURriHN6eURdwHfVLXy/DwR+n/TawPcmUl/AyJ2tpXkGtw5zlt131I60p
         zbFZEDgfT7vYCGCTtFGJYoDfjSj15RuqseIjxF/l4Vo9A+tpc3yenX43X6YeAeUKgexQ
         gAdw==
X-Gm-Message-State: AOAM531HRffxeXBcJIYGiX+MU0Mad6QLaUXd1RxyCTynPMXLmrm64qY1
        /AZz6kZmSMlqUoDcxUib1AU=
X-Google-Smtp-Source: ABdhPJwITvv/1cD8c5tYUb4+FWBLkHxjmFTp/fYTUTBlGAI6luRAnsYRAPaca7moWqts00mR2bonUg==
X-Received: by 2002:a62:cd8f:: with SMTP id o137mr35259796pfg.64.1643911456966;
        Thu, 03 Feb 2022 10:04:16 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4d88])
        by smtp.gmail.com with ESMTPSA id a1sm37110669pgm.83.2022.02.03.10.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:04:16 -0800 (PST)
Date:   Thu, 3 Feb 2022 10:04:14 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 5/5] selftests/bpf: test for pinning for
 cgroup_view link
Message-ID: <20220203180414.blk6ou3ccmod2qck@ast-mbp.dhcp.thefacebook.com>
References: <20220201205534.1962784-1-haoluo@google.com>
 <20220201205534.1962784-6-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201205534.1962784-6-haoluo@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 01, 2022 at 12:55:34PM -0800, Hao Luo wrote:
> +
> +SEC("iter/cgroup_view")
> +int dump_cgroup_lat(struct bpf_iter__cgroup_view *ctx)
> +{
> +	struct seq_file *seq = ctx->meta->seq;
> +	struct cgroup *cgroup = ctx->cgroup;
> +	struct wait_lat *lat;
> +	u64 id;
> +
> +	BPF_SEQ_PRINTF(seq, "cgroup_id: %8lu\n", cgroup->kn->id);
> +	lat = bpf_map_lookup_elem(&cgroup_lat, &id);

Looks like "id = cgroup->kn->id" assignment is missing here?

Thanks a lot for this test. It explains the motivation well.

It seems that the patches 1-4 are there to automatically
supply cgroup pointer into bpf_iter__cgroup_view.

Since user space needs to track good part of cgroup dir opreations
can we task it with the job of patches 1-4 as well?
It can register notifier for cgroupfs operations and
do mkdir in bpffs similarly _and_ parametrize 'view' bpf program
with corresponding cgroup_id.
Ideally there is no new 'view' program and it's a subset of 'iter'
bpf program. They're already parametrizable.
When 'iter' is pinned the user space can tell it which object it should
iterate on. The 'view' will be an interator of one element and
argument to it can be cgroup_id.
When user space pins the same 'view' program in a newly created bpffs
directory it will parametrize it with a different cgroup_id.
At the end the same 'view' program will be pinned in multiple directories
with different cgroup_id arguments.
This patch 5 will look very much the same, but patches 1-4 will not be
necessary.
Of course there are races between cgroup create/destroy and bpffs
mkdir, prog pin operatiosn, but they will be there regardless.
The patch 1-4 approach is not race free either.
Will that work?
