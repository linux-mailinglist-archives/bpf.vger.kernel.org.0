Return-Path: <bpf+bounces-9477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D57980B9
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 04:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615161C20C6D
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 02:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E12515B9;
	Fri,  8 Sep 2023 02:54:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BD139E
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 02:54:00 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D501BD8;
	Thu,  7 Sep 2023 19:53:58 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6516a8e2167so9155716d6.2;
        Thu, 07 Sep 2023 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694141638; x=1694746438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6fop6ayCaKn3gScpGY1wXrhdJ9eTL5GofQSvvTxRa8=;
        b=YjGUp47ubnuHNEql8yabyWdBhcpWbv+5y9GaZTP3BrgXlATKK+saBPEp2ojtWcx4Wk
         MEvVITgoyrjA+BRN0JzO60IekE0WKt8OFX1+mG6L3RZTYa/yLkcviCf6jbSokf5/TfPs
         X2U3hRKTrhVnsGdFho/4EBWhRBbGkJw9Y9OJ2EgQsaxyBJcYebBNIl5D3HMd2j1SR+XO
         1hzsUqCZ8BsI7aIQdsCdUuWGXaFO9ASMdqEHknceGBQN6lciQJJgBAHCWEtGFzXS9h3J
         3xydvI9TvE2qjuGFeeF1DDUXSwP5dhD2odwYgr/Co4GO+O+pwZ/Yqavd2K2HW2ycXeHA
         4G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694141638; x=1694746438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6fop6ayCaKn3gScpGY1wXrhdJ9eTL5GofQSvvTxRa8=;
        b=BO33qUGjERluOHAjkHysEKBkTWIb2Gs7eyx/rf9yzAnQQfO9atu43sszIy3JYVZ/5e
         VwuRZpICgKFq/IxIuIeaqFUgSBM3ZhXBguo7XuEJ27Q8/nogHaH36Ey8x+/p/Ptw7K+h
         hnarMQw/mQzLN9BweutBV50ZfaDmhLNqCeaSIP+E+b2NlzxLIspwFizbC3F9nZ4gqCgz
         lJYNiw75dbANZI+VGlXwpRqpKdk79nkDH1TVBugYTMwF8HcKwE3837VaYMFqCYkaJAYB
         1wf7G7SABEkooRbp7vMSt/SSaoX465uEas2v707rONx2Z6pB9qb47ZVtq//NDQougYFw
         NTLw==
X-Gm-Message-State: AOJu0YxSJhWmCPxf7wBTdRRUV5F+L6Lpvj7s0iE8YtuKH92Hz4u65neC
	+RnhKqTAyjPfaW3cCkGPuhxa/y/FMTZ7lN8h3/M=
X-Google-Smtp-Source: AGHT+IG2l/oDM2swr1zYmOybLiyYn3afTGW/qz1V4KKJQsRw5vChpKb3fkrPw1CmCFCegpwzaQDtjTAgrnJdrhORFpU=
X-Received: by 2002:a0c:f508:0:b0:641:8e1a:d23b with SMTP id
 j8-20020a0cf508000000b006418e1ad23bmr1061971qvm.31.1694141637964; Thu, 07 Sep
 2023 19:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230903142800.3870-1-laoar.shao@gmail.com> <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
In-Reply-To: <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 8 Sep 2023 10:53:21 +0800
Message-ID: <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on cgroup1
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 10:41=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello Yafang.
>
> On Sun, Sep 03, 2023 at 02:27:55PM +0000, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > In our specific use case, we intend to use bpf_current_under_cgroup() t=
o
> > audit whether the current task resides within specific containers.
>
> I wonder -- how does this work in practice?

In our practice, the cgroup_array map serves as a shared map utilized
by both our LSM programs and the target pods. as follows,

    ----------------
    | target pod |
    ----------------
           |
           |
          V                                      ----------------
 /sys/fs/bpf/cgoup_array     <--- | LSM progs|
                                                  ----------------

Within the target pods, we employ a script to update its cgroup file
descriptor into the cgroup_array, for instance:

    cgrp_fd =3D open("/sys/fs/cgroup/cpu");
    cgrp_map_fd =3D bpf_obj_get("/sys/fs/bpf/cgroup_array");
    bpf_map_update_elem(cgrp_map_fd, &app_idx, &cgrp_fd, 0);

Next, we will validate the contents of the cgroup_array within our LSM
programs, as follows:

     if (!bpf_current_task_under_cgroup(&cgroup_array, app_idx))
            return -1;

Within our Kubernetes deployment system, we will inject this script
into the target pods only if specific annotations, such as
"bpf_audit," are present. Consequently, users do not need to manually
modify their code; this process will be handled automatically.

Within our Kubernetes environment, there is only a single instance of
these target pods on each host. Consequently, we can conveniently
utilize the array index as the application ID. However, in scenarios
where you have multiple instances running on a single host, you will
need to manage the mapping of instances to array indexes
independently. For cases with multiple instances, a cgroup_hash may be
a more suitable approach, although that is a separate discussion
altogether.

>
> If it's systemd hybrid setup, you can get the information from the
> unified hierarchy which represents the container membership.
>
> If it's a setup without the unified hierarchy, you have to pick one
> hieararchy as a representation of the membership. Which one will it be?

We utilize the CPU subsystem, and all of our pods have this cgroup
subsystem enabled.

>
> > Subsequently, we can use this information to create distinct ACLs withi=
n
> > our LSM BPF programs, enabling us to control specific operations perfor=
med
> > by these tasks.
>
> If one was serious about container-based ACLs, it'd be best to have a
> dedicated and maintained hierarchy for this (I mean a named v1
> hiearchy). But your implementation omits this, so this hints to me that
> this scenario may already be better covered with querying the unified
> hierarchy.
>
> > Considering the widespread use of cgroup1 in container environments,
> > coupled with the considerable time it will take to transition to cgroup=
2,
> > implementing this change will significantly enhance the utility of BPF
> > in container scenarios.
>
> If a change like this is not accepted, will it make the transition
> period shorter? (As written above, the unified hierarchy seems a better
> fit for your use case.)

If that change is not accepted by upstream, we will need to
independently manage and maintain it within our local kernel :(

--=20
Regards
Yafang

