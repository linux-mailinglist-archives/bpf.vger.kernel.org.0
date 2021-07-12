Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181B03C6713
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 01:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhGLXlt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 19:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhGLXlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Jul 2021 19:41:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4057DC0613DD
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 16:38:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hr1so37948431ejc.1
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+ow3JQSGmIxGxmBtzaNRu0aWAexpxicEex2FR/8Vpg=;
        b=q3bb1njJLd0JiDyJVBFlk6/1k+0LgD6QVIzASIwyUTB2Ts1EZMIt1eH81/e7zxLe01
         bS9TKHrpynFB5xjjmCFgqmGncKe7jJBg6WVucoV3UTxdZWxGFPF6A2NedL2Y2G3wnmyJ
         UtI6on4FTvPNB3iCmsSC75y+GefK2ZFOE7Oxmdxl6Krsz22YOTzHVPRWZuWcExbo6lPE
         KlpTit9FABi7uRkykZg49tv7gtl+a+pTm8LRjSTF4sY+P2u/vWt7Dmb1ADSTrAyJEIBI
         k73k71QbPloKF9P4JLKf18FTJQTz4Kl2GMmJfMtGuMmR9yqmrZPLdvrJQMnaWxPa5hR2
         YV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+ow3JQSGmIxGxmBtzaNRu0aWAexpxicEex2FR/8Vpg=;
        b=ojC0n8A4jmC5sk9IyuIxBoJsAUi4tDxOYdfZN3PGWQ2s87Agcp6wk9/bWfln84RI7n
         uoF04/MBvc1Go++F3G4qTPX4hM/3ERcqvo41Xw2aId/DqzqHr+AErUVboYlRoxzBwANx
         E/QIJCirwavCv8Yoe+/02uzjOtXas2qJ0WAsKdbnSU28sdJrcE81nQvQYxd6JIVOA5cz
         JIWV2rOhwLHQSDTKI4WQB93D1W6TtCx83x1O95PFLrhIf9hpe2LtWP/F3fJv1VPN/Rou
         mEB1ZOZsyBe/LUIlLnjum9++33snlRXoT8emTDzUxQ2FGiRti1VF8q2qzVfFMSmp2JB1
         PnzA==
X-Gm-Message-State: AOAM531Axha+mnhCEb8S9Q7+kDFxAD1lgdzvXPUOu4J4umU32t4pO/mi
        gH4MnN50eEJ5XNS75E95HVGENtPYM3NLRACQWlM=
X-Google-Smtp-Source: ABdhPJzdDaEe7zghTgJjqMfsmc1EkneKIm/CgP0FYTtTKxLyxYGQA4yi9R+j6tHPYT5KH3T5HwUlQap+lRyNSevmSWk=
X-Received: by 2002:a17:906:a2da:: with SMTP id by26mr1949752ejb.232.1626133137857;
 Mon, 12 Jul 2021 16:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <c43bc0a9-9eca-44df-d0c7-7865f448cc24@gmail.com>
 <92121d33-4a45-b27a-e3cd-e54232924583@fb.com> <79e4924c-e581-47dd-875c-6fd72e85dfac@gmail.com>
 <6c6b765d-1d8e-671c-c0a9-97b44c04862c@fb.com> <85caf3b3-868-7085-f4df-89df7930ad9b@gmail.com>
 <ce2ea7e8-0443-3e78-6cf8-d3105f729646@fb.com> <64cd3e3e-3b6-52b2-f176-9075f4804b7a@gmail.com>
 <497fc0fe-8036-8b79-2c6e-495f2a7b0ae@gmail.com> <CAK3+h2xv-EZH9afEymGqKdwHozHHu=XHJYKispFSixYxz7YVLQ@mail.gmail.com>
In-Reply-To: <CAK3+h2xv-EZH9afEymGqKdwHozHHu=XHJYKispFSixYxz7YVLQ@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Mon, 12 Jul 2021 16:38:46 -0700
Message-ID: <CAK3+h2zW5ZgnXu0_iMHUMLxmgVd2EAoRFuwAEKVkJwOnxSp56g@mail.gmail.com>
Subject: Re: R1 invalid mem access 'inv'
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong,



On Fri, Jun 18, 2021 at 12:58 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> Hi Yonghong,
>
> I attached the full verifier log and BPF bytecode just in case it is
> obvious to you, if it is not, that is ok. I tried to make sense out of
> it and I failed due to my limited knowledge about BPF :)
>

I followed your clue on investigating how fp-200=pkt changed to
fp-200=inv in https://github.com/cilium/cilium/issues/16517#issuecomment-873522146
with previous attached complete bpf verifier log and bpf bytecode, it
eventually comes to following

0000000000004948 :
    2345: bf a3 00 00 00 00 00 00 r3 = r10
    2346: 07 03 00 00 d0 ff ff ff r3 += -48
    2347: b7 08 00 00 06 00 00 00 r8 = 6
; return ctx_store_bytes(ctx, off, mac, ETH_ALEN, 0);
    2348: bf 61 00 00 00 00 00 00 r1 = r6
    2349: b7 02 00 00 00 00 00 00 r2 = 0
    2350: b7 04 00 00 06 00 00 00 r4 = 6
    2351: b7 05 00 00 00 00 00 00 r5 = 0
    2352: 85 00 00 00 09 00 00 00 call 9
    2353: 67 00 00 00 20 00 00 00 r0 <<= 32
    2354: c7 00 00 00 20 00 00 00 r0 s>>= 32
; if (eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0)
    2355: c5 00 54 00 00 00 00 00 if r0 s< 0 goto +84

my new code is eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0;
that is what i copied from other part of cilium code, eth_store_daddr
is:

static __always_inline int eth_store_daddr(struct __ctx_buff *ctx,

                                           const __u8 *mac, int off)
{
#if !CTX_DIRECT_WRITE_OK
        return eth_store_daddr_aligned(ctx, mac, off);
#else
......
}

and eth_store_daddr_aligned is

static __always_inline int eth_store_daddr_aligned(struct __ctx_buff *ctx,

                                                   const __u8 *mac, int off)
{
        return ctx_store_bytes(ctx, off, mac, ETH_ALEN, 0);
}

Joe  from Cilium raised an interesting question on why the compiler
put ctx_store_bytes() before  if (eth_store_daddr(ctx, (__u8 *)
&vtep_mac.addr, 0) < 0),
that seems to have  fp-200=pkt changed to fp-200=inv, and indeed if I
skip the eth_store_daddr_aligned call, the issue is resolved, do you
have clue on why compiler does that?

I have more follow-up in https://github.com/cilium/cilium/issues/16517
if you are interested to know the full picture.

Appreciate it very much if you have time to look at it :)

Vincent
