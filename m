Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FBB436F14
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 02:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhJVAxk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 20:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJVAxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 20:53:39 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9E1C061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 17:51:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w17so1577607plg.9
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 17:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Enb7nyrjVNvXyAgH3Ga/tFNgrt0DMdmL2N5/zDV5Oug=;
        b=KOUjFIxouNDcu5kw2L22LIR8sTQXpuccFj6/aiPgOwbOulOLTiMFWlrM9Tp4797+PL
         ml2GRLyQl1wCV0pxDvrHz3OoOFu6b60Y3DYGtmNZnGOEwn3hh27viYA/zMywZvs/jn+j
         rNdy2oWYBD1+wvI/SvI6aY+AV21x53M8sL6vtWBYTVJvbiVDXJy1NTsqeGyBC2yTKgNI
         wtqVzYtUwlLEL13uaoLx3zP47p4M1xudEErqKu2yEMe9DG+Bss0pVurXouZmPyE96ylG
         Yb44lw3nlVrEXNYYjz7sRnOvsgVx/alBjObyOp3FHY8CD4BnhKmMxCNb1xXuVNGuC56C
         3bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Enb7nyrjVNvXyAgH3Ga/tFNgrt0DMdmL2N5/zDV5Oug=;
        b=KZiB33Q5Q30pkbU1WsP7en8BZ0nHCECuUM6KFqMQc6C595TV0oENwVYZU5yo3b+upL
         Cv1RRpvuhUYjMi77Dq8ekAhyRFJptK3ZF/cwG5IR8fj4nEDVHgdKGX09C2zh4NgyP0uJ
         wgxaYh1hn5hNnb8AVvUjjd9MbMXHINySPhyWRDAIxaUnygXns0YF/Y7gozneQvf1PluV
         LUw5oq2BoiTPkXawc+RqWj0aqgibbaXnWdNWbMpsFcfCsQpE7qjtyn2u7ETmevRVp/TW
         UTw2Fa0UAlUAg6+cmEeI7G6Qh+M9E9ovdO6/YMLVRvbwAhCVrNc4I66odm9wInhgdASH
         yPyQ==
X-Gm-Message-State: AOAM530XNwZd1G4eNBG48xsSl7p2KGLjnMbSwtkYovAmAIOGmyiwlQyF
        ZXaIzM2NqC3bsaWVEIbgzekvUNGnP4uyaR3EmgQ=
X-Google-Smtp-Source: ABdhPJz47jYQ10RLyCp+oI5N+S/RSKGqh11TOCRT/K7JyoTlb5hYg2aEKXiMi+ZG2jzD7oGa+DgVkzV9Wi6S8DLMMJ8=
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr10498233pjj.138.1634863882630;
 Thu, 21 Oct 2021 17:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <20210917215721.43491-2-alexei.starovoitov@gmail.com> <20210928164515.46fad888@linux.microsoft.com>
 <20210928163730.7v7ovjhk7kxputny@ast-mbp.dhcp.thefacebook.com>
 <20210928191103.193a9c62@linux.microsoft.com> <CAADnVQ+ajFPKfP+Q5WQFztfZ+05uGgbuQk3H8_9OTny=0vku=g@mail.gmail.com>
 <CAFnufp3hx0CaF=ukCXY3UJj0omVX+5WWk0=-QuENvTPGye_sKA@mail.gmail.com>
 <20210929193858.57ba3cd1@linux.microsoft.com> <CAADnVQJjHyB1CwquYx2X2uMGygEpFJhNh75gPcHnYkD2pLmcDA@mail.gmail.com>
 <CAFnufp07EHqc0wgv0V2H5yMfdw-9diPOX6RS_z+k1iJV+LJ=Kw@mail.gmail.com> <CAFnufp15UYRJTW9dEorryZ80NsK_ULK0MXmaP_dg_ys6jC89nw@mail.gmail.com>
In-Reply-To: <CAFnufp15UYRJTW9dEorryZ80NsK_ULK0MXmaP_dg_ys6jC89nw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Oct 2021 17:51:11 -0700
Message-ID: <CAADnVQ+xVzbz_jhn_k0c+tNU7Py_oJqBJ5Sr+DGq1t-Y1iWxZw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel duty.
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Matteo Croce <mcroce@microsoft.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 5:49 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> I posted an RFC for the eBPF signature which depends on this series.

you need to wait.
