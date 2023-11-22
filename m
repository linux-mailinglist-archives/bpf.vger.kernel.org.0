Return-Path: <bpf+bounces-15715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32727F5480
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 00:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D2EB20E88
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA232110F;
	Wed, 22 Nov 2023 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDtZA//9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111EED56;
	Wed, 22 Nov 2023 15:26:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-332ce3fa438so822512f8f.1;
        Wed, 22 Nov 2023 15:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700695602; x=1701300402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7VkYcNnsFbmMqIJfU51f8QLpPwwDdC/NMyz7h+wtmI=;
        b=cDtZA//9Sw+JOFYkCyMyhY2zY2c2txz4Kpj1XeVhKm5u+7C5Rb+l0DAjfta1JXKDrs
         ELcLhwxuBeYdZFCn3j/crUny0DA2Vj6AMyh4bWO3AqYDWOGDqtDGhAYNHlXWq8RnwFtj
         dkmTBPXvtFbjECuUgvN8CIQacxHjoQbfyUuRX5tKOqW7pVVXy+Yyr9vRU7Kc2J/e/Ye/
         6vCwm9q5E3b7BNCGJL7IRb2lfe5nHsSThCnM5jDUDki511E2vxFIVFxaiX4PzruBHYx7
         Q/OmgWwd8JZDIlgwFW/Me7E61MJ2rzzuDbiTScIAio3KY0oXAPZpv1PV8qeqKYrTFmz7
         0DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700695602; x=1701300402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7VkYcNnsFbmMqIJfU51f8QLpPwwDdC/NMyz7h+wtmI=;
        b=vzIUyltKHvVOkXfHbQXr9E8keiJ6ZOKFkldxQjITcZ0gvFB0bKBiwj0KjIxon4BB9Y
         iNMxGGJj51vmSUTFuFmInS7PC6rooNV1yuHEQIG4ZLk7dBWA0JB5wq69JaeZV8p23ZLv
         JfGrDPZzSUskBzYZjDDg/VohLEgaDSsWDeGxeeOS2s6/jYPfYm24gRDbNvN+AmjGcOzV
         M7v1eD2B+XJPxjac5hC+ReQjvrRh4nIbqV7PQwxpbCbCqQVk4D7UglfKv3un1nhjRAwT
         ht4ZHTWaIObBT79rhJv3G7aA5CyaGoskWkjcSrnzwcn4IA06dMX+5gDBgG1o9CcDfysk
         Po+A==
X-Gm-Message-State: AOJu0Yzq4DJeMHMD8OxHuuybbANlbXKNc+xgmYFn9QHU4JFmwCWG5Q4a
	ZRRMyeURaGGqd0BeFDpNABm/EE7FW1JJ2YbPktQ=
X-Google-Smtp-Source: AGHT+IGfGEiUVGG7HE0zQHGzL3N4NjEco3/qsuBFgzX6R2NaTwUa719PW5aRkLjb8pgJ8gAQPAoPbIdETyoWcoDKCtg=
X-Received: by 2002:adf:ea49:0:b0:332:ce79:cffe with SMTP id
 j9-20020adfea49000000b00332ce79cffemr624609wrn.35.1700695602263; Wed, 22 Nov
 2023 15:26:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700676682.git.dxu@dxuuu.xyz> <2443b6093691c7ae9dace98b0257f61ff2ff30ec.1700676682.git.dxu@dxuuu.xyz>
In-Reply-To: <2443b6093691c7ae9dace98b0257f61ff2ff30ec.1700676682.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Nov 2023 15:26:30 -0800
Message-ID: <CAADnVQJDwPgWoUyDnu1nzQAhpH1yTv1z6r6HrMzn5R_So_rCDQ@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v1 1/7] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: John Fastabend <john.fastabend@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, antony.antony@secunet.com, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:21=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "Global functions as their definitions will be in xfrm_=
state BTF");

Pls use __bpf_kfunc_start_defs() instead.

