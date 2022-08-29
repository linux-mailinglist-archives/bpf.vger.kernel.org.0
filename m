Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724095A57C0
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 01:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiH2Xpy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 19:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Xpx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 19:45:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046DD84EF7
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 16:45:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id h5so7265621ejb.3
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 16:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=viwm8VlRl5JlVPUTeI9sz3Mqlj2LdoU1RZfVIXgfatI=;
        b=NyONEqIQ+MMAvKaRHkElSaG6m0/2F2SnwG4rrhIWTK3JbV0i+92EXSKbfE+vC5d3L1
         5IUMU4DpMlLzEhfr1YujHsDBqyUD/564P/5YTaZSmsns1QxBmCa+LAQDEmtK1ZNYE6qf
         kRyzDw9imH3JZBSzKy8GvlLh4juCOVzEoD6cMgdrcQCI019+adXBUaCRFnSo47YpFW0e
         S7odFxfazrb7676hpshUktrAJdRQgTpsBVVxEQzbvvzhIs2CFu9tYak5Rlg4ounN1nZQ
         L+zdNKWYQut8XpY4BQ+bdqzB2XvKIWVO1IfQcImDONjVKGh/8TXZAwzXiYdydFTkIMLe
         VwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=viwm8VlRl5JlVPUTeI9sz3Mqlj2LdoU1RZfVIXgfatI=;
        b=yn5JnFbsowwNFHsz+aETHlnW+gI4UNEbKqfj1ZunH6wH3Io6ngJ7uvfve0Vopn0MBF
         f7v50SllrG9kpMkqquslW3krtSsQsKWxexcwFm4nKoXrB5T7tdKyhvawIORnLGl7Dy1M
         a71HP7zzHp2bX8rpbGBW7fiIF/jkVvDK/9+BMTLvqZzEltpAr5pZ0i4MFJbor0s79tt/
         d3rSAg/Wb5gTDv+9cSfQ1tX1zHbSV7Rh6HWn3Vy55WbtqBtulfbUIzqUTDcToZzdm0ja
         MK8+VaBCfwEwjAVYKTFGwCPfyTnGMnn+6f0sasT4le/9eHvu2yEBeyR7mlSSemTbAxs3
         clSQ==
X-Gm-Message-State: ACgBeo1B1ZJgdDlq8u8WNEJ3/9Cub1Vz2SHXVAeqTLzDh+R20FPYp2Qz
        KFjXiNhMcdDgm8XtK62WFcmgmzJDeKeFon6IB/o=
X-Google-Smtp-Source: AA6agR5GP2oSUUw4gfIe0jB8ESTDOYmbX7+JRel7aUdcM5bUPEzhfmtV2nbryWfbm2uePB/bXjFVZ0hVW8wcH5bmvrA=
X-Received: by 2002:a17:906:dc93:b0:742:133b:42c3 with SMTP id
 cs19-20020a170906dc9300b00742133b42c3mr1046857ejc.502.1661816751567; Mon, 29
 Aug 2022 16:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com> <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
 <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com> <CAP01T74nPCXAeP=Aj09pW_Ykv5Rx2Y4U_fULQe+a4pWygVxaGg@mail.gmail.com>
 <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com>
In-Reply-To: <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 16:45:40 -0700
Message-ID: <CAADnVQL9g=PQzZK06FVOiCPBkM15AuyR6m0K5n5d8GtPBKnNAg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "memxor@gmail.com" <memxor@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Mon, Aug 29, 2022 at 4:18 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> >
> > It is not very precise, but until those maps are gone it delays
> > release of the allocator (we can empty all percpu caches to save
> > memory once bpf_map pinning the allocator is gone, because allocations
> > are not going to be served). But it allows unit_free to be relatively
> > less costly as long as those 'candidate' maps are around.
>
> Yes, we considered this but it's much easier to get to pathological behaviors, by
> just loading and unloading programs that can access an allocator in a loop. The
> freelists being empty help but it's still quite easy to hold a lot of memory for
> nothing.
>
> The pointer walk was proposed to prune most such pathological cases while still being
> conservative enough to be easy to implement. Only races with the pointer walk can
> extend the lifetime unnecessarily.

I'm getting lost in this thread.

Here is my understanding so far:
We don't free kernel kptrs from map in release_uref,
but we should for local kptrs, since such objs are
not much different from timers.
So release_uref will xchg all such kptrs and free them
into the allocator without touching allocator's refcnt.
So there is no concurrency issue that Kumar was concerned about.
We might need two arrays though.
prog->used_allocators[] and map->used_allocators[]
The verifier would populate both at load time.
At prog unload dec refcnt in one array.
At map free dec refcnt in the other array.
Map-in-map insert/delete of new map would copy allocators[] from
outer map.
As the general suggestion to solve this problem I think
we really need to avoid run-time refcnt changes at alloc/free
even when they're per-cpu 'fast'.
