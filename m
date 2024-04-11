Return-Path: <bpf+bounces-26583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F628A21A1
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 00:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744A81C23EE2
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD463FE54;
	Thu, 11 Apr 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt4I6LoK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E0405EB
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873528; cv=none; b=kOdjh3+gyEdhkiM9GYAQ5+KTu2qVozdZULGMZHGzaA+90hR/X4fKGjRcupYzXcaQ9gNkG1nHT88Gz4w+Fx27LN4F1kW7o1B3Q/qH2kgq3BTrTTssZO7j5USxgGzZa93lVdiIsy7qHjm52l+EiSvxLOS/7I8la+osyLqnO9Bve+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873528; c=relaxed/simple;
	bh=0biQIVyX/G9Qd7HjSuKosdlraExo3dTzeb+ErqkAmsU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UStFUK4AlUP2Cuv3qq0PkgAioClyAyGWwZMvz1QXYPuPYK9gALxlZoEaJ0x8ZyH/EQPLbF+e3FUh1Mj1s8UyzI5BhNLNQ8e0gJ8pNNxDGOIAq365ZTDaRHlJ7ZMIgwuL+w6bI+kGh8oL9nsLPtrbxzlXDGmDa/sglu13OqlR1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt4I6LoK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so287500a12.1
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712873525; x=1713478325; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0biQIVyX/G9Qd7HjSuKosdlraExo3dTzeb+ErqkAmsU=;
        b=jt4I6LoK13cRt8nB1nU2ADKMkYcgfBrAAvmv/IZblq3Czfwt/F/RiIb7DVt6bx3hZ8
         x1hSfLzPQYhyD4jqn+jJ/82Bhse9OnZb4VS3ZzNsCghudUQT4x6aJzr9pFd19M0EqWLD
         NPiy9zUGacTYec9Ya8izoN1DfHJb7nW3BhbMr+hvB567zm1upMlmJ0w3PEA25YgkaI53
         mg9jj935K7cLBuBkOL540ZjP1kRsrcTscbWNnsWJQwhrfcNVF0az0M+IpVrpmCugmnfh
         ocGlFl1nvYW85c6KhnclpTNNAYpKU3+/Y9NrXHdfuC2Yq5m/bphfOSEznxfwi22qss5U
         jm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712873525; x=1713478325;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0biQIVyX/G9Qd7HjSuKosdlraExo3dTzeb+ErqkAmsU=;
        b=aupOMSN9ubmFZQTjVKS9g6E7aeSMgTVT/BvfkGIukuhl6nJAH1+kjOU6fXHhh8Ogz2
         vbTv4iqEZXLB2k6ir3PiBfBKROFdYYhqkfikZY0iBbQg7QTzRqBxgF2J3Wrum9mNjBwz
         NgYSFMwBSOTi4+4o/2wZiGGJermj912ec+qXCj8CsxlggFpPsxpXBLZa0XyCbTEt5h54
         GzHSU/2cxvU8o16ewEpxjOJNKCrduZO7vhs9CkVDC16W9BbDLtYbug/4YXUtiTbwAqbO
         /hcwOK9cgfs239vCA4j/jodE6bGEXQOKS3sGWSbkaGadXVkCEpxxUDmE1FGReCURxRB2
         9hsA==
X-Forwarded-Encrypted: i=1; AJvYcCUq5ayzx9f8ktW6eM8yEq66u23Hc6RYVmUxWSTSkpfBESvoFKBnIDB0Zx5MDfH+ro/wV98HmpkCVj/erY8peFK+iva0
X-Gm-Message-State: AOJu0YycUlGvqrowXpeGen5UaSGVC5nyurLFCKMsytkkp/+vK7LN99zz
	E6RwsUgoEMqatheVz7PKQI222dzNyeG2hesLSmwsLl8qd5TPlLlDrExrz1sD
X-Google-Smtp-Source: AGHT+IF93S++2JkF8nOXsjvk+tW1hGf0pKAyRXegb1SCLPo4TWfvh7ykmse37NPxAG+pcB5Sxa2XHw==
X-Received: by 2002:a50:d7d3:0:b0:56e:418:5559 with SMTP id m19-20020a50d7d3000000b0056e04185559mr654491edj.3.1712873524700;
        Thu, 11 Apr 2024 15:12:04 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640205d000b0056fea963056sm858968edx.7.2024.04.11.15.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 15:12:04 -0700 (PDT)
Message-ID: <10df40df780ed8fc5c8d14a25576b52a47dbfc0d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Remove unnecessary checks on the
 offset of btf_field.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Fri, 12 Apr 2024 01:12:02 +0300
In-Reply-To: <20240410004150.2917641-2-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
	 <20240410004150.2917641-2-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
> reg_find_field_offset() always return a btf_field with a matching offset
> value. Checking the offset of the returned btf_field is unnecessary.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


