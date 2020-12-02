Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913102CB26E
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 02:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgLBBk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 20:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLBBk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 20:40:26 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48162C0613D4
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 17:39:46 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id x17so147056ybr.8
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 17:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drwn1zA9epewELYpsEH4x4ZU8if1FefIOowfYbVqU6c=;
        b=AN30uMRPIHc3IZ6/JhySa78CjLkFf4+kF+etRPsQZQnWAHlgFfg42QqoRukklyYrJC
         CjI/ybB66k6JxrY5IOAqDRa+S1SUuZDWsdKqi/UTXJcLihR0BlhLeZuIkuuRk2wtmwV2
         CIrlnSZB6yrXO5Ccfy19onS2Y0Y4r9QlTCR4TreLvdagjIOd/6MOm5ZYT4appQ7d+Up2
         t5Dhh6dDblMkB65o37jMQeYEMfgq4r4D1SJaza1M+K+VGDhVi+sopvM4AOYfMIQIvhqm
         pUJ3CuxKN63mQqMymmGyL8dX0SAAUIu8TpMAFugRfQT3q9HTn9SQDLsMrC2hIxg6Jq5A
         4KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drwn1zA9epewELYpsEH4x4ZU8if1FefIOowfYbVqU6c=;
        b=Q1ne7pqcqm+oxytjDAcWLGobv63yMDhX3cdHu1V5QS+hFpQZ+JhoArBgfweVJc4ZGA
         s4DvtfKuFhmOG9uxjGpLtUc+OoN/IH4lbip0mlKCJLsvsYs+b7PTTsvtcGk9KAN2BU7M
         nIoeMyMdp9nNA9e+ahVosuwznvskHVSnnygCFSBzISGdlKwGkOrCPXy/n+suTB4YIMpg
         KT5s38Dzt3bQG2kch/vpz4ZFCEBD9m9OOuSzUOwrwz2hygBXLtUrbp/AtoN7Vd4AvlDW
         3uVg4ox9cF+mRJVnEOEH8kZUG8jIrKkZeq1CIrfGFzzCX8DfmlYX0InTSp9xM1onlfdD
         bbQQ==
X-Gm-Message-State: AOAM5301WMfcWdHMoveKtl0S0NTNxj4h4PrhERYQ0fpMtvhZmlY/BOEX
        3aWkz30K6UI1yHb1M0jPDBfpIjVFUocXAQ34w2HuZTl3IAU=
X-Google-Smtp-Source: ABdhPJxtGzPf8ZZZ5lgZzNLa9jiB7lVPSqfL/qS+k5Gci07AbTCLplwGRUmw0pR8ya0mt2k0LXRvDgfCZ+yh8n7yDAw=
X-Received: by 2002:a25:7717:: with SMTP id s23mr349544ybc.459.1606873185643;
 Tue, 01 Dec 2020 17:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20201201044104.24948-1-andreimatei1@gmail.com>
In-Reply-To: <20201201044104.24948-1-andreimatei1@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 17:39:34 -0800
Message-ID: <CAEf4Bza12kGPv2dukdYiWmPDxiWArm9G91ZVU4fRstZ8a_Y0tQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/1] libbpf: fail early when loading programs
 with unspecified type
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 30, 2020 at 8:43 PM Andrei Matei <andreimatei1@gmail.com> wrote:
>
> This patch should help people who misunderstand the importance of using
> proper prefixes to their ELF sections in bpf object files. The patch
> assumes that programs with type BPF_PROG_TYPE_UNSPEC are always invalid,
> as indicated by `man 2 bpf`. Please let me know if that is not accurate.
>

FYI, you don't need to send a cover letter with a single patch.


> Andrei Matei (1):
>   libbpf: fail early when loading programs with unspecified type
>
>  tools/lib/bpf/libbpf.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> --
> 2.27.0
>
