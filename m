Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F254C3CF5
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 05:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiBYEPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 23:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiBYEPB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 23:15:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AB92465F8
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 20:14:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82CA7B82B05
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 04:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBE2C340E8
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 04:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645762468;
        bh=KCK6IkRFagqTRBRvk5z5MMUq9jNkki0hxWdgnKNRdW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aNt0/toVTkoKbrb0cM302t77dXTvAEMzpZGVpR07k9mqmO4/k0g62aguKSnevKUWX
         yLYVUVK6rRrWPwDJyoklPjIdaEbGqjhkVCRkzzniumZpOYP24VWF5ahxmW4Vc2G/Vk
         DLIoTJunSJaCOxX6cIUQTc3ruWHg7e0NFY5K+Uu+W0/nzgaRI9vwsTz6wtUTQt1+0k
         NXUJyoI2vt/MCji2m59WZyFFIGdG9vdSu1OHJjK5T1B8Lb9Lpsc2niyxelpC5KlQa+
         gBW/lCv5IRukkyClYt5l/IAzp/59THME1X1nFJJW2ABUgFLTOVyYncVV6fscSs9hrH
         lwVd47Gb5DAlw==
Received: by mail-yb1-f177.google.com with SMTP id bt13so3557204ybb.2
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 20:14:27 -0800 (PST)
X-Gm-Message-State: AOAM532PR6163MgMT9C1IBSOZTuZjjXTsbz7WyxXc9I78GB5GMo596T2
        xcmlgF6fkovZungAvphCGEhd0bcMA9Gyyjfxu5U=
X-Google-Smtp-Source: ABdhPJwbyElFqnpDE7HJYUYcr/YVd8ZNCvJaPCxhdIut8ym4/hd1n1VgQ5UhesKfzvY+HIvg27a5gdb7TYwbnYtJLcI=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr5376901ybn.259.1645762466995; Thu, 24
 Feb 2022 20:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20220224214928.826717-1-fallentree@fb.com>
In-Reply-To: <20220224214928.826717-1-fallentree@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 24 Feb 2022 20:14:16 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5ioJBrPKbmSP4q14s9JNNjP3FaAXshy-vTUJ8Ct8461g@mail.gmail.com>
Message-ID: <CAPhsuW5ioJBrPKbmSP4q14s9JNNjP3FaAXshy-vTUJ8Ct8461g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix issue with bpf preload module taking
 over stdout/stdin of kernel.
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 24, 2022 at 1:49 PM Yucong Sun <fallentree@fb.com> wrote:
>
[...]

> In this patch:
>   - skel_closenz was changed to skel_closenez to correctly handle
>     FD=0 case.

Btw, what does closenez mean? Should it be closegez (great or equal to
zero)?

Also, fix Andrii's email address.

>   - various places detecting FD > 0 was changed to FD >= 0.
>   - Call iterators_skel__detach() funciton to release FDs after links
>   are obtained.
>
> 1: https://github.com/kernel-patches/bpf/commit/cb80ddc67152e72f28ff6ea8517acdf875d7381d
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
