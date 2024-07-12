Return-Path: <bpf+bounces-34698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3016930190
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FD21C22AD9
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EB84CB2B;
	Fri, 12 Jul 2024 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jvi2lWpx"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49A224EA
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819502; cv=none; b=YrFXJ18cwk0LjG6Tk9rgFEt/j9oqTM5cVySZxDMVmAjAqorWn+E2SEJIfnbykBcY7U172yCcPvi0935pi875o/QCVfhiQg60Q8o0LFUYjpL3hPDZIp2niV0cqBGUVUxiDPb6F7QNEDGjPcVdeS2+9+hqEhAvYjC6yLspRUSlNRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819502; c=relaxed/simple;
	bh=jiHgDqhEtUbt/b5Tcq7BCwpPcRHTprO72chCaiLMzTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJXLWPh09TO1szplQKIbyG/Wj2I4GSucvJfkP2X5rSicB0GR9BNv88CbgOBsQvpWmxTIQL4gAVC9iIqKUQ7wwOblZFJSk5CZdb81hRF6Z2A7zCDSSpWd6wBgCi3X5w75sl8XqCVpWe2Rl2/DWNeL5oLfxobQ2qOnQ775gVku8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jvi2lWpx; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720819498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDQzKsi9ap3Msk+v18IUDq7zoR8izQtmdCo3d7po/QE=;
	b=Jvi2lWpxCWBHeDhvt4SWtAq/6/jnjHMZiAKqjrh+Mn72eE/1HtS9VsjKMtlzk4MH+06K50
	3IaEYXYVygN5TCYobzFhkYrwSbL/8bjlMtuFcbbktxBs21f1mbdENzjWltXpEOzst7gZH0
	Q+sAuYgum2Rng+ww2Esv9Nd0mS+Asng=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <753b8b26-db96-4fb9-b96c-c0485a762a4f@linux.dev>
Date: Fri, 12 Jul 2024 14:24:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Get better reg range with ldsx and
 32bit compare
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240712202815.3540564-1-yonghong.song@linux.dev>
 <CAADnVQKhfXg0N-yNOxxmR+Nq_YxG2zHPzpY9BjtBfwvFpQLZ_g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKhfXg0N-yNOxxmR+Nq_YxG2zHPzpY9BjtBfwvFpQLZ_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/12/24 1:30 PM, Alexei Starovoitov wrote:
> On Fri, Jul 12, 2024 at 1:28 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> +       if (reg->s32_min_value >= 0) {
>> +               if ((reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX) ||
>> +                   (reg->smin_value >= S16_MIN && reg->smax_value <= S16_MAX) ||
>> +                   (reg->smin_value >= S8_MIN && reg->smax_value <= S8_MAX)) {
> Could you do:
> if (reg->s32_min_value >= 0 &&
>      (reg->smin_value >= S32_MIN ...
>
> to remove one indent below.

Ack. Will make proper change in the next revision.

>
>> +                       reg->smin_value = reg->umin_value = reg->s32_min_value;
>> +                       reg->smax_value = reg->umax_value = reg->s32_max_value;
>> +                       reg->var_off = tnum_intersect(reg->var_off,
>> +                                                     tnum_range(reg->smin_value,
>> +                                                                reg->smax_value));

