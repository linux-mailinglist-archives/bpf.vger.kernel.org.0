Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902F26880E5
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 16:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjBBPBn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 10:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjBBPBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 10:01:41 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09B82BEE7
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 07:01:39 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id pj1so1076668qkn.3
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 07:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oLBuC23YlkzNJJ9bFUSG7GcHohwhM4jWe1P5ffpoHfI=;
        b=BuaU+P4J6x9okg5ikzm1q16mHqfr0E1jhjk539x1XmDXNqZldJwprxkkVo3RPAlvuX
         wzApobl8hq1rbY7drkgHklzRhrZqasmN2kcest52sAMqleU9oHAikSSvd06y6HWwnINr
         Zkxb4F6c1twkA2MfTSgND/Pd8877mn9KK7nc9EzvGyhn+zalgI8ZNz//L1PGMfh8vfhJ
         L10W4c3BIPXAJrGHgj6KwZdVOcp0hBjfAttnfSwdjmuG76Iwk1F4+XQZf1W1WUaXJMYs
         7KSeP9xm9/tT6GKBZ11IVwJDJOxUc4dzWF5ZqOa44c3ACCWDHrQZoHDQp4iu5E0hAOVP
         qyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLBuC23YlkzNJJ9bFUSG7GcHohwhM4jWe1P5ffpoHfI=;
        b=zzhnEyMsUtA1NNgewmFYB8P+wsjXw1pyNwsjDdQIxUQXSudVm1vIqy3jGbeu4lQ+RY
         j3EKJwmTnGsadrYyuJPllJv+1QDbJf7+MThpXqqBDDwEmCC/w3KRXhHr7qf2cjW387J9
         U6qggwO2m/v7EFGj3XrSmgxNwiflIiHB4GLl1J7NeSG84G6OSCGizNBcFZ2hp9ISpzFD
         qpn9CQGAG7cQH/w3eSdOmqZI0LkHiYBO9H3pasH+p58DlhwQFokk1P3UPs8E6gwQblNS
         3y2vmqJNbFynsPA9n4jihs9Kt00u95Dqp57+S3dDKNdvAg8YihAxvEm/oL57tAWfl/1S
         bJcw==
X-Gm-Message-State: AO0yUKVrIB6rRk2bZi2OzqSqvPMYWZDZ8Li+tjmD7ustDZo5T8xmUYqi
        rfUpsA0ZXSmC7cUXrllS98YrBgIlETBe5fR5lrM=
X-Google-Smtp-Source: AK7set/sRrQmyA1JU85a11weQG62DJ5POsOsuA1qS6Nz5J1tjuvaOKHLgUxrmPYCbBeSOBwtTAnu6iYLQFqLTIJmwpM=
X-Received: by 2002:a05:620a:2442:b0:728:8e9e:9887 with SMTP id
 h2-20020a05620a244200b007288e9e9887mr709515qkn.385.1675350098284; Thu, 02 Feb
 2023 07:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <20230202014158.19616-3-laoar.shao@gmail.com>
 <f18a3e-335c-ef3e-b572-73bd651138e4@gentwo.de>
In-Reply-To: <f18a3e-335c-ef3e-b572-73bd651138e4@gentwo.de>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 2 Feb 2023 23:01:02 +0800
Message-ID: <CALOAHbCCKF_N+Uu1Ka6fMeApwPNdU3B1Hz4J3_AcqHQ4vJOQ9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] mm: percpu: introduce percpu_size()
To:     Christoph Lameter <cl@gentwo.de>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, akpm@linux-foundation.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 2, 2023 at 10:32 PM Christoph Lameter <cl@gentwo.de> wrote:
>
> On Thu, 2 Feb 2023, Yafang Shao wrote:
>
> > +     bits = end - bit_off;
> > +     size = bits * PCPU_MIN_ALLOC_SIZE;
> > +
> > +     return pcpu_obj_full_size(size);
>
> Dont you have to multiply by the number of online cpus? The per cpu area
> are duplicated for those.

It is multiplied in pcpu_obj_full_size().

-- 
Regards
Yafang
