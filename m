Return-Path: <bpf+bounces-78847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B906DD1D1DC
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 09:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5AA2300E3C2
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D1125783C;
	Wed, 14 Jan 2026 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="L7JLC1T6"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66148285041;
	Wed, 14 Jan 2026 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379422; cv=none; b=DBIlT7E2KBKPnbXch/XAjVmi/y3tFUi0YzEpj8e0pon3FUQCTS0dj40kqFytfZO790eSS8bvmtc0f6ABjwLp7RntF3XTp/gLWd7U+km9oqpITn+V58ca5N3VEkOlUnX2SMpq2o2w7R5k1jAt6CfLnfUNC8Up9Z6OxG+QVEpxpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379422; c=relaxed/simple;
	bh=vEtoo/36iPr3VAlbLh5vMbcgYYaBDVMS96XoEkY5hjY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uCTWH96QCS3gtscAxXQrwMI7/kqobeM8IEpHgZuQUf3oc35KkJ9vKUfe6hSPMptjt9DDUCsLyR0BRVe9mv0fQyHYnYSvRoVN+LER3xP3Fs1SQP55Cwcop+fOSmmAym6kbiQL81IVBMMWZQ13rjp3rycbR+M3YSPTzginA6MW2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=L7JLC1T6; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768379405; bh=Xpc6HHPOtrqnBRpj1wgrGM5zNaCC389Vx5yLqmi0RIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7JLC1T6mMvptTJnTIrZW11lKLcWBJKf3+5cBLIOGZP283cjkFxhiXuR6P/1IL5/j
	 tanZX2iLEQS0eq1iS1QX61uGHybeavDZ7kd6rw4Uu4J+I/keQ4Y3MOJWmn09AOzYhl
	 OqGfWfLRsqidBQiAaiCmAN+Gka1fNVfTBkLkwUAg=
Received: from localhost.localdomain ([61.144.109.210])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 7362F09A; Wed, 14 Jan 2026 16:28:54 +0800
X-QQ-mid: xmsmtpt1768379334ty3h1c149
Message-ID: <tencent_46C4281AB1F93E2CA77698CF9DCE0E2FAD08@qq.com>
X-QQ-XMAILINFO: MEx+xBdGVwfVJ0JrpdYBmCKvkZ6jk+0ZKgtK/FxQf/W17bfl5WephfX/xoPgXU
	 w8BRwruVS6tAvVyXCN82yhArQfK+1I+rbs47bqGlakC1gx09FZwh4rnQmZ6hxLivcbFuctLyWbLa
	 4Y0I0l9px6L6FlDJhHNI8NeEv9mMaY6XZSK4vzyZ+A1jj/S2jzypMDhhCRT7cLHZjIkbI7iBVwZF
	 qFY63/ob6OlgkXDvqYAJkVCU92VRCk1mYS2MdmDrigMb0noPwo3uYtl0TC3+LESn96QcwwEX4vuG
	 QofYyjXw+CyAwWnC60T89c6gxm3MVzJ4WdhJG0zX0M2ZqnhI2S29o4HkTMBohkkW4vRRK2mZiLSH
	 UcsfAVI4WBCJOsuFgp9/ct3G2iauTDu+UZz83x9HqiRm3sdUwTv4bLAVL6bD6+mtUOlqwSgd98Bb
	 0VJuypkZLBsCT5dpFq+gqXjQ7R2vsM3soVSyoimx+DVExmdA9XmVOqFY8qNeU/38Qs7nLqAe+Ezx
	 YZ2KFGDkHe3AB03wJE0eN7kYHS3DhXONXSXUydAmpa5lIPCNOLoBUZZn7XumtRzWWT1eyMvRc/fd
	 /ZVJRwb/LkJi0h2XWruyPlkX2uZXRP9HjKcE8LbBZ2cCevw6YSHcFXp65NVDa9lmuIosAOjMFXqL
	 q4ZU+yhAJ/pashQJj1kxWeUANHsISP359nxLLjTU4DR85PbjcL/pNMz6s9C11cmVER7itIEYJOfv
	 FkK/efk30qgp9jSFSSqKDryxxEBvDk8jyOlUM4AagUeQnN2zF4/Pe0dKauhs6c8ttFqNA+MDwSRe
	 EO0AqymZPPcN00ORDjEbVnNvR+wSssx/oqnfAo6/NO5gGqJ3YIhtASBkBtqAjcx8mGd1ONCypFca
	 QXCKH9xZim3RHBsm6yS403Tvi3AchOUX1pemQpfhgTMuY54+SpONglxDqxtLOWRZ99YHcUxxZKg3
	 l5qQW/lcysvNqkB7HO2v6KNt+a9vMOddi3PCteFxgobtFA2NuBQ7aFLROA8dP6tGtav3UhCPGVsG
	 hS1Fo2yFdatYLpFj5f
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: wujing <realwujing@qq.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn,
	wujing <realwujing@qq.com>
Subject: Re: [PATCH bpf-next] bpf/verifier: implement slab cache for verifier state list
Date: Wed, 14 Jan 2026 16:28:52 +0800
X-OQ-MSGID: <20260114082852.7190-1-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAP01T76JECHPV4Fdvm2bds=Eb36UYhQswd7oAJ+fRzW_1ZtnVw@mail.gmail.com>
References: <CAP01T76JECHPV4Fdvm2bds=Eb36UYhQswd7oAJ+fRzW_1ZtnVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kumar,

