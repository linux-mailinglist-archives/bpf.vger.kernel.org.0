Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F23687F9B
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 15:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjBBOM1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 09:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBBOMZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 09:12:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489229039F
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 06:12:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso3844218wms.0
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYyOEBkWxvJgd7OA0mHmSipy8L3OkjsbmgHHm82YhW0=;
        b=bdGjE5sLdnOc6Oph7Fu5WKF8YQBumY/CplyMSDyibTVkzifBMBAF4t0t9bwmHMeMAk
         Xi/ClA59CBMc2zx3ZNWcgE3Is4SAYnIvwbsjFIfd+w2DYdkW1WZ0GQo0ZhqxI7vpXpMx
         Iz1pvJ6lB6KUQ//GUPZ4h8j5rlZm1WwDYgE2QcQqLwoYU9nIiQ2E8TzuFMxsAMkyHeBB
         iF7JwkwGUUMILibzxhRFce7T5GFaA9z5cbZzvd6HOfqvG/Fn+hPh0OBPo+mSjMtdnrAS
         mBOgw7lOTUzNLvz5B5t+omjEdyP/TZsxXZxEhqh5SfjdzBTYLYi5D4LuwMr8CtJfvfBx
         Gl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYyOEBkWxvJgd7OA0mHmSipy8L3OkjsbmgHHm82YhW0=;
        b=jEV/Q1YvQ+8qUb9fJRny2YfT5xRAAqLkWzqKlonfhvyiyjoGCl5nkaCwozNDSVLJS8
         BWAyWj2lIEeXn5dNMKsDX5kx7AEf5vj8FffKhYaosBqMf76bBL1rVahBNEHBNYwXhs20
         OUc7T1+R/OYSpa8Kg9gxRxSGO6TZKvMn7lFvbTmmC5stEbHXTMaOvXxCB/CMyZOZoklJ
         2EG7PpnUI31jgeyT2l5zXBbyR9zIN9xHALshh4A5QWq9A4Z4y3HHtQ5a3mHGqCG42zsR
         5ojbRg/rtz68QQ9aPEQ9/2vpgJvJM21OI9pNsGDpmA0XhKDOhv5t1OIFBagZk9p1Gyq1
         xtRA==
X-Gm-Message-State: AO0yUKXWr6XN7Yd/JQrOGhGK6V1LRvTQTAV4CvZVfwARCbFElxxk9Y5r
        86lpWtyZyMJt3HQxYSlr4B8=
X-Google-Smtp-Source: AK7set+zSyZNVRZQRM0q4yC/hS/4n26A7XCmP+izQDcox8cLmbNIht0sFpUycREH/rnwBU7E2D2xRA==
X-Received: by 2002:a05:600c:1c1c:b0:3df:9858:c02f with SMTP id j28-20020a05600c1c1c00b003df9858c02fmr2058801wms.4.1675347120607;
        Thu, 02 Feb 2023 06:12:00 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b003dc1300eab0sm5449470wmq.33.2023.02.02.06.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 06:12:00 -0800 (PST)
Subject: Re: [PATCH bpf-next v4 1/1] docs/bpf: Add description of register
 liveness tracking algorithm
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
References: <20230202125713.821931-1-eddyz87@gmail.com>
 <20230202125713.821931-2-eddyz87@gmail.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <26b33f08-4e59-5107-42ff-cb7a3af59318@gmail.com>
Date:   Thu, 2 Feb 2023 14:11:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230202125713.821931-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/02/2023 12:57, Eduard Zingerman wrote:
> This is a followup for [1], adds an overview for the register liveness
> tracking, covers the following points:
> - why register liveness tracking is useful;
> - how register parentage chains are constructed;
> - how liveness marks are applied using the parentage chains.
> 
> [1] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
