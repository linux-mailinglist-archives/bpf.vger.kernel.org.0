Return-Path: <bpf+bounces-56029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB349A8B2CB
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 09:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA583AD8F0
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 07:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78D22E3E3;
	Wed, 16 Apr 2025 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BusBPrhi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A15189B9D
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744790287; cv=none; b=McwKQvtR7VjoBuW6WzORT4+YFFgjahk+6y2Q3gDYQ1tAsccknfVZNx/ht+uxUPQyhLGXL6iJCjvJJcF/2CYBEr7GRDnhR5T3tYrWMD9agHC0cGKbmL7qVXgsDdHhwU8+whrzp7LLK0GZcUsU7KclcBgrCFjxcfXJIRYQOTXd01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744790287; c=relaxed/simple;
	bh=fDTyr4wzSq28przA1CVLFQ5tG72ieGXIHfRpzg0/csw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8jY7ptOaev6t05Q2Qgf+n6f+B1aj+wnVPj8qJe+S6mrCYg2Fp6lttOQlr5G9VltT1T+/uA0mnbTfAVFXUE3099a1m/pfrxhFwOtL7FX1PeFa7Xk9hVnL+Lier47C8TxgigSTJHGtkkVSHtouz7LJ/Zcq6vmeKpW2ZiOQ/iBwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BusBPrhi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736b98acaadso5921307b3a.1
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744790286; x=1745395086; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDTyr4wzSq28przA1CVLFQ5tG72ieGXIHfRpzg0/csw=;
        b=BusBPrhixS2DWplwowdgMSGWTY0c99eqIHFSf5fKz+rupJTWjuplhN/83W25LvWWgS
         y4sfMUcV71fxmMGDIf3ZRWek+s2Ijz9mqMYaR3I9LOy8y0FyGkC6Rag5qNStFMHmSVYg
         IQnew9rYoJi98EQoKWQSQqNFOoLSD4Fos6/9AZPdPbWvGrkGWAM6whY3sd+50h8MWL99
         PaQzvTX6UfP5tWfXk5IEWh4Z6LUZ11pV0pI1Ql4Nb8qMl59lTVQF+yMvxjS0fD2ebRKT
         Vs/eNiH5Q1C8aYB1papugU39pqcMIbxXwVvd8mqjtMtBCaI+6c/N1oJig/X2TmAfqCnM
         Je0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744790286; x=1745395086;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDTyr4wzSq28przA1CVLFQ5tG72ieGXIHfRpzg0/csw=;
        b=N0dYwNGWmckTTpJWy9DUwujp8agyfQ8b1oRiVbM+YA6K66dyd+KhRGwBvLWR1T9H5b
         x3/IVfheYDcN090SsEcJ+Daf3cbCg0EphWWLPKtFiIu2n19uPoN442AQWHNu0vBxj0ia
         qxmsTSyC6blmk8L2CcyfQ6UdaE3O+rxCC/BtRPW3WOfXDH6TlX5vNFAphmmdRBd/J6Nf
         S+WQ446ZtSZgeHAjehJYq7dBEdfW94NUprPTOFCYLYFH5N7TJlNVQpn29rUCnMm3GADj
         GK5OjIZpRWbyvHgz69YdqQhzGgoH79I4go3h4OCdtETzO50E1YVl/tJQYC5jAMa5HvIe
         u7mg==
X-Gm-Message-State: AOJu0Yw7KXnU+xBtX0/igg7/OsrsCexNjxOWNbeTFRhmR7KDg83MRVxb
	f/7jyah9KHuTTvsKZxLs5XhFh4Z2bdHGltvkGtt9kq0EjHP97Ssx
X-Gm-Gg: ASbGnctDpoieCMK1+vTrfabbaW2Tfzttrc9BWaImUoXqPpFYybfP71E6YkzpH8T3CtN
	WNRskXP9HqgFGqGi1u8jQiSqk/RxM68uFryeyd4+1sHvV0BaAWwwPXCExBIfDnuySM1vI3jN4+D
	R6XK/vsco96+/ySG+qUKyTBMv2qXAi4i+HqOWtvI5b7vZ9+pJUwi77rJaytX3oHqNpyNB2cz14O
	sAXpiT42CmA9eEaOBD3fh7K9Is4jflZfATAlbs8zTbZftKZXkl4m0ceZ1GqntC1hyI0xuzuKnK2
	J1rdAFnAxF/bV98RmCZhqxtheo3UKzWL6cAJqgRdlTUA
X-Google-Smtp-Source: AGHT+IENWja7eCRJA8d6W7Ml7XfmtZiaGFW0aln8/2Z13STLpRWoic7vxKdDPOJsLKUIuOpP6kz1MA==
X-Received: by 2002:a05:6a00:ac2:b0:736:3be3:3d77 with SMTP id d2e1a72fcca58-73c267c9faemr1353376b3a.16.1744790285707;
        Wed, 16 Apr 2025 00:58:05 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f8276sm10103426b3a.100.2025.04.16.00.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 00:58:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 02/13] bpf: Compare dynptr_id in
 regsafe
In-Reply-To: <20250414161443.1146103-3-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Mon, 14 Apr 2025 09:14:32 -0700")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-3-memxor@gmail.com>
Date: Wed, 16 Apr 2025 00:58:01 -0700
Message-ID: <87r01s1qt2.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Now that PTR_TO_MEM can be invalidated due to skb going away, we must
> take care to be more careful in regsafe regarding state pruning. While
> ref_obj_id comparison will ensure that incorrect pruning is prevented,
> since we attach ref_obj_id of skb to the PTR_TO_MEM emanating from it,
> it is nonetheless clearer to also compare the dynptr_id as well.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

