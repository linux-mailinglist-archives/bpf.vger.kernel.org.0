Return-Path: <bpf+bounces-8082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C7780F68
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F160F28243C
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D3198A0;
	Fri, 18 Aug 2023 15:40:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EEEACB
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:40:43 +0000 (UTC)
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701BA3C1F;
	Fri, 18 Aug 2023 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1692373235;
	bh=bvV/soH/dURAAoXFyESTSqw98tSL2GFyxRs8zFGxUJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BonxfaUfz1xUq5urQHPeWjuYAm9THSvWyMF5IFy/8wu2xW/9y5WhF5YASP74HmFRb
	 ZHB+OG1PdmJwMUMiFyJ8kWca+j3THzc6dMOQIb1mcdJ0yOvz5e3vRzxv61Al8ceukh
	 c/z+XnYpxLOJhDR1VbucP8aKsr4Sq9PXUD5SytEY=
Received: from rtoax.. ([124.126.138.8])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 90FACE53; Fri, 18 Aug 2023 23:36:15 +0800
X-QQ-mid: xmsmtpt1692372975tun35vlo9
Message-ID: <tencent_6F0CBE858CB29E2E63544C5FF7461710E909@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No3saEAZZsHGvRz8jNYaOJFWRAqomTdpjFsYYM/FhW1//BsolyPr
	 kgMCXoM7zOoqq3pTlN2Z5iOpBFeZv+BkhHDNY/aQz8SdNiaM3GyO/38lx5zCCjYTCNDE+iJOb+Ht
	 JBXScXJveNAq4YbMfPK+lTC2SpB1XAcnqqCDLIkxewjwXdrW0XP2QVhft3fyPnP+NktSyf3b2CN4
	 RohO8GGFopAus8lsmeKiRuyQmG+kdxZYshXCMhFxWTK95PtFsoImGbsgGRf43Sk6WfpXKLWbrXO3
	 nbhsQbHvzBvSWla7iY5SdpEGNsAADZo/WXG02oSlYaJPSYNJk96s3WVBHZNKxa0wWauK+rFi/ibD
	 uePZjTWL22WCodBBcsAn883sGkAXIz3fyczacgQPcQ6hdN9w9Wny65bKvUI83qqZz5Rj2RU6ANhk
	 9760mfwwZan4ouLrtLjlX2oeJKrdmydBqw5YjSIJzUrVkM8PR/JmXVmbZef+I2+zRTQU4Ne67Pru
	 AYDxPDpcGF1zt2G9T77XIUaCB50a4UwTGBB9KNL+RbHGrUPtWfZ2MIaEbLZQLhz1FcoC/xDLyvWJ
	 1atmEi8PGFcfJKxaaS7K8smI3eshSv8KYTrvxJo5YPT0H3zNB/3wtv4iMjHEyG80bRLC1FaI1Kor
	 REsmOmxrKBNBiKTGn427yE1k+8752Z+1QFOwP5/4+mqk17EDL6uLJj36dMWTPw9NsoLGSHN+JJqD
	 BzNFhajZWyA0HEKpAe/z6kKmEOMUm2ynYtwHDO/GoGuVswd+xMI0yEJ3bsxArH8cTSAUfsv8dZti
	 woCleRIArFYWUUSNvOAXF6K0fmgLGEqEVWoVVnzaCInyRJ54lhVeQdoZTziHymRv2ufmmbYzSUAi
	 UxZGhSPecGIzCT5IWpl/hkJk9YYnB50cmOlVMxJcrVR4XVEDvExs5dLwfWkVf+EL5Lr9HCrPrEEn
	 qPo9QPO+l632JqqFTO1InRhzZxdganQ1O8HRvEagKV3eqjDv3Lj8Mn7zzqEI7Sz7Mo15nc6/UupK
	 I3Z9xZ9A==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Rong Tao <rtoax@foxmail.com>
To: olsajiri@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	rongtao@cestc.cn,
	rtoax@foxmail.com,
	sdf@google.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v5] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date: Fri, 18 Aug 2023 23:36:13 +0800
X-OQ-MSGID: <20230818153615.46450-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZN9iDSj3/vdk5pRX@krava>
References: <ZN9iDSj3/vdk5pRX@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, jirka

Sadly, we can't include libbpf_internal.h in trace_helpers.{h,c}.
we only have the following headers when compile samples/bpf/:

tree of samples/bpf/libbpf/
    +-- bpf_helper_defs.h
    +-- include
    |   '-- bpf
    |       +-- bpf_core_read.h
    |       +-- bpf_endian.h
    |       +-- bpf.h
    |       +-- bpf_helper_defs.h
    |       +-- bpf_helpers.h
    |       +-- bpf_tracing.h
    |       +-- btf.h
    |       +-- libbpf_common.h
    |       +-- libbpf.h
    |       +-- libbpf_legacy.h
    |       +-- libbpf_version.h
    |       +-- skel_internal.h
    |       '-- usdt.bpf.h
    +-- libbpf.a

No libbpf_internal.h here.

What if we add a declaration to libbpf_ensure_mem() in trace_helpers.c?

Good Day,
Rong Tao


