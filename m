Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0353758923D
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiHCS1l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 14:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbiHCS1h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 14:27:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45115A2F9
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 11:27:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so2849179pjn.3
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SRwtA707AmX/MwRu3ABzIXYiv+Ca4br4bKPrZGaCYs4=;
        b=S43u8mtb9ddkazJg3DaHv0fFJTAgi/DAdnKMKWDEgIOCmlh/Sf3S8RjO8/MnSOrUu8
         PhTm3mQTvOM4HmJS8WDZW8rwvZpaVbeSYnOs+/aaO7FKPipbQ9vU8j+BqXa6/OlrwHeQ
         UyMo2Y2jAX6WcF2evQ7y7RYBHtldqgzlP3AO3YXSRwaxM4iVH6EKK+OAE4G1c/hbz7CS
         9PyavbbzGtpiZpct92VsiX2mdoIdJ1sAe+/C6cD1prk411OwzSms70b+v8VBSJTuvdBh
         QAg3NR3O0tGUT2AmtQQdd+B4Pf7GWQCsyiLF9Pku6titEewsgnHLwglW3cgfXfTqSKAb
         6IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SRwtA707AmX/MwRu3ABzIXYiv+Ca4br4bKPrZGaCYs4=;
        b=d039eK/CElsR2WI4ggLU9hI4e9Bs22v6cGVBjZm59lv3kLdtPrVEtrPUr14VdPH6+q
         qrQbVEudlWnpUSmFdNNe7U9gBA58zAP27a4IJSJkNjm5Oe+0K/lGXxjpJqIuqwroQw/8
         sEDvgyXI5nRv9GR11XMtaHg67Vy9Ytk3s+HmrN6g0/iRIJmldcnLWrlLTxdixPtDbKa9
         8uy3OZlRpujWBBT5Bwvs8HKUN5yzszlBq/Oooo6RyxxRWKAn0FlZXt9FAzdvI+YGu5UV
         3qZeJKcc5ZuYB+sdT3AHQakrQ8KLWL+nbqe8BNMDMDwGvbizu+a3tpdAbgjtg6vP2n8n
         ehtw==
X-Gm-Message-State: ACgBeo3MM/Qkf5wBwWeLJS7QH4gCY03nvx1xVTINDvEevlo5VqH74It6
        lk3ZzXAtEq8mi1H27wqsEbd6+T3RXpzn0ZHEsTp3PQ==
X-Google-Smtp-Source: AA6agR6/eFrzUkwLG1UcdFVPALpyRZ81brItoj/6cSg/81BkrwSixPbARAfc/DhB7+H0k//Oqt4nMLk69ZoBiAX6tCQ=
X-Received: by 2002:a17:903:1111:b0:16a:acf4:e951 with SMTP id
 n17-20020a170903111100b0016aacf4e951mr26889387plh.72.1659551255230; Wed, 03
 Aug 2022 11:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220803163223.3747004-1-sdf@google.com> <20220803163223.3747004-2-sdf@google.com>
 <20220803165142.jp7xesq4ejxhwtl7@kafai-mbp.dhcp.thefacebook.com>
 <CAKH8qBsAotiMp8zj_MgM73mrOEVmvrX7UEuBB63ViHee4Z37WA@mail.gmail.com> <20220803171904.m2gqrd3rf4td6l4p@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220803171904.m2gqrd3rf4td6l4p@kafai-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 3 Aug 2022 11:27:24 -0700
Message-ID: <CAKH8qBuxZDa0-xBXw1Gmt+y7gnoXGdd-f3Tr3dHuaMFPvEFE1w@mail.gmail.com>
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

On Wed, Aug 3, 2022 at 10:19 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Aug 03, 2022 at 10:10:33AM -0700, Stanislav Fomichev wrote:
> > On Wed, Aug 3, 2022 at 9:51 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Wed, Aug 03, 2022 at 09:32:23AM -0700, Stanislav Fomichev wrote:
> > > > +static void test_fentry_to_cgroup_bpf(void)
> > > > +{
> > > > +     struct bind4_prog *skel = NULL;
> > > > +     struct bpf_prog_info info = {};
> > > > +     __u32 info_len = sizeof(info);
> > > > +     int cgroup_fd = -1;
> > > > +     int fentry_fd = -1;
> > > > +     int btf_id;
> > > > +
> > > > +     cgroup_fd = test__join_cgroup("/fentry_to_cgroup_bpf");
> > > > +     if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
> > > > +             return;
> > > > +
> > > > +     skel = bind4_prog__open_and_load();
> > > > +     if (!ASSERT_OK_PTR(skel, "skel"))
> > > > +             goto cleanup;
> > > > +
> > > > +     skel->links.bind_v4_prog = bpf_program__attach_cgroup(skel->progs.bind_v4_prog, cgroup_fd);
> > > > +     if (!ASSERT_OK_PTR(skel->links.bind_v4_prog, "bpf_program__attach_cgroup"))
> > > > +             goto cleanup;
> > > > +
> > > > +     btf_id = find_prog_btf_id("bind_v4_prog", bpf_program__fd(skel->progs.bind_v4_prog));
> > > > +     if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
> > > > +             goto cleanup;
> > > > +
> > > > +     fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind_v4_prog), btf_id);
> > > > +     if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
> > > > +             goto cleanup;
> > > > +
> > > > +     /* Make sure bpf_obj_get_info_by_fd works correctly when attaching
> > > > +      * to another BPF program.
> > > > +      */
> > > > +
> > > > +     ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> > > > +               "bpf_obj_get_info_by_fd");
> > > > +
> > > > +     ASSERT_EQ(info.btf_id, 0, "info.btf_id");
> > > > +     ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
> > > > +     ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
> > > nit. This can check against btf_id.
> >
> > As in ASSERT_NEQ(info.attach_btf_obj_id, info.btf_id,
> > "info.attach_btf_obj_id") ?
> Ah, my bad on one line off.  I meant the previous line.
>
> ASSERT_NEQ(info.attach_btf_id, btf_id, "info.attach_btf_id");

Thanks! I'm assuming that I also confused you with that ASSERT_NEQ and
you really meant:
ASSERT_EQ(info.attach_btf_id, btf_id, "info.attach_btf_id");

Will wait for more potential feedback from Hao/Andrii and will try to
respin tomorrow with your suggestion applied.

> The bind_v4_prog's btf_obj_id is lost.  Otherwise, it could also do
> ASSERT_NEQ(info.attach_btf_obj_id, bind_v4_prog_btf_id, "info.attach_btf_obj_id");
