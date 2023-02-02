Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB66878C0
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjBBJZs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 04:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjBBJZc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 04:25:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A9D709B5
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 01:25:31 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso831500wmq.5
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 01:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52IPiBQiqlp1tsu5V2fLJqp7tNuqZnvH9nK9GgrnzeM=;
        b=COp4Aift2ATUBvh+7mmVNP/SgsyzfmiYToaut+fjabl0dKDkeQlh5GIgXcUye4Vo6w
         eaTiDb+gBqOuO/2yiXdZuffh3aKfGTzE9+NbKWAerXUe4xxvRrz/GEu1Ad6USID+AJIF
         in9cVG0NbF8CKZTeNZvqWqOMX6seJewRReO6fPZpyGerefJcDUGyfhZaEq4zMDN211JT
         jYjZOTFZznyXit9mUJ5N8oqsVvlKKdb/wgN9F2Fc7x4+W2e7gJ5Gf9lUK2oN70U89ugj
         WeZVqVqKNABYkxQpahlFpX1fyJ6bUaIE3gmk3oWtx/iuoUaz8pshQ2VN0y8y64pVrJyT
         PiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52IPiBQiqlp1tsu5V2fLJqp7tNuqZnvH9nK9GgrnzeM=;
        b=XgUircckTHyeHW2HAivWCIW/RzX568s7zv/EATojNdqVG0xKHa7+dJTwbFSrpEZp8z
         xsQ1WgpofFUZA9LuUxNnSLUmuFadDh/p1l6IzqRUsO6H1B642O2IyPaJrduxXXeRwYLW
         Krbefivrc6z6oCB9Gmk9ipdp53h89XBKrjAFZKdMaQEZRKmezkh5Pw33sQUj/lqpN7wr
         2VMV4c1d7AFRMlDFkluQ517/sD/y166GP7uUVBQLOhLv+3Jaysc+Bf320ul9cv0h94yA
         gP+9VMKvOAOSSoyyVauc6RaUPfOS3OXdC6NfJNvFjqf/CpP1wyI2ITJXxrjqg2mgF4Du
         2TSg==
X-Gm-Message-State: AO0yUKWY6qqXpV9C09cRK5vwayFhV/9PbMo5zmTVIOIyjmVGPHnhN4hN
        m3NIqc/y5s6+uiwtFqWmpss=
X-Google-Smtp-Source: AK7set8YPgAkZ0E6xBwmHKFVwzlKaqlItS8J7d1qvQq8ptn6lgYaw9s8jlFvSMQAUv6VDvlvjgfWJQ==
X-Received: by 2002:a05:600c:2141:b0:3de:d52:2cd2 with SMTP id v1-20020a05600c214100b003de0d522cd2mr5269947wml.4.1675329930158;
        Thu, 02 Feb 2023 01:25:30 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc851000000b003dc530186e1sm4142080wml.45.2023.02.02.01.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:25:29 -0800 (PST)
Subject: Re: [PATCH bpf-next v3 1/1] docs/bpf: Add description of register
 liveness tracking algorithm
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
References: <20230131181118.733845-1-eddyz87@gmail.com>
 <20230131181118.733845-2-eddyz87@gmail.com>
 <99a2eaa9-aebb-f0c8-1d13-62e1533631e7@gmail.com>
 <48f840c1b879728bda69e059f19c2cea642c1e97.camel@gmail.com>
 <c26d4287-6603-d44f-58fc-ed4c698ea5b3@gmail.com>
 <cc8561139d020136d0bfa01684317ef25996d184.camel@gmail.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <b6966500-c25f-cc31-5d61-eabf54f3e3b6@gmail.com>
Date:   Thu, 2 Feb 2023 09:25:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cc8561139d020136d0bfa01684317ef25996d184.camel@gmail.com>
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

On 01/02/2023 18:28, Eduard Zingerman wrote:
> How about the following?
> 
> ---- 8< ---------------------------
> 
> For each processed instruction, the verifier tracks read and written
> registers and stack slots. The main idea of the algorithm is that read
> marks propagate back along the state parentage chain until they hit a
> write mark, which 'screens off' earlier states from the read. The
> information about reads is propagated by function ``mark_reg_read()``
> which could be summarized as follows::
> 
> ---- >8 ---------------------------

SGTM.
