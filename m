Return-Path: <bpf+bounces-16889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A5C807362
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 16:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19804281F95
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308D3FB21;
	Wed,  6 Dec 2023 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XY4q6oJM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0001D1BD
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 07:08:34 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d7a47d06eeso47457547b3.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 07:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701875314; x=1702480114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI4+87OmuedWYZowFLyZTVA/u3jp6SGb1EP0gsJn5OY=;
        b=XY4q6oJMulDtDfGvgZX7Rx6nvetjT5BNrNAyuSIRJzqMWmYPeZhQiesXEexmbeTorT
         4AL8+taBVtrOB/PdklOUKZJCg1b5rx6oQUhOX/7igdRP8THpbot+DZsxvj1+v2zoFN38
         QnsU7Ub9CSFs2Lg5osOhd7CyW9an0nHGJ0buZdQpCFzLQS1z5q/EXJ78xAYVkYEfk4ML
         EtwRfuhzCg4W2qRtxvU6UCZrm6DWzXlIaOvWKOleFLjuCW7M6b+dlQt/mx/lfzMhFqvy
         RBYMs6mM9LnPCWxxIJJQxp37M7qNx9inq/l/fupwsj6uTi1HvR5x7lSXsbbC1ZcVOJe0
         QuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875314; x=1702480114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI4+87OmuedWYZowFLyZTVA/u3jp6SGb1EP0gsJn5OY=;
        b=FUmY0S9OO6cpNNAdiFQv6w5xqjlqX5c5VOy/5LRx14SqrIfAUAFmutKejdIG24HfWY
         cg6qPTuX6dV/Nd9m6/gcMwwIT30Ma5rVDs2oLm7muHjgOJ2D7Hxd/YYdD0G+/pLw9OYI
         uMeIy39Qg2RttuXtMNvdgcqG35P9VauFEhTuhQcC2hBwxGyBjvSMavirjWcQWnYvxBd3
         GnKr5X2x9XAZGvPRLF/VxPU+usB5UkZXwDhCiDQgyt9FiFrWs9+ZZ5Yfu08x/XakTNX9
         XkcGgmuS1XpzDClqB1SRcW+8ww8C9DG261v85e1A4JefJphWVTJ0+bVj14KjcbaXACqJ
         fUag==
X-Gm-Message-State: AOJu0YySgBo7M1O1TMx2nOxqbkphiTz0STQI6WKxD68KiGlo6265XdjU
	U4rqSIk4mPNoI0SAI9Ge4Ue03idL/ZD0NPYqUu6uDg==
X-Google-Smtp-Source: AGHT+IHF9CzT8VrghpajIXOI4MLzZ24JXy9q27f+k6JJ8gWMSKwgFRPeOQuAl95Vk0Cb7Kg8XGZRY9Z+ZKYjtmmKU1M=
X-Received: by 2002:a0d:e60b:0:b0:5d7:1940:f3e9 with SMTP id
 p11-20020a0de60b000000b005d71940f3e9mr760885ywe.81.1701875313870; Wed, 06 Dec
 2023 07:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201182904.532825-14-jhs@mojatatu.com> <9dc10258-a370-4c8f-8099-36edf40b6f80@suswa.mountain>
In-Reply-To: <9dc10258-a370-4c8f-8099-36edf40b6f80@suswa.mountain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 6 Dec 2023 10:08:22 -0500
Message-ID: <CAM0EoMnnXNxtzDqtC96rbKjy1qfebtBTPpGj7MR7j4uzqXjEWA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 13/15] p4tc: add runtime table entry create,
 update, get, delete, flush and dump
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, netdev@vger.kernel.org, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, deb.chatterjee@intel.com, 
	anjali.singhai@intel.com, namrata.limaye@intel.com, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, Dec 6, 2023 at 12:34=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hi Jamal,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jamal-Hadi-Salim/n=
et-sched-act_api-increase-action-kind-string-length/20231202-032940
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20231201182904.532825-14-jhs%40m=
ojatatu.com
> patch subject: [PATCH net-next v9 13/15] p4tc: add runtime table entry cr=
eate, update, get, delete, flush and dump
> config: powerpc64-randconfig-r081-20231204 (https://download.01.org/0day-=
ci/archive/20231205/202312052121.NV57fCuG-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231205/202312052121=
.NV57fCuG-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202312052121.NV57fCuG-lkp@intel.com/

Thanks - Will do (it will be a new version not separate fix commit).

> smatch warnings:
> net/sched/p4tc/p4tc_tbl_entry.c:2555 p4tc_tbl_entry_dumpit() warn: can 'n=
l_path_attrs.pname' even be NULL?

We need to update our smatch i suppose because we didnt catch this one.

cheers,
jamal

> vim +2555 net/sched/p4tc/p4tc_tbl_entry.c
>
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2529        pnatt =3D nla_res=
erve(skb, P4TC_ROOT_PNAME, P4TC_PIPELINE_NAMSIZ);
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2530        if (!pnatt)
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2531                return -E=
NOMEM;
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2532
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2533        ids[P4TC_PID_IDX]=
 =3D t_new->pipeid;
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2534        arg_ids =3D nla_d=
ata(tb[P4TC_PATH]);
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2535        memcpy(&ids[P4TC_=
TBLID_IDX], arg_ids, nla_len(tb[P4TC_PATH]));
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2536        nl_path_attrs.ids=
 =3D ids;
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2537
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2538        nl_path_attrs.pna=
me =3D nla_data(pnatt);
>
> nla_data() can't be NULL
>
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2539        if (!p_name) {
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2540                /* Filled=
 up by the operation or forced failure */
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2541                memset(nl=
_path_attrs.pname, 0, P4TC_PIPELINE_NAMSIZ);
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2542                nl_path_a=
ttrs.pname_passed =3D false;
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2543        } else {
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2544                strscpy(n=
l_path_attrs.pname, p_name, P4TC_PIPELINE_NAMSIZ);
>
> And we dereference it
>
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2545                nl_path_a=
ttrs.pname_passed =3D true;
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2546        }
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2547
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2548        root =3D nla_nest=
_start(skb, P4TC_ROOT);
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2549        ret =3D p4tc_tabl=
e_entry_dump(net, skb, tb[P4TC_PARAMS], &nl_path_attrs,
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2550                         =
           cb, extack);
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2551        if (ret <=3D 0)
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2552                goto out;
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2553        nla_nest_end(skb,=
 root);
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2554
> 0d5bbed1381e54 Jamal Hadi Salim 2023-12-01 @2555        if (nl_path_attrs=
.pname) {
>                                                             ^^^^^^^^^^^^^=
^^^^^^
> This NULL check can be removed.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

