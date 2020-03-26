Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC86193567
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 02:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCZBwC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 21:52:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46906 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbgCZBwC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 21:52:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id g7so4019193qtj.13;
        Wed, 25 Mar 2020 18:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y38zEgb3EH5u0ISLbX3L46cnC2XWupaDcY08yZB2pNc=;
        b=lAaBD/0C9KD3FC5rERps9ALxqWaPr3p9p6GWkio2Ph34zVah9EUivfohLcXVxDIW8k
         qC+DhDMxP3eYiHC3ugZ73vGAXcfnXs8XEfGvdVt5oCt/W+IjZ2NojiGk2NpIEJxtx7vO
         c2scVpO98jYO/AK5np6/+QaBBAjSUo4Nlh+YmT5cLqx8fj26cwfUYLio9/ISH934psZ4
         yzwIsXy1jFnnSBxKinBfISl8eBo4mmCCyqqkUtjYK8jf3KXWaAB407m9+iir7wpMrLpk
         btU6fM5hJhUB4OfnvUiaFm0XvIxOL58V79S2zlELbiUwFhK350pKRqYCeUoYbhaL34wk
         d9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y38zEgb3EH5u0ISLbX3L46cnC2XWupaDcY08yZB2pNc=;
        b=KpWulbrPCuxjlkGmccRjLTd+Pvggk0WXt909ZhZPtkFgcJv58qRm9AlquzSzAXsTaw
         j5q5B6wNRu9XUrO1mi0Zv3Ewr7ydw4GZSCJ6P2YTe/JnF/nn9JyWtXppd/bzOyaN4yf4
         4cXa6dWXU+r3k1gVGfqkzAKR50C1rb8laNWCDbJX3lOyIyUrPbVmAhtRZdtVEkWhzqxR
         izYejf7K0s2VdTUBhvy4TOozWTs7EWL6oLp8NBPXWNb0M9x8yBeDku6sV0Cms86HtsSO
         R2TNX6MDihJvFC09E4+FI4biGsyzsSOO4cjHdp4/eKtIeo3tEw2LqxCmMj3r8U0s8yWK
         HEeQ==
X-Gm-Message-State: ANhLgQ2ypscl2upjjGPVO/NtnaxURug/R2vHdblqiPy/6TtZJbHkIHO8
        lKcMaw5xOquX11nvR2waYZa6+Db0Jxr6STXWZM4=
X-Google-Smtp-Source: ADFU+vsEuvmfB/mTYFYnlUUT9EbTD50gewArOBTrfX+z1pFq5CwoE9ICI5sfKWceBFPTzgpb4mUU21kl1UL26iw54P8=
X-Received: by 2002:ac8:1865:: with SMTP id n34mr5687310qtk.93.1585187521038;
 Wed, 25 Mar 2020 18:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200325152629.6904-1-kpsingh@chromium.org> <20200325152629.6904-2-kpsingh@chromium.org>
In-Reply-To: <20200325152629.6904-2-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Mar 2020 18:51:50 -0700
Message-ID: <CAEf4BzYomSccqbO2AGbejQV2R2z0jz5GhEFZxuf7SGwtju+e8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/8] bpf: Introduce BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 25, 2020 at 8:27 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Introduce types and configs for bpf programs that can be attached to
> LSM hooks. The programs can be enabled by the config option
> CONFIG_BPF_LSM.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

Looks good to me, so please add by ack, but I think it would be easier
to review if this was combined with patch #4, which adds verifier
support and kernel/bpf/syscall.c support. On its own this patch just
adds random unused stuff.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  MAINTAINERS                    |  1 +
>  include/linux/bpf.h            |  3 +++
>  include/linux/bpf_types.h      |  4 ++++
>  include/uapi/linux/bpf.h       |  2 ++
>  init/Kconfig                   | 12 ++++++++++++
>  kernel/bpf/Makefile            |  1 +
>  kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
>  kernel/trace/bpf_trace.c       | 12 ++++++------
>  tools/include/uapi/linux/bpf.h |  2 ++
>  tools/lib/bpf/libbpf_probes.c  |  1 +
>  10 files changed, 49 insertions(+), 6 deletions(-)
>  create mode 100644 kernel/bpf/bpf_lsm.c
>

[...]
