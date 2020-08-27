Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CDD253B86
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 03:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgH0BiP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 21:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgH0BiO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 21:38:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F7CC061383
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 18:38:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c8so2024702lfh.9
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcZaZT5thwhJ11Sw+P5MksLekBOktbPk7Gm1gWNLeIg=;
        b=Dnw0CNEgWHRjRY6mVfKDmenVclOHmH5gb8vsyRKn1HlquwSK9oiMqP5+l+4bHIUmEN
         ImBA+i6GyDM1F0AHWS7CRMjJ7MbjGg3iMTfGDiQs2TxZFuTaeWydDDDSQzsB1j+J+HS2
         hF5BeBXmPWTkNM6rGsgz2JkcZoHkS34A8KeAOj/TRNVUC4cD4QDaQFLc1HCe10CG1PYe
         Q0U9h5FTzR8smu+Ap/LU1p61Im/PL+P7y/rCDRvwMmMg06sLJPyajSl/UF/RMG3Dnw47
         6BcaQUsr7h/UOccf+voQ08xND5Y4s1o9fVhqmMAio85FbwxE4hrSZAgkBPmBsn1k0C6I
         e/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcZaZT5thwhJ11Sw+P5MksLekBOktbPk7Gm1gWNLeIg=;
        b=nRQsh54LE5rls4jPZrjXuoeu+kb5id0QjqS6bxz3f/jyLsIlajl0w6iJVVJbrYHcU6
         oskIWbQCBWl+oBdijpxeC2iMd6bwD0ala86UdEDWn4U79F5PzDi4cY/jX+IZDhT65985
         dhQIQmAosBO6DOcPMYIdYLSdCjJew1lwtN9tOi1RmaLfst+VEIKZTh/a2uO/BU3dvIvH
         dx3kOTST5D7vqV7jauBioKQlTa0ty5aXo4WZOJDBENmKB+/sJVUTJ0PXfI+O3UvL1azO
         W4ezfRbv0UG1Tu+ltKL9oLHXxFrGpbEX64n2IjCLVWtq/96jeZDUK2ZKD527weirjfHW
         hsbw==
X-Gm-Message-State: AOAM533cvZp8cKOMBxG1sglj/8s//Fu3TSVIaQbPmg8qp8Va2krEk4Kf
        SQ+U/Pav6m9nej5Yme+TNO7qCihU3nRPgAjG76H5BA==
X-Google-Smtp-Source: ABdhPJxRcjc/Gqp/xT0urxhuNv5VqgxhHlf/nPvUR2crUR0WvM1oYHdUzyehd4aChT2XgBrBktIsBGkJHiIB0EJwAh4=
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr3245912lfp.124.1598492292040;
 Wed, 26 Aug 2020 18:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-8-guro@fb.com>
In-Reply-To: <20200821150134.2581465-8-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Aug 2020 18:38:01 -0700
Message-ID: <CALvZod62e=y1-HJJrC7dQQiarRR9o5t+4y_NtZT4B7aGhF46WQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/30] bpf: refine memcg-based memory
 accounting for devmap maps
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

On Fri, Aug 21, 2020 at 8:18 AM Roman Gushchin <guro@fb.com> wrote:
>
> Include map metadata and the node size (struct bpf_dtab_netdev) on
> element update into the accounting.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
