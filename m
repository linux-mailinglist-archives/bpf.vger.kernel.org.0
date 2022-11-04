Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2BE618F6A
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 05:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKDEJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 00:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKDEJg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 00:09:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7FB1EC42
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:09:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id 13so10349745ejn.3
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 21:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rwwxg0EL6fD56ISk7wBtu8my4uD0oAkiL/InO8sIGk8=;
        b=bbdH0BSSHvKatY8PJVM5CPZ5m8dpbVMmPMvY6+ofW6W67DY2JoWmimZufsgOYqFKs7
         Q8BpVGxvZjPpu+zJkcikC0G79qBL2NJ3eoi5Ij6LHUSdlWBv0MXQDYaeKN12lMqFkse2
         AT2BsenBk+XBPDCC1pIsFWySPEPvFLvVAN2idW28bHhR5ndpGIPfUPNQ/LFjLUiKUDqk
         7A9Qvof/QU/xl/EqiPXnd1SZeW7+CbIOvkP2wMYQ8SUapQ7b/40ZC60YjQO8p+oJdjqz
         2qYet3fGUsrAiJxqbSOOAOVl2546wiRYymgAUi4iZ1YU2n9o70ijmtwhiAOLLNmvZpVH
         YUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rwwxg0EL6fD56ISk7wBtu8my4uD0oAkiL/InO8sIGk8=;
        b=3ELmQ9RZO2PnwNM0RgxLvCsE26vSz1EJjDf7azytI9ipkyGS/7ifeBdX5D8/BeZrev
         0yUA+Q1vTPAunw1cpTqCwxPAcDlUIKoqrZ7phoHltC2RqBPmSrkgzMQcJom7xV5aSAAO
         wZWwEmuI58a15T5NY7+Ws6GYeUVygBWL8p/xaLHVnHuQ3n+hg9+YekF3G1rt/oJV4c1H
         m4/wkdRiarnbAkkiwwUqKSRAdv2x9XtpgNjFIz7xNq4p0yHnA2W9nH36zsnAhIjZgWH1
         rsCUv9WBT1VSlNBVYmW2wBmgLVLECHVTXqhH2gR/kz3wbr+QQNeD2aBchuu+EUKqU5yp
         Qq8g==
X-Gm-Message-State: ACrzQf1j7J/zaMPYAGB5HTzYIPUvGE+nfgg/Urho4k6TNRa8lJcLlr1w
        hxDIJcP2/qRm6p0trGVOlMh9FzXTAUhF1JTqnL4=
X-Google-Smtp-Source: AMsMyM4Vs918RsIJtpg2B/v7yx5uVDNZuIDbmX9n0ld6WY3C15RRIJwRIRmCDiYfcvJryyjm7kvqDYu3eOR+njLUoh8=
X-Received: by 2002:a17:906:1f48:b0:7ae:77d:bac with SMTP id
 d8-20020a1709061f4800b007ae077d0bacmr11193055ejk.708.1667534974027; Thu, 03
 Nov 2022 21:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221103191013.1236066-1-memxor@gmail.com> <20221103191013.1236066-7-memxor@gmail.com>
 <20221104040058.mo4r62wf72clvhcb@macbook-pro-5.dhcp.thefacebook.com>
In-Reply-To: <20221104040058.mo4r62wf72clvhcb@macbook-pro-5.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Nov 2022 21:09:22 -0700
Message-ID: <CAADnVQJ1TnKYdJ=--BVAw7Y24rkAohX+4zSYbWc-TjDHWJROvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/24] bpf: Refactor kptr_off_tab into btf_record
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Thu, Nov 3, 2022 at 9:01 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 04, 2022 at 12:39:55AM +0530, Kumar Kartikeya Dwivedi wrote:
> >
> > -enum bpf_kptr_type {
> > -     BPF_KPTR_UNREF,
> > -     BPF_KPTR_REF,
> > +enum btf_field_type {
> > +     BPF_KPTR_UNREF = (1 << 2),
> > +     BPF_KPTR_REF   = (1 << 3),
> > +     BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
> >  };
>
> ...
>
> > +             for (i = 0; i < sizeof(map->record->field_mask) * 8; i++) {
> > +                     switch (map->record->field_mask & (1 << i)) {
> > +                     case 0:
> > +                             continue;
> > +                     case BPF_KPTR_UNREF:
> > +                     case BPF_KPTR_REF:
> > +                             if (map->map_type != BPF_MAP_TYPE_HASH &&
> > +                                 map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> > +                                 map->map_type != BPF_MAP_TYPE_ARRAY &&
> > +                                 map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
> > +                                     ret = -EOPNOTSUPP;
> > +                                     goto free_map_tab;
> > +                             }
> > +                             break;
> > +                     default:
> > +                             /* Fail if map_type checks are missing for a field type */
> > +                             ret = -EOPNOTSUPP;
> > +                             goto free_map_tab;
> > +                     }
>
> With this patch alone this is also wrong.

Actually this bit is probably fine. The bug is elsewhere.

The point below stands:


> And it breaks bisect.
> Please make sure to do a full vmtest.sh for every patch in the series.
