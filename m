Return-Path: <bpf+bounces-50372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F99A26B94
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 06:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65311886A03
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA561FECCA;
	Tue,  4 Feb 2025 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC5IswFX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8A139579;
	Tue,  4 Feb 2025 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648641; cv=none; b=jgSGAMZkqcwXOom75Jmela/Y2O4GjNpK0zZMa2j3BEkwXPaJNFK8bmTMO5BjN6kLbfOFBGfvn3uZH1anr/bcWCKtUcJgJXRFscmC9BFA3pYvSOEaulZCufjYckf9SjiWBKl9/7zULubbFnbfNUB0eKH/5JIJGhapbVlP38soiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648641; c=relaxed/simple;
	bh=rKOc+NWP551c6S11mPDymPdrW7a1Eqj7jOiUBmaWBjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OXkeHanEm9iBhrITYYCwbMz/Z7yBUF+s9pW92E1aWGWvRnxTjQSiTpwtfa7XGmin3Rwc589e6723ahVYKhR44VfRqsDwnag4GQW9zoxIxmaZcZKTjAoS7QHYeda+2Rox0QQsAzkF7xPF35Ng95zinksQNroCDnWSSEcMD3BBUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC5IswFX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f441791e40so6661160a91.3;
        Mon, 03 Feb 2025 21:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738648639; x=1739253439; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rKOc+NWP551c6S11mPDymPdrW7a1Eqj7jOiUBmaWBjo=;
        b=nC5IswFXublhCNB8lMkOg2LbguMxd1Kg1zZ/ISl1V6w35CFtKVj3HDbImS7TvXnBBJ
         xwLnnFMPOjFmqSIDPwD9QBTCr4T+2v5JKmHFCBXMOqtRk3xEM+daWMhVbv+QTvvUjdfk
         9OYvm6ryp90h6cBQpa1aS8mEFm4mDH7pRzIokqImDKvzDtoz7SXXAvuNWJ1lbYjkI45r
         SQ0z55ZbXxGJ7TjmH4pLVTPHxfvX0m2HG79DacrjNXV6PAv28SAIGScqHnckLDT7/Asb
         f7PypdN7ouhpzJxQvym+IPyDEOwA1FquKwWiIs+qt3XlrE5mHyxdAVxgFSTAUNmIslMY
         Bfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738648639; x=1739253439;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKOc+NWP551c6S11mPDymPdrW7a1Eqj7jOiUBmaWBjo=;
        b=PxXe0Q0/OtZbo62886iIcAG4oOwEMifprOe7+vHXOPi4oUUpA+Q8V5EpgemN4eCOw6
         6+uF2U24q1s5U5HJn3nfZPWNo7WOgPZhTnrMX+yAV2DpLjTZhbkIqaS54qRU5f+ZrcmM
         0m+eAVgLxIlds50w79WnyVALXENzdz9lccvm1t5uZm5exH9J1KA7PUYSwezp4XXSH8lA
         Xrx5hXft0pHke+CopeWaBj9GHPxc52hk+EfpqCioMnKhiSCFSaiADo80khybemz8phyN
         e4Ujb2/o/okCp3Xh7fb7qm4YroSRPEBpmPGOrUv4dyw1gY5g6O4gZxfO+ozmxO3Qsk7g
         nfmA==
X-Forwarded-Encrypted: i=1; AJvYcCXupokI2P+r8tcurkM6RF9+3Q9KQv4EtW7fYTO7lHqZjHBdZ4sLqgziPJmAGIhuFcK9qUx25ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrRjz+RMoHBSqZhWksyk5Ivfy6D1KEDnoHq7FkcYY8W9ITMyru
	mlVFGRyZvi5qwcCggFZntmpuzKbEWaGHAsHiWr9XMY6mAz0sUIM8
X-Gm-Gg: ASbGnct7r+yFapPg0m5mz2Jy/vP5XdyPSna8R00KAaENtpdE24NjWVufQ0IKZH6D2qe
	BIsLUBCTHbrEm/yTsiMcqtExredWUNOgJ+uHzZz7EQQDvhaP1joRfit6sIsWlNnjG8EoVRDZoCx
	HI9MMnJoIIrL20SnGdPqAbYdgs5QkyeTU9+5AHm3uqycmOQf8ahqqRXFF6jMiry1C+Rm9GvVW2u
	t8fzXc7EJt3m2HlLIJZHT1VNrGZ0YjnLpxTCIXofZ9EVAJU23nXHPHIP61nCni6/ck+kB3SYONK
	rcu/4ccs/vER
X-Google-Smtp-Source: AGHT+IEj6vn1fs8qsLeif//h83N6vrdfa0sQgpdB/id4ZtNY9EtTHPaE+NRpX79kBceTLnL0srCczg==
X-Received: by 2002:a05:6a00:180b:b0:72f:9f9e:5bc8 with SMTP id d2e1a72fcca58-72fd0c74655mr35877989b3a.22.1738648638593;
        Mon, 03 Feb 2025 21:57:18 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm9353571b3a.151.2025.02.03.21.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 21:57:18 -0800 (PST)
Message-ID: <e2333ffe38ce39b5a4d83680a53ec132cd6acbfc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 01/18] bpf: Make every prog keep a copy of
 ctx_arg_info
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kuba@kernel.org, 
	edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, 	yepeilin.cs@gmail.com, ming.lei@redhat.com,
 kernel-team@meta.com
Date: Mon, 03 Feb 2025 21:57:13 -0800
In-Reply-To: <20250131192912.133796-2-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
		 <20250131192912.133796-2-ameryhung@gmail.com>
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
> Currently, ctx_arg_info is read-only in the view of the verifier since
> it is shared among programs of the same attach type. Make each program
> have their own copy of ctx_arg_info so that we can use it to store
> program specific information.
>=20
> In the next patch where we support acquiring a referenced kptr through a
> struct_ops argument tagged with "__ref", ctx_arg_info->ref_obj_id will
> be used to store the unique reference object id of the argument. This
> avoids creating a requirement in the verifier that "__ref" tagged
> arguments must be the first set of references acquired [0].
>=20
> [0] https://lore.kernel.org/bpf/20241220195619.2022866-2-amery.hung@gmail=
.com/
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


