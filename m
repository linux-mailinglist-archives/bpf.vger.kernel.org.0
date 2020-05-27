Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924601E4C29
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbgE0Rkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 13:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbgE0Rkk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 13:40:40 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BDAC03E97D
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:40:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x22so222251qkj.6
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hcV5y/448NucPuCFDD5s80WvaLV/+L6Y6aWTXNhPJ6M=;
        b=b/bZTy4vE6/uduslr+Kb3ocuKQlHq2Is7+CEKiiImtdISm09h2fkkq3jav+Epoghrh
         CyJhRCA46mxHpds7YnkQN1lDiSMhiLqgtP3Emm9kOmNy7/+mFmc9NqgRgKQytUf7cnhZ
         UlrHefwWqeVWjBylxOyItGC1PkIvI1bPCNYRq37R+AymTtgUtxwVjPGiZbNnS6dWFM+V
         Zxs2bkr/E6NvLQGVKwukbRAETdxS0Sb5xLd5+buVJ4S9JEL44/2ZkIEn3JmNYlAbqJhk
         Wbyr9g0z5kFhtxLAin1PFmuFN11TZx19x9PsvS5VlJjZf1WZFcT05y5Vs/VzeB00lSty
         t1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hcV5y/448NucPuCFDD5s80WvaLV/+L6Y6aWTXNhPJ6M=;
        b=I0r0STHRDOPm7mXDG+qBDCEVFbdM73cOcfX+h7Ueioblm1AcymvV2z7yfRq66+49zc
         hsTwr5oHMT3dgx5dOCbuHocNjmh71W42gwfeAwk07GHNRwIH8pCVOejYrZTTDXizO+F8
         PSET8WmhsVo/dw/O78WABDPOZPRbOHVTKKqRpfp9pmThPS05hUD+BlmAsjsyjbV5JaXr
         1Sl7Korv9hc1U4XQVYOFEnExz7JfkSd3STsN4sMID/RPGFDi+xmxChwfM3nyk4H3HqF2
         YRioUd/FQZ5qAfgeDwBxXx4vqA5TMGIXAV11WNIW1FsTPCGAyXuKsYoX/ednll/bpsPL
         Nkzg==
X-Gm-Message-State: AOAM530xuAHDmirV+YDOYsM49CpbV2OSb8/kiVJIgkh7YYQ/J0Mw+cmJ
        rAR/FvIri85wQU8/4nEqZxDDTjM=
X-Google-Smtp-Source: ABdhPJwBJ98QhfL2t1UhVy+T83POjlR8Ywppmx99tCxRxf3pJkEqt367bijcpIXOQwtoKw/hHQzoBOA=
X-Received: by 2002:a0c:f445:: with SMTP id h5mr24198190qvm.151.1590601238703;
 Wed, 27 May 2020 10:40:38 -0700 (PDT)
Date:   Wed, 27 May 2020 10:40:36 -0700
In-Reply-To: <20200527170840.1768178-4-jakub@cloudflare.com>
Message-Id: <20200527174036.GF49942@google.com>
Mime-Version: 1.0
References: <20200527170840.1768178-1-jakub@cloudflare.com> <20200527170840.1768178-4-jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next 3/8] net: Introduce netns_bpf for BPF programs
 attached to netns
From:   sdf@google.com
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/27, Jakub Sitnicki wrote:
> In order to:

>   (1) attach more than one BPF program type to netns, or
>   (2) support attaching BPF programs to netns with bpf_link, or
>   (3) support multi-prog attach points for netns

> we will need to keep more state per netns than a single pointer like we
> have now for BPF flow dissector program.

> Prepare for the above by extracting netns_bpf that is part of struct net,
> for storing all state related to BPF programs attached to netns.

> Turn flow dissector callbacks for querying/attaching/detaching a program
> into generic ones that operate on netns_bpf. Next patch will move the
> generic callbacks into their own module.

> This is similar to how it is organized for cgroup with cgroup_bpf.

> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>   include/linux/bpf-netns.h   | 56 ++++++++++++++++++++++
>   include/linux/skbuff.h      | 26 ----------
>   include/net/net_namespace.h |  4 +-
>   include/net/netns/bpf.h     | 17 +++++++
>   kernel/bpf/syscall.c        |  7 +--
>   net/core/flow_dissector.c   | 96 ++++++++++++++++++++++++-------------
>   6 files changed, 143 insertions(+), 63 deletions(-)
>   create mode 100644 include/linux/bpf-netns.h
>   create mode 100644 include/net/netns/bpf.h

> diff --git a/include/linux/bpf-netns.h b/include/linux/bpf-netns.h
> new file mode 100644
> index 000000000000..f3aec3d79824
> --- /dev/null
> +++ b/include/linux/bpf-netns.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _BPF_NETNS_H
> +#define _BPF_NETNS_H
> +
> +#include <linux/mutex.h>
> +#include <uapi/linux/bpf.h>
> +
> +enum netns_bpf_attach_type {
> +	NETNS_BPF_INVALID = -1,
> +	NETNS_BPF_FLOW_DISSECTOR = 0,
> +	MAX_NETNS_BPF_ATTACH_TYPE
> +};
> +
> +static inline enum netns_bpf_attach_type
> +to_netns_bpf_attach_type(enum bpf_attach_type attach_type)
> +{
> +	switch (attach_type) {
> +	case BPF_FLOW_DISSECTOR:
> +		return NETNS_BPF_FLOW_DISSECTOR;
> +	default:
> +		return NETNS_BPF_INVALID;
> +	}
> +}
> +
> +/* Protects updates to netns_bpf */
> +extern struct mutex netns_bpf_mutex;
I wonder whether it's a good time to make this mutex per-netns, WDYT?

The only problem I see is that it might complicate the global
mode of flow dissector where we go over every ns to make sure no
progs are attached. That will be racy with per-ns mutex unless
we do something about it...
