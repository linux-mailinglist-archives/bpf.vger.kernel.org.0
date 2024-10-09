Return-Path: <bpf+bounces-41363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7709E9960CC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F221C2108C
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 07:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248217C7CC;
	Wed,  9 Oct 2024 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbjjaH+B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DAC42070
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458806; cv=none; b=RdD3j/jifE9VNRIS27a/F6GpOEofKxe8cENAXrY9lW9ZTqWrmAyiF3ffbtazspfV6FtB93s4NsyZOmHJyjERjs+33e6J44gT+UwKhIH3c8OklZibJ5/hJ71wg6gaccqOOvVtadWpKpdAAfW/YE58HNNVZEs0gfyBdWp5oSeNwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458806; c=relaxed/simple;
	bh=GUqQ3swirCtU6ZaSDwvOrQtX4hpv7xb52nAZKyzidfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZVdFCDD+w16uTQpUsveltiKkOEm/pwnkBL3LMgp4p9j7GobEUZoimuKn+qgQByayp4EWcPIAwvgkpv1bg7EiRY2XPz+ax19sAmrh3FZsuMTdk14ACdW1MjW1VAQNB2PeyIAnnTIIAXRpCtMQjOu3mVRcY6JwYEzL086metEFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbjjaH+B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c544d345cso4635655ad.1
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728458804; x=1729063604; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUqQ3swirCtU6ZaSDwvOrQtX4hpv7xb52nAZKyzidfs=;
        b=jbjjaH+BzufD+mJ9NNkWroHem98qyHft4cRPCuC6fSz623QUxFPPFwEK2M83KgMvqO
         HaGM7glOOfkoEfnmIB/yRmbzowLt4LtDM+Kbo4FzPCagL4TGvRVhp+5nvzI8ndCViwwp
         Y5TSuLb1iNMmmlh/WM1mHf34ob04cuZLPRJRSH0iOqAZSa4v402mLRLPCI5fN30SJtOO
         zqkfrBnYdKayldo/Rju2pDOBTd15160GndPAsKBW9Pe1DsJIJmiIi05JuCmcljY881w0
         797eK8NkTYFdLHwhjP8jzuOCxLCqt9nXF0yX210lmPs1/X/0coVCqvlit3ztkM6RVw40
         HEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728458804; x=1729063604;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUqQ3swirCtU6ZaSDwvOrQtX4hpv7xb52nAZKyzidfs=;
        b=KiAp9DRq7mBJwCBR5ofg9PcebO8rKudn/GlciPuQIgPQWzEpRdBhOyZVZ86clAPqwO
         hlfU7yDemnDA6nOBOyz0BVL6bfIxnrc9gu3ICJxcluXufO/ACJTPP+hj9mw5qiTpx5wE
         DOy3DgSp7M+wUzXtgwcHZRS4PaO3eJQr28EBYREk2XKBmB2QndT/WXx2QtuBugqUT58o
         6777gs+8Lt5CiAJNYLBkNPjuPConsy8VTsyhxRnQF0npEOOru/BBSrSgT3IM+4ZL7ccR
         sJ+kZYBwLYOwMoMx+HQ8e1X+8r+VMatQai9D4qn/MOE6k68pAeP7FZN5w374VS8xM94L
         Yx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbAiBP5KH0lyTyB145p8vnCw4NCsTz1o5kqhH9dRREAit+72oHDJtzpRKICty7fSs2YD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHvabr4J2M2MTzf6XGgB2pogDiaj0UF3d8u6tcWawIxccsyR0
	fGY3lA8+hJcxaDr5qyUzpveqrkFYlTEsWglbpVewZDPOKpy22gis
X-Google-Smtp-Source: AGHT+IHw708D3hQ0Pzb4v3l+Q/iYuEc+2L+kNAMwhiyUD52rfjkhmH/WN5D0jHgZp7/MFGyk8hJ9aQ==
X-Received: by 2002:a17:903:41c6:b0:206:9c9b:61bb with SMTP id d9443c01a7336-20c4e26b5bfmr96119655ad.6.1728458804228;
        Wed, 09 Oct 2024 00:26:44 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13968a3csm65189235ad.208.2024.10.09.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:26:43 -0700 (PDT)
Message-ID: <8f03efea7c8ca6eeffb3c9310a98c01fcf04c95f.camel@gmail.com>
Subject: Re: [PATCH bpf RESEND 1/2] bpf: Check the remaining info_cnt before
 repeating btf fields
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Date: Wed, 09 Oct 2024 00:26:38 -0700
In-Reply-To: <eeceba84-0fa0-322a-5236-0f02103f4863@huaweicloud.com>
References: <20241008071114.3718177-1-houtao@huaweicloud.com>
	 <20241008071114.3718177-2-houtao@huaweicloud.com>
	 <e8b1e868755e0369d212f53f4e00c0cf93477af1.camel@gmail.com>
	 <eeceba84-0fa0-322a-5236-0f02103f4863@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 15:12 +0800, Hou Tao wrote:

[...]

> I don't think they are the same. The main reason is due to the check in
> the beginning of btf_repeat_field():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Ensure not repeating fields=
 that should not be repeated. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < field_cnt; i=
++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 switch (info[i].type) {
>=20
> There are two cases here:
> 1) info_cnt =3D=3D 0
> Because info_cnt is 0, the found record isn't saved in info[0], the
> check will be incorrect
>=20
> 2) nelements =3D=3D1 && info_cnt > 0
> If the found record is bpf_timer or similar, btf_repeat_fields() will
> return -EINVAL instead of 0.

Oh, right, there is a loop accessing 'info' at the start.
Sorry for the noise.


