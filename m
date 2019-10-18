Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B2DDCEB8
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 20:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394791AbfJRSv6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 14:51:58 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44419 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfJRSv6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 14:51:58 -0400
Received: by mail-vs1-f66.google.com with SMTP id w195so4687978vsw.11
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQ+b7O8lIRasL7SBrhHpxrv11BEIe5f0Rek2PCPmRlk=;
        b=eq5rjLzv/egeeOliP0FyzcN897rAH02eUhoyWTxH5VxKB7cltB/4lezGCwXTc7mWiM
         agRoCqaVmezu+8sDVqVCH7V/ev7sXLa45VEb0VkR8sfJUoWQmCmtl2LAPjTe4cicayqL
         g7ZXqcHawzCtaBHEyzabwuwL7R7i7O+VI113W7GAZ024yh/EnZNp/2PJ0s05CkNv9R0T
         LTHQUo9yTolD17XDNZZ+pDwukRJEoK4XQ2u3COt7YATY9QLyCNcnpQUlWEbLAF0zh6Ug
         29RSLFs/o4EuZiKwSAwVJDvVJHdphgMnMGeN3hdmsCtqPtFzEb6+RkjWqqlCjj78Eay3
         QAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQ+b7O8lIRasL7SBrhHpxrv11BEIe5f0Rek2PCPmRlk=;
        b=KLhe9wAWOA7xJXNwAZRdskSV+et4n/+sLMHSxubpTbUYo8DiMCC4wEGnUZqGNwgpN0
         zcHeZa3+nBQCQyJJSL/auGlavG9VmLsGj5EzuLQ8OAR8FuUdaXwBEeTECzU3VvZl4tAz
         u+XfCfQmiPQuzXW2Xf+cAmPHi8+gq1dyadWPJmHh9rQ8qu4nKMX2+rsGi6IpnMvLGZOW
         Es3jRu2KSvSudmoJ2hrzKKIyuKPfBYVEZ32bWVt4QWDyT1WIY2ZRjQZmpfEgL/liAFV0
         FYt07cgSS3YkOkys+zhZ4dO56LKaw9m30mRaBkeFvRCXDc17Prr3TQEelB1K98NauEc9
         iKow==
X-Gm-Message-State: APjAAAU/PNVAXFbaGruQoU7dU8lLHukYqJsatRG8X0ZNoot/MrMK508p
        v36L02t2TApNq+Q9dobgP4TQRBeLS3iRFXmbXr/mIg==
X-Google-Smtp-Source: APXvYqy/fouzVLLJeCyLs5Pk8bc2m+kQSVsYEjXrZRIgA4PZofUHlW6/cLIfMnqH7a2sjGeHopVCqIG2YTD+NDkuVqk=
X-Received: by 2002:a67:6242:: with SMTP id w63mr361961vsb.233.1571424716206;
 Fri, 18 Oct 2019 11:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <f5bf07dccd8b552a76c84d49e80b86c5aa071122.1571400024.git.jbenc@redhat.com>
In-Reply-To: <f5bf07dccd8b552a76c84d49e80b86c5aa071122.1571400024.git.jbenc@redhat.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 18 Oct 2019 11:51:44 -0700
Message-ID: <CAFTs51Xh=LjQqzS_YFaG6Z-OdOYLyXeSes+aWxkrPaBx_po_bg@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: More compatible nc options in test_tc_edt
To:     Jiri Benc <jbenc@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, linux-netdev <netdev@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 18, 2019 at 5:00 AM Jiri Benc <jbenc@redhat.com> wrote:
>
> Out of the three nc implementations widely in use, at least two (BSD netcat
> and nmap-ncat) do not support -l combined with -s. Modify the nc invocation
> to be accepted by all of them.
>
> Fixes: 7df5e3db8f63 ("selftests: bpf: tc-bpf flow shaping with EDT")
> Cc: Peter Oskolkov <posk@google.com>
> Signed-off-by: Jiri Benc <jbenc@redhat.com>
> ---
>  tools/testing/selftests/bpf/test_tc_edt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_tc_edt.sh b/tools/testing/selftests/bpf/test_tc_edt.sh
> index f38567ef694b..daa7d1b8d309 100755
> --- a/tools/testing/selftests/bpf/test_tc_edt.sh
> +++ b/tools/testing/selftests/bpf/test_tc_edt.sh
> @@ -59,7 +59,7 @@ ip netns exec ${NS_SRC} tc filter add dev veth_src egress \
>
>  # start the listener
>  ip netns exec ${NS_DST} bash -c \
> -       "nc -4 -l -s ${IP_DST} -p 9000 >/dev/null &"
> +       "nc -4 -l -p 9000 >/dev/null &"

The test passes with the regular linux/debian nc. If it passes will the rest,

Acked-by: Peter Oskolkov <posk@google.com>

>  declare -i NC_PID=$!
>  sleep 1
>
> --
> 2.18.1
>
