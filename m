Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7019990C
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 16:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgCaO5r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 10:57:47 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:47030 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbgCaO5q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 10:57:46 -0400
Received: by mail-il1-f193.google.com with SMTP id i75so12399552ild.13
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2020 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfQhccziDudVsLMP6kJ733ATOZ31NAdEJFty0F3uQqA=;
        b=PlQeasvJWSo4iQz94dt77xWDMNTQ+jYB7zJRbPPBNjYM5612R+MSy+yWtI+wboPQln
         U1BFVvavpFJ8O79mRN/SrlTA5PjRB0JO6ysbJ1GtuFMkdY5QO9moEBnkW9xb7/Fvwki7
         aKBt4twfTSpIC3oAK7rvmfhTng3NCSJDnzGfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfQhccziDudVsLMP6kJ733ATOZ31NAdEJFty0F3uQqA=;
        b=gxkI0az0BwK6Q62SF2EGjIN0COyw9YeHtsdXWml4NELlblZjSewj181Lo5BfVIwzKQ
         e97d9s1jFRJCg5wy0fQdH/5/s56VID69E2iDalsgAH0A6BJim1OBau80P5jq8jdrIQ3o
         z7hnLBAZaLD4Yj/V9xZocDzqlYJq9JGkiCQpuy5X/0qBdvPs2XPA2OVA/Zv1k11Gqjgc
         q7ODYinrJVOaG/GKMbIwca27gUOTpPd3js+r0ry6wqtkIKFeh9RVuHBaQoNkES3Oa+kh
         IrEW0ED7/YRXv4sEFpW4tgBRS4Gc6bnygEbvbsz74S/ZNSwA4SE/fLm3wg5Tn67ECCFX
         mbbg==
X-Gm-Message-State: ANhLgQ0ncI5fmjDsFB19v+36mvrmWKXewpyGhIl6dHVUCchX3GgQ9A1v
        isTqT8uCcNONv4SIARsyVEO9fZFWxkjaeUaN3gM+MmRI
X-Google-Smtp-Source: ADFU+vuFxmGgOn08tmoANgBI3LNTetni9UTrAwOiEISPhiM5Omw//ihMU/JryRy+gVy9Ac1Y5taJ1VHJyEY+hsM2LGs=
X-Received: by 2002:a05:6e02:551:: with SMTP id i17mr16403204ils.280.1585666665915;
 Tue, 31 Mar 2020 07:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200331101046.23252-1-bjorn.topel@gmail.com>
In-Reply-To: <20200331101046.23252-1-bjorn.topel@gmail.com>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Tue, 31 Mar 2020 07:57:35 -0700
Message-ID: <CADasFoDZq=+34MSjPD7gqEDhW8Zm_zFWAamHZc7ZsAeYT2=Lrg@mail.gmail.com>
Subject: Re: [PATCH bpf] riscv: remove BPF JIT for nommu builds
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-riscv@lists.infradead.org, Damien.LeMoal@wdc.com,
        hch@infradead.org, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for looking into this!

Acked-by: Luke Nelson <luke.r.nels@gmail.com>
