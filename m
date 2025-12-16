Return-Path: <bpf+bounces-76776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 184DCCC5493
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 103A33022B62
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4680D30DD2F;
	Tue, 16 Dec 2025 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZRGGRhZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D914221F13
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765922457; cv=none; b=UbjENm5tljPo+0lNWw+Syn2rf1pUDk/rQJ8cGXR6V3K7YmFFbTtLax3EzQq/m4m8Tu7FiyLQWUv9ywREfU25HV5JVHbsZaJ4HUqBacX4Tt/JhON5+7iC1biYAITniVy2g3Gf7MW5RFdHcUHi+K4lK3oTFj0y6fbbeXQQ4h+v42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765922457; c=relaxed/simple;
	bh=Zz73vwuBYA34/jgFQ2Dx7cwa756vvrIPbdhC3oJwsFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lk1QbzuPQ0kNZFGIGLcsolUuL3z+ut7m+GNtDY0nSU9QVIcPkxMKknUFqNls1A9vExqnYuZI+xcu1TgzHQjL+0zj8E+NW1TyAmwyzZTdEVEfc6azAgmmVU2vt4azBRdJ0LulLSVCTmhaRANOktAuRD6i6YpnIWTS5o8xfqR3hzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZRGGRhZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29f1bc40b35so74245435ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765922456; x=1766527256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zz73vwuBYA34/jgFQ2Dx7cwa756vvrIPbdhC3oJwsFk=;
        b=JZRGGRhZpLADsdQcRPs2bcvaeyvB3mDoDy6KEwLiFGJtNUk2Xf7HEhQuUTAO2wZaC4
         jBMZwSW/b2eyEC9+nHSNBSTzypr27y9vtpfEhxbVJdaydRLSYHxh2Ufh9pgCvSKDMJno
         z9qLfCtwHj5+FkT3XrhtNSJbjNFT8e27UJceTs3gYeGL0UYaYTRx6uyYSftvdqW4DO7V
         x6ORhMoOLw1Ivjcx3BwpTP3FSo1c+r2clkWTDifZvjlYNOylOJxBlzDP3saLa9hm5Qgk
         2ZY3cPMZPbW2b8vTJQVL2wl7R42IqxHvLfy4aHaI1apfJSZqV4iuVaHr15xl7b3LrmgD
         vrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765922456; x=1766527256;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zz73vwuBYA34/jgFQ2Dx7cwa756vvrIPbdhC3oJwsFk=;
        b=ovAFrGFWCd3OmxIAKD6nj859Hz648XKcXX3Lu7/JEdfJm+pbDShgNknZj1rskeJlJn
         Up6UrpgqowPb8hyCwEX6TcQWmwhmczxXWYh30rq+PDv5UH7OHRbw10vNXYZlHRds2833
         we/gxnf3tsHTPRSlw0Otfuvzj8yezRKihVDN3F6UHSQ9zaG3ZF1kXDe/oeXZxV7Hl/Ji
         y+8PZOv6kTjQ8CWB0VXn3LNJfR/hTOMfwE4vAEGBHTnPUIetC5coKZLLa2GZAGn5KL3F
         y7WV3TVDpItLjUKsXmm57fxF0fU5U/2qgGNPhHsg97/N575+m3wQ7ZWMI9ONXIOY1gEr
         Yz7w==
X-Forwarded-Encrypted: i=1; AJvYcCUUr3YdvbCQ2DcUHaXwAMkpNHqI59oxvFyAv4BnrlkduGgNAQg39V8UeYHmIDWC/bfMWxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUXeClL5ROwK9GfmYwlvxRt7mUaipW7/8LxSNIjeDpHprkLMW
	xFdod1L6dUorJLF9Pz2LRE1ZgNvldBuFe9qaFAEQWsy5qOgdOeD83LWF
X-Gm-Gg: AY/fxX6A9VyJARDlQP1N0Yn6W7Dk7G8Q9lR8i6rGocckzyxyJ+MGztPUMBFEhyQqnm9
	fFZXvbC5B+d4mozorLGiN67BtzBIP+P4fX3ZhQBozrex+MwbnetxGQJK3lbcE9KyrrEQkVQ87Q8
	jG7ciAgpzYI2DC27aTJhTmTtoFQ5Omsdivug4vjv74PkQS+zkknqdvMnicI0Bjm5nvgM6ahYake
	3XHb2yJvMI+r0oBkIU7HOo3VdURTXCXmW0+ZEFlBiICBCZ3G+aKryh9LJLx6AR6i7dI9bKRFMXY
	CkefNmkFGYqjihh3qkXJlARFTX2aDw0ihJXnD8VIWmpTuPGRZeAu/glNvjcKmD2Lx1abUVPJcP+
	hN7MtJtODXkv3jGWGDQpss7zNuvFXbcU2ZX/xXCZ5oTze8m9neX/AH/ndzBCPp9uGjWRuUOZbef
	qIO3IKTuLL
X-Google-Smtp-Source: AGHT+IEscR3GrGwKLKHe6JaMDo84Iekfj4woyf9aht5NqzpJ76WndOOIOcoWird76S85mOMB70JZrA==
X-Received: by 2002:a17:902:e811:b0:2a0:d05d:e4f with SMTP id d9443c01a7336-2a0d05d17dcmr101407615ad.45.1765922455698;
        Tue, 16 Dec 2025 14:00:55 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0b7f5c457sm93866505ad.67.2025.12.16.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:00:55 -0800 (PST)
Message-ID: <1e7f87fb8c6d8e14da910a25b02b8de17d869f59.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 02/10] selftests/bpf: Add test cases for
 btf__permute functionality
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 14:00:51 -0800
In-Reply-To: <20251208062353.1702672-3-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-3-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> This patch introduces test cases for the btf__permute function to ensure
> it works correctly with both base BTF and split BTF scenarios.
>=20
> The test suite includes:
> - test_permute_base: Validates permutation on base BTF
> - test_permute_split: Tests permutation on split BTF
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

