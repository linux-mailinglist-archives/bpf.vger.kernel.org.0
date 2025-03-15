Return-Path: <bpf+bounces-54104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EB3A62D27
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 14:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D5617A4CF
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5E1F8BDC;
	Sat, 15 Mar 2025 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gwn9DVRn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94571DF964;
	Sat, 15 Mar 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742043651; cv=none; b=bUR5WLVvMyJjRwqCzUs2iLC4VzxT4jX81ABYg4w57LduUmjH9Km3eeCAX/uyPNYcxN0lSoxOfKjnggd3uaZ0BUC3tz6vLurkjPF7a7DH4G/IBwKcFrcjAFi6iCxWZBDxA3sxogxXgF7L7n5A0+/dYiN5YFVgFPW+iNKbedkxbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742043651; c=relaxed/simple;
	bh=WXG3nm9VTQNTwm5ptPPKtK7R9NwVj/dBEI+Nk7wKJRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWMSwtkL7pTKc/krpKcObVuCW4oD5BApYXcC1SI+wkYh/e+rg9tbwEcy9VcZAhkrDoNR87ZY08Qa172LqzhGUlQli7UEsQvVsrRQkcmQk4H/nDdZksRz6IlP9+1vyB6HGEGaU8rET/0FG6ASucsFlTnHjKXNQirXQI5CaSwvM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Gwn9DVRn; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742043650; x=1773579650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jqOXkuumBOlYORoc3RdeMLnYb4A6AmoaISyCTe+YEjA=;
  b=Gwn9DVRnIgMddR7hXVDW+Dbp2T+/CuvMhlIXOswWhjwx+s1F6ZtjwevU
   /tkY7QRK4fAnWPcLYPSz4UieUzwtT3Vy4EXboyqfY/sGP+ttZGdp8XpiD
   r8ezTjbDa8skWT5witwTyaFkqZhes82QEgmEjiExy7A5sDbLkwwWc4tV+
   A=;
X-IronPort-AV: E=Sophos;i="6.14,250,1736812800"; 
   d="scan'208";a="503054615"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 13:00:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:47751]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.34:2525] with esmtp (Farcaster)
 id 8f32fc71-a378-4960-a103-202bc15e229e; Sat, 15 Mar 2025 13:00:43 +0000 (UTC)
X-Farcaster-Flow-ID: 8f32fc71-a378-4960-a103-202bc15e229e
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Mar 2025 13:00:43 +0000
Received: from b0be8375a521.amazon.com (10.118.246.93) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Mar 2025 13:00:37 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <enjuk@amazon.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <eddyz87@gmail.com>, <haoluo@google.com>,
	<iii@linux.ibm.com>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kohei.enju@gmail.com>, <kpsingh@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <martin.lau@linux.dev>, <sdf@fomichev.me>,
	<song@kernel.org>, <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>,
	<yepeilin@google.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v1] bpf: Fix out-of-bounds read in check_atomic_load/store()
Date: Sat, 15 Mar 2025 21:59:39 +0900
Message-ID: <20250315130028.92105-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315082251.32679-1-enjuk@amazon.com>
References: <20250315082251.32679-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

>> ...
>>>  kernel/bpf/verifier.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>> 
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 3303a3605ee8..6481604ab612 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -7788,6 +7788,12 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
>>>  static int check_atomic_load(struct bpf_verifier_env *env,
>>>  			     struct bpf_insn *insn)
>>>  {
>>> +	int err;
>>> +
>>> +	err = check_reg_arg(env, insn->src_reg, SRC_OP);
>>> +	if (err)
>>> +		return err;
>>> +
>>
>>I agree with these changes, however, both check_load_mem() and
>>check_store_reg() already do check_reg_arg() first thing.
>>Maybe just swap the atomic_ptr_type_ok() and check_load_mem()?
>
>You're absolutely right. The additional check_reg_arg() introduces some 
>redundancy since check_load_mem() and check_store_reg() do that.

IMHO, in this specific case, I believe OOB is caused by invalid register 
number in reg_state(), so check_reg_arg() is too much and instead just 
checking register number before atomic_ptr_type_ok() is sufficient.

Although it's still somewhat redundant and not a fundamental solution, I 
think it would be better than doing whole register checking by 
check_reg_arg().

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3303a3605ee8..48131839ac26 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7788,6 +7788,11 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 static int check_atomic_load(struct bpf_verifier_env *env,
                 struct bpf_insn *insn)
 {
+	if (insn->src_reg >= MAX_BPF_REG) {
+		verbose(env, "R%d is invalid\n", insn->src_reg);
+		return -EINVAL;
+	}
+
    if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
        verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
            insn->src_reg,
@@ -7801,6 +7806,11 @@ static int check_atomic_load(struct bpf_verifier_env *env,
 static int check_atomic_store(struct bpf_verifier_env *env,
                  struct bpf_insn *insn)
 {
+	if (insn->dst_reg >= MAX_BPF_REG) {
+		verbose(env, "R%d is invalid\n", insn->dst_reg);
+		return -EINVAL;
+	}
+
    if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
        verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
            insn->dst_reg,

>I've revised the patch to simply swap the order and syzbot didn't trigger 
>the issue in this context.
>    https://lore.kernel.org/all/20250315055941.10487-2-enjuk@amazon.com/
> ...

Regards,
Kohei

