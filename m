Return-Path: <bpf+bounces-6741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB39A76D766
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F901C212A8
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7D1101F2;
	Wed,  2 Aug 2023 19:06:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AE7D52F
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 19:06:49 +0000 (UTC)
Received: from out-117.mta0.migadu.com (out-117.mta0.migadu.com [IPv6:2001:41d0:1004:224b::75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1682129
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 12:06:46 -0700 (PDT)
Message-ID: <87ff8db2-a5d0-ccd0-0808-c83c4c135e05@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691003204; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKqFX37CvYKxPY3eB4VjI3FOLMu+wlT2i2ELLkYWG3Q=;
	b=rJPLEIcVe1JNbuUk6CCn+tdClazw1MMrU0gpupZUQOHlXkFh78n70JVCE98NInCc74Q5aw
	W50/3SBGqUvqj2kJHBqKkmuYlunSIc0xKwTI/a68ULfAJcFC7uYYf7YB0y8p9xIP96OwWG
	4bcMDiNIii1xHBZZNaazJ4vXY078USk=
Date: Wed, 2 Aug 2023 12:06:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next] libbpf: Use local includes inside the library
Content-Language: en-US
To: Sergey Kacheev <s.kacheev@gmail.com>, bpf@vger.kernel.org,
 Alan Maguire <alan.maguire@oracle.com>
References: <CAJVhQqUg6OKq6CpVJP5ng04Dg+z=igevPpmuxTqhsR3dKvd9+Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAJVhQqUg6OKq6CpVJP5ng04Dg+z=igevPpmuxTqhsR3dKvd9+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/2/23 11:22 AM, Sergey Kacheev wrote:
> In our monrepo, we try to minimize special processing when importing
> (aka vendor) third-party source code. Ideally, we try to import
> directly from the repositories with the code without changing it, we
> try to stick to the source code dependency instead of the artifact
> dependency. In the current situation, a patch has to be made for
> libbpf to fix the includes in bpf headers so that they work directly
> from libbpf/src.
> 
> Signed-off-by: Sergey Kacheev <s.kacheev@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

