Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB800617F91
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 15:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKCOaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiKCOac (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 10:30:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79571759F
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 07:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81C52B825E5
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3177BC43145
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667485828;
        bh=l75YDmSSQ6EVuls44rNs5CILWC9+kQ7tTBi958tg7+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BY8vuYD0/q+dm+3JR2ZXKrbj29fk9onqUSIryyQ26VeiRDLbBVrIXc28f+qMddqT+
         c1+mEiVcBuEDmwAqb/SV/s2jTxvDBdyBvs+pjz6seFql3fysnwzTnkIEEI1SEgw46u
         MO+WmAtPUFgVwFjqlolQOkfaQXblb6BYs3KCYCa3X6ElAvZ6dNA+jwMX+6n14rDv5/
         syXeqw1mYSy7GBtmpbTAPPkr/18KCeA1YbO3/kPahpsuwfb/oV7kNeawjIaNKI2vVS
         wkRFAMsXM4gjZWcEPiybB78qkyse1eBEkRBJj+xGge7LYbYjA7udH9V9yelc6tkBcl
         zCibFj7R4yoIg==
Received: by mail-lj1-f181.google.com with SMTP id t10so2487935ljj.0
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 07:30:28 -0700 (PDT)
X-Gm-Message-State: ACrzQf0/naSXvctzceS18VA1+TGkuOikWQ6ckSs1mHp9kYKGlEMNcC3U
        nR7bB5BbGU1vTvEMV6OEBD3C/X+ifQey9GiL9lP49Q==
X-Google-Smtp-Source: AMsMyM6phbAMz5Tbjgm3ZYnC7KpjAwwzR9lBnmWBpS0elTeIiEUyOkvkxgvkHpBqsi+8D895Rix+LhZHAnfMFej0Epg=
X-Received: by 2002:a2e:140a:0:b0:277:23fe:8794 with SMTP id
 u10-20020a2e140a000000b0027723fe8794mr12446943ljd.156.1667485826228; Thu, 03
 Nov 2022 07:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221103072102.2320490-1-yhs@fb.com> <20221103072108.2322165-1-yhs@fb.com>
In-Reply-To: <20221103072108.2322165-1-yhs@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 3 Nov 2022 15:30:15 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7ZY-qPvntQJLa8F7Ta-e4j9_FU9bHpq_O5Sgw5-F6Scw@mail.gmail.com>
Message-ID: <CACYkzJ7ZY-qPvntQJLa8F7Ta-e4j9_FU9bHpq_O5Sgw5-F6Scw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] compiler_types: Define __rcu as __attribute__((btf_type_tag("rcu")))
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 8:21 AM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, without rcu attribute info in BTF, the verifier treats
> rcu tagged pointer as a normal pointer. This might be a problem
> for sleepable program where rcu_read_lock()/unlock() is not available.
> For example, for a sleepable fentry program, if rcu protected memory
> access is interleaved with a sleepable helper/kfunc, it is possible
> the memory access after the sleepable helper/kfunc might be invalid
> since the object might have been freed then. To prevent such cases,
> introducing rcu tagging for memory accesses in verifier can help
> to reject such programs.
>
> To enable rcu tagging in BTF, during kernel compilation,
> define __rcu as attribute btf_type_tag("rcu") so __rcu information can
> be preserved in dwarf and btf, and later can be used for bpf prog verification.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: KP Singh <kpsingh@kernel.org>
