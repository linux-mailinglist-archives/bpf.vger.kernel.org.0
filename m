Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4778F5E9A53
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 09:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiIZHSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 03:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiIZHSd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 03:18:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6631378
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 00:18:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id nb11so12091307ejc.5
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 00:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=/VTORAyU6Sh8vmL2hwHItqSKWneVT05Nas1xc/s2AZQ=;
        b=lPdtT4oh7EtPX83gReNjydRQOqSAvvHB6knUzzF+HzRLnuDSdwmDux5aULAD8Gk/St
         hmIc/4jv3uzNmQ3CX+ug1+BHy7dAXZyV1/uTpWfSSMGoHanA3KqQ8thGOj+dN4tDzkly
         OWdxid+hm0GkxZlSWKBISb6JIeZ09mgbLmw9ENS9fvWnjEXmrAs/0oWg0lGgnENlRaom
         J+ydJ1kWoqGCc5EGiLMwOZgSGqssRXEDwE21EPsY1QFIe/cgBB3ld8UUWxsvz/pLAaMV
         qYl2Ruw4/M0OTjYYyMurdIAFAcvmETzCnV5ypT8T5u1eaIjxPIYVqw4z3G0ZVHD7YGnM
         EGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/VTORAyU6Sh8vmL2hwHItqSKWneVT05Nas1xc/s2AZQ=;
        b=1szeSFMWL6tOSqp39axrcPAXNvwjf5GgvcZYOxiWKdm3r78zuKrap+vv0ebW1sygaN
         j5PUGzytEnSrogpE/z8GByhOa+qyrV0AC7DRE/UOFqTAzkaqQ2Bi++dxmlRefoiouIvq
         UaOYUURZ0MY1c00M7n8aJ9JNELWUojROYAFiTrIRTlVaQyoGIRL1MTYP14rOXk3goDX2
         TYyqsXG+LV5P/IKeBRlfCvKovbRgjbl6umqbecVixFGGdQatzkRkTun7sxmNX9Hj42Z8
         nlVj+UNfWSgEey7Apgqqi6t8eaZiplI7J9wRQfDS06OgnWHszghpECR7C3YWuccwPk1N
         QLag==
X-Gm-Message-State: ACrzQf24kUPtCIc+j125SgHeTs9OonbciEGvrnSZx6R7dj1yajAsFmPD
        pwLIFcwMlViyj+87CerTsrgcPn3UaM8TOPJPDtQGhX4e3IE=
X-Google-Smtp-Source: AMsMyM7zxlkekbckXrGbT2KSLC0Ulw3nLzxiE87861YY4iyglV22dkXALmP0btw+oAl64ROf9SCQAHBReBjgRV7ukig=
X-Received: by 2002:a17:906:d550:b0:780:cec2:aae1 with SMTP id
 cr16-20020a170906d55000b00780cec2aae1mr17359185ejc.477.1664176711171; Mon, 26
 Sep 2022 00:18:31 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Mon, 26 Sep 2022 09:18:19 +0200
Message-ID: <CAJ+HfNgnvWaQcZKC37ayZgrWdLa1Ni9Zvena8NxyEYPTeAoMsw@mail.gmail.com>
Subject: The future of bpf_dispatcher
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the recent weeks there have been various issues [1] [2] (warnings, ftrac=
e
breakage) related to the bpf_dispatcher. The dispatcher was introduced
to reduce the cost of indirect calls for the XDP realm, and during the
whole retpoline timeline it was doing its job pretty good.

However, it's a somewhat odd animal in the kernel, and very x86
specific.

Is the bpf_dispatcher still relevant? If yes, can it be replaced by a
more generic functionality (e.g. static_calls)?


Thoughts?
Bj=C3=B6rn


[1] https://lore.kernel.org/bpf/20220923211837.3044723-1-song@kernel.org/
[2] https://lore.kernel.org/bpf/20220903131154.420467-1-jolsa@kernel.org/
