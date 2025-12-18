Return-Path: <bpf+bounces-77051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8052FCCDD53
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1995C3009F6D
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BA2340A57;
	Thu, 18 Dec 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5dmuLMm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9CC340A51
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096881; cv=none; b=o9OprLAXBIvDyyS3iGxUsQ/xN5Eu2Uk3Cjr/RO+RAj9DLlB4rJtMGvIZmXx3UgcDXoGCheUzbPAfxhh96pr7ewd8dN2pB6LaVFTWisfmYY1nDjlfHjSvPknIOW/78nqE99GqQHIdscNZmKTziSX1fgxJIAjmao9yaNEzbVKJUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096881; c=relaxed/simple;
	bh=M03zd7X2axJg/+RzCsc92znhx0Iq0DkU/IbU5CWaNXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ktEA5QURFRSqTnfwefFHL45bYZse+S7wVcFfoFf50bbHec/UuHz+CgNjYgKV8PTS6r9WtZVP3jyxGZCUcrw/EBZ/Q7o3ALU2YJqEFIv5r4gvwYlod/8IYuv9lyeYs7y79/0wydNtnqbSb1AQz0k/v+WSzQuzn2m7xSyWsGsv+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5dmuLMm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc0d7255434so717309a12.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766096880; x=1766701680; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M03zd7X2axJg/+RzCsc92znhx0Iq0DkU/IbU5CWaNXw=;
        b=R5dmuLMmjwzvX76cd6MUTxzb2T/sRibf84yHh/C9QiImn2T1SVk0KNat6axOKIu7sj
         nSqnQVwI3SoSJOkVuzQUXy/HuH26JIK6SV9ZzFrJIWTtU7lSz7/ayoC+vZjQ9+omrU8o
         m18+mAfdRcFp6N9fmQQNAT+Dd9xEV4wdnSdftvS69/3x54ZxWnwMx/hRp6VovwNXr6oM
         TQ0wHcOjohPeBxqjAN9O5AoJKZ+49PKczbu3RC5KmOeBesliJLvsmCVBhr/I1nAXkcL7
         pnTTbT/abN59A2tVoLEZZEo+e8vrAg7/o8rr0lKdvRnNzwlHZPoSolbaqa1odoixwZ+k
         hGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766096880; x=1766701680;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M03zd7X2axJg/+RzCsc92znhx0Iq0DkU/IbU5CWaNXw=;
        b=brmJssyphPQjjEdxtD8si5vc9F3wUQLGg3MZefuec3QAKfr4mmC2JDW4THgW9hW0ho
         rJXt0vW2v6doMsfkS4h4T3ffgO9VndWGwv+G4Sqqc8+Nzx2zX3aaxgJCKGA5Re4th1Pv
         TXTpOs2ln0cD34/NFbVMj1JMd0eNKUZCQlD4PsDRSpxF2o0Cnj1XGDXwY0Yr331+aNFc
         NxtYKYLKSQCpwhqRY8rKgy08v3nT4yV+qwYjZFhGjDY9S3n3UGHdd5bNYSa12ZEqSuSc
         3FWZxJOwonShZ4uE7WiCn5rpXlIT2to8DrIF9j/vzaQOajVBqR8WwECbajJ+mogHPwQv
         M9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVTaMsNJcGruPbaLJXPGsdu9axf+tBU+QaTWUJM/hFr3EPU0HOUDmBOYDUdOIJPi/BejBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fVs3Mr54IQ+ok/3/xPpzvXvwEwGFilx4x6p+8bHjoVVoagQt
	K/vqk6B91vBgSzA8HWMykwvkz072XbUaPmd568PwgzgU8ZZV1iQFvxjO44StQpt5qs0=
X-Gm-Gg: AY/fxX77q0+OwcjmZmYKejP+Fi0nGJ07cJZ6Xe+9mkPtA9FEC9LO8OTnJf426hA4BNu
	/rZsqbckXpsm/imoGZ50tAdr6Enx3pVPjPYFzqTepS2ufRm3awEXZflGZWBnZ2p0+DHNf0TQ9JB
	b6DhVeS2Ua4LePRVKK2HiExlAuykpdX5IQjyUvt9WsTGWVs9h5vnCnx/IVhhEiz2XnDC9RSyeBS
	CTovx508Ou8G3xkym/fzJgVUkZ1GlXOOOUgakr7LEKcBsbw40Xtd6FkwjyPurEHZVgCIN3rFJDi
	bzt3pGlD5O2NXTPSYsL76nivn418xVu+LbHSEXbl9hDILqWQn2NZugoOHRHU4byjsIHyFFnzPBH
	c/2vDFTJ7eeMyPmI8shhMlpALL9/Cz0HPwxirqf4eQOiTRX9WikL299AdK+J8yC/WhxW+SqNe/x
	h/rY6XlU5NgTyj7/EkEYJEj4iwUC/+WZgNxDZB
X-Google-Smtp-Source: AGHT+IHousfN6+czE9aWmuESH/WtJoyDnf28vijiqWDZlragMmybzU6Lz7UNMNFLhvXezMt9euKujA==
X-Received: by 2002:a05:7301:7817:b0:2a4:7b58:1a25 with SMTP id 5a478bee46e88-2b05ec7459fmr910386eec.27.1766096879670;
        Thu, 18 Dec 2025 14:27:59 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ff8634csm1483831eec.3.2025.12.18.14.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:27:59 -0800 (PST)
Message-ID: <5ceab6b0e23c0f00f3d3acdaf70bef5d9f982e42.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 10/13] libbpf: Optimize the performance of
 determine_ptr_size
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 14:27:57 -0800
In-Reply-To: <20251218113051.455293-11-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-11-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> Leverage the performance improvement of btf__find_by_name_kind() when
> BTF is sorted. For sorted BTF, the function uses binary search with
> O(log n) complexity instead of linear search, providing significant
> performance benefits, especially for large BTF like vmlinux.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

