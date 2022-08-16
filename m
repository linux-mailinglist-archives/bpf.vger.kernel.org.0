Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9955960E9
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiHPRTc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 13:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiHPRTb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 13:19:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC2852820
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:19:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k14so9914202pfh.0
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=J9UmHsCVJn8xu4u2hvlgyWbs4c3FaEtd0xlYK3QJl+M=;
        b=bPwFixxdoJes2rhtFtZEaZZm1fyrllghLwnULD7gBoFKbfb2YqFnTgxNHnuTDCDBFg
         2031kzIanwmdVs6mCB3LIA5bos9PICJ/MaU2VtFCqsVaBf2DRP2HkDpWfAgACwEolze7
         hZATnGhS5T1S6okxoffCQ2MFHrF3ZxNMZojtN02fXluePdf8DccNr55W8lbhIn1ZQSen
         ZluUbhVHYu3Xclvl7dHeroVvcorDrXGSitOt1O1v/8cXtzWgSxyBOeUKgSbuPaXiGE0x
         D0gwHEDZQWkc4gadoxAk8LyZHbJrJTyzZlZdOj282dtgXHuPuPS6uoAJkkDpwdgJpVRf
         a2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=J9UmHsCVJn8xu4u2hvlgyWbs4c3FaEtd0xlYK3QJl+M=;
        b=c5Q009NOFag+e4cjTAKijAL+Z78bEUZNrTHWIV0YvRVyk4858ZtOw1PDD2aSopfN2G
         gNWnS8cnX4WHVaBJH//LRz1tfMZ5CsEOX19a54vVtvpOvenTJdJuxiGaunnJ4t1/imbQ
         NwKgLvUQfzv+I3g6XS5vdV72fkNkIcQGZ0U/zzJi0Ax/xCmYH+Q86r52JPRp4SS0wFZZ
         FCX4qefuVkIaf/P8Hh4LXa34BO23h2nForC507un5p945utZdg8rpwVpLgtFEQkMHPMT
         8QCk61Q1p3UYZ5XTFCsVGSif4qtuLcIhyhrtS/RBYyhf1ld2tNiqfcGF5e4RRyc+BXb5
         zL5w==
X-Gm-Message-State: ACgBeo1q9NkC6Pg1Lxm+ijvFrG/3KB0ZnZwDPdB2x3ys/6UQVjNDQ82v
        BpHrHuHs1JJNmwNJV6aghNKHgk+ZesMTwheN8HDJ4QUNd4E=
X-Google-Smtp-Source: AA6agR5iHZ8XYLQpZT2qQ8uyElIafDbLSb25QGxC5UoPsBgM9ZuYT9rTzFD/7O6c+LybXmVrhNo6YnFz62F8HFnWyDM=
X-Received: by 2002:aa7:8895:0:b0:52e:c742:2f3d with SMTP id
 z21-20020aa78895000000b0052ec7422f3dmr21702459pfe.69.1660670369955; Tue, 16
 Aug 2022 10:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220812190241.3544528-1-sdf@google.com> <20220812190241.3544528-2-sdf@google.com>
 <20220815212647.6wddh5spdl2l554v@kafai-mbp>
In-Reply-To: <20220815212647.6wddh5spdl2l554v@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 16 Aug 2022 10:19:19 -0700
Message-ID: <CAKH8qBudSSHkP+FjEjZVocW94e12MSmX8-hEWyQ=8fOFHbUPpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: introduce cgroup_{common,current}_func_proto
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

On Mon, Aug 15, 2022 at 2:27 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Aug 12, 2022 at 12:02:39PM -0700, Stanislav Fomichev wrote:
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 3c1b9bbcf971..de7d2fabb06d 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -429,7 +429,6 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
> >  };
> >
> >  #ifdef CONFIG_CGROUP_BPF
> > -
> >  BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
> >  {
> >       /* flags argument is not used now,
> > @@ -460,7 +459,37 @@ const struct bpf_func_proto bpf_get_local_storage_proto = {
> >       .arg1_type      = ARG_CONST_MAP_PTR,
> >       .arg2_type      = ARG_ANYTHING,
> >  };
> > -#endif
> > +
> > +BPF_CALL_0(bpf_get_retval)
> > +{
> > +     struct bpf_cg_run_ctx *ctx =
> > +             container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> > +
> > +     return ctx->retval;
> > +}
> > +
> > +const struct bpf_func_proto bpf_get_retval_proto = {
> > +     .func           = bpf_get_retval,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +};
> > +
> > +BPF_CALL_1(bpf_set_retval, int, retval)
> > +{
> > +     struct bpf_cg_run_ctx *ctx =
> > +             container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> > +
> > +     ctx->retval = retval;
> > +     return 0;
> > +}
> > +
> > +const struct bpf_func_proto bpf_set_retval_proto = {
> > +     .func           = bpf_set_retval,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_ANYTHING,
> > +};
> > +#endif /* CONFIG_CGROUP_BPF */
> >
> >  #define BPF_STRTOX_BASE_MASK 0x1F
> >
> > @@ -1726,6 +1755,40 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> >       }
> >  }
> >
> > +/* Common helpers for cgroup hooks. */
> > +const struct bpf_func_proto *
> > +cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > +{
> > +     switch (func_id) {
> > +#ifdef CONFIG_CGROUP_BPF
> > +     case BPF_FUNC_get_local_storage:
> > +             return &bpf_get_local_storage_proto;
> > +     case BPF_FUNC_get_retval:
> > +             return &bpf_get_retval_proto;
> > +     case BPF_FUNC_set_retval:
> > +             return &bpf_set_retval_proto;
> > +#endif
> > +     default:
> > +             return NULL;
> > +     }
> > +}
> > +
> > +/* Common helpers for cgroup hooks with valid process context. */
> > +const struct bpf_func_proto *
> > +cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > +{
> > +     switch (func_id) {
> > +#ifdef CONFIG_CGROUPS
> > +     case BPF_FUNC_get_current_uid_gid:
> > +             return &bpf_get_current_uid_gid_proto;
> > +     case BPF_FUNC_get_current_cgroup_id:
> > +             return &bpf_get_current_cgroup_id_proto;
> > +#endif
> > +     default:
> > +             return NULL;
> > +     }
> > +}
> Does it make sense to move all these changes to kernel/bpf/cgroup.c
> instead such that there is no need to do 'ifdef CONFIG_CGROUPS*'.
> bpf_get_local_storage probably needs to move to kernel/bpf/cgroup.c
> also.

Hm, didn't think about it, let me try moving everything under
bpf/cgroup.c instead..

(saw the build failures but decided not to spam with a v2)
