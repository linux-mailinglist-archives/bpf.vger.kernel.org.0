Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA56139EDA
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 02:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgANBTp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 20:19:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43026 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgANBTp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 20:19:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so10631400qke.10
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2020 17:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xht2kQMNXwpo0KSK6+bl48VtC/R1pMF4046jup2jGaQ=;
        b=i74gaj2fzU397SqmUaYEFd1A//4UaLs8ZEFyYsvBayU+njmkRq3elCE4nadBHymm22
         Hz+or5cEU8wlCgxfIhf4tpXP2EKyP9ad9/eo1yw4tcZiJnzSaa3xN5bIVJYRiwcgtjTV
         ypKf+2UCd+b6hAy576aR+YpxIO5GXZ7LrpzVjSeff4XEUyWM0aeB4MrGb+/5weWG9jDp
         ln+uyTBFzauGA+hXs5Pb7xr1Zx9tVaa/eiQKEwR/HimSX7d5Xe+gXonam61Je4BkjuMa
         E9Lk7CLKe2y9PEIgiHtoxyT+sLfUTFGEI4EYC+9QvrTeGkjn22xyweJocjRzbny7al6I
         Nfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xht2kQMNXwpo0KSK6+bl48VtC/R1pMF4046jup2jGaQ=;
        b=mSaAK3G5By+BFUpQW/PBaO2fqCI40zfytbjy/8tbs2b07AZ7IHrCTSybX9A4kWMvTU
         WAB2s+CAOSxmT2wH9SzTsBML37adck7g9Q1B/aHaAOkvmFpLzLWdrGPReWsGq5QhVDZi
         3CnnFBK7hclA4h0T+a/Q/fZ27VPLM1TxDIXdWnqVowN94vtIgdVpJ2nDK5xp/ou440sw
         W5ei82IH8l93igbWllNS0x3S8lie34lLuz88uivpCg+bCzjzm1aFAbJnO+149buCD433
         zGAdtv205bYFP+Ag3UfyolXGqqOf4arMsvONkDVr6p/HLSfybFAi3AoL2tgHVyzM20jn
         tGbA==
X-Gm-Message-State: APjAAAUK+OF3RBMaQwQwMNf5stiLK81H11BVZnWMnq/YaTdrnU39cmc/
        06wF0/ah2X1M11q6PIN/jtRx8GUEZPt4t8ACCw4=
X-Google-Smtp-Source: APXvYqwTQ3jnNkOg2gHRo+lgKzPNjbZ3bz/aSyrsiVTgpu/ZM+TvL0wI4+qeX+jReRQR/NtiMsbHg7yhecPpaRzF6tk=
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr19358517qkj.36.1578964784031;
 Mon, 13 Jan 2020 17:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20200110011557.1949757-1-yhs@fb.com> <20200110011559.1949913-1-yhs@fb.com>
In-Reply-To: <20200110011559.1949913-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Jan 2020 17:19:33 -0800
Message-ID: <CAEf4Bzagfmx1H3DgQ9ZjxKwbGdRGHAy7=qHt5S0Pqf0vV7PB4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] tools/bpf: add a selftest for bpf_send_signal_thread()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 9, 2020 at 5:16 PM Yonghong Song <yhs@fb.com> wrote:
>
> The test_progs send_signal() is amended to test
> bpf_send_signal_thread() as well.
>
>   $ ./test_progs -n 40
>   #40/1 send_signal_tracepoint:OK
>   #40/2 send_signal_perf:OK
>   #40/3 send_signal_nmi:OK
>   #40/4 send_signal_tracepoint_thread:OK
>   #40/5 send_signal_perf_thread:OK
>   #40/6 send_signal_nmi_thread:OK
>   #40 send_signal:OK
>   Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/include/uapi/linux/bpf.h                | 18 +++++++++--

maybe do tools/uapi header sync in a first patch, along the original change?

>  .../selftests/bpf/prog_tests/send_signal.c    | 30 ++++++++++++-------
>  .../bpf/progs/test_send_signal_kern.c         |  9 ++++--
>  3 files changed, 42 insertions(+), 15 deletions(-)
>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> index 0e6be01157e6..4a722024c32b 100644
> --- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> @@ -23,6 +23,7 @@ int bpf_send_signal_test(void *ctx)
>  {
>         __u64 *info_val, *status_val;
>         __u32 key = 0, pid, sig;
> +       int use_signal_thread;
>         int ret;
>
>         status_val = bpf_map_lookup_elem(&status_map, &key);
> @@ -33,11 +34,15 @@ int bpf_send_signal_test(void *ctx)
>         if (!info_val || *info_val == 0)
>                 return 0;
>
> -       sig = *info_val >> 32;
> +       use_signal_thread = *info_val >> 48;
> +       sig = *info_val >> 32 & 0xFFFF;
>         pid = *info_val & 0xffffFFFF;

Would you mind rewriting this test w/ BPF skeleton and global data? It
would make it cleaner without all this masking stuff?

>
>         if ((bpf_get_current_pid_tgid() >> 32) == pid) {
> -               ret = bpf_send_signal(sig);
> +               if (use_signal_thread)
> +                       ret = bpf_send_signal_thread(sig);
> +               else
> +                       ret = bpf_send_signal(sig);
>                 if (ret == 0)
>                         *status_val = 1;
>         }
> --
> 2.17.1
>
