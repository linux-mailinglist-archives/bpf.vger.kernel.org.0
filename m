Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2D4F673A
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiDFRgc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbiDFRfz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 13:35:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3447321FF6C
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 08:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2ECEB824B5
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 15:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C1AC385AB
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649259857;
        bh=vWK0HC0ZdB8sGlZbserDZ72jYW8Fc7a6wD4c+Cm9cEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q9tKaQ181ABxBjopzcekbKg07gHajXbcwu63QACqRHdX43M+cU4bZnoShL5BErCY3
         Dag7krCNvzPT+GUx50eHYxdRSUPNYGhqEo0D3m/kFQRtGoPPNbIUqMYZnxYPBT4KUM
         sSM8KuyMVdcjT1kstSunkZEtGKk3mMctT28M774MizgpP/hfmGmg/sCt2R8gJl2seV
         ymXqtU26gFr6XXAXM6vsOd0pfBn1x8H1LHHxp4uSC4Y72cgmJTdKTHQyt/i8G/IOha
         qKGXanhgEXiLsgSrxRuz37E69s8vyWQPN4z+8W9v6FG1QYa6zpeOBVAwzriNDpUKFO
         m3+E4T6jaClLA==
Received: by mail-ed1-f49.google.com with SMTP id k2so3110504edj.9
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 08:44:17 -0700 (PDT)
X-Gm-Message-State: AOAM530dxVbolhZAJzMeEkTFRCRwwQWBD/jVRq6dgK6c8VT/w4tBjAH2
        Q92OCLKaLVCNDLzbLVQooFZb1Jfea7X8oimpwRyWOg==
X-Google-Smtp-Source: ABdhPJyaG4jcygMbIK/QmOhsgzrDD5mFbTDbuH4e9qOhaSZhbNfMBZ9eMb7X4WN0vEA251tH5tnUwG4TptP45S7VRqo=
X-Received: by 2002:a05:6402:f1c:b0:41b:54d2:ef1b with SMTP id
 i28-20020a0564020f1c00b0041b54d2ef1bmr9317277eda.185.1649259855672; Wed, 06
 Apr 2022 08:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89i+rfrkRrdYAq8Baq04n_ACq+VdB+UcsMoq7U-dB-2hKJA@mail.gmail.com>
 <20220401000642.GB4285@paulmck-ThinkPad-P17-Gen-1> <CANn89iJtfTiSz4v+L3YW+b_gzNoPLz_wuAmXGrNJXqNs9BU9cA@mail.gmail.com>
 <20220401130114.GC4285@paulmck-ThinkPad-P17-Gen-1> <CANn89iLicuKS2wDjY1D5qNT4c-ob=D2n1NnRnm5fGg4LFuW1Kg@mail.gmail.com>
 <20220401152037.GD4285@paulmck-ThinkPad-P17-Gen-1> <20220401152814.GA2841044@paulmck-ThinkPad-P17-Gen-1>
 <20220401154837.GA2842076@paulmck-ThinkPad-P17-Gen-1> <7a90a9b5-df13-6824-32d1-931f19c96cba@quicinc.com>
 <CACYkzJ4FzbFu5NfdRMParp3Ome=ygVAqQPs2v6UGzRDt2LC6iw@mail.gmail.com> <20220405203818.qsi7j74jpsex7oky@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220405203818.qsi7j74jpsex7oky@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 6 Apr 2022 17:44:05 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5PkwidPAomc-+js=OTFdzwf38hMO01Q_rbsPM-HZTTkg@mail.gmail.com>
Message-ID: <CACYkzJ5PkwidPAomc-+js=OTFdzwf38hMO01Q_rbsPM-HZTTkg@mail.gmail.com>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, paulmck@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>, andrii@kernel.org,
        ast@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 5, 2022 at 10:38 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Apr 05, 2022 at 02:04:34AM +0200, KP Singh wrote:
> > > >>> Either way, how frequently is call_rcu_tasks_trace() being invoked in
> > > >>> your setup?  If it is being invoked frequently, increasing delays would
> > > >>> allow multiple call_rcu_tasks_trace() instances to be served by a single
> > > >>> tasklist scan.
> > > >>>
> > > >>>> Given that, I do not think bpf_sk_storage_free() can/should use
> > > >>>> call_rcu_tasks_trace(),
> > > >>>> we probably will have to fix this soon (or revert from our kernels)
> > > >>>
> > > >>> Well, you are in luck!!!  This commit added call_rcu_tasks_trace() to
> > > >>> bpf_selem_unlink_storage_nolock(), which is invoked in a loop by
> > > >>> bpf_sk_storage_free():
> > > >>>
> > > >>> 0fe4b381a59e ("bpf: Allow bpf_local_storage to be used by sleepable programs")
> > > >>>
> > > >>> This commit was authored by KP Singh, who I am adding on CC.  Or I would
> > > >>> have, except that you beat me to it.  Good show!!!  ;-)
> >
> > Hello :)
> >
> > Martin, if this ends up being an issue we might have to go with the
> > initial proposed approach
> > of marking local storage maps explicitly as sleepable so that not all
> > maps are forced to be
> > synchronized via trace RCU.
> >
> > We can make the verifier reject loading programs that try to use
> > non-sleepable local storage
> > maps in sleepable programs.
> >
> > Do you think this is a feasible approach we can take or do you have
> > other suggestions?
> bpf_sk_storage_free() does not need to use call_rcu_tasks_trace().
> The same should go for the bpf_{task,inode}_storage_free().
> The sk at this point is being destroyed.  No bpf prog (sleepable or not)
> can have a hold on this sk.  The only storage reader left is from
> bpf_local_storage_map_free() which is under rcu_read_lock(),
> so a 'kfree_rcu(selem, rcu)' is enough.
> A few lines below in bpf_sk_storage_free(), 'kfree_rcu(sk_storage, rcu)'
> is currently used instead of call_rcu_tasks_trace() for the same reason.
>
> KP, if the above makes sense, can you make a patch for it?
> The bpf_local_storage_map_free() code path also does not need
> call_rcu_tasks_trace(), so may as well change it together.
> The bpf_*_storage_delete() helper and the map_{delete,update}_elem()
> syscall still require the call_rcu_tasks_trace().

Thanks, I will send a patch.
