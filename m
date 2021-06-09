Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8BD3A15BC
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 15:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhFINgo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhFINgn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Jun 2021 09:36:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF6EC06175F
        for <bpf@vger.kernel.org>; Wed,  9 Jun 2021 06:34:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso4315193wmg.2
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4saDlChR+RuvHPGRsi4z0xuOYFPQYvYKCEMLsyCqzts=;
        b=mT8xmEwsva2RWOzg9GTBeuJ4HZupNdWelO0n8QJg+EU9VEOZ2CGcwVBkrdigkGIswq
         yUTV+H8x2P8BeRwEnGAIo0shA3xuNheHLaWAv7w1sBfVkhG47vxYmI7b76Z6/DpvQ0vX
         aUp9wkl1YP0YdLW+NrRkj32B9yVHPnPh/L5MwrvJCN7R1VXZ9+RTuc1WIGEvuirQkKzg
         0ZrhbLCyDcao7O/gmpwGwIEl/Kol4c8oRMjviylBoSFDJiBrWCP16stXJcseE7vfvi11
         wP5RsapFMxJu8EbSZ2IOt2gLZipP7jpfSKMxwQOu9LVqUhfiTyp6igYkujhdPq4ihZA2
         9kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4saDlChR+RuvHPGRsi4z0xuOYFPQYvYKCEMLsyCqzts=;
        b=QE6uccXJoSm5RZHoUfXsVG3OZ90Cs0+dqiT3/E6yajnPKPZFU515Q065PGq1COlTIc
         R7zghgHjJavv9VLO23McY6E/gdbFDGuN32VdmMKbRuWiVZuzXmv2bgaQ5nOGuIa5/a6/
         DhFiOkzHGKqGlOLQUR3Jqyn65h2ASQwg4OdgT3hYlyQHMWeyXJwWijFCxIHpg0pAu6cv
         mCsPm6UJDseTHWJWoNjU4adhOCNOMvX0JsNHnYI4/nIK1Z6JdMm9SNTjy2edUqrKead0
         hyZSW+kq6luhEZV9dUG/wvRkc4CiAVDwOxrz6Q77WIWlh11t26SGTY+vRFh87oCux1gi
         auYw==
X-Gm-Message-State: AOAM532k8YOdqDVVM+8LFxaTQVTyESqNPiTRj2iElS9t0O37kOyVvbiI
        MJ9y0ueujbliXgF1FEmfyL0qxQ==
X-Google-Smtp-Source: ABdhPJwYtQRehX/ldUS18MDWwYYZ27ctlbQ1XpeEyR3fN4K2ALfBatOJhZqCN/XBWhZpl9xlA5By/Q==
X-Received: by 2002:a05:600c:ad2:: with SMTP id c18mr27456842wmr.93.1623245671854;
        Wed, 09 Jun 2021 06:34:31 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.73.197])
        by smtp.gmail.com with ESMTPSA id b62sm22153441wmh.47.2021.06.09.06.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:34:31 -0700 (PDT)
Subject: Re: [PATCH] tools/bpftool: Fix error return code in do_batch()
To:     Zhihao Cheng <chengzhihao1@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kuba@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
References: <20210609115916.2186872-1-chengzhihao1@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <7883956d-4042-5f6b-e7dd-de135062a2ef@isovalent.com>
Date:   Wed, 9 Jun 2021 14:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609115916.2186872-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-06-09 19:59 UTC+0800 ~ Zhihao Cheng <chengzhihao1@huawei.com>
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 668da745af3c2 ("tools: bpftool: add support for quotations ...")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you for the fix.
Quentin
