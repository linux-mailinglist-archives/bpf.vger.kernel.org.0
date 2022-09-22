Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C645C5E6BC6
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 21:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiIVTgO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 15:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiIVTgN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 15:36:13 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AEC10B203
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 12:36:10 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 135so2523711ybl.9
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=B+gga6ltJtUAel3yll8VCzI2wh4t47DgPA/bbeueEV4=;
        b=LGw6RoWIJhTtjzyWPFyoOKWj2PALb/UK9cMieG1EswUK8uncGsTKcX9GOT90bFqJCY
         zxjAEudl4ROGfcjGQySHHEM4eM3g5Rdayzz+sbVQRpHc+v4SEspoyjoGm3dUPlhjJ2i/
         l+RZN9qaEGfJLJNwZwDvDLDBT8y3FrqJP40VTeBaVNBEARp6hksHQ3Ff4oxXTt7PS16o
         zXeM0mf/BuhhK9PO25w6zjlb2zxTmppYIQ42mjn9ddbgHz9v6upXky0rjTFzDBck3iYy
         g/W6wREdY/00bB45gfdGxdAnaRsyZNQd3r/+lk9aeTuHTw9dqm0p8fPDdBEGZwqXnSsn
         Bdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=B+gga6ltJtUAel3yll8VCzI2wh4t47DgPA/bbeueEV4=;
        b=ChRLy6wTH2qfB12vjH3QKv/1EtQ6fa8BFJOUog7fK+7C0vywhbgixAPFEaRIIVQEkN
         bE6dolHvtTWixfZIQxhyclSyNJQjFfKHE2SQadkHKPQjYgbQL1ECSM3VKPi1kJw0/mMC
         SZyyW4O6F4bPBmrqISR+J3xEJhje+2yXQEicZbAcntXp+hVZxafNDxA/78j1U9l6IJ91
         R70cidHJZagjpMAhNLGRzjL+7Y/L3NJVO8k9gjB0FxqKHG71TeFgiHYIQwRJpG+ieqyj
         41WP+72u5yRIw1ZcLn+q3EBH6qRhLGMhQrjNp94Y0CPu4rdbFEZ8UmOY5iRxjSMq7u3U
         8G2w==
X-Gm-Message-State: ACrzQf0e2MSbjz4p99RA/BJ1eOwoNroDjqYM2iOYENFP9W0ZXhcxtkPO
        5HryXbLZ9XhaY6iA3xqP0b13STC83gxJHUkPZph3sg==
X-Google-Smtp-Source: AMsMyM5B26rqF5aDDU+4uPkZq44P4q/L62syhM0LGixbAJaHbFp8dTKOynRG64pCiD4+nr40BnT8apLy+md/oSRK3Xk=
X-Received: by 2002:a25:8b10:0:b0:6b0:58a:f8f5 with SMTP id
 i16-20020a258b10000000b006b0058af8f5mr5294000ybl.524.1663875369520; Thu, 22
 Sep 2022 12:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220922044023.718774-1-namhyung@kernel.org>
In-Reply-To: <20220922044023.718774-1-namhyung@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 22 Sep 2022 12:35:58 -0700
Message-ID: <CA+khW7gQPqoBSi5bSQXFdnkVyjMpu4A=vzFXRLvWDjZww0brEA@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: Get a perf cgroup more portably in BPF
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 21, 2022 at 9:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The perf_event_cgrp_id can be different on other configurations.
> To be more portable as CO-RE, it needs to get the cgroup subsys id
> using the bpf_core_enum_value() helper.
>

I remember using bpf_core_enum_value requires a compiler built-in. So
the build will fail on old compiler such as clang-11. See [1]. Maybe
we should surround it with #if
__has_builtin(__builtin_preserve_enum_value) to be sure.

[1]  https://www.spinics.net/lists/bpf/msg30859.html

> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
[...]
