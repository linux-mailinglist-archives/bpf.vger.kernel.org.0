Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCF058AD13
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiHEPhG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 11:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiHEPhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 11:37:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D918422B32
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 08:37:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p18so2942910plr.8
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FWkeNcL7xrNhKXm5tviXEub3CTo30zaz6QEhKgmLfno=;
        b=Wh4+prLAHHxtNt/IbJ+VyVqSm51adZ+EQvj6oPpvL1HZx51SroKApi7e692Ai9xh7d
         UVFYN1K85A6F6fEBraTZiwGZg7Wf1Wgui9y5U5sJy32U0lQJXRcllVWOt4aAWvD8H8AU
         VPWRRMnPNAsF//amIq1ynUm/5WKv/iBq9FS/Vx/nEQgiA6Y5LUJBbOPjcPceZlF5+Crs
         PaUqqziU5KyasVugbinDG/s559SOjJ/zegoGeL8wVKkH6Y0lgx+WTr13BrI9xhn4znzw
         3D4RTKEJfVNCzoxkS4SwmDMyqEYMBrakZ+SuCNZCJo9nu96E2YU5QzB8A48aX3arTI/G
         nwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FWkeNcL7xrNhKXm5tviXEub3CTo30zaz6QEhKgmLfno=;
        b=HWE+3VkT5plHO8h/XjI2k4iShbEVQhN6eB9BRVjq/DZa1qAXZYb9rQIFRBTFM0s2ks
         LeouMKjOxLbGm1mHdGMTFMnPz6kT7iV93+8N3qAPOITYgBxyrHliaXIxeQ0RYGCWRWCa
         BClMg7JZp8512Ox84bNC6EEmJ3iA9GI5kmZfIXBGduyygCy1OInsu8QeTyvMPDfZFAIA
         n+fcUK/ecbCHxBY+5/fUCW4fQU80XMQrvABtl+B6YduiOjN58aMee2305WaX7F/RXTJl
         V3Dzr+bET+nWMBC4JplBjndjasOdkxusj58fN56BD7gsGB4D4uiDBNISEJhdJrrkdsbR
         DwOQ==
X-Gm-Message-State: ACgBeo1vRGk6tSjOrYvS46gSxGa1giu6eDnmIaSUSvO6FjkN7+SFRxRu
        Q6N2VyVzh4OJcOyQBFG+tuulI9CfUpxbWnkBD+3IGpVdJa5fzGmg
X-Google-Smtp-Source: AA6agR69dts3gAGzr+osUP0+5TQ+fEbmA58vIEk4l2cPf9kpp1RApid3VkpS2EvXRQ4llJPXl5aAleIP6og7HfU2WTc=
X-Received: by 2002:a17:902:ce0e:b0:16c:7977:9d74 with SMTP id
 k14-20020a170902ce0e00b0016c79779d74mr7518939plg.92.1659713822191; Fri, 05
 Aug 2022 08:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000026328205e08cdbeb@google.com> <cover.1659676823.git.yin31149@gmail.com>
 <87fsib9e3y.fsf@cloudflare.com>
In-Reply-To: <87fsib9e3y.fsf@cloudflare.com>
From:   Hawkins Jiawei <yin31149@gmail.com>
Date:   Fri, 5 Aug 2022 23:36:50 +0800
Message-ID: <CAKrof1PcSg8PfwwG92qOsp=3sEHE4mTnb4fBtcCw60Mv9gp5zA@mail.gmail.com>
Subject: Re: [PATCH net v5 0/2] net: enhancements to sk_user_data field
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     syzbot+5f26f85569bd179c18ce@syzkaller.appspotmail.com,
        paskripkin@gmail.com, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        hawk <18801353760@163.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 5 Aug 2022 at 18:30, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> Thank you for the fix.
>
> For the series:
>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Thanks for your patience, it really helps me a lot!
