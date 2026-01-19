Return-Path: <bpf+bounces-79514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D1D3B836
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 21:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D857530230ED
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D822EFD91;
	Mon, 19 Jan 2026 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8u+qOr3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9AD2C2346
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854315; cv=none; b=bXcb9fBhqrvt/tm14f2epdBwVlh8F97cmiJHsvyEnGqJO/EnFeizAL00UXSza6FtlgUWDXYjpeMjikIPYNAIhxK9cLharhNGCTCxm5cfz8FjjHh+CS/Q57AlVK1eDGeQsCc1fipHMxK1Gnv11M3fvDwp+ANNrEoVP1xeKxm5gOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854315; c=relaxed/simple;
	bh=qVlx/AweOaEi5+Z6aS/giYLu5HeFuCMEDO6+VmV3i/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MwH3g30v27pO2+xZ9BEBbqcjWRC/xROtS2q/J2SDD39Pzgdk3lMG+eYEDAmU10yctuItqoW6l7qP1TFG3kMAWSa9cs0KzeiUpBJtRsCMuXEnCPQyj7eaW/ay5vglQD0EQmy0KDEG9gB+2RnSnE/ysyUYfu/x/IxZu2ofE5vVkxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8u+qOr3; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6268012eec.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 12:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768854314; x=1769459114; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QG6Vcjfp6R7A27lQkwL0j3R742MpCwEPC/xPli+XDhw=;
        b=J8u+qOr3c33nkTrO/FNrTlYABgsy2wG5cciZYv7758lRHgkr5rztJ2R80bYaA0xidR
         w2N+PKX3e6zSuEMaTcRgdAARU1zr0H6VH7wTd6wTnAHmL42H6rAZ3s5TOMkAotC7Gc5E
         OkkZigebUaBrIVqNt6qgQwgzHVrwKTJq68hS1jDBo/wpKrIx0zzpwZnAQiKqiN9LDhCx
         783CrteznpqDND75SauR193UlKfM+tbEti8IrDfZlsJ4Ta3fzeEExuoPK9tUMn7Kho3e
         QBLUwnsFA2W3E3Hnc9ngGyDwfJ3ZpszR7wd8l5se2QckRsU8Io+OL1IdqtNsPP0ZzWjT
         sRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854314; x=1769459114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QG6Vcjfp6R7A27lQkwL0j3R742MpCwEPC/xPli+XDhw=;
        b=N9K8GLbxr1snWjU8ML7KEzIJiFDNE/K4usJapysVpYIHhkmx771BG85gSZsz+62Ycd
         +jxGi/v0xCIE/c87iARHNnXlblDTTK2mg4OkgYnf1v4JcVg2R9qAmfkWmT3FJb0JIxTo
         yGsFCDkf8XYBfWZJtAiEp7CwvuorBwXo52UmTRcoslPZUrK87kHfPDFcMNMMXMKkIVEr
         rCqPHX9WlxzHSpYkx9pd3QDV8zfeuiebQ+WzZCteMka1QDxEfBAA9dFCMfDKOcIr8WXP
         6pzS9aJBhDJPO0gMTvLG00MB3bvOq3LLTnrJIaxynCcaURic34LvRctFPaCcja4KZqeO
         F0Jg==
X-Gm-Message-State: AOJu0YwZv9BWPWaghxn96yRZP5yUde3SZB4pf/SpbKmbaaH3uL82ktJg
	23+x0F1Zain6hQlDNu9U+LrVdsFa+b+hYw8us/bZzvPhjfP8Dm+IoYdY
X-Gm-Gg: AZuq6aIZknq+58c7Gl2i5R3Hf67DZ+IGLbfxVcGa5w7sdHu5D9YjwHUqiggyTKxQfWT
	pCb4damHE5OGQtygVnZTgSGaaVSsxTykxCbVgRa+Ffw4AYIbsTuzvbnop+OMAr3si9PL3M0MVwH
	tOGGdWfWP67C33wdW3AGCmgsRT0KDRmQFyuOAsk1pK0Lx8lQN7dIWToVpPGMmfrJ4Lg5q5TCs0/
	RU2AHRQIWMe9nZPIZA8RzC5tAKfBHDw/6Mj8QNyv6kU8v/wil6zCdOXGV+JfmWOe+Y5l7BkLFm+
	onA2ejuMhrJsQQhQ4zVfI3tpTCY0ujgI/mV6Q57v0nJU9/BBTB+8jq79YYtnfLtSoKx1kYHoObD
	lX7CrWf8Fpgw88YSZtOFtqz5mZWnp91vkSK9fYxkTiBx/wFsWSu9KBeiaGyKKkFZOKLLuHli3BG
	xps/0u5U6iJJsuKDU+pRgRELEzpxUW2dRKMIsRjHGzflEM0zZWK3j6z45QMoLPvORE/g==
X-Received: by 2002:a05:7301:4184:b0:2a4:3593:466c with SMTP id 5a478bee46e88-2b6b3ec9ddfmr6785656eec.8.1768854312077;
        Mon, 19 Jan 2026 12:25:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3503ce3sm14350271eec.12.2026.01.19.12.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:25:11 -0800 (PST)
Message-ID: <600177c05c552f470cc5e25c7dba6990d96790e9.camel@gmail.com>
Subject: Re: [PATCH bpf RESEND v2 2/2] bpf: Require ARG_PTR_TO_MEM with
 memory flag
From: Eduard Zingerman <eddyz87@gmail.com>
To: Zesen Liu <ftyghome@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Matt Bobrowski <mattbobrowski@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu	 <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, Shuran Liu
	 <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni
	 <haoran.ni.cs@gmail.com>
Date: Mon, 19 Jan 2026 12:25:08 -0800
In-Reply-To: <20260118-helper_proto-v2-2-ab3a1337e755@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
	 <20260118-helper_proto-v2-2-ab3a1337e755@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-01-18 at 16:16 +0800, Zesen Liu wrote:
> Add check to ensure that ARG_PTR_TO_MEM is used with either MEM_WRITE or
> MEM_RDONLY.
>=20
> Using ARG_PTR_TO_MEM alone without tags does not make sense because:
>=20
> - If the helper does not change the argument, missing MEM_RDONLY causes t=
he
> verifier to incorrectly reject a read-only buffer.
> - If the helper does change the argument, missing MEM_WRITE causes the
> verifier to incorrectly assume the memory is unchanged, leading to errors
> in code optimization.
>=20
> Co-developed-by: Shuran Liu <electronlsr@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
> ---

Note: this patch no longer applies properly because of the change in
      the check_func_proto() signature.

[...]

