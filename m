Return-Path: <bpf+bounces-31420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C71328FC6D6
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 10:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628B01F21C06
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665444963C;
	Wed,  5 Jun 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lczM9yvV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B91946BE
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577143; cv=none; b=IKnm+AqWNjnWuq/dnLoxtzWTWXp0uxH3MMkrjSq48tkQiBRS9qFCtC/MiOkzhd7MzLp2GXfJqe5b5WHJQvH/md4WJJzPl08eFTVGQZQl7vRCpAIgkQpEcdxSJxLj/uwwvV8JEL7M9fW00kRiO0J9GFIWpoUO5eeLg39gLkd3v+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577143; c=relaxed/simple;
	bh=4PgNF5iHlPwWGopd2561mzSZbWHKCiIlIOEtQ6+MRd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZifAfPo3eMyKB9zC5f1mndnfsS2pxgi46WezTVrK0aitwUonjHrFWlg4xxpw09ejf3f5SbauiaMvfeOf8beEqogMq+xd1OhjVIVLjNyT8WDvZs7VbQIN1QlvcAfN31fSOAB2qEJYv2WCmz12LQYqszTE/mAoeXDFi+V5WomJUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lczM9yvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BD5C3277B;
	Wed,  5 Jun 2024 08:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717577142;
	bh=4PgNF5iHlPwWGopd2561mzSZbWHKCiIlIOEtQ6+MRd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lczM9yvVLtnjI2odDih0N7jZ4251HGpl2WRMYd9l7VRd7fRakoO7SD5MtFnsu5Vp9
	 ktwKu3UF2SjAh1b6QHtj66bHkGroeCQhN3quu4vTe7uTLxnE7WDo9bZ86PAauj8RZF
	 X5QpnAMft8oTSy1C1m1bjlcvH1DVJnCQYCsJ6eX8NwzvmHLGwkyhxct/o9q6hK92mk
	 VGuJLQ6vaconmHq6kfShx9FmX0otzPTK61JLJ0RNjnJHe1ZIo/sUb5TPmnDXFeGOry
	 y+dgFSf+QmAE1HTpRGgJZK4Ai4n+NH1SdcnFqpTpVtDy/Z5oRweYOKxtgDZZvGyfcE
	 tCWcc2H9pEntA==
Message-ID: <e14d2461-7336-43e4-88c3-b0a6abac4bab@kernel.org>
Date: Wed, 5 Jun 2024 09:45:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 4/5] bpftool: use BTF field iterator in btfgen
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: alan.maguire@oracle.com, eddyz87@gmail.com, jolsa@kernel.org
References: <20240605001629.4061937-1-andrii@kernel.org>
 <20240605001629.4061937-5-andrii@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240605001629.4061937-5-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-06-05 01:16 UTC+0100 ~ Andrii Nakryiko <andrii@kernel.org>
> Switch bpftool's code which is using libbpf-internal
> btf_type_visit_type_ids() helper to new btf_field_iter functionality.
> 
> This makes bpftool code simpler, but also unblocks removing libbpf's
> btf_type_visit_type_ids() helper completely.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>


Still looks good to me :)

Reviewed-by: Quentin Monnet <qmo@kernel.org>

