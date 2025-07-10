Return-Path: <bpf+bounces-62957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123CB00AE0
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 19:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F477614E6
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 17:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9302F2C74;
	Thu, 10 Jul 2025 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH8ydHhN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8F2F2C59;
	Thu, 10 Jul 2025 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170080; cv=none; b=DdzNlJl64B131kSEw1j9KW15NyDsIB2r4Mkmf4rKRxqQp34JeGUga52ALGazJzbsxO02MsFGlCjD7q7EZsuJHV+NkGvaxg2aP40YSC+j90lWLoi7UsV7Due925S4RXSuQt71uKs5Jf6+90jf1cxSmixKPFT/mujD/mJONIvHG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170080; c=relaxed/simple;
	bh=WkU7E2CZARwcXaf0IgqnfXY/Ezervcn4VvuyojcVVlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emcA/OOlBoFWUVhJoBloO99CR2ZKhc8ZdnHpc1EyQZjU8MZe7WqcRvHUq9GpDh1rj0lD+j9cRUm2SlvHCT1L6MyD5lIBPbDKm13UOa5Tk66Q4E/Bix/k8y4RYvFoyL9O38Sie3uKTNk2iY4hfB/R0ASkTrLjacgXC40vFKDAxU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH8ydHhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E2BC4CEF4;
	Thu, 10 Jul 2025 17:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752170080;
	bh=WkU7E2CZARwcXaf0IgqnfXY/Ezervcn4VvuyojcVVlY=;
	h=From:To:Cc:Subject:Date:From;
	b=AH8ydHhNikqbhoQ0jIe2bmbWG3x0XxoVTHpa+UQewZgBP0Alua3Q2H6pQL85PGbQw
	 HnbHrm3PXSLnevwKtivLPp2Oq8DSyzfT0nTrXriBmUynHeB2y1js1pXk7Fi3J43n/8
	 C26n3ZJworioY3+p8oMgGVl8BIQPxaMyeIBMZxV9+W95xRIKmVcdT/Q7AwpWqvOzNP
	 9rKFDdG8s1SR0SS/7M9OVR7mu4pFJ9EitT0k9TGMWpsbarz4xNgO/oPRm0rpDo7ntM
	 SrMBreqO6Y/jnGelGjRnWKkgVuBcGwuDWoDppsujAF1xPvE0ecx3+m2C6yYiH1WF3C
	 cznQZjFxnHZWA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: [PATCH bpf-next 0/1] A tool to verify the BPF memory model
Date: Thu, 10 Jul 2025 17:54:32 +0000
Message-ID: <20250710175434.18829-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am building a tool called blitmus[1] that converts memory model litmus
tests written in C into BPF programs that run in parallel to verify that the
JITs are enforcing the memory model correctly.

With this tool I was able to find a bug in the implementation of the smp_mb()
in the selftests.

Using the following litmus test:

C SB+fencembonceonces

(*
 * Result: Never
 *
 * This litmus test demonstrates that full memory barriers suffice to
 * order the store-buffering pattern, where each process writes to the
 * variable that the preceding process reads.  (Locking and RCU can also
 * suffice, but not much else.)
 *)

{}

P0(int *x, int *y)
{
        int r0;

        WRITE_ONCE(*x, 1);
        smp_mb();
        r0 = READ_ONCE(*y);
}

P1(int *x, int *y)
{
        int r0;

        WRITE_ONCE(*y, 1);
        smp_mb();
        r0 = READ_ONCE(*x);
}

exists (0:r0=0 /\ 1:r0=0)

Running the generated program on an ARMv8 machine: 

With the current implementation of smp_mb():

    [root@fedora blitmus]# ./sb_fencembonceonces
    Starting litmus test with configuration:
      Test: SB+fencembonceonces
      Iterations: 4100
    
    Test SB+fencembonceonces Allowed
    Histogram (4 states)
    4545     *>0:r0=0; 1:r0=0;
    20403742 :>0:r0=0; 1:r0=1;
    20591700 :>0:r0=1; 1:r0=0;
    13       :>0:r0=1; 1:r0=1;
    Ok
    
    Witnesses
    Positive: 4545, Negative: 40995455
    Condition exists (0:r0=0 /\ 1:r0=0) is validated
    Observation SB+fencembonceonces Sometimes 4545 40995455
    Time SB+fencembonceonces 8.33
    
    Thu Jul 10 16:56:41 UTC

Positive witnesses mean that smp_mb() is not working as
expected and not providing any ordering.

After applying the patch to fix smp_mb():

    [root@fedora blitmus]# ./sb_fencembonceonces
    Starting litmus test with configuration:
      Test: SB+fencembonceonces
      Iterations: 4100
    
    Test SB+fencembonceonces Allowed
    Histogram (3 states)
    19657569 :>0:r0=0; 1:r0=1;
    20227574 :>0:r0=1; 1:r0=0;
    1114857  :>0:r0=1; 1:r0=1;
    No
    
    Witnesses
    Positive: 0, Negative: 41000000
    Condition exists (0:r0=0 /\ 1:r0=0) is NOT validated
    Observation SB+fencembonceonces Never 0 41000000
    Time SB+fencembonceonces 9.58
    
    Thu Jul 10 16:56:10 UTC

0 positive witnesses mean that invalid behaviour is not seen and smp_mb()
is ordering the operations properly.

I hope to improve this tool more and use it to fuzz the JITs of ARMv8,
RISC-V, and Power and see what other bugs can be exposed.

[1] https://github.com/puranjaymohan/blitmus

Puranjay Mohan (1):
  selftests/bpf: fix implementation of smp_mb()

 tools/testing/selftests/bpf/bpf_atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.1


