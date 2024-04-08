Return-Path: <bpf+bounces-26205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C10E89CA6E
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 19:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7843B29F4B
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2955C14387A;
	Mon,  8 Apr 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB7ijO4Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDF142E68;
	Mon,  8 Apr 2024 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596172; cv=none; b=StguFbbGqEVLpHufMXfh4Ab6P3E7If4QGGp4sZ9o9bOn/1YN+S7kGH0e+TnW8Sax5WMulyFgGy7fTkBi8mK7RAAZb+FQcsXJ/CmUR4uazrcKgb7euIL72tTn4BvZqswRSiqdpGFWAhe5uYJpfgJo8FcCn6aN993ZT0W5qWYvxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596172; c=relaxed/simple;
	bh=FXRh4NT4mgAmM5SWmhxzWE8ppnsO/CEI3gx+kEY5Y88=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Yf4TigOdhc6gLRkrMyyi41KoPsLn5vFcu0DQiAS0Rh2SCCHRdwrkCfdtfBPoQgmMIoVqZRE36wHjez4BWFIv2j0ViPchEXJtzT4A5KT42/2/EqNf6Tu7U7im4onebsq/WrcEK188fkZwMfAb4PjiyHfQjQaD0Eyo6GnLjzsu7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB7ijO4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DCCC433F1;
	Mon,  8 Apr 2024 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712596172;
	bh=FXRh4NT4mgAmM5SWmhxzWE8ppnsO/CEI3gx+kEY5Y88=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=BB7ijO4Q3/URZEptPIUEWBlcudWmK2jw7NdXZ6/LpEgJTYcFzY1OXa4ftqrmI+AtG
	 qNeUCiJCP8WwztAcGqauws/pRzmBxOifz3db2LcOLa+IzGkIOtdD5zhJ668pbaQPVv
	 98MKQLmLDEPtGCg6P7QG2XLIFJKtHLvfCjdAXsai7gubXYc2LHz2Kl3jN1C80dPWwz
	 GgiPe14JfOeSVAfxkWBA8T6xjxLoIXlo8p0iEOr8QvH+mjIRzmiZJUl/p8R76FTN6n
	 vl0+DCm7s6gXbmdry7HK1o6btvU1aOws8RpBhv/SN2A7Pqp3vA/MDk7rj3J8n/7teS
	 T/xB8/YGgZz2g==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH bpf-next v2 2/7] bpf, lsm: Add return value range
 description for lsm hook
From: KP Singh <kpsingh@kernel.org>
In-Reply-To: <20240325095653.1720123-3-xukuohai@huaweicloud.com>
Date: Mon, 8 Apr 2024 19:09:25 +0200
Cc: bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Florent Revest <revest@chromium.org>,
 Brendan Jackman <jackmanb@chromium.org>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FAC6C1E-B0C2-4743-AFF0-0DCC2B331D0A@kernel.org>
References: <20240325095653.1720123-1-xukuohai@huaweicloud.com>
 <20240325095653.1720123-3-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 25 Mar 2024, at 10:56, Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>=20
> From: Xu Kuohai <xukuohai@huawei.com>
>=20
> Add return value descriptions for lsm hook.
>=20
> Two integer ranges are added:
>=20
> 1. ERRNO: Integer between -MAX_ERRNO and 0, including -MAX_ERRNO and =
0.
> 2. ANY: Any integer


I think you should merge this patch and the first patch. It's not clear =
that the first value in this macro is actually used as the default value =
until one reads the code. I think you also need to make it clear that =
there is no logical change on the LSM side in the this patch.

- KP=

