Return-Path: <bpf+bounces-35733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B3693D516
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0F02844F2
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D211CA1;
	Fri, 26 Jul 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IvaKIRyU"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915115E81
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004036; cv=none; b=aI6Y5L5ZIFUG7XifsCG8F41YjNx3wPwQ4B0AckwUmku7wG2GfSB0qmoPghlsPX0ct4PeLw+PKXWUjJkIsY0kP4YOrLS/vgv14R+tDvz/LBXh19ZMH1BsMf2vVy4S7OaaIYTyPO6YJiF9KZsic+fKo62BAzTeXhRtWC/m/V4o36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004036; c=relaxed/simple;
	bh=zFNHbW4SDJolvZwnh4TyaLneUMCGt+JESG0ybQOGxwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hO2+kC3IGmqoWulvXMy1xhjcR+8pfhkbgiRL5hFZzqDdjknebP6CrY5Z2V0RfC34No+mSQask9aT6MbB+Rdb1Xs0ZnKd4U/U8hnk1ulNqAJAVZ4o+xNJ0EzAYq/rbpsyhtoHM/t6uX9DqD57IraTaFh3ymRy/op4ye1a9dLx2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IvaKIRyU; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <535ec9d5-0ecd-4778-8af2-15f4b8f9150c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722004028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFNHbW4SDJolvZwnh4TyaLneUMCGt+JESG0ybQOGxwo=;
	b=IvaKIRyUrXsvNnA8KJ0VOrktWiTNUE0VrXYWwT3OOxVKW/v2DcMIik19DDfAl9M/aBl8sn
	T5BeDLAmAyR3efgzl6rRXK2zqf1vJZXZhaE3oFubCsS/dn+yqWeHxnKq6SFLOxrIxnb989
	ygtZ86SKapclxF8I+Cir9L7AWZql5Hc=
Date: Fri, 26 Jul 2024 07:26:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 bpf-next] bpf: export btf_find_by_name_kind and
 bpf_base_func_proto
Content-Language: en-GB
To: Ming Lei <ming.lei@redhat.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, andrii@kernel.org, drosen@google.com,
 kuifeng@meta.com
Cc: sinquersw@gmail.com, thinker.li@gmail.com,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
References: <20240726125958.2853508-1-ming.lei@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240726125958.2853508-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/26/24 5:59 AM, Ming Lei wrote:
> Almost all existed struct_ops users(hid, sched_ext, ...) need the two APIs.
>
> In-tree hid-bpf code(drivers/hid/bpf/hid_bpf_struct_ops.c) can't be built
> as module because the two APIs aren't exported.
>
> Export btf_find_by_name_kind and bpf_base_func_proto, so that any kernel
> module can use them given bpf community is supporting to register
> struct_ops in module, see the patchset "Registrating struct_ops types from
> modules"[1], which is merged to v6.9.
>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


