Return-Path: <bpf+bounces-9036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBBE78E8DC
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F9C1C209FB
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A33846E;
	Thu, 31 Aug 2023 08:54:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A66746B
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 08:54:39 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823DCE9
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 01:54:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bed101b70so56670966b.3
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693472077; x=1694076877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/Au/49sfFbqDAeWmUwfMG5Mgj/xSzZD87OOb4rDMB4=;
        b=p1d5vfpOt9PYu4DGarP4Dlwf3WxLLM4tQ2uLPfi914dy45fRk+jiZFuIRPfccWqoMC
         yx6fjkBOdFqftGCRtX9o2qITMwbIizPForwrod3iRTlIbin7p4wR8C3JvByuK+Tb8r0K
         oOn51/mMH59ZqQaTRoQcTwJQJD6OgexMAOKD6/MdSal6yzGmR724yQiBCWVpSWKksOUQ
         KgAI93whuzWF5Imq9EUNM5SPwYjuvTG0hp/Uk15f8f24dAeLCRWJavrZXZtnZZ+y7RtL
         P3QDa89Vh59uIvgjfzFhLR2OcIDDh2q01y6XZnIZG1kHwKG2uSB6I58QJUOZ/ViA0Gp1
         L6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693472077; x=1694076877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/Au/49sfFbqDAeWmUwfMG5Mgj/xSzZD87OOb4rDMB4=;
        b=FtJWJoSX/OMfDwfnP3PG+pnzl29IjO7MhrVZzQS0HbXFAS42eCQYRILlHROTbh/mrl
         HRksqIkh2mzeKvxy4auV+RKi3zF4stK7lmNk7g+gP/VhhbZ1AVVAjb2PEpB7gng5oMgG
         TUpeHU0cwFd/E2/R+CmZFVPL5Zsp4aGKhpP6avi3Yd58B7dqs8Lexg4xtUzBonMA7/fS
         QeT+pluSGRM/kjPDTXh2ZX4cnZMVykde832z2U+YZNBiCPoneId5fTJsrX3O7DohEaaf
         GGJDR3UAY/b6XgGDPR6vTJ8OfHwNdKHwq1Sd9gjx0PIUmE03qHNAmg/wCpT2phW1xeMJ
         VIZA==
X-Gm-Message-State: AOJu0Yz7QpvxB0Eyr6I94QXkLayuf4M37h69VdluLunRoWL4pP7ge+sL
	3wCv4Sbx3BkedmOdIMwf9XU=
X-Google-Smtp-Source: AGHT+IFIz2cZKCJCGvoGOGS3y6pYTzJMrjxvS4x5mWMB9mwyJZEQ2XYZnfZPHJxHrCsAt5yfXlRHVw==
X-Received: by 2002:a17:907:7757:b0:9a1:b43b:73a0 with SMTP id kx23-20020a170907775700b009a1b43b73a0mr3479800ejc.20.1693472076690;
        Thu, 31 Aug 2023 01:54:36 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id m26-20020a170906259a00b0099ca4f61a8bsm525091ejb.92.2023.08.31.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:54:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 31 Aug 2023 10:54:34 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
Message-ID: <ZPBVSjDQndPpI3ie@krava>
References: <20230830093502.1436694-1-jolsa@kernel.org>
 <89bb059e-f371-8354-5770-f022396e0b38@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89bb059e-f371-8354-5770-f022396e0b38@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 03:37:37PM +0800, Hou Tao wrote:
> Hi
> 
> On 8/30/2023 5:35 PM, Jiri Olsa wrote:
> > Recent commit [1] broken d_path test, because now filp_close is not
> > called directly from sys_close, but eventually later when the file
> > is finally released.
> 
> To make test_d_path self-test pass, beside attaching to a different
> function (e.g., __fput_sync or filp_flush), we could also use
> close_range() or even dup2() to close the created fd, because these
> syscalls still use filp_close() to close the opened file.

nice, I like the close_range solution ;-) patch below fixes the test

> 
> >
> > I can't see any other solution than to hook filp_flush function and
> > that also means we need to add it to btf_allowlist_d_path list, so
> > it can use the d_path helper.
> >
> > But it's probably not very stable because filp_flush is static so it
> > could be potentially inlined.
> >
> > Also if we'd keep the current filp_close hook and find a way how to 'wait'
> > for it to be called so user space can go with checks, then it looks
> > like d_path might not work properly when the task is no longer around.
> 
> It seems there is no need to wait for it to be called, because
> filp_close() is still called synchronously by some syscall (e.g.,
> close_range or io_uring). So if the bpf program tries to collect many
> close event as possible, it should be attach to both filp_close() and
> __fput_sync(), right ?
> 

right, when we hook to close_range it's still synchronous

thanks,
jirka


---
diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index 911345c526e6..8a558c980753 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -91,6 +91,7 @@ static int trigger_fstat_events(pid_t pid)
 
 out_close:
 	/* triggers filp_close */
+#define close(fd) close_range(fd, fd, 0)
 	close(pipefd[0]);
 	close(pipefd[1]);
 	close(sockfd);
@@ -98,6 +99,7 @@ static int trigger_fstat_events(pid_t pid)
 	close(devfd);
 	close(localfd);
 	close(indicatorfd);
+#undef close
 	return ret;
 }
 

