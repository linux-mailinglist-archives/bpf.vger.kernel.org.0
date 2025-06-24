Return-Path: <bpf+bounces-61438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B60BAE711C
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3657A39D6
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 20:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8A2EBDC8;
	Tue, 24 Jun 2025 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VIFaYh/v"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453B2EAD02
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798399; cv=none; b=Qn6mYacnBbb7vJAg1lrh+sOU9fminxNLWxkLYWLcdSui0ZkdpHraqPkXft4J/81sNGiNTctX+I5E6blzEbyRkEEtNHtUterNe/gpCuhRcnOXvhB1+Nef1PUZRJOcP6AxK8oc44m4nZ7J5cBcjvdOniyJGaB28tPKf6uF+C2kWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798399; c=relaxed/simple;
	bh=zKt65oCuxbPXw2yaHPdEpx5laRk8Pofpa78iTrtBx9g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZXrOtZMcCBh/0kORxDg1AHNXnWOrbpht2FRK0zFu4ICFCpKQXDUMqdbNMnN93k4ba7XRf0jX1QIshHgbwGQtQuJBgyoB1ydlfq7SRi8x5EJJJpdAuiTWN7u5icraQINqrlyZ7RR+zOPX6J5jk0c4YMN4bySvXE1AWb9IqFOLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VIFaYh/v; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OKq35f031371
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 13:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:reply-to:subject:to; s=s2048-2021-q4; bh=w4ERkWx0y
	AHAA+diOOCmhdy3cQHmNrGkIfsDV2wuvOM=; b=VIFaYh/v7DsUvNIagyXjlmvjo
	hpzoDl5+mVg2ieR/0gnVr2XyWLxa1fnyYUqe6JlS7hJj4xrtf5srnWeTjM6Elpf7
	EppK2+VxRUxowcHuY7Fdw0Uuap4HTDBVMCypJwdp1gd+TdM/fRfoyY9kRiB/Z+Bh
	8z4VRpMDQbftSmkOqSAD3qWJh0AcWa0sTGQV2WiyuzNC8BcYEjRUMJwcwQuRvmGw
	lXzWhW4N/fDq6ACJHz8rS9wMfAGSk/6wZxsHmlOz3qd8p7ckiKBft+ynbBSBaERz
	oeS7BT09sR6l7IJcvZIH4Cxh5VBLLtWakHKFdTMr8yz9V+vptt97r/WCycKVA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47f9njumhq-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 13:53:16 -0700 (PDT)
Received: from twshared76339.05.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Tue, 24 Jun 2025 20:53:14 +0000
Received: by devvm7589.cco0.facebook.com (Postfix, from userid 669379)
	id 4FB4E166A9FF; Tue, 24 Jun 2025 13:52:58 -0700 (PDT)
From: Ihor Solodrai <isolodrai@meta.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <eddyz87@gmail.com>,
        <mykyta.yatsenko5@gmail.com>, <mykolal@fb.com>, <kernel-team@meta.com>
Subject: [PATCH bpf-next v2 0/2] bpf: add bpf_dynptr_memset() kfunc
Date: Tue, 24 Jun 2025 13:52:38 -0700
Message-ID: <20250624205240.1311453-1-isolodrai@meta.com>
X-Mailer: git-send-email 2.47.1
Reply-To: <ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XdbvUXftHVabMGiWShB9puwoSUkUf_wd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2NiBTYWx0ZWRfX8d8lUnjs5DVa Rn+Bt7cawfh30a/wwoPHmboh40lOro/G/S6KPbDKk+ZYztjS9kkajPl5R3aml/fjvyyb/nIzAw6 0/fJytEes2i6EZMuvDPosfYMXjTM8/VRcwPq4ivr4fE3/1jlIsM2o4I1HOkEalnN7AyEMVOs3dV
 8rJ+idArVH5BnkL/I+W2BJqEIp8wC21zZhMH1LaBecWsuQVBFrMaFF6w4e/MZiu38MfKogf4in/ DcLLWa2WTyVI66LtQRgxMi4dmxPs5Ic4WzvR0J7tgSE9N/N51qczHG4Sn3DqwF4DZhfPDqRA7Db bu568ZwYQFX6441bbfFIcGJR3V2kblc0URaPPB1APCrqAqBtPS7RY45zAh5D//IlFuhd+6NLsSC
 JAo7n6hBRuZrVTGvX0RB/nMeFb6s/Nh3LsPDhJccy30w/Qgk4Io+BwWVgPjD5ODHn0gUaa+S
X-Proofpoint-GUID: XdbvUXftHVabMGiWShB9puwoSUkUf_wd
X-Authority-Analysis: v=2.4 cv=XKkwSRhE c=1 sm=1 tr=0 ts=685b103d cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=2aBJgU8Q5d57Da2MBNcA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01

Implement bpf_dynptr_memset() kfunc and add tests for it.

v1->v2:
  * handle non-linear buffers with bpf_dynptr_write()
  * change function signature to include offset arg
  * add more test cases

v1: https://lore.kernel.org/bpf/20250618223310.3684760-1-isolodrai@meta.c=
om/

Ihor Solodrai (2):
  bpf: add bpf_dynptr_memset() kfunc
  selftests/bpf: add test cases for bpf_dynptr_memset()

 kernel/bpf/helpers.c                          |  48 +++++
 .../testing/selftests/bpf/prog_tests/dynptr.c |   8 +
 .../selftests/bpf/progs/dynptr_success.c      | 164 ++++++++++++++++++
 3 files changed, 220 insertions(+)

--=20
2.47.1


