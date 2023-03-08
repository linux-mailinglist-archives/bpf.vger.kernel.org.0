Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1396B03AE
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 11:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCHKFK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 05:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCHKE4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 05:04:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C94A9EF42
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 02:04:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so854545wmb.5
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 02:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678269889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xI3IeYXjb0jAILEXVkmScjtFgQT63K08asdpYEfJy3E=;
        b=St+DQoRQVODXHngLpW3+ICNhaEstYpS5Wr9ON081v5f+MMckEjilnBrh/rdSKQNWLG
         tclEuHIdnGpdkk8TNc0/h944dGrDLtf2DBVhGgkgOWodqzo2hJWxRekTen0fk8yOWRgI
         lKb566qJh9lt4CbyOiKbKeEZXOa7P7YZ5xQSXxo/Ob42sAQ8IXRQ0J30XqBu3X0Cc9vu
         YsHf9JoJcIUCvLvVs7am7eSx4wVm7Usl3FcVRxbcFv1r6tW2JnwqSRmObB8TYNIHUoxi
         t5vesgCff2lzTg6+36jv5Kj616TWXBiPIECif4r/dF9qUeINigUUmlsf9tz7BcwH0DeT
         mAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678269889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xI3IeYXjb0jAILEXVkmScjtFgQT63K08asdpYEfJy3E=;
        b=KOlqDrHQpttdLY4rjImvIK3Z+8uj4wtU+BfcJ+MSplhznhTPpKMek3GM8NxtCvExYb
         kSCtXweB+o5BRnqfKLpz950gEFdl29mPyNKfozmmwzKMLxJPopTp6GvAYfMsN5stV7d0
         zM9oHCrZFK81JoNrsnuvMxsEp5Da8xksTXaXyjuFGdb0QuExAIORUqYjlt08ZvHLhG++
         n2nat8LpRCbp5oi8SVbBwokVPkFEfx/YnmECIIBt9zxOYDjeaV3KW4dSwHe+aQ0PjTxl
         BL9lrY2GX7uuPrq/BCK3Dt4Uc1PUV5KtUV7ZYM0cIvnvn9CJOvc20Q25DwwhUwOcQEOO
         Fczg==
X-Gm-Message-State: AO0yUKXy8nIBVDpiDlVZcuPV8mccGDceSols9iCJIrfpvtBnJvDMiQ6B
        i4woFqF8nIqBj6ygTMvgr1k3lg==
X-Google-Smtp-Source: AK7set9785bEFEG7igon4buj4fZtol0gnqjPLeirhpztiuSSEMkVteG0gLAAXgqQ85ish/2QYB2sUg==
X-Received: by 2002:a05:600c:358f:b0:3eb:3f2d:f237 with SMTP id p15-20020a05600c358f00b003eb3f2df237mr16639997wmq.6.1678269889660;
        Wed, 08 Mar 2023 02:04:49 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:8dc2:aec7:a9a7:915b? ([2a02:8011:e80c:0:8dc2:aec7:a9a7:915b])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003e91b9a92c9sm15143482wmg.24.2023.03.08.02.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:04:49 -0800 (PST)
Message-ID: <9d1c6719-b989-f4fa-4f89-fbccc69dfe30@isovalent.com>
Date:   Wed, 8 Mar 2023 10:04:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [EXTERNAL] Re: Suggested patch for bpftool
Content-Language: en-GB
To:     Rae Marks <Raeanne.Marks@microsoft.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     Leonid Liansky <lliansky@microsoft.com>
References: <SJ0PR00MB10058537EA379C1260C3C8A9FBB69@SJ0PR00MB1005.namprd00.prod.outlook.com>
 <b32ecbd4-4ac8-d925-18fb-735bf7d30ad4@isovalent.com>
 <SJ0PR00MB10072E7C794A3E2D8C1E86FDFBB79@SJ0PR00MB1007.namprd00.prod.outlook.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <SJ0PR00MB10072E7C794A3E2D8C1E86FDFBB79@SJ0PR00MB1007.namprd00.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-03-07 18:15 UTC+0000 ~ Rae Marks <Raeanne.Marks@microsoft.com>
> Hi Quentin,
>  
> My apologies, I linked to the incorrect line. In particular, I want to continue iterating if the call to bpf_map_get_fd_by_id fails. I cannot disclose at this time our use case due to confidentiality, but I can imagine a scenario for example if a kernel module wants to override the return value for some reason (not our use case, but a legitimate one). Below is my patch.

Hi Rae,

If you want to formally submit your patch, please make sure to also take
a look at the generic documentation for patch submission [0]. In
particular, you'll need to sign off your patch, and to make sure you
generate it against the kernel tree (not the GitHub mirror).

Please avoid top-posting on the mailing list, it makes it harder to
follow conversations.

[0]
https://docs.kernel.org/process/submitting-patches.html#submittingpatches

> 
> From 7f3eb5c045ec0169435c18af448ebe5eeb642cc6 Mon Sep 17 00:00:00 2001
> From: Rae Marks ramark@microsoft.com
> Date: Tue, 7 Mar 2023 10:06:34 -0800
> Subject: [PATCH] bpftool: Continue iterating if individual map operations fail
> 
> If a call to bpf_map_get_fd_by_id or bpf_map_get_info_by_fd fails,
> the current behavior is to bail out of the loop, which means no
> other maps can be displayed or modified. With this change, the loop
> will continue, so an error with one map will not affect the others.
> ---
>  src/map.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/map.c b/src/map.c
> index aaeb893..17074c1 100644
> --- a/src/map.c
> +++ b/src/map.c
> @@ -705,14 +705,14 @@ static int do_show(int argc, char **argv)
>  				continue;
>  			p_err("can't get map by id (%u): %s",
>  			      id, strerror(errno));
> -			break;
> +			continue;

You'd also need to remove the "if ... continue" three lines above this one.

>  		}
>  
>  		err = bpf_map_get_info_by_fd(fd, &info, &len);
>  		if (err) {
>  			p_err("can't get map info: %s", strerror(errno));
>  			close(fd);
> -			break;
> +			continue;
>  		}
>  
>  		if (json_output)

I'm not really convinced at this stage. I can't see a good reason to
keep iterating other than a map that has gone during the process, in
which case it's -ENOENT and we already continue (commit 8207c6dd4746c).
As I see it, any other error means something is going very wrong and it
makes sense to abort, as retrieving the info for the next maps is likely
to fail for the same reason. I prefer bpftool to print a single error in
that case, rather than a list of errors for all existing maps.

It's true that a kernel module could change the return value, but then
modules can change return values in many places, and my feeling is that
we can't afford to hypothetically accommodate for all of those.

Quentin
