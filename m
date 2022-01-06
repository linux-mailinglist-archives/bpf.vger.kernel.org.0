Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50574485D1B
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 01:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbiAFA0o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 19:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343658AbiAFA0o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 19:26:44 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C1CC061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 16:26:43 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id v10so839486ilj.3
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 16:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+MtkvKJJLUkRjo+TehPBt71Ox8LXv5TqmtM3OCiWpE=;
        b=epuCidMl1dxoGrKBfbB4hVxgavwvrXSv5+xEBUWICdPHDcFYzE2UDBQ7/skVmRfXbi
         WbZWaLGySPQxfoRg2w1Kdpj3XlS6JYpxFlEYFOUKRWVGc6UMNpW3WxOV5yo5eIjW8UEI
         snUNUay7qvzOBDG5UpPOmeh/8D1e7/xg7NlseCNFD/sPFmhC4EKHplq+vHh1CzODgf2J
         sl4rrk5BtFj90yS/Aie/wX3d9b1IA4Kg9rw0wPTsJlBxTBtxRs6/odu3X8Mwz8fz6CPq
         D7A3Hs2hYY6oow40gVa5Qws4x3ODI2q4QVC030wHNnNUaojAp2ozK4YZNxIF/3cyOHEY
         Gqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+MtkvKJJLUkRjo+TehPBt71Ox8LXv5TqmtM3OCiWpE=;
        b=D27iAWvRR6W1nuk7GVLbCPWWDnB8p2/tDR0xQ/c37CIkZwjWdfwpcEuQ00FYRVu7Wn
         i7v4HXLNrtxmv0a1A3GZkL5Of5Yss5bHwlzFHKaXKEyJY3wyiQKnvUQZ+jWKubPnE5Da
         9/9wQ7wqtOshqc11NIOWOBZjeTxbasmrlkFnlGwtYTvkhbp+yfFbNp3BDZ8ZR0GkW6ZT
         odJGcOgrDiEisOmhTU1cV8INGM29p8mCwwBMYQPh8wI5M8GisxRJLPSP1XYkvo43nKFq
         3htCSjNqlWnKrBLery0m1Ac9Jhowb+etwLOGSQf0KJnGwHXFBNJ+cRpQ06724TW3ElWJ
         1Hdg==
X-Gm-Message-State: AOAM532IL+Nu+Ue6FVwSjD/+ECalL3y5zoImzX58+rAVC5nWD3cJt31o
        hvQgRfbDXCZ7GHXSaBdYjjmzPM70esaMUjslkZMONPPB
X-Google-Smtp-Source: ABdhPJznsyrWPq+BKQIMAz6xMuAZTZZ0iw9lAhaNhgDTnwKIN2bNsRMZOoQfa7/7Yh6rNT0B/YgTje12lwCGfq75y3Q=
X-Received: by 2002:a05:6e02:18ca:: with SMTP id s10mr27064588ilu.305.1641428803261;
 Wed, 05 Jan 2022 16:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20211230215338.6be8cccf@poseidon.quill.lan>
In-Reply-To: <20211230215338.6be8cccf@poseidon.quill.lan>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 16:26:32 -0800
Message-ID: <CAEf4BzbEH4m_y2saV1nN30a_eOSb2ORRgZfXQ6FaXtTHyUsYYw@mail.gmail.com>
Subject: Re: libbpf: Memory error detected by Valgrind
To:     Alex <bpf@centromere.net>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 31, 2021 at 2:35 AM Alex <bpf@centromere.net> wrote:
>
> With valgrind I discovered the following in v0.6.1:
>
> ```
> ==923672== Memcheck, a memory error detector
> ==923672== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==923672== Using Valgrind-3.15.0 and LibVEX; rerun with -h for copyright info
> ==923672== Command: ...
> ==923672==
> ==923672== Conditional jump or move depends on uninitialised value(s)
> ==923672==    at 0x46707C: strlen (in ...)
> ==923672==    by 0x466F4D: strdup (in ...)
> ==923672==    by 0x41DE90: internal_map_name (libbpf.c:1521)
> ==923672==    by 0x41DE90: bpf_object__init_internal_map (libbpf.c:1540)
> ==923672==    by 0x4200B0: bpf_object__init_global_data_maps (libbpf.c:1601)
> ==923672==    by 0x4266B5: bpf_object__init_maps (libbpf.c:2601)
> ==923672==    by 0x4266B5: __bpf_object__open.part.0 (libbpf.c:6937)
> ==923672==    by 0x429609: __bpf_object__open (libbpf.c:6885)
> ==923672==    by 0x429609: bpf_object__open_mem (libbpf.c:6999)
> ==923672==    by 0x4315C0: bpf_object__open_skeleton (libbpf.c:11529)
> ```
>
> I believe `map_name` in `internal_map_name` of src/libbpf.c is the culprit:
>
> char map_name[BPF_OBJ_NAME_LEN], *p;
>
> The issue disappears when I change this line to:
>
> char map_name[BPF_OBJ_NAME_LEN] = {}, *p;
>
> Should I submit a patch?

I don't understand where the issue is, tbh. map_name is clearly
initialized by snprintf() unconditionally, so by the time we do
strdup(map_name) it's a properly initialized string. What am I
missing?

>
> --
> Alex
