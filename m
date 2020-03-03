Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98206178555
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgCCWMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:12:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45889 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCWMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:12:55 -0500
Received: by mail-qk1-f193.google.com with SMTP id z12so5070236qkg.12;
        Tue, 03 Mar 2020 14:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7Rh8XJ8kSJSNPMKXViWJCfLmn5XBsgJg4UraZQqhb0=;
        b=kcEnUWfqi0L6iLPVhUsKUNmI4LCqCLew+vBo0XSl1jiO4gsYjImV9UVdUUQF+IyuML
         lK+rF6T0r0cWTcfkgTrNxedI1giynJdjTlT7uLszDmn5FmjqTo/4O/meet2VwgN2waar
         Va9Lf19/CYr5DMbX6EK9Br6kqfwutNLfJnhommS23UPTmTRaUHJsJoDV8b2jXcsYTGR+
         ISG7EoIVXNz6eibszHDZYLyBNi6o8v68KkwJ5QYcmAdeWTBiU7JTfAMMUJPRsDaFWwVL
         ri6GR/eUCVnz6nRaeJk/xckevsKg8TEe5IpldQx3cu/gx0aTow/UBySsiICvgP65XMA4
         Pafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7Rh8XJ8kSJSNPMKXViWJCfLmn5XBsgJg4UraZQqhb0=;
        b=kCQGpu0GTaaiu6oS28Zrj8ygIpJV7tP8xpnSmb8Eh0QLHgkxlMKhjarxpMfgCULGDV
         2R9E5IiogQ66TnroznYhECLPtPSjeYvXCGDIUZO8A48Pol2TSl58NRsS2uptE2lG6dM9
         PjZ1lj7vD8Q9MB2qCg5O4jLt/AAtdANksoNpnrxwBh0QmpZigKfUa2Nx48W5HpPko+V5
         +dXf6AktdPTAM2XnMEcNieRf6ELOSDQrtArRcaL75XJpZmuHSqF8ofYqdvBM+NCkKfLa
         U3nGMgbD86sGkSmZbxKE1k1EYvJS7ydFez8MwzquKhciv/K1qn7KCdW7JfVx+3RASysK
         4Dfw==
X-Gm-Message-State: ANhLgQ2RWbaFkpAaf7mmfYx0O+xwgzoC8BmpGt9LGa4VYMK3YUx+sfnx
        rsMYhXPrSXwmLgwYcNDC/3PqFxs9B2PTgfmjp2g=
X-Google-Smtp-Source: ADFU+vsAG4wvPztCHxNLQLGHoS2DiUywQXd5qd0kRhlOyHQUaVEiTZIEgLEt3tMS/pNlrV/wV+x8Nt+P1YUpAocfTKM=
X-Received: by 2002:a37:6716:: with SMTP id b22mr175857qkc.437.1583273574509;
 Tue, 03 Mar 2020 14:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20200303140950.6355-1-kpsingh@chromium.org>
In-Reply-To: <20200303140950.6355-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 14:12:43 -0800
Message-ID: <CAEf4BzZkkbf0a-pCcmxq6+=XdJH6H7pPwbzq=UiMKRpWnJceyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] Introduce BPF_MODIFY_RET tracing progs.
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 6:12 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> This was brought up in the KRSI v4 discussion and found to be useful
> both for security and tracing programs.
>
>   https://lore.kernel.org/bpf/20200225193108.GB22391@chromium.org/
>
> The modify_return programs are allowed for security hooks (with an
> extra CAP_MAC_ADMIN check) and functions whitelisted for error
> injection (ALLOW_ERROR_INJECTION).
>
> The "security_" check is expected to be cleaned up with the KRSI patch
> series.
>
> Here is an example of how a fmod_ret program behaves:
>
> int func_to_be_attached(int a, int b)
> {  <--- do_fentry
>
> do_fmod_ret:
>    <update ret by calling fmod_ret>
>    if (ret != 0)
>         goto do_fexit;
>
> original_function:
>
>     <side_effects_happen_here>
>
> }  <--- do_fexit
>
> ALLOW_ERROR_INJECTION(func_to_be_attached, ERRNO)
>
> The fmod_ret program attached to this function can be defined as:
>
> SEC("fmod_ret/func_to_be_attached")
> BPF_PROG(func_name, int a, int b, int ret)

nit: int BPF_PROG(...)


> {
>         // This will skip the original function logic.
>         return -1;
> }
>
> KP Singh (7):
>   bpf: Refactor trampoline update code
>   bpf: JIT helpers for fmod_ret progs
>   bpf: Introduce BPF_MODIFY_RETURN
>   bpf: Attachment verification for BPF_MODIFY_RETURN
>   tools/libbpf: Add support for BPF_MODIFY_RETURN
>   bpf: Add test ops for BPF_PROG_TYPE_TRACING
>   bpf: Add selftests for BPF_MODIFY_RETURN
>
>  arch/x86/net/bpf_jit_comp.c                   | 261 +++++++++++++-----
>  include/linux/bpf.h                           |  24 +-
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/bpf_struct_ops.c                   |  13 +-
>  kernel/bpf/btf.c                              |  27 +-
>  kernel/bpf/syscall.c                          |   1 +
>  kernel/bpf/trampoline.c                       |  66 +++--
>  kernel/bpf/verifier.c                         |  32 +++
>  kernel/trace/bpf_trace.c                      |   1 +
>  net/bpf/test_run.c                            |  57 +++-
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/libbpf.c                        |   4 +
>  .../selftests/bpf/prog_tests/fentry_fexit.c   |  12 +-
>  .../selftests/bpf/prog_tests/fentry_test.c    |  14 +-
>  .../selftests/bpf/prog_tests/fexit_test.c     |  69 ++---
>  .../selftests/bpf/prog_tests/modify_return.c  |  65 +++++
>  .../selftests/bpf/progs/modify_return.c       |  49 ++++
>  17 files changed, 509 insertions(+), 188 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/modify_return.c
>  create mode 100644 tools/testing/selftests/bpf/progs/modify_return.c
>
> --
> 2.20.1
>
