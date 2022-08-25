Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E695A1658
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbiHYQI1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiHYQI0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 12:08:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB0B2CE3
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 09:08:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay12so10478834wmb.1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=qJFXiUbKt6w02mRtcY69k1GXz5OpuUxZn1hBK0D9aVg=;
        b=fOB1Kxvj6JQgB5F5ehnFtl/KkSRt44hjSwcbLxUyvY3/7rgocYtN/pBviaklr3QST8
         aZA8NqIT7p57MA78z1DxCbmtoaRuZxR+cTAtryAVjIl6n9Q8RPNZlfUyvBAmWSLQKwop
         SA4dtZLrvhUUHgvNFnoe9iO5jepcKoRiUAtUTbjcjO/7QIvHSEX4hBCUCLz7sekoaNBH
         WagZHeMUayNhDGhTijii9WRBuHvoLi8xHJX76rVhoo9SssWz4jE0z+cW/AYZhLbUvlra
         a6d1xxA73eFNIY73nw5f5GUtUFPuVe7uHsvs7h9x4jSWxRmNwhJCQaukXxHe/PftoxK9
         lr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=qJFXiUbKt6w02mRtcY69k1GXz5OpuUxZn1hBK0D9aVg=;
        b=lTIQbUh/DodvFHDiM+FX1ZMscK5JNx0CTkTmtxO/+nmpB+ry0Zf0Nh1osx6hYWs/hk
         7onzcBJYuCAN2L86V6frmMgOJwtT7vPfFAI2QDRuept8G/TItwyAFBBHSeteWe1p/fhv
         sdMGPQoA/wHo65bUv5YK48+PO/ff07EYZqKI7Y8RFgnc7Vccn3S9vbao8Q/RoRz59b7y
         xJmEZHyZk5Szi37r1gKvV6BgFuVKic7ju/nxOH279gTvDA2i8k/vTNWvxQOfHUUQAZHr
         hEl2TBMF1yqfS06HfqRa2btSR+SUqo7jIs8JNwS7WFa76dXV80BwiWniWNIBRQEZiBTh
         XxrA==
X-Gm-Message-State: ACgBeo3DgiiWQbLersCmGf7Ecao05CKV+7rwx4k/UMfUclKczH8RNz0U
        7Sziw9ggp+Ym0bSoaXxn4aI=
X-Google-Smtp-Source: AA6agR7NUOMxc7LhqRZP3M/TNtEaVgKJsWJROyKd5eYVqRDEa3wok8XFKwgQ1zyC3I/Hk95F1lCV6A==
X-Received: by 2002:a05:600c:a149:b0:3a5:dab4:9d03 with SMTP id ib9-20020a05600ca14900b003a5dab49d03mr8678029wmb.124.1661443703116;
        Thu, 25 Aug 2022 09:08:23 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id l5-20020a7bc445000000b003a5fcae64d4sm5493117wmi.29.2022.08.25.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:08:22 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 25 Aug 2022 18:08:20 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC PATCH bpf-next 10/17] bpf: Add support to attach program to
 multiple trampolines
Message-ID: <YweedGDaL7yI382D@krava>
References: <20220808140626.422731-1-jolsa@kernel.org>
 <20220808140626.422731-11-jolsa@kernel.org>
 <20220824012237.h57uimu2m3medkz5@macbook-pro-3.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824012237.h57uimu2m3medkz5@macbook-pro-3.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 23, 2022 at 06:22:37PM -0700, Alexei Starovoitov wrote:
> On Mon, Aug 08, 2022 at 04:06:19PM +0200, Jiri Olsa wrote:
> > Adding support to attach program to multiple trampolines
> > with new attach/detach interface:
> > 
> >   int bpf_trampoline_multi_attach(struct bpf_tramp_prog *tp,
> >                                   struct bpf_tramp_id *id)
> >   int bpf_trampoline_multi_detach(struct bpf_tramp_prog *tp,
> >                                   struct bpf_tramp_id *id)
> > 
> > The program is passed as bpf_tramp_prog object and trampolines to
> > attach it to are passed as bpf_tramp_id object.
> > 
> > The interface creates new bpf_trampoline object which is initialized
> > as 'multi' trampoline and stored separtely from standard trampolines.
> > 
> > There are following rules how the standard and multi trampolines
> > go along:
> >   - multi trampoline can attach on top of existing single trampolines,
> >     which creates 2 types of function IDs:
> > 
> >       1) single-IDs - functions that are attached within existing single
> >          trampolines
> >       2) multi-IDs  - functions that were 'free' and are now taken by new
> >          'multi' trampoline
> > 
> >   - we allow overlapping of 2 'multi' trampolines if they are attached
> >     to same IDs
> >   - we do now allow any other overlapping of 2 'multi' trampolines
> >   - any new 'single' trampoline cannot attach to existing multi-IDs IDs.
> > 
> > Maybe better explained on following example:
> > 
> >    - you want to attach program P to functions A,B,C,D,E,F
> >      via bpf_trampoline_multi_attach
> > 
> >    - D,E,F already have standard trampoline attached
> > 
> >    - the bpf_trampoline_multi_attach will create new 'multi' trampoline
> >      which spans over A,B,C functions and attach program P to single
> >      trampolines D,E,F
> > 
> >    - A,B,C functions are now 'not attachable' by any trampoline
> >      until the above 'multi' trampoline is released
> 
> This restriction is probably too severe.
> Song added support for trampoline and KLPs to co-exist on the same function.
> This multi trampoline restriction will resurface the same issue.
> afiak this restriction is only because multi trampoline image
> is the same for A,B,C. This memory optimization is probably going too far.
> How about we keep existing logic of one tramp image per function.
> Pretend that multi-prog P matches BTF of the target function,
> create normal tramp for it and attach prog P there.
> The prototype of P allows six u64. The args are potentially rearding
> garbage, but there are no safety issues, since multi progs don't know BTF types.
> 
> We still need sinle bpf_link_multi to contain btf_ids of all functions,
> but it can point to many bpf tramps. One for each attach function.
> 
> iirc we discussed something like this long ago, but I don't remember
> why we didn't go that route.
> arch_prepare_bpf_trampoline is fast.
> bpf_tramp_image_alloc is fast too.
> So attaching one multi-prog to thousands of btf_id-s should be fast too.
> The destroy part is interesting.
> There we will be doing thousands of bpf_tramp_image_put,
> but it's all async now. We used to have synchronize_rcu() which could
> be the reason why this approach was slow.
> Or is this unregister_fentry that slows it down?
> But register_ftrace_direct_multi() interface should have solved it
> for both register and unregister?

I think it's the synchronize_rcu_tasks at the end of each ftrace update,
that's why we added un/register_ftrace_direct_multi that makes the changes
for multiple ips and syncs once at the end

un/register_ftrace_direct_multi will attach/detach multiple multiple ips
to single address (trampoline), so for this approach we would need to add new
ftrace direct api that would allow to set multiple ips to multiple trampolines
within one call.. I was already checking on that and looks doable

another problem might be that this update function will need to be called with
all related trampoline locks, which in this case would be thousands

jirka

> 
> Hopefully the bpf_tramp_id concept won't be needed.
> It's bpf_link that will keep a link list or array of btf_ids and tramps.
> bpf_tracing_link_multi ?
> link destroy is simply going over all tramps and removing prog from them.
