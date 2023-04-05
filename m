Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08586D84ED
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjDER3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjDER3C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:29:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404825BB7
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:28:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so142962320ede.8
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680715726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcQ9KITPeUpvvWZ3eJ0auiTIc6sndP1s7xyPLJr1jn8=;
        b=EKBmQ7w7IWQOxOTyyIA/WYcHiZWMxwVA3MMnilWnBmtB8YYg6bzNfys6ovigfW/xF5
         H5BYK8CbKaYDMTWJuhrjyxovc3MH62of0rOE4J7HZZbrfws77qd9HlGK0gMQ4Z0PUU3B
         Xoark5mZPGlfEMNbaYlq51D/qpnK7S3/fDeuhEZaC8OLNgCcKzvuX9nzKqQLS3++GEg5
         2gZUT6NqN3UcHj/cIeKVCYAEDLRmT6otgfbuxOM4xF9Havu+0UKUTiCiyVuSBd0cAYFu
         V9cc8bzgrnW59r2kaw+1CHB6byepmuIk45G0CuGPUmMjxzNMQLpOuPnWBc7XHrWB5iY7
         S4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcQ9KITPeUpvvWZ3eJ0auiTIc6sndP1s7xyPLJr1jn8=;
        b=Fib08DiCBgtHRx3C3bh6b0SLKv7rvEJM/Ihu6Ok9VkpZJE2VsnSpqcKqMhuXiFn6G0
         C0rr9ABbwVMynRyiCy/i3d99O1h9mTTeBe/VCspeIDa2RS5TpzY0fNzC0b0HD9mWQmph
         ydg7OI3JqqZ7L8qd7iB6q2EqvppsV0MnoFiG+x5YpBbQChMmO2KhW/RO3I4aDhe0CGjN
         Zy13cm7zLgWf2PHRGO8OxKzOZRdQ3Fd+TGvls4tLUkvFRI97scpeeyCTi1LQpZ4VJ2yu
         ZHCo0KbhWoPH+x+dzJCnrnXZwfsJXzGnHaxvzSEvNU1SUoMlYwIWirUJ+5aPelKvrPFJ
         fRJQ==
X-Gm-Message-State: AAQBX9c7Qrqijd3jy1O+sQbeYYWBcWP1g6F5onpUOu+bZXqPsBmH2tSh
        y+NX+wKAybNOmaOYGIf9U/wPPlLp7oiZeY2nxE4USQ==
X-Google-Smtp-Source: AKy350aGTQSXOCPxiOvTKwAsHiQgQL90ZtHCwi+416Kl5RnWTxQKnC6jcxo4s5CaIKDGUZCHAf1UpLhsvw/EB3Jep3s=
X-Received: by 2002:a17:906:dcf:b0:932:6a2:ba19 with SMTP id
 p15-20020a1709060dcf00b0093206a2ba19mr1983441eji.14.1680715725790; Wed, 05
 Apr 2023 10:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-11-andrii@kernel.org>
In-Reply-To: <20230404043659.2282536-11-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 5 Apr 2023 18:28:34 +0100
Message-ID: <CAN+4W8hdNudL+UvuhnYFgG87QzNY1feCkYn1vJ3RD1ZQX2+9kg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/19] bpf: simplify logging-related error
 conditions handling
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Move log->level =3D=3D 0 check into bpf_vlog_truncated() instead of doing=
 it
> explicitly. Also remove unnecessary goto in kernel/bpf/verifier.c.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>
