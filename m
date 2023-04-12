Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F315E6DFBCB
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjDLQuq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjDLQuk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 12:50:40 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75816728A
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:50:15 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54ee0b73e08so232870517b3.0
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681318158; x=1683910158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8x2GYQVTWi+sPNYvJWEXQwUM4/xewwyCUDz0TcH8TOo=;
        b=K6l7g0Yj4XlJqjAsyHyWP+Q1rL9gJtHxD1PnxWOB3Q7aHr+SYV9cIBfSPEOu9Nx5k1
         UbHIT8aHIROyoCvDEUMRaT348cFCflSr5lG/byaxjgOTXyGRGGL7JSjPpoenu7LHieTq
         V2eRmw7klQlY++6lH9RMNUxrJyuPhVLhLvocwndrawpEtqiKc6KRi0SofZhGrsicNbno
         +jbxiR+iaUQwpiscPx9oZ3A031YDcBndEmEmk7kK02NxmotA7B5EZobCi1pNG/Pl5DN/
         8Vur2y1JAU+LAzV78OPE/yUndwunnnm0A5aw3gzV7VjAuNrLE4rE6VrllMOWDWCMUrd1
         KSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681318158; x=1683910158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8x2GYQVTWi+sPNYvJWEXQwUM4/xewwyCUDz0TcH8TOo=;
        b=ZXCOG6SCLpnpps0YR3T17ixY4daCLdHy5bb/nhG65u1+MOi/bPWHWT5rED/WiUq8mJ
         VJIqsb8pTT8zEfahU57y60hZaAPHnP7HVrSpB/reYjSY7w3U43P2cxlmRMFmK7U0OlsU
         wiGXsa3z4wFXnd0AaC5MHYy1tfDJHcq0AJUWeq0baUPaan4CUyTK2cPZdeqx1BvEdtvT
         L+5YlZouVuBO7dPoFvwJIh+ins+mAuIGfeGJyOFKu1ILieElLNRW4Yeq9V0uOhN4od7m
         u4RTFhxM+h9T9y6LgUjwzpLa8Xamw7z1b7i6Yb4BT1TB93yIAwaeZYEVaV54jPlqdy+e
         1j1w==
X-Gm-Message-State: AAQBX9d2+NfLQpe3V5rCHnEbY5K+3WxXPazB309AL90hFVD8OsF8eHKH
        pJPcmmtaNWNMth3lo9slO2n/64dhAK6+Nmm+adsi
X-Google-Smtp-Source: AKy350ZDdYjcoWPVpXbg3FDE6dTQVUa/J9xJsjd6TMn/vmDnRg7KoxhVhQyxkVUzi7NoSRBJQKREjnpA/3hquvo0mek=
X-Received: by 2002:a81:a744:0:b0:54f:69a4:151e with SMTP id
 e65-20020a81a744000000b0054f69a4151emr4401389ywh.8.1681318157759; Wed, 12 Apr
 2023 09:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org>
In-Reply-To: <20230412043300.360803-1-andrii@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Apr 2023 12:49:06 -0400
Message-ID: <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security, whi=
ch
> are meant to allow highly-granular LSM-based control over the usage of BP=
F
> subsytem. Specifically, to control the creation of BPF maps and BTF data
> objects, which are fundamental building blocks of any modern BPF applicat=
ion.
>
> These new hooks are able to override default kernel-side CAP_BPF-based (a=
nd
> sometimes CAP_NET_ADMIN-based) permission checks. It is now possible to
> implement LSM policies that could granularly enforce more restrictions on
> a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> capabilities), but also, importantly, allow to *bypass kernel-side
> enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications and=
 use
> cases.

One of the hallmarks of the LSM has always been that it is
non-authoritative: it cannot unilaterally grant access, it can only
restrict what would have been otherwise permitted on a traditional
Linux system.  Put another way, a LSM should not undermine the Linux
discretionary access controls, e.g. capabilities.

If there is a problem with the eBPF capability-based access controls,
that problem needs to be addressed in how the core eBPF code
implements its capability checks, not by modifying the LSM mechanism
to bypass these checks.

--=20
paul-moore.com
