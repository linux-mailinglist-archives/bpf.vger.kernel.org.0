Return-Path: <bpf+bounces-1127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDCE70E5DE
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 21:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DE281460
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410421CED;
	Tue, 23 May 2023 19:43:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781C1F934
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 19:43:11 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60CFE5;
	Tue, 23 May 2023 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UK1+XiYEyu4+vDapejBb3ZP/JmaeH6v5xTRHNShZpvI=; b=K8uiWzEwvRaNs1+I0WOKBh5cVI
	dJJQidJawc69Qeq7ul/Q+/qy5CA4w2vWyQWIab2biCrQ7niIOJWe6seb+5wOal30Czb6qWDzmCZOJ
	zxR/AM+q/Pk26NTSsy469S3vzZPI+OtSOUFKWFjnzvoKGRlRHl7qspOf5dW1fTn4V5VGoHaZQISY4
	GibDZHL/rUTfoAs8Op/6IRWXFx/1uBoTMVDfKsY8oui8Lvu3cMN6P97IISYIkaPnaX575H5M/ysPq
	PP6lNvh9bD9ccr1ot49F7iKIlVdhsE2uOnnXRGAxUra298pdEk3Cde2BwqhbMJ98wPM+xa+U5lHsZ
	iUejKITQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q1XuU-00019c-Rf; Tue, 23 May 2023 21:43:07 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q1XuU-000JYH-BJ; Tue, 23 May 2023 21:43:06 +0200
Subject: Re: [PATCH v4 bpf-next 0/4] Add O_PATH-based BPF_OBJ_PIN and
 BPF_OBJ_GET support
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@kernel.org
Cc: cyphar@cyphar.com, brauner@kernel.org, lennart@poettering.net,
 linux-fsdevel@vger.kernel.org
References: <20230523170013.728457-1-andrii@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d881e3a5-2d11-2ad9-14b2-169ccc11f63a@iogearbox.net>
Date: Tue, 23 May 2023 21:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230523170013.728457-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26916/Tue May 23 09:22:39 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/23/23 7:00 PM, Andrii Nakryiko wrote:
> Add ability to specify pinning location within BPF FS using O_PATH-based FDs,
> similar to openat() family of APIs. Patch #2 adds necessary kernel-side
> changes. Patch #3 exposes this through libbpf APIs. Patch #4 uses new mount
> APIs (fsopen, fsconfig, fsmount) to demonstrated how now it's possible to work
> with detach-mounted BPF FS using new BPF_OBJ_PIN and BPF_OBJ_GET
> functionality. We also add few more tests using various combinations of
> path_fd and pathname to validate proper argument propagation in kernel code.
> 
> This feature is inspired as a result of recent conversations during
> LSF/MM/BPF 2023 conference about shortcomings of being able to perform BPF
> objects pinning only using lookup-based paths.
> 
> v3->v4:
>    - libbpf v1.3 bump (Daniel);

Looks good, applied 2-4 now. (Patch 1 was already in the tree.) Thanks!

