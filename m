Return-Path: <bpf+bounces-34955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90919340B1
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 18:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C091C21910
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D2D181D18;
	Wed, 17 Jul 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPf3I+bG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD71181D07
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234687; cv=none; b=oYeCGx6D0GElNRRjZEitC/NeFOT492LzIaCyYSkYZMIyynG4jH9rjL1bnj5Q5yf/ZNuLUN82iXBnsTBco6Bu6sDqHRrhIHXCO91HEHbCceNfMfgHGsuoPm2pXLRQY/TjSiuPDj9SniKwThSRwzW30iFDybGGKzYeDvpI0lNlUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234687; c=relaxed/simple;
	bh=A4cyRx00SU3bUfDh7G1JgKUprIF0w5LFB5GtjejsqiU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CZcW77TNrQK4LG88TibrSD0EVgNjr1Ue22OfNSreZ2sbRnAEC+s0IBn8KfUdOA16oQbIld3FcXhxKVXbj5xTRj9fWKfuqYQvMgwCV/KvfhaaknJf/j/ddxzj8AiSdZMqPYxjLN2UJCEv91UrsrxP9V0frA63yzcJglhtT2vzb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPf3I+bG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCECC2BD10;
	Wed, 17 Jul 2024 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721234686;
	bh=A4cyRx00SU3bUfDh7G1JgKUprIF0w5LFB5GtjejsqiU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=pPf3I+bGpj43BNzUJQW1Acg6yqisXev41C5OUTpcHu+JKrS/e7VkONFf5WgvW7krw
	 ibD+F4gGG97312Xn2ytUkwe7So9cj08OH2gvat2Pr6gqMfclAoJache+5QAtVRVs6B
	 wSeeZavhb1za7Z/l1LdLY9JfEoxBbhda9ppLF4m7Kzmr/IGi3V/KVaDCRnLudVhrWZ
	 oThpuepC6SO8vWFpUnRshJAS+05TPDtkVdTs0eoQms7yzXtvT6WmEbo/XN42NGKRqy
	 1UN6LwBtHAUZX/EQjS7o2LwnbjwIoFUuQTZGyZV1xiA2tcIU+cKmzm616KndHz7lDA
	 VGwtLhzf1LFig==
Message-ID: <eafb5e56-e281-4e3e-914c-005d22af81bd@kernel.org>
Date: Wed, 17 Jul 2024 17:44:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next] bpftool: Fix typo in usage help
To: Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
 Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: donald.hunter@redhat.com
References: <20240717134508.77488-1-donald.hunter@gmail.com>
Content-Language: en-GB
In-Reply-To: <20240717134508.77488-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-07-17 14:45 UTC+0100 ~ Donald Hunter <donald.hunter@gmail.com>
> The usage help for "bpftool prog help" contains a ° instead of the _
> symbol for cgroup/sendmsg_unix. Fix the typo.
> 
> Fixes: 8b3cba987e6d ("bpftool: Add support for cgroup unix socket address hooks")
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks!


