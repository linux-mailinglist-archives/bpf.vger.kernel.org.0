Return-Path: <bpf+bounces-44868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15E39C94A4
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 22:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D22B22F1A
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 21:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E179E1AF0C5;
	Thu, 14 Nov 2024 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QAyCrM95"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1C76026
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620616; cv=none; b=KJth5g833MT848qN2KjRwiGDQSnHPx/d4Oq43wA/Om3W5e/Xv6ShHHcZQFZmxrOOwE71SUB9zkC0gg1D1N98ECku6k382nmx/+Bh+QeuL6BpHDKObR3YudGJpzke4qAiMV5zlKHErw+jsy2+O84pot2aTCg2W8DfZvaccOkJ0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620616; c=relaxed/simple;
	bh=n7JmvDQEJTOnk++XK6eA+PE6CAAvjld8xZERnikAMqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cz51cpLXBss3MZM1n3VvWJuSVgoDHusgyUg2WVjhtX1vZIMj6Gj7gx05F+UhEZ0RVPXEu36wEAefllh4Y2Y0Ue5hDm6+0TUMrRuua8w5LxzJ1V/so38zMtwb0M3n9kEHqXoQCUC9BfHWBw72VqSKlpCRyiWecW/I08ICD0TYNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QAyCrM95; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5edc796-7ae3-4b57-b8ee-223f2c26f936@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731620611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDmTfCI6RKcz57gtjFsW2JZrMbqYTYu7rhILfnoxFRk=;
	b=QAyCrM95sT4SgqKL1YZL6gh5Iio9mME7K9TkmbaOtg2G5WNw0ki8VNgeGHcwHa6XCEIAKU
	r7l8SYf7aFKyP248QyuEjAFCg6fxDG/JzxE4grnJ/GMSBp83J5tHcS4IcrJCo9HepY796w
	RTWkXD8WOF4oYi3JWqcf5KW8V73gyew=
Date: Thu, 14 Nov 2024 13:43:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] xsk: Free skb when TX metadata options are invalid
To: Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, yoong.siang.song@intel.com, sdf@fomichev.me,
 netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 bpf@vger.kernel.org
References: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/14/24 3:30 AM, Felix Maurer wrote:
> When a new skb is allocated for transmitting an xsk descriptor, i.e., for
> every non-multibuf descriptor or the first frag of a multibuf descriptor,
> but the descriptor is later found to have invalid options set for the TX
> metadata, the new skb is never freed. This can leak skbs until the send
> buffer is full which makes sending more packets impossible.
> 
> Fix this by freeing the skb in the error path if we are currently dealing
> with the first frag, i.e., an skb allocated in this iteration of
> xsk_build_skb.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Jakub, can you help to take it directly to the net tree? Thanks!


