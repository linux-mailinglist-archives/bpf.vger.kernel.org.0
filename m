Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC7E6BD8A4
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 20:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCPTJD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 15:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCPTJD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 15:09:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1863E6EBA
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 12:09:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg48so11547271edb.13
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1678993739;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mB+A29eEEZW7kIMc9mlvPB5+eUGl+xUe7SC9reM3S6A=;
        b=TDtgsxbHk4hOtfcTIZ5OVlsLk5Yf56AF3BA7K4pas1/Gkp5acLOxaaQgrvhHdv5jnS
         ilK5c88poRrc0LDcU5QQXUNF6G4mVCf3DGYBqfTwB5HfC9gJ5JgekL/wXhw9LGPZbYwL
         deRMu/kN8nPMUAxp1YVvYfhlwk9RFpdL5+xv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678993739;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mB+A29eEEZW7kIMc9mlvPB5+eUGl+xUe7SC9reM3S6A=;
        b=IlgZfHoS1szD3TjWp4Zwk/W2TIiLTBJd6IwZMt2qYMAaGR0kzBnvg5erVhtvKAxSro
         KEtrEbVAi+BQcArH6L7ekUuO42LbFQNMvmPoKq3w92bngR6xwvl+iVCtPhABTF3EquWY
         r+dN8sECosQXrZN1wa7e2XxV5WQZ8WJYbrB7lVDyIbw7aC8rrT6prPBnbzikv3y5Yula
         vpS5FgHTuov0ztaA8kd85jHTDb1bgd0ITX5+ATc0WN9yPVcibLp+ZIwj8fEs2MXWl18J
         Uc7VMlHYDz//IWhuNpiVrykgoHKT9TLwrNBENNPszbekmv5oz7Y9AQy4Vs1PkkQvh8bB
         bvTA==
X-Gm-Message-State: AO0yUKXa8+L+CxpOfTkgRP1eFiWDazbSvqmxFiPBrhQSgVmlJ3/jRUAW
        1/Conq9IIui6Ct8A1jNY8zU1V2ryZxvu4GJG63lYTQpasDlnSxZIpNE=
X-Google-Smtp-Source: AK7set8FCbLQbzQX8WYJ0EU5p6Q0fIItM7Z69/BBvG9K4lbEyabqeZ8GoeAWpT94osyvWhmtPzFZVhOcBr2megdFsDo=
X-Received: by 2002:a17:906:854f:b0:92b:ec37:e4b7 with SMTP id
 h15-20020a170906854f00b0092bec37e4b7mr6032102ejy.14.1678993739213; Thu, 16
 Mar 2023 12:08:59 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Lai <chrlai@riotgames.com>
Date:   Thu, 16 Mar 2023 12:08:48 -0700
Message-ID: <CAAFY1_4a5MC0-BkGcRx-5n-vdXZbjjrjEukwur+n4AOXFhMHFw@mail.gmail.com>
Subject: bpf_timer memory utilization
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,
Using BPF Hashmap with bpf_timer for each entry value and callback to
delete the entry after 1 minute.
Constantly creating load to insert elements onto the map, we have
observed the following:
-3M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
peaked around 5GB
-16M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
peaked around 34GB
-24M map capacity, 1 minute bpf_timer callback/cleanup, memory usage
peaked around 55GB
Wondering if this is expected and what is causing the huge increase in
memory as we increase the number of elements inserted onto the map.
Thank you.
