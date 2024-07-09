Return-Path: <bpf+bounces-34213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE592B3F3
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90B01F2250D
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72769155345;
	Tue,  9 Jul 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he1zNqLl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4C154458;
	Tue,  9 Jul 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517682; cv=none; b=XXdo9nSbEQrT0X9OhxE2COhlJtkjuGoG7a2Ce1lGlgAYOoY38BIMKoOgNXcuKHnH+AnPWpwxY7mKwNy3dd3I6Z+C/k/tcAa5TjyA7h44LTXQ3DUdPACpd6KzAzpbMGtm8673YAM/IIiX1THpgd7A1IFnLp9sHaHt0aNk62sFUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517682; c=relaxed/simple;
	bh=P0Tg5HgvkrsbncakOIEEZ4alS4fkZKeRhddMQDXL43c=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type; b=u9wt6MXsEgGkpJzuvTMj7Az+hJUfOObspEMLgCSRM2wzLyU0XuxFob6M+etI7KjcnD06innm3VhcjAn3UekIeeuWOqbZmRl5yjY26/udYEhR/iqeY7jrYun30fZTKZWtZPqk66XSNCoJXePSNwW0OFyW7Ha2N+P+NCzxJMohFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he1zNqLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F481C3277B;
	Tue,  9 Jul 2024 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720517681;
	bh=P0Tg5HgvkrsbncakOIEEZ4alS4fkZKeRhddMQDXL43c=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=he1zNqLljVoU8atGAg/yb/t+komzyYSyUY+npj0LJK4bw+LtwG11R0MmXeAwmqJVN
	 Gq2dFw2iLKQw4byk3Jns1oIitgwh5VE3CeSemr9ul5IDq1N/fs8QPsVGGzHAXiL+gE
	 3UZnQ54m426HhEP1xEhMFfkflU9qC3krY+KILGS0EzD5qvw5SHqPlXOIOr8/jV1Gru
	 jYvW8eSkQPg/CJxlcbfxZBdTxpt89kvJ78Eed5vR6EsWNw7cxMdLNCnX4W53UCak3D
	 rCRrUuoCATcNZqAmlzOexTCha0d8M49L3Rot3QU4UoktF/cV4sVw3liGPk+RE6qkGp
	 QDJDM1x9covzQ==
Date: Tue, 09 Jul 2024 15:02:13 +0530
From: Naveen N Rao <naveen@kernel.org>
Subject: Re: WARNING&Oops in v6.6.37 on ppc64lea - Trying to vfree() bad
 address (00000000453be747)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, matoro
	<matoro_mailinglist_kernel@matoro.tk>
Cc: bpf@vger.kernel.org, Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev
	<linuxppc-dev@lists.ozlabs.org>, ltp@lists.linux.it, stable@vger.kernel.org,
	Vitaly Chikunov <vt@altlinux.org>
References: <20240705203413.wbv2nw3747vjeibk@altlinux.org>
	<cf736c5e37489e7dc7ffd67b9de2ab47@matoro.tk>
	<2024070904-cod-bobcat-a0d0@gregkh>
In-Reply-To: <2024070904-cod-bobcat-a0d0@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.16.0 (https://github.com/astroidmail/astroid)
Message-Id: <1720516964.n61e0dnv80.naveen@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman wrote:
> On Mon, Jul 08, 2024 at 11:16:48PM -0400, matoro wrote:
>> On 2024-07-05 16:34, Vitaly Chikunov wrote:
>> > Hi,
>> >=20
>> > There is new WARNING and Oops on ppc64le in v6.6.37 when running LTP t=
ests:
>> > bpf_prog01, bpf_prog02, bpf_prog04, bpf_prog05, prctl04. Logs excerpt
>> > below. I
>> > see there is 1 commit in v6.6.36..v6.6.37 with call to
>> > bpf_jit_binary_pack_finalize, backported from 5 patch mainline patchse=
t:
>> >=20
>> >   f99feda5684a powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|fr=
ee]
>> >=20

<snip>

>> >=20
>> > And so on. Temporary build/test log is at
>> > https://git.altlinux.org/tasks/352218/build/100/ppc64le/log
>> >=20
>> > Other stable/longterm branches or other architectures does not exhibit=
 this.
>> >=20
>> > Thanks,
>>=20
>> Hi all - this just took down a production server for me, on POWER9 bare
>> metal.  Not running tests, just booting normally, before services even c=
ame
>> up.  Had to perform manual restoration, reverting to 6.6.36 worked.  Als=
o
>> running 64k kernel, unsure if it's better on 4k kernel.
>>=20
>> In case it's helpful, here's the log from my boot:
>> https://dpaste.org/Gyxxg/raw
>=20
> Ok, this isn't good, something went wrong with my backports here.  Let
> me go revert them all and push out a new 6.6.y release right away.

I think the problem is that the series adding support for bpf prog_pack=20
was partially backported. In particular, the below patches are missing=20
from stable v6.6:
465cabc97b42 powerpc/code-patching: introduce patch_instructions()
033ffaf0af1f powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_p=
ack
6efc1675acb8 powerpc/bpf: implement bpf_arch_text_copy

It should be sufficient to revert commit f99feda5684a (powerpc/bpf: use=20
bpf_jit_binary_pack_[alloc|finalize|free]) to allow the above to apply=20
cleanly, followed by cherry picking commit 90d862f370b6 (powerpc/bpf:=20
use bpf_jit_binary_pack_[alloc|finalize|free]) from upstream.

Alternately, commit f99feda5684a (powerpc/bpf: use=20
bpf_jit_binary_pack_[alloc|finalize|free]) can be reverted.


- Naveen


