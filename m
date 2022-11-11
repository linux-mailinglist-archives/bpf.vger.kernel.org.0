Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7C36261DF
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiKKT2X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiKKT2W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:28:22 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E1267F5A;
        Fri, 11 Nov 2022 11:28:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ft34so14703620ejc.12;
        Fri, 11 Nov 2022 11:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SLrRdT2XdqmrDUkaZHCP2NqvDXj8131047YB0+FVNPo=;
        b=ZR5Ueiqw1IiFgDenlSL3nVplWJ/tb5gtMizyp3sJKV5M/l68Oau/TgjYX0aistLq5U
         Vs5kHv+x536g045WmwVsfe4RwaudhYc5rqaxMSvN6Sn7ExxQGoy94lAubM7dUwMCmwJA
         dQ2IUE6jeXLXGC4esBQJe6juh5s8yhAA8uQMiLCKoMIKDOmS63fwMVa3yAsnCsD3e2Mr
         KYdFOuS/KdVkVluVDn72VUM4GQt+lFPUhROqDTBssZYZDNKBE9it1X5rbRgNNTcAGqxw
         vGjcLVcUtH/i8tMhzhRUDWSY67yw5mMOuz0dkRVXt7cyYwhWb6kjy6DGhKohdDCo503I
         c7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLrRdT2XdqmrDUkaZHCP2NqvDXj8131047YB0+FVNPo=;
        b=xpHGcGY8jw1xBrD3zx1do1WSFU9CUicO4GvQ7c8ICzjMf8El084Aj1TTi/0tJiamqB
         Ofi/15W1b6m0lCcZNMTQgK88tFwrlgWsKCuXLvH6Q7qT5rIAP4NnoZE+sDmpOQX+SV4H
         F01GScS0G/E6dD2dBQRxWHPg4VqtJK4WUtAEdRPRaVQ2dpHx4eR6rWiA/JSR3sKNFtXL
         Fin34d6TX+ZKKJRuvFOkMoydDf9P6AQFupma5g5aA/FuO0qCgIFEmLplr/oFi/RxlAqg
         Yp5RN/qqQux950s96DbymtQW4KIi3ZYkSBnnvbpj6jRNEnHIb8YqthggLbwxjlutNx3F
         MrgQ==
X-Gm-Message-State: ANoB5pkCUVIYTQxArItgklIbjnm4thJkZbp5vEwwbi9/ixoZtn//f2DT
        jBnIoY3kgNfuGC1BoPGpW67v41jppZ/wTgtszVWxTnXyjb4=
X-Google-Smtp-Source: AA0mqf7ta+x/OfAMB8FrXA1CUPwz503tTGj60OE4YEmS388ZVnFuaEGfd4Vi+OgE+oy6zTe45uHlMGDKIFAF6adJlyg=
X-Received: by 2002:a17:906:cd0f:b0:78d:99ee:4e68 with SMTP id
 oz15-20020a170906cd0f00b0078d99ee4e68mr2986865ejb.302.1668194899339; Fri, 11
 Nov 2022 11:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20221101114542.24481-1-donald.hunter@gmail.com>
In-Reply-To: <20221101114542.24481-1-donald.hunter@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 11:28:07 -0800
Message-ID: <CAEf4BzaxPPUr+FJPTnxJiCg=iPeNDf3NqJnndXe6pUEqM_a+NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/1] Document BPF_MAP_TYPE_LPM_TRIE
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
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

On Tue, Nov 1, 2022 at 4:45 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Add documentation for BPF_MAP_TYPE_LPM_TRIE including kernel
> BPF helper usage, userspace usage and examples.
>
> v1->v2:
> - Point to code in tools/testing/selftests/... as requested
>   by John Fastabend
> - Clean up some wording
>

There is no need for a cover letter for single patch submissions.

Applied to bpf-next, but dropped the cover letter. Also added "bpf,
docs: " prefix to commit subject.

Thanks.

> Donald Hunter (1):
>   Document BPF_MAP_TYPE_LPM_TRIE
>
>  Documentation/bpf/map_lpm_trie.rst | 181 +++++++++++++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 Documentation/bpf/map_lpm_trie.rst
>
> --
> 2.35.1
>
