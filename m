Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74D6669E51
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjAMQi4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 11:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjAMQid (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 11:38:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EF5669B0
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 08:35:51 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id cf18so47189179ejb.5
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 08:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8LxwOtgMDea8fjbpceXtCfOwJXx+Kvb+Ltmt8EO5IYE=;
        b=k+M+yjaxDPZ2U+1hItv4D8UaKPSk0TA0elJoUuL8g43/ZAcLAH47It/MdslYtODp0/
         vAzmC9tunwsE6n8Cw92K60RpnHCERgRug/y3C4EgMQ92NN5D3y9PWfcVuoi5qomQBFQR
         TxY2XmeKZWJZEmvqbBV+nKW73RasW0EimZgc7Gy1FoYPHOAKdLZ+o3kBHqMzfojLD1va
         v2zLgXM0paCk4zU7C/Yw0D7KH5Pe6+JkA2e5QbVUTvGOYC7GrK3qDaTrKw+dN/fCpgTp
         GAlhyNefodN3MP4pFwIJtIXyjirQUKX7FNavUY0kdOWVniYSHtBao/JZE+gXgbvVTvU4
         +Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LxwOtgMDea8fjbpceXtCfOwJXx+Kvb+Ltmt8EO5IYE=;
        b=KwsOxma6drzE5q4ZqHPpxsdxxQJ+xN43PZ+ix6zuElu42pX6PAidefjLFoAxv0Uy5w
         o0blUh5IE/z6ADttoC0I/SZ+wYWoTpQl5AVJE/7mMfZaX/3hC0i8n7hxNUJNpt3lD7mB
         oTqQF1tBwD/P81pifpAie6flpDlRhmvOzY7D1OuxAKOhHtUiRdukPoCFWTdYkC++r0bP
         aWFuebZF4siLCRHSwsDCkL2rAkGgwQ+/9XqbaZ1pIqR9+DttiOA71d6rlWijP8/S8UJA
         cr7aQ2y+zAbrk/DAHy/seUOdDScUSzBKc87jO5rSATWRmK4W6QBajvqBNJc7fNFTCXAN
         Fj5g==
X-Gm-Message-State: AFqh2kqRxh0oljpHN/4e/PBhq+3lZDPxf7xd9/59tfBpdPS6jUX7wNlG
        vT68ObQ1UnsTyWG+2E0y3b57yrbxrV4uMGaUKlM=
X-Google-Smtp-Source: AMrXdXucHIceHQZeHNTFR0POkEIti1s65lrBC+gdOTouO3GOJF+b/PgTVf9HDM1l0N5YLV2JHFnXwkMct6S4ViFPbnI=
X-Received: by 2002:a17:907:3103:b0:864:dab4:760f with SMTP id
 wl3-20020a170907310300b00864dab4760fmr464596ejb.633.1673627750151; Fri, 13
 Jan 2023 08:35:50 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan> <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net> <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
 <Y78+iIqqpyufjWOv@mail.gmail.com> <CAADnVQ+b+XBukob0VAvxraUvXAf9zv8pa2R4QhRvjyULm9=zKA@mail.gmail.com>
 <87edryg3zy.fsf@oracle.com>
In-Reply-To: <87edryg3zy.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 13 Jan 2023 08:35:38 -0800
Message-ID: <CAADnVQ+05WrH4FTAy9E5W12H+KBxK0DFBeTzKcuXk_BGJx7nHQ@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        David Faust <david.faust@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 13, 2023 at 1:45 AM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> > iirc they had their own incompatible inline asm :(
> > It's a bigger issue.
>
> We are taking care of that, by adding support to the GNU assembler to
> also understand the pseudo-C syntax used by llvm.  This covers both .s
> files specified in the compilation line, and inline asm statements.
>
> Should be ready soon.

This is awesome! Thank you.
