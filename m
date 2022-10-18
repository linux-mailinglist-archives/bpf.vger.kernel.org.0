Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3580B603176
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJRRSP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 13:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiJRRSJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 13:18:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61364D8EC9
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 10:18:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y14so33894963ejd.9
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 10:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IW9Hpwahimvo85yAyW9OokA39ZFTeRmCuBwRPiu0kmM=;
        b=fjjvpB/NmcjHs7fCcX6Z3ywb9U0QguC77Yvy2GyeB03QsL3jbbaGUd4ok2+je6pwOX
         8c9XQRepPh9KNZBnSVC3hxGKzgfvTrZMl+nh7LdlMDZmwmA/YmCkRWiOBCph0VX4N2vR
         YzSl68T0hhHG2uPbLd5PFEvpmdT+tUZS3BN3RqsX381gPWbHW1WgDXrU2Cz1KX8jOpW1
         xM5owHIf5RqESG2bYDcglmpRx80n/cgnLFT0KAUPKhHkueZ2Q8YRX0uheUVfWH6Cca19
         B4LjEL//Ku8jsaPOLPNRRrTl7L9ezh/5zdObmnwlIjibgQR9cpgLbZqp2c6fTnLxzDnj
         cqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IW9Hpwahimvo85yAyW9OokA39ZFTeRmCuBwRPiu0kmM=;
        b=S8Nf56wxjU7xeIDgDRxbritMQ8vogZVtgxqmC0m21jxssCfmSHL/kLW6XkJcLG3Vjd
         lMBHlq4dUBdY31Z9KWOsCiJmEj2N1ArXGbMsF2xl7TZIzEWGDyTemQmns+ULRXe7aHxI
         Nh31DSzrwAlxeeRMugORkeFYJNdgwK+mWl1Hly/ZF1ovUZzpvyfNFQiuiu8HOjtgoyxd
         eDJKzqytkKQr7yB+gOeZXcmhfv72k71EvZvZnIcfEE7oKvIl8Ab80nOIEsdAwIArQJEB
         Na3JnLn3Kzf7EHacI1g4kIkSxJLpOi6Ktnrwcn4mGoWMipRRqpOEVmEwfLndxSzTv3rB
         civg==
X-Gm-Message-State: ACrzQf1ZO9tSFSCAaZD1Sok14xyzOuTkQIe/rlkWAz/U1T/vhL4LkRyt
        4Hsui13AduERmJuEk4W8tQsRCndJARYAFH8EnKs=
X-Google-Smtp-Source: AMsMyM4qo7XprEj20ThPHHrZX9OKTv7QGrWHcey934qoFngfIkSQnS8ZQFB36Umq8mBixjXAmTLC38X8P92CQKMTwwE=
X-Received: by 2002:a17:907:6e93:b0:78d:dff1:71e3 with SMTP id
 sh19-20020a1709076e9300b0078ddff171e3mr3171390ejc.94.1666113484867; Tue, 18
 Oct 2022 10:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <Y02Yk8gUgVDuZR4Q@google.com> <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
 <CAKH8qBtdNv0OmL0oH+U2w0ygLmGUug37xNhHWpjc5=0tn1cThQ@mail.gmail.com>
 <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com>
 <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev> <Y03USAeiBL5Ol22E@google.com>
 <06e37b29-b384-7432-d966-ad89901de55d@linux.dev> <fdc0484e-c2da-a118-b845-f937f0ef5688@meta.com>
 <Y07dlsqt9u3BYF2U@google.com>
In-Reply-To: <Y07dlsqt9u3BYF2U@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Oct 2022 10:17:53 -0700
Message-ID: <CAADnVQKPMaU5av0soDh+ddnqpLbjDHEVyFpK9hX4g+99cBiJdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Yonghong Song <yhs@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 10:08 AM <sdf@google.com> wrote:
> > >
> > > '#define BPF_MAP_TYPE_CGROUP_STORAGE BPF_MAP_TYPE_CGRP_LOCAL_STORAGE /*
> > > depreciated by BPF_MAP_TYPE_CGRP_STORAGE */' in the uapi.
> > >
> > > The new cgroup storage uses a shorter name "cgrp", like
> > > BPF_MAP_TYPE_CGRP_STORAGE and bpf_cgrp_storage_get()?
>
> > This might work and the naming convention will be similar to
> > existing sk/inode/task storage.
>
> +1, CGRP_STORAGE sounds good!

+1 from me as well.

Something like this ?
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 17f61338f8f8..13dcb2418847 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -922,7 +922,8 @@ enum bpf_map_type {
        BPF_MAP_TYPE_CPUMAP,
        BPF_MAP_TYPE_XSKMAP,
        BPF_MAP_TYPE_SOCKHASH,
-       BPF_MAP_TYPE_CGROUP_STORAGE,
+       BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
+       BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
        BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
        BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
        BPF_MAP_TYPE_QUEUE,
@@ -935,6 +936,7 @@ enum bpf_map_type {
        BPF_MAP_TYPE_TASK_STORAGE,
        BPF_MAP_TYPE_BLOOM_FILTER,
        BPF_MAP_TYPE_USER_RINGBUF,
+       BPF_MAP_TYPE_CGRP_STORAGE,
 };

What are we going to do with BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE ?
Probably should come up with a replacement as well?
