Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8020259BB25
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 10:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiHVINY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiHVINT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 04:13:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1405EBC
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 01:13:15 -0700 (PDT)
Date:   Mon, 22 Aug 2022 10:13:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661155992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RI1W1r/JnH//TPAVyLGoon8Y+va5356A9zQiPWsRzIk=;
        b=edIuPg5+y7TQFs7J2ea5iuQDFnfdQa+iz7Pi23PR8wGozdwXUpeewZSNVADeGMu2aJGO2h
        OexqOxtvVGfAtD/zn3OsnucyRo23w7+M7GLwRHJTYJV/YsjrsQUSEwfRCwWcmSZmXWNUgt
        Tvc0weV9wcN2XwfaLMgMRHliTr1aCI2HO8E93Z+sMQpW0X2ven/LWDSHKbmIrfVVFXOMEJ
        X8NWy0X0k/lOs7q6goZ5umifn0NXJHUYX+hKWBVwXsISkRyHJF7f04Nb5ni37YaiC389Tg
        EqZIRziAxHYmGaiRysetOboGtCkaZNNaVKsYlMm9uuGfjlJU+M2PuXhm8VNr9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661155992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RI1W1r/JnH//TPAVyLGoon8Y+va5356A9zQiPWsRzIk=;
        b=ZPL0Bj4MhR/rlrqMhImoUjPYrdFsP6xz3/pCfx8e1xHYiWre1qzNgq08g0gOpVYAyHc7DN
        pGVhGi5NfPn/dCAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Sun <sunhao.th@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: Re: [PATCH 1/3] bpf: Disable preemption when increasing per-cpu
 map_locked
Message-ID: <YwM6l7MxTe47fzFZ@linutronix.de>
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220821033223.2598791-2-houtao@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022-08-21 11:32:21 [+0800], Hou Tao wrote:
> process A                      process B
> 
> htab_map_update_elem()
>   htab_lock_bucket()
>     migrate_disable()
>     /* return 1 */
>     __this_cpu_inc_return()
>     /* preempted by B */
> 
>                                htab_map_update_elem()
>                                  /* the same bucket as A */
>                                  htab_lock_bucket()
>                                    migrate_disable()
>                                    /* return 2, so lock fails */
>                                    __this_cpu_inc_return()
>                                    return -EBUSY
> 
> A fix that seems feasible is using in_nmi() in htab_lock_bucket() and
> only checking the value of map_locked for nmi context. But it will
> re-introduce dead-lock on bucket lock if htab_lock_bucket() is re-entered
> through non-tracing program (e.g. fentry program).
> 
> So fixing it by using disable_preempt() instead of migrate_disable() when
> increasing htab->map_locked. However when htab_use_raw_lock() is false,
> bucket lock will be a sleepable spin-lock and it breaks disable_preempt(),
> so still use migrate_disable() for spin-lock case.

But isn't the RT case still affected by the very same problem?

> Signed-off-by: Hou Tao <houtao1@huawei.com>

Sebastian
