Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48554589101
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 19:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiHCRKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 13:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHCRKq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 13:10:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424BA1583D
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 10:10:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q16so15674463pgq.6
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Y8hZLBaBnqYVGDfrejf6S+1ROpbgrpVmKFqLiQsn18M=;
        b=NklhyfZLxhS2sMoqjqUNcnZfw99+L8FmNfaF/QYGWnVud+0DF+ULH+y8Mx2tN/8O+4
         oLf+g0VGup/Q9hDd5oMco6PFbRqeJpxxEQQerFhWxciEAfEN3Zm7X3Y507sgYbNIi9PZ
         lbyH0QJrfTMwboxOJydp6cfwsywBv5iiNQ4YBUfdXcjnGcaEvUUgMnKbW+JFjTFh94sc
         FwPv+9m6LvR6wXCfpsSCdeWB0kHqGmGn19diTa8xs7BFc4dbykAibDogITcJAhQzdHXh
         PXrk/sgnB4jk9ZvasI/IQSaEiKHO3o7EJnMb5GyTLSXfNjYraedbU2ZlAD6k7D6J5cI/
         5kFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Y8hZLBaBnqYVGDfrejf6S+1ROpbgrpVmKFqLiQsn18M=;
        b=i8qnhUf/E1DHKtZFVDmsEGDk/O3Z8G4jhwAv1dm2pOHGuJGXiTy4Eq1FK3UJN8fY5F
         62mT9W0c3DkUH/7hW8QFgt0fu9gds+q4HjaMhDPhS0/V4P6gRIWqW2Msi2Zq+wDU7FGs
         obFbc+zVpZH42A5Xj7K+lASWRzW9fe1lLniRqMQdQwcfRVbRbUJMdkO1QY8TocpBDL41
         G9r+68vCDY9nXptBBKXCEV2LwMz1CODnU3eW07vv7HylLc/kzv2geFedDEKdyJPvObCl
         6luZ5noOOwd6kCAuwsb5x26hia+vEpaR3kDlZtYxzzL5NIgMZ2RUM/IxubdEU8+f56Qt
         JBfA==
X-Gm-Message-State: ACgBeo2bog0Y8yOEgxLXNfX82qbGHAR7XT9s96wdWY6h926Xmd0dcndg
        9KbGN/RQcsoFEsUvCuhejQRawrQ6SK39lmWfgDlIpaPx3m1JoQ==
X-Google-Smtp-Source: AA6agR67xj0SJ1Tx0Q2J3ghmNr0ylK+WYhuaDunsZnI4Hw8JA/wCT5ryhmeULm3kjEOUPq5L2ccZ6m5ip/BkE6gkpi4=
X-Received: by 2002:a63:ea45:0:b0:41c:86b0:5d05 with SMTP id
 l5-20020a63ea45000000b0041c86b05d05mr5016318pgk.442.1659546644483; Wed, 03
 Aug 2022 10:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220803163223.3747004-1-sdf@google.com> <20220803163223.3747004-2-sdf@google.com>
 <20220803165142.jp7xesq4ejxhwtl7@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220803165142.jp7xesq4ejxhwtl7@kafai-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 3 Aug 2022 10:10:33 -0700
Message-ID: <CAKH8qBsAotiMp8zj_MgM73mrOEVmvrX7UEuBB63ViHee4Z37WA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Excercise
 bpf_obj_get_info_by_fd for bpf2bpf
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 3, 2022 at 9:51 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Aug 03, 2022 at 09:32:23AM -0700, Stanislav Fomichev wrote:
> > +static void test_fentry_to_cgroup_bpf(void)
> > +{
> > +     struct bind4_prog *skel = NULL;
> > +     struct bpf_prog_info info = {};
> > +     __u32 info_len = sizeof(info);
> > +     int cgroup_fd = -1;
> > +     int fentry_fd = -1;
> > +     int btf_id;
> > +
> > +     cgroup_fd = test__join_cgroup("/fentry_to_cgroup_bpf");
> > +     if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
> > +             return;
> > +
> > +     skel = bind4_prog__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "skel"))
> > +             goto cleanup;
> > +
> > +     skel->links.bind_v4_prog = bpf_program__attach_cgroup(skel->progs.bind_v4_prog, cgroup_fd);
> > +     if (!ASSERT_OK_PTR(skel->links.bind_v4_prog, "bpf_program__attach_cgroup"))
> > +             goto cleanup;
> > +
> > +     btf_id = find_prog_btf_id("bind_v4_prog", bpf_program__fd(skel->progs.bind_v4_prog));
> > +     if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
> > +             goto cleanup;
> > +
> > +     fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind_v4_prog), btf_id);
> > +     if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
> > +             goto cleanup;
> > +
> > +     /* Make sure bpf_obj_get_info_by_fd works correctly when attaching
> > +      * to another BPF program.
> > +      */
> > +
> > +     ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> > +               "bpf_obj_get_info_by_fd");
> > +
> > +     ASSERT_EQ(info.btf_id, 0, "info.btf_id");
> > +     ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
> > +     ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
> nit. This can check against btf_id.

As in ASSERT_NEQ(info.attach_btf_obj_id, info.btf_id,
"info.attach_btf_obj_id") ?

> Overall lgtm. Thanks.
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Thank you for the review!
