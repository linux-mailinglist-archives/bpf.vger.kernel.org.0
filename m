Return-Path: <bpf+bounces-40589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD498A9C7
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 18:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5120E2821B4
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF3D192598;
	Mon, 30 Sep 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oeGc8E8S"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8FF3D0D5
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713898; cv=none; b=lXFZBUresODgiUSMQT5yjNNevYip1WG80qSkJrsDpfyYnCwkYuZtzR9a8PMOxuFARFq5DTOXrA1ndwoaI6zfsN9J871CV9axxVPaudsBIvo/MlnAktcYGCZROEFejB63Q6DU1m/0K+a5Sni2Oy/kHD4uOkRSl54EZwrOYMGIOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713898; c=relaxed/simple;
	bh=jykrlBlw1NrtddvTZXujYBRNuxff2G7TY9Gzz9Lv+Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkpHMHL2XOL9WsPM3ljqV+0eXOTTDnPnd/a8xbsbixQmPl/svnUprcRuDrULQleXxMvAcTlgCZ2cs98SX0fDG5F0LGPKqIkfAeMDsy4IOCtvlMwNa/e6RhWA3CbGuZgo+5ERAqUuVv7w8+QX8lg0VYnGshH0Jyp2vTfrVtqXg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oeGc8E8S; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d66d9704-39b9-4999-ab75-9708e1b1c7b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727713894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iY+vcJnzV+b/sgWUiO3vXrFGdLJs72uFPFguEf5X14=;
	b=oeGc8E8SEt09DOj1cJs1EVGJ2Hq9Qp3gQSVy1u0jJMQZbdgmgCRtYOF/Doyxor584UW19H
	Om2lGv4C2KE+nIJzk0InxyY7BZyMKJ5YnMJS5G8z3L94nujdiraUFBX82XKvoO7/eVaY9v
	Cc2SFJtQtN8hgpZGIdGCXrfAARA1W24=
Date: Mon, 30 Sep 2024 09:31:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private
 stack
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234526.1770736-1-yonghong.song@linux.dev>
 <202409292026.oUij9Xvr-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <202409292026.oUij9Xvr-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 9/29/24 6:02 AM, kernel test robot wrote:
> Hi Yonghong,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Allow-each-subprog-having-stack-size-of-512-bytes/20240927-074744
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20240926234526.1770736-1-yonghong.song%40linux.dev
> patch subject: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private stack
> config: x86_64-buildonly-randconfig-004-20240929 (https://download.01.org/0day-ci/archive/20240929/202409292026.oUij9Xvr-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409292026.oUij9Xvr-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409292026.oUij9Xvr-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> ld.lld: error: undefined symbol: this_cpu_off

Leon Hwang has reported this error. Will fix in the next revision.

>     >>> referenced by bpf_jit_comp.c:31 (arch/x86/net/bpf_jit_comp.c:31)
>     >>>               arch/x86/net/bpf_jit_comp.o:(bpf_int_jit_compile) in archive vmlinux.a
>

