Return-Path: <bpf+bounces-16788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6717F805F94
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC63B21134
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 20:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36686A009;
	Tue,  5 Dec 2023 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EVhFXuQf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C876181
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 12:39:01 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7b37405f64aso234857439f.2
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 12:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701808740; x=1702413540; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A88fqGcX394h7YszYpVb7M+n3XIozf+iiWyPOataKGI=;
        b=EVhFXuQfk51P0stuckFLKbCmFKz3qy8uWq0cWC3W/PUxCgDPEJYLiKplEP6y2YKust
         0dk2Y/i8WE0sa1+etHkFsqjAz0v6ypLoAjPpRipk3LEXx694M7BFvyLoPt6cLjb53caj
         nxHDtAHEvUaqCg6l34cLSPM6XtaJHNFpCnIImTzRTI3/wuC11TCUIhzD30rZVaRVISss
         +A7QLE7BX/pmQskxKDnWDIzrMHoN/zjL0+hMFDKgQSVaUQm5hmStuBtQp/k2fO2RK084
         JfqH2uidlnFPGOKl+7ET77M7oZ2VBRTKRNBApWGTfSH+ZjZKCDg82v11EUUDL1V165Jx
         NovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701808740; x=1702413540;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A88fqGcX394h7YszYpVb7M+n3XIozf+iiWyPOataKGI=;
        b=CO2rNzES+96b/vhYv554weVC7gqvPx4j0Aws+5Ip6S4z715O7Brebzo2FxpzTF5iXE
         HTvUQxUDRmsz2LWaI/91tjlqHhM+PkLRvZYE/mLO39KCyKadilTxbP/hMWzqTVwXvmpO
         FaQDymSBMPg20K+tgG/zMAWjqh1kjtuetW1fU0kK1sblTqdi5CCVqTpcqpzw6h5Ii0V6
         VVug0yYJkHco6NdIASQzEH+wuQ/ePtvSQxR8XVCPJZwVXVHzcLhXnLW4tzOHtcPWmSgA
         Q97Bnp89Ev6I5riNw1aliXQqsIpc5rIrXQzWGkFpN5L1qHgxNpFmBYNh7jLIGsja1G6f
         4gOA==
X-Gm-Message-State: AOJu0Yzl3VTun+/zEI/G3SfnHNgIRCLRXdoEo1X/EBQpk+mosgbju45k
	AY9sonKKLbu5X7QQPeSVF8z3+A==
X-Google-Smtp-Source: AGHT+IF9ggWhHxIX1Tx69AoCSkaaEv6I3eKEijYk6umVcDcZk5DvtB+84n4lSYjwKmWQ7NAmtaHkyA==
X-Received: by 2002:a05:6602:36cf:b0:783:62d0:88c with SMTP id bg15-20020a05660236cf00b0078362d0088cmr10891254iob.19.1701808740405;
        Tue, 05 Dec 2023 12:39:00 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:9478:4e6::7d:56])
        by smtp.gmail.com with ESMTPSA id gn16-20020a056602641000b007b37a09d407sm3449818iob.14.2023.12.05.12.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 12:38:59 -0800 (PST)
Date: Tue, 5 Dec 2023 14:38:57 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: BPF LSM prevent program unload
Message-ID: <ZW+KYViDT3HWtKI1@CMGLRV3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

IIUC, LSMs are supposed to give us the ability to design policy around
unprivileged users and in addition to privileged users. As we expand
our usage of BPF LSM's, there are cases where we want to restrict
privileged users from unloading our progs. For instance, any privileged
user that wants to remove restrictions we've placed on privileged users.

We currently have a loader application doesn't leverage BPF skeletons. We
instead load BPF object files, and then pin the progs to a mount point that
is a bpf filesystem. On next run, if we have new policies, load in new
policies, and finally unload the old.

Here are some conditions a privileged user may unload programs:
	
	umount /sys/fs/bpf
	rm -rf /sys/fs/bpf/lsm
	rm /sys/fs/bpf/lsm/some_prog
	unlink /sys/fs/bpf/lsm/some_prog

This works because once we remove the last reference, the programs and
pinned maps are cleaned up.

Moving individual pins or moving the mount entirely with mount --move
do not perform any clean up operations. Lastly, bpftool doesn't currently
have the ability to unload LSM's AFAIK.

The few ideas I have floating around are:

1. Leverage some LSM hooks (BPF or otherwise) to restrict on the functions
   security_sb_umount(), security_path_unlink(), security_inode_unlink().

   Both security_path_unlink() and security_inode_unlink() handle the
   unlink/remove case, but not the umount case.

3. Leverage SELinux/Apparmor to possibly handle these cases.

4. Introduce a security_bpf_prog_unload() to target hopefully the
   umount and unlink cases at the same time.

5. Possible moonshot idea: introduce a interface to pin _specifically_
   BPF LSM's to the kernel, and avoid the bpf sysfs problems all
   together.

We're making the assumption this problem has been thought about before,
and are wondering if there's anything obvious we're missing here.

Fred

