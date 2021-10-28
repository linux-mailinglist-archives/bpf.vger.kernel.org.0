Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B543F2EA
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 00:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhJ1WpS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 18:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhJ1WpR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 18:45:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B5C061570
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 15:42:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 188so13360417ljj.4
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XaGstqMMf71x3qggRkE+pbmocplZzKlWQ6w/+ovGtQo=;
        b=e0zj6qMzSCY8ezdR8EFJzUZk8oAyTych659FO/Qgz+QNtykdNQ6ujxTxHOpPQUkVWu
         lRzSCU83twcHEVSHgvCH6jGroZ6NBpj7g6u0/ZOJobMq/xuTKuDE7aXCdEP6ocox4De3
         9ZVLTJS6gIdQsoJ8JAMNfMfbBmn7JlL3PlQok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XaGstqMMf71x3qggRkE+pbmocplZzKlWQ6w/+ovGtQo=;
        b=JXassRLSCHX0+FMGBYeDeG2mmmVm5NLsCOd4Y8ay9B/Q4licYwSWYnXS9p81Z2//2R
         lebeLuCcMd2+1xhWA2+uIc+s7t8xMUF647KLwm2WAwiU62lUdtrTg99xNw6WUaWfWz23
         9QMUwiK4blWBsQn66fVjhYksYCHKN/5axgNq1TmblMO2B5Emp0Ut6LSSN2JLpV7uEu90
         5PAlSAbmFoPhKTCaCFt1xEf7wHY2WgS5mrlSoa2dGcCCfYJqkCjjTA2bkxSTds1ZMZwV
         xPi4OOx1pmABTm1a8w894TdeI4Co1hEuutGruQ9ykri8oSwzdIbLfFBgVYeda+Fspz1Y
         uPlA==
X-Gm-Message-State: AOAM531euAM5xkVye7psNoHpfSEFY1NV4j0VRb1rQHrIphMdPVRT7V3/
        i31Pt5BrM3rgbriRWAWKJ1s7ZMieTuTBnfeTBEvd7w==
X-Google-Smtp-Source: ABdhPJwHWqduDeinUJFlWT0zouUiuKoTqWYQ1gmn135ZD9N2+/daEXQ0a921IPMaRs0hP5zJgTk7GUBrFolwxwGBr3E=
X-Received: by 2002:a05:651c:230c:: with SMTP id bi12mr7772421ljb.218.1635460968206;
 Thu, 28 Oct 2021 15:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211027203727.208847-1-mauricio@kinvolk.io> <20211027203727.208847-3-mauricio@kinvolk.io>
 <CAEf4BzYUXYFKyWVbNmfz9Bjui4UytfQs1Qmc24U+bYZwQtRbcw@mail.gmail.com>
In-Reply-To: <CAEf4BzYUXYFKyWVbNmfz9Bjui4UytfQs1Qmc24U+bYZwQtRbcw@mail.gmail.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Thu, 28 Oct 2021 17:42:37 -0500
Message-ID: <CAHap4zt1jFM_hMd0mqT+158f3-C8Vn0AtZHH+pK_MxxiUan5zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: Implement API for generating BTF for
 ebpf objects
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Rafael David Tinoco <rafael.tinoco@aquasec.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> I don't think it's necessary for libbpf to expose all these new APIs.
> The format of CO-RE relocations and .BTF.ext is open and fixed. You
> don't really need to simulate full CO-RE relocation logic to figure
> out which types are necessary. Just go over all .BTF.ext records for
> CO-RE relocations, parse spec (simple format as well) and see which
> fields are accessed.

How do you suggest to match the types for the target BTF without
simulating the CO-RE relocation? Are you suggesting to match them only
by name? We want to generate the minimal BTF that is needed by a given
object. Consider that we could generate these files for thousands of
kernels, size is very important for us. For this reason we chose to
simulate the relocation generating only the types (and members) that
are really needed.

> Either way, this is not libbpf's problem to solve. It's a tooling problem.

I agree. When I started working on this I tried to implement it
without using the libbpf relocation logic, but very soon I realized I
was  reimplementing the same logic. Another possibility we have
considered is to expose this relocation logic in the libbpf API,
however I fear it's too complicated and invasive too...
