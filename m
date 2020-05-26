Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188D41E3228
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 00:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391647AbgEZWOH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 18:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390125AbgEZWOH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 18:14:07 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D028DC061A0F
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:14:06 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m44so17603355qtm.8
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiGbbuhreSRjvWcyZ8Gx1L8BK3CkeZ5t3ryJaR357V0=;
        b=jWSSOxrr/egqgmdjVeMXFs23VO3fu4QckI2uFSk9Op7JfgHDgNQssYDn2usqQ6o0HQ
         MGTAecDcSK9k0C7Qw65SrB5TstdVSgEVh+7rmkWh7uOTaEjEb7n9Jk8yq9WMSRz3i/YI
         rTpQvSIP65nVt4/j0zWfaSEqG3ws4hgtTRZV/cKXr6yvJmp4xQBNjyGq02gXNs3qhh/m
         SLMwgLUcJlwlTRIg1X6Wc0SkSYircgUhzbULEl6ajoH8N4qOprMrai1SNC/8vvCmGdSU
         kRKigRCprxVKDGrr5DyLisen3miyXp7w+UkBRfrR0AqXX1B1i4IKezVh3wewzrU7t/+U
         LHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiGbbuhreSRjvWcyZ8Gx1L8BK3CkeZ5t3ryJaR357V0=;
        b=pYWz0iaxYEJRlx6wZekvODPJAN/8zcjf9LnW4h1IHUU2jq5A1NV7RFBM8JeY4DDIPl
         yMbmODAaNr+KdJ13yd26cfsds2vYgcYL+FUxKl+0n5CvK4qpH/eWwW4Q9jYzGEi9eGf4
         92qqeaU/ziZqyqQt5yNXb4XfKr2qTgjm9BWGm6Xy/RFXKWkNQ67YtpjqXuOANpLAJC0R
         qeEssh37aRT6ol+QA8aT3PDSP7PSaTCfP+HWYDuMRivH7be6yBGhbxIKxbgvQBSxPIjC
         VbWSIa14t5yKg28v/2mFkmL4/Gfw9TqRPrYKDcHmQo+WWCIRIVpv5gLc4sSX0fOTo/BR
         UTCQ==
X-Gm-Message-State: AOAM531iQ3Wa+YGqXUKd+5DvvM9seIA9pVUbWyN8SYWDsgFHoabMSmwZ
        HrADk1SIAvdaBObTwZkP0DwU3y7kVPSU45FpsrQ=
X-Google-Smtp-Source: ABdhPJxXan2rdHQWxB5CNsOfdNyS17q4kp8j4WknPcNnwp9PtgKvnmQ+59inb0CJpKCbtRlg5LBF6/CDo79+AtXT7W0=
X-Received: by 2002:ac8:71cd:: with SMTP id i13mr1028418qtp.93.1590531246101;
 Tue, 26 May 2020 15:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com> <20200522041310.233185-7-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-7-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 15:13:55 -0700
Message-ID: <CAEf4BzbVbM9jh5K=qcywooTWvuAvS8euDy+xru6tQEd=Y4T+wg@mail.gmail.com>
Subject: Re: [PATCH 6/8] selftests/bpf: fix urandom_read installation
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> selftests/lib.mk does not prepend TEST_CUSTOM_PROGS with OUTPUT (vs
> TEST_GEN_PROGS, TEST_GEN_PROGS_EXTENDED, TEST_GEN_FILES). So do it
> in the bpf Makefile. Otherwise make install fails to install it on
> out of tree build.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>


>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index efab82151ce2..31598ca2d396 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -82,7 +82,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>         flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
>         test_lirc_mode2_user xdping test_cpp runqslower bench
>
> -TEST_CUSTOM_PROGS = urandom_read
> +TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
>
>  # Emit succinct information message describing current building step
>  # $1 - generic step name (e.g., CC, LINK, etc);
> --
> 2.26.2
>
