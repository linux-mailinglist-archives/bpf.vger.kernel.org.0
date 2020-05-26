Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8491E3224
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 00:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391271AbgEZWNl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 18:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390125AbgEZWNl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 18:13:41 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A24BC061A0F
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:13:41 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so17626928qtb.5
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNcHhvr6KuPBf/E4rDhl12C7cXKSOIswGdVJaomU4vg=;
        b=hcJ3/coiKLA+s4mP3l7fuWOkPsFone/kabRzQcU6p2EK9Z8sbq/7zgTNPe8O3Gp7gS
         mFMZAg7G5lZY/eJDtVz56Y2g24DeBFSm72q0k05MUXuGkmHyEwjdMsVGbdTqpkoGKdLK
         05/KC9AO9Lp66/UKwkzzV8XWu9XLeYxGHgLEP8bFZUul6C2JiqLabE76nCSt5gS/jwih
         stoGYjAur3br6/hJerbmGcBjOhe5VmggVFDteG+0ocnuGvIAgPACSxLkRCdJ8XzvHqVU
         TdLKAkQ7cJRdZ/SLsWQXI3XZKwBP/iAf61FpTML5dabbrT/C+ug8zLGNmytoP3MQS2VL
         lWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNcHhvr6KuPBf/E4rDhl12C7cXKSOIswGdVJaomU4vg=;
        b=SB0cWbuZf4nZ/LlLXV7WB9l9OXglgUoD065xKE1fCUgA1ZMRWxcuvUbinB95eq98tS
         kzRSUthz8YGeDtHNmpI9CiUV5plLw9XPj4yJQnl726JS+YQi3zm2VhGOcoeBX0kg665e
         wYO4UuN+MM0+rmUVInrJX0Wyja6eAeKksEnjyRZdprbX29+BL4Q2F2OxfwqCUR6hWOlM
         lkzF1YfjgwsKQGWzObDltao8Z6vmHBlWMP7nfzNMW7zimAlsFlF4dgFFMd98XWeWupso
         WZI5WrafcCXi//Fyj5QfFxIv8YoyTWsAQCajlBB6MX+Zf+55TQHRDNDN9h9jy8TEq1xc
         LV5g==
X-Gm-Message-State: AOAM53119KWu+vJd3n4iytB2J7eP5gxexlAsEnYGiyD/OyDP6Wi3WN/X
        eu5X3inTO2tCEec5eRJjddqN5pVQ5EQis2pk8+I=
X-Google-Smtp-Source: ABdhPJwTiao4FSAUx3O4pzReJ1W6BeUQJKtmW3Giv3QIrCHxAn67vVzUJqErOqtOuWLpp8tfVb1oYkIv9+Q031FWBaY=
X-Received: by 2002:ac8:342b:: with SMTP id u40mr1075576qtb.59.1590531220434;
 Tue, 26 May 2020 15:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com> <20200522041310.233185-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-2-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 15:13:29 -0700
Message-ID: <CAEf4BzYjaqQX+jxq42KvtBZXWS7Ld_f0AEQyejr-oMpL4JcyFA@mail.gmail.com>
Subject: Re: [PATCH 1/8] selftests/bpf: remove test_align from Makefile
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
> test_align has been moved under test_progs.
>
> Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under
> test_progs")
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

Fixes tag has to be on the single line, like this:

Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under test_progs")

Also no need for empty line between Fixes: and Signed-off-by: tags.

With that fixed, please add my ack:

Acked-by: Andrii Nakryiko <andriin@fb.com>



>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e716e931d0c9..09700db35c2d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -30,7 +30,7 @@ LDLIBS += -lcap -lelf -lz -lrt -lpthread
>
>  # Order correspond to 'make run_tests' order
>  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
> -       test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
> +       test_verifier_log test_dev_cgroup test_tcpbpf_user \
>         test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
>         test_cgroup_storage \
>         test_netcnt test_tcpnotify_user test_sock_fields test_sysctl \
> --
> 2.26.2
>
