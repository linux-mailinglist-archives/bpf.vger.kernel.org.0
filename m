Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9366E73F
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 20:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjAQTrt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 14:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjAQTpM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 14:45:12 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EA970C47
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 10:45:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id jl4so34454352plb.8
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 10:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=czjhulnbxPViHNWlhUqdkq9lJ5ibNGkW0rVGu5OvcwM=;
        b=VqFKj5xLiYUzG6Ce70T+Dcy2tU+ny9/BcxI1XyEtmrqKY3kypCiDTX0kSotQsEXAji
         +3jvoN7G/Onz6Jslf5D4wwX6t+lIuStMFwTF6IlRk6T/R+X3QFtSYg/eJlFKUcsGt64U
         FUxzCfkaD2X6E9v4M3dJFO/o56InPtkubOlkvr/IfdObyaiAdlRdo+xDEmWiYd48hhAP
         Q2usM5M7DpYwJraYBVmdIo8ppQcw4Pd0IDyTZIYggBkv3zvwYonkF95s/BCh/m1dhski
         ctkQsGBXfjkrIfzt6z1vBUTkhlDjiVocTJgVapuiOqYFNa+sn7p8LZPeIMJQ9aV6c4X4
         R3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czjhulnbxPViHNWlhUqdkq9lJ5ibNGkW0rVGu5OvcwM=;
        b=MkjZb71dk5a4v9tPHwgXLB8G+5ODVBBMeyU0Wwndh4CdqIWwIhlMNJO7ZLzxNkqk2h
         B17Walmqq5UDQ8izYPnLNgL0ZcgULNHonoiJrfzQIhHdz/zN/xs54JScCRzOlYhG1Pe8
         R/rSXSnNZKMLhhro9mkRGZwzIhK/b8BGySYW5pCjkvvVdISsTcREQa1o5v33n6nbO8lO
         5thepD/A5Jhn8CJP7MgPo50mwgOcZTAw4IJW6/fbQo4xtIevZgW1MP21k6iMxxgSpeTJ
         bkjpN5m5/hY9XQsuL+YMkt0Amco8PC8C3D2JmJK0h9ImOAuEs+rlHKLpWM9975zASKyq
         //9Q==
X-Gm-Message-State: AFqh2kok2KU0bAT86BdToWj1kIYdyrIBgBSFch/+hkp/ew97CpkkwaiK
        gCoKOdlOBFODUJezgAvPUahGb9g+vGA2xkx6WrhdO7yFQL6k6Q==
X-Google-Smtp-Source: AMrXdXvrCudSHaNnM43PvEJFlsb4z7qRdLY+v55llR/9vG77XFNgcMFlqVcIGIt2tvFGmS63M9LYIl3/Y8nqsuWNf1g=
X-Received: by 2002:a17:90a:588c:b0:229:5906:e9d9 with SMTP id
 j12-20020a17090a588c00b002295906e9d9mr450832pji.181.1673981116988; Tue, 17
 Jan 2023 10:45:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
 <CAEf4BzYztcahNoFH_CvtWz_1dTA3SSYv+zOorsyP0TfX-2EdaA@mail.gmail.com>
 <CA+khW7gXaHwxZjS1sp0oAF-t0jk0+CnwxdhV9kqyBfqEVack-w@mail.gmail.com>
 <CAEf4BzaQPtFMkcJdH4m5S0X5t3UD1M0M_bJk9Z65Zspb5bbxgA@mail.gmail.com>
 <CA+khW7g44a7a1-C+q7B5NA1DPiM6zCanLsrXOfNm1vOvKwPtAw@mail.gmail.com> <CAEf4BzbtKXzk2oLkmYM_6uiAg5OpxvoakgiS3tsh4+Z1hK1GDg@mail.gmail.com>
In-Reply-To: <CAEf4BzbtKXzk2oLkmYM_6uiAg5OpxvoakgiS3tsh4+Z1hK1GDg@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 17 Jan 2023 10:45:05 -0800
Message-ID: <CA+khW7gP=NfkNp56R5dxYy2a5QAt+5-mD-NZh2V2xh=TRwYGDQ@mail.gmail.com>
Subject: Re: CORE feature request: support checking field type directly
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
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

On Fri, Jan 13, 2023 at 6:44 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
<...>
> You need triple underscore between old and new suffixes, see [0] for
> ignored suffix rule.
>
>   [0] https://nakryiko.com/posts/bpf-core-reference-guide/#handling-incompatible-field-and-type-changes

Triple underscore works!

Thanks!
Hao
