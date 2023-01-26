Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EA067C464
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 06:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjAZFqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 00:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbjAZFqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 00:46:12 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B51A4AD
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 21:46:11 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id q15so607398qtn.0
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 21:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+eHanpk6LZuqRzuz3qKULO1b4PCiKRmK6RZEZ5BCko=;
        b=OZp8pWexBLWt7GnP6U6u0uEGAbjvxKQL9g8OI1OqvwHaYCDWFEx5/I923jxlbTFEAI
         EXQrLuWRsuwT3cVYvuZp7vuizd8NfRPaSc5m1r3mxrWXvjIjbK7HsIyrIllHE88kZAIM
         gCEo9S/E3HEqwN1zhukzRvVa4QIoDkKwPeqxOM4lWQEytLHunBC/WbVvczjZMxvHpp+T
         Mlmu9j7BPAJA/ZM89Kw/w5CRP2Yo8OVK21JrBVPEVwb3SUI0P1mVb9gEENmiIxZ3B/Bc
         CLhH5j34YPUe9g2iK0OmwEnodN32mJjYafarA0epPSrvYYajKlUf56kOfH8RnoI8a9rT
         l+9Q==
X-Gm-Message-State: AFqh2koSsbJmG4Qmgv2GirWkUteDcjelwNYQlRRwKJ2zEYoZHuzQ4JHh
        03NzS8fk3WDX6RlqoIolVTY=
X-Google-Smtp-Source: AMrXdXtMWD6/w45HPmtMNHRjnN/c5DjIjdtvPxoKSRK5w/2MGTDhXoBZX/RIKLskGgpTvpvrfzHtBQ==
X-Received: by 2002:ac8:6708:0:b0:3a9:818f:db3d with SMTP id e8-20020ac86708000000b003a9818fdb3dmr51000181qtp.53.1674711970645;
        Wed, 25 Jan 2023 21:46:10 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id p1-20020ac84081000000b003b2957fb45bsm210655qtl.8.2023.01.25.21.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 21:46:10 -0800 (PST)
Date:   Wed, 25 Jan 2023 23:46:08 -0600
From:   David Vernet <void@manifault.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Per-arg kfunc flags
Message-ID: <Y9IToH14bniD00R2@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I would like to discuss how to enable per-arg kfunc flags.

As described in [0], kfunc flags are currently at the granularity of the
entire kfunc. This means that, for example, only a single kfunc argument
can be acquired (indicated by KF_ACQUIRE), released (indicated by
KF_RELEASE), RCU-protected (KF_RCU), etc.

This hasn't really been a problem up to this point, though there are
some per-arg annotations such as those described in [1], and patches
here and there such as [2], which collectively indicate that it may be
time to start aligning on what the design and implemention should look
like (e.g. should we model the UX for defining kfuncs in a similar to
way to helpers, go in a different direction, what blockers are there,
etc).

[0]: https://docs.kernel.org/bpf/kfuncs.html#annotating-kfuncs
[1]: https://docs.kernel.org/bpf/kfuncs.html#annotating-kfunc-parameters
[2]: https://lore.kernel.org/bpf/20221217082506.1570898-2-davemarchevsky@fb.com/

What do you all think?

Thanks,
David
