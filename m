Return-Path: <bpf+bounces-59295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3748EAC8054
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885469E35E3
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A422D4E2;
	Thu, 29 May 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dEK26zK9"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD6193062;
	Thu, 29 May 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532772; cv=none; b=a1c4Kb6QC6CTAgdVooNq1dV74V4se7+bql22wF4MtlDoZCqeoxZJJxzJLr3xXq5LqWvDUjAKriqEV7U/zB1dO83c6H0eiReQa6qLsDPkIU9zEbp+2O/rKd4jz1ysIbnc8uFrBkQpg8AFOvJWVym/PSL91fsBYf05lhXWWntoE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532772; c=relaxed/simple;
	bh=GzoA6uvTo4t9PdtiyY4JFANz807VCS4EaCaegKk/xqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kaXWEQgW9D2cnEgX+FkwGjd/9GayLZ/bkVw5Fm+Bu8onwnPSuz+c7jof5plnmDMNhQo3MTYk4Tt8bcxaJQTBEoB/E59lmx6L6CwkIFlJgK5suqk24BwXk0d/MC2tKqtF4nmKFT7CmGHhLog6v4TtOIiR9mna1GGJdPRtQzm2pzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dEK26zK9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id D0CB1207861D;
	Thu, 29 May 2025 08:32:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0CB1207861D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748532768;
	bh=CVcXX0izB84lzZgI4QE93xD+b9nu6pG8yG3Y1vkIp/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dEK26zK9pRZZcIxz/pLWp9R4tr/wue5TYXgnS4OULTipYZlZ42H7056RrD0GTzsMo
	 dTGT1ZmDBvivP/d3g18JAE0PJUfTa+OGPUc32VHMH24qU5tyYKN9K4gvb+f9NZPz54
	 huicmVqCVkiLyW+j3NBbRbIIDLzsSWGgWw7UtvqY=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Paul Moore <paul@paul-moore.com>, jarkko@kernel.org,
 zeffron@riotgames.com, xiyou.wangcong@gmail.com, kysrinivasan@gmail.com,
 code@tyhicks.com, linux-security-module@vger.kernel.org,
 roberto.sassu@huawei.com, James.Bottomley@hansenpartnership.com, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, David Howells <dhowells@redhat.com>, Ignat Korchagin
 <ignat@cloudflare.com>, Quentin Monnet <qmo@kernel.org>, Jason Xing
 <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, Anton
 Protopopov <aspsk@isovalent.com>, Jordan Rome <linux@jordanrome.com>,
 Martin Kelly <martin.kelly@crowdstrike.com>, Alan Maguire
 <alan.maguire@oracle.com>, Matteo Croce <teknoraver@meta.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/3] bpf: Add bpf_check_signature
In-Reply-To: <aDgy1Wqn7WIFNXvb@wunner.de>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <20250528215037.2081066-2-bboscaccy@linux.microsoft.com>
 <aDgy1Wqn7WIFNXvb@wunner.de>
Date: Thu, 29 May 2025 08:32:43 -0700
Message-ID: <87msave8kk.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Wunner <lukas@wunner.de> writes:

> On Wed, May 28, 2025 at 02:49:03PM -0700, Blaise Boscaccy wrote:
>> +	if (!attr->signature_maps_size) {
>> +		sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_insn), (u8 *)&hash);
>> +		err = verify_pkcs7_signature(hash, sizeof(hash), signature, attr->signature_size,
>> +				     VERIFY_USE_SECONDARY_KEYRING,
>> +				     VERIFYING_EBPF_SIGNATURE,
>> +				     NULL, NULL);
>
> Has this ever been tested?
>
> It looks like it will always return -EINVAL because:
>
>   verify_pkcs7_signature()
>     verify_pkcs7_message_sig()
>       pkcs7_verify()
>
> ... pkcs7_verify() contains a switch statement which you're not
> amending with a "case VERIFYING_EBPF_SIGNATURE" but which returns
> -EINVAL in the "default" case.
>

Looks like I missed a commit when sending this patchset. Thanks for
finding that. 

> Aside from that, you may want to consider introducing a new ".ebpf"
> keyring to allow adding trusted keys specifically for eBPF verification
> without having to rely on the system keyring.
>
> Constraining oneself to sha256 doesn't seem future-proof.
>

Definitely not a bad idea, curious, how would you envision that looking
from an UAPI perspective? 

> Some minor style issues in the commit message caught my eye:
>
>> This introduces signature verification for eBPF programs inside of the
>> bpf subsystem. Two signature validation schemes are included, one that
>
> Use imperative mood, avoid repetitive "This ...", e.g.
> "Introduce signature verification of eBPF programs..."
>
>> The signature check is performed before the call to
>> security_bpf_prog_load. This allows the LSM subsystem to be clued into
>> the result of the signature check, whilst granting knowledge of the
>> method and apparatus which was employed.
>
> "Perform the signature check before calling security_bpf_prog_load()
> to allow..."
>
> Thanks,
>
> Lukas

