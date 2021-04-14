Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0471935F4E2
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348115AbhDNNdJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 09:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348130AbhDNNdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 09:33:08 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24538C061574
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 06:32:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e14so5783662ils.12
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rJkm+pt7IAIh3meE9DcpUBzUhbdXEUDSKBscpDbcvQ=;
        b=SdJvtJWFpdtL24ZNlj+RoMxAj5tA6pT+FNmGcPLgHU0k94dxjF7yuNFFoBBo1LY4r6
         IhBsY1KplvIJlpe302RTUiVZPvoyVU5AO0u0dNEp6+jD+i7N4WnItL/yk/LlBf0rlXbr
         86GH9pU9ZIpe7lbkOa6WmN2CohV0FPVA/gwB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rJkm+pt7IAIh3meE9DcpUBzUhbdXEUDSKBscpDbcvQ=;
        b=sOxWqmwKLM9BbARyBAIpyLOde1JucswUs4daWEajlFZli8NRjhdpTuQfz/jGM6fw+r
         3AXjucmWhr0MK+A7K10y1ZOjUY9ER4kPN5lCW0hSMdxAyIG+mtjpiPWg2ySoVjRcBb7O
         nyrw6RYkHuZtLNqL5uOQx3uzQ9b2floj7WOuHLWDpXyZwVFnleDdP4fKEtsyVh0iKChq
         r5Mu7XstcMdCR+zkQg/al2QhYgXJkSBCFLZaWhhYP5PY6VYJ4AAW/7xhifkQFvAWeH4W
         U043F2rFNjghDoP8ESA49B/ysQW/R+UZZaitk/XETERhP3Tr8txxiHQkcIHJ2xw5AbAH
         0z2A==
X-Gm-Message-State: AOAM531XNi6VSizBIj1h34MGfvkaJgyCfyO7aPB79cjJgc1HjS5Q30kQ
        cn8SiFjSFrgBOr0n02GF3jwTGD0X4e++mM0/6CxEOg==
X-Google-Smtp-Source: ABdhPJxpQBuy43S79HHF6y0YaWWhOf7xOlTljrKXOqrhq+xJ7yWxHZ2nsrlYqB99sBD3phaEhBb5ng2ySZoZ/DB+8qE=
X-Received: by 2002:a92:ce90:: with SMTP id r16mr13484481ilo.220.1618407154503;
 Wed, 14 Apr 2021 06:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-4-revest@chromium.org> <202104130447.2WLAvV47-lkp@intel.com>
In-Reply-To: <202104130447.2WLAvV47-lkp@intel.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 14 Apr 2021 15:32:23 +0200
Message-ID: <CABRcYmLe-PO5nKKXjiyBhzAtx2A80qBRfy362dFzt9PA5Ndi9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
To:     kernel test robot <lkp@intel.com>
Cc:     bpf <bpf@vger.kernel.org>, kbuild-all@lists.01.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 10:32 PM kernel test robot <lkp@intel.com> wrote:
>    m68k-linux-ld: kernel/bpf/verifier.o: in function `check_helper_call.isra.0':
> >> verifier.c:(.text+0xf79e): undefined reference to `bpf_printf_prepare'
>    m68k-linux-ld: kernel/bpf/helpers.o: in function `bpf_base_func_proto':
> >> helpers.c:(.text+0xd82): undefined reference to `bpf_snprintf_proto'

I'll move the implementation of bpf_printf_prepare/bpf_printf_cleanup
and bpf_snprintf to kernel/bpf/helpers.c so that they all get built on
kernels with CONFIG_BPF_SYSCALL but not CONFIG_BPF_EVENTS.
