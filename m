Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CFF5B2A85
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 01:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIHXpA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 19:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIHXo7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 19:44:59 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AA64AD4E
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 16:44:57 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id m66so102893vsm.12
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 16:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y7TWOtDpon5Nttq0NPO+sGf6ZvFDO5uaqBl6d0L6ZOA=;
        b=HFQZlKkjbX7wGP4tkFuL5B23GQLh56nqk4VIx9k2YoQ/Ds0n1iD9o3hfy0c9stpYq7
         Wmievp83EWVegnKdrGPf0TgbZdlJAQdrZDTWGNnO4H1Sq0AMWNiZpBXU9ZKzRpDy0ciU
         iTsfKd4CS8HSHjfZ6ZLUqbgWS/hJ5td6adUI6Wppp7Nw7qQsxaNwGfBNU8kc+pB8A/cE
         N/yCZ+xYbXMbghz76yROrj6PAAiotjX2lkcrNL35h3fvZfCV1Q6pPcIfv9MaKeOfhTTy
         WZYWGyEB/jnr/wVQSV/Y/z7MpOnlc+onegXDdb08xmwQdIMpUxjSzlUYDd12g/b2rqUE
         ixOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y7TWOtDpon5Nttq0NPO+sGf6ZvFDO5uaqBl6d0L6ZOA=;
        b=7VI2ZJycix/n7OzttOr4TXNFtTBno1iUfzsapWGSnYBtKQlE7OZ6/7XxwgU1m91bp/
         Bp2PXoFlCTR+AmexGCRE19gZ9dEj08TXFofP59rNEwkC7qrF2MrNX/hpkrQ8UgRnvfqd
         agiFQavhuX7zwhWqn1lyuFYugMIH0MmCTNh2tOwmQGjYZNFLkBiaCX/yJThrPV04pOIX
         iNYqyVytXkblMDZFNIW2q5lFOR6sptAQkI4GF8oCWl3juoB1NOr0xnJSJiswdzTLUttX
         S7XJRXdoKurhFO0ec9dC/qr2VUx+FXF1ipZCP9rnRpQejWC2qc9hFU1QPOaqpYTDMVqJ
         bvJg==
X-Gm-Message-State: ACgBeo2ymelSqbvgA0tX+G7J9x5MxPmenfj/gMURT2dBA9h6MjZjPK5y
        k7LlCsXWxEqrDUMy5w+g/uGZJBojrkvIXIAVST/jvA==
X-Google-Smtp-Source: AA6agR6fCuZSA22FZAqMML4OzLwnMQXRGaa1//x9SdMthC42hxy7ww05w5TNZCCPLILYHro8Pk7iyLyyGK22vHXEty8=
X-Received: by 2002:a05:6102:40d:b0:398:2420:b4e7 with SMTP id
 d13-20020a056102040d00b003982420b4e7mr3622694vsq.46.1662680696153; Thu, 08
 Sep 2022 16:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662678623.git.zhuyifei@google.com> <97288b66a44c984cb5514ca7390ca0cf9c30275f.1662678623.git.zhuyifei@google.com>
 <e1648c86-7859-a7c8-4474-83c826cbb464@linux.dev>
In-Reply-To: <e1648c86-7859-a7c8-4474-83c826cbb464@linux.dev>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Thu, 8 Sep 2022 16:44:45 -0700
Message-ID: <CAA-VZPnTBOOAxu+VqupzDqej_wheXYbOGxG0nuV+eMPqS35GKQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: Ensure cgroup/connect{4,6}
 programs can bind unpriv ICMP ping
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 8, 2022 at 4:32 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 9/8/22 4:16 PM, YiFei Zhu wrote:
> > +void test_connect_ping(void)
> > +{
> > +     struct connect_ping *skel;
> > +     int cgroup_fd;
> > +
> > +     if (!ASSERT_OK(unshare(CLONE_NEWNET | CLONE_NEWNS), "unshare"))
> > +             return;
> > +
> > +     /* overmount sysfs, and making original sysfs private so overmount
> > +      * does not propagate to other mntns.
> > +      */
> > +     if (!ASSERT_OK(mount("none", "/sys", NULL, MS_PRIVATE, NULL),
> > +                    "remount-private-sys"))
> > +             return;
> > +     if (!ASSERT_OK(mount("sysfs", "/sys", "sysfs", 0, NULL),
> > +                    "mount-sys"))
> > +             return;
> > +     if (!ASSERT_OK(mount("bpffs", "/sys/fs/bpf", "bpf", 0, NULL),
> > +                    "mount-bpf"))
> > +             goto clean_mount;
> > +
> > +     if (!ASSERT_OK(system("ip link set dev lo up"), "lo-up"))
> > +             goto clean_mount;
> > +     if (!ASSERT_OK(system("ip addr add 1.1.1.1 dev lo"), "lo-addr-v4"))
> > +             goto clean_mount;
> > +     if (!ASSERT_OK(system("ip -6 addr add 2001:db8::1 dev lo"), "lo-addr-v6"))
> > +             goto clean_mount;
> > +     if (write_sysctl("/proc/sys/net/ipv4/ping_group_range", "0 0"))
> > +             goto clean_mount;
> > +
> > +     cgroup_fd = test__join_cgroup("/connect_ping");
> > +     if (!ASSERT_GE(cgroup_fd, 0, "cg-create"))
> > +             goto clean_mount;
> > +
> > +     skel = connect_ping__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "skel-load"))
> > +             goto close_cgroup;
> > +     skel->links.connect_v4_prog =
> > +             bpf_program__attach_cgroup(skel->progs.connect_v4_prog, cgroup_fd);
> > +     if (!ASSERT_OK_PTR(skel->links.connect_v4_prog, "cg-attach-v4"))
> > +             goto close_cgroup;
>
> connect_ping__destroy() is also needed in this error path.
>
> I had already mentioned that in v2.  I went back to v2 and noticed my
> editor some how merged my reply with the previous quoted line ">".  A
> similar thing happened in my recent replies also.  I hope it appears
> fine this time.

Oops, I missed that and thought that was part of a quote. Let me fix
that and send a v4.

> > +     skel->links.connect_v6_prog =
> > +             bpf_program__attach_cgroup(skel->progs.connect_v6_prog, cgroup_fd);
> > +     if (!ASSERT_OK_PTR(skel->links.connect_v6_prog, "cg-attach-v6"))
> > +             goto close_cgroup;
>
> Same here.
