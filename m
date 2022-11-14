Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81635628B7C
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 22:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiKNVno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 16:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbiKNVnk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 16:43:40 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77906418
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:43:38 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id z17so8340345qki.11
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCaFzGyMxbaD6kfi3xwQEpdP9ekJ88yWXsVcB45Tgvk=;
        b=4jvcS5kw8qUIrclZg9RGW3EIN3B+5rYRi1ot35tHG0HkEu7brOjZydezNT2IC3Ts7W
         ev6XNIYElBRLiv+CDIlKoHt4xGxi2DddpVz/hGiH2OAgYrB9Kad5AaZYDZGLV0blXxEX
         fTs8NJTBkyvchWdTlwyWByCkTmVxy9jb1SkXn+8omytLO2dWu8nnYan6WWyp+k8dqWI5
         iLKb+eODZ7jOa/0Gz11Gns4wtBdwBG86aVfYGQX/8aFFuxsfxZoXBDhV3mBW8VniaCvw
         Xkm4YC7GKCr+kXGWYZkFMLgXaZEnohIEHAHXtjjoFNvHCNSpSFJTmoQ3i0nXYT35B5A7
         z8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCaFzGyMxbaD6kfi3xwQEpdP9ekJ88yWXsVcB45Tgvk=;
        b=FB6WaapLKZexhGXZCCsTvKHKjuWAtaNANhZ1EF4lA/YT5ylcN/EYR3ZwkWTJuBivjD
         qCCJMibRKP8cioswGlmUszDlx0ysLcpTX6JNjNqkMxHEP/5Qx+2iRVrSkSvDMQNcBbow
         UT0XrTlwu+0cgIJhjiHamVIZlgzPNeA2s0hsK3+py8HRBsGVPPX8Zuq03qOWQVG4UHtX
         fweNTyWq5QENDwKoyo6056GqEU3p8WChBgPYj+WT2a7OJqW85ovYJD1FzWxZFOlTqAzS
         ubttOR098+xeGhpNepVMb/qe756Q4zCAClF/ufNC+ghIk4YgNaO/tVOkECbNTDzS2BBb
         l/eQ==
X-Gm-Message-State: ANoB5pm6lt35ITsbaswA4xq9lKWe1wATT+qfblcITNf86rrEOEPiBnfw
        VXP/+ufCHIZzHZ1d0fo5BxD2k5aqPg+gA2PANSrdAG8/x3TXHA==
X-Google-Smtp-Source: AA0mqf40uqe+wiya3Q4O3a4mz4YV8mJXtN8uT7S35eUQWqW3wPsZqcIPbiv70niaEuAgmJ/3+0gU9/w2aGEVs2B2/zw=
X-Received: by 2002:ae9:f815:0:b0:6fa:2b22:ff3e with SMTP id
 x21-20020ae9f815000000b006fa2b22ff3emr12480321qkh.200.1668462217832; Mon, 14
 Nov 2022 13:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20221113101438.30910-4-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221113101438.30910-4-sahid.ferdjaoui@industrialdiscipline.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Mon, 14 Nov 2022 21:43:26 +0000
Message-ID: <CACdoK4LmoqxVBxdOZ1WwiiNw7XnOn=fqHHPfDEfBRi705k80jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpftool: fix error message when function
 can't register struct_ops
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 13 Nov 2022 at 10:15, Sahid Orentino Ferdjaoui
<sahid.ferdjaoui@industrialdiscipline.com> wrote:
>
> It is expected that errno be passed to strerror(). This also cleans
> this part of code from using libbpf_get_error().
>
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>
> Acked-by: Yonghong Song <yhs@fb.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks
