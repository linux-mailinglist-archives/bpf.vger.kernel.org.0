Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73744273B8
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243609AbhJHW3K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbhJHW3K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:10 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D233C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:27:14 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v195so24279663ybb.0
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kU7BspeEe24FkufKKY5iIKxlvfB3Z5HgoOSsibjURI=;
        b=Pp+LNXs+kM0+BR55wyeuSBxggxTI+atE/hdb65TkurAI+5wKkvZYzPsiMV+dA4jKcQ
         YHGEqN4EzHfsB/eL+lTj86Kdeyt7PjRqhWLtH3+eoSzjMWPncbXNB1vBbUo5ExPjbhYn
         TRF6n3i4z0C1YYVhP8pTpIEodaaWMNBnAFkxZAKl+FLiXoFq6f21vRYwJ4DUk4xLDl3t
         3c75YtqhOoXuibLiuxCacymTVTySNlxxBh2JZh8Fm16t/2a7SpapltLgFdBSaZoC1OFg
         5xkmWdZOstEpzEE7V1UPTynS6pMg+AT0s5BXfv7pVlfa9l/A8rLyauiIyyGUeof/Q8hM
         jjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kU7BspeEe24FkufKKY5iIKxlvfB3Z5HgoOSsibjURI=;
        b=w3qii05ZfKeWCExt99hXO+dyf50Bn1nHL+3aPlhMm/VTfn+y1KqG5ky95AOJU/B0jU
         ArZcwEwbvenadbLTDG89Ink3HVLlGJC7tfzn1PhTvUz1rZXAIUt7PbnFgofrRWV2iDNP
         Bogm9QUcknquvdznwiisRBXjBSRcc26rcaeyE9WBjAKAtsx5yV6ZSgjHtBZIICa1DEDi
         q6cqlHB9+MOFACrZCZFANAfuFd3/fVscnM1zc6ibtBi04pe8auYDy016aq7+Qg/56WF3
         /So1hx8OxW+rDVDWNinOvtowJgBcR/Qahv6reD3nyExiXfgBVQyxjcrscm1LOQXcsCNv
         aV7g==
X-Gm-Message-State: AOAM530MjfESgGtQcB2VKZoVPE+3vtunHTtez5/jNOv8x8FLzBdQCV7A
        esDO8K2Ll7MnZwoqFrDGFqsRmpu5b2fMzsD1Ung=
X-Google-Smtp-Source: ABdhPJxF7iwDIw0xuVHodtV8hgRC2r9S9muozFZROnI1lpHPIM7ntB/CkuCvMJAJdjXKX+GJH4hjd+dbyQHaBsCvQJY=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr6461412ybc.225.1633732033513;
 Fri, 08 Oct 2021 15:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-9-fallentree@fb.com>
In-Reply-To: <20211006185619.364369-9-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 15:27:02 -0700
Message-ID: <CAEf4BzaptXUD=fXZfLK6krKGa__oBogcXaHZkrrOk8b0st8O9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 08/14] selftests/bpf: adding a namespace reset
 for tc_redirect
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch delete ns_src/ns_dst/ns_redir namespaces before recreating
> them, making the test more robust.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---
>  .../testing/selftests/bpf/prog_tests/tc_redirect.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> index e87bc4466d9a..25744136e131 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> @@ -176,6 +176,18 @@ static int netns_setup_namespaces(const char *verb)
>         return 0;
>  }
>
> +static void netns_setup_namespaces_nofail(const char *verb)
> +{
> +       const char * const *ns = namespaces;
> +       char cmd[128];
> +
> +       while (*ns) {
> +               snprintf(cmd, sizeof(cmd), "ip netns %s %s", verb, *ns);
> +               system(cmd);

is this what's causing

Cannot remove namespace file "/var/run/netns/ns_src": No such file or directory
Cannot remove namespace file "/var/run/netns/ns_fwd": No such file or directory
Cannot remove namespace file "/var/run/netns/ns_dst": No such file or directory

?

I haven't applied it yet, let's see if there is a way to avoid
unnecessary "warnings".



> +               ns++;
> +       }
> +}
> +
>  struct netns_setup_result {
>         int ifindex_veth_src_fwd;
>         int ifindex_veth_dst_fwd;
> @@ -762,6 +774,8 @@ static void test_tc_redirect_peer_l3(struct netns_setup_result *setup_result)
>
>  static void *test_tc_redirect_run_tests(void *arg)
>  {
> +       netns_setup_namespaces_nofail("delete");
> +
>         RUN_TEST(tc_redirect_peer);
>         RUN_TEST(tc_redirect_peer_l3);
>         RUN_TEST(tc_redirect_neigh);
> --
> 2.30.2
>
