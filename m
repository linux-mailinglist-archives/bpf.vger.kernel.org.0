Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7DC486DB7
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 00:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245507AbiAFXZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 18:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245500AbiAFXZf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 18:25:35 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1792C061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 15:25:34 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id q5so5038680ioj.7
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 15:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHi+niJIwMftr6Po/9+XbGO1jc/2iyisIvBd1AcqNJA=;
        b=GPj+OpyZibJDlP49kUTkSBS5XPG29JiIrkx9MJj3pJTJdEUdiGziEcIvNatmj4LP1b
         g5I/dcUokaR6UY57kE9dFUCFtYDlfr9iHC+NQSgl6V70WbK2knP6hsHSppEDa5O6gLY5
         vyUtBIFT6z5ZAsCzzHsepATLexnRr8C1LTO2cTh+SoZy7yQRN1od2wRxRf5O61l4V0KF
         JNhbLtPt/sxoSxlK6TaTTtnzcTorJy0S5aDoMQ8mcH/OtuFjpfP7xI8hAJIhqlZ/xDiI
         nGNaTEySFFOUDDtlPFChHrbSkE37MXVnIXBQRy/raNe36dCzq8aQ1P46x7XTLqXWFytZ
         PGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHi+niJIwMftr6Po/9+XbGO1jc/2iyisIvBd1AcqNJA=;
        b=pHq6qnpeO6YrypA/AZlLw+ImXbLHg01o6+JMoIyLpXJsvlcSquI90yq6aOJRP3vVJ0
         Gq4Pojddsy0PBhuLcGMKe5gjQEduqktmYk7Iee6XPHmYLmK97+G5apPH8r9+PZP1x0pB
         fVbe8KIl769tw53GyBjwzbn9vqknKeJ/SYrQeW9fw7un8/AYYpaXtdWrzWt6ycyzvs87
         kssuvDUvVsHOeyQgGtxV7RAB0r4YgLJkNaGTMtWxBlRie2WHQdBhwDmzlF47Ar6XYCF3
         Sg3bHJlrQKv8qgElLOgPIUZLvsrrK9sN75v0JjC0IRM3PQP23IcEhYryst797rE7gbh0
         UaPA==
X-Gm-Message-State: AOAM531aM/rZvW3fDJxB2LlHn3JIKH0a9b9t0z4ZfgiK2YbfLwuBaeqH
        SemtEhDORvwQjf5CuBkfivGmCdQ37wpp7nJ8Q0c=
X-Google-Smtp-Source: ABdhPJwzcDsp1vs49hsuXArO0GU8OaUXt27m+ubt7/FKlmxS57VjUOl/MZZ3oVLqE2pMcI2j6KYIdx/FHNg1ySEJCE4=
X-Received: by 2002:a05:6638:1193:: with SMTP id f19mr29241860jas.237.1641511534248;
 Thu, 06 Jan 2022 15:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20220106205525.2116218-1-haoluo@google.com> <ca6e2085-251b-1dbd-3ee1-d990b0eec810@fb.com>
In-Reply-To: <ca6e2085-251b-1dbd-3ee1-d990b0eec810@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Jan 2022 15:25:23 -0800
Message-ID: <CAEf4BzaCe7z4=zaqeBu_7+=Ob8GY8-eNPrhiStEiGqGa6OMLzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf/selftests: Test bpf_d_path on rdonly_mem.
To:     Yonghong Song <yhs@fb.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 6, 2022 at 3:17 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/6/22 12:55 PM, Hao Luo wrote:
> > The second parameter of bpf_d_path() can only accept writable
> > memories. Rdonly_mem obtained from bpf_per_cpu_ptr() can not
> > be passed into bpf_d_path for modification. This patch adds
> > a selftest to verify this behavior.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Applied to bpf-next, thanks.
