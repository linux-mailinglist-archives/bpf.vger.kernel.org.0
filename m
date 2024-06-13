Return-Path: <bpf+bounces-32072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B9906DE5
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 14:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1CE1C20B59
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DD114659D;
	Thu, 13 Jun 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="q1UZRfAP"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623C12C530
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280034; cv=none; b=jGqtrKDg2jeRZctHTPLIfBOPDw2uhfFNqZm8r+zD43Bx+QFE+uoFhRlHzP6ip8vK7eDm+NiBfVP3Fk/FYf3XNOP1+leOm5bqmoxR4uur51vb8ExpzVBNMmt+mNo3/wpoVETGiiancIsOCa4O6nGj2zREYQO254RL1Ye57pvbldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280034; c=relaxed/simple;
	bh=g2LVxO6kG2tt3Jnnc+OPQN3oKMrBQVNBpWB+ywRxEVo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BViuRdXHxWFT9ryYfPynWTilAJCQDA1TbTnvxKWFXxbgm/+dE7cojLmw3D22b3aAt3S3poXJISaeyIfRIx2QVd1IUT4RD9R5eoWeeAfOQioSM82LXdT4mMvBRBRHgdAhjiPYVNuZMZHIcTALUyE4GmmFFZEMBmapSHZqGN0Y0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=q1UZRfAP; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1vUE+XXIJruY+Yq7PpDzzpzillPOMyZq9xj4UdAYKLI=; b=q1UZRfAPBFZUCxjMwj9FIYK5xF
	gwXQ3CdDDpycufGz1DBd3XIXuXx00OdWa0DJZCkH8qY0Ht5qy9rC2fJgb0dQMHQ/WUnS+Hki1jvaM
	1BCxHt6JtdFXWTHXKhaMQWZR11uvzgu9xEv2B3USfgfgUJp/vizvOlxBmsn1cZ5mWZlberJaes4NB
	5phUMfuvwQnWNDS9bmyKvC7NnvSqF+eYmB+x3siH/kjZXCDp0sojfMyQcDCjRPhBPH9yYmnpGO1cM
	C/CnrY6tKWecAhEgjFlo9FTcwXJK+BILEMuKfR1fdNqQR1aBEBbYAmXgxbIPGU17U6gbHCjZVIMNx
	4o4novXQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHj82-000GoR-Lm; Thu, 13 Jun 2024 14:00:30 +0200
Received: from [178.197.249.34] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHj82-0001ka-0I;
	Thu, 13 Jun 2024 14:00:30 +0200
Subject: Re: [PATCH bpf 1/2] bpf: Fix reg_set_min_max corruption of fake_reg
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, jjlopezjaimez@google.com
References: <20240612221405.3378-1-daniel@iogearbox.net>
 <CAADnVQJgFWciD8tgtzq=Pv56Dz+pre3eJtOi_xWca1ZZAQQnmA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <11f76e55-f98d-37d1-99d6-9f4ebdf32f88@iogearbox.net>
Date: Thu, 13 Jun 2024 14:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJgFWciD8tgtzq=Pv56Dz+pre3eJtOi_xWca1ZZAQQnmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27305/Thu Jun 13 10:33:25 2024)

On 6/13/24 1:13 AM, Alexei Starovoitov wrote:
> On Wed, Jun 12, 2024 at 3:40 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
[...]
>> Fixes: 67420501e868 ("bpf: generalize reg_set_min_max() to handle non-const register comparisons")
>> Reported-by: Juan José López Jaimez <jjlopezjaimez@google.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   kernel/bpf/verifier.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 36ef8e96787e..366b312203d2 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -15112,8 +15112,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>>          struct bpf_verifier_state *other_branch;
>>          struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
>>          struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
>> +       struct bpf_reg_state fake_reg1 = {}, fake_reg2 = {};
> 
> That's too much stack increase.
> Even a single reg on the stack is a bit high.

Hm, agree 120 bytes.. we can actually move it away from stack altogether
into env. I found another such location as well where stack can be reduced.
Updated in v2, thanks!