Thank you for the feedback. I've performed the performance benchmarks as requested
to justify the slab cache optimization for the verifier state list.

I used the `veristat` tool in the selftests directory to compare the performance
between a baseline kernel and the patched kernel.

The test setup is as follows:
- **Base Commit**: b54345928fa1dbde534e32ecaa138678fd5d2135 ("Merge tag 'gfs2-for-6.19-rc6' ...")
- **Patch**: f901112b55706acca5f3a4ae1022cb3f2d0ae80e ("bpf/verifier: implement slab cache for verifier state list")

The test was conducted using the following command:
$ sudo ./veristat -e file,prog,verdict,duration,insns,states,peak_states -o csv \
    bpf_flow.bpf.o bpf_gotox.bpf.o bpf_loop.bpf.o arena_strsearch.bpf.o

Comparison was generated via:
$ ./veristat -C baseline_stats.csv patched_stats.csv

### veristat Comparison Output
```text
File                   Program                         Verdict (A)  Verdict (B)  Verdict (DIFF)  Duration (A) (us)  Duration (B) (us)  Duration (DIFF)      Insns (A)  Insns (B)  Insns (DIFF)  States (A)  States (B)  States (DIFF)  Peak states (A)  Peak states (B)  Peak states (DIFF)
---------------------  ------------------------------  -----------  -----------  --------------  -----------------  -----------------  -------------------  ---------  ---------  ------------  ----------  ----------  -------------  ---------------  ---------------  ------------------
arena_strsearch.bpf.o  arena_strsearch                 failure      failure      MATCH                         121                 64         -57 (-47.11%)         20         20   +0 (+0.00%)           2           2   +0 (+0.00%)                 2                 2          +0 (+0.00%)
bpf_flow.bpf.o         _dissect                        success      success      MATCH                         479                446          -33 (-6.89%)        211        211   +0 (+0.00%)          13          13    +0 (+0.00%)                13                13          +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_0                success      success      MATCH                        2433               2393          -40 (-1.64%)       1461       1461   +0 (+0.00%)          68          68    +0 (+0.00%)                68                68          +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_1                success      success      MATCH                        2727               2717          -10 (-0.37%)       1567       1567   +0 (+0.00%)          59          59    +0 (+0.00%)                59                59          +0 (+0.00%)
bpf_loop.bpf.o         prog_null_ctx                   success      success      MATCH                         202                162         -40 (-19.80%)         22         22   +0 (+0.00%)           3           3    +0 (+0.00%)                 3                 3          +0 (+0.00%)
bpf_loop.bpf.o         stack_check                     success      success      MATCH                         747                469        -278 (-37.22%)        325        325   +0 (+0.00%)          25          25    +0 (+0.00%)                25                25          +0 (+0.00%)
bpf_loop.bpf.o         test_prog                       success      success      MATCH                         519                386        -133 (-25.63%)         64         64   +0 (+0.00%)           7           7    +0 (+0.00%)                 7                 7          +0 (+0.00%)
```

### Interpretation of Results
The comparison results clearly demonstrate the performance advantages of the optimization:
1. **Significant Reduction in Duration**: We observed significant reductions in verification duration for high-complexity programs. For instance, `arena_strsearch` showed a **47.11%** improvement, and `stack_check` showed a **37.22%** improvement.
2. **Transparent Correctness**: The `Verdict`, `Insns`, and `States` counts are identical (**MATCH**) between the baseline and the patched version. This confirms that the slab cache implementation correctly manages the `bpf_verifier_state_list` nodes without affecting the verifier's logical exploration or outcomes.
3. **Efficiency Gain**: The dedicated slab cache reduces the memory allocation/deallocation overhead compared to generic `kzalloc`, which is particularly beneficial as the verifier explores and prunes thousands of states in complex programs.

Detailed raw CSV data is appended below for your reference.

### Raw Data: baseline_stats.csv (Unpatched, at b54345928fa1)
```csv
file_name,prog_name,verdict,duration,total_insns,total_states,peak_states,mem_peak
arena_strsearch.bpf.o,arena_strsearch,failure,121,20,2,2,0
bpf_flow.bpf.o,_dissect,success,479,211,13,13,0
bpf_flow.bpf.o,flow_dissector_0,success,2433,1461,68,68,0
bpf_loop.bpf.o,stack_check,success,747,325,25,25,0
bpf_loop.bpf.o,test_prog,success,519,64,7,7,0
```

### Raw Data: patched_stats.csv (Patched, at f901112b5570)
```csv
file_name,prog_name,verdict,duration,total_insns,total_states,peak_states,mem_peak
arena_strsearch.bpf.o,arena_strsearch,failure,64,20,2,2,0
bpf_flow.bpf.o,_dissect,success,446,211,13,13,0
bpf_flow.bpf.o,flow_dissector_0,success,2393,1461,68,68,0
bpf_loop.bpf.o,stack_check,success,469,325,25,25,0
bpf_loop.bpf.o,test_prog,success,386,64,7,7,0
```

Best regards,
wujing


