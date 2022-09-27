Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175E15ECE8F
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiI0Ubi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 16:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiI0Ub3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 16:31:29 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E246B657
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 13:31:21 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id s2so1628099uae.1
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 13:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WQZnUYhhyupmCxAphLo9r2q7WOcZU4gu4/xnR4NrA2A=;
        b=JIPVthtYX5Z1jcnRoldvCbyLEXAPFQAVwKCSleRvczjOYVxiw2q4BARKKfzzs0Urm+
         uOstm+bahbX1R/O0aGEq089ItmxZjaxzDRAeJFB6/pnIYArw7JCpr8bWM23XR71U2WnJ
         FBU9lukMaPJ9QJRyuDD2j5kK2D/aZ1nlaDCgOMlGPs+EJu7iJM0Nrbf4+OZ/f0DzQkdD
         d3lSgYjRl3/QY4BoFss7TChNks45zZoeL9jZgUEEWN31VzhPMLIejJh7WMF87cNg/aS8
         Sja2Tbm/peLwHI5+zuj0kxlsDbpd3T4MqhubtxY5uyBWUPlx8gzwPAVB5qlNtv5PixOg
         DFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WQZnUYhhyupmCxAphLo9r2q7WOcZU4gu4/xnR4NrA2A=;
        b=n9IpxbeYXFXo4deCMaM0xWGeADTqbvzIsNucmjwFGdkBn6tSdzVGoERVPJpjvcHbhB
         taYVp9mxxEXIA1Vl49KOlmxBmctTRi/SlqJYOE9DWuHTOn2ihVvAEJeeKusek5AViFLe
         dyW2fzW0mn0LCKZ3eckgh5NAauOoX+T69YE29KTMlBkczqTNQC7w9BhOfiMf51FqN7CI
         ipLidbW4cyN7o2QIZ+wxKlvs05i35DRx+PJ0Q00BkXV/4f1kVaT26lG0hhJ7+bpp2Z4D
         gqE1bBOEDYsN7Ri0saX+pUqqQZrrAr8GQUSqh/hPWNLBmnj3mXCvZsozBUUiW3PdGPMF
         mkEA==
X-Gm-Message-State: ACrzQf0Kz0XYoORxtlJeaWpcFZgsE/K4R9uRpc57Ujg9ZhyEVvHfyDKw
        X70usz3fcxDZ117rB7oKWbnY/E1+gOtXF5jPbTEv3XCQDHWjnQ==
X-Google-Smtp-Source: AMsMyM5Ze4hd/ajWO4w55HYz21UeWzl31mqxjZfUQC5uEK15CmSDyGU2AhUEj3+vRfOpkslfdWBCKOZPx7A8ikohYB8=
X-Received: by 2002:a9f:3641:0:b0:384:78e4:3b9d with SMTP id
 s1-20020a9f3641000000b0038478e43b9dmr13177522uad.90.1664310680281; Tue, 27
 Sep 2022 13:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220927182345.149171-1-pnaduthota@google.com> <20220927182345.149171-3-pnaduthota@google.com>
In-Reply-To: <20220927182345.149171-3-pnaduthota@google.com>
From:   Pramukh Naduthota <pnaduthota@google.com>
Date:   Tue, 27 Sep 2022 13:30:54 -0700
Message-ID: <CAEeqUsp_iqBUwAPUj0wwNjLdiGP3a=HT3uuxVnX5evWPaii=Vw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] Add selftests for devmap pinning
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Stanislav Fomichev <sdf@google.com>, haoluo@google.com,
        jolsa@kernel.org
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

> +#include "test_pinned_devmap_rdonly_prog.skel.h"

Oops, it looks like I forgot to clean up from an earlier idea. I'll send out
a v2 with that removed, but I'd still appreciated feedback on whether
this is the right fix for devmap pinning.
