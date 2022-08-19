Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C19E599BB8
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 14:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348084AbiHSMFl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 08:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348530AbiHSMFh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 08:05:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26D3EE4A5
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 05:05:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so4668729pjf.2
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nLF30amAk6vL579WqQVIBktWPPH4Um2+WcN9QKXX5zk=;
        b=hODOYdOY15vPYwZzoOow1TUmucyiWqLh87p/zVtdtDz9SDOKZED6uu/bDPi1fDlQvU
         o7qNyD8dlG4QwTsnmxhlh2QN6WzUwmjSuQkKpeMdB9xYMTJYQUzpQBju1pV5wsjsddCn
         IZ0AQB1Xk+DA9qX6dzWB2DCsil6vMkui9oplY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nLF30amAk6vL579WqQVIBktWPPH4Um2+WcN9QKXX5zk=;
        b=wXViKktylr1Y8wPP1t//rlqx3gnIzW/14oarbreEvQKpjHMeFCc/zNKpK2h2bBRGw1
         vrvEp9vDrx+LSIw2EH07/5qlSqKnpwS0fc1bqR8E6Dmgtffq51J0rDkWx71spDc1BNOZ
         LzgjZSLldPLozTQRU/aHIoD8Kbi63cOH6B42N+7+WS6DU2264b5CIGZwqfFxHaZ1CML2
         wJO5+wZES5YPBT5ZC7xNktqLBGLiU7bwNiQOBdrzQfqvc7XZeCkMXyNAeTD75KRkgytT
         inIIcI0ENl660jrH4LJB1EkvBPjqSeHgiD3XPOViuPrv4477xBRiva17VPNKRKaiALsO
         WGhA==
X-Gm-Message-State: ACgBeo2LCqBmKlCVusvyBQk+au9GQuSVFfAb7vz+uJEVueK1dwkhx02b
        I+m6FBO7pHBKuIZk1nZe6dZvzl4KVHMkdA==
X-Google-Smtp-Source: AA6agR4f7UYNK6rcXVoNBbb3KrKkDAbFm2B6jYhKcmmuZX87wJaBp6EK2y8EH0FRIrl9d1MriX5v7w==
X-Received: by 2002:a17:90a:d90c:b0:1fa:c99f:757d with SMTP id c12-20020a17090ad90c00b001fac99f757dmr8202541pjv.240.1660910736266;
        Fri, 19 Aug 2022 05:05:36 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:7527:6400:5770:d67d])
        by smtp.gmail.com with ESMTPSA id y187-20020a6232c4000000b0052b9351737fsm3409378pfy.92.2022.08.19.05.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:05:35 -0700 (PDT)
Date:   Fri, 19 Aug 2022 21:05:30 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Guangbin Huang <huangguangbin2@huawei.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        lipeng321@huawei.com, shenjian15@huawei.com
Subject: Re: [PATCH] lib/vnsprintf: add const modifier for param 'bitmap'
Message-ID: <Yv98imNv6BDTU0Bd@google.com>
References: <20220816144557.30779-1-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816144557.30779-1-huangguangbin2@huawei.com>
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On (22/08/16 22:45), Guangbin Huang wrote:
> There is no modification for param bitmap in function
> bitmap_string() and bitmap_list_string(), so add const
> modifier for it.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
