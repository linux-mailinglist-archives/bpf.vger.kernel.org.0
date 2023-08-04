Return-Path: <bpf+bounces-7054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88418770BB7
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 00:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0371C20AFC
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F323BE3;
	Fri,  4 Aug 2023 22:04:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED931AA8B
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 22:04:54 +0000 (UTC)
Received: from out-89.mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF810EA
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 15:04:51 -0700 (PDT)
Message-ID: <3d28fbdb-7f4b-06fc-1080-468d419dc4a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691186689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4U/EXTCEbT0bKWZjLQTzRSbsu3HlZmIKt4N3y5UmUCM=;
	b=xm0Ftx7NapCuetX9U1wQyAd4xXU1NYL7OCtc7PIVXeKlyFtxnYB0/U55uTnhVahjrJnI5S
	QmI9VH7/TkK+l0YgDvcpMD46nS642sGZ6D4r4IFCGZ31+Xs58JAtWRwuMfHSeyFupJAGwU
	8cHP20s4Wa7i8d9Xcf92CP6s6w5ohjw=
Date: Fri, 4 Aug 2023 15:04:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf, docs: Formalize type notation and function
 semantics in ISA standard
Content-Language: en-US
To: Will Hawkins <hawkinsw@obs.cr>, David Vernet <void@manifault.com>
References: <20230803004450.3006690-1-hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230803004450.3006690-1-hawkinsw@obs.cr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/23 5:44 PM, Will Hawkins wrote:
> Give a single place where the shorthand for types are defined and the
> semantics of helper functions are described.

David, please help to review. Thanks.


