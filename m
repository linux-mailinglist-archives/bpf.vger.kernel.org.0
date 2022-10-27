Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20676105C1
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 00:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiJ0W3K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 18:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiJ0W3J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 18:29:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E395AB18D0
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:29:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36ab1ae386bso27264317b3.16
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6W0G9AZ2KwMH/ft7R9NsK9JSlp8JARS3nVtt2ly/rs=;
        b=YrhEnrpEwMGNdVFBWt6DirqokyyXKireLgbgY2V/O1LUvxJ6PM6OhMRY/MI6uJ/5IO
         zgvQF5r5I6yykg5WYZkFxPR46zKsz6ZPBpp3Bj4ZmTCZe9/9lnCJjQiS7ccYMnosZkfO
         Kv9LQzLxwkfLIvOevJb1iwoDZqCn5aiqW26qzbtPVE4VcMb7NbWLAhAJ8BzzNQtbenA7
         i06IE1acMo6Dmz07yCB2Bi/sqgUngBHEDpEW1Y1MpI04+xxLsOGT6cD416cwUWv/1aSq
         pIwp1SAswrsgg4bwvOHtDYTXXjF2qANyelKDAuKx8gpZ9qzAom4wN1hmFcCYh3kSeqU9
         kmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6W0G9AZ2KwMH/ft7R9NsK9JSlp8JARS3nVtt2ly/rs=;
        b=CKH9ckaM8GK7oOkM7N+IJ0WC/gB4VGFRuaKoiqXkmu/g13lFQpCMmcrtfuaiYq03wY
         tzpRWwMP6WCdW4SYc16lixbB8KJELkTnpSq7furSRwasPvYaBb51VqsB+njRWdCdbiP4
         8zTB9Q1z35OPuFUEpyuVH81SK+J6qGJRqOigwMPOT3akKdk96BfAh0of5bQrz29x3l61
         KgzQz+eCyDOnlRRi9CBY4nJ47mxphzn9v5H1qcCSnHRLY2cdAYXL7ge865HBA8ZdPgAq
         ztagHJxr0GnJffPBmqK+ld93ZJQuTf3qKvQvjRVJJfXo/MyEGr4eYZu4m3FuAyHJb0xB
         ej3A==
X-Gm-Message-State: ACrzQf1CdVpKkV3WJW5PstzAqJRoalzcr5Lg/1IXjgq7RYzUaXJ9sZq4
        4XbT7569IN5u2PzzcsVfqa30d+g=
X-Google-Smtp-Source: AMsMyM4PA1Nz1TzqsQ3GgTPj3aprJpvMjHJfBJ5R0mFP4U/5QlbwBm2E9Hlf2nJgWoobEurAWbCKc6U=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:d211:0:b0:6cb:abdb:21f0 with SMTP id
 j17-20020a25d211000000b006cbabdb21f0mr9386285ybg.215.1666909711156; Thu, 27
 Oct 2022 15:28:31 -0700 (PDT)
Date:   Thu, 27 Oct 2022 15:28:29 -0700
In-Reply-To: <20221027143914.1928-1-dthaler1968@googlemail.com>
Mime-Version: 1.0
References: <20221027143914.1928-1-dthaler1968@googlemail.com>
Message-ID: <Y1sGDYGV34A5EfPK@google.com>
Subject: Re: [PATCH 1/4] bpf, docs: Add note about type convention
From:   sdf@google.com
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/27, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>

> Add note about type convention

> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

For the series:
Acked-by: Stanislav Fomichev <sdf@google.com>

Carry-on from my shift last week.

> ---
>   Documentation/bpf/instruction-set.rst | 7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/Documentation/bpf/instruction-set.rst  
> b/Documentation/bpf/instruction-set.rst
> index 5d798437d..bed6d33fc 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -7,6 +7,11 @@ eBPF Instruction Set Specification, v1.0

>   This document specifies version 1.0 of the eBPF instruction set.

> +Documentation conventions
> +=========================
> +
> +For brevity, this document uses the type notion "u64", "u32", etc.
> +to mean an unsigned integer whose width is the specified number of bits.

>   Registers and calling convention
>   ================================
> @@ -116,6 +121,8 @@ BPF_END   0xd0   byte swap operations (see `Byte swap  
> instructions`_ below)

>     dst_reg = (u32) dst_reg + (u32) src_reg;

> +where '(u32)' indicates truncation to 32 bits.
> +
>   ``BPF_ADD | BPF_X | BPF_ALU64`` means::

>     dst_reg = dst_reg + src_reg
> --
> 2.33.4

