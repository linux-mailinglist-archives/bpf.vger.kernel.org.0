Return-Path: <bpf+bounces-64464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0980B13227
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 00:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED0E3A53BC
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336A1F7575;
	Sun, 27 Jul 2025 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLDYDmn9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492BF86338
	for <bpf@vger.kernel.org>; Sun, 27 Jul 2025 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753653708; cv=none; b=Msp8gPpWhm+69QfpM1aOAyzWEZHi59sigSm8jGVaNaaE+Sak38pEaBN0MKkzXnnQAVdmKxXjEody573L5w4cNTHoJdhSLG2ZGQlwVCiG6RBji4H6PkqLSedJg6XNU+QC46S8obsNMD3nL/HR13/SdCVjDu6a+mQQ1R8OzTqb7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753653708; c=relaxed/simple;
	bh=bVx39zeXyMmjnULc1Yt4PP/T5PUV0giE8tF/FhDh3Qo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jceIPLVlrXo6k80OFLisgTYGZdadZmcrer07glNJJMDxFFTpebbQUq7H8xNa85CCqRkmWE9CEfFci5ybMvKJyNE2pIdsVnkMQ1D95rabHas2SSekn+pOAu6DJLUj9AvHX7Z6X+2eI6oUhjRgZa6z3/E+RWR3q5ng5uXYMQlaK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLDYDmn9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so7360785ad.0
        for <bpf@vger.kernel.org>; Sun, 27 Jul 2025 15:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753653706; x=1754258506; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bVx39zeXyMmjnULc1Yt4PP/T5PUV0giE8tF/FhDh3Qo=;
        b=mLDYDmn9qQznWXzVt58K4NqYf9hDXjRo+YKxAxN+UcLiThTiE7yVEjVoYb9Rf7lqfu
         2ufu6Nt7GRgbe31muKDA00VDlwS/QLzyQYBRdMyjuk34IuPqVc08+vrS263HDzO8GaPB
         DWKaYlwD2dPn2BCldvSq45lw1UlcnT4QnQEMoH2F6Jm22o8fjB0vKqnxP3JMPmT6Vo03
         k58nAoepbCOenBH+HlQcpF/T1lOiC7FSGKe5COShHgqmTmQXXOHEwRmXs8pWRt3MY19u
         jShwMCKv07lom+Qcx1is2H42jm70gh85cKJlE3d/TMS5WzEVoILjHiyvztoMdnjKPuHg
         SebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753653706; x=1754258506;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVx39zeXyMmjnULc1Yt4PP/T5PUV0giE8tF/FhDh3Qo=;
        b=Z9SPTkkErtmdn7dCzMliMYVy+Xqg5Q/HdB0MMIoOqmIKh6XVOm/rmVNY0Kt1yQ8FNj
         +NvfhYu7Q+nS+6rMQdEVNyFWEkSZQGbSMgrji2QSrqYnaAPIFRB+60BsmDAfpniUxPAA
         h941tDDNC6s4Sf1vkwEgomVR3JuSWAIHEEqfRRfbUc9YFCleYh2sU6Rd2ymTohQj3+3S
         niaqbrTbjrqVXgpwhFc1VoeNW4omY0iaF3TK2nSYuKOLTdyVQr/icwIZ+FaHN59jWWko
         qi/9lS02a32SdI6rZJR2iHcv1myGLPjF3f7087Ekxjk3u9vDl5IzAkx9dgtQIh5/hkGk
         Ssxg==
X-Gm-Message-State: AOJu0Yzdq8AHN7Yw9hEIzBnzWgMSQSb6JPw2vF3wCc0AuBrYfzJ3MKAk
	FyN6Er1+PQFitt+IfgzWtM6mBlVMjAQ7dXUmypD4dpK1ghFOU7BUkSva
X-Gm-Gg: ASbGncukRSYq/k57NhVoJnqXmiZK7vivYEFI+t1mA7wQsXLyDU5SDinAEvWb2xLIe6G
	aHq+K+qnHAXl1EyZ8xp+g5w+cPGCpPVbIDWYMr+ojbjFKFeN2FyZ4q01Q7eCJPPiJpnVFmumYJA
	ITofBDOVYR2x4KkcoyMiZy2DE716yw5h6pWK5dg/px0LHlKvoNwBagokFcQXA3RW65QFfHNaW4Y
	vtwEkDFJjzca622nzn5zE07F72blPiGVoYHstXMw2f4UHE+1B6CceZaUEQec82XisjvfmhaZzgK
	IXvUfF71PBXJ0GSNi5TQKYNGO+88mzmi1j096njMx4PK014ExJIWW8+Cr7oe11l8QK1mWqNyh9C
	l+psIVdwo/iEbCZ+CGQ==
X-Google-Smtp-Source: AGHT+IEvsHj9gaDqOI434tTGypE0cnvS51xf7ubl2y3t9ypv465gT5N6GhJpEAalKE1AYawgyKAuZA==
X-Received: by 2002:a17:902:e748:b0:240:38ee:9434 with SMTP id d9443c01a7336-24038ee9756mr9526205ad.47.1753653706486;
        Sun, 27 Jul 2025 15:01:46 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bcfbsm39797215ad.16.2025.07.27.15.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 15:01:46 -0700 (PDT)
Message-ID: <bc88e11c64573f761f0a0af572cedd2843fa77c4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Test cross-sign 64bits
 range refinement
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Sun, 27 Jul 2025 15:01:42 -0700
In-Reply-To: <aISo449B0QhMyf2H@mail.gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
	 <8f1297bcbfaeebff55215d57f488570152ebb05f.1753364265.git.paul.chaignon@gmail.com>
	 <905853bfc266a6969953b4de8433ef9ca7e7a34c.camel@gmail.com>
	 <aIKtSK9LjQXB8FLY@mail.gmail.com>
	 <6d75ad3a05ebf56ab2f68e677264e8142c372fbc.camel@gmail.com>
	 <d7f52ed7d0f0b3fd2ce8336f4161b776cfc0d628.camel@gmail.com>
	 <aISo449B0QhMyf2H@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-26 at 12:07 +0200, Paul Chaignon wrote:

[...]

> Thanks a lot for the full analysis! I've added a patch in the v3 to call
> __reg_deduce_bounds a third time. I reused your analysis and trace from
> above in the patch description. Note I added you as a co-author; give
> me a shout if I shouldn't have.

Acked remaining patches, thank you for working on this!

