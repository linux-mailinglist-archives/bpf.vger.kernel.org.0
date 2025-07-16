Return-Path: <bpf+bounces-63422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F36B072E2
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 12:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDA03B919E
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5EC2F2C56;
	Wed, 16 Jul 2025 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HvbrLASY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501320E704
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660821; cv=none; b=il6n7k6o4xJXNjK/gbYThPDI5W96+tulT6M9dCqayTBFdKPdQfPRWPPAu1yLUPOkl7hWgP5bPEEiMr6RDWC0S8E3I3ciVMwshaZfGJ/HEKVQxomUpUqhSc/aAr/phEhxTkAvGli69xW6cplhrQeIk0EQEI2P+pGNsTqj0vXe7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660821; c=relaxed/simple;
	bh=viO8rwTsUKi5COCCYybRz82V9Iu+VK1O25yYaxUyd9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAgIZUP10dZmnOY48Y98V2Ttj0iFZ9sgTPIwTRnY1v8o2ASPsDALm3D6eLh1P+iR38Xfxm3dLs5xm14vIuVYKiW5OGWd+Ug2q8kdw5lFtxKvtSIY9cCdXxBhp11PZvHR8FowSWa1w46ahDthIH6IDv2REJW5IlHIeHo89ywfWsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HvbrLASY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a54700a463so406334f8f.1
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752660817; x=1753265617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpt+9Qss+w8E1DAkR9uyV13yqefTDDIaUlADRRVU5Is=;
        b=HvbrLASYEUwfMU5sI36ciEtwM8I9t8AOaYZ1Y8zyEWDP8PWELsQ3dEBFRTXQdRqp1U
         D9Gff0gxtdPIUq9s0w0p9TyC+cxqR2HZ8CjB1ogNtkg08xzl4x4n7+ZypaETtW3PeMWF
         I5orscw2AwDCpA04Pv36Vo4ZAWhf4QOD7Tk9bkF7RrvFDMuihSab0KISdn4iDuIwytni
         p7FqZFM+C/UXiwntmiNTmUSa4jZlH4J6W3FZC3pZUtBiot2PNMGJ6zsGkA86/83SzVdE
         pLNFWy+qa9fbEgsYf4CJhM6N5abmRseeVr8oVFelM5GhFE6yIuTm8WpptL68KZDUa1/7
         +wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660817; x=1753265617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpt+9Qss+w8E1DAkR9uyV13yqefTDDIaUlADRRVU5Is=;
        b=kRwTeGngBNfWqkZ4zl46oOU1LmkpOJ7nxFufiDwB3jYb6wXhbILcDyu2cH8d58sZOZ
         UOhQqZQLwNOpidw9AYZZDE28Dj2z9mdDJzoWn84oauNEl67AEyZXOz6ERhmYTPUYnOJV
         Xx9Z4KkGtje25Vh9pQ0EP25vinC03c3dde9Q35uw+bPW5qa9YZrhT4WLrJGSfwHc9Dq7
         ye3D6MZDVxUASGZI278VLcnGmcR2mOTVmXGXE4ExRxXjJ+Hiv0WHqzkCbhku0cCu9Xle
         CEc0er1Ou6O4cY88vFbkr6fWd1uMPOEfAtPKyNatVw9uv69MIkauE3iiBr8EstZBjym0
         R/5Q==
X-Gm-Message-State: AOJu0Yz9ium2aRNaUMtd6uNfmSFfco85bFj+OIpIO4Rc0Pa97MBpOqLN
	8VGtgUhqbkYtHgNUL7Sr1JsddECkfTSSjcyrpjGjFx1Zuc4LDSyshfibO7nVFmeMPnE=
