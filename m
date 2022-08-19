Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080BC599DA2
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349528AbiHSObt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 10:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiHSObs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 10:31:48 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2638EA337
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 07:31:47 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p184so3412039iod.6
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AjbWubpcUa9YQyhG2E/jmsWbUQjRwTtqNUg4iIKtN+8=;
        b=C6anqngy5zaJtJIkFBWXsltajPoLTr1rr1XPNtqI2RSKz6tGxTwn9hv98osC5GAcrY
         zpGwuCHoPTq2zMpxLs28lV+xuWvyk8qajrh/JQPe7p5uT3W4rkRZHAditnhqdrUwfS38
         IfjbgFXacBkCtHtP2TrHUut2KKtO8Y88MshVC+e7vMgmvnpJBSUPRPsQhh/ja5P1xoDQ
         Dpkt52pVBkQzJMomL/X48MXR9g0U7bL7QMQLPmjbNpNtG7CcKpNEXB5Qt8h+oqFTJLRt
         7SEvcA+anHsZdPxQhSEbB9RGorXmK8gLECE7+eu7xGf44hWiq9MRLS4m9QOEi6BYBWJA
         RNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AjbWubpcUa9YQyhG2E/jmsWbUQjRwTtqNUg4iIKtN+8=;
        b=mzhHSVwKGjsHjpkaquh72WeFZJGNgmCFTByCZm5uyp3p6bweVPZWXMTZE5KSeSRxxm
         +jDOfyAVqj6yV0ySLJTGTN+55yzTHOSvtfHtzRpMRaJwHnzeY31U0nNjZriwtvAop3Mc
         LJsrZag+Sv4H/qPVSlYgheYmBssL0ztlwWvM9Hbt/bQM6g7/h5s3tUhtAWgY5U+BFBpn
         n0EqHiqsV3BZX1p7078DU1KRi4nufbGxzx9ySdVR+dLnjI/CrhpnSj8/uM7osy0zihOm
         BeDnO/67uj6APsFl0bRWDlPHWX9IaC7Cy8ymB0lPavdWL3+M7jMNPB4IelpDAnc2ypl6
         ezmA==
X-Gm-Message-State: ACgBeo207s0wTdOobLEtyYD97MMqIDgJwieCpEMNAh7egF8qRbiyQT5t
        uHbYqlr09FcPqXOz/GMmEhfybzeM5FkjCoenQKhKLN1J
X-Google-Smtp-Source: AA6agR6tC4Ut7gTSRB4ZYvcO8nQhbPvmaX07V2qlN6w9X0wA5ZRqEus3zAEtUGqOriIh/asA/sxCAc8EUx9gHr8KZwE=
X-Received: by 2002:a05:6638:1394:b0:343:6ce7:2849 with SMTP id
 w20-20020a056638139400b003436ce72849mr3712899jad.231.1660919506896; Fri, 19
 Aug 2022 07:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
 <20220817210419.95560-2-alexei.starovoitov@gmail.com> <CAP01T77L6e=B6OtLcM4bToM5n4+j3S6+p+ieTPtDGUgQUZ3o1Q@mail.gmail.com>
 <20220818003957.t5lcp636n7we37hk@MacBook-Pro-3.local> <CAP01T74gcYpXXoafBAEaL5a_7FaDdfAwzmoE86pOctzmeeVhmw@mail.gmail.com>
 <20220818223051.ti3gt7po72c5bqjh@MacBook-Pro-3.local.dhcp.thefacebook.com>
In-Reply-To: <20220818223051.ti3gt7po72c5bqjh@MacBook-Pro-3.local.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 19 Aug 2022 16:31:11 +0200
Message-ID: <CAP01T76rn=FrSC9VA=mbEK7QKMu-88uZiiekpn6TqQ_Ea0-u5Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/12] bpf: Introduce any context BPF specific
 memory allocator.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Aug 2022 at 00:30, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Right. We cannot fail in unit_free().
> With per-cpu counter both unit_alloc() and free_bulk_nmi() would
> potentially fail in such unlikely scenario.
> Not a big deal for free_bulk_nmi(). It would pick the element later.
> For unit_alloc() return NULL is normal.
> Especially since it's so unlikely for nmi to hit right in the middle
> of llist_del_first().
>
> Since we'll add this per-cpu counter to solve interrupted llist_del_first()
> it feels that the same counter can be used to protect unit_alloc/free/irq_work.
> Then we don't need free_llist_nmi. Single free_llist would be fine,
> but unit_free() should not fail. If free_list cannot be accessed
> due to per-cpu counter being busy we have to push somewhere.
> So it seems two lists are necessary. Maybe it's still better ?
> Roughly I'm thinking of the following:
> unit_alloc()
> {
>   llnode = NULL;
>   local_irq_save();
>   if (__this_cpu_inc_return(c->alloc_active) != 1))
>      goto out;
>   llnode = __llist_del_first(&c->free_llist);
>   if (llnode)
>       cnt = --c->free_cnt;
> out:
>   __this_cpu_dec(c->alloc_active);
>   local_irq_restore();
>   return ret;
> }
> unit_free()
> {
>   local_irq_save();
>   if (__this_cpu_inc_return(c->alloc_active) != 1)) {
>      llist_add(llnode, &c->free_llist_nmi);
>      goto out;
>   }
>   __llist_add(llnode, &c->free_llist);
>   cnt = ++c->free_cnt;
> out:
>   __this_cpu_dec(c->alloc_active);
>   local_irq_restore();
>   return ret;
> }
> alloc_bulk, free_bulk would be protected by alloc_active as well.
> alloc_bulk_nmi is gone.
> free_bulk_nmi is still there to drain unlucky unit_free,
> but it's now alone to do llist_del_first() and it just frees anything
> that is in the free_llist_nmi.
> The main advantage is that free_llist_nmi doesn't need to prefilled.
> It will be empty most of the time.
> wdyt?

Looks great! The other option would be to not have the overflow
free_llist_nmi list and just allowing llist_add to free_llist from the
NMI case even if we interrupt llist_del_first, but then the non-NMI
user needs to use the atomic llist_add version as well (since we may
interrupt it), which won't be great for performance. So having the
extra list is much better.
