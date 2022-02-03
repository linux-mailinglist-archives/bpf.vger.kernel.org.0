Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C804A8B7B
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 19:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353414AbiBCSVr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 13:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353403AbiBCSVo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 13:21:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95502C061401
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 10:21:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so4170533wmb.1
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 10:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Be902ZQ59a12XZsjjmEwvJaGpQx08wl8f3D6PIc0GW4=;
        b=4Qk67+eCOetTZ3IMWOlgL/O6SFR0O6YF+RvtKI89mDfiAT5akOM03BJHqGL0BH6SBz
         OhqTz8CrZpyC2BQ2usk6EDULsAauADKD0Qao9IrT80M37z297/T1GMTOnqJ7m0oz/msY
         V2K5tLfzuxUy7RK+lcRiHpxxRFj/6FAccvgsu7aAlW/GwNCj3uyX+Sx3NyMZgzDrwv7B
         V0WC2Ro69taKYb+XI0Oxd2NO8QA0VRYhiig5DzbME0zM/+hu/ItJmiQVRxSOiv1dsIgv
         fkpMIkwy68gpb9s0Cce/jZEtbr5VlyzhbgaQbQWM/kAspC8yrGo7cV21l1WqzKHX9gUM
         F0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Be902ZQ59a12XZsjjmEwvJaGpQx08wl8f3D6PIc0GW4=;
        b=obua/goyRkLIlXO3kNoWuJz8Gwxp4YGKj5N+8OKijjbS0ENk0ovibZeJhVhumA/oc8
         ODk+3BTfAAZYFmT5VB1J6p2iUp+6FF63mqNbRNcTGInfp3QR0ur1aa2Ym2tuuIWy7a/b
         cas42WqEv/4XQdZ7J8RiW/xcwO/lk5mcoWI1EbTvzs0L8kWjV7SJNUr4uaGXEDX3CgDn
         ZTmfvDj+Qmq8+58HT86nXOzV74LMD89XFM1wEv5CDriDeXNI4zIkoRy9eEZSHuNSwHp0
         cJu89UF9H94MWtG3V1g3qJwbA31AMaxv2P/UBLtsLnc+d9AMTTjt3dmT6sVfu7YvVdIX
         amNA==
X-Gm-Message-State: AOAM531SpWTK8nPafWZiIqXRhp3VdwY+Gt9VrGb5BhTLwFceSrfHk/SW
        yPDp0CeS7sbJint1s1uqZlQ23YIy6Xxd
X-Google-Smtp-Source: ABdhPJybdrgD3oIFRO3TlzNHWEQbTBYfIRi2+ZshN8VFNXeWMbUi5ZZNq6SPaj5U6/5OdFQ1Yse5bA==
X-Received: by 2002:a7b:c744:: with SMTP id w4mr11457251wmk.113.1643912503205;
        Thu, 03 Feb 2022 10:21:43 -0800 (PST)
Received: from Mem (2a01cb088160fc00aca4bfbbf04c2d2b.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:aca4:bfbb:f04c:2d2b])
        by smtp.gmail.com with ESMTPSA id g4sm24289933wrd.111.2022.02.03.10.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:21:42 -0800 (PST)
Date:   Thu, 3 Feb 2022 19:21:41 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Subject: Re: Packet pointers with 32-bit assignments
Message-ID: <20220203182141.GA129889@Mem>
References: <20220202205921.GA96712@Mem>
 <c5a76b4d-abed-51f6-bf16-040eb0baf290@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a76b4d-abed-51f6-bf16-040eb0baf290@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 02, 2022 at 07:24:20PM -0800, Yonghong Song wrote:
> 
> 
> On 2/2/22 12:59 PM, Paul Chaignon wrote:
> > Hi,
> > 
> > We're hitting the following verifier error in Cilium, on bpf-next
> > (86c7ecad3bf8) with LLVM 10.0.0 and mcpu=v3.
> > 
> >      ; return (void *)(unsigned long)ctx->data;
> >      2: (61) r9 = *(u32 *)(r7 +76)
> >      ; R7_w=ctx(id=0,off=0,imm=0) R9_w=pkt(id=0,off=0,r=0,imm=0)
> >      ; return (void *)(unsigned long)ctx->data;
> >      3: (bc) w6 = w9
> >      ; R6_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R9_w=pkt(id=0,off=0,r=0,imm=0)
> >      ; if (data + tot_len > data_end)
> >      4: (bf) r2 = r6
> >      ; R2_w=inv(id=1,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6_w=inv(id=1,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> >      5: (07) r2 += 54
> >      ; R2_w=inv(id=0,umin_value=54,umax_value=4294967349,var_off=(0x0; 0x1ffffffff))
> >      ; if (data + tot_len > data_end)
> >      6: (2d) if r2 > r1 goto pc+466
> >      ; R1_w=pkt_end(id=0,off=0,imm=0) R2_w=inv(id=0,umin_value=54,umax_value=4294967349,var_off=(0x0; 0x1ffffffff))
> >      ; tmp = a->d1 - b->d1;
> >      7: (71) r2 = *(u8 *)(r6 +22)
> >      R6 invalid mem access 'inv'
> > 
> > As seen above, the verifier loses track of the packet pointer at
> > instruction 3, which then leads to an invalid memory access. Since
> > ctx->data is on 32 bits, LLVM generated a 32-bit assignment at
> > instruction 3.
> > 
> > We're usually able to avoid this by removing all 32-bit comparisons and
> > additions with the 64-bit variables for data and data_end. But in this
> > case, all variables are already on 64 bits.
> > 
> > Is there maybe a compiler patch we're missing which prevents such
> > assignments? If not, could we teach the verifier to track and convert
> > such assignments?
> 
> We kind of tackled this problem sometimes back. For example, the
> following is a proposed llvm builtin for this purpose:
>   https://reviews.llvm.org/D81479
>   https://reviews.llvm.org/D81480
> the builtin looks like
>   void *ptr = __builtin_bpf_load_u32_to_ptr(void *base,
>                   int const_offset);
> 
> The patches are abandoned since the functionality can be
> achieved with bpf asm code. Something likes below
>    asm("%0 = *(u32 *)(%1 + %2)" : "=r"(ptr) : "r"(ctx), "i"(76));
> We could define the above asm insn as a macro and put it
> in bpf_helpers.h.
> 
> Could you give a try?

It works fine! One more piece of asm bytecode in Cilium but who's
counting at this point :))

Thanks Yonghong!

> 
> > 
> > Regards,
> > Paul
