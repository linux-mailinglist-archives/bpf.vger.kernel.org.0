Return-Path: <bpf+bounces-50373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E1A26B96
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 06:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4593A74D2
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 05:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8DE1FF1CE;
	Tue,  4 Feb 2025 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqEgAc+R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006C171E43;
	Tue,  4 Feb 2025 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648655; cv=none; b=hfi03NB8OLfacItxOx4x2PBYmHG/wV0h3WBOEYgInjkTDwt3xyM5mmDnIihcMfeHJysmVvjbL6tfh90RFewxAEySiHtFSG/OTIxQEKMKyly1TzDCM6oYJiU8v2c9E2NLSF7yWmQ4hqLgYiMJ2WqVFvrBSKhMeXlrbdb+dHXzcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648655; c=relaxed/simple;
	bh=dbeZ0gg1k15y7+CmNvp7w9Xz2vAcGWdOdBV4OXqdV6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=btH96MqHVrf917qva2F3/o9VuSmu7XUEBLl/mxv/XLrEdmyikV9RzDPTj4Bw1WhSM4a0nRflPTD6bDjlNgQkIL5ijjV/OPEXfGEiIZmcpUsTqfPoo6g8+HG5WAlL8WQ67r2jZeUNWh9pkOuupEn2uKszG2s3JaZlhLvEhWIj3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqEgAc+R; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2167141dfa1so90791845ad.1;
        Mon, 03 Feb 2025 21:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738648653; x=1739253453; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dbeZ0gg1k15y7+CmNvp7w9Xz2vAcGWdOdBV4OXqdV6g=;
        b=PqEgAc+R0Tn0IYL+ayHd5zei57d4kBFSHCniQl17GDd6iOkBwFlwoUCX45D1816KB9
         FpwbYbTGo2vL309jwqvpPhhe6j2z2SUwo4Vs6m6/KB4UUEqyxuEna7J92eWLSzZR87XI
         HYb84R9etr9Cd0+mzTfCH9TsiEHHzZsKEeBb1JL603Oeach3kg2D3V7+mtMmIx0InApW
         fSu2CJq5tkn5h+5L+6ClpsKdg9kwy2gBr4H8T3HngJeIyusIPJ91WDBeeGWjESgWttz5
         rm0ef4SPE0xvXkj/iqpa1ZuNVfgzn/7mmDhtUXBW4pbJKdAMu4VuVlgZtUTvv5zNUiBj
         BnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738648653; x=1739253453;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbeZ0gg1k15y7+CmNvp7w9Xz2vAcGWdOdBV4OXqdV6g=;
        b=JNxQGhzXHOiEkVXcmp1Gbz7aIcSyOughrBNjmGPoPh7GeNp0f5cCUuygPgcBG8bQst
         pXz2xWIyBxQe3PXLPDyabGeNwdtPVKle8+4leB8R8AkfpkvTSK2t58Htvd7jrIzdaKLF
         IrP3nhxpSPh9QoeVnbUtqNCpbAF3YE9hUDuQ7dTdwuXi5gHoL44Gxd8mzVZ7gSM9Ds+B
         wvfVjxJJK7sfvzmksC4UkZQHEghPd0P3GS87axYL9wlFnO4tnYpeMDr3jBy4gtVZU/rB
         SvV7k/qP/nw4VeA0NPnhLB6SXkMbOFbnGavrC7e9X7BypgcWHx7TUNiUF5ywkDshW8DT
         pWUw==
X-Forwarded-Encrypted: i=1; AJvYcCWsMtcYX9aKyMOaXM2CU9JAfHUWbF6xdA68gZZAteVYgqjWuP85OW2NiObbmS56pQWLuf/XAJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypz2s/eAII4ApNrYxhNyCc6dy4rmVNE5KkrXBoPvT3epN3ZCgp
	tdA67XOT/5AkBrHYN8TtKk0xTfMXVbHK0z65+hyfVg9M+i3XOXUJEM4MTwxn
X-Gm-Gg: ASbGncsX5CGlho9U9QJ0oKeUxzG0XLh2aLXVibAPy/YKwK1XjmyyyyiFvK+ArPhnbc+
	HOHKMEDhmxCyipma9lpZMdKzgl9T5AY+/KznkCellCEkBPwQawDrNR/bvlWWP9fquzHzDcbAn8v
	95Wfb9Qv2VnrBpnRviWQIzFSt5JR5XlxxZhNxVfj5Jo0UToPtbV7dy1KpBJovOi1J7qzdl8peAm
	fMZmpPz8zXBMVa2n3eKzUrEQszVo0cuE8m/J+rJeKvFwCcjOMS0dN50vHusGXHyiTcrNkLQANtB
	kJboFh0zqOBo
X-Google-Smtp-Source: AGHT+IEgsinyxTuALl2qGiWrrCkDxa2u8RrrhJpttUx07gpeXrdwA8zfMt/7l3QJ+JiPbCF7ve4MwA==
X-Received: by 2002:a17:902:da84:b0:216:2aec:2d54 with SMTP id d9443c01a7336-21f01c3d2b7mr25706455ad.8.1738648652886;
        Mon, 03 Feb 2025 21:57:32 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33007dbsm87261635ad.184.2025.02.03.21.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 21:57:32 -0800 (PST)
Message-ID: <9ebf3b8d8d115e83a64c2181372017d6bbb8f51f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 02/18] bpf: Support getting referenced kptr
 from struct_ops argument
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kuba@kernel.org, 
	edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, 	yepeilin.cs@gmail.com, ming.lei@redhat.com,
 kernel-team@meta.com
Date: Mon, 03 Feb 2025 21:57:27 -0800
In-Reply-To: <20250131192912.133796-3-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
		 <20250131192912.133796-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-31 at 11:28 -0800, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
>=20
> Allows struct_ops programs to acqurie referenced kptrs from arguments
> by directly reading the argument.
>=20
> The verifier will acquire a reference for struct_ops a argument tagged
> with "__ref" in the stub function in the beginning of the main program.
> The user will be able to access the referenced kptr directly by reading
> the context as long as it has not been released by the program.
>=20
> This new mechanism to acquire referenced kptr (compared to the existing
> "kfunc with KF_ACQUIRE") is introduced for ergonomic and semantic reasons=
.
> In the first use case, Qdisc_ops, an skb is passed to .enqueue in the
> first argument. This mechanism provides a natural way for users to get a
> referenced kptr in the .enqueue struct_ops programs and makes sure that a
> qdisc will always enqueue or drop the skb.
>=20
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


