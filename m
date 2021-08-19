Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77303F2016
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 20:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhHSSpi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhHSSph (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 14:45:37 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16409C061756
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 11:45:01 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l144so14027352ybl.12
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBEwDOBwwxynaaFh4NJ9Bk0iSClWw6W0bHKETXr1p7w=;
        b=dnSDt1qsQ/hDrNxeqFJdhoOQnHS1/7MJsHzcwjLhGlEMA5x54/6mVtmzHxSObf1VQc
         nGmSSSh2GllrGsZ+WfP+nfYpLEVDssxd2l8xvUtLcyqopqh9LeVu4zF8CPeF/PBz8KrN
         rLE3Bq4mCGmr7ijO6jLYYml4WcWvIYqcDMThJ5KM6so5NZ00WkprKNxXapIHkJfpKCYG
         ukcfHwCW5JodATASwekm72yfD7e5lbkRzi8TULRloRRJfwIoUBZLriFj82x56pUHKfaa
         eHs4JRJF6Q4j+DbI6vCdrE/KWWRJljWMrr9RFTFyNoP7BXVFNhFEc/ucryOBzRqkTXLh
         bKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBEwDOBwwxynaaFh4NJ9Bk0iSClWw6W0bHKETXr1p7w=;
        b=Oh3QnOsgN6PUQzsXIeXPqBBH8RoDqPgGE9KBlZVjpuvORc0rteNpAfcjG5wXlD/P7w
         cTXQu/DQLonHCp5JRDzQP34HalOlYfklFDrv3Ag4RbCxVvWHZik4W5KUXHrFzi73nDhP
         ATPxmO6gmFSqwQAbOH9D9tFEfiT37QoRPvilK/8h/t0PUzDlrLQbOFJWdASXckvdLxbo
         2SOM2PHDh2P7MBySvfoG2wPDMSitF69mbO5GN8C5N0SAFB1tDMV+JoHlXLLVxqMLfP7l
         Ay/cPZEVNCq9j684ycV7JbETwWur3FHbU/KZhmbXGvhZPonGnn0J4WFmPxoOpVs0fUh1
         9O9g==
X-Gm-Message-State: AOAM532D+e0oRtYNaXqd3aIQkkcmbuAgTbrMeHDU/NtOBKxdIndYuPTk
        VLLbpN5l0pzUK2+I4rZiYY2ZXDdQcp6x40W214M=
X-Google-Smtp-Source: ABdhPJwariHExY40B2GS7kms72hpVi/KFJpc9iuLE0pq1ikSBE93vfqKoEnNer+Wg0WAZv/5JlvkW/0xUoI1tt3JMMg=
X-Received: by 2002:a25:d691:: with SMTP id n139mr21076390ybg.27.1629398700296;
 Thu, 19 Aug 2021 11:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210819163609.2583758-1-fallentree@fb.com>
In-Reply-To: <20210819163609.2583758-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Aug 2021 11:44:48 -0700
Message-ID: <CAEf4BzZyiZ3Q4Q=VSRZD0_8Wf-2-T8Ti_NyghC4eAoRGoH-F4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: adding delay in socketmap_listen
 to reduce flakyness
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 19, 2021 at 9:36 AM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch adds a 1ms delay to reduce flakyness of the test.
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---

Any reasons to not implement exponential back-off, like we did for test_maps?

>  .../selftests/bpf/prog_tests/sockmap_listen.c        | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index afa14fb66f08..6a5df28f9a3d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1603,8 +1603,10 @@ static void unix_redir_to_connected(int sotype, int sock_mapfd,
>  again:
>         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
>         if (n < 0) {
> -               if (errno == EAGAIN && retries--)
> +               if (errno == EAGAIN && retries--) {
> +                       usleep(1000);
>                         goto again;
> +               }
>                 FAIL_ERRNO("%s: read", log_prefix);
>         }
>         if (n == 0)
> @@ -1776,8 +1778,10 @@ static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
>  again:
>         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
>         if (n < 0) {
> -               if (errno == EAGAIN && retries--)
> +               if (errno == EAGAIN && retries--) {
> +                       usleep(1000);
>                         goto again;
> +               }
>                 FAIL_ERRNO("%s: read", log_prefix);
>         }
>         if (n == 0)
> @@ -1869,8 +1873,10 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
>  again:
>         n = read(mode == REDIR_INGRESS ? p0 : c0, &b, 1);
>         if (n < 0) {
> -               if (errno == EAGAIN && retries--)
> +               if (errno == EAGAIN && retries--) {
> +                       usleep(1000);
>                         goto again;
> +               }
>                 FAIL_ERRNO("%s: read", log_prefix);
>         }
>         if (n == 0)
> --
> 2.30.2
>
