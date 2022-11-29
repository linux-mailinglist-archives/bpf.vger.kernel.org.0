Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C011963C535
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 17:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiK2QcM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 11:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiK2QcL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 11:32:11 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE8D69315
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 08:32:10 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3c090251d59so88726387b3.4
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 08:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pos9CLsNDOLwN1KlKKwyHJD/9mCUMrOJkN3cfz/UVC4=;
        b=EhAD6liTlzMfpa89rt0L+8dsVrC5xnKIADVCwuHQ84XIKLp73fqXZae5ZVXydCT8T/
         YfC55X4j72RVeQKDO+K5FDmfX9Oo1oj1cTaMQwxCWzsT4xarXHzR6ODvMe6O2cOu5kgB
         gQ7+gS2G5okwRLHhdCjV6XkGXHJ85nsUXfMU3X7gotfpRMawDkFTkj8VHpDtPUS/89w8
         18hl0aPY2hpLwWONMphukjnJUvu09q8/ngfUTzq6rL+iqqQRTOJrMgrY8NAqEyT6uGwz
         6Xydkccowvp8C11NJ2wAk73FcquPGcYJbIWQWAqhi3RkXnbd3XdtzUKhCDXGTw6SC+Qe
         bKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pos9CLsNDOLwN1KlKKwyHJD/9mCUMrOJkN3cfz/UVC4=;
        b=buJgR05bmDYva+VuJ46cB3v+9iOj8NHZVVBqZ7zrptjgMCZz5xpcV+712lI0jwaXRZ
         pTPywwidP9JAPsf3UD6gAMHbWOWEyAUxV7QqFkmwqEZscjJLif3nYXXZaadho4EVNKF6
         H2WHzmcZk/7fAbL1tue8nCSk4/9fiy9Rt1NOnMzNjxeUBixURLXF6gxZ3YRT8qWg0B27
         YmAY7CmT9Jh3Gg+g8bjJYjIB7fwrUs0t8mktdpeA284P3IZe8cE6YVZU1Aj8EHPXqbuc
         39C/4Il7vhWHWLZoxcfk7J/h0/rmpiDn7tzlxODNrTwx+K8GtVUEoysmn5y6b1J/QZCv
         LxyA==
X-Gm-Message-State: ANoB5pn8EeYXZOlkgtuARpbdNwEhc7++B4y7dSidJQxvAgMG5OF31n8C
        jU1y0Hy0RhDGjWz+A86YOJ/FEjA3qT4jldLfmHtt96wvGUKR7To7
X-Google-Smtp-Source: AA0mqf44EYqAqdHoqLv769M54UVrIYx4kmzzVIxUbWjZcsGRJoOJZPBOD8Ui3vJ9/DOs8NIBz3x+bWgZs6BC066ldQg=
X-Received: by 2002:a05:690c:91:b0:392:1434:c329 with SMTP id
 be17-20020a05690c009100b003921434c329mr37265953ywb.72.1669739529108; Tue, 29
 Nov 2022 08:32:09 -0800 (PST)
MIME-Version: 1.0
References: <CAC=wTOhBfH8GA4t=DspjK4GdBAS3ezNBxzz5RWsFmGavkpz3nA@mail.gmail.com>
In-Reply-To: <CAC=wTOhBfH8GA4t=DspjK4GdBAS3ezNBxzz5RWsFmGavkpz3nA@mail.gmail.com>
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Tue, 29 Nov 2022 16:31:58 +0000
Message-ID: <CAC=wTOiPd+RQdQd2f6yfWyrGfaGHakOimtrhYnj+WrpuAZjAFw@mail.gmail.com>
Subject: Re: Investigating network performance when eBPF is in use
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I found the problem. When I added the tun0 interface to the bridge,
performance increased to more than 10000 TCP_CRR round trips per
second.

I needed to create tun0 in the root namespace, add it to the bridge,
and then move it to the namespace where it would be used.
ip link set tun0 master br0
ip link set dev tun0 netns ns2

Chris Ward, IBM

On Mon, 28 Nov 2022 at 16:47, Chris Ward <tjcw01@gmail.com> wrote:
>
> I have a test case which shows unexpectedly poor performance for one
> scenario (TCP_CRR netperf test between 2 namespaces on 1 machine).
> This test case delivers under 1 round-trip per second, where it should
> be delivering more than 10000 round-trips per second.
> I have tried disabling Nagle, but that does not increase the observed rate.
>
> Are there any tools I should be using to investigate what is happening
> ? Or does anyone on this lisk know what is going on and how to fix it
> ?
>
> My test case is available here
> https://github.com/tjcw/bpf-examples/tree/tjcw-integration-1.2/AF_XDP-filter/netperf-namespace
> if anyone wants to try repeating my results.
>
> Chris Ward, IBM
