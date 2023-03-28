Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC36CC40B
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjC1O7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjC1O7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 10:59:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA09E3AC
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 07:59:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id cf7so15434887ybb.5
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680015555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/Tr76xWiRdPhCzh2iAIz1ngMVJemqmUsrV57MPqNeE=;
        b=Tt1MpwBCckGfBRJPyJn7mnYIufUfVxu0osm9Xuq8gDBzp9Zl5SijHD6x4KQjbrMWEh
         cR4itExVYXUY8HTQuYCWuV5Rg6H125SdaHSCPAvUlKamplxStCH4rjE2/WcnHTjKhjrt
         038rfwwfndQ2ou7fJtK3qBflN/A1iDRlkq81JX+Z7insN5nb1uTL0Uo01n0XraIao7M2
         Fdp9ucU3Ljn6qpuDyKhjPEtSctWImYf+1VP6nPOE2U4SSXgKWYIn4QDlVxtNK1zY5mgr
         bLTFWCgmCGlE6IuJslMe1IS18hr0AuFjkuVwxblk3dP0+AkaQl8W95dVHmZXdHKaN7fx
         PZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/Tr76xWiRdPhCzh2iAIz1ngMVJemqmUsrV57MPqNeE=;
        b=RT4SFIPAPxWL85knHld5OYwKn8LBiKptdzGJvH/mXcHYFEopIt4PWfobLg3wa1AgBz
         KaD0vQl6bsLzQ6FMom6zimHARRYG7vO6Rj2EUyXBq3QyRTx6MWSetz1ErVmKrc4upbo0
         qZUmejDvhhgXN7z7aAFqsm3Lf8qvspwP1v1YmRPCS0JFdKt+q8d0KzAZVxKAyXJRpNhm
         U5ZUzkhg0QfUgbomNfg4KTonoT/qg775uGAxUqQK5Y2NEacyxkQU7k0eyNIsKowt+qQa
         9d0tOTQHvMavmLM4AG7tBiXO5ztesvN8gS+LrtRzo9yfSmW58BrCEIYIwUe4r1fh5/cH
         jsiA==
X-Gm-Message-State: AAQBX9fB5ZoSlzsefbvBZNKbBFqre+YKX8LNVZXNiKLuI9lgphbfAYS0
        ZhUfLFW7roWtz5GIXHZ7k7h7jgeHo7q1nPAOaFDWUA==
X-Google-Smtp-Source: AKy350aNQtresOYs68OKsUS0vcF2N6XmOyJ60HmYb6YXhXcoQU+dKlCLTm68Gcz+3vaqlOs4fNhYSgxXyk+d8mzAE3I=
X-Received: by 2002:a05:6902:1108:b0:b6d:fc53:c5c0 with SMTP id
 o8-20020a056902110800b00b6dfc53c5c0mr13259448ybu.1.1680015555044; Tue, 28 Mar
 2023 07:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-5-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-5-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 07:59:04 -0700
Message-ID: <CALvZod4zLhgjd3Tr5Qauz+OwF7Gj-NwDZPMpYAsxaMSUvu3F4g@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> rstat flushing is too expensive to perform in irq context.
> The previous patch removed the only context that may invoke an rstat
> flush from irq context, add a WARN_ON_ONCE() to detect future
> violations, or those that we are not aware of.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
