Return-Path: <bpf+bounces-70271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63707BB5CCF
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 04:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C69DF4E989E
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 02:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF6242D91;
	Fri,  3 Oct 2025 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NDq4AvRw"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93F2D0C8A
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458340; cv=none; b=ggnNem2McSblfUQ6ZGKZOP4LkStjbO5ea8KgcxV0GD/mQvDTBdxLfyaN8LpMzcX7b2KX7ahXaOAwf8Xgb9vXfYoUtjiQZ0V7InNUG0be93jKaaKFdFFD+AZ+1Ikw7VOiYQchg22cYHIWkebdySMkT1LdCyesZ8Hi58Qc+WOjqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458340; c=relaxed/simple;
	bh=GD6VrInVVdH2NlN9EQq+idRiGAyq1oxsK2ZXZOnBtBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8Dx4EgkIAk6QHhXNafDsw8AiVgZ7J+WYSAGJILy1WL1i86HzPh9zsTA9NmP/cz+rQVVfypq9SNrVhSGbY1oFvzWeZZ09B/4+9qV+zcU2P5RCrqpykKVwKV1v2I1IopMFpyGAyRg2HZu6NRzm5odQW0sj7Hoh8GTCh+iHr5NpJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NDq4AvRw; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <53799ac8-7cb0-40df-96ca-7d1da039981c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759458335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yoG1RXF4ryOJPC0FxXE2ZgGYQ7y0FveTUADHN56GcE=;
	b=NDq4AvRwFmjH28loO6VT1/2OpyYA5YAd1W4CY8xLBnAordbFT85Zd083t1dFBhi+L28Ks4
	eackNIZ6TAMTGMnb20DwCsIxXiIfK9lXiyEwgB+/kwIkh1qr57aFlUx+Na6nfsELp81Qn7
	51piO7IldBVroE7LCc04b64Ji3UInYg=
Date: Fri, 3 Oct 2025 10:25:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v3 04/10] bpf: Add common attr support for
 prog_load
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251002154841.99348-1-leon.hwang@linux.dev>
 <20251002154841.99348-5-leon.hwang@linux.dev>
 <CAADnVQ+WcMp5bgw_hHON+unufO=Mm5f7Em2kUeqmkyBZwMU0nQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+WcMp5bgw_hHON+unufO=Mm5f7Em2kUeqmkyBZwMU0nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/10/25 07:51, Alexei Starovoitov wrote:
> On Thu, Oct 2, 2025 at 8:49 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>> +
>> +       if (!attr->log_buf && common_attrs->log_buf) {
>> +               *log_common_attrs = true;
> 
> I feel like a broken record.
> Do not use 'bool' arguments. There is always a better option.
> 'bool *' is even worse.

Got it — I now understand that using 'bool' here (especially as a
pointer) is a code smell and generally discouraged.

I'll remove log_common_attrs and reimplement this part to avoid the
'bool' argument altogether. I'll look for a cleaner alternative in the
next revision.

Thanks,
Leon

