Return-Path: <bpf+bounces-70397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 729F6BB9580
	for <lists+bpf@lfdr.de>; Sun, 05 Oct 2025 12:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F5EE3458B2
	for <lists+bpf@lfdr.de>; Sun,  5 Oct 2025 10:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB819D8AC;
	Sun,  5 Oct 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="wTjLjynt"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAD717A2EB
	for <bpf@vger.kernel.org>; Sun,  5 Oct 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759659886; cv=none; b=kcXNhra8DzTM5030L8islQPvGCnYtG7omns7VFnMsCjmdqGjE/5cxcVT+wixHvBDRJrY4T2/Ta/dfGTxDqJTmewJ40rVf5FQM/2yAgEKO2gAYzsAX3UuTNNVBUO520JFxxdDUN68G7ofPXdMAhrAECUx4tt3k2s8w8NeLywig1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759659886; c=relaxed/simple;
	bh=PZQgm1mcxLirxmzsFVR6VYtTv5PG45Ciohd/pqZTPrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LdGk4aiP2GBikggNFQD0wyGKpy+aata4UzcBLrQvk351QkeRUzeUJuONisZmInkkm0Fna9gGzMHWIDbB2TWSc+YJuayhy+Bx0w1560DKKEU+spdeS25U+9EXajpZ+8S0eVBLDfEecYq6hJ3NiEoZysSmuAb1egsy85gUolf5huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=wTjLjynt; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1759659874; bh=PZQgm1mcxLirxmzsFVR6VYtTv5PG45Ciohd/pqZTPrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=wTjLjynt8OqQy2Qv5AUHsfG0tWAiGWsS+6cNywkL2/WRc/RljAMWAVk2hRXrBdPQ5
	 CzvqHmpddZ3fnl4WIpdmQvUsr0Qr8wNejc7ho8xiKefrxtBvrgQL23sGdmlOj7VDnY
	 Q9kL7vFR15mFLWjW1PJnj6Ot33HwFrGR6ZXf3KgPBlzlrxiTE6GzINyt9H2NeDaNcb
	 1XocPkjgIPPpG/tSBaTymnPIw3GvldaY2zfT+Schh+vytDO4hGgYlmbVHh6yyLpmdP
	 9ciFFkeg6nB83LLZVUL89F+O2OYCWAim8EGzu0cEUWWmNLQZMc72kukC0k4qdqXyDs
	 vIMMHRGEsd1DA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4cfdmy2Tytz1y9F;
	Sun,  5 Oct 2025 12:24:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3632:e00:f174:1ae7:eb66:61e6
Received: from localhost (unknown [IPv6:2001:9e8:3632:e00:f174:1ae7:eb66:61e6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19skQKmS7HssjiV0hEv1Sej4/btFRpaGes=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4cfdmv5Dqkz1y8K;
	Sun,  5 Oct 2025 12:24:31 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Tiezhu Yang <yangtiezhu@loongson.cn>,  bpf
 <bpf@vger.kernel.org>
Subject: Re: Some unpriv verifier tests failed due to bpf_jit_bypass_spec_v1
In-Reply-To: <878qhr69jb.fsf@fau.de> (Luis Gerhorst's message of "Fri, 03 Oct
	2025 21:59:52 +0200")
References: <CAEyhmHTvj4cDRfu1FXSEXmdCqyWfs3ehw5gtB9qJCrThuUy2Kw@mail.gmail.com>
	<878qhr69jb.fsf@fau.de>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 05 Oct 2025 12:24:30 +0200
Message-ID: <87plb17ijl.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luis Gerhorst <luis.gerhorst@fau.de> writes:

> Some test still fail because the '#ifdef SPEC_V1' is still missing for
> them. I will prepare a patch to resolve this.

I now tried around a little and in conclusion I think it would be best
for you to instead disable unpriv tests by adding a 'return -1' for
LoongArch/PowerPC (the only archs setting bpf_jit_bypass_spec_v1) in
get_mitigations_off().

Using SPEC_V1 to also test that certain errors do not occur on archs
like LoongArch gets complicated pretty quickly. This is because we then
have to also set SPEC_V1 on archs that do not have
bpf_jit_bypass_spec_v1() set (e.g., s390x) to test load failure/success
correctly. Also, we still have to disable unpriv tests for PowerPC
(because jit_bypass_spec_v1 is dynamic there), and we have to change
SPEC_V1/xlated tests to take thing like zext into consideration to make
them work on s390x. I tried everything except for the zext stuff, see
the series sent in reply to this.

Currently, '#ifdef SPEC_V1' is only used to add additional __xlated
tests for x86/ARM, not to determine the load failure/success expected.
Therefore, this complexity is currently avoided.

