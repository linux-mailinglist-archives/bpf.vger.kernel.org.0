Return-Path: <bpf+bounces-9106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F23D78FBDA
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 12:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED6B1C20C6B
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E5A947;
	Fri,  1 Sep 2023 10:41:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917879E6
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 10:41:47 +0000 (UTC)
Received: from out-231.mta0.migadu.com (out-231.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C527310CC
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 03:41:45 -0700 (PDT)
Message-ID: <96f8b4f0-a3a3-8da5-af6e-3bfc11d7f524@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693564903; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BhLX35lLI383smuv84S/OeZwvmBG5wsYV+iqo28kOT4=;
	b=ZUP21jDrGNw2Oag7pKRjgIEL80ihMHfKLw2XAcCH2SrR456JYsW9YJX/9VneY2bVO+Fqa2
	Cxg10m6x8paO2d58D1aE3P7bpzhnwHKCv+5va+C18lRorvXvLKw6cS7/1ScG5EGAmDnV1u
	/UFd3f03pFOImdb9ETMP33VvmUy6uo4=
Date: Fri, 1 Sep 2023 06:41:39 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 10/11] selftests/bpf: Enable the cpuv4 tests for
 s390x
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20230830011128.1415752-1-iii@linux.ibm.com>
 <20230830011128.1415752-11-iii@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230830011128.1415752-11-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/29/23 9:07 PM, Ilya Leoshkevich wrote:
> Now that all the cpuv4 support is in place, enable the tests.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

