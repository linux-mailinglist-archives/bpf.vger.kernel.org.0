Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4D6BC5A2
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 06:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCPF0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 01:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCPF0w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 01:26:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736EF12075
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 22:26:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4957380pjc.1
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 22:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678944405;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji3jLm/dcllNLVtngZjQ/qpp2+j6X4OznUvE0tzSQRA=;
        b=QNXJSAJwGv7FgF0AO57q1H1wkgdMTGcoDpNWCBMMeTANSR5V/7uAWnZ4TdVSpvMNe7
         Ayyfxgd8Ilwxj1lfWP2O6tm8DyswVt9wCRTlNEC39SEzow9wvYNH5HeyDqurrLeYoCjz
         Fv91KLIYQn0RGVtf4k+GIY/qim6DejIyCpa39vxqwrBsBsV/WIbinHu88ASF4jQCaYfF
         hq/89okBzwM7j52RU4QTEp4Ilu7T63d+/zE10jGsa76IPx2aBIDfPdtfjx7obenWG/gg
         v6bjr7ZUjnKWSUUY3g7Ozj2SVdbswk3on0mZDdLawRkrm+ZPyELa7aB/o0GdZumWrns6
         62QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678944405;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ji3jLm/dcllNLVtngZjQ/qpp2+j6X4OznUvE0tzSQRA=;
        b=4DKBg6RDL0IJVtfG4RLsE0SCCDupFvLrZJl8D+VNfC8c47Vj52Wz0dAsYNa5vzVahP
         Gc5tymOrA0jpYtSn5znpxKi4EzCrUpJa/hWwLhIcNJPlol93Hiy+w6/3CVc4asZXLbfc
         xem6j5eqXe3Ile6GbGjHjkR5GFu+KcZWGINYmyxHo6SbV1sqLmBrDkrdo6sc0G51OOOl
         MdDISJw5DbAPjMP0iwFMKxqWJXdWVGakKESiI4bZvjCqwbqcrS95kfIzgL1rME2U78Om
         o/vVIQ+SDqmsaHoVbKR++QHZ2Se+Kfksa9LM0wUwSK/7iPUomu/4eHwVxHs+l7SoySj3
         Q6xA==
X-Gm-Message-State: AO0yUKVfeVbQVeZBWCrdg7j3e5D1lHrMq8GqqYcoIkg1fVgv9fJtZOVT
        qULyWEAidlsjZA05C1+pLDM=
X-Google-Smtp-Source: AK7set8V+VK2vX/2Su1W/RIymrgn7QaPpnWAfiowHnH691Cls6neHA055ytwM2lTOi2cEWxa4Jp/nA==
X-Received: by 2002:a05:6a20:748c:b0:d6:c9e2:17af with SMTP id p12-20020a056a20748c00b000d6c9e217afmr1724855pzd.45.1678944404978;
        Wed, 15 Mar 2023 22:26:44 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id m20-20020aa79014000000b00625544bb33csm4388004pfo.81.2023.03.15.22.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:26:44 -0700 (PDT)
Date:   Wed, 15 Mar 2023 22:26:42 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Message-ID: <6412a892cc5ac_8961e208b2@john.notmuch>
In-Reply-To: <e755f802-be5f-073f-bdf2-28bbd93fd0ab@meta.com>
References: <20230316000726.1016773-1-martin.lau@linux.dev>
 <20230316000726.1016773-2-martin.lau@linux.dev>
 <e755f802-be5f-073f-bdf2-28bbd93fd0ab@meta.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Fix a fd leak in an error
 path in network_helpers.c
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> 
> 
> On 3/15/23 5:07 PM, Martin KaFai Lau wrote:
> > From: Martin KaFai Lau <martin.lau@kernel.org>
> > 
> > In __start_server, it leaks a fd when setsockopt(SO_REUSEPORT) fails.
> > This patch fixes it.
> > 
> > Fixes: eed92afdd14c ("bpf: selftest: Test batching and bpf_(get|set)sockopt in bpf tcp iter")
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> 
> Acked-by: Yonghong Song <yhs@fb.com>

Acked-by: John Fastabend <john.fastabend@gmail.com>
