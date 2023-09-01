Return-Path: <bpf+bounces-9105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BE478FBD7
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 12:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF052819AB
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FADA947;
	Fri,  1 Sep 2023 10:40:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984A29A1
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 10:40:35 +0000 (UTC)
Received: from out-235.mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C83210CC
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 03:40:33 -0700 (PDT)
Message-ID: <3602cc26-bcc7-d7e1-2183-53a3a1b93d91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693564831; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nrl5SQz2pg/MXM5KDjFoYKwi09tnkpUGEZZ8N4RBAmE=;
	b=tBDjRnMJM3fA0IOdPPfQtey/w8moKQa8fqQU1yQhUFbsGNdIK9wA0VawoSAWYX3FGKfgur
	uy/Zhamc4Za3vS49KJIMXN4w5S9Q42UCzYFsrVI6IgSGh8BgqKsbPlqhtupAFSUS+0IQ2l
	S1MONdwRbVrVcUeiShyMSVoEZphLvLA=
Date: Fri, 1 Sep 2023 06:40:24 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20230830011128.1415752-1-iii@linux.ibm.com>
 <20230830011128.1415752-2-iii@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230830011128.1415752-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/29/23 9:07 PM, Ilya Leoshkevich wrote:
> On the architectures that use bpf_jit_needs_zext(), e.g., s390x, the
> verifier incorrectly inserts a zero-extension after BPF_MEMSX, leading
> to miscompilations like the one below:
> 
>        24:       89 1a ff fe 00 00 00 00 "r1 = *(s16 *)(r10 - 2);"       # zext_dst set
>     0x3ff7fdb910e:       lgh     %r2,-2(%r13,%r0)                        # load halfword
>     0x3ff7fdb9114:       llgfr   %r2,%r2                                 # wrong!
>        25:       65 10 00 03 00 00 7f ff if r1 s> 32767 goto +3 <l0_1>   # check_cond_jmp_op()
> 
> Disable such zero-extensions. The JITs need to insert sign-extension
> themselves, if necessary.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

