Return-Path: <bpf+bounces-5609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CE375C70B
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DA728216C
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391DC168B4;
	Fri, 21 Jul 2023 12:45:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1929AB
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 12:45:16 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C8B1FD2;
	Fri, 21 Jul 2023 05:45:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so2570155a12.3;
        Fri, 21 Jul 2023 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689943513; x=1690548313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nc0AVA69BpamHsOI9Kdi8d5CRGWiKK10b/CD70sRVDE=;
        b=enlaeyNAA786yYcEyhxBZlYvXYSZh6Qp++INv5mS5Y8I523pM8Yh4A3G/BzGj1xGBf
         3BKCzJG30VkItZ7SpZfTu6AE+QKlcxUPfJXq5J7GQJ8qeAC34fCPdZEBUC0y3ko0iLmq
         l2m1DO54VtXLuAhxz5QFT49noPSXBSXSBslfY96OTtc/u3W0s9oZIkk0vRt29C1IK+gj
         I2QFwfxIU6Y0pdEvUA/fgLY8DLqXdiRDwzhPIApZ//qZHbSOP2Np9GSFdbJQcFYiSRVC
         1H7K/9426FNGlx9lte6nW2c+9zWZDyctAmAhL+LGiSF9iHVqbNz/qownJgJ/h8OurwMy
         rbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943513; x=1690548313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc0AVA69BpamHsOI9Kdi8d5CRGWiKK10b/CD70sRVDE=;
        b=VfLrOTjEt/JW4t+i9hYYNfR7kA5sdHijZxuhE15mJ5xUnSGx4z1lhJoZ1c9a9c7X30
         furrizKK9p9/YmMYei6xRrg4/7L1A7oqy+tbcXXo8j33vVXAY3i8wNM2Mau0u+TNUiCZ
         lZurh2RtzDNLQFenSsXEYSrSlpmOJAeNIWbHaAcGzxT5CUTlwRBbuXE9WHuc9VDNs/E6
         D3mpe6tmZjBGWSlzmrR9GzVtwKf/nIFlno/bWjpXRVdkLnvEgrRwL9BG+cVGYG+1Vf5B
         vzZdKn1/ChhQylx26yKNYFjBLjAXOfWe82aWmciDik2q2cZYamLbSoEtPxfpW8+Pt8vr
         BB7Q==
X-Gm-Message-State: ABy/qLbXdpz3c8/++sRVspKuvrhXOlUMbMd0CVkksJjCe2IIcaFCfu7g
	tLoqMa8GOc8aUr9uUyq8ouA=
X-Google-Smtp-Source: APBJJlHnZS9Cj/96OFnxY100gU6WfZW4hObnWX4sr3Ar5u9IuxLDr2avizCNTANiyjVIEIGjpcssHQ==
X-Received: by 2002:aa7:dc0f:0:b0:51e:2cdb:ed1f with SMTP id b15-20020aa7dc0f000000b0051e2cdbed1fmr1373985edu.9.1689943512934;
        Fri, 21 Jul 2023 05:45:12 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7c44c000000b0051bed21a635sm2079430edr.74.2023.07.21.05.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:45:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 21 Jul 2023 14:45:10 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf 2/2] bpf: Disable preemption in bpf_event_output
Message-ID: <ZLp91s9kuOp7kEEA@krava>
References: <20230720085704.190592-1-jolsa@kernel.org>
 <20230720085704.190592-3-jolsa@kernel.org>
 <0b963b18-4933-3b70-3dc6-6c7150bcf7bb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b963b18-4933-3b70-3dc6-6c7150bcf7bb@huaweicloud.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 08:16:14PM +0800, Hou Tao wrote:
> 
> 
> On 7/20/2023 4:57 PM, Jiri Olsa wrote:
> > We received report [1] of kernel crash, which is caused by
> > using nesting protection without disabled preemption.
> >
> > The bpf_event_output can be called by programs executed by
> > bpf_prog_run_array_cg function that disabled migration but
> > keeps preemption enabled.
> >
> > This can cause task to be preempted by another one inside the
> > nesting protection and lead eventually to two tasks using same
> > perf_sample_data buffer and cause crashes like:
> >
> >   BUG: kernel NULL pointer dereference, address: 0000000000000001
> >   #PF: supervisor instruction fetch in kernel mode
> >   #PF: error_code(0x0010) - not-present page
> >   ...
> >   ? perf_output_sample+0x12a/0x9a0
> >   ? finish_task_switch.isra.0+0x81/0x280
> >   ? perf_event_output+0x66/0xa0
> >   ? bpf_event_output+0x13a/0x190
> >   ? bpf_event_output_data+0x22/0x40
> >   ? bpf_prog_dfc84bbde731b257_cil_sock4_connect+0x40a/0xacb
> >   ? xa_load+0x87/0xe0
> >   ? __cgroup_bpf_run_filter_sock_addr+0xc1/0x1a0
> >   ? release_sock+0x3e/0x90
> >   ? sk_setsockopt+0x1a1/0x12f0
> >   ? udp_pre_connect+0x36/0x50
> >   ? inet_dgram_connect+0x93/0xa0
> >   ? __sys_connect+0xb4/0xe0
> >   ? udp_setsockopt+0x27/0x40
> >   ? __pfx_udp_push_pending_frames+0x10/0x10
> >   ? __sys_setsockopt+0xdf/0x1a0
> >   ? __x64_sys_connect+0xf/0x20
> >   ? do_syscall_64+0x3a/0x90
> >   ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >
> > Fixing this by disabling preemption in bpf_event_output.
> >
> > [1] https://github.com/cilium/cilium/issues/26756
> > Cc: stable@vger.kernel.org
> > Reported-by:  Oleg "livelace" Popov <o.popov@livelace.ru>
> > Fixes: 2a916f2f546c bpf: Use migrate_disable/enable in array macros and cgroup/lirc code.
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Hou Tao <houtao1@huawei.com>
> 
> With one nit above. The format of the Fixes tags should be 2a916f2f546c
> ("bpf: Use migrate_disable/enable in array macros and cgroup/lirc code.")
> 

right, sorry about that.. should I resend?

thanks,
jirka

