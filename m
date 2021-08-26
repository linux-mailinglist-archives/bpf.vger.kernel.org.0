Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883473F7FA3
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 03:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhHZBFl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Aug 2021 21:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbhHZBFl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Aug 2021 21:05:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED39AC061757
        for <bpf@vger.kernel.org>; Wed, 25 Aug 2021 18:04:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m26so1218152pff.3
        for <bpf@vger.kernel.org>; Wed, 25 Aug 2021 18:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7ov6wB07MrM0gRJrpzNpSKuSouc4apAtoEUNGtyoq0=;
        b=V7X4HZbSNcLKfeaEgAiSHIQVXB2pFo7shclH5fRaedUqj+eEtmTpiIy3y5ieqyBjni
         0BX66OLyce7432m7h1ifCUuSP5jL09aJV0oISjj1PwoS3OCbfSWM0LKYDJPbWhsSN+rr
         P4mDnLqSM3pUB+G76bG+F0sP114kfWlAwN2hRMjEo474wRohZHgzEMH7z6KumyQaJxOZ
         kyViLairZrZgdHxaJE8D2O8ozk33rFC/4XCnjLKlw0EmUZDXAxVS66Ydxz1+v3uvMdHO
         Bik+CtqRW+o917NfI064dfv0MCJgTEzuM8NSuQGXZkuwuFsOPM6DzMLdN1Bw9n6TJWz2
         5Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7ov6wB07MrM0gRJrpzNpSKuSouc4apAtoEUNGtyoq0=;
        b=jODvRWA2bAKRnQZzoHeeYVb1X8SsUd2WWW+OUVo4N74tevxb3hwkPd22RlGmSYGS1b
         i4+MpZJGGMv7tacYbCuhJTRL/Slwfp1DE7wtqjSpbejR0kD0otZtFMqBqKIBDVrOcNFR
         1EtuYBvyr692ufprBJ+MbL6EPStsMWS3FKna9duv9+Suo6e5gaDEhDSuVJNrpefGvDyf
         +l2boHrBsQdd185ANlG9qLcTuIYscDq9nQdy6EIFQlatz+c0ZMXPCz+lcg4MCf6KVn7C
         RDSvXUXFFhxqzQ853mW82MePAVqT77PrvRAfWj15VtF6cido1BKx3tEUUVBMDAKfXE94
         /8YA==
X-Gm-Message-State: AOAM530BPmk9giYHraIaEJhzEcmFYP3TTnpQRS6KdFWh1/xQAjU+dvns
        yb1+YC5gBfNTQXFx99EG6cIwWh+KvWZkv+L/+8U=
X-Google-Smtp-Source: ABdhPJx2ta/f8fEt4gNA1qqg2Lkv/XZlezKh7TNhxhnQnaIJHyFJQhyy9c6HfCcrsrfaRVxYQ8MPJNUKwrPlyMgECLU=
X-Received: by 2002:a05:6a00:791:b0:3e1:3316:2e8 with SMTP id
 g17-20020a056a00079100b003e1331602e8mr1010549pfu.10.1629939894431; Wed, 25
 Aug 2021 18:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210825184745.2680830-1-fallentree@fb.com>
In-Reply-To: <20210825184745.2680830-1-fallentree@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 25 Aug 2021 18:04:43 -0700
Message-ID: <CAADnVQJz8LUTsm_azd4JE0n5Q4Me0Lze6hmsqNYfAKMeA44_fQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 25, 2021 at 2:07 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch adds similar retry logic to more places where read() is used, to
> reduce flakyness in slow CI environment.
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 6a5df28f9a3d..5c5979046523 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -949,6 +949,7 @@ static void redir_to_connected(int family, int sotype, int sock_mapfd,
>         int err, n;
>         u32 key;
>         char b;
> +       int retries = 100;
>
>         zero_verdict_count(verd_mapfd);
>
> @@ -1001,10 +1002,15 @@ static void redir_to_connected(int family, int sotype, int sock_mapfd,
>                 goto close_peer1;
>         if (pass != 1)
>                 FAIL("%s: want pass count 1, have %d", log_prefix, pass);
> -
> +again:
>         n = read(c0, &b, 1);
> -       if (n < 0)
> +       if (n < 0) {
> +               if (errno == EAGAIN && retries--) {

TCP was fixed differently in
commit 30b4cb36b111 ("selftests/bpf: Fix spurious failures in accept
due to EAGAIN").
Would a similar approach work here?
