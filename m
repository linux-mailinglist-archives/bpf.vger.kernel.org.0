Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E936AAC76
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 21:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCDUjE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 15:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDUjD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 15:39:03 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA54DBEB
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 12:39:03 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i3so6260820plg.6
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 12:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34iX1lM9o/TQJmIN9AbBna5m7S1JUCdsDcRRVRmUWH4=;
        b=mc30rJALaXPDxAUg9uc8Sj7YzmKwF57MLA47AdqExO+X7KiTkLN/BqZY+ae8ZIX8TF
         O0FCzU8aJGDPGlecq7q6bMFR/uORlBI/fd8Kc0fJTdy/0pLaXgO1Xckd6RjEM7khR7Lf
         gUCELNxQulViV0efWkRPI9PLeDMheYehNpaLQrRsAId5Co/JH0XFEf7yJWwsLBQXRvr1
         d+xmPjlMJ2bBxo7NdWf/liJMx7YlfzcW4fe/KuvT8O3nnusRUE1D4YH0Ipo9Lmg12Fvf
         VdGVJp7JgdLIse4BRxVQWrNUEBcxQ3Z1QeCWPQIy5HRxLv8tLy2/LP4qgR3Nzcd2sJUz
         7WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34iX1lM9o/TQJmIN9AbBna5m7S1JUCdsDcRRVRmUWH4=;
        b=x7k2nepbcnzDJzARPk31NqxLh9FVxMzGKISi9owOBrzX+sOf0JF6gAbNR1tPWA/syB
         ac18tgk/BezSKDuobZ9X8qFALJIqUzh3rjJ01eeeQSuWf9PKtCeMFc5DwAEUahC+RgiZ
         NPRJCq168YRdN+4X0EDTkDtYIShPh/VoXvA56i6l4J01wVB1FoS1s3SqNY8KKcaQ5Aly
         aDxXyWXZSCTIUZ3gSGBg/gAEBTMQZD3tPU+ZZOO8+lt42j8Pj7smUFcMdCYYYw4LAaYU
         u0ik//4YPrbCbZ4NeThcBdWgeXBkEXxv+5FEbYqDmvpsM94p6l4sMb7kCJuF89wX2euK
         nMqA==
X-Gm-Message-State: AO0yUKWM83bwL+6sbokQj64ab0WT1qTbFbLvNJEuh5WPN15EAA1iacdB
        x2SFkXz778RymKigSgHK+gY=
X-Google-Smtp-Source: AK7set9oEeJhlGTYAKlrPvDgNVyK71KaBkYe9LbSTcUrHi15P1rrZDAgbCtC3JVkh/tRpiT9S+4QWw==
X-Received: by 2002:a17:902:f552:b0:19e:6966:cddc with SMTP id h18-20020a170902f55200b0019e6966cddcmr8333451plf.1.1677962342647;
        Sat, 04 Mar 2023 12:39:02 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:59fc])
        by smtp.gmail.com with ESMTPSA id kq3-20020a170903284300b0019b9a075f1fsm3707198plb.80.2023.03.04.12.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 12:39:02 -0800 (PST)
Date:   Sat, 4 Mar 2023 12:39:00 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 16/17] selftests/bpf: add iterators tests
Message-ID: <20230304203900.2eowyut62ptvgcsq@MacBook-Pro-6.local>
References: <20230302235015.2044271-1-andrii@kernel.org>
 <20230302235015.2044271-17-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302235015.2044271-17-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 02, 2023 at 03:50:14PM -0800, Andrii Nakryiko wrote:
> +
> +#ifdef REAL_TEST

Looks like REAL_TEST is never set.

and all bpf_printk-s in tests are never executed, because the test are 'load-only'
to check the verifier?

It looks like all of them can be run (once printks are removed and converted to if-s).
That would nicely complement patch 17 runners.

It can be a follow up, of course.

Great stuff overall!
