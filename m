Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3856314EC
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 16:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKTPfx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 10:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKTPfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 10:35:51 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92A72CE08
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 07:35:50 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id j6so6556439qvn.12
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 07:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fpwqVOW797gAFKaMlFf8rbbV9ogLoKN+pyL9Kzxq/Hw=;
        b=ZOYD2TgVj7T0xPjQ+jIUtjU+vq3fPR84XpXCvebYPPYI/9fbZ/LXfWaRbovc0z8xhF
         T92nk65v1UW8rGSGTU0kq/sd+X3cK+yxmdLeYUnNazHqzDUwruJW1OHmfKfx2IVWIpsM
         W/R7inVlGR6fgSXZ0p9DUkEuURjiCjmyt68bxxWIbuX0Z44vYEQllW2OWh928+1v0Al9
         t1fPpjX3Mrr0pzMHvhvP7GxJEHcFQEDdWS5lRyKW/j2f4xDgZQS205INk4CaYjgIjpnN
         3cRMBLdCnmlOxuMZX/CPyrlVkEZvMzwwbvksujODSQCmhyhNPhSvUDT1ZDcMyvumN7JY
         7suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpwqVOW797gAFKaMlFf8rbbV9ogLoKN+pyL9Kzxq/Hw=;
        b=ENDk0tqkAwNfsIETkARamqBPlk4AeR8fjbsJW+3JL1di6jF91fGkW0DsMONBpUephs
         VN1dHdQIuKlL0x1ADXbBGu24H/9BKe7hcR1Wz85gSliXvkUyr3lus2tTb6toGfE8KxXG
         zFblvz6WOn9Au7DKknmxJ+rUAtUYVlrHfEXr8aKeoPDuz1SQmw/MGxP1HMdgcvpzDHSb
         LvZohKBX2xC5eAyfSbrjYK3v6SHWsuU3YLzmvV3DOzJ/j97/6Oruse7VVEcum27b1jkd
         8a93Pj6xd4V11ggIH7Kqr7BFZ2xIOZ2LZ0q35a3vSO1NgiRAsIFtQUC40iFOygkA/1VM
         CL8g==
X-Gm-Message-State: ANoB5pkV+7PCqjuvoFZJshszXVQwCZP8fSRfe3hzBlNeOtELLtZjSLni
        KElMFw5kG2KRijH9r4SlvOXf3Y2sxGsBT/RCtqqISA==
X-Google-Smtp-Source: AA0mqf77324nlIUY+wS5UtR45efI3byUqSKuoV/Lx7tqebN/IvrA3fZ+8rxnGBBVRkUUFdRiGdp5ovZSRIghWZJ4pXs=
X-Received: by 2002:a0c:914d:0:b0:4b1:af7a:7f67 with SMTP id
 q71-20020a0c914d000000b004b1af7a7f67mr14190954qvq.67.1668958549981; Sun, 20
 Nov 2022 07:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20221120112515.38165-1-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221120112515.38165-1-sahid.ferdjaoui@industrialdiscipline.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Sun, 20 Nov 2022 15:35:38 +0000
Message-ID: <CACdoK4+0_q_6T5gF_TGhceVTcq5+77qYOY-sC3Di8kqQkGXWBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/5] clean-up bpftool from legacy support
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 20 Nov 2022 at 11:25, Sahid Orentino Ferdjaoui
<sahid.ferdjaoui@industrialdiscipline.com> wrote:
>
> As part of commit 93b8952d223a ("libbpf: deprecate legacy BPF map
> definitions") and commit bd054102a8c7 ("libbpf: enforce strict libbpf
> 1.0 behaviors") The --legacy option is not relevant anymore. #1 is
> removing it. #4 is cleaning the code from using libbpf_get_error().
>
> About patches #2 and #3 They are changes discovered while working on
> this series (credits to Quentin Monnet). #2 is cleaning-up usage of an
> unnecessary PTR_ERR(NULL), finally #3 is fixing an invalid value
> passed to strerror().
>
> v1 -> v2:
>    - Addressed review comments from Yonghong Song on patch #4
>    - Added a patch #5 that removes unwanted function noticed by
>      Yonghong Song
> v2 -> v3
>    - Addressed review comments from Andrii Nakryiko on patch #2, #3, #4
>      * clean-up usage of libbpf_get_error() (#2, #3)
>      * fix possible return of an uninitialized local variable err
>      * fix returned errors using errno
> v3 -> v4
>    - Addressed review comments from Quentin Monnet
>      * fix line moved from patch #2 to patch #3
>      * fix missing returned errors using errno
>      * fix some returned values to errno instead of -1

For the series:
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks for this work!
