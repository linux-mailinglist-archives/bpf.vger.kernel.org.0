Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88652F66C
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 01:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbiETX5z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 19:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiETX5y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 19:57:54 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB8A1A0ADC
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:57:53 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 2so458837iou.5
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpuih7eD25YoaQgoLTJ1wM4vKXDRK+qjLExm0GvIyjw=;
        b=E57J/zm47SygoqB1IVqnk7yPsB9njvpFSgxWyk0YjU07bDMLf+H9OJVWvvNKrM3gj8
         5odTxHXu9uokgRwqiltMPe1UXkWsMQ5AAEMlMyhdaVs40Rd7H394KhXX+PmkXE251J+M
         R+JEHlDurvCJP71gMcgf10zlX8lgukZde0RVShYdffHeK4QkwuwdSl5I0aX95kDtgIwk
         vlAeb9MZgmNzZrsWX5lrxF5RC7F2gQeZZL/mPgUSd2PTZjl5YIUelY7O7dz2akEOJFim
         qlyhI4FO2fyMuwEj5yeL6xaZ9FC3jIbCq7+LthJUShPyixRaYWjcTpUWP0hzHefJxw89
         q25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpuih7eD25YoaQgoLTJ1wM4vKXDRK+qjLExm0GvIyjw=;
        b=2Jpm2hgRDO9/FunkyUBnkeMSo74h8wYO9/qCAQy7HW+g6+TMGMVauCMRRCuAUbTv0S
         ITOCQND+JVqHEV0W+CDS4yLInZ1LpB/rtb3JeiputGIBlgm72mwTAPpap87RYfQDx6o5
         yIY5Pg9Vimz8A2iOUtaTo79Rle58OYxHcsGeIT9+IzpFPVI96yDU+hkvlvXNDZizsJkf
         OR3YeYG1BPng80R4yLp/eZDADpCaHbkOPkq3+sXfkrjanKPjOCkHqXkeUbMTqUxh5kJy
         ef/p4rZJ3VvUa3DhTXr9fxoU0aNIQD7pdUXvYQC/NCQXNXS9mEKjAJ7kuPdHYV3BRQC7
         RghA==
X-Gm-Message-State: AOAM532Pb8VVzr9zER2O+L5y5HVnPuwNR6PjcJZfqWboP3Fs+5+q8Ytl
        PEatXIrGuVdhuBKle4hVD1fSM/msw4YdMn/3cIrTE/M1wjc=
X-Google-Smtp-Source: ABdhPJx1+BCASC+BuZlsob2+AUZEok6xsrdlsNlIx5s73E+OIHCyA8sEdE6toFjDIkgkEgQUck+KqB9c8s8eIrbHwEw=
X-Received: by 2002:a05:6602:2acd:b0:65a:9f9d:23dc with SMTP id
 m13-20020a0566022acd00b0065a9f9d23dcmr5875903iov.154.1653091072864; Fri, 20
 May 2022 16:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2xA+K-yby7m+3Hp1G6qinafZPW1OB=Uk5-AKxUfztBtEA@mail.gmail.com>
In-Reply-To: <CAK3+h2xA+K-yby7m+3Hp1G6qinafZPW1OB=Uk5-AKxUfztBtEA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 May 2022 16:57:41 -0700
Message-ID: <CAEf4Bzbtj5UnkhHEiVxgbVByCoqiCp5zm_vSBq=+LFKVsLcCLg@mail.gmail.com>
Subject: Re: libbpf: failed to load program 'vxlan_get_tunnel_src'
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 19, 2022 at 11:14 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> Hi,
>
> Here is my step to run bpf selftest on Ubuntu 20.04.2 LTS
>
> git clone https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> cd bpf-next; cp /boot/config-5.10.0-051000-generic .config; yes "" |
> make oldconfig; make bzImage; make modules; cd
> tools/testing/selftests/bpf/; make
>
> then below, am I missing something in kernel config to cause "libbpf:
> failed to load program 'vxlan_get_tunnel_src'"
>
> ./test_progs -a tunnel
>

  > invalid func unknown#177

Yes, you are missing bpf_trace_vprintk() (that's helper #177), which
is called through log_err() -> bpf_printk() -> bpf_trace_vprintk().
Either use recent enough kernel or remove log_err() statements.



[...]
