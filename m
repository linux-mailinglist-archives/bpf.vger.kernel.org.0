Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D09262A2A1
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 21:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiKOUT1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 15:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiKOUTT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 15:19:19 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D88C2C640
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:19:17 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id z17so10293953qki.11
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg2p+d9BTb0sDApPTHD/FCt+oKLyPxzeDhZVVD2/bvE=;
        b=oiqPPIadrE290wPskdviykHavn9ie2jg0rNWMYK9DXxkRRR5tL5u9Kw+40VMQRXpmL
         YmsMd8l3Mf8tjrJkkcHRF6R+7wPaIJyTLZQgVBN63Q0ORPLENmAneLpIEkVzgZVCHc1q
         qP134upef1/dOr0KiaCmgyRw32zBGSUjIj+RW8EyhD6AmG1ALBAp5ZMZVVcqPW4k7oXl
         WyEiFqr8hYuwz3mxKQvX1R3J2/td4P/VwOnOpoJdILskAx2wLAZD4Gjqym6vT26ewMYN
         Bh6n0Hqs1KawTr8ny/W90JyNL9fLYsJP2bonXx6RViN23LL8IzNyWDH1WseVubeuw2eB
         mDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kg2p+d9BTb0sDApPTHD/FCt+oKLyPxzeDhZVVD2/bvE=;
        b=WwnqHZjBq9a0xay5VNkYP3nHG5Piq/b0YbIKDt6Da1nAgvgr0epVSokRH2Xni9gr9C
         Nj2ym44oOUTfFO1dbU80hfdySaLxQgPqeOdyC/rAUfdmGEjk8Xw6GC8jpIlZOARlFYnU
         LBcoqVoO9j57/u+4P2/y2I4RgKUjjhqzk+FQwNtgcyWsfSyg8R6JLHVTh9ZwChuvJi6R
         60v1aLFxg9SZ/gwyEJ2Qdzt6FzgTXElsC7rqcSUVvZ52LWm6D9198IGqvtBflrC2AmtF
         hKTIovWUQxFLqkAa40uAdkqlqdUs8kWP4bUjHogE4PP6UXaDOYJAeBtuCEoLj7BGUJaZ
         huDQ==
X-Gm-Message-State: ANoB5pmK2YUNpHkswHmt8rShRR7q7YgUbmPaDajRgbsh48jx3MfBkAdK
        vv1lsd8rvYeyr8O64NRXJn6OewI0qoIpo1+wZeUDjA==
X-Google-Smtp-Source: AA0mqf4+NeFrs5IgilPztvEth+wuzXVCXKXZ6fBBFSO5bfaH4DFrSE079OowKhwnTee84fmxGXSVssJQy4r8nWe0Mms=
X-Received: by 2002:a05:620a:4895:b0:6ce:2d77:92d0 with SMTP id
 ea21-20020a05620a489500b006ce2d7792d0mr16761581qkb.713.1668543556542; Tue, 15
 Nov 2022 12:19:16 -0800 (PST)
MIME-Version: 1.0
References: <1668517207-11822-1-git-send-email-yangtiezhu@loongson.cn> <Y3PdlPVxobFMVYoX@google.com>
In-Reply-To: <Y3PdlPVxobFMVYoX@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 15 Nov 2022 20:19:05 +0000
Message-ID: <CACdoK4KEzd8w3pWjuGet-W3ZzAf+8uBpzngk_aX7_aBDYm4T5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Check argc first before "file" in do_batch()
To:     sdf@google.com
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 15 Nov 2022 at 18:42, <sdf@google.com> wrote:
>
> On 11/15, Tiezhu Yang wrote:
> > If the parameters for batch are more than 2, check argc first can
> > return immediately, no need to use is_prefix() to check "file" with
> > a little overhead and then check argc, it is better to check "file"
> > only when the parameters for batch are 2.
>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> Acked-by: Stanislav Fomichev <sdf@google.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks
