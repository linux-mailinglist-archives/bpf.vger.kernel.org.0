Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE66E86AC
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 02:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDTAmS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 20:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjDTAmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 20:42:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B41D2685
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:42:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a34d3812dso31021566b.3
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681951332; x=1684543332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tW4PJkjb+FWSlVhBWNdj8q8GhUe/g+/kBG1brMDKfPs=;
        b=blJnypZMzqZzsEiWXlDe7qq2O+zt7PaEqkjLIlGnTMrjO1reLD13cN2K1lL/wwe9B6
         9Ub+SZ+fheuP1ds6lV0XNMEDNGkYjTtX1oIpCYLZy5bUDs7eHGGNFjiRzieOKmVXtvzn
         381MLQE/j9BjpR8GYoe4EdJBtO1UTJuiNFZ/gttnyUZecaZktWsUbcVDAYfvbEf8KJ2+
         yRScXjk/MPSKc6EfNOB5K/e5T1wrAZBTdA2ZPe/QObK0EOXODikCs3olwan1uM8v+JHN
         xm+huzBrvduP/g/VoVuPHASdYYp666I/B8y0j0yP9Q7JjkQi/h/t2TJJBaRnJhkHgH6r
         RcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951332; x=1684543332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tW4PJkjb+FWSlVhBWNdj8q8GhUe/g+/kBG1brMDKfPs=;
        b=Ec4j3anOPa3/PHu+ocH5LfMaqF0AOAYRWD0Sj3ZjKOizPBYLw0EFmTJjdO6U7gwQ2w
         mFJ4k3sAtL1D8D2rFjrpoF5LQB+MXBUnyOP+CipolsX9Chfll9k1Ip3f0xiEIJ9JLvBx
         RVUk1/leKgvzlt9g/P5LIkMJLZxMp7aglicoU/xZnci/KYeN4j0Vwq5KWiNfbz4bNMbM
         UsCmp/KtyyNW6l9cSDwA2MhYGxMpSD61zSzlgjIB8CJJmqDqtHV2WTFj9TUtAE3xeaP2
         ALlFXWdEbserzZeHN/jyP8XGC5KO1ofp9GV9WYgyMXRNolAjDDmOR4N1jfZqsdGhCp/B
         0/hQ==
X-Gm-Message-State: AAQBX9cFdnGKYxAr6PhyygZdcgMmZ/nxtzCoyw0Y78XaK3etxk4KqyIv
        k2eF5C+Nkmuz/8XX7hsY+/KFr5EzoBMax0hxmEjaww==
X-Google-Smtp-Source: AKy350YmO4T54S2PgczMfnsAYjJaQrurkCO3Sk9vVZldjeuXI8jzEuQp9DeymAz8XA7Y5nyGg0NiZ8eFdGuFWXH2lfA=
X-Received: by 2002:aa7:cd4e:0:b0:505:513f:3d2d with SMTP id
 v14-20020aa7cd4e000000b00505513f3d2dmr6642216edw.40.1681951331885; Wed, 19
 Apr 2023 17:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230420002822.345222-1-kuifeng@meta.com>
In-Reply-To: <20230420002822.345222-1-kuifeng@meta.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 20 Apr 2023 01:42:00 +0100
Message-ID: <CACdoK4LKSn88Hfs9eGJMWi9z6VMdvWBPQ3HCPmFs9RPTpKo9eA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: Register struct_ops with a link.
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 20 Apr 2023 at 01:28, Kui-Feng Lee <thinker.li@gmail.com> wrote:
>
> You can include an optional path after specifying the object name for the
> 'struct_ops register' subcommand.
>
> Since the commit 226bc6ae6405 ("Merge branch 'Transit between BPF TCP
> congestion controls.'") has been accepted, it is now possible to create a
> link for a struct_ops. This can be done by defining a struct_ops in
> SEC(".struct_ops.link") to make libbpf returns a real link. If we don't pin
> the links before leaving bpftool, they will disappear. To instruct bpftool
> to pin the links in a directory with the names of the maps, we need to
> provide the path of that directory.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
