Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA5F852C7
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 20:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbfHGSOe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 14:14:34 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38159 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389181AbfHGSOe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 14:14:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so64683465lfj.5
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 11:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9WW+4WaZtDg9QXKdieHggUkaA+4k68PcqDbChgZVQc=;
        b=Gq+tGU8Phy1IjXRd5AmRYs4dNYsSUQFR6zzYjFtLDbTHuX18GewZTB/JwcSkwX/I0g
         bpfOyU3sHaYH7wm5+nNvfN04tSHEZM/jYAo+LYWzJ32yeH8c68jKOj9OfYORDrxJNinm
         S9+wzkQXpxchDEbgpFhhTT3LSYbC3955rURnvS/jdB50x12ieLHGAJvPtC/v11IN2u+S
         ridlqlaS0ucn1GENz489Q6M+ddTYNxZOW1PoyukH8FaNeW/q2UuNZmJPvbKDi7fWUom5
         Xphljxy0ds33kFA6dwyGGNEjGbTZ1UIh8D8KZ/FC7zN3rrURTLMMzty/lv85lCAIkl8l
         /isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9WW+4WaZtDg9QXKdieHggUkaA+4k68PcqDbChgZVQc=;
        b=cLg1iojnd49IVqNIpSJ/kO+AKQF/ThWRB5Z6W1jjI+Tg/rVCjf6Jj1wST3iVtJofGq
         +2uSsYzYp4+6UR+R/0+xMp05f8xA77pAE1eTsj7AHgk2PuQSihhrFQARBxisdBaWTeSn
         OshZtxTcpbNN7mLQbJnBcS0Aj+/20A/n2ZotFeBwmtV2SR2kJMpWTHKD+GtfvzAu+5yH
         U61jih1hP2uaG8mDQZqDVRXHsCxYUFw9BF3BK6E8fe/zXgYdZirYKasAnToRzgxijlwM
         pOfxNbZatAFQqvZkXQPgqxHYS/C50OKZsEKifqEiZnNe1N4f7ckLSUN1ezU/3mF8dInQ
         T5FQ==
X-Gm-Message-State: APjAAAW9hCWTX4w41QlCkSoqoI+ynbuejoiGp4X6EBfZ9ukAR9EsAYDX
        eDp5AiQ10jQm5efHzLTaZYh/LfL0QE9ltKopfnE=
X-Google-Smtp-Source: APXvYqw2OrJPnaVB5557qC+MlpKSkpTiPwVcPGXVFr3yylaDvlzoCAT8bXEyQHTkmhGaW9TN1KqdR/iHrORVD8GjFE0=
X-Received: by 2002:a19:5d53:: with SMTP id p19mr6483479lfj.109.1565201672743;
 Wed, 07 Aug 2019 11:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190806234131.5655-1-dxu@dxuuu.xyz>
In-Reply-To: <20190806234131.5655-1-dxu@dxuuu.xyz>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 7 Aug 2019 11:14:21 -0700
Message-ID: <CAPhsuW7z9A=5AtWaOEEfdhyV9CmWKYXRn5itOh2tcsOgbdxOiQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 6, 2019 at 4:41 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> It's useful to know kprobe's nmissed and nhit stats. For example with
> tracing tools, it's important to know when events may have been lost.
> There is currently no way to get that information from the perf API.
> This patch adds a new ioctl that lets users query this information.
> ---

[...]
> +
>  /*
>   * Ioctls that can be done on a perf event fd:
>   */
> @@ -462,6 +484,7 @@ struct perf_event_query_bpf {
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT            _IOW('$', 9, __u32)
>  #define PERF_EVENT_IOC_QUERY_BPF               _IOWR('$', 10, struct perf_event_query_bpf *)
>  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES       _IOW('$', 11, struct perf_event_attr *)
> +#define PERF_EVENT_IOC_QUERY_KPROBE            _IOWR('$', 12, struct perf_event_query_kprobe *)

This should be _IOR().

[...]
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 9d483ad9bb6c..5449182f3056 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -196,6 +196,31 @@ bool trace_kprobe_error_injectable(struct trace_event_call *call)
>         return within_error_injection_list(trace_kprobe_address(tk));
>  }
>
> +int perf_event_query_kprobe(struct perf_event *event, void __user *info)

I think perf_kprobe_event_query() would be a better name, especially that we
have struct perf_event_query_kprobe.

Thanks,
Song
