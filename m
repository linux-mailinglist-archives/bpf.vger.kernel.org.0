Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D684F5A5867
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 02:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiH3A0Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 20:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiH3A0P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 20:26:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C83C72FE8
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:26:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so18945510ejb.13
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gPNFm/AplA5XMLd2GFTeKayE5jSEbK014pFxD0Ga3H8=;
        b=mzq/mbB602bODOlGkS31DVyrQnNVJrs53msV2Hy/9O3hyxoS0TfG1HZ3J9+wDEAAQZ
         51n7S0WdyoJoa76mCEOJK+Gf8eKNj0eGtjoTL3rL0CVh0oZeuJ8ycjOqCPufj8OA+eTC
         uWk0+sLO9mG91VGVFGKIS1XHdV9ZJfBDT98ytfoRfVTKjWHSYT/lh3yaOSNsUXUk9Ewv
         uLeqgjNk6dPB/G8lbTAXcAHkh3AQ85APxalaxUO0N3pZmk+cX0k2+KdTJVuwyZpbgEJ3
         lqfOjMlECvKaduQmfslpU4sm6pk9uGT8bShQHj5EdYpzUmP5h96W8LdpTxeBRgYCDq7X
         UB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gPNFm/AplA5XMLd2GFTeKayE5jSEbK014pFxD0Ga3H8=;
        b=zrAzjMnaM8AbduJUCNaceWZKg1App4QqPaFjuROK5R5hU3jVW0ywUKedVwJvpnmFo1
         6dFbC/a1RrsFYJQOUFrvJDA0EmaZpwO9Uv4jl03sO5D9MQtnUfyi0rfJed9uFUZfkvvN
         CNt0TObzEbIcaWItRJmXV/66Ez3/lVuuDGLOhPTPlOtMoPGniZyhR5N15gWKY1zSCJPm
         svkB8rRWeTOMXifrNlunceLr9w5K65Qo+3jTIrE9wcNXgJbEQo9eaa1lnUTlggwOaOVk
         VOcSIogTls/mf1BNjQPn4ZtHVqYTQRnazZvjAnAXGVJXZnRS9ZW58cs8yKVT7wb+lKOX
         32LA==
X-Gm-Message-State: ACgBeo0mbASKnj92mCp8PKIP7y7wFBLIZXi50QnS+tMa5+4/Z4foandl
        fmump7VKqExEOqWT6ArQnMGfbrKNsunVFq0Vr0Y=
X-Google-Smtp-Source: AA6agR6pybWVeUwFeyMejwFcXJWlJKlPIBFgxWzyUhjZE5326cYP+OKZqVrlvfa+B3c5ywobeAt0R3U2Ti4s1X9/4WE=
X-Received: by 2002:a17:906:dc93:b0:742:133b:42c3 with SMTP id
 cs19-20020a170906dc9300b00742133b42c3mr1123732ejc.502.1661819173147; Mon, 29
 Aug 2022 17:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com> <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
 <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com> <CAP01T74nPCXAeP=Aj09pW_Ykv5Rx2Y4U_fULQe+a4pWygVxaGg@mail.gmail.com>
 <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com> <CAADnVQL9g=PQzZK06FVOiCPBkM15AuyR6m0K5n5d8GtPBKnNAg@mail.gmail.com>
 <CAP01T76MUhBcWyTnCBMZ9e0xV3i00XZQBjVAnYrVab_Hgqhx5w@mail.gmail.com>
In-Reply-To: <CAP01T76MUhBcWyTnCBMZ9e0xV3i00XZQBjVAnYrVab_Hgqhx5w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 17:26:01 -0700
Message-ID: <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Delyan Kratunov <delyank@fb.com>,
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

On Mon, Aug 29, 2022 at 5:20 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 30 Aug 2022 at 01:45, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Aug 29, 2022 at 4:18 PM Delyan Kratunov <delyank@fb.com> wrote:
> > >
> > > >
> > > > It is not very precise, but until those maps are gone it delays
> > > > release of the allocator (we can empty all percpu caches to save
> > > > memory once bpf_map pinning the allocator is gone, because allocations
> > > > are not going to be served). But it allows unit_free to be relatively
> > > > less costly as long as those 'candidate' maps are around.
> > >
> > > Yes, we considered this but it's much easier to get to pathological behaviors, by
> > > just loading and unloading programs that can access an allocator in a loop. The
> > > freelists being empty help but it's still quite easy to hold a lot of memory for
> > > nothing.
> > >
> > > The pointer walk was proposed to prune most such pathological cases while still being
> > > conservative enough to be easy to implement. Only races with the pointer walk can
> > > extend the lifetime unnecessarily.
> >
> > I'm getting lost in this thread.
> >
> > Here is my understanding so far:
> > We don't free kernel kptrs from map in release_uref,
> > but we should for local kptrs, since such objs are
> > not much different from timers.
> > So release_uref will xchg all such kptrs and free them
> > into the allocator without touching allocator's refcnt.
> > So there is no concurrency issue that Kumar was concerned about.
>
> Haven't really thought through whether this will fix the concurrent
> kptr swap problem, but then with this I think you need:
> - New helper bpf_local_kptr_xchg(map, map_value, kptr)

no. why?
current bpf_kptr_xchg(void *map_value, void *ptr) should work.
The verifier knows map ptr from map_value.

> - Associating map_uid of map, map_value
> - Always doing atomic_inc_not_zero(map->usercnt) for each call to
> local_kptr_xchg
> 1 and 2 because of inner_maps, 3 because of release_uref.
> But maybe not a deal breaker?

No run-time refcnts.
All possible allocators will be added to map->used_allocators
at prog load time and allocator's refcnt incremented.
At run-time bpf_kptr_xchg(map_value, ptr) will be happening
with an allocator A which was added to that map->used_allocators
already.
