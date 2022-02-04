Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B861B4AA01F
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiBDTck (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 14:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiBDTcj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 14:32:39 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D738EC06173E;
        Fri,  4 Feb 2022 11:32:39 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i30so5927309pfk.8;
        Fri, 04 Feb 2022 11:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUlpEUUncbrROhxIWvkQkKCYCD/G+bbQIEklhMA/Ybg=;
        b=AFCgQQDYWiYy7shg0qNU0hwjRmJsiEEMFX/s6Te/hLHILPDPqz1RzSfdvA/V7Cf3Cj
         Al8s7rjX3t7W2M5UjjYir197PLToJI/B6GbxOFm1JJByVtCBKC+x0SIJoPVkdZgfJ7MR
         Gn+uUe0OpYlqOiVJqLwwmdTlWdSZxmqembg3p1T5vl6dWLEjVPYF17eBsAmjKZ+8JvcF
         g57E3lYiSKP6smzlDGrliHn1jSGIzpMDwf7XnRC1bJLqFWWYGChfsf6cdXkSW5slO3kB
         1NKb96EuFVGUzv1hfzLXsvzT4ZB5df8p71f+v+Qh3uqyib+M0igPVfKJRHyPknm+XNl6
         WDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUlpEUUncbrROhxIWvkQkKCYCD/G+bbQIEklhMA/Ybg=;
        b=Z2gccGuP1MysSpKElS/xMhzVl6pjohn3jFHWlxz5kay2f6HLbkYwZDL7tHRRPvDQa4
         f1Mh6dN9pMmOz+Sqtk7EkTk8xHRwoDumS/eu2zCJhI4SyTmsOabzB8wWR8oam3dQ0uxf
         dS0VLBjBllDsi5IclVfUOdbCNLwc4p1aCOtoZFCsMyStTMcmjhPHjrL/yC/Swo+nUMrv
         E2SwcY4iy4XKBXvZxv/sT5e/P5tKEy0nqEyTfzzRfeKNTV/ug0dBn8Gw+ImT4n4/dlYX
         ++TUxRTUIkSI7X1aWdV38BSIgZ4T/NOORX8MVjMV0BEwN6X2qTpGnlCLLQl1y29Sc5aM
         dDRw==
X-Gm-Message-State: AOAM533LIxcBa2Po89r4Olo70kH7jmBUrfzddZafMyYnUhX6+3JRIbEE
        BzODTMxcfVYO486kvg7my1dC9WeCqYhScXpIXE28pycdREQ=
X-Google-Smtp-Source: ABdhPJzpDKg5ZR5ERsXsmoD7khT/sBcvAHEWJkEw1MZOVY6e/qEaKvyDpjfoOnb/NSP08ZW5LS1/moI/GDbk0UUOGH0=
X-Received: by 2002:a65:6182:: with SMTP id c2mr432225pgv.95.1644003159120;
 Fri, 04 Feb 2022 11:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20220204005519.60361-1-mcroce@linux.microsoft.com> <20220204005519.60361-2-mcroce@linux.microsoft.com>
In-Reply-To: <20220204005519.60361-2-mcroce@linux.microsoft.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 4 Feb 2022 11:32:28 -0800
Message-ID: <CAADnVQJy_ksv9hYDhjGvxzMQipa7Fw4DGrAajhSLZKZcPNBf8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: limit bpf_core_types_are_compat() recursion
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 3, 2022 at 4:55 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> +
> +               for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
> +                       if (level <= 1)
> +                               return -EINVAL;

<= 1 is not correct, since it makes
MAX_TYPES_ARE_COMPAT_DEPTH 2
misleading.
With <= 1 the recursion depth is just 1.
So I've changed to to <=0 to make the actual depth of 2.
