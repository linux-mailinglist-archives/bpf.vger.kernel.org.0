Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28AA6A20F1
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBXR52 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 12:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjBXR51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 12:57:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A17B1ACC0
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 09:57:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id d30so539238eda.4
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 09:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jpb3d5mk2MPENp6BXfHfp8dICD1UdZ4ajxkAbbiXz9Y=;
        b=jZmKOAjvsxcCeZcRp54ZL+qN/G5yBVTptMC5N5LJ9HVbllFVOHrOMKM/tI2zOXjT53
         ar7s+TzJ6xWmKx8UcEwKHHVO0jXXQTtQdR2Bj5DXGaun9s8ij6/tDfWgvZvQaaqGj0ql
         2WaPGBG0GRHAEoOYVV/CAe/pMCfuep6WGGeQMkV+okQ8xIvUQrjck/cNd7HuQsUZ96eO
         b32JU9iquHh97VJ68uf0ZsBCc7kmwDwk3k65bSu+j6IvhwuCy7gacTlm+KLYpC1dgNaM
         WpIJzX6ZcC3mDeEYzp355IH5yXLnHKJ0Oa6US3O8rEEAte7FwVtknsv0A6SgF1M2gvAM
         gKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpb3d5mk2MPENp6BXfHfp8dICD1UdZ4ajxkAbbiXz9Y=;
        b=l09KXa+IaEaJieOswkbK/BY626ngux71XV37ipScsrbcHvy06E5Wcuevu6sn4SRESp
         +pIo/ccwgkhNP8Zc+oA00glVYiTFe/vpieqeLDUDQJ+CdCWxy+JhNh1XPJN7i0s2NUDB
         sMCx1hRj862hb0u1U5nnwVU42mNa2ypXiHA1d9OorCOPght3ZTYykEWdJ8dNLCkAM4s4
         bvqQAYouonB7iurEgJ9qVSBjoCfKAXzuC49STEYxD1693KHG+admBdVhxwpgtA06wmZ0
         +2qRBYte21//J1VMWwBXzJvNW0/RxnGE75jTj2zGbWjxBup2Ta9fXPIHWJsvC2bF3Sxc
         8cCg==
X-Gm-Message-State: AO0yUKUcwovCUwX/Q+rJnYq0G0wfLdBi+57KOc8FvDGsWPwV8IY1jVBy
        Bykv9/STnucnwXl6XrjVzAUAg7YWRwCTGWzaSlE=
X-Google-Smtp-Source: AK7set/6PYbJ0GDD6L5dQh3251wGbCA8K4NwUNOe8e1RETu/n3lPv5BngVjeDgMsC8LlTAyxEZP2nTUmIdJkm8HUErI=
X-Received: by 2002:a05:6402:2811:b0:4af:70a5:5674 with SMTP id
 h17-20020a056402281100b004af70a55674mr499518ede.0.1677261445419; Fri, 24 Feb
 2023 09:57:25 -0800 (PST)
MIME-Version: 1.0
References: <Y/iQjSidojkAkNxj@krava>
In-Reply-To: <Y/iQjSidojkAkNxj@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Feb 2023 09:57:13 -0800
Message-ID: <CAEf4BzZxFOkV6NEWBtQd40WjBTW0kOucea4gm-tLw7nnEX-X0g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] multi uprobe link
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        lorenz.bauer@isovalent.com, Daniel Borkmann <daniel@iogearbox.net>
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

On Fri, Feb 24, 2023 at 2:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> We have a usecase to monitor potentially many uprobes and current way of
> attaching many uprobes through perf takes long time. It's because there's
> extra perf event install/schedule for each uprobe you want to attach.
>
> It'd be great to have a another way to attach multiple uprobes probably by
> adding new uprobe_multi link, that would create system wide uprobes directly
> and attach bpf program to it.
>
> Although that would not solve all the performance issues with uprobes, it
> seems like a good start to solve attach/detach times.
>
> I'd be interested in other people's experiences with uprobes and ideas on
> speeding it up. The uprobe_multi link prototype should be done by that time,
> hopefully ;-)

Great! Looking forward to it! Certainly a very useful thing, also for
USDTs which could be inlined in lots of places, so one USDT attachment
is actually a multi-uprobe attachment, in general.

>
> thanks,
> jirka
