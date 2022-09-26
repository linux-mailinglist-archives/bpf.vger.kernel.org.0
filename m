Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A955E97B9
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 03:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIZBd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 21:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIZBd5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 21:33:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128F62E8;
        Sun, 25 Sep 2022 18:33:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so10946735pja.5;
        Sun, 25 Sep 2022 18:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5BhgllpUKS513O27OjXCjUDC/SjvmW7SHNp/AqojOpc=;
        b=b55YE2vzDxcbpX1Lp0e2mBOO/1PgxEeRvNOe8KIxYmL6YRc4se8Wi2TrxPVz86+KnG
         W60KlY8US9fKFD6P+srYYqY2SjZD5K+ruy7rOp1Dz3UL2PhWofQcfNqaxD7y2l2fJf3h
         o5xCd1aXi4kJeUZJl+8RYzfrBSeQfoMR+M34fAo9jALldQvQR9PtZ9fkMU6qKmUal+WR
         MSUGftXPCNJAq9WL23jxJSKZj0uZ2lk6Rg/QSVNOGsivPZwgWMGlz2bquQgbWYjgOmL7
         rCtMAfTh901SGwnAa9f4uf7t4cOHStOhM/OqPvbnFi6iqgsXRi9YKh8C4AUQ0uovaIMK
         itDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5BhgllpUKS513O27OjXCjUDC/SjvmW7SHNp/AqojOpc=;
        b=KATyIqd/rtGzbKV2n7tW7gcjcTyev1Udd4dgTjVpUUCQOpHsmQDoVnu5wSW0vH6Uqh
         jPN/J7Xix2gBQTBYOZqkktahjulPIRmj/a06R9dWc/hKgAfMR3LDXK5zcQXKqZiJo4aj
         MajV9wx1WMhXI2m31Kkf/VY6sGunJf6Uc2tEiLDqKU3SRKsIAWeUsc9BzxoDwqgczoto
         KoC0iN0rJxJXEhg4MQ5gvOTIW7+HeQIh4fBzDe+QSqDiz5FOB7cGH8O2rSuC5/qPyBpA
         72Y2fPNaDaLTO9D72C7xS3bbBhLb7WO1uuql3ZL1Wz79U362hoqRJR46wiSWqFPo0HPm
         998A==
X-Gm-Message-State: ACrzQf2qASqHzEv1XX3BKck+8coStyE3nORRwDGhWxr+8Pb17lV7Uuds
        Q4DFBbx9Em9Cqs70W9wXtcMBAmmTndA=
X-Google-Smtp-Source: AMsMyM5BvumaK3ApOMSdZDz6zQVdtPS4/6tQy5reN/HRjn2sZI0dHLAqYP6N/SbpEfpLX0ic5NpHqw==
X-Received: by 2002:a17:902:e805:b0:177:e8af:ba43 with SMTP id u5-20020a170902e80500b00177e8afba43mr20340156plg.171.1664156036017;
        Sun, 25 Sep 2022 18:33:56 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-77.three.co.id. [180.214.232.77])
        by smtp.gmail.com with ESMTPSA id s3-20020a17090a5d0300b001fbb6d73da5sm5422433pji.21.2022.09.25.18.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 18:33:55 -0700 (PDT)
Message-ID: <a6664802-dd91-0ec1-3cf9-8e6e4147ab6e@gmail.com>
Date:   Mon, 26 Sep 2022 08:33:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH bpf-next v4 2/2] Add table of BPF program types to libbpf
 docs
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20220922115257.99815-1-donald.hunter@gmail.com>
 <20220922115257.99815-3-donald.hunter@gmail.com> <Yy2zBAIFGGBMe4k1@debian.me>
 <m2czbm872w.fsf@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <m2czbm872w.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/23/22 22:05, Donald Hunter wrote:
>> The note above doesn't get rendered on htmldocs output, so I have applied
>> the fixup:
> 
> It was intended to be a comment to the reader of program_types.rst that
> this is the format of the .csv file that will be rendered. It was not
> meant to be a note on the rendered page.
> 
> The rendered page will show the table that is produced by the csv-table
> directive which is self explanatory.
> 

AFAIK, I don't see any disclaimer for that table...

-- 
An old man doll... just what I always wanted! - Clara
