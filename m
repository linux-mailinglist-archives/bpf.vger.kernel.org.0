Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0CE488F01
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 04:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiAJDrQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Jan 2022 22:47:16 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:53593 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiAJDrP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Jan 2022 22:47:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JXKX14swqz4xdd;
        Mon, 10 Jan 2022 14:47:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1641786434;
        bh=LocqTwodVt/kEQFBOJj7f+zi/hSB5CLQZtSRLVFk1tE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZkBdaF0X/WBOyJ09Fjgh14uY1B9II8rI2zb8mSCwBYeJnuNEabENAtIWOc9SA8iNj
         F9L3KnZ+m609lxj/Seb/ldNDHGULzK7ftZi15Mb1RnjQqXIt2cm+rD9vnzY2gtViT0
         LNSznOChEZkcXrpkvoRYAN34F/+InBlW2Ydbv5UoJPuSU5Cqvmw1DM//ZA6DgPwPDz
         I8DJgzoy6JDDwDOeU/e+HSBtwK3ZFs+S3JZolggjwA07jcCBLKDqCSMZYBYNHHzWvI
         Nwh2hC7oya6m/n6uthyV7k6o0EL91rLiSBQI0sa0yPuw3RZPuJrH32N7OYbF8AoBmN
         QxmS3+CpG3Vdg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Hari Bathini <hbathini@linux.ibm.com>,
        johan.almbladh@anyfinetworks.com, Jiri Olsa <jolsa@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, song@kernel.org, ykaliuta@redhat.com
Subject: Re: [PATCH 00/13] powerpc/bpf: Some fixes and updates
In-Reply-To: <4893ddd3-f0ef-003b-3445-57ce5dc1b065@iogearbox.net>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
 <f4f3437d-084f-0858-8795-76e4a0fa5627@iogearbox.net>
 <1641540707.ewk8tpqmvl.naveen@linux.ibm.com>
 <4893ddd3-f0ef-003b-3445-57ce5dc1b065@iogearbox.net>
Date:   Mon, 10 Jan 2022 14:47:12 +1100
Message-ID: <875yqs2qwv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:
> On 1/7/22 8:36 AM, Naveen N. Rao wrote:
>> Daniel Borkmann wrote:
>>> On 1/6/22 12:45 PM, Naveen N. Rao wrote:
>>>> A set of fixes and updates to powerpc BPF JIT:
>>>> - Patches 1-3 fix issues with the existing powerpc JIT and are tagged
>>>> =C2=A0=C2=A0 for -stable.
>>>> - Patch 4 fixes a build issue with bpf selftests on powerpc.
>>>> - Patches 5-9 handle some corner cases and make some small improvement=
s.
>>>> - Patches 10-13 optimize how function calls are handled in ppc64.
>>>>
>>>> Patches 7 and 8 were previously posted, and while patch 7 has no
>>>> changes, patch 8 has been reworked to handle BPF_EXIT differently.
>>>
>>> Is the plan to route these via ppc trees? Fwiw, patch 1 and 4 look gene=
ric
>>> and in general good to me, we could also take these two via bpf-next tr=
ee
>>> given outside of arch/powerpc/? Whichever works best.
>>=20
>> Yes, I would like to route this through the powerpc tree. Though patches=
 1 and 4 are generic, they primarily affect powerpc and I do not see confli=
cting changes in bpf-next. Request you to please ack those patches so that =
Michael can take it through the powerpc tree.
>
> Ok, works for me. I presume this will end up in the upcoming merge window
> anyway, so not too long time until we can sync these back to bpf/bpf-next
> trees then.

Hmm. This series landed a little late for me to get it into linux-next
before the merge window opened.

It's mostly small and includes some bug fixes, so I'm not saying it
needs to wait for the next merge window, but I would like it to get some
testing in linux-next before I ask Linus to pull it.

When would you need it all merged into Linus' tree in order to sync up
with the bpf tree for the next cycle? I assume as long as it's merged
before rc1 that would be sufficient?

cheers
