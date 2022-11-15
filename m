Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75993629F6E
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKOQp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiKOQpy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:45:54 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B26455
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:45:54 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p21so13674191plr.7
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gcs7e9k/h47CQc4VpgZuAmvpTTCy31XC3q5fKTJL+o=;
        b=oQxu9PqTKfJ4cxCA9YOMikj0A+F7VOuKhMQo0H8a6P59kXO4EUEj4KuIiQUe4mC6ly
         Mf1Z6Gz17G7K3zJ0fJBzU19LcNQ1TnrlOm7SfmJFQClerjXmnC2E04M0c0XH08DXHt4+
         HFN2JO17HuuNVA+4d0MOpoH8zht28qQIgoYbqaaJvn9ciSZG9v2Ntey3bezliqN7+O1Z
         INZbTtErHBanYtmdpHlPZ1knrC36gJe30jQYaRgZz0Cj2VDaG2YkkwX8NYm9JGFh6F6G
         5cpXtcvd8dUy1PnrEj+T6hnJoqBSszmKX9RPHUCStbG7NhHjZwjDA2yX1KAewLEx98k3
         5Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gcs7e9k/h47CQc4VpgZuAmvpTTCy31XC3q5fKTJL+o=;
        b=dXmsfsel32GXwbKzw7/7TGND1EktMSxqMjPPdOFV8qP4foUUJUfCI0bNzMyzsDXi3U
         OxooAViTfjw/eheJKzbBYbNLvotH1vzGH27CR6hf842u7sM9ulKFkGvCXcFL1/jmUygU
         HmsDYdIoo7TIPJmfD1kiEZ6BVbZez+ROhOvefjA6gLyKa9hRLHl31b4ZpVj5t1FwJUbg
         i5tjgD8HIRitz9ZBLoBDENxoNKOpis4uLuyOOUI7CtYT8fm/fdDh+MtI9Ipm5ZVqM9qP
         TkJ3Uz+rPJnhrHIHmNeUV5DXGj5V5W6uYqXw31jDpIikRjj8hhVtaTy8XVGeYQ2p111E
         UJig==
X-Gm-Message-State: ANoB5pnQLOz5PODjxLqoSMxYjl8d4If3Wzj5x+k7+gmrmM7UKV5gGhJe
        31zaPNvlPN1YRdGzADhA0vCmcmU1IJY=
X-Google-Smtp-Source: AA0mqf4xjsj3lSo3NcF2R8fP3CqoeZTNvpxiGdUuGXQ+K+S6VKA2uAzstrwZKQpwWAMTTQMVw1QGHw==
X-Received: by 2002:a17:902:d102:b0:186:9c32:79d9 with SMTP id w2-20020a170902d10200b001869c3279d9mr5121618plw.47.1668530753791;
        Tue, 15 Nov 2022 08:45:53 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b00186b945c0d1sm10137321plw.2.2022.11.15.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:45:53 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:15:48 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: [bug report] bpf: Refactor map->off_arr handling
Message-ID: <20221115164548.6tccxdbl54jyq5qv@apollo>
References: <Y3OOa77Sn6GnyLvB@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3OOa77Sn6GnyLvB@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 06:34:43PM IST, Dan Carpenter wrote:
> Hello Kumar Kartikeya Dwivedi,
>
> The patch f71b2f64177a: "bpf: Refactor map->off_arr handling" from
> Nov 4, 2022, leads to the following Smatch static checker warning:
>
> 	kernel/bpf/btf.c:3597 btf_parse_field_offs()
> 	warn: potential pointer math issue ('off' is a 32 bit pointer)
>
> kernel/bpf/btf.c
>     3580 struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec)
>     3581 {
>     3582         struct btf_field_offs *foffs;
>     3583         u32 i, *off;
>     3584         u8 *sz;
>     3585
>     3586         BUILD_BUG_ON(ARRAY_SIZE(foffs->field_off) != ARRAY_SIZE(foffs->field_sz));
>     3587         if (IS_ERR_OR_NULL(rec) || WARN_ON_ONCE(rec->cnt > sizeof(foffs->field_off)))
>                                                                     ^^^^^^^^^^^^^^^^^^^^^^^^
> s/sizeof/ARRAY_SIZE/
>

Thanks for the report, but this one I noticed already and fixed in:
2d577252579b ("bpf: Remove BPF_MAP_OFF_ARR_MAX")
