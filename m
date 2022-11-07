Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712C061E9D3
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 04:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiKGDpl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 22:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiKGDpk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 22:45:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2029A64F8
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 19:45:39 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id sc25so26742448ejc.12
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 19:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wzXJe4vSJV0lP+RBL9a1mv2oJi4SQ63KIQ8gcevBG8A=;
        b=Cwx/YL43BiuEmm/PUmVHB9s8/T6VMvxtNeCfMGS7oYRE60/+1Z54l/2XfowvxJ8TGX
         OePfVUKnW0G8D8rHlyDhcLqv6jM5jPdKWVRGG/ap9rx4N557pU8yOYNPU0tIo+5FB0vJ
         WyiEpqtcHJNlAmH2pgBeEoUb74LH7531C8GmsAiNT1MnGlCLEiNVdJMRsZt8rQx6Gqs7
         bh8PY8EN1pwHH1C+NCmilYbtBxd/Q47KH0C7MTgID+2KHkttMw8Ml08wUVl0rgpBcFzZ
         cfG1QJV9K2tFuAEDfJDDtbnltnqQbwhjA5THgsnEku0epLwL+Y1piyUSevDi39nq5UTh
         XcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzXJe4vSJV0lP+RBL9a1mv2oJi4SQ63KIQ8gcevBG8A=;
        b=ECmCo+bNmEO1wYlqDtuaE2WX6f9TU3EYyaJuD2yHoXFr169eq9576P97IeLV+4AbQN
         jArSjbyuHMCBDZBPXDJLBillqGffDBd2wWI+bk4eWvcOM9t8ipRC882LM6KZCLWyra7a
         Gpv1PikrHXJgG87r2dGknTZOqeUqYvDJEfgUXBTmXCeRg1ZDPOBh+uwMN+bJGjdyD6rI
         NMdwyuaGXIhvMwYTmNBAAdeln+R8wyiWT8I2cXHe3LNjrNk6qrCNwCp0R9uMsmElmIPj
         c6HxBmJCNf/lJScdJYoTVaHXv+jKhGla6WeNMVANjlz5qRrTlwL2EvnILM5jEMYzSp60
         si7w==
X-Gm-Message-State: ACrzQf2HsVUz8X8J3Lh4LYt7LBBWHrk3ihfn1Yr2LqKdQrHswEqu8WRD
        aSvP+C7yOzhMKHMfMcDEPhwOmhiTZSkLc7toqycFWDUYlmg=
X-Google-Smtp-Source: AMsMyM5pCrGiRc9mUMcU07MmosUqeEmFRgMIMkdJ7cdi3jdbdm621Y5Z+YCPtpcg/ISYUGknxoWIaCAzIGFIN/ki5a4=
X-Received: by 2002:a17:906:8a73:b0:7ae:3962:47e7 with SMTP id
 hy19-20020a1709068a7300b007ae396247e7mr13471906ejc.502.1667792737465; Sun, 06
 Nov 2022 19:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20221106015152.2556188-1-memxor@gmail.com> <20221106015152.2556188-2-memxor@gmail.com>
 <CAADnVQ+iuB6abH0=N0su6DGAW1FnOtgUQ+Zq6x9bH1w5X_6P=w@mail.gmail.com>
 <20221106214444.nbqh4qdpsoaj5t7s@apollo> <CAADnVQLiPdCZSiGsy7rUWttpM+iuXp+2BJoaHqR_ajc4K-xuWw@mail.gmail.com>
 <20221107014851.fofi3xxqlludjgez@apollo> <CAADnVQKyUKeEs14uzcHKym3iVtjV1DU2HkitPc+NvV8RUZW=Pg@mail.gmail.com>
In-Reply-To: <CAADnVQKyUKeEs14uzcHKym3iVtjV1DU2HkitPc+NvV8RUZW=Pg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 6 Nov 2022 19:45:26 -0800
Message-ID: <CAADnVQKGd20kh_4xcEFMi365bOt0KtDwkYnzZsZP=vioVX3mGw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 1/2] bpf: Fix deadlock for bpf_timer's spinlock
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 6, 2022 at 6:34 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> > For bpf_timer, it would mean moving drop_prog_refcnt outside spin lock critical
> > section. hrtimer_cancel is already done after the unlock. For bpf_list_head, it

> > would mean swapping out the list_head and then draining it outside the lock.
>
> That also works.
> drop_prog_refcnt() can be moved after unlock.
> Don't see any race.

I mean not the whole function obviously.
Instead of
static void drop_prog_refcnt(struct bpf_hrtimer *t)
it can become
static struct bpf_prog *drop_prog_refcnt(struct bpf_hrtimer *t)
t->prog and callback_fn should only be manipulated
under lock.
bpf_prog_put itself can happen after unlock.
