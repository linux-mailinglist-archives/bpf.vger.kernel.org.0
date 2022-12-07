Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC8645429
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 07:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiLGGnb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 01:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiLGGn1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 01:43:27 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3846562FC
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 22:43:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jn7so16165106plb.13
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 22:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPWgO0bmIGUmi+VkC0P0zNgAap+OYqVSh5ClUoAgfEc=;
        b=dV2WZ0pWRfo80aEgHeq54OpMSWMLWxrtHWXHVmY5u/+bCy9+dndP0UpOTkz2BZfP+8
         SJnf65+IWjfRwVcEBjFVZPKtAYH5Xljt1hIhG+t/TuGS36ktkenx36PFxM/R+5Dtv9Jz
         4ApUjVPeTW8eiQvy7RgGOXhrwrzXYJm4oEwSMFbJ38D5hbcHD67fe+5TLURGjoCfkJzH
         jjtpxAg42/yt3dI0RyjnTgwPaQQrC21bV4aQZZhOJSIdbEfXH8qlsFAVgDVgAvpkj41j
         uoTLZnrEfLaSYrxrl+oPm79QBjwzHdsOhQGL8WDXfQ49bGNFma2LZKmLJZRvK0OZzEAm
         KstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPWgO0bmIGUmi+VkC0P0zNgAap+OYqVSh5ClUoAgfEc=;
        b=NpclxmFK9JDV1/4sdblbxkR3OEZsLJYirzwosxG9od7wu+xqUhCbiQa4+wAxm+hlsu
         GhvZW4vqFZ0Qb68EpSxKUMjeyThQta6p3hPn+Mu73IUo2NQPs5DUThlX2Lprfa0942Km
         SrRtjV/x5gND0Dlyr3b9sTW7KGsg2Ru8A/5BESdx8phHBoyeMb63BfTuExirJiMCMVZi
         Db2Z3is8NUdpI2OiWZEKzums3X1VtnrBs+cZDOJ53hb+niW3l0ygS+/Qp/1JhLL0kjPB
         bc0lWOkaiOGQwbaVpxoDr2QDXdEbmwqYyLlpegWz6rpeeFSsre9APrqu6Y3UQw4DbBS7
         weYQ==
X-Gm-Message-State: ANoB5pnfg2LAFWiRP8AU1nUxUdfLQGQbyhor2gwcFPFFPY/20dpiSMiP
        ymZwOjfveAPYiTaAP+7mGcY=
X-Google-Smtp-Source: AA0mqf4Iud4YzfBoDA0sVJf5GLWAFLvDFrQRtTw8UBLHMgiTbCQGZR7S314gcTy8cb9kiBdI3bAPpQ==
X-Received: by 2002:a17:90a:5911:b0:218:7b32:d353 with SMTP id k17-20020a17090a591100b002187b32d353mr94228637pji.100.1670395406755;
        Tue, 06 Dec 2022 22:43:26 -0800 (PST)
Received: from localhost ([98.97.38.190])
        by smtp.gmail.com with ESMTPSA id d17-20020a63f251000000b00476d1385265sm10796259pgk.25.2022.12.06.22.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 22:43:26 -0800 (PST)
Date:   Tue, 06 Dec 2022 22:43:24 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Pramukh Naduthota <pnaduthota@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Message-ID: <6390360cb92fe_bb36208c5@john.notmuch>
In-Reply-To: <CAEeqUsrLqtxvQeKLdDe0xAc_zTM__0wuJ4Vqta+cUzQe5fuNew@mail.gmail.com>
References: <20221201011135.1589838-1-pnaduthota@google.com>
 <20221201011135.1589838-3-pnaduthota@google.com>
 <55bc0068-880d-4715-0fb5-a2b384951c1d@iogearbox.net>
 <CAEeqUsrLqtxvQeKLdDe0xAc_zTM__0wuJ4Vqta+cUzQe5fuNew@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] Add a selftest for devmap pinning.
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

Pramukh Naduthota wrote:
> Sorry, looks like I didn't run the tests again after fixing my
> checkpatch errors. Still new to this, and am quite mortified.
> 
> Is there a better way to fix this than sending out a v3 of my patch?

You'll need to send a v3 and be sure to build/run the selftests. Also for
future reference please don't top post it. And thanks for working
on the fix.
