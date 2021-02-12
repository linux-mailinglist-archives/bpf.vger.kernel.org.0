Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA27831985B
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 03:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBLC3z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 21:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhBLC3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 21:29:54 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB25C061574;
        Thu, 11 Feb 2021 18:29:08 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a22so9831553ljp.10;
        Thu, 11 Feb 2021 18:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCnAVVy2YBgvZrEV3Lzj68ghKda1DDj22cLOx+VQ8/4=;
        b=spNYCcANf7Kz+BPN/1GkoWjs5KiTLKBjLc+5NP+ZZNNiuuc8RnVv/IkM+UuB4oemwu
         /4cKVodZQFdvAmdHvPpusMvCR5UWTa4DzH+ATMe5ifu+84ZMGw0CJUXc91tIy2RKXTHH
         NtYatThEbFDmxv4qI0MkNOucOFzMc640yGPA0nZKC8uppNOMzvly+fh9dSimY7Mzx+uI
         fe5m3lAEcWms/r3Ppo7Y0fn+fa39zVujIVpghcSaCe1iI77AmXAEna8FmAoexzVV5sTd
         tdPcCYmysAbMNiwdXRkLopqut5HGT7QtCBDdcDpgcNf7xJTdQsQILyOA+6fd2mDeMu2n
         jYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCnAVVy2YBgvZrEV3Lzj68ghKda1DDj22cLOx+VQ8/4=;
        b=JUOCdWKl4Rl/5VqBSTCB6oRQfRyyi86Ro3RfadV0aoY4XMeOAh33xG8MoKW/OsgC0c
         MnpNeuC07t78OlZCsaILGZLKKOyAmwoUP4/0Orm0QNFdv7vZa516VoHtnmO/sjAGyxrN
         JTrD3EK4VifH8qMSu7NZgAZ+0kF0rbogy7kcjXhYu73b85FmJCAbiZbogeRoKdKHY/Oa
         aI6+kgyXEv8qF4tJt7NWRMVL9bwOsuhuU10ewOobiUx+u8iks0uPMJbD1P57hcco8KY+
         yutiVZbk/eN2BRCd/kkTbORs/paW7KCF/FEiIbsBOaTO+DUt7FMIqvCiMJJJZm6bCOLH
         b8Cw==
X-Gm-Message-State: AOAM530XvlndeVeUXikJ2Pb6talYmD31K+TRiB/K/wDgZbSm63Hgv1rB
        00N7bFyUt7YInZG0FmLLz+5Rq8B2Xk/91r75dCI=
X-Google-Smtp-Source: ABdhPJytJYG+Wg3a9ZqsIaqVE2Tobi+heYrA4DQDfuF08Hv27MvTmzJWAy5dTKq39OZTeq01aFFkvouF6f7lJHrfGS0=
X-Received: by 2002:a2e:964e:: with SMTP id z14mr412938ljh.204.1613096945649;
 Thu, 11 Feb 2021 18:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20210210111406.785541-1-revest@chromium.org> <20210210111406.785541-2-revest@chromium.org>
In-Reply-To: <20210210111406.785541-2-revest@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 11 Feb 2021 18:28:54 -0800
Message-ID: <CAADnVQ+e7P9SeDFUQ58tX8PAEf+bymWBXXboO+Qv8AO2DS5YWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/5] bpf: Expose bpf_get_socket_cookie to
 tracing programs
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@google.com>,
        Brendan Jackman <jackmanb@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 10, 2021 at 3:14 AM Florent Revest <revest@chromium.org> wrote:
>
> +BPF_CALL_1(bpf_get_socket_ptr_cookie, struct sock *, sk)
> +{
> +       return sk ? sock_gen_cookie(sk) : 0;
> +}
> +
> +const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto = {
> +       .func           = bpf_get_socket_ptr_cookie,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> +};

As Daniel pointed out there is an sk_destruct issue here, but I don't
think it's fair
to penalize this set and future similar patches. They don't make things worse.
The issue has been there for some time due to sk_storage in tracing and
other helpers. We need to come up with a holistic approach to solve it.
I suspect allow/deny lists will certainly make it better, but won't
really address it,
and will be fragile over long term.
I think tracing would need to be integrated with bpf_lsm and start relying
on security_*_free callbacks to cover this last 1%.
I think that would be a great topic for the next bpf office hours on Feb 25.
