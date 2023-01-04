Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA365CB22
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 01:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjADA4G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 19:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjADAz4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 19:55:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B783FAE8
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 16:55:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF826155E
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 00:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844AFC433EF;
        Wed,  4 Jan 2023 00:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672793752;
        bh=K+3tvYJKdwOjUIrtNexq8bhr7gH7CwW0RikRcCmP+Ls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UWB9pZIEwAXSb7TuBHqxf+qOK5Ryl5pTMzYPhnKnlO3zVtspwQst0Syo3j8wKNrGX
         SesX1t+EMtLiaBHfzowbVuBrE3JhEERuiz27JGSm2xOWybdr/nNRLLxwvh9bcra+AK
         43FsM4mvss3Q82ECl/x4oycDiT2ZlDADVq6t5quR17TdHQkqN+2NwwoUQbWV1qrgev
         fJxrqDxEw4KbvZYi9S5gJEQu2kc3iC00W1539cAQMXWOGGorT26jxfpVgitP8ayylZ
         gtuGoJXNxzv5dvvNwG00NAT8Zp2yFRSmCNGVWR6toshsjnzmjz5zguKplISF+LDmH+
         XRm5ebUTYnaCQ==
Date:   Tue, 3 Jan 2023 16:55:50 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <20230103165550.56bf9717@kernel.org>
In-Reply-To: <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
References: <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
        <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
        <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
        <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
        <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
        <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
        <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
        <Y68wP/MQHOhUy2EY@maniforge.lan>
        <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
        <Y69RZeEvP2dXO7to@maniforge.lan>
        <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 30 Dec 2022 16:42:13 -0800 Alexei Starovoitov wrote:
> iirc Martin and Kuba had concerns about bits of dynptr(skb | xdp) too.

FWIW yes, I withdrew my objections because Joanne showed me some changes
which reduced LOC in user space even with the limited functionality.
But dynptrs are not the efficient skb/xdp buf abstraction I was hoping
for :(
