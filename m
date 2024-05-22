Return-Path: <bpf+bounces-30342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF08CC8F7
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 00:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E63B1F21CE6
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ACB148305;
	Wed, 22 May 2024 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHKpYa7T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EA1474BE;
	Wed, 22 May 2024 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716416375; cv=none; b=IDxPdVR+MScmDGCGg78WCCEwojJ2HrYKzk1Rgb4Pt6YTMpOrwVm0x2P/sWARSXk7dw+hjZc/OIsfZ9L8/KNYQWbz9QpR7VR53Tchd8ImU7Sh3qW2CAn5ApLcXdAMX0nuMqFs8YxXaF6kF3RpvluLcudxyB6sdy77fLSNCIe3v/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716416375; c=relaxed/simple;
	bh=9Gp8ARWt+LlbhxAZ1UqjpmYMBLgcgTXITVrydyGORUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/QG4W04JJk0NDI2CU1eTPiEHMEdzD+mFBPKrKtqeHZdgy3mghRO4uEdu6dQTCzfeYiGcGQ8BytDT+j0HSqSrPlnu73MP36buhdPj8HlbrdYxZciN9UmOVwtMvPFKqwhAUumzdbE5ngxByd+EBxF0SIrIeKdC7dQvCa4op3YgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHKpYa7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3201FC2BBFC;
	Wed, 22 May 2024 22:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716416375;
	bh=9Gp8ARWt+LlbhxAZ1UqjpmYMBLgcgTXITVrydyGORUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RHKpYa7TbtWSJG1vNWcBKi+yR7pTJVMPf0rYI+FTCJ0I6aq4eXx1hCJrcsqDn8wnP
	 mr7WBi6Jn/CnGJu6Btoz1R7sovDGnjkEhnJ8aSuDj0R8WDU3GL3mQSatqmC9Jn342N
	 t09xo4ZnvD1ytEMZkkKPIEx7Ea5Am4qKP7vZpKlCG2yyb7ZXSMOEKT+JdgIqCc0DRQ
	 7Wm4NqPEMZZZ9fmunGVmowpPZBTejgzzKdy4pN/dhinIuxL1Es+d7DMJkKdMeWL0mM
	 RXMDTVKU53zNxdPfJ1+ZLUvtZDeqGaKCCVs9+IE4I+EVej+cRou4NrvJpyiRgKqFyK
	 cZogCn1FpTZTw==
Date: Wed, 22 May 2024 15:19:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Network Development
 <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>,
 Anjali Singhai Jain <anjali.singhai@intel.com>, "Limaye, Namrata"
 <namrata.limaye@intel.com>, tom Herbert <tom@sipanda.io>, Marcelo Ricardo
 Leitner <mleitner@redhat.com>, "Shirshyad, Mahesh"
 <Mahesh.Shirshyad@amd.com>, "Osinski, Tomasz" <tomasz.osinski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Vlad
 Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, Khalid Manaa
 <khalidm@nvidia.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, "Daly, Dan"
 <dan.daly@intel.com>, Andy Fingerhut <andy.fingerhut@gmail.com>, Chris
 Sommers <chris.sommers@keysight.com>, Matty Kadosh <mattyk@nvidia.com>, bpf
 <bpf@vger.kernel.org>, lwn@lwn.net
Subject: Re: On the NACKs on P4TC patches
Message-ID: <20240522151933.6f422e63@kernel.org>
In-Reply-To: <CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
	<41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
	<CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
	<CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
	<87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
	<CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
	<CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
	<82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
	<CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
	<CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
	<CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
	<CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jamal!

On Tue, 21 May 2024 08:35:07 -0400 Jamal Hadi Salim wrote:
> At that point(v16) i asked for the series to be applied despite the
> Nacks because, frankly, the Nacks have no merit. Paolo was not
> comfortable applying patches with Nacks and tried to mediate. In his
> mediation effort he asked if we could remove eBPF - and our answer was
> no because after all that time we have become dependent on it and
> frankly there was no technical reason not to use eBPF.

I'm not fully clear on who you're appealing to, and I may be missing
some points. But maybe it will be more useful than hurtful if I clarify
my point of view.

AFAIU BPF folks disagree with the use of their subsystem, and they
point out that P4 pipelines can be implemented using BPF in the first
place.
To which you reply that you like (a highly dated type of) a netlink
interface, and (handwavey) ability to configure the data path SW or 
HW via the same interface.

AFAICT there's some but not very strong support for P4TC, and it
doesn't benefit or solve any problems of the broader networking stack
(e.g. expressing or configuring parser graphs in general)

So from my perspective, the submission is neither technically strong
enough, nor broadly useful enough to consider making questionable precedents
for, i.e. to override maintainers on how their subsystems are extended.

