Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4147A59F0CA
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 03:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiHXBWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 21:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiHXBWm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 21:22:42 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200A953026
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 18:22:42 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v4so13697715pgi.10
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=w/YQjiFs5raxW2ANjKTkf7XNkMIar9sgHaIePVbpgSg=;
        b=lNnV2re5YKioOntotjhb1RdzpOC769uTka9lCDGw9yQxVB1K3QHBGDHbrE4QC8lesY
         YknFmKBL/YbdhMk2pCqYAdN3tXBWMt/yfmohrHuT8NB0Mn5ZR581f+OFqQzOkaSpLoHV
         pF44C16XBE7WiK3Bx/SReO4apEvbC27L9gopMAbfqRJDB1JBle/3nbQ4zX8d87J54T0n
         c9MOU3VA/FOqV188to34ZBOG6pJjMdNhZyOSGSyy19JvN7acl2ExRiRaGm+OaKFuUznm
         ArR78MQdg5OkLWEWmPQq+ylsRVQ0FVsh2bNO1UP+T0QaWgqojRKontDakOCuNthBqRt2
         ep/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=w/YQjiFs5raxW2ANjKTkf7XNkMIar9sgHaIePVbpgSg=;
        b=t+L46f4oduRVgdaMuTxnZCSAeDFTSU1HOssUQQO1XWmMqyqTGdd86NjIgF1nwmQ+/9
         svBNtPkaSVTPcWKT2nzMPY98JHMh9Q/dvdfqaXHkvCDoKKNzoM6Lhq92q7iaAOoIv+Zc
         6DR1165zJH7tyhbAVoWlZi2hLh/8fQi4u6cEs4Nb1pWGmB/ZgLqBlkjOU2XyGC+HZW8O
         MP3ce9PtvFA1wkUnPf+TV4mtGt7NCWYit9+HBpzxSfX4QVzr0mEsa8uQdm06wbdGOj5N
         RnGhVhjNwLpS/qlPq2UzxBVGsAud4NUVImk4nDFp4xU4YLVPGrdnnETqG6HHZ3JazL4l
         NNQQ==
X-Gm-Message-State: ACgBeo1tecegt3Rehkfxc+N36ltg3vkHArtWXv2LDnzYBEScjUYLh8N4
        IZ9ILUY/w46X/Ni6iaJvr2M=
X-Google-Smtp-Source: AA6agR469GgotXJNnbHLxbdL6J8eVnPigLAj2LW65XYPZHc7djr8TLtZUqvaXJOFuIzByZ54O58OsA==
X-Received: by 2002:a05:6a00:134d:b0:536:c434:4b6 with SMTP id k13-20020a056a00134d00b00536c43404b6mr9495390pfu.32.1661304161486;
        Tue, 23 Aug 2022 18:22:41 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:6341])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902aa8e00b00170a6722c79sm11036117plr.247.2022.08.23.18.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 18:22:40 -0700 (PDT)
Date:   Tue, 23 Aug 2022 18:22:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiri Olsa <jolsa@kernel.org>
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
Message-ID: <20220824012237.h57uimu2m3medkz5@macbook-pro-3.dhcp.thefacebook.com>
References: <20220808140626.422731-1-jolsa@kernel.org>
 <20220808140626.422731-11-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808140626.422731-11-jolsa@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 08, 2022 at 04:06:19PM +0200, Jiri Olsa wrote:
> Adding support to attach program to multiple trampolines
> with new attach/detach interface:
> 
>   int bpf_trampoline_multi_attach(struct bpf_tramp_prog *tp,
>                                   struct bpf_tramp_id *id)
>   int bpf_trampoline_multi_detach(struct bpf_tramp_prog *tp,
>                                   struct bpf_tramp_id *id)
> 
> The program is passed as bpf_tramp_prog object and trampolines to
> attach it to are passed as bpf_tramp_id object.
> 
> The interface creates new bpf_trampoline object which is initialized
> as 'multi' trampoline and stored separtely from standard trampolines.
> 
> There are following rules how the standard and multi trampolines
> go along:
>   - multi trampoline can attach on top of existing single trampolines,
>     which creates 2 types of function IDs:
> 
>       1) single-IDs - functions that are attached within existing single
>          trampolines
>       2) multi-IDs  - functions that were 'free' and are now taken by new
>          'multi' trampoline
> 
>   - we allow overlapping of 2 'multi' trampolines if they are attached
>     to same IDs
>   - we do now allow any other overlapping of 2 'multi' trampolines
>   - any new 'single' trampoline cannot attach to existing multi-IDs IDs.
> 
> Maybe better explained on following example:
> 
>    - you want to attach program P to functions A,B,C,D,E,F
>      via bpf_trampoline_multi_attach
> 
>    - D,E,F already have standard trampoline attached
> 
>    - the bpf_trampoline_multi_attach will create new 'multi' trampoline
>      which spans over A,B,C functions and attach program P to single
>      trampolines D,E,F
> 
>    - A,B,C functions are now 'not attachable' by any trampoline
>      until the above 'multi' trampoline is released

This restriction is probably too severe.
Song added support for trampoline and KLPs to co-exist on the same function.
This multi trampoline restriction will resurface the same issue.
afiak this restriction is only because multi trampoline image
is the same for A,B,C. This memory optimization is probably going too far.
How about we keep existing logic of one tramp image per function.
Pretend that multi-prog P matches BTF of the target function,
create normal tramp for it and attach prog P there.
The prototype of P allows six u64. The args are potentially rearding
garbage, but there are no safety issues, since multi progs don't know BTF types.

We still need sinle bpf_link_multi to contain btf_ids of all functions,
but it can point to many bpf tramps. One for each attach function.

iirc we discussed something like this long ago, but I don't remember
why we didn't go that route.
arch_prepare_bpf_trampoline is fast.
bpf_tramp_image_alloc is fast too.
So attaching one multi-prog to thousands of btf_id-s should be fast too.
The destroy part is interesting.
There we will be doing thousands of bpf_tramp_image_put,
but it's all async now. We used to have synchronize_rcu() which could
be the reason why this approach was slow.
Or is this unregister_fentry that slows it down?
But register_ftrace_direct_multi() interface should have solved it
for both register and unregister?

Hopefully the bpf_tramp_id concept won't be needed.
It's bpf_link that will keep a link list or array of btf_ids and tramps.
bpf_tracing_link_multi ?
link destroy is simply going over all tramps and removing prog from them.
