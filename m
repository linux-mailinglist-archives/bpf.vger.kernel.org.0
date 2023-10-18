Return-Path: <bpf+bounces-12538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658497CD8F6
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 12:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9678E1C20CBF
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E37518B15;
	Wed, 18 Oct 2023 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="A+53hsGm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62C15E8B
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 10:16:25 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB90109;
	Wed, 18 Oct 2023 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1697624179;
	bh=MczObw+G4xIfimfbL65IT/uzpdr8unY/SOxvHjaqltM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A+53hsGmVyQYZZh5fTNgAkvKCl4uqq0LlfPKxFdLRnkUdS990MgFkzAD2DjBBG/+Q
	 iR6t95IAePINUtlt5f7MPTjZsTbxoZc84zemN57VvwOvppCQUWAiTwL+dDCPCBzwNp
	 EExN23l5P9uQgXwRCGn/gRCPGCbMO+ybjEW+N0JzOCkRYpoB+Y9jXwxYHRlZ5QjpIu
	 r6RnQYtkK75SJmUNp3+jR8HHFvDOpWNLNFnYXsAkSTn6e8/QbiyAEr1NeTvVmFE4Fq
	 X/Zdt++Imc1OXNlm/zP/AbR2ft0iMH1XypX8p8WP9w7EJ3UcpQrGTjpNFxtf5O8D8l
	 NBLbv8iapuwcA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9RZp5lHmz4xF9;
	Wed, 18 Oct 2023 21:16:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Muhammad Muzammil
 <m.muzzammilashraf@gmail.com>, martin.lau@linux.dev,
 yonghong.song@linux.dev, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: powerpc: net: bpf_jit_comp32.c: Fixed 'instead' typo
In-Reply-To: <cc25e4b1-9079-1c45-b6d4-7f7f4701df0a@iogearbox.net>
References: <20231013053118.11221-1-m.muzzammilashraf@gmail.com>
 <cc25e4b1-9079-1c45-b6d4-7f7f4701df0a@iogearbox.net>
Date: Wed, 18 Oct 2023 21:16:18 +1100
Message-ID: <87cyxc6xsd.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Daniel Borkmann <daniel@iogearbox.net> writes:
> On 10/13/23 7:31 AM, Muhammad Muzammil wrote:
>> Fixed 'instead' typo
>> 
>> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
>
> Michael, I presume you'll pick it up?

Will do.

cheers

