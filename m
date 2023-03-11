Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A066B5E7F
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCKROO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Mar 2023 12:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCKROO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Mar 2023 12:14:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40205B3288
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 09:14:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nn12so8176784pjb.5
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 09:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112; t=1678554851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOKGow/mO9jpNc8gyiIeqT76HvA8+ciKGvap6neQtLg=;
        b=yJiZLQha3nB0hAHFQp9VXnUdnoUsZXC5K7tGx+JqI7BAu7IJSR1x7U7FVPH8s74TqT
         DXt8PvA9yA+OaReqJwnXYsUWaafY8MfasdQ+hEisuk+NXAoTQ7QOQlFTIchEO2CIa3M2
         3D5oXzqnvdXjaYdX5lxaZmVqDPbGfDvA2JCayXcm7QyfyzcHID/lpQBgqnoAvxNZgT4E
         642nH9+0Sd+7BoY3rly6+o4UEAQ3UXJysbkIAko3GHApXkiEWy7PbFFpD6jLBLFae0XA
         BmuT6eJPSJYSblVOzuT5ZJcpaKMrcc/3GZ6wMPUq0ry6dKtdWQwscP6tVRlF3S2kskch
         hu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678554851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOKGow/mO9jpNc8gyiIeqT76HvA8+ciKGvap6neQtLg=;
        b=ZqTj3Y/nkS0UIcV5hIBxsZlzVxn48urZuB3U5+YDlK87OhYOEBUPptIt9svnHGLBoa
         vn4PalmuZopteJQRnlFxOuLIn2KmXMqn8kqWdbG7tdecU7RId4/CWKxzfahKf6FKExlr
         62mZuPI8QpOs3lKftBkqkdiZ+4UZY8YXfhullxiQ4rqHeYEI4YONvJRsEVtw4HCj4Fa6
         suJM3iiKXOiMw2sC/j9NxxM6ITxGJav6NjRedvWgFQVh2yYCB/tF+XdYMG+6ERtLXLc+
         i5ovyFlFFoRVxHUyl5IOTI47svQJNoytz5qSBRzmJFV7Qrq0MpmqEtevINkMCQ2itq1i
         dpng==
X-Gm-Message-State: AO0yUKXlR+ypyOsJPTaioS8BpUuvROfVxwUUdnTixHN0pva2dAEEfp3/
        3nDlqHUCPtTXeXmfeFCS8MG9AQ==
X-Google-Smtp-Source: AK7set+P2NvIbojvM+8gOZPt4aOld2GWsyXU4p7Q06ZatC0junkHBHw7lV2yhgvk/Q9jJm+KfBHlTQ==
X-Received: by 2002:a17:903:1c1:b0:19e:72c5:34df with SMTP id e1-20020a17090301c100b0019e72c534dfmr34384572plh.52.1678554851742;
        Sat, 11 Mar 2023 09:14:11 -0800 (PST)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id ld14-20020a170902face00b0019f387f2dc3sm198752plb.24.2023.03.11.09.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:14:11 -0800 (PST)
Date:   Sat, 11 Mar 2023 09:14:09 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, kuniyu@amazon.com,
        liuhangbin@gmail.com, xiangxia.m.yue@gmail.com, jiri@nvidia.com,
        andy.ren@getcruise.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net: introduce budget_squeeze to help us tune
 rx behavior
Message-ID: <20230311091409.4f125e53@hermes.local>
In-Reply-To: <20230311163614.92296-1-kerneljasonxing@gmail.com>
References: <20230311163614.92296-1-kerneljasonxing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 12 Mar 2023 00:36:14 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> -	for (;;) {
> +	for (; is_continue;) {


Easier to read this as a
 	while (is_continue) {

but what is wrong with using break; instead?
