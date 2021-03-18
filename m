Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE7340A6F
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 17:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhCRQnf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 12:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232187AbhCRQnS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Mar 2021 12:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616085797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xMH16K1Vk3sQr9cJFMbSFsVVc6ukC0diu3TY4hvT3V8=;
        b=BleXR+onDitSRp7W3y4aYv4eKtThH0a9ejIPGiSKSD9cDzLyxUNcSkAWyP4TWg1hEtEVtY
        rOMy/HCuX8hH20vauuGmr2tsY5dNBYr+lrBppgEor5Oz/ncHXZ0y+4g6jEt44CHoXRYFlv
        nmK3fX4DTlhH4sQDnx1mytzwEen2lgU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561--ST7-ivaMmCqUVH1qgEvOg-1; Thu, 18 Mar 2021 12:43:15 -0400
X-MC-Unique: -ST7-ivaMmCqUVH1qgEvOg-1
Received: by mail-wm1-f72.google.com with SMTP id a65so4243841wmh.1
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 09:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMH16K1Vk3sQr9cJFMbSFsVVc6ukC0diu3TY4hvT3V8=;
        b=Dx7Mw12tunqWPdrxXbOz58ImebK7XFpfQwzDKb7hmceSzcySuJFsfEF5ySMskUvg15
         +4O6Jv4Pk3HXfpNFIeg1ZidIgp8D98D6TS37Yb9zFsluNqbyAstYkA94bHmkTsxmsGTC
         inFPqsyJrJE/cYVk8PWiujNgFbWibQ/WfTlfKJ9azvviV3tBFZ3Nu/EDw1wvvTp46yA2
         QoBC/0rdLm77FSGzRnvbr0pxXypJqUz/D2raSwTDjCY8y3cSPCdywrypifmKpu2hR9c7
         X63Vnuf+gziS89n0iDKsJu8XIESg1UipzOuSA3jOpN57+Mfvz5MDmzaDzXVL9DyHWZSx
         aXPQ==
X-Gm-Message-State: AOAM5307ns8yf5Ck8pwZARuu+RZ21EJTeAaHGKOuEXGuaUTx7uNFRAyc
        YO/vspCrb7OuuM0bRui2iq/hcJ/SBLvtxHJ7Z4Q2kZkAIVDcDoJKfrkAJ7xhLCFidU2rgxx6pbG
        j7SQ9f5yIRg5v4LlZ7H2wxhPb0Knh
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr201583wrv.222.1616085794527;
        Thu, 18 Mar 2021 09:43:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNeNypcp+XHyJTGZ8spn3LHjP3NH4oxZpMKd2THyQxn7pG5dxPB2k0bkCYChYIhaq3pgrGoGCwOWHOyS3DRRM=
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr201567wrv.222.1616085794358;
 Thu, 18 Mar 2021 09:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <2ed7a55e-7def-7faf-fc47-991b867bff9e@iogearbox.net>
 <CANYvDQOfygmqv0V-1PuzXV8ZFzk0uD566oEF3v9uX21G4fSFKg@mail.gmail.com>
 <1e410caf-019a-ade7-465d-3d936d2f7dc6@iogearbox.net> <5845cef9-5aaf-f85e-8280-472f61ddaeed@iogearbox.net>
 <CANYvDQNCKmEy9ZzPRvhNYvK0=TKk1pRS=seUuAkby92ic8tVqw@mail.gmail.com>
 <f97bd923-bf12-69a0-f0a8-c9a764abbed2@iogearbox.net> <YFIwzhE00OpU1zro@krava>
 <ff0db44e-aa55-da94-785f-ba10792a5ae1@iogearbox.net> <YFKOeGqUwBPTkPzT@krava>
 <61494cfb-1ceb-4886-3023-1ac0b35697d6@iogearbox.net> <YFM+Ijeu4bN4IzH1@krava> <CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com>
In-Reply-To: <CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com>
From:   Serhei Makarov <smakarov@redhat.com>
Date:   Thu, 18 Mar 2021 12:43:03 -0400
Message-ID: <CANYvDQOH5ZDpQBAHtz13YNiJ2Bhd56wnoas71UdYco62g-xBDg@mail.gmail.com>
Subject: Re: deadlock bug related to bpf,audit subsystems
To:     linux-audit@redhat.com, bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        Frank Eigler <fche@redhat.com>, guro@fb.com,
        Jerome Marchand <jmarchan@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 10:43 AM Serhei Makarov <smakarov@redhat.com> wrote:
> Jiri Olsa also reports seeing a similar deadlock at v5.10. I'm in the
> middle of double-checking my bisection which ended up at a
> seemingly-unrelated commit [2]
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1938312
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=2dcb3964544177c51853a210b6ad400de78ef17d

I've confirmed that my first bisection was incorrect by testing
@1c2f67308af4 mm: thp: fix MADV_REMOVE deadlock on shmem THP
and reproducing the deadlock. Previously this commit was marked as
good, so it seems a kernel with the bug can sometimes pass the test.

I'll double check rc6 next since I have the kernel handy. If
5.11.0-rc6 can also be made to fail, with Jiri Olsa's report it'd be
necessary to do a wider search.
There may be commits with intent similar to
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d92db5c04d103
which tightened some of the behaviour of kernel reads, but affecting
the audit subsystem?
The actual stack trace that leads to deadlock goes through
security_locked_down() which was present since the original patch
reworking probe_read into separate probe_read_{user,kernel} helpers
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=6ae08ae3dea2

-- Serhei

