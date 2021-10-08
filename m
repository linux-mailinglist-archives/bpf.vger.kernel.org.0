Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21235427404
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 01:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbhJHXKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243722AbhJHXKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 19:10:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF37C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 16:08:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so45299351lfu.5
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 16:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTBnlkAjt9bNIWz9nYIojTfMAG4P/ep2ibFYiwSAstY=;
        b=AtcbCT6mmsxeRuTYCgcJsWVRj8ZqjwuU8yaUhxI1vKH4mz+c9+mSxzNIDOwE9kDmEw
         LBGJsCmFbQGkt1mRD0giUx+5o4x216fLQQRkkCTr9qg1CA6tnYNoOsY50vRix2x//pOr
         fYFslNLJX8KZSedGWvVPlQGB4w8c3qDdlruYOmAiLbu2HSunqaqalpsa8dZuQBgkxR9z
         N015qDdnMFEIDhkAs642g2VFnaXCigT94tcspUIKmx8D8tU/zID26e3IChgD9TOylZ4x
         lNTzRCxavael46Y/wxjG1+xUw8zWhLA5ISb2k3zpq776My6rTQ6109VZJ5VN0lMgoVHy
         vumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTBnlkAjt9bNIWz9nYIojTfMAG4P/ep2ibFYiwSAstY=;
        b=ZF6egd1C59W5EtWbDYLj6hrgrFBYCetsEdG3ZWyWmcxSK5J7QuGgVwQgbGxl5CfgBx
         3Qp5KbPF9INMM++auhNCBrpTie57OF58sGrBzU19gbyY79ZOk+xkzQ/9Y3IUvM2ruVVH
         sBDcx4yLHSzX0Kigj5LHTYpfENS/9eR3YGV6qiwSKK2apIgQMcQFqG9YKS53U+TGwH+L
         MIX0VU6Hmbfj1yzVWsqKxlTREhyOUBDhfmkWpVScr5vMsES7T+ZTQRNI0PxhfTE1aQD5
         THJ8rZC2PyV7SvPOq/vtfLnBZQGWl502O26uhxg+JcItiA1I7szhpnciiEXCYMyxHXag
         W+9g==
X-Gm-Message-State: AOAM531/cjSxg1D5kHjYPQg4qtnYwW/f2pfswtzhXC/5g9imeRemm43f
        F7jkCEtijdVqmf+PiTuoxtPDXFrHW16wohvsdXg=
X-Google-Smtp-Source: ABdhPJwW/NBRhus12rcj3qLCitol0HJKI1CH36zkSbI09cMuPj1XFdF6HCDXIvco9k8KC0YulD2CBdgiF4ijsritsl4=
X-Received: by 2002:a05:6512:3341:: with SMTP id y1mr12993391lfd.487.1633734500895;
 Fri, 08 Oct 2021 16:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-9-fallentree@fb.com>
 <CAEf4BzaptXUD=fXZfLK6krKGa__oBogcXaHZkrrOk8b0st8O9g@mail.gmail.com>
In-Reply-To: <CAEf4BzaptXUD=fXZfLK6krKGa__oBogcXaHZkrrOk8b0st8O9g@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Fri, 8 Oct 2021 16:07:54 -0700
Message-ID: <CAJygYd1QbcZN4ok2UdeUtmj7jN6EejpLCxa2sBHvv_3ZbGhmLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 08/14] selftests/bpf: adding a namespace reset
 for tc_redirect
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 3:27 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
> >
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > This patch delete ns_src/ns_dst/ns_redir namespaces before recreating
> > them, making the test more robust.
> >
> > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > ---
> >  .../testing/selftests/bpf/prog_tests/tc_redirect.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > index e87bc4466d9a..25744136e131 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > @@ -176,6 +176,18 @@ static int netns_setup_namespaces(const char *verb)
> >         return 0;
> >  }
> >
> > +static void netns_setup_namespaces_nofail(const char *verb)
> > +{
> > +       const char * const *ns = namespaces;
> > +       char cmd[128];
> > +
> > +       while (*ns) {
> > +               snprintf(cmd, sizeof(cmd), "ip netns %s %s", verb, *ns);
> > +               system(cmd);
>
> is this what's causing
>
> Cannot remove namespace file "/var/run/netns/ns_src": No such file or directory
> Cannot remove namespace file "/var/run/netns/ns_fwd": No such file or directory
> Cannot remove namespace file "/var/run/netns/ns_dst": No such file or directory
>
> ?
>
> I haven't applied it yet, let's see if there is a way to avoid
> unnecessary "warnings".

we could just change this line

+               snprintf(cmd, sizeof(cmd), "ip netns %s %s > /dev/null
2>&1", verb, *ns);

to get rid of the warning

>
>
>
> > +               ns++;
> > +       }
> > +}
> > +
> >  struct netns_setup_result {
> >         int ifindex_veth_src_fwd;
> >         int ifindex_veth_dst_fwd;
> > @@ -762,6 +774,8 @@ static void test_tc_redirect_peer_l3(struct netns_setup_result *setup_result)
> >
> >  static void *test_tc_redirect_run_tests(void *arg)
> >  {
> > +       netns_setup_namespaces_nofail("delete");
> > +
> >         RUN_TEST(tc_redirect_peer);
> >         RUN_TEST(tc_redirect_peer_l3);
> >         RUN_TEST(tc_redirect_neigh);
> > --
> > 2.30.2
> >
