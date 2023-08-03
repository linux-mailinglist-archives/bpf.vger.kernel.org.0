Return-Path: <bpf+bounces-6785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5692E76DFBF
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211921C21443
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 05:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EED7498;
	Thu,  3 Aug 2023 05:27:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9F3D8E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 05:27:47 +0000 (UTC)
Received: from out-86.mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47E3A89
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 22:27:13 -0700 (PDT)
Message-ID: <efaae4e7-7c90-9c34-5232-de406fad23d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691040429; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTbBhGlrpoAGJdKSc90GMN/oNPPVh1eXL266pWaE0QM=;
	b=Ndye3spB/cF3Gec1czH/2VVJjiXK4D66oVkqF8CrN2cStLTCmgxT9kIY52uYrFhLZR0Pac
	peDDEaKPNiSSc4jxz0stwxne6UD/u4v+2CJmhtKlRYNmO1qYljHPCU5ecws58+GX9zvcJ0
	FTDAppxf83XFU08ng+GNXddmfKG/eYE=
Date: Wed, 2 Aug 2023 22:27:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH -next] bpf: change bpf_alu_sign_string and
 bpf_movsx_string to static
Content-Language: en-US
To: Yang Yingliang <yangyingliang@huawei.com>, bpf@vger.kernel.org
Cc: eddyz87@gmail.com, quentin@isovalent.com, ast@kernel.org
References: <20230803023128.3753323-1-yangyingliang@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230803023128.3753323-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/2/23 7:31 PM, Yang Yingliang wrote:
> The bpf_alu_sign_string and bpf_movsx_string introduced in commit
> f835bb622299 ("bpf: Add kernel/bpftool asm support for new instructions")
> are only used in disasm.c now, change them to static.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for the fix!

Acked-by: Yonghong Song <yonghong.song@linux.dev>

