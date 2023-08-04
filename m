Return-Path: <bpf+bounces-7059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E820770C5C
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 01:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF8E1C216C1
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313F253B1;
	Fri,  4 Aug 2023 23:24:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E2253A8
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 23:24:49 +0000 (UTC)
Received: from out-103.mta0.migadu.com (out-103.mta0.migadu.com [IPv6:2001:41d0:1004:224b::67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870E84EDC;
	Fri,  4 Aug 2023 16:24:47 -0700 (PDT)
Message-ID: <c76149f5-62d2-03de-05d8-f305d07f9089@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691191485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KM6TuEa4mggA6gvOUgc9FEnKNsg2euSylhFsrEPzmuU=;
	b=wOyiL6Iof6j5VhPDWV5Ihcvon+7uoMx3fABuP9xaAF1G81N0lPFk/XwKlCO0gYq7PaVqA2
	YJLXoJ2PsLTLYvALDsEAFps1J2XK39/5JEmTWmQrbYV1Qe/PE94YBs1SyJpfDo9YxR+ioL
	I5NZCyuWhYStZWaqnNfmiqZ/9nxXWLY=
Date: Fri, 4 Aug 2023 16:24:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linux-next:master 4617/7272] kernel/bpf/disasm.c:90:12: sparse:
 sparse: symbol 'bpf_alu_sign_string' was not declared. Should it be static?
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexei Starovoitov <ast@kernel.org>, Quentin Monnet <quentin@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202308050615.wxAn1v2J-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <202308050615.wxAn1v2J-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/4/23 3:40 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   bdffb18b5dd8071cd25685b966f380a30b1fadaa
> commit: f835bb6222998c8655bc4e85287d42b57c17b208 [4617/7272] bpf: Add kernel/bpftool asm support for new instructions
> config: i386-randconfig-i063-20230730 (https://download.01.org/0day-ci/archive/20230805/202308050615.wxAn1v2J-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230805/202308050615.wxAn1v2J-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308050615.wxAn1v2J-lkp@intel.com/

fwiw, the fix is in 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=1e8e2efb34023c5113ec679eae3c59ae2cd57b13 
.
I have added the above tags to the fix.

> 
> sparse warnings: (new ones prefixed by >>)
>>> kernel/bpf/disasm.c:90:12: sparse: sparse: symbol 'bpf_alu_sign_string' was not declared. Should it be static?
>>> kernel/bpf/disasm.c:95:12: sparse: sparse: symbol 'bpf_movsx_string' was not declared. Should it be static?
> 


