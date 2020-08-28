Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29651255EF1
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 18:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgH1Qok (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgH1Qod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 12:44:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C83C06121B
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 09:44:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so2033373ljj.4
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzpPi8yXbLMuzZSSY1LpudtamO507TJJwiMVPeY80DE=;
        b=hHayFTVAP6eh4eo+w96Oa1ZAIXRFKK+O8XvGFl7M7dsA/Sfgl+TIdTnwip76YxquFb
         MUgTLABcXm228lJFA+6PfABognH5JhCINUZ4/AV1oFyEVllbBqx6bZUMFpPQMbMG854O
         uBbhuWVF8lM4SKRAu8D54grAOXevhjo09f77L+QDqC+9f4UGc/pT8JdJMAcS6b9Uft6i
         UBi00xHyjclUtNjsHg83xovHNctWTuceI4QpQKcnCuX0neMqc7kVyRpy99rQ1W8kw5kC
         YrpihI9fczOPvfkaWFuOpvsw1esRu4o8kmdQSn/QJo1TOO9BYzegeWQ5dDCpmFHqFrBH
         478w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzpPi8yXbLMuzZSSY1LpudtamO507TJJwiMVPeY80DE=;
        b=Kcj3RWzesV9ZfXMQdmP4Em69ckkc+4HXxWus/goSIYvjbWKCYi6Pye27+3Pe40SIKP
         uIpdatj+X5VFYtbONEuDL3mHU9t8qlEb/4f6zclpPCMTFuf0Hh801KoE/oVaoVak7ldd
         HpAW7TLnbAiD24hFt7fPwQShbOtq13eXNYc2sW4At7VuHpzXMJf9s52HwbkUAvfLuTB9
         3vo9UBs554WFfdRkdDD2A52Axu8kuIclajAgyKFRPDdqoF08i6KCpfxVe3r8r3Am+2lP
         z/BPOB/+skhDarg95CL55ZHD7KpsaEPs6f0OtYHLviFJT/vwI22sOl1uTQmU/Wm/ekgX
         7cNQ==
X-Gm-Message-State: AOAM530PErM3ra+Vvn7fvxtcWu1B6f4T3PWLEKdR93Sn5lQE9zJ2mK9b
        o3tjAWm5/HeLvf7tGYlkFEuKDK7wpSarrboqNPvKDDyZpjk=
X-Google-Smtp-Source: ABdhPJzWm18EUoriLV8GpLXZeBfpnJJ0335T25V0TWtCl4zXTizNjuHaws4CrJw0LNy//Kma1xGNubrLqXxkoP4jWBk=
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr1334390ljj.332.1598633070579;
 Fri, 28 Aug 2020 09:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-9-guro@fb.com>
In-Reply-To: <20200821150134.2581465-9-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 28 Aug 2020 09:44:19 -0700
Message-ID: <CALvZod75xBLmf6FigcdNsruyWjMhZ3eaZWggWYuzS5jwFVgW6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 08/30] bpf: refine memcg-based memory
 accounting for hashtab maps
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

On Fri, Aug 21, 2020 at 8:23 AM Roman Gushchin <guro@fb.com> wrote:
>
> Include percpu objects and the size of map metadata into the
> accounting.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
