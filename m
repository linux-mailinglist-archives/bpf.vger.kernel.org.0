Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8301625FB2C
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 15:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgIGNPT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 09:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbgIGNOB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 09:14:01 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F8C061573
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 06:13:59 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b16so13906103ioj.4
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJxrp3jWjF7EJg6ivEph7Rvu/2Ib4g633vwVD85S0CQ=;
        b=02oi5gEY+CBYrcWzikAaaVf8WYKMnPAd7E+MRFN69aX1B1S66WDlgCdy0AQMWOcO9x
         dqsSr3LJl+8281YPFuv0mu1sxj3DeRM7cfC9tRkIuhksEamK9r1iaNHxPa2fqbWNdQgl
         jotLselURDHsgHXQTJIrV9nz/0vonv/HCPRf9mUh6CiSg/qXK52haPG9tjT/NHLoQ31u
         x701J289XrVryQ6QgGek4kOoVwg4sAXqUhRTadM1vYhws2Yqbw25M+GXXTs2Q2xGEqFW
         1Pi6LozXECFWw8n/jBF3NTT2dm5ekovFTf/PxhOEUNxoSWIGUnaEboPV79CmK6RvdYGa
         fgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJxrp3jWjF7EJg6ivEph7Rvu/2Ib4g633vwVD85S0CQ=;
        b=YNND831NO7AsQUJPVSvs7ddv8N9EaY7MnSsLfa6cR/HpqpjWr5DNLaHz5XYIfe4rfJ
         J0bkO5hSeDAKH1v45uT9VAbTy2x+YU5pDVoREtjW8On1w2u4TKDOeVwFYhRBrPNnuXtG
         cOlg4GRqA62NE0LfcYlrwLrcVvGueGsc502kBAKj8dxsCDgikpmQ62uU7WL0o9IKgqCT
         BpThAZfilaktpInu7SjB7vQT84BvrKLEkCCM00ILON43WDMK46tXcC5TzVrZ+B8BbsXt
         /w+qj4jy1l+4mqu1a8ZazHodKSh4ywVYSh2oUkFOLatcM3b6HImZ7Tvl/NvD7ncohsRR
         1Cpw==
X-Gm-Message-State: AOAM530Ic1J0PwH6/CcS9eXly/xwgQBun20EKVkHxrRipVSPM+HwzV67
        kUikH5oCOb77d5j2C34VzC7MR6AzU0TY3cOupPhCYg==
X-Google-Smtp-Source: ABdhPJyIsSU/kSggNluSNlIsOOH4fGatdNVfmgVY6hM+kLXuW21p8KPaq8g4xKYVeO73nxoI3pzlBQzTn43eWkOXZTI=
X-Received: by 2002:a02:840f:: with SMTP id k15mr19698228jah.100.1599484436760;
 Mon, 07 Sep 2020 06:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeTCaU1fEGVVWnXKR_zv4ZSoCrBGSN65-RpFuKg9Gf-_z6TOw@mail.gmail.com>
 <CAADnVQKsbbd9dbPYQqa5=QsRfLo07hEjr1rSC=5DfVpzUK7Ajw@mail.gmail.com>
In-Reply-To: <CAADnVQKsbbd9dbPYQqa5=QsRfLo07hEjr1rSC=5DfVpzUK7Ajw@mail.gmail.com>
From:   Borna Cafuk <borna.cafuk@sartura.hr>
Date:   Mon, 7 Sep 2020 15:13:45 +0200
Message-ID: <CAGeTCaWSSBJye72NCQW4N=XtsFx-rv-EEgTowTT3VEtus=pFtA@mail.gmail.com>
Subject: Re: HASH_OF_MAPS inner map allocation from BPF
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        kpsingh@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 5, 2020 at 12:47 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 4, 2020 at 7:57 AM Borna Cafuk <borna.cafuk@sartura.hr> wrote:
> >
> > Hello everyone,
> >
> > Judging by [0], the inner maps in BPF_MAP_TYPE_HASH_OF_MAPS can only be created
> > from the userspace. This seems quite limiting in regard to what can be done
> > with them.
> >
> > Are there any plans to allow for creating the inner maps from BPF programs?
> >
> > [0] https://stackoverflow.com/a/63391528
>
> Did you ask that question or your use case is different?
> Creating a new map for map_in_map from bpf prog can be implemented.
> bpf_map_update_elem() is doing memory allocation for map elements.
> In such a case calling this helper on map_in_map can, in theory, create a new
> inner map and insert it into the outer map.

No, it wasn't me who asked that question, but it seemed close enough to
my issue. My use case calls for modifying the syscount example from BCC[1].

The idea is to have an outer map where the keys are PIDs, and inner maps where
the keys are system call numbers. This would enable tracking the number of
syscalls made by each process and the makeup of those calls for all processes
simultaneously.

[1] https://github.com/iovisor/bcc/blob/master/libbpf-tools/syscount.bpf.c


>
> But if your use case it what stackoverflow says:
> "
> SEC("lsm/sb_alloc_security")
> int BPF_PROG(sb_alloc_security, struct super_block *sb) {
>     uuid_t key = sb->s_uuid; // use super block UUID as key to the outer_map
>     // If key does not exist in outer_map,
>     // create a new inner map and insert it
>     // into the outer_map with the key
> }
> "
> Then it would be more efficient, faster, easier to use if you could
> extend the kernel with per-sb local storage.
> We already have socket- and inode- local storage.
> Other kernel data structures will fit the same infra.
> You wouldn't need to hook into sb_alloc_security either.
> From other lsm hooks you'll ask for super_block-local_stoarge and scratch
> memory will be allocated on demand and automatically freed with sb.
