Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E993459C6D6
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 20:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbiHVSoJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 14:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiHVSnk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 14:43:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E6E2F67A
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 11:41:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 2so10746297pll.0
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pAeGXiKDSHzRtBmd1eWz1XWxXqUizgH5ixhi8wAAWw4=;
        b=iUZVbozod0D8GPLYVijRLZSBCDBgSpySgtU8wEA99aO98zLOe8pz6m2Hc6f2Kc5s09
         lEmvWyjcM0o5mp3/msywTKtf+DLYhSqV0GzfCA7Ydfae/c+lOPV10gA6W0FOv+rT7/KD
         1Van0Y+Ntj1i9aYslzgQTq1dc0PVQoYIccXLbz/P41mCNthEk0XXOovcRuJ4hqA1MLXn
         saBRD2f9p1fMbY0WvpzhxLquHtu6mSx+dJ1AoxIWSeARSyfsXX5gmArfn7+TcrNwfjQ6
         DPe0f9odSmdGs7OH1DnwhspZWbHh+1aTKhb9R9IhvWTatZxvIIPYyqyRX1CTlPpQ9Sak
         XMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pAeGXiKDSHzRtBmd1eWz1XWxXqUizgH5ixhi8wAAWw4=;
        b=TUVWs6WYYbmIJz66jZ9gl1QRyP4O7EG1zWzCw4inTqJzHAGtfzwYJXtLGPazXJhGT9
         C78+TR7jF8uCd2Sqt37CiguSe1fm2EN99NESTfxPCJjjHKPxKXBZqCfTYBXOmg0Ea8xg
         JC8wELi63MT8hd1anUIuvSAmkSdy+YnrxYMTvKKaSP7JjwBX3NoQO1B2RvapM5rWivQC
         sbWv+ENpmvQh2SoxVgVtFxYctT2DEAZpVR0TC8I123x5KRQxBI+SABghnR5WxbCVKbET
         g0EkzN6mhQgnHx4ickZCmpYVobeJOr5C+IWz68wqwR+KRfgA8bLvL5o2sDe0l6DIDebJ
         1oDw==
X-Gm-Message-State: ACgBeo02VSgA7s58JmxCl3+T7BYF0rtC+4LtY/R8QrXfqAfPkujCVcYq
        F6SyPmPgpC6rt0RNtEcmW+/7uhaLMmviiKYpRI7tdw==
X-Google-Smtp-Source: AA6agR4B6s+ZmBDoziuXzM5unWKVnO3keZXlJl4oUVaui3L5QnwlZ7xANyKjLsN8OIjgC5akajT4SlazfTziU/RCxDo=
X-Received: by 2002:a17:902:db01:b0:172:fa5b:2ec5 with SMTP id
 m1-20020a170902db0100b00172fa5b2ec5mr2085302plx.73.1661193636309; Mon, 22 Aug
 2022 11:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220818232729.2479330-1-sdf@google.com> <20220818232729.2479330-2-sdf@google.com>
 <20220819181756.2jfak4bfsu5x7csb@kafai-mbp>
In-Reply-To: <20220819181756.2jfak4bfsu5x7csb@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 22 Aug 2022 11:40:25 -0700
Message-ID: <CAKH8qBtx_cUuToFZjrvU_F7p8_XOgEyTbSJXw7UMW6o3C==k8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Introduce cgroup_{common,current}_func_proto
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
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

On Fri, Aug 19, 2022 at 11:18 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Aug 18, 2022 at 04:27:25PM -0700, Stanislav Fomichev wrote:
> > +BPF_CALL_0(bpf_get_current_cgroup_id)
> > +{
> > +     struct cgroup *cgrp;
> > +     u64 cgrp_id;
> > +
> > +     rcu_read_lock();
> > +     cgrp = task_dfl_cgroup(current);
> > +     cgrp_id = cgroup_id(cgrp);
> > +     rcu_read_unlock();
> > +
> > +     return cgrp_id;
> > +}
> > +
> > +const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
> > +     .func           = bpf_get_current_cgroup_id,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +};
> > +
> > +BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
> > +{
> > +     struct cgroup *cgrp;
> > +     struct cgroup *ancestor;
> > +     u64 cgrp_id;
> > +
> > +     rcu_read_lock();
> > +     cgrp = task_dfl_cgroup(current);
> > +     ancestor = cgroup_ancestor(cgrp, ancestor_level);
> > +     cgrp_id = ancestor ? cgroup_id(ancestor) : 0;
> > +     rcu_read_unlock();
> > +
> > +     return cgrp_id;
> > +}
> > +
> > +const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
> > +     .func           = bpf_get_current_ancestor_cgroup_id,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_ANYTHING,
> > +};
> The bpf_get_current_cgroup_id_proto and
> bpf_get_current_ancestor_cgroup_id_proto should stay at helpers.c.
> Otherwise, those non cgroup hooks will have issue (eg. bpf_trace.c)
> when CONFIG_CGROUP_BPF not set.

Oh, good point on bpf_trace.c, will keep in helpers.c
I'm now a bit surprised I haven't seen a build failure :-/
Thank you for the review! Will address your other point and resend.


> May be in the future cgroup_current_func_proto() can be re-used for non
> cgroup hooks.
>
> > +#ifdef CONFIG_CGROUP_NET_CLASSID
> > +BPF_CALL_0(bpf_get_cgroup_classid_curr)
> > +{
> > +     return __task_get_classid(current);
> > +}
> > +
> > +const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
> > +     .func           = bpf_get_cgroup_classid_curr,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +};
> > +#endif
> Same for this one. eg. sk_msg needs it.  probably stay in filter.c as-is.
