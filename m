Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEAA6A00F2
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 02:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjBWB6Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 20:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBWB6X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 20:58:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D5F11E98;
        Wed, 22 Feb 2023 17:58:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y2so6930979pjg.3;
        Wed, 22 Feb 2023 17:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ES+hJU7C0GAmrMheTS6LDouuORythb1ROogiIDv0iHY=;
        b=Bta0XgBNUTPmBTeLzI37RtHFuVDWPBqubGxqVHR0P/z/3aJaQliF1pRwaEPTW11tX/
         Iy4YWXtAitVf7DPGsngqf6UwNQW/g1rJQt1cJqOiwyQsD8KGkuJvLfeQBHSXTt71gFP8
         xqHdazhzXhjnswl9R4+ueGtjKbSmqN0UHAGVKZWI6GqEKNH14SUVwd/jfxQd7z/UfJiC
         Km/ngSiVXRSo8FPZA0iAA1L6lkCkhAjRyYR9no3s0TOruLBma5NEEDI5JubLxNbN0K+O
         Hh1dCeaM0PK0QJNZnRUfDyZV/xfxzbnOYM1xS1GR/s7F47Lo0MStKKKJF8iOMvZuD8AB
         zajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ES+hJU7C0GAmrMheTS6LDouuORythb1ROogiIDv0iHY=;
        b=lfyLHtgRJIuFm4MLKMEExz0dI0RD9qpsdlLfTcdlLx9yShJEkir2WCNkAptsNhRhhR
         Jh718kr5L1G3kBuWkFk6vY17ja8S7eRlI0oplIJRptCtH3WwwkcAsQ4Asu2fIUhZhVhf
         2dwo9Ag+0p4HzbBUfgOOAdxAsxEEesxbR77VDNMYD7dkboxWD6OD1F5YluQWMuNkAxAI
         sGBCXCgaORauUlNlz7yz5UsgE85U3Nf5srG220GTK/+pQDLZZ/vPZZ/M6ThM9FX+YdKU
         6DWKr+TLK9lGcZd5LTIFzBlhYr109lgPIo3aowUhUZBRBC1TYsy8i3A+zD6YPTny1X3+
         NGcg==
X-Gm-Message-State: AO0yUKUATTj7hNnq52OMRn2sD8FThl+cIJ3ieneZ1avVrb14vbnirMnK
        0yC2ezGqlzmHe8SmB+dDTp8=
X-Google-Smtp-Source: AK7set9G2IHGP3W1zAnPNrzTgYpIF5dIaXK1+tXu+tukZzMfWwuRNK3FNXgEc0FbFdXQ7MHy0/e8aQ==
X-Received: by 2002:a17:903:283:b0:19a:96f0:a8de with SMTP id j3-20020a170903028300b0019a96f0a8demr10224800plr.5.1677117502179;
        Wed, 22 Feb 2023 17:58:22 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-6.three.co.id. [180.214.232.6])
        by smtp.gmail.com with ESMTPSA id ix3-20020a170902f80300b0019934030f46sm1885946plb.132.2023.02.22.17.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 17:58:21 -0800 (PST)
Message-ID: <176b9ce3-74bc-2c12-eb85-14b94e3b5338@gmail.com>
Date:   Thu, 23 Feb 2023 08:58:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] Documentation: bpf: Fix link to BTF doc
To:     Ross Zwisler <zwisler@google.com>
Cc:     Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>
References: <20230222083530.26136-1-bagasdotme@gmail.com>
 <Y/ZlDnioTn+hj03/@google.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y/ZlDnioTn+hj03/@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/23/23 01:55, Ross Zwisler wrote:
>> Ross, do you want to give a Reviewed-by or Acked-by?
> 
> Sure, thanks for the fix:
> Acked-by: Ross Zwisler <zwisler@google.com>

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

