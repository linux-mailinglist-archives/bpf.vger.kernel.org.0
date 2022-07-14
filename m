Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02E45740DF
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 03:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiGNBND (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 21:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiGNBNB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 21:13:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D0A2019B;
        Wed, 13 Jul 2022 18:13:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so895354pjf.2;
        Wed, 13 Jul 2022 18:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qY/L3esgP/6wlVOByUaM8eY0CWOL//SIEpk6GRGXg9Y=;
        b=OZ4VnFWsd7Gf9jtquuwL4gdatAZcRgoISs4e26darmOLhenPYwMMHtgnS0g/qv/K0U
         kvspN2qPnS5NhAiKRkT6TI5fZp/nWgP1GHG71qk55PP870YzbUcGgEV18Tg6cktJHCmu
         JNZOrLbqJQbFoUong7efgK/kpv1qgcr1zVJKuXWa5WqlVRxd7lXUijT8lnYlNUpn+EKY
         JB3nM3C6sft9Jj6Shq9jpZ3h5qPd1nsIh+0VcYxdfGK6O6UDdKy769ZWpDr0veIoAeDD
         NWsGY3yACeTvEFuSyHf/nE4jRpKxdvzRKQi/XuhYWaas6goMr9r4fanq+WtC8h580Awi
         60kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qY/L3esgP/6wlVOByUaM8eY0CWOL//SIEpk6GRGXg9Y=;
        b=GEde9C7lNlJQqFsm0JnlZBoWIgGheoJnxZ85XuWhz3wAoFpduWUjsSnJB0Ke5hssrQ
         xbWGLZrbnwLXushOgBptouhqyq57Sx1idd5SrYAJq2isi4h/Fg+j0fAoMA0mJpb4wq3S
         A8+RERLh9SDA33zo4QXQx7ggqE9coQvvuSScUCVhHBQYai/n74oPSQo+UApufo26+F+Y
         nevwweRqfFp1saCEgN9+ofqqzt38X24aOdt8tF7BhLJmtR/Bjekve3dsNYezfGCBLxrx
         3QpQiK6JgXUjrq/UHOu49f2h+EhXqrLju8t54h7Mwt+lIEeIj4IuL9lk+Spoy49jFycw
         Gbaw==
X-Gm-Message-State: AJIora+CMj4/ingYQxQL2zAxFGRE0lTVJED6L5/TSANY/GhGyuv7N5Bj
        itSDYMRqigJkwMM8lQa3bb7LonPFYLw=
X-Google-Smtp-Source: AGRyM1siopMFPWzPD/3Ra9FhjM1HPHnzCgZj4EIkYv6grSpPZAOU1k/m0GssqkjkbQvZUcYRBaambg==
X-Received: by 2002:a17:90a:f0c8:b0:1f0:671b:f594 with SMTP id fa8-20020a17090af0c800b001f0671bf594mr11675122pjb.238.1657761180515;
        Wed, 13 Jul 2022 18:13:00 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b0016a565f3f34sm57311plg.168.2022.07.13.18.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 18:12:59 -0700 (PDT)
Message-ID: <99351eee-17b4-66e0-1b9e-7f798756780a@gmail.com>
Date:   Thu, 14 Jul 2022 08:12:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] bpf, docs: document BPF_MAP_TYPE_HASH and variants
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>
References: <20220713211612.84782-1-donald.hunter@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220713211612.84782-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/14/22 04:16, Donald Hunter wrote:
> This commit adds documentation for BPF_MAP_TYPE_HASH including kernel
> version introduced, usage and examples. It also documents
> BPF_MAP_TYPE_PERCPU_HASH, BPF_MAP_TYPE_LRU_HASH and
> BPF_MAP_TYPE_LRU_PERCPU_HASH which are similar.
> 

Please, please use imperative mood instead for patch description
(that is, better write like "document BPF_MAP_TYPE_* types").

-- 
An old man doll... just what I always wanted! - Clara
