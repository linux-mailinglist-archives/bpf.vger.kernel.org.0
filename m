Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9162CBB70
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 12:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgLBLTw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 06:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbgLBLTu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 06:19:50 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038CEC0613D4
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 03:19:10 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k10so6140512wmi.3
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ewAnY9HSoLrwnuLqpq3pGLIFg/YPcBbyKf1iWj4MkbA=;
        b=SuUi2UNdeECiQI1YSBC0mxVpJJG47QJ2Uu3Xr3Iwo/yYJnR50iGUodcrQ+mWbq8sDj
         GuVgRRdNS98KgJnPOT5gOYkOhY8v6I5wzFXVoRtB26wXFskkWi5t9vNlsCfRwdFg/tBk
         7FMUbQK3ciWtkewja+gJSHRH54E5+3LQrE8aoXZsgsuy+/QCDfEofXt2rhyE/aHSxYjE
         hsq3iLDyHExIv9BaOgZA859kcMSjwbkVeJOG3FJTsy7RvHo7g+m1Mm/1jk5mUbkZbTjy
         eQUhRCTOzRNvF1COg9f22LaIoSRQs/LtVijYenTDZPp/IxQJ8C0+O8CA63OTCOG8zLgn
         yhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ewAnY9HSoLrwnuLqpq3pGLIFg/YPcBbyKf1iWj4MkbA=;
        b=afZsKsLCXCbvGOTFE3Po5exyEfZ2N+PTY7C0bsuTukgfyCaIlWI4dnCHXHl8bg8YJn
         QGfrJpdgVUOtaru3AIriAYoXvFt1QllFG7Rx5UxBlf2s6XBkjGlmhFVi2qUZ6o1KjEwK
         +PXDdaj8E5KrytxMQlxeWfY0B13Ze0h7YgNnUwK636JRbJuPVBegn3y+NctRwtQVjLnr
         jO5yxlJa6E4ifS+54UQ6qWWVZHYBl6IUrOhq2Gk0aSnyCSk0EnLwrmSHe1Hv9J1rvUvx
         uw4UqKQ34ORCs5Wp5DpLeds68ngAwEO5eNUtSEuZ8lX526U7Krqiryu3mG4CCrymDoW0
         9LMA==
X-Gm-Message-State: AOAM530yZuaxhbYErQ/iycSDdz0TwYWdnGETPe8jVRwfULn4KlBYCVxu
        KzovgYFm1Hbg+1+o1qv0eaVmVg==
X-Google-Smtp-Source: ABdhPJzwJjh1gbEnPTQME3N1fYzMAHiKKDk/w6rK6zdqwhM1akQs6qm0CvuPLF+PBHn0Aju/q3j3sg==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr2615389wmg.189.1606907947170;
        Wed, 02 Dec 2020 03:19:07 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 34sm1578880wrh.78.2020.12.02.03.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:19:06 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:19:02 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 10/13] bpf: Add instructions for
 atomic[64]_[fetch_]sub
Message-ID: <20201202111902.GC9710@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-11-jackmanb@google.com>
 <0fd52966-24b2-c50c-4f23-93428d8993c4@fb.com>
 <20201129013420.yi7ehnseawm5hsb7@ast-mbp>
 <1dfd2e5e-f8d2-eac2-d6b2-7428ceb00c36@fb.com>
 <20201201123800.GG2114905@google.com>
 <CAADnVQLYMKhC4D9AzcOEXM9s9LfdFo4sEL3hsU=UAzBOXGwb-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLYMKhC4D9AzcOEXM9s9LfdFo4sEL3hsU=UAzBOXGwb-A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 01, 2020 at 09:55:22PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 1, 2020 at 4:38 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > I guess it's also worth remembering other archs might have an atomic
> > subtract.
> 
> which one?
> arm64 LSE implements atomic_fetch_sub as neg+ldadd.
> imo x64 and arm64 example outweighs choices by other archs if there are such.
> Even without LSE it will be neg+llsc loop.
> The reason I proposed bpf xsub insn earlier is that I thought that llvm
> won't be able to emit it so easily and JIT/verifier would struggle.

Ack, I'll drop the atomic subtract instruction.
