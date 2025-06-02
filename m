Return-Path: <bpf+bounces-59436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F1EACB719
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 17:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54B14C343F
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7056C23BF8F;
	Mon,  2 Jun 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UrpPYD4Z"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C1E23315A;
	Mon,  2 Jun 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876497; cv=none; b=WhAVJTeCyJplzlOFzM5CjjJ6Pt5qkaOpoG1OWKr0obFxq2TwSYOtaFc4MxSf1AS2bnwf+gOMqSkcnQHtFlM0YiEeAstVJgubfC/SAgeEpKmpOPGJED+7AUnrXh9ZllddSYKWzyXyU9P8ZkIKDhwHKAmvbRblY5sYtOsCnPgjcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876497; c=relaxed/simple;
	bh=LaKg7t0RuwlvnsMDtoPiMEaCUDTrJM9p4LfCg+Jnc2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eseiSOVUyEl3NX26z12v3UWViBR9Q7Qe6JdRT1rSPuhpDfyeH6c4tHumUuY6Z9LCjbC6feX0GdTEtbENbV1R78CNj1vmYHSKAbXc21HXwYjbIW3mG6cFB92vcvTs5YkZ7l2axANxOlYzytbqslao68U/qm6h3yKQ52GS7asSwmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UrpPYD4Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id B783C2113A4E;
	Mon,  2 Jun 2025 08:01:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B783C2113A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748876490;
	bh=LaKg7t0RuwlvnsMDtoPiMEaCUDTrJM9p4LfCg+Jnc2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UrpPYD4ZV36T4yks9wnk/qqQ88MEmtszbG2RxOz0KAkkfYCcOC3WYCFy6DjO9pzaL
	 LBmNP0WUgqbdsAtAbz6eT4v/qzrlskHWyK9j10OBMF8VTsGSJWWtl0vLgtNUAlt3Z3
	 EC6Y5vacXwc28JQhCc+l6hHnHaXw69IoxlK6+Tpw=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, jarkko@kernel.org,
 zeffron@riotgames.com, xiyou.wangcong@gmail.com, kysrinivasan@gmail.com,
 code@tyhicks.com, linux-security-module@vger.kernel.org,
 roberto.sassu@huawei.com, James.Bottomley@hansenpartnership.com, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Howells
 <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, Ignat Korchagin
 <ignat@cloudflare.com>, Quentin Monnet <qmo@kernel.org>, Jason Xing
 <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, Anton
 Protopopov <aspsk@isovalent.com>, Jordan Rome <linux@jordanrome.com>,
 Martin Kelly <martin.kelly@crowdstrike.com>, Alan Maguire
 <alan.maguire@oracle.com>, Matteo Croce <teknoraver@meta.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kys@microsoft.com
Subject: Re: [PATCH 0/3] BPF signature verification
In-Reply-To: <CACYkzJ5gXf4MOdb4scid0TaQwpwewH5Zzn2W18XB1tFBoR2CQQ@mail.gmail.com>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
 <87iklhn6ed.fsf@microsoft.com>
 <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
 <87ecw5n3tz.fsf@microsoft.com>
 <CACYkzJ4ondubPHDF8HL-sseVQo7AtJ2uo=twqhqLWaE3zJ=jEA@mail.gmail.com>
 <878qmdn39e.fsf@microsoft.com>
 <CACYkzJ6ChW6GeG8CJiUR6w-Nu3U2OYednXgCYJmp6N5FysLc2w@mail.gmail.com>
 <875xhhn0jo.fsf@microsoft.com>
 <CACYkzJ5gXf4MOdb4scid0TaQwpwewH5Zzn2W18XB1tFBoR2CQQ@mail.gmail.com>
Date: Mon, 02 Jun 2025 08:01:29 -0700
Message-ID: <8734cimbli.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KP Singh <kpsingh@kernel.org> writes:

>> And I'm saying that they are, based on wanting visibility in the LSM
>> layer, passing that along to the end user, and wanting to be able to
>> show correctness, along with mitigating an entire vector of supply chain
>> attacks targeting gen.c.
>
> What supply chain attack?I asked this earlier, you never replied, what
> does a supply chain attack here really look like?
>
>
I responded to that here:
https://lore.kernel.org/linux-security-module/87iklhn6ed.fsf@microsoft.com/

Warmest Regards,
Blaise

> - KP
>
>>
>> So in summary, your objection to this is that you feel it's simply "not
>> needed", and those above risks/design problems aren't actually an issue?
>>
>> > Let's have this discussion in the patch series, much easier to discuss
>> > with the code.
>>
>> I think we've all been waiting for that. Yes, lets.

