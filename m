Return-Path: <bpf+bounces-26195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51FA89C84E
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234C61C22CEF
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9562F1411C5;
	Mon,  8 Apr 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUDO1WnK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156A140E50;
	Mon,  8 Apr 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590239; cv=none; b=Mc0cxJtfTe35CCEsCHWDJQzDEn4/xidc73FeEhokJM17xRvk2qyf87+ROvZAubARfpws1JDt7xMeVgD5X21x90w9yQK8fRQny/AI/ARUAq7gqUeXi/nzA6D/m8mCxl3TuiFI812Th2Nw98Si/jORWn2e9g/yL5n78SPFePH1N08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590239; c=relaxed/simple;
	bh=EHvc303WukukeZcSPxdzYnV8f0yJtowH++DgOEuksfE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uNHDa6OAnmFDMgr+N+6VNzUM9z7Fh2+8jrMTlQz5ubZlsFzVv2z+qa0rbO94dDQdvPk93hHVOZVOqoOCXi027Y5Ldf+IH9ypnL2d38e0p+0AlwvSM/OBjWFHuV6uQ0JdKnWunxS5tYxTM3bTjm5g/S282iBh910moDEQ42+MlFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUDO1WnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A439C433C7;
	Mon,  8 Apr 2024 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712590238;
	bh=EHvc303WukukeZcSPxdzYnV8f0yJtowH++DgOEuksfE=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=UUDO1WnK2IQY7VEnuosdox41Fe7Q8ogjo7uWVgzN5+fD+o/UXETS69CBow0Q5mCfm
	 XOpVTyPWvEO56DMnnpQW0Mo+IXfXzWEa1mSxXgTWUb384XpjkCaVQUJ3fmTHjoyJ4D
	 Qa4NVA7pd0zTMP762rWAGh2FG5iAheQoGe7qdLekRSoYUhI5djx7tZpVjCwnPfdVld
	 g9l1qJPcZa01ZRizeRP0uM8tfIZ9Txnhl/stCqlEsQ2fJ1SPgT2C226jeYTYczfs1E
	 s3sqb85TmJBWDms9nJk3BkRr7wgsI1EH6hP97BH0s74cbJZ1I1qCHr38qENSzyQxSr
	 Phj5z/UZsRCRA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 41D5511A2C4F; Mon,  8 Apr 2024 17:30:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eadavis@qq.com,
 eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
In-Reply-To: <000000000000abd40e0615516bdb@google.com>
References: <000000000000abd40e0615516bdb@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 08 Apr 2024 17:30:36 +0200
Message-ID: <877ch7hnxf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:

Trying again on a different branch:

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 443574b03387


diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfd919374017..a3f24486829e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -281,9 +281,9 @@ static int xdp_recv_frames(struct xdp_frame **frames, int nframes,
 static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
                              u32 repeat)
 {
-       struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
        int err = 0, act, ret, i, nframes = 0, batch_sz;
        struct xdp_frame **frames = xdp->frames;
+       struct bpf_redirect_info *ri;
        struct xdp_page_head *head;
        struct xdp_frame *frm;
        bool redirect = false;
@@ -294,6 +294,7 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog
*prog,
 
        local_bh_disable();
        xdp_set_return_frame_no_direct();
+       ri = this_cpu_ptr(&bpf_redirect_info);
 
        for (i = 0; i < batch_sz; i++) {
                page = page_pool_dev_alloc_pages(xdp->pp);


