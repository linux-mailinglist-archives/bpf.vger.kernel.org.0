Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291B9692B22
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 00:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBJX0g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 18:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjBJX0f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 18:26:35 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE9A1F4A1
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 15:26:34 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id c26so14872218ejz.10
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 15:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iBXwqoPCuNdKkYBehKvau5QpSug7jJ5GHo8AA7LpcZg=;
        b=ngzQVTZ27MY7kb5zAHGRatSnjSvzHzPuCOLsuCPszekboEacE+0zaBecQHCcv4qLMO
         3FrhXvCvVhO82y+HWsjloARJoTF1PbzF4r48xCVTyHDeDX8ZkvaYiAEYpUiDi4bIaSJs
         j+FIvRhppTtUTDZu9pdhikmjUyYjimibGH4gSOE5gKD6lRlsnFXq6wmyqKNGW322DHHi
         BhsqBdHAuFkhB4MQUEU3NCRIiXI7hUvHxwJ+pRlKqDp+6ziKyIgOaqNJny/dlQAM0onN
         N7STr/MMkz04pt4FjWSepkaBM18PzKqQQvC5x8L4h3NQoosu0UrNmRhMMEAVwfGfToqL
         KMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBXwqoPCuNdKkYBehKvau5QpSug7jJ5GHo8AA7LpcZg=;
        b=8NE34pXLnSszqOo60UcYVQbvCyUKxu0MhcJdNMShUKqTYWTO4w6YrRkM/4v+3xfxn6
         B1eEm/QJaWhtp58VOz3K2RFKPBc8Np3IA/ql63fGUp03/UZuM/Ckwpp1q8aBtgF2hXos
         xAAabOQqkupuZ4R7drRVUcMQTi72ikN8cUS6WWwCNs9tNS2ajLgh9DLlJ5QpAPDY+UbH
         AxtELlljG+bLXGzg/zuTvhcZVxxUCv38tiUeCQklZz+1tcEztCa/AO4ylrhXgL0oeRvs
         /puNyeRI9c1lpnQCtDCX8uWjGXOXU3rq8a/etXvaqkQLoyglgI84zhwM7M03pecSgc8E
         oD8g==
X-Gm-Message-State: AO0yUKUijUrFdKRq4HLV/zDp7s+UT3UiyY+wlxf7UPhoKxw4oOFL8WqY
        AusmLnz3VxBBAauMQra8pBTcFuCpXR2PVISLcvw=
X-Google-Smtp-Source: AK7set/+Q/3WYNXLDrLZfB2rBIHbipC7tHQA9d7kqQVRb/a2azDIiX+ZFALoqdPnfZrlU80kAkpJMXU36RK+/ygwNgk=
X-Received: by 2002:a17:906:aec1:b0:889:8f1a:a153 with SMTP id
 me1-20020a170906aec100b008898f1aa153mr1698359ejb.15.1676071592860; Fri, 10
 Feb 2023 15:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20230210001210.395194-1-iii@linux.ibm.com> <20230210001210.395194-12-iii@linux.ibm.com>
In-Reply-To: <20230210001210.395194-12-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Feb 2023 15:26:21 -0800
Message-ID: <CAEf4BzatVzj1f58HpusvMPiD77QR0E1x_mdV-4d2e5Lr+Riu6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/16] perf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Thu, Feb 9, 2023 at 4:13 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Use the new type-safe wrappers around bpf_obj_get_info_by_fd().
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

This will cause unnecessary pain for perf for a small gain. perf
supports linking libbpf dynamically, so using some very recent APIs is
a complication. So please drop this patch. Samples and bpftool
conversion is totally fine, IMO.

>  tools/perf/util/bpf-utils.c   | 4 ++--
>  tools/perf/util/bpf_counter.c | 2 +-
>  tools/perf/util/bpf_counter.h | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>

[...]
