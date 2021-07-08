Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C3E3C1B5B
	for <lists+bpf@lfdr.de>; Fri,  9 Jul 2021 00:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhGHWJc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Jul 2021 18:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhGHWJb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Jul 2021 18:09:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD4C061574
        for <bpf@vger.kernel.org>; Thu,  8 Jul 2021 15:06:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t17so19264663lfq.0
        for <bpf@vger.kernel.org>; Thu, 08 Jul 2021 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89OaHBDISe4OaGSiCXjjeql+odMbdBP8qnYCx4UT2bo=;
        b=j0WdzM0TyJBkyE74wJLHjC4cCpN/7jUGIYHd7+KdHga0jTKz4GcGY+h67xepvXANFR
         mxcC2WHvkF78NSBCMDa05glrYxuO4xqb/IDGOInV/s2UYy3qajIU1+GnPpdPIIUVJ/kz
         5qPrRWyamJMhHT86uiecal2X7ryIG2sY+x0uhjZZCuASikoZfmfKS0TLOPmeryUFemc4
         C0A3qxWKaXe2b8B+VtXN+wWOZ7lSBoYXBmDGwRPiErkOk2whDj2f1/SqMck1km6y5pIj
         4yJekEwMur5V2do4V2PBqKxVLNjYvJx+Ld39d25C/titbakjzo3OoBe1o0EhZj2Adw1Z
         4I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89OaHBDISe4OaGSiCXjjeql+odMbdBP8qnYCx4UT2bo=;
        b=LkPZCU7KQdCvvuS8lSfoOQDYadIqoTHbN6MSiwmr76MjTGMc97RcTdqHLWsm8fS8TO
         7SpB9OyB59BwbPOW8037tTppj8pTwZmFshkZRaQUaqU88jSJF639Hai7uAykesEDG1Av
         SEmRDJxngStiXbaaEoIjoQVA7zMBouIWtX1zK/klUi5qLUhUoUgSgbsU9TddNakZ1i5G
         rdpeYkIKcFE+YJI5Lrl//4Sl279rmjLmw4kUedCsr1lSAAXlSrpdUM5PPn6gsgPwPJwz
         VIfOdThLfRmmURzm86j9b89sZIjftANsBL9b4PCk9BBx4BZGvlLtYOH7DCnq2ksCkr7v
         AUog==
X-Gm-Message-State: AOAM531GFEt2GOglvtCawNyL9tGCkbPJsk+MRK31LhEbqzyBA6QzY7LJ
        aIcEx4siemZyxsEOng8qmW+HXQdmCSla9tmfmA8=
X-Google-Smtp-Source: ABdhPJxUmMDqjlTI6aoW50z0K9nhul/SQIXLWCWYGOLv8VjF75JlvyBwuIVFWyRheMEu26dAzbI1EHH1I0qhyAca3CM=
X-Received: by 2002:a19:5016:: with SMTP id e22mr23144640lfb.539.1625782006314;
 Thu, 08 Jul 2021 15:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABX6iNpgX0EHWNJxb5Vd45Dc6BmS7P7Fjz5o0AyHU3Jq0ORYTw@mail.gmail.com>
In-Reply-To: <CABX6iNpgX0EHWNJxb5Vd45Dc6BmS7P7Fjz5o0AyHU3Jq0ORYTw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 8 Jul 2021 15:06:35 -0700
Message-ID: <CAADnVQJ21Tt2HaJ5P4wbxBLVo1YT-PwN3bOHBQK+17reK5HxOg@mail.gmail.com>
Subject: Re: eBPF support for TCP payload append feature
To:     Sandesh.DhawaskarSathyanarayana@colorado.edu
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 7, 2021 at 8:29 AM Sandesh Dhawaskar Sathyanarayana
<Sandesh.DhawaskarSathyanarayana@colorado.edu> wrote:
>
>
> Hence to do such modification for TCP telemetry in eBPF with software switches, we need to add new eBPF support as kernel workaround can create csum issues for TCP.

For TCP telemetry use case a custom TCP hdr option would fit better.
Sender and receiver TCP stacks won't get confused and middle boxes
should handle it fine.
https://lore.kernel.org/bpf/20200820190008.2883500-1-kafai@fb.com/
Once such option (read: space in the packet) is produced at the sender side
the middle box can fill in the extra data running at XDP layer, since space
in the packet is already reserved.
I believe UDP is already used for switch telemetry in such a fashion.
