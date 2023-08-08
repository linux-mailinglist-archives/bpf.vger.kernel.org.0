Return-Path: <bpf+bounces-7204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911C0773564
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 02:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD05281630
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 00:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3855137F;
	Tue,  8 Aug 2023 00:33:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719B191
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 00:33:47 +0000 (UTC)
Received: from out-102.mta1.migadu.com (out-102.mta1.migadu.com [IPv6:2001:41d0:203:375::66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0361703
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 17:33:46 -0700 (PDT)
Message-ID: <b08d7924-9ca1-1ec1-8201-4bf58b403066@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691454824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRuYBmnLzSABJKYlhGN/Af89iV4teHhB9p+KEYcIn90=;
	b=p6yhagCRuAbXBmCyK9WcrPwOPq3abMfhVz2hWDXJxHEUO+JZQZzmhDECzJzDUrgE2m0q7f
	7nkMWF20SqKdmD2InecHcGdhMmEEiFesk06U/O8B4ngFFvL4XrY7HhxxLRXkVsHYoelHrF
	EuSjy2TSKjuPHmfLU2nPxSbjKRwg7t8=
Date: Mon, 7 Aug 2023 17:33:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: remove duplicated functions
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, bpf@vger.kernel.org
References: <20230807193840.567962-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230807193840.567962-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/7/23 12:38 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The file cgroup_tcp_skb.c contains redundant implementations of the similar
> functions (create_server_sock_v6() and connect_client_server_v6()) found in
> network_helpers.c. Let's eliminate these duplicated functions.

How about the port function mentioned in 
https://lore.kernel.org/bpf/c2776380-7550-3777-24a0-1f155785696c@linux.dev/ :

 >> There is get_socket_local_port() that supports both v4 and v6 in
 >> network_helpers.c which is equivalent to the get_sock_port_v6() here.


