Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C315710D5
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 05:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiGLD14 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 23:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiGLD1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 23:27:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A017AB5
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 20:27:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g1so8458196edb.12
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 20:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FXMPCLcOgGQ5vhUcJdqrEPftuNKdLTpeMPhLjKlrPFM=;
        b=c61cDJe8VOst9yG1KQc0tiIsF1aBHqOHMTvBhIjiKgPJUPZMUpxTLAL2hqkvg3gfQe
         WV+11gQkgo9QRWKigmBlfvT89llHpweHLfOLffvqfiENlH9Tx7NhHo/bDAcmBmRvXMrN
         kD4LkKknVOqY4qg6V+oFwpoVByjteufHjJk8QsSVhlm4SdEAOeFy5zcNTojRqHjyP8TY
         S36/t6Lu1P2jLZkCBsa/rhAiS/fZcnQGvu4izYW2+FN3YeyG9gPUsKx+yQbMk3jNxC7S
         VcU2jAPnX4tC5y6ZC7jcOtmTjClLT41W8NQ6jdbpLIHTpLCJw0q20V/lS3yeIB8BAA5F
         46+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FXMPCLcOgGQ5vhUcJdqrEPftuNKdLTpeMPhLjKlrPFM=;
        b=dqQ3x/qy3MXYV0QLjicBqPNyiVcbjrJMgV7xC7e43SvOVywfN7cqCVJmOgST3sHm5q
         bBmbk7TrHqLlkClDdPvlgbcMx8mdiVk0BRWzmL8rLiVVwut4+QfZc3upCdhdhVLDy/cr
         WmQIVD+HZh0McjKYCWTJceMmwETYswY56BeO9IFE9iGHsb7kjkIVcCJgmCIm4BWPXAu9
         F/bh3uLUTCwdeCN9d/tdOazxRYFmncCEpiMNBgi9KNdPqj6R6KoXLny3fWrCO/sMombd
         dIAavS/DHTYvG/GfuqoK2jj7o/aO/njd/ZYaO38/c5OShJy8002V/QfWUrMS/RjSqRLV
         vEKQ==
X-Gm-Message-State: AJIora+o9tSLYe53r7WFoSZKigHeXuYbcpatAAdoPVX51vuZuMWXw3jJ
        rnHO4raTkfbaCxakLpjfSMQ6V6FlAuR3NQYnucMUhharhdM=
X-Google-Smtp-Source: AGRyM1urO70n1W2UjmALpeDZ3w6p+hEQSw7zbhexbu4BExE6UBjV0r9+iwVBv9CD9/IzbdKx5QyLgKQaHrcSS1090dc=
X-Received: by 2002:a05:6402:c92:b0:43a:7177:5be7 with SMTP id
 cm18-20020a0564020c9200b0043a71775be7mr29103264edb.224.1657596469526; Mon, 11
 Jul 2022 20:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <OBzRUbPFxraCqyqKJG4wxt16KtWfSZuzR1_huzK30nTPOyc2_oKjBYylXc9fr0CL_oOi0SbH8P67jujAXcI8rMT_wZQwfcAblzuteWLv5fg=@pm.me>
In-Reply-To: <OBzRUbPFxraCqyqKJG4wxt16KtWfSZuzR1_huzK30nTPOyc2_oKjBYylXc9fr0CL_oOi0SbH8P67jujAXcI8rMT_wZQwfcAblzuteWLv5fg=@pm.me>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Jul 2022 20:27:38 -0700
Message-ID: <CAEf4Bzb=-gRPao8cTj3iJs0fGaXT_F1AzYNn8A5apuHCGZJPpw@mail.gmail.com>
Subject: Re: What happens to a uprobe if it links to a library within a
 container, and that container gets deleted?
To:     Yadunandan Pillai <thesw4rm@pm.me>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 7, 2022 at 12:05 PM Yadunandan Pillai <thesw4rm@pm.me> wrote:
>
> How are uprobes "remembered" in the kernel from a conceptual standpoint? =
Where is the attach point stored? Is it basically a hashmap with JMP instru=
ctions for each function that is being attached to? What exactly does the c=
leanup process look like if the attach point disappears?
>
> Example of a use case: let's say a uprobe is to "SSL_read" in /proc/[root=
_pid]/root/.../libssl.so where [root_pid] is the root process of a containe=
r. If the container dies, then does that uprobe hang around attaching to em=
pty air or gets deleted as well?

In BPF world, uprobe is a combination of two objects, each having
their FD and associated lifetimes:
  - perf_event_open() syscall creates perf_event kernel object that
represents uprobe itself (you specify target binary, which kernel
resolves into inode internally; optionally you also specify PID
filter, so uprobe can be triggered only for specific process or for
all processes that run code from specified binary);
  - uprobe BPF program attached to perf_event object; this attachment
(link) also has associated FD (for older kernels you'll have only
perf_event FD, though);

As long as at least one of those FDs are not closed, your uprobe+BPF
program will be active. They might not be triggered ever because file
was deleted from file system (I think file's inode will be kept around
until perf_event is destroyed, but I haven't checked the code).

So direct answer to your last question depends on what happens with
perf_event that was created during attachment. If its FD survives the
container (because you transferred FD, or the process is outside of
container, or you pinned BPF link representing that attachment), then
no, uprobe is still there. But if the process that attached BPF
program exits and nothing else keeps FD alive, then BPF program and
perf_event will be detached and destroyed.

>
> Yadunandan Pillai
