Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DDA649F64
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 14:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiLLNHr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 08:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiLLNHq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 08:07:46 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B8AF15;
        Mon, 12 Dec 2022 05:07:43 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u5so11952894pjy.5;
        Mon, 12 Dec 2022 05:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Qae+3gpjlZ4aHtJW4a8rsj6ywaTrkotTIcu0bHPlFE=;
        b=OHFOZTNfAqJ5xEqEKu74b3+pJARjGTpEK0Q++tj63X9V2c0yhZDbx3cArL0HhKR6cg
         9vspm+r/fnEe64a1tkTGl3eVoo3Pk2xv0uwq5wp4Mmybk4Z81QL0sMATKc1xGeCYWgAl
         5598IQWDeSo6dGgyfgn93daBXfsnC/gG4F+tI+VpPNtkuFUXhnMG2Y1N8HcU3A1/WQuH
         TbpJCl8X46k7firn7BTTNTTb8ZmNeOXLicNiX+9ZJmuxQNjtMSwC+mPco4iR7UOz7QHo
         tI2wh6OK9rapv8HgYYNy+200eVgBcenqIeU3p7DqYDaZxmPGav22+kg6lx0ftWrGjbmO
         HL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qae+3gpjlZ4aHtJW4a8rsj6ywaTrkotTIcu0bHPlFE=;
        b=gdujsdITrue4A4hd5HZRmbBZwI9GB2fYaLjFq4VOHz5I1MjSrhKLI1FExF/a24iVNV
         QLexdrynjTRY9bLlNG1D11p/Zdb42ceEWAYGP2280US86f3SUBqtAWQwM5YIPHaGKEn6
         oCDElhedNxRitG6E9AgyUXXSOJJpdr843kXzP17mhCKSYRsm+Z674SqJnp+pbF9b+Ex9
         GLPEOfPut8Drjqu6ZFyM+c9xuPiT00pjPuTM+kohK0nlUZ+Ou9VaH4XCPcg+/HcdN+Qj
         9eHMEQA8UDnpbjh9oaTaOOHf3ndbKglbz+WX27JFCfSAdmnYrkarRSJvTb3G3xN1AK9E
         InYw==
X-Gm-Message-State: ANoB5pnOwU9b0YgSJNPw4iLR4iRl0FDcR9fvmlRfegLWQw6YQusiQY0X
        9Ock0CLNKz3/kQY03DwEr/w=
X-Google-Smtp-Source: AA0mqf7GwQ9YL4IWroFx4lL1um52eBZPIcNibAiTFzMf6RCbyVR7cUx5wt2jvqRCugtTfqIcNMFYkg==
X-Received: by 2002:a17:902:aa47:b0:185:441e:222a with SMTP id c7-20020a170902aa4700b00185441e222amr16485008plr.37.1670850462684;
        Mon, 12 Dec 2022 05:07:42 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-27.three.co.id. [180.214.233.27])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b001885041d7b8sm6301725plh.293.2022.12.12.05.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:07:42 -0800 (PST)
Message-ID: <fd419b09-4514-7785-bd72-f912d0fe85c8@gmail.com>
Date:   Mon, 12 Dec 2022 20:07:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 28/31] sched_ext: Add
 Documentation/scheduler/sched-ext.rst
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-29-tj@kernel.org> <Y5anpn997mR2g8Ur@debian.me>
 <Y5bKGXG0o4dReJ8C@slm.duckdns.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y5bKGXG0o4dReJ8C@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/12/22 13:28, Tejun Heo wrote:
>> No patch description? Really? Please write one.
> 
> That's unnecessarily grating. I can add some blurb but here's an honest
> question. What pertinent information would the description contain that
> shouldn't be in the doc itself?
> 

Sorry I don't know the answer, but the description should at least
expand from the patch subject.

Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara

