Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD22D266E
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 09:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgLHIlV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 03:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgLHIlV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 03:41:21 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B465EC061749
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 00:40:40 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bo9so23389385ejb.13
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 00:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iWNeU/iqnpjqUNxFinA574BiX2UPQRaBtZr1Gu0KYEk=;
        b=Lbc8jRmJ9dLuPzWst3MTRuF2B+Mem9SfLaPuPN/Ihnds+bigbAgBnxsntvVBl9ZWaV
         WMM6Jl0Hrl4n4gMd2I5iYnbP8cgDDCuZwl15jDnGGLotpDs3FMRR+pKSOtNpjhEAtJuV
         QsoI2cmUSf0VoAZaLscBJ8e+vwvFsP+nFg7xB6u4c22cpby5QHWpUufatSj6NCqu4Edf
         9RSZ18kDJttoxKntiAFKixDc1pCo6z8cqFqO6/mLBGFZVOdr9kad+rsxZimOIIb0VLX4
         QMI+qCQgESdORG4sUjAsI9E192dEB6rB0jg11Y2cylyh8WyzsSXhPadzpChUpJhfHiVn
         H+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iWNeU/iqnpjqUNxFinA574BiX2UPQRaBtZr1Gu0KYEk=;
        b=miIfoUtpvVm+O6MDM8jCZyUefdRp96iPIz4hvAdnOOA+NJ/VN+rsy7s6eVI8mSv9Q+
         7DCCqNGvJNiIPhlw4SM+FwMYEIZYajYVoY6JOvTYTfyhfZsBYWZIQoIg5YrGzVT3ENm4
         z+Kc27F617KXpnvpFXKfEvmvXqt+mJE9ogkqR2dh/rzgt0f96+F6ZV6aZS5ZizIOZ+2R
         TSMIyn9XuN1OqaPGGzdE/VEpHxDHuPwcf+q6i6IAlQUbjOqZVg0cqul9dDwNUgqlE054
         tzBgmY4BKzFa2RqETh3zke2pFum+MFP7xHicTsQ4LId4Uw5ILJvlIcd50UcLGMKObdmu
         ehoQ==
X-Gm-Message-State: AOAM5320MB8w84mGV2/Oz7Oj9/p1kgUAajerHxmeduRY9Bp/PJ93Q9jr
        Prif8HlpkyE0oHmHQIZLACA3r5tXATfPKBAXQPKosW6vLKE=
X-Google-Smtp-Source: ABdhPJwhrmSMbMzK3aKtFNwVp/ciudyUO7MywEFplmQc8Flt0SxL84vljCIVXII7ynzA17bbzi2msovRoPF6Rq6axck=
X-Received: by 2002:a17:907:3e23:: with SMTP id hp35mr22609864ejc.254.1607416839091;
 Tue, 08 Dec 2020 00:40:39 -0800 (PST)
MIME-Version: 1.0
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Tue, 8 Dec 2020 10:40:03 +0200
Message-ID: <CANaYP3GdNhD56xykv+uS2Y1Mof1vXWkSfdbTPo9bwjGmXxSHEA@mail.gmail.com>
Subject: Feature proposal - Attaching probes to cgroups
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,

Are there any plans on extending the cgroup program types to include
more probe types (or possibly allow restricting any probe type to a
specific cgroup)?

For a use case example, this will allow attaching programs to the
"docker" cgroup and thus tracing events from containers only (or even
enforcing eBPF LSM on docker containers only).

Another use case that I can think of is shared cloud infrastructure -
attaching eBPF probes in those environments is risky from the security
point of view since one cannot restrict tracing to its own resources
only (containers, etc.). Allowing restricting bpf probes to a cgroup
may allow creating a cgroup for each user's resources and allowing it
to attach programs to its cgroup only.

Thanks,
Gilad Reti