X-Gm-Gg: ASbGnctOZ6+8xeuFjvFXHDB+BJeta0iaY/5i4+dW4wsXF8LnecLRoULMCN+/UyYHqej
	YRnHj9xcl+Ah/ty6KdLFOfB3XKBvHzBydtUnitds+kA9E0Ev1kpzMYLdAGokzjH+haNo6zcJR5t
	puHCgSfzTPEcm1InHy2dyS9YshrERZPq160tmAhUEa90i51QHby0xsC1wVUCNuyHcSuPIsK3oKE
	fr7agKL1TDHx6aNTBjoOdsmGil8cP0dQhyqYGgN8AYJtRZ6CvnrdkZNSGcXDF/7IPOUrRo8eJhG
	93P/lQspobGsXVKn9o4we25hRUlhGDe+k5lhiJzGoXh5iJbOGByfDswJBVuLrIqe9zkMQCDlpq5
	TZAkKTgAQSjYiqAV9SDAreIzMUQN1fp66vAGYWjK71tTiMrM=
X-Google-Smtp-Source: AGHT+IHqe/AzSltctTUR8ILGEpGESU6BloFfOZH1jyFHxcaPp3B17lsKfauNv79LiMDN0igXk3HRpw==
X-Received: by 2002:a5d:5d12:0:b0:3b6:99:5611 with SMTP id ffacd0b85a97d-3b60953f531mr6013335f8f.20.1752660817083;
        Wed, 16 Jul 2025 03:13:37 -0700 (PDT)
Received: from u94a (114-140-120-56.adsl.fetnet.net. [114.140.120.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc21e7sm17430699f8f.36.2025.07.16.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:13:36 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:13:26 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, 
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add tests with stack ptr
 register in conditional jmp
Message-ID: <4goguotzo5jh4224ox7oaan5l4mh2mt4y54j2bpbeba45umzws@7is5vdizr6m3>
References: <20250524041335.4046126-1-yonghong.song@linux.dev>
 <20250524041340.4046304-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524041340.4046304-1-yonghong.song@linux.dev>

Hi Andrii and Yonghong,

On Fri, May 23, 2025 at 09:13:40PM -0700, Yonghong Song wrote:
> Add two tests:
>   - one test has 'rX <op> r10' where rX is not r10, and
>   - another test has 'rX <op> rY' where rX and rY are not r10
>     but there is an early insn 'rX = r10'.
> 
> Without previous verifier change, both tests will fail.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../selftests/bpf/progs/verifier_precision.c  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)

I was looking this commit (5ffb537e416e) since it was a BPF selftest
test for CVE-2025-38279, but upon looking I found that the commit
differs from the patch, there is an extra hunk that changed
kernel/bpf/verifier.c that wasn't found the Yonghong's original patch.

I suppose it was meant to be squashed into the previous commit
e2d2115e56c4 "bpf: Do not include stack ptr register in precision
backtracking bookkeeping"?

Since stable backports got only e2d2115e56c4, but not the 5ffb537e416e
here with the extra change for kernel/bpf/verifier.c, I'd guess the
backtracking logic in the stable kernel isn't correct at the moment,
so I'll send 5ffb537e416e "selftests/bpf: Add tests with stack ptr
register in conditional jmp" to stable as well. Let me know if that's
not the right thing to do.

Shung-Hsi

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 98c52829936e..a7d6e0c5928b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16456,6 +16456,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		if (src_reg->type == PTR_TO_STACK)
 			insn_flags |= INSN_F_SRC_REG_STACK;
+		if (dst_reg->type == PTR_TO_STACK)
+			insn_flags |= INSN_F_DST_REG_STACK;
 	} else {
 		if (insn->src_reg != BPF_REG_0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -16465,10 +16467,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		memset(src_reg, 0, sizeof(*src_reg));
 		src_reg->type = SCALAR_VALUE;
 		__mark_reg_known(src_reg, insn->imm);
+
+		if (dst_reg->type == PTR_TO_STACK)
+			insn_flags |= INSN_F_DST_REG_STACK;
 	}
 
-	if (dst_reg->type == PTR_TO_STACK)
-		insn_flags |= INSN_F_DST_REG_STACK;
 	if (insn_flags) {
 		err = push_insn_history(env, this_branch, insn_flags, 0);
 		if (err)

> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
...

