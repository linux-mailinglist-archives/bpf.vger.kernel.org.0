Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB20C48B9E1
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 22:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244246AbiAKVtx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 16:49:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37016 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiAKVtx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 16:49:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42AC3B81D4F
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 21:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A23C36AF2
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 21:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641937791;
        bh=z5KoftC8awVcvx70e1t6eeC2ZSD2cHZ+RCHN8zNFR38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rnldDHVbGIgs3foVZwS2RX8/w9vIaB3Q8Ix9CGYgJNSnO4e7XpDEgrWlt9O5QUBLT
         +fsh80xzUOqNw7MWjmyXZo+J2MX88cJna3H9lO2R3VpdQvr7urRDS5u5Y51/UQkHGo
         pZX+Ic0zeKvrAAyq+K8RI0lxMU3e5XWERT5DIvlGOLRtlyC4k0vUYY+yrZuaqgxtf6
         54wKqUQZ3l+cyGtBq51YwBo0TD4wzVpo2g4z5y+dh7lLDNPUgKbSWwA3m3wVJ1WtvY
         CvQvMIjv5OyWZ533nfTQmh0u7er1AeoBcs06b4mnsrvBeEhk/39frmnKw6E7xURCJ1
         RJjKcX854nBXA==
Received: by mail-yb1-f169.google.com with SMTP id c6so930930ybk.3
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 13:49:51 -0800 (PST)
X-Gm-Message-State: AOAM532oAyeyeeKm9agalVo7URLI4MtLzS0O4L29E0VpP9Gvx6NWC5gp
        vrEbbWTA+O4BkwVLvdKfwi7qMTVHJY7DlUTXamM=
X-Google-Smtp-Source: ABdhPJxjPHFG+jm2q7F1MuL+P4K2+kCBPeySjxKzyG0duhQC5L/kZwZNiZwsrKbI14jmjlotNlkC143oL4FSR6OaA+8=
X-Received: by 2002:a05:6902:1106:: with SMTP id o6mr10061267ybu.195.1641937790199;
 Tue, 11 Jan 2022 13:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20220111184418.196442-1-usama.arif@bytedance.com>
In-Reply-To: <20220111184418.196442-1-usama.arif@bytedance.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 11 Jan 2022 13:49:39 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5ys+q1ikj5s+TroQBgLAmzWdP+aYEadhtM1==6CYRQow@mail.gmail.com>
Message-ID: <CAPhsuW5ys+q1ikj5s+TroQBgLAmzWdP+aYEadhtM1==6CYRQow@mail.gmail.com>
Subject: Re: [PATCH v5] bpf/scripts: add an error if the correct number of
 helpers are not generated
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, joe@cilium.io,
        fam.zheng@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 11, 2022 at 10:44 AM Usama Arif <usama.arif@bytedance.com> wrote:
>
> Currently bpf_helper_defs.h and the bpf helpers man page are auto-generated
> using function documentation present in bpf.h. If the documentation for the
> helper is missing or doesn't follow a specific format for e.g. if a function
> is documented as:
>  * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
> instead of
>  * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
> (notice the extra space at the start and end of function arguments)
> then that helper is not dumped in the auto-generated header and results in
> an invalid call during eBPF runtime, even if all the code specific to the
> helper is correct.
>
> This patch checks the number of functions documented within the header file
> with those present as part of #define __BPF_FUNC_MAPPER and generates an
> error in the header file and the man page if they don't match. It is not
> needed with the currently documented upstream functions, but can help in
> debugging when developing new helpers when there might be missing or
> misformatted documentation.
>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Acked-by: Song Liu <songliubraving@fb.com>

[...]
