Return-Path: <bpf+bounces-13925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BC7DEE59
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 09:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AE8B2124E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 08:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8879C2;
	Thu,  2 Nov 2023 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5ERlu/7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D47499
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 08:50:14 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C312C;
	Thu,  2 Nov 2023 01:50:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32fb190bf9bso24300f8f.1;
        Thu, 02 Nov 2023 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698915011; x=1699519811; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKF4AuwBxKpYd7Ly1Ezs8kH7+emBGdvuLRRIRObR8w8=;
        b=H5ERlu/7esuI5hQQKpHOA19rBWOGrGAE4WOCvBGfv25DHh4Xwn7v1UxYcCTKXdnLGf
         GA25emovQ5biDy9XgcQLrw31GdHX+Ax6sU4Q6h9AO9TG8YAmRWbNf4HerOG7+UDiFQsx
         vxye8qm08W8KDCDMij/O397IBql1VDFk7nVht9NfFvFZJo52V9Ssqs45RUuunKNzRriA
         cL+q/AwnQyiIa9vGG9vfSU/1A+/telF/b3tXgTXNb3C3ZvItZYMB30VurY7ilTNm8Y3U
         MIs2oJQyHFsaHmVaiXMF3yekFQ9xVzGFQgp4IwX5Wdd/Tz2cOG8xG5VNme/3jWSk0ZkR
         wDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915011; x=1699519811;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKF4AuwBxKpYd7Ly1Ezs8kH7+emBGdvuLRRIRObR8w8=;
        b=eYVcexT0ZApVDZH1Fnl52m09+pbIdWpMEdfxWt7HKIhRTl7lnB5lISh3iaMMYPECbs
         xhYH2IRjo9YEUCxuZqY037TCNXefauo8C7WnZf3QnM2rPnFB4J/24i5PdA0JJL5qsP6S
         VIwHDdcNgf/lV0wKyM1DbMQW+BD9FTy5lBbl3tq0cFAkJMsk49dGYDVsfM78oK7fopLl
         A3jxU3afSEocyYEAtYHCcU5m4rqxAyeitVrJfC1tf8HrLOknvLlBT/VmSWE9jetRHHMf
         oeDiQtQOu9l3dW2BXAKYWA1v1L0z9C3YQEnAib4Tah7SOsKJjLpNdbfdHPD0wpEsBDdw
         78HA==
X-Gm-Message-State: AOJu0YxggIGo+cbYay2UpeUfBhPoSWVl1yKIVSMvRgGnzfwZvoqVu+vW
	bzQPRFBctcyEqTPNPbPnJDQ=
X-Google-Smtp-Source: AGHT+IFpPQcz2g4e80rRiQAB/q8Kh3kmpvmcK2UWFhQwt3wEtaM8jzxqzZ92RFRUnkmGnE3MC2eaiQ==
X-Received: by 2002:a05:6000:1565:b0:32d:8c67:be05 with SMTP id 5-20020a056000156500b0032d8c67be05mr9214808wrz.22.1698915011124;
        Thu, 02 Nov 2023 01:50:11 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4849000000b0032d8eecf901sm1844107wrs.3.2023.11.02.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 01:50:10 -0700 (PDT)
Date: Thu, 2 Nov 2023 08:50:08 +0000
From: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	regressions@lists.linux.dev,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: mainline build failure due to 9c66dc94b62a ("bpf: Introduce css_task
 open-coded iterator kfuncs")
Message-ID: <ZUNiwMLBsL52X9wa@debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All,

The latest mainline kernel branch fails to build mips decstation_64_defconfig,
decstation_defconfig and decstation_r4k_defconfig with the error:

kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
  917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
      |              ^~~~~~~~~~~~~~~~~~~
kernel/bpf/task_iter.c:917:14: note: each undeclared identifier is reported only once for each function it appears in
kernel/bpf/task_iter.c:917:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
  917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
      |                                    ^~~~~~~~~~~~~~~~~~~~~~
kernel/bpf/task_iter.c:925:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
  925 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
      |                                                            ^~~~~~
kernel/bpf/task_iter.c:928:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
  928 |         css_task_iter_start(css, flags, kit->css_it);
      |         ^~~~~~~~~~~~~~~~~~~
      |         task_seq_start
kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
kernel/bpf/task_iter.c:938:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
  938 |         return css_task_iter_next(kit->css_it);
      |                ^~~~~~~~~~~~~~~~~~
      |                class_dev_iter_next
kernel/bpf/task_iter.c:938:16: warning: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Wint-conversion]
  938 |         return css_task_iter_next(kit->css_it);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
kernel/bpf/task_iter.c:947:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
  947 |         css_task_iter_end(kit->css_it);
      |         ^~~~~~~~~~~~~~~~~

git bisect pointed to 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs")

I will be happy to test any patch or provide any extra log if needed.

#regzbot introduced: 9c66dc94b62aef23300f05f63404afb8990920b4

-- 
Regards
Sudip

