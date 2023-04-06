Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4D6D9D3D
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbjDFQJa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbjDFQJ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:09:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8F93EF
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:09:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l15so2621149ejq.10
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680797346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdkjuJE1elUB43CchYEctgbx3o25Rv2AshR1jqOdy1w=;
        b=dmU2u9dBbtcCNcM8LlQLmmjleUNYI0++ejRBd5fcsfxU394VZ6ydE8jyT1gTrrqG9Q
         lhwGUutJEHWe09e8LYmIgoy58mycJURUoWFrz4SO1RktU4tkpwoK4wDhaCukb4h0QLpn
         BODr1CIojc3vIvhy0stb18G1bNxuWpbywSZtYpXmbuHT8JvGLjS81QgUt717ObcNAU2t
         el+8bmOjmjcYMjecf9fZZ6jWQ/LEgt6qk6OCu5i7ichA3bPHkv8+bmx7G/8nk7l5yDS7
         47d1T1qu5iBlJNjbbNEPXsrXhG5tojQ6dVb8HQz/BG8KC5c9FEwL0e+2Cy1I3GaC3lIV
         48Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680797346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdkjuJE1elUB43CchYEctgbx3o25Rv2AshR1jqOdy1w=;
        b=Ie7xFu3Ag03tzyscQUnHiAIuAmZTqExOeyTsZ2FeFZ5SoL4lnerPCLUf+fd/Xj2AVw
         ejbbVgU/e95vnU7+6PQCSkmnkvx0TuEppPtSvonND8QH3MDSX1P3XMdXhjzUQKgfqbJW
         zKdB8HyBEYe1l+etsqk3QDp1SoNAXq5xxW0cyC2JU+I3k+Yblt0Ipa/ZoLxhoSwUM2ur
         BO0s6z8IIx3sWQehjRKkUT+Q0dtotjS09eA4x9MsJs2WPMHmap8BaB/c6OD28NVP91hb
         XNAqQgtr5/RcZHOA4P6FO4WSBWkhDtzHaVre2oausRlSnD+SYblZ5xwgwbB3DcyBpxRi
         UMWA==
X-Gm-Message-State: AAQBX9dkzTZ5/fV6aT+OsxYGjDxHIGlzBZoOu7/07cEmLsN6cKWHrLD8
        1sSbElq4/uClOPZ/v2RaKs/a+0Q9POYinCRaTiGp+Q==
X-Google-Smtp-Source: AKy350aebKRH5tIWrLGwY4zcuYm3COjZ+ZgjHreiMx6kmQQeruHL4N4CjAZcD6OsEs9Nnn39CFHwu2E8Ud9clTjONk0=
X-Received: by 2002:a17:906:dcf:b0:932:6a2:ba19 with SMTP id
 p15-20020a1709060dcf00b0093206a2ba19mr3620124eji.14.1680797346160; Thu, 06
 Apr 2023 09:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-13-andrii@kernel.org>
 <CAN+4W8gtHrWt_XQBTSvkMxmeuLT4hcUtYMaFRdeZfKyJ_s2QJA@mail.gmail.com> <CAEf4BzaKwrLhyk-Hon9Hi4aZhVrnU-OS-7-jHdd9uMzUnjRKZA@mail.gmail.com>
In-Reply-To: <CAEf4BzaKwrLhyk-Hon9Hi4aZhVrnU-OS-7-jHdd9uMzUnjRKZA@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 6 Apr 2023 17:08:54 +0100
Message-ID: <CAN+4W8jp=G-WaNxUaXAmwi8ofH+GxuW=7_3iMfueF+SDi9U=Nw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/19] bpf: add log_size_actual output field
 to return log contents size
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
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

On Wed, Apr 5, 2023 at 6:40=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > Can we check that both fields are zero when entering the syscall?
>
> Yep, it already happens and is done by generic
> bpf_check_uarg_tail_zero() check in __sys_bpf.

I thought that check only happens if expected_size > actual_size? I'm
thinking of the actual_size =3D=3D expected_size case, what prevents user
space from setting log_size_actual to a non-zero value?
