Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7626ED587
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 21:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjDXTtv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 15:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjDXTtl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC645FF0
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:49:37 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a677dffb37so42549345ad.2
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682365777; x=1684957777;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncXeF8+lSv+yUHjZGKkNhp0Jv9CE7Y6CwXT+QMlocgs=;
        b=ioI2c6rKmrBM7w5lAyzS3elYoLlGr4WX7+PFpkRPWL06xjkVAh74juiPP2bN+sFz8w
         TdeqNYyDXb+x8YFDGK9OcsCriKiLWT704o22ueLXUGib9SE4BlBIDVwa+b+nMgbMBZDy
         wzaOuGVrIa11p7O1XXh0H+z1Al2Ucow3Iz+MFstLc9E26oL7VAkb4C9Q+Z25SGP0ypUd
         eLcMT5G9MvFlrVJZcZ73cIPT8oPX0DI5VDN2Yk+fXogP9yUcfzktu3M8RLFZvTYrStkD
         yOQTy1La/a9NFB9oaWH3m322ZsFkzfxwHvgzXR5hV6FU52UjNleJBd1P5BaggMY0yR11
         A6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682365777; x=1684957777;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ncXeF8+lSv+yUHjZGKkNhp0Jv9CE7Y6CwXT+QMlocgs=;
        b=FIMoUy+uwXWAXTiZouLnnPNxMWnSPZDOCW2y7M1zb75TC1CR22+iFhsRV3DF1+fpA4
         fj0azQzNGK5pOklGYTsErqpNM7V7FATCXsgL2FNfmYJB2kR/XgMd4hmWqi3t3+6936Iv
         scBrvTpb+YVyw/J9zOr1OpTYZiHpSBVsWXIM5Pm2Q42aPVXL0Tx3KMY6vQCy85a5iryZ
         PCbO9DrjGr/lIDzKGG2epHIpEclVo3+eNro/MxjvJVhoiPQLTRDx7dhPd+mrrRfb2BEr
         Lurvm4Hzo5DwvonzVNWHnn7lZHea4yu0u4Z7pWOWNhdPzXhRDCEpawtryUPwKE9/uDaT
         IJIA==
X-Gm-Message-State: AAQBX9f0MEF8OkqfUpJ9WJDPybiHzvGIrxldEhiQYFu6vBclhOK0M3wT
        vInhyGX3Mvarly80HFPViTuHV8UVIc4=
X-Google-Smtp-Source: AKy350aDTINZgc1Nj6WKEzmVblq3CYB+DNrwsSkYJIagd1OcMyS9TIYqFRebDlxGjuQYQkEWba4txw==
X-Received: by 2002:a17:903:24e:b0:1a6:4a64:4d27 with SMTP id j14-20020a170903024e00b001a64a644d27mr18782941plh.40.1682365777414;
        Mon, 24 Apr 2023 12:49:37 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:d8b6:344e:b81a:e8b5])
        by smtp.gmail.com with ESMTPSA id bd2-20020a170902830200b001a68d45e52dsm6901912plb.249.2023.04.24.12.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:49:36 -0700 (PDT)
Date:   Mon, 24 Apr 2023 12:49:35 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Message-ID: <6446dd4faa312_389cc208c3@john.notmuch>
In-Reply-To: <20230420071414.570108-3-joannelkoong@gmail.com>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-3-joannelkoong@gmail.com>
Subject: RE: [PATCH v2 bpf-next 2/5] bpf: Add bpf_dynptr_is_null and
 bpf_dynptr_is_rdonly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong wrote:
> bpf_dynptr_is_null returns true if the dynptr is null / invalid
> (determined by whether ptr->data is NULL), else false if
> the dynptr is a valid dynptr.
> 
> bpf_dynptr_is_rdonly returns true if the dynptr is read-only,
> else false if the dynptr is read-writable. If the dynptr is
> null / invalid, false is returned by default.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
