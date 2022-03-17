Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0984DBE20
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 06:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiCQFVa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 01:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiCQFV3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 01:21:29 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB521C7F34;
        Wed, 16 Mar 2022 22:10:04 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l18so4770057ioj.2;
        Wed, 16 Mar 2022 22:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4gmqQuGPJjduKOS0VKqwRnrZDQWThVwCU1BkVJb0qyo=;
        b=Kj2UPnhuFkvSepvlkYKvXv2ZUjCsy5i/IffG2LpzPTKjkzuAHCaFB4kaXzskR2GBe+
         86Gw8hG7UWTwnhP6alZ4jxeT9sMiD6M7iLFys4X/GAfr6d0p+pN8XQC7LWlZx+LQJtt6
         FVdo32fCE0Vcw7fdOi8vVjWZljmPmL1KeNQCAh0gm/0o9IFv0eq6qCzU5xb4P39+3g9b
         P8pjY8E4o86ZEDvxhiFuoQaQ9sPbuw66PfVTFu9Xdh8ZOPwA/oOAfsp4rNgUZsz5a0iV
         l9LBhcmjWa2dXHX/Jda9xn6kWa+RISEpoIELncShEuOPxDZeig3o0yh7+o3E8WjSp8SQ
         aAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4gmqQuGPJjduKOS0VKqwRnrZDQWThVwCU1BkVJb0qyo=;
        b=HHNqjYJ1fj84ysIkANNrfKmBkDhFzwSW3ajpdSBsraC2Hpqm9ccxHMIj7ZDnk8BvEy
         yhV6z852hPG7mYiFGQicAHr7P6mVN2LB0ZGTzMtd71N7JHQ7O1zvRENEtUJROd++sOzJ
         7d8hzP4kTqMzQd/4TuFgQoXyO1RgBxmv6dqkFZCjhclT/w+wGWhiRUiYtsUIVPVDYHoT
         1kh/7fyyybLRf3uoPjKmVoINh8j+4LGZpgDiVbkJ/nZgpCcH9BvIi7L7G3WMJc8DKD65
         Y1Ueta79a2r6Y15t3xiQkTpQYKGon/arhsijXC5Bn7+qlxxqFOVH0bEIaCD4Ma0Jy1wy
         iIVA==
X-Gm-Message-State: AOAM530Hn2bZLQzVkmrRd6+xI2xgv2ZYBvRQOTgvMweMMmEqfl7xr8XF
        rTtlEC4oukbsObN/4UOhWKYxnt/05ZmvuA==
X-Google-Smtp-Source: ABdhPJxreZTx1bq4zpOUlBaoGH8PpCAEnIjro23cSjqxSmVghWu8UgVgnUCsUsCTVYxPvAEMjt8Y1Q==
X-Received: by 2002:a02:2406:0:b0:317:1aea:c8a4 with SMTP id f6-20020a022406000000b003171aeac8a4mr1233329jaa.65.1647493206983;
        Wed, 16 Mar 2022 22:00:06 -0700 (PDT)
Received: from localhost ([99.197.200.79])
        by smtp.gmail.com with ESMTPSA id b6-20020a056602000600b006494b91cecdsm644342ioa.0.2022.03.16.22.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 22:00:06 -0700 (PDT)
Date:   Wed, 16 Mar 2022 21:59:59 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     kkourt@kkourt.io, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornilios Kourtis <kornilios@isovalent.com>
Message-ID: <6232c04f3c9d2_487f20860@john.notmuch>
In-Reply-To: <20220316132338.3226871-1-kkourt@kkourt.io>
References: <YjHjLkYBk/XfXSK0@tinh>
 <20220316132338.3226871-1-kkourt@kkourt.io>
Subject: RE: [PATCH 1/2] pahole: avoid segfault when parsing bogus file
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kkourt@ wrote:
> From: Kornilios Kourtis <kornilios@isovalent.com>
> 
> When trying to use btf encoding for an apparently problematic kernel
> file, pahole segfaults. As can be seen below [1], the problem is that we
> are trying to dereference a NULL decoder.
> 
> Fix this by checking the return value of dwfl_getmodules which [2] whill
> return -1 on errors or an offset if one of the modules did not return
> DWARF_CB_OK. (In this specific case, it was __cus__load_debug_types that
> returned DWARF_CB_ABORT.)
> 

[...]
 
> [2] https://sourceware.org/git/?p=elfutils.git;a=blob;f=libdwfl/libdwfl.h;h=f98f1d525d94bc7bcfc7c816890de5907ee4bd6d;hb=HEAD#l200

Thanks for the reference and fix.

Acked-by: John Fastabend <john.fastabend@gmail.com>
