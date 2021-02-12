Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7493198E9
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 04:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhBLDoD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 22:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhBLDny (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 22:43:54 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ECDC061574
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 19:43:13 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id r23so10040720ljh.1
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 19:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuTOoyxQ3Mc+2YM96TXoRNMrnkxTCqSm/kkEiWDR6VA=;
        b=MFl1/B67dzxFXgbzdlExY5OUwCDU3CqdRs7+rUzYDiVoYo5yzvpznGgUDwARvLmJsi
         k9GXMjwdorfj/NalB7HF/lLHMFXUECf28WxSgo8aQz3S84VRXGl4xUodlnNkKcuWKFjs
         D9Vri+p/1XMwYh4HoLMbVS3s6PoMihSlbnCGFH/qtm4x+eqVNzWUqVo3bbaGhXFzfgxd
         rJnl2mAC+GU4aPJwkL5kqUdmLzCdTlOL9PQkSeB0ns3r1Xn8LD8nQDFEjlosiGsgBPda
         8YDvSBhbW4ABprTlpLMcscVgPpxqz6SOfvBAXYsb8qU75gIZuvpU3o9v9GW8ECF+1Kv/
         oYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuTOoyxQ3Mc+2YM96TXoRNMrnkxTCqSm/kkEiWDR6VA=;
        b=P83/ME5qEnwddsT8mPIAvij/K+T2vaKdLQyQ/av56mPQwv1N/ZKCWJgOMzJbVRgNzk
         +52fERN4WJ10jQjAbG/ZuCRHjwhLRIV5QqIdrySDneWXJ/EKIo9mzWW59eDhl2uVoIOm
         ROeLafzcO7L4tisw3y/TEPQIB8BkiXEkglB3GsOAK5C7WVLQY3Qoq0DcvRtiuqH2K3dt
         Nl8Lxa1amCKY3OHKekjXz3+GN01jcuEwI6ruKMZamrqoVsciGuEaANsH9VG3J1gGgafz
         M3h4bnJ0meVNYxEvM4hxWP7Eee86Hrt4uHsyjBWM4AdEMpFY2qdL3Gf5KPWKXldjhn14
         5rHQ==
X-Gm-Message-State: AOAM5319Sj2ILCss9Kpani8cEvc7cG4SyeIGIjnXjneWKIMGgc6ZgIOQ
        Ig/M96Xi0Vx/9b02Y4phjXfVI0O/HA2kz+1+oGw=
X-Google-Smtp-Source: ABdhPJyqXOL41XnBktjg/WDDMs0J7DvD3Sn4RyG7qdfXoel+ArO6BKLSIFR5P2reUCeYNrCLi3o/OcwxbmtK3tHPU/Q=
X-Received: by 2002:a2e:894d:: with SMTP id b13mr533435ljk.44.1613101392395;
 Thu, 11 Feb 2021 19:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
 <20210210033634.62081-2-alexei.starovoitov@gmail.com> <1e54f82603c361e7ee1464621a9937c1efb3b254.camel@linux.ibm.com>
In-Reply-To: <1e54f82603c361e7ee1464621a9937c1efb3b254.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 11 Feb 2021 19:43:01 -0800
Message-ID: <CAADnVQKkc4dYCCNV=X4FNfRteoMXGHno4cMExab54cNGgVJ6AQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/9] bpf: Optimize program stats
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 11, 2021 at 7:26 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> mm/percpu.c:2089
> #5  0x00000000002ef738 in __bpf_prog_free (fp=0x380001ce000) at
> kernel/bpf/core.c:262
> #6  bpf_prog_realloc (fp_old=fp_old@entry=0x380001ce000, size=249856,
>
> So we end up with objcg=NULL, but I'm not sure why this happens.
> Please let me know if you need more info.

Argh. Thanks for reporting!
Pushed the obvious fix:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=1336c662474edec3966c96c8de026f794d16b804
Pls pull bpf-next and give it a spin.
