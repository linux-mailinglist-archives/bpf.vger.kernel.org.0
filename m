Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98C6BC5A1
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 06:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCPF0g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 01:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCPF0e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 01:26:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941C628E6F
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 22:26:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j13so583454pjd.1
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 22:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678944393;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcLvVMLnIscrrmNw9/xf0Hr1woGsn0/x0RHizJ+ZzRE=;
        b=CU0VQf3JeHxuIGNL8H8grBT3yP2VWy3YDKrzNN3Bihy7WxfoEFGOga4dw+xr+yylKP
         9wIUeX/YHlxs9wfwf0cmDgSylRs46L8ZY+Ufe4fRB2PARSWu2+ZbANAyNVGaxi9nSfAe
         sGDcZtlJl4bPHICDNkXw4QA1BYa98rNUK+ocLVjgtz5B/H1jerbgy8eUYrx6zhumB5ee
         cBemCsfh+7BGtXATTvwjR2dVIAKlWEbSklt+hqluKOVzQIjk01eHNi8Hte00BclM+LnS
         obpRMJVmFOpDwE/Djr+izjk+4Z/8TyyeklXssQDM/Su5/WgM088z6/nqgcXDMATcvNAP
         vD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678944393;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EcLvVMLnIscrrmNw9/xf0Hr1woGsn0/x0RHizJ+ZzRE=;
        b=CWpod6b+fR0MvJp9pgF22PetRbfVtwZFEIMMr2zEPfbEuiA3HaGj/2MbRlEBptosY/
         Gb6ji9KglUpG7Z63KKAV12DPaR13oowm2p+13k2vI5pE80BTFM7+35jfBn0PVqI1cGzQ
         685tLK6L2lG0OuRlZ/ZfL6Ax/ut/6xhVi1ZLNC8xpzTMTwmlGo7BantW4RPMWmb/EEzi
         NQlJFhuv/3NGtgZ82jgIsU/GOtkQyi5TmSOgHpfnRVTcSufM9WGQIsz2LH8b9LLo5xcu
         i6NTiNhQ0+OHyyo0HAJtnkLVffpukLMUrpKj85T7ko6VEc+XxXFuP+KaHEAkWFXfJMpB
         wUYw==
X-Gm-Message-State: AO0yUKVa20eXIf0HoeC+BR/yn6a0ktOkC85FfeXz/zqznKnm8LLGGeqN
        +DSD68COqzUZ5Fjtu9yFlSG7UcE09go=
X-Google-Smtp-Source: AK7set8eVy9DxsQib92aKQsqoKJlIcAKgq2E+XLXgyozQOOhIzjWO9Me+nl2rUQN40/ZaHockZHIDg==
X-Received: by 2002:a17:90b:4c03:b0:23b:513d:8ff6 with SMTP id na3-20020a17090b4c0300b0023b513d8ff6mr2384108pjb.40.1678944393020;
        Wed, 15 Mar 2023 22:26:33 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b001a1929e7985sm352126pln.22.2023.03.15.22.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:26:32 -0700 (PDT)
Date:   Wed, 15 Mar 2023 22:26:30 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Message-ID: <6412a886947ad_8961e208d9@john.notmuch>
In-Reply-To: <0096d13a-b61e-28d8-d256-49fda1519047@meta.com>
References: <20230316000726.1016773-1-martin.lau@linux.dev>
 <0096d13a-b61e-28d8-d256-49fda1519047@meta.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Use ASSERT_EQ instead
 ASSERT_OK for testing memcmp result
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

Yonghong Song wrote:
> 
> 
> On 3/15/23 5:07 PM, Martin KaFai Lau wrote:
> > From: Martin KaFai Lau <martin.lau@kernel.org>
> > 
> > In tcp_hdr_options test, it ensures the received tcp hdr option
> > and the sk local storage have the expected values. It uses memcmp
> > to check that. Testing the memcmp result with ASSERT_OK is confusing
> > because ASSERT_OK will print out the errno which is not set.
> > This patch uses ASSERT_EQ to check for 0 instead.
> > 
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> 
> Acked-by: Yonghong Song <yhs@fb.com>

Acked-by: John Fastabend <john.fastabend@gmail.com>
