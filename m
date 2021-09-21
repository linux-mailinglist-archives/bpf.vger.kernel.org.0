Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20F413673
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhIUPss (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbhIUPss (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 11:48:48 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98298C061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 08:47:19 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bk29so55641927qkb.8
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWMTKLyj6T/GPciDDD2Ln6viqKV6fCtTl0u+Q+i6eUA=;
        b=VO7DHLq8nO+KTg0XbBaSBivv96JmlUQBW069Zc/BVs12qGFzgcfkP1D1WXfana0oYl
         /WqVXlCTWz8meyCpPRtGVdyo5bkLBD5pOOeLsqBTVYxLz6tUJFRQyZJqksguiBXrb1Yj
         rAqOfuEpqB/SXFZ/eBGlIOV8ThV3jCBjHtwNnQoh/DjtTNobQoyG8dBu2b7cixzTkgC6
         St/JDNufCVUyC/vTjifYW/CiQ3qqJpsRwrgOhSZuQgsdO8BYuUngIWQXCCLUJqXt01zr
         vl9bzT4WHy7T09OmrYcSGVsiYUlqBNoOOHI+GO9Z46/bbIlTF2F/8YX8wPBUaUsbH1iJ
         R91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWMTKLyj6T/GPciDDD2Ln6viqKV6fCtTl0u+Q+i6eUA=;
        b=VPM1IPuLImwUB82nQNZIlVHAaAQ7dTAqtsMmKIh+XgLTwfuvS7dL1u+GMluADbbQlJ
         r+qkCOekPZ9MCfGqciydg98YCp3fMGeRdiCmBUW60r11Vu8wUP+J4TOW119yoGzAnBDb
         Q/Ft4g+W+BgNtWQpr+NzTXTpt2Y8F2su0uPzJhR8vGwp52NJhns0ysey8jww0UjkcM32
         iGWRYkNSjDjFreChOD2VlVRiFLG2D43d8ydbWdYDlP2duro7wlfIAznRRePqUnxCRuB4
         DgWfY18l1yhGUR6zhOdFWp54ptNRg7w6Q4efRfmv/xb3gdmkphE5ejrZjd76TCqEQ+oz
         euEg==
X-Gm-Message-State: AOAM532p2UyzEgSAOgJcUW9seu0cpsIo1ONc7KNEVnRMSLy8fWNCzv1t
        n01hfjmO9zofgwi3983HVOiXa4jNG2J8wnJhKwgfDGxg
X-Google-Smtp-Source: ABdhPJxCNrI5of8a+uTEU+JT0y7VRXDy19hKGJzPOMFVv4ZW/Afx2VOUPF6tpVWPE49AO+YpPgBRVOmmAgWCEhBXm9Q=
X-Received: by 2002:a25:1884:: with SMTP id 126mr22422817yby.114.1632239237069;
 Tue, 21 Sep 2021 08:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210918031457.36204-1-grantseltzer@gmail.com>
In-Reply-To: <20210918031457.36204-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 08:47:06 -0700
Message-ID: <CAEf4BzYqkThWJ+j0-SP1SbQg1SVg4CwPXkePey7AHuAxdX8bew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Add doc comments in libbpf.h
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 8:17 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds comments above functions in libbpf.h which document
> their uses. These comments are of a format that doxygen and sphinx
> can pick up and render. These are rendered by libbpf.readthedocs.org
>
> These doc comments are for:
> - bpf_object__find_map_by_name()
> - bpf_map__fd()
> - bpf_map__is_internal()
> - libbpf_get_error()
> - libbpf_num_possible_cpus()
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---

Applied to bpf-next yesterday. Patchbot didn't notice, so I'm giving
you a heads up.

>  tools/lib/bpf/libbpf.h | 66 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 8 deletions(-)
>

[...]
