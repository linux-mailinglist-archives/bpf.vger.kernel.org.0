Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219A0628AB1
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 21:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiKNUpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 15:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbiKNUp2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 15:45:28 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521760CD
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 12:45:28 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id j6so8514490qvn.12
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 12:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TUwKHRYK0ZG7ZgA3acGxt/xOF3M5aPiHgNvK4K3ic3c=;
        b=7LuqZO4Ew6q0JLCrGJ4RxwGWrFy04wH2lHhzgHKNjUB5lmOHNcpIZxOdWBByCSP0Jb
         kv6GwcnIgg1eFF8WOpdYTY5XN6BnUScUyhtQNxiGTijCMwlofnx0i5/LCSr2yjE5pNys
         Jb3TZpS1u0QEMddWuBKcLj/YBzuK5K2V0iiCdSs01AINzguU9wczECrkK0tc52W+IPdA
         FxOfpPXL6nZ7C6pKALde4DWot2xPmuxS6K/DG876eoorTNRVBMIpNg44irOuj7CHr1U/
         ZeTC98JM2wXMgNh0jh6vq04sM+QQc6QJ/MFbFBvpp3++jggb9rLbAMplhJUExHBbNHly
         Rx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUwKHRYK0ZG7ZgA3acGxt/xOF3M5aPiHgNvK4K3ic3c=;
        b=D8tQjWhddDHP13nFFhfSt/2sRvn/RjSSEV2Ph1udP/ytGsZztC5d3L6U5q4rawiAu+
         jb9yYSaDCvCmWMR18XRIlwUBX9hAb/OoiSaZhePP37Co4/V6e2TUKIzct0iwrLw46YQF
         WUZw3dQ//Hv8PtKxzbCTiGVgny+lz9CprsDOUAYliI7IBO0XS3C0r31bQK4LA4sw+z8D
         7SXLp4/8CK7x48fvmWDqBb2kFKxdrh2a2RutMzyqzAJpy635Ffp5RS0PEriSjs6aTPnV
         2j0LqE52Xr4Dt9sXbqpZeGlVlwjgZx+mufgRRx2JSya+VNgtIy3EhVXf2GQjU/TWWgBG
         CbCw==
X-Gm-Message-State: ANoB5plOhOLaEqXK+I6N6PcpZwe1ICWcSmtmMP0WY22nqmbsedAvShNB
        AIX4vNqz9gqAnGbURahiX67p+Xf8Fvi9R+WQZ4Sr4Q==
X-Google-Smtp-Source: AA0mqf6ThKbg4i9U/XgGipXb5NTpSFAnHTW1JEAoobiWhBx5c0Bg4pMFt6P30L3+xtr/EP1oIeHk0oPB1Tgg/n5husY=
X-Received: by 2002:a05:6214:5c87:b0:4af:af9d:fdc9 with SMTP id
 lj7-20020a0562145c8700b004afaf9dfdc9mr14101807qvb.60.1668458727306; Mon, 14
 Nov 2022 12:45:27 -0800 (PST)
MIME-Version: 1.0
References: <1668396484-4596-1-git-send-email-yangtiezhu@loongson.cn>
 <1668396484-4596-2-git-send-email-yangtiezhu@loongson.cn> <Y3J6AXOFcoGg7p8/@google.com>
In-Reply-To: <Y3J6AXOFcoGg7p8/@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Mon, 14 Nov 2022 20:45:16 +0000
Message-ID: <CACdoK4LXDmN9L4we00017vs+HkFCgucHYf0kLEWCDSxFF9tqBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Use strcmp() instead of is_prefix()
 to check parameters
To:     sdf@google.com
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 14 Nov 2022 at 17:25, <sdf@google.com> wrote:
>
> On 11/14, Tiezhu Yang wrote:
> > In the current code, the parameters check of bpftool seems not correct,
> > for example, "bpftool batch file FILE" is the expected command format,
> > but "bpftool b f FILE" is recognized as valid, so use strcmp() instead
> > of is_prefix() to check parameters.
>
> That's by design and is similar to what iproute2 commands are doing.

Agreed with Stanislav, all bpftool commands support argument prefixing
and it's helpful, I see no reason to remove it for the batch command.
But thanks anyway for reporting
