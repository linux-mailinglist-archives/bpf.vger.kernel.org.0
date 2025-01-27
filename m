Return-Path: <bpf+bounces-49853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DA2A1D55A
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 12:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2231887A1C
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44561FECC9;
	Mon, 27 Jan 2025 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="l5jrvOWL"
X-Original-To: bpf@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE52647;
	Mon, 27 Jan 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977549; cv=none; b=YYjeJ0jEGSPqMxeveJ9kEd7uUfkLr4LnF86XsowHOrH0G37AhC+3l6XmnWHuqQIpHEQtT2TXDAo5yrhomaRtCVrVXRqiG/hoOV5sS3Hfc2cig2s2rSHRoE0UGg4APESU41rJhULS15+nfWPa1EqRJFtPKoP5XHJiBfWD56fZqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977549; c=relaxed/simple;
	bh=mMwgzU0qB1jXi43ww+rCOS5ZwHoB0iRetm/NwBsm4G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmmyA7jj19FTD7BhDlrXMD96OGbVH0ymxeWid89yONGU4BEVlQqnZevV//7CuoNFVcyBajteIY/nUPwAzRpnDmplryaqiJrAhoEljaZMIWQmY4XB94f1Jp9A+woyZ3Pzh7hr9YCGkkU91l2/XDrHhDbIZpWsoiqo9Z4CMfiUrtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=l5jrvOWL; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1737977541; bh=mMwgzU0qB1jXi43ww+rCOS5ZwHoB0iRetm/NwBsm4G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5jrvOWLvSOjXrpTHOkJ0ca7oCu76sQU0rIevmBu7gT1mPRWQmRhwacUCHb3GpREv
	 xTfRMSuGO/Uf/YjEhV+s9SvuOm+oZjRKncV8mARXp0eHz4ilJuVQDJ1qu1wfsygfkm
	 FzIJ07fqEBvtk0wniN0blzAS5SpdJDDzgIhe/SRI=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.52.1)
	(envelope-from <n.schier@avm.de>)
	id 67976ec5-35e9-7f0000032729-7f0000018224-1
	for <multiple-recipients>; Mon, 27 Jan 2025 12:32:21 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 27 Jan 2025 12:32:21 +0100 (CET)
Received: from l-nschier-nb (unknown [IPv6:2001:9e8:9fa:e101:5fb1:76a5:fd66:46b3])
	by mail-auth.avm.de (Postfix) with ESMTPSA id 1A03F808E0;
	Mon, 27 Jan 2025 12:32:21 +0100 (CET)
Date: Mon, 27 Jan 2025 12:32:19 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ruowen Qin <ruqin@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] samples/hid: remove unnecessary -I flags from
 libbpf EXTRA_CFLAGS
Message-ID: <20250127-mottled-lean-waxbill-6fd7a1@l-nschier-nb>
References: <20250123081950.173588-1-jinghao7@illinois.edu>
 <20250123081950.173588-2-jinghao7@illinois.edu>
 <20250127-military-salamander-of-fame-3f6e1e@l-nschier-nb>
 <d2f8f530-2e31-4ddd-a743-35c7f0c48199@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2f8f530-2e31-4ddd-a743-35c7f0c48199@illinois.edu>
X-purgate-ID: 149429::1737977541-E8C54833-65997A4D/0/0
X-purgate-type: clean
X-purgate-size: 1202
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

On Mon, Jan 27, 2025 at 03:37:56AM -0600, Jinghao Jia wrote:
> On 1/27/25 3:29 AM, Nicolas Schier wrote:
> > On Thu, Jan 23, 2025 at 02:19:49AM -0600, Jinghao Jia wrote:
> >> Commit 5a6ea7022ff4 ("samples/bpf: Remove unnecessary -I flags from
> >> libbpf EXTRA_CFLAGS") fixed the build error caused by redundant include
> >> path for samples/bpf, but not samples/hid.
> >>
> >> Apply the same fix on samples/hid as well.
> >>
> >> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
> > 
> > I can't see a relation between this patch and the referenced commit.
> > Can you please check whether the 'Fixes' is (still?) valid here?
> > 
> > Kind regards,
> > Nicolas
> > 
> 
> The 'Fixes' is from commit 5a6ea7022ff4 ("samples/bpf: Remove unnecessary
> -I flags from libbpf EXTRA_CFLAGS") that fixes the equivalent issue in
> samples/bpf --- according to its commit message, commit 13b25489b6f8
> ("kbuild: change working directory to external module directory with M=")
> is the commit that breaks the libbpf build in the samples.

ah sorry, I should have read 5a6ea7022ff4 before.  Thanks for
clarification.

Kind regards,
Nicolas

