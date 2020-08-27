Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAFE253B5B
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 03:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgH0B0M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 21:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgH0B0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 21:26:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E836C0617A9
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 18:26:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t6so4531155ljk.9
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 18:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwQRmtSR03e8Z95YTtgCWBM4ls338szcbW/y+WRctMo=;
        b=PM5UARjGZl7it+68nTblaLTBd77X447PU2c/xp6hmTWdeu4ce4iJZbahk4s2Q5PFaJ
         +v+KyatAlGog4EeZ3cfesfi2mxphBlqnUJ5TOaTqtLfNPbK/tsYe51dE9r+vh8dltGPj
         VBNJl+/9uuOQawkQjvHhrIxa1q93amF+R24gTM/DDjJv7KT63B/rNovbI+fiLtTOY9og
         QlilqKXxN+DnacwnLR1hZm74Zn6LtMNCX+hk7SILdthH7AofhPk49lpUCb8NTyRlUKar
         UlBRatC9I2jMr4qpkzT8ZWALAvc+20hsVv33d1S0hF0nLPPEfOB3+C9Yo+1u1vQOn4Ui
         20DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwQRmtSR03e8Z95YTtgCWBM4ls338szcbW/y+WRctMo=;
        b=ONc6yaozUGmXrf2KdYvoBMZ0lXI9/ZQOHeGaP6XXrJunu7AvpoSUNdJH5iy76JGRYB
         sz5S6Fast4Bk7Ti/xnB0ZK15KaDLJUIf2BvYyPUyRh5AjOqTjCpMS7kjgVuPCWxu6QHI
         icjv1hwVqvKC8vd0C183ywL67WeYgU+LC2YBxZYpbjgdtWch2iNpQP1cHnG7Bd1oTZP1
         cP8VzcDozLt223lpJuKG0xqsj8JVHlEiCDhv5z+Yn+DlIo3DXWGwbA7cZug0G2jBJVou
         hjPLpGnHfVl64kfei6a42aQ6SjCJUgNeGn631WiH/yxOfKft04hFWmzWTukaUwWvu2j3
         p+6g==
X-Gm-Message-State: AOAM530o61FNAXXphm03QAwsn76tTmOWSX4JtgUQ7Q8oGGnULy3a843u
        EF+Rw4518sPuMizuVif6JOU2XFZEqgDrX9lg4n9HBw==
X-Google-Smtp-Source: ABdhPJzfxeyQIyjqzngf0Ic3JmYBl8qWIcdHApqyuYYTCcRsQk5Fv6y+bLFRZIGKwYL6aolr76njLkTX27P4q7r9sUc=
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr7668037ljf.58.1598491569469;
 Wed, 26 Aug 2020 18:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-7-guro@fb.com>
In-Reply-To: <20200821150134.2581465-7-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Aug 2020 18:25:58 -0700
Message-ID: <CALvZod49nAYx5Uh1kSkTyZz98xJt9pgaLu0syZxfRb9bfyM1+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/30] bpf: memcg-based memory accounting for
 cgroup storage maps
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 8:17 AM Roman Gushchin <guro@fb.com> wrote:
>
> Account memory used by cgroup storage maps including the percpu memory
> for the percpu flavor of cgroup storage and map metadata.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
