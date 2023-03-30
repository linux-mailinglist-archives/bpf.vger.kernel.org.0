Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC186D0C6B
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjC3RNK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjC3RNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 13:13:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4DFE04A
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:13:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so79159080edb.13
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680196380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qClcTc4BeYeX/LOwQFbM/YP0DBK0rhoxHWEcQHAmZQ=;
        b=YclsK9AcoFz8Cl4PbUOz9fK3bCYd5NTTCQizSz0o9nKACalWG2NKp68dS064Outs9N
         KKKnDb+qa5jBO0czUJyNCWrf7XCgMtFrJ8vbrKUPSVl/KizOnOrv+54kB3O4yboGP8Rw
         jpTgzPmKF8wsRYU8jRo3Q9t1lQAik+6Q/Y8ySWNH9VOsNSjYSM9FCVFl056n8IXqrABv
         iJZJl2Sn1CuaTT+FR4HupDE2pm9545CGPS1fwE8axx05eIUDMpwL27th+2iTDMGZI2Sx
         dzS/yF2Kt7cVJAALyhBWNLdvpPU+Hy3CrFFe9wL9efjw2JAWlZHQU9aAoXDtWHQG1aPW
         sJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qClcTc4BeYeX/LOwQFbM/YP0DBK0rhoxHWEcQHAmZQ=;
        b=bld6LUr2xtvgnv9VvBySSwfJEHw/Q/6ljy5+RcRo/IEWJRn7wxnft0j+JnbJfr0frz
         +GqKbDpZyyjz/gj+zqSWxZiSaRdOlqHhRWpKnOA+FOjyg/i/6R/3cpOk3qWv0MSIBjrp
         UQnu/ZUpn01LFA0Q+78WZQLJd5dZX/sIzFq8BV+D1+lVTx7YzM7Ar6G3Jjh0gzy7OB/Q
         rlgHYYRJxeDn4kBboUNBLMp04XF9ED912VigMjsJfYPEDaz7kkPFBSrF4mE/NoVv78FE
         3CxLvj58xapdqkvEncGPVN10cqb7qdEG7FYBuyCGOmtz6QNzcrq/mx0AYPZazONoAXfz
         kv2w==
X-Gm-Message-State: AAQBX9fsZT3PMFQL4YazE0DF99fglINeHjqABGWYWkhBBuI0f1L8XdSH
        I5UAt5dLDMH7Yx4gA2F6R2bX0qyDR6/SJtnsN4InRg==
X-Google-Smtp-Source: AKy350a9nrws9VUYALTPg4FQn2cWsHUI4amsy+REcIgtmalorZ5Cg1Jd2/tRkK+2UFj9HDIYmH2SiFHCXm7+mWbdKUU=
X-Received: by 2002:a17:906:7217:b0:932:6a2:ba19 with SMTP id
 m23-20020a170906721700b0093206a2ba19mr12410652ejk.14.1680196380751; Thu, 30
 Mar 2023 10:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-5-andrii@kernel.org>
In-Reply-To: <20230328235610.3159943-5-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 30 Mar 2023 18:12:49 +0100
Message-ID: <CAN+4W8h4QwvVcKkfTGOKAug2wnbZi5t5GyXXK0VWoobrNo1jpA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] libbpf: don't enforce verifier log levels
 on libbpf side
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

On Wed, Mar 29, 2023 at 12:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> This basically prevents any forward compatibility. And we either way
> just return -EINVAL, which would otherwise be returned from bpf()
> syscall anyways.

In your cover letter you make the argument that applications can opt
out of the behaviour, but I think shows that this isn't entirely true.
Apps linking old libbpf won't be able to fix their breakage without
updating libbpf. This is especially annoying when you have to support
multiple old versions where doing this isn't straightforward.

Take this as another plea to make this opt in and instead work
together to make this a default on the lib side. :)
