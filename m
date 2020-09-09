Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FC7263366
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgIIRDc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbgIIPrP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 11:47:15 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E0C06137D
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 07:21:31 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y2so2484095ilp.7
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mtr65x6fK5IlIQRtZLNh/NxFbA0Ukhq43XJmWOA2CUc=;
        b=1kTWQ0Rx17CB3a3l6zRYbeWVNhCtQNdeO1Nyt31G782X3qOLON4LuUwU2Tfa2HcPBh
         eo2G7kbcA/xqYT4dUkojSxg3+vNGmZt2EyubttIOhQWjesQdymM00mjaHjpLaShFMpCn
         61y8hoz4MVq8xiOPf9zkqwlAvhn2qYSfAPRjcDSAc5CspVC43c4n4VpfDyNYwdPamoJz
         3A4tvoOXFutN7GNfYhYGLEIamInVZSviooYPkuI1G9U0ii130k/rjOPPzldqxP1mJCqV
         nyFrsR/dfjygylN1VDNcS5jSBh1M2gvITzl/AbNA5+8HifN1lQdBIlmucO5fQ/pzz1+Y
         LMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mtr65x6fK5IlIQRtZLNh/NxFbA0Ukhq43XJmWOA2CUc=;
        b=p4Ib4VmetdPiqaZUyyBqisJVbspjAnPki/4da9YfHZx35HI9hz1ZeouKZfUsAaJenr
         ssbXwDGp69QgeN6KNg3O8R3lgSqRoPXVM1sCGzeoKVlk7NLQeJaIea3AVGq/3nb/u3wd
         CYkr+zLruwbb/6OzZAnDvdtgEgQiWeM4mtBCOeVlwENiXylxSEH3UZxETbIo80XOW0yI
         XINzwplDT8n7QAN6dr/4o8hy6C8eFqWkcuvsmqveG3MjnYDPvJQVRpDSWZw3fbiIU4ch
         SxaI9GnAKEd5lk1Vkij/CWjPY94RieYQqRP0LQGAXwSvkRx7A8TRfrH1pydxSguwJwrw
         b7/A==
X-Gm-Message-State: AOAM530l4BLq+OjslAvTyJCX3+a9gqBQ0fPUIfhSfISYJf898a9kLpyM
        IMx1UgPsaLRR/ZJq0bJuhb6xQBzIO4YmsJEt
X-Google-Smtp-Source: ABdhPJweYTpuCpa5hQXVyCKu1HNYd1h5alEfQqDr7iNE+D2ODqGnoa1Ri0/JOkdr4eXiKi7PQPRmEw==
X-Received: by 2002:a05:6e02:d2:: with SMTP id r18mr3681539ilq.303.1599661290531;
        Wed, 09 Sep 2020 07:21:30 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j62sm1286878iof.53.2020.09.09.07.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:21:30 -0700 (PDT)
Subject: Re: [PATCH] block: remove redundant empty check of mq_list
To:     Xianting Tian <tian.xianting@h3c.com>, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20200909064814.5704-1-tian.xianting@h3c.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <466b8c40-9d53-8a40-6c5b-f76db2974c04@kernel.dk>
Date:   Wed, 9 Sep 2020 08:21:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909064814.5704-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/9/20 12:48 AM, Xianting Tian wrote:
> blk_mq_flush_plug_list() itself will do the empty check of mq_list,
> so remove such check in blk_flush_plug_list().
> Actually normally mq_list is not empty when blk_flush_plug_list is
> called.

It's cheaper to do in the caller, instead of doing the function call
and then aborting if it's empty. So I'd suggest just leaving it alone.
Right now this is the only caller, but it's nicer to assume we can
be called in any state vs not having the check.

-- 
Jens Axboe

