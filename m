Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A036A008A
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 02:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjBWBXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 20:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjBWBXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 20:23:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D565220057;
        Wed, 22 Feb 2023 17:22:57 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e5so12115836plg.8;
        Wed, 22 Feb 2023 17:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8JlHnEeXi6Ume/0LdrQ/Wv4xR86SmiNzZL4WaoGYxI=;
        b=jBFbnzW7xxeQ02Nn1kicQZiPHvOTRESreCrOnCUHxOap4EINoKmuv2fpdpUpZJkvMZ
         I18kqjayiDk2HybGVTLc89pQv5IAbL/Jj7ZTwCSOKFa3zolNkeWLV6NaqsDsH6FsTrEr
         uwSz/f64lMtjpjKIvK85XyFd+XSLI21mwFZd/bkDMqs+ZZpn0OGPaK8/O6H+my0RGouc
         F4PqwPgghTEBAG9VWjCWqLKv6rc9t56HzzjecLF2OS3wgSgetSwEBAmIZrN2mY5f6pvt
         YUw4v/hQA24d2GwnTtAvh/X/IRgb8aoOYPmKne5Ij0TMi4Ysi7FAa8vWI+8MS4owiQnH
         BNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8JlHnEeXi6Ume/0LdrQ/Wv4xR86SmiNzZL4WaoGYxI=;
        b=1vRihr3rUKVp27WtegchYmuEoMUZ6Y6LjlVAeg8d3CRfkps55E952BVdGcas5lhEAZ
         zlIqiRHvtVyRodWyg8TZKvhpH+KwgZaO+NFwJHWXDg5k1D7jaNBvTqK3txhQ9DaA4EKj
         Ps3OlwirSBI6ElnKe+W06548oLOwQYDDc3KZ65fDmiIOqQ+ZPk6eccHqP9eNz0/2oiWX
         u1Z+QFI2NL6c6BCU8qbeP+LkROd2Z7wVSAFUc/SpTmwl8nvHunHtN4ixABxYioFqVjqN
         H40vX66RLfHNuBdiumg44p0MFE92HCwiK03tBSrji48/eLcFA/pPhdNqpgdSzXxJBNNU
         uH5A==
X-Gm-Message-State: AO0yUKUGuA0XJRnQdHEgNRxDj1BtIJavEyQ+qH8lRGPpk+x6UbpJzE5B
        lbobbnYt+EVnqkRcza5BDrc=
X-Google-Smtp-Source: AK7set8in1ZoSyRyaJNEnYf4iObtvL5YKbdNJ1Kol3k6xu9FgnbnNUwO+2zBhHO1PZl1PLKvXuxtkg==
X-Received: by 2002:a17:902:ea07:b0:19a:9580:74c with SMTP id s7-20020a170902ea0700b0019a9580074cmr10568768plg.7.1677115376917;
        Wed, 22 Feb 2023 17:22:56 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:1bf3])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709027c8100b0019cbb055a95sm277694pll.94.2023.02.22.17.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 17:22:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 22 Feb 2023 15:22:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_cgroup_from_id() kfunc
Message-ID: <Y/a/7ftfWVYpDTO0@slm.duckdns.org>
References: <Y/VA+jP0mB5cMZEz@slm.duckdns.org>
 <CAADnVQL0Zf3Dq=6wCMmj+R9bz1B1J4b=mUkvkObKfPQprUjyag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL0Zf3Dq=6wCMmj+R9bz1B1J4b=mUkvkObKfPQprUjyag@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 01:20:19PM -0800, Alexei Starovoitov wrote:
> On Tue, Feb 21, 2023 at 2:09 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > cgroup ID is an userspace-visible 64bit value uniquely identifying a given
> > cgroup. As the IDs are used widely, it's useful to be able to look up the
> > matching cgroups. Add bpf_cgroup_from_id().
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  Documentation/bpf/kfuncs.rst                  | 10 +++--
> >  kernel/bpf/helpers.c                          | 18 ++++++++
> >  .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
> >  .../selftests/bpf/progs/cgrp_kfunc_common.h   |  1 +
> >  .../selftests/bpf/progs/cgrp_kfunc_success.c  | 42 +++++++++++++++++++
> >  5 files changed, 69 insertions(+), 3 deletions(-)
> 
> Looks great, but could you please split it into two patches:
> One for helpers.c and kfuncs.rst and another for selftests
> with [PATCH bpf-next] selftests/bpf: subject ?
> Doesn't matter much in this case, but it might ease backporting
> and easier to track patches grouped by subj.

Will do.

Thanks.

-- 
tejun
