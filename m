Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C6E59E3DD
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiHWMhd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243177AbiHWMhA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 08:37:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE197104B07
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 02:48:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k9so16335308wri.0
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=pPEVAxgaxKD4J0wcfxqhn23VCWzQtkRq18PNslA5OrA=;
        b=RscSYg+8HPYPD6Zw6Md7FBTnsNYqSOhB7qq2o4+pk7fuPQYyTrbVAHFs03ph3vD8lz
         FQNhgSnCCXCSJ0kcXer26HdZuAMbWOQQZIwDxhEdhuLeNDJ6ODapQSuZTFiMr/GxI3Jy
         OQAYbJZzDh5e/jxVDO3oDcamp65tpt0vJpxBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pPEVAxgaxKD4J0wcfxqhn23VCWzQtkRq18PNslA5OrA=;
        b=1YIGQEnR/LU8onotn1PMcL8qtvYtE9cui0cXe75QyQFj1KOTrJO0X60FVifz+5Lrbt
         NvnSS+CNqMVTK4ymQp7MJ1dgiPBczmXhajhUx3ugp5reDxNDOqdhfIzvvMV+GSbyDL0d
         rMaF8AcJbKfHYd73WFRXUzOEFxLx/4ZtwGl5tLwDpXlZxldkSZBbMaQJO30k9hpbkzPI
         JFtMAiETaYonK0FITiQrI4FU3yGAVuAVNi7PQMdzjznQq2MNSaBMHDhCdUegJHPhM7FT
         dRnogyBejF4bBZebMcTVmsIu8tmxdvKWMOQhkB8uxZ2sEnPAf1Hjf3PpnryzX2MdBStJ
         LOTA==
X-Gm-Message-State: ACgBeo0UjgnfAlRdRVQIkUV5zTzAnaIE+LR8lHmsHlIHF0UYlYs2n+DT
        o+8gu8RcQUc2Dw6v+qIWFXmBCw==
X-Google-Smtp-Source: AA6agR4p+cZzclalyIp0C04jWn3G0n/6bX0A6oaMjNSO/l0jnYh3SXer7Moj6MvFCSsHMLdIEN3Ryg==
X-Received: by 2002:adf:fe04:0:b0:225:1c8e:9027 with SMTP id n4-20020adffe04000000b002251c8e9027mr12733717wrr.155.1661248064324;
        Tue, 23 Aug 2022 02:47:44 -0700 (PDT)
Received: from blondie ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id j14-20020adfff8e000000b0021f0af83142sm13647565wrr.91.2022.08.23.02.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:47:43 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:47:40 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Support setting variable-length
 tunnel options
Message-ID: <20220823124740.63bb69d1@blondie>
In-Reply-To: <630488c5d0f99_2ad4d720813@john.notmuch>
References: <20220822052152.378622-1-shmulik.ladkani@gmail.com>
        <20220822052152.378622-2-shmulik.ladkani@gmail.com>
        <630488c5d0f99_2ad4d720813@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Aug 2022 00:59:01 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> This API feels akward to me. Could you collapse this by using a dynamic pointer,
> recently added? And drop the ptr_to_mem+const_size part at least? That seems
> redundant with latest kernels.

Hoo, nice. Wasn't aware of this new bpf_dynptr_kern, thanks!
Will resubmit with a signature that gets 'opts' as ARG_PTR_TO_DYNPTR.

Best
Shmulik
