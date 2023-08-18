Return-Path: <bpf+bounces-8034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A48780370
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 03:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6FE1C215B4
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 01:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80128654;
	Fri, 18 Aug 2023 01:39:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFA398
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 01:39:41 +0000 (UTC)
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E891710C0;
	Thu, 17 Aug 2023 18:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1692322778;
	bh=HwlS99rKftcCjJkXQ9IOansZ25GQOznIAvv1J4y70hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kkaNflEGt8NtwbZU4Vw0fEJl0vhpLYkRj2wJpGo8p4kK7qQ8/tLrI/Wb/asq8EAGa
	 X2i/q2/Wylf0B92x0ZolGjTmzI4dZyeKthktnxPiXz8mNv8UcWYrKBRUzY29rNQJWU
	 kc6JA9Bj5+FGDkM2PbNgIXbaSMRfuX0r1hPJjC8Y=
Received: from localhost.localdomain ([39.156.73.12])
	by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
	id 9E127C29; Fri, 18 Aug 2023 09:39:33 +0800
X-QQ-mid: xmsmtpt1692322773tmej5lrvm
Message-ID: <tencent_03EBFD524265EA7560341E91C5E04F083405@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeienvsCx/U4Ubq51UCVl4H8yRQHU4+1XdXbpolMYva+4SdxIGrXVm
	 pNWR6MtgfmXzLxfX0bunLxwotPEUoYe+ISXLRYkzkzfOvdJBclhaEid8gi8lq5C9e/pjV28yBASx
	 EO1T/3Q9WAMy0/ejsBJYW5K0MBcjtmDBiGE1NncJBlgk42PaD+TTPjv0n1m/QQilTOBOK7onok4l
	 mP/QeSmwPzY77nocbyrC42ypP05GwLhxxfctR+dSZhrtnlAkR/ncEAqU88lCuOc69Sxyc4CdgwL7
	 FGqrPUgmGVzkKlOBeebrfA1fl8gK1g4Ou6URChxGrXy8IMJQg4CvH2e8kyJn/2Y7dAtPPxZ2sNcq
	 ZrsMWbF9vSFoLRt7x/cWJOX4idoIkk+TmKqKrz3m/la3jn+RqenwoNOEs3TbmaHZAcGObCM3ZRST
	 IXbXJVtfy3cJzkKZC0X1/IzoZ3tzcHajAatZYkClOnZ2zicKRpaidYXGKTn9m/zUNQ4AZtkE9Vz5
	 jf0IYgDBrDi/2090Qh+IMfUEbcuiiVTeae4dnnkIgIDFAS1BrmWffeBJXZ39nNep/f5IZWmEhRc9
	 keChmtxmpcIgN06rx6M/e4WP5XzSnnzO/CFwzAZRs+ppko1AJaf/jalhwh18U4QbYq2zC3/4xonI
	 aawpNWthuxt/8JQMIL0r1PrA2ZbYS/QZimt4QFYDcjOjF5pOBe1PBFul/lozO9D8p6xuJ2N9fnO1
	 V5agwxDtETjQQ4SAf0MAmDB337kXMYTxIlR2XWctGr2TE/J7zZnmk+JyNyeMBTRpohPuqD/0m7k0
	 0v/1FrkUz3CF34od41N07x1/BJtnVpmJ9X0+EjuifaCdIzvwJrhvyMNNOdrgGYSvwfGMw9iF4Rrg
	 yt5RDU2hD8ENi2UJD0RRqva2s0xvXmitFEFkmi3L880KgO+8HAxTvaN3FB5C3XJOP40KTutBGSJn
	 VPfxAc0JOVMuxvunJT5y4KOdfG9I+IhmeGmO1YD93wtlze7P84St0qM40zEy4Z
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
Date: Fri, 18 Aug 2023 09:39:32 +0800
X-OQ-MSGID: <20230818013932.22139-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZN3YeyMkgEg1IoKP@krava>
References: <ZN3YeyMkgEg1IoKP@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, Jiri. Thanks for your reply.

libbpf_ensure_mem() is in libbpf_internal.h, samples/bpf/ can't see it, do we
reposition the function declaration?

Good Day
Rong Tao


