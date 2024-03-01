Return-Path: <bpf+bounces-23166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7774E86E785
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D074287DBA
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3041119F;
	Fri,  1 Mar 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP+R9NCf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC34848D
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315048; cv=none; b=opXXvGMe3UMX3SWoFsdMdp3Rq2RmXaHbZ3tjOtbTxOb/LDBURKAoFKSZkdk699oZu/elO4rYbx16oFGIhFSv+ie3QsxEw68WUAVlgRgDzbwc/0vEAe/6dBcnEwvD/zfIZxnOxMEOoJNpvnQ+h8swX3tbSaXbOlNqFQ0M6ZhQ2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315048; c=relaxed/simple;
	bh=mfcqekLhNHIuxedgOq2IGFOeSxBkF78GemzOP4utyNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsK03mUzYHLWtLTSqZmaIAlCVPD7nLVY1CCx3u1Ai3VR46XEaQJyGO+z+i8thDti1vXcCiaw4dmEJVuLdH1PUIvoKflEgfPY1TUuXEooIo7MSA3s4Ddb3PKjX70/DG4Q1tFUvWr2fDR+YUTKXDchA8K4gC0i1GW10rNUJiSWQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP+R9NCf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so2370349e87.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709315044; x=1709919844; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mfcqekLhNHIuxedgOq2IGFOeSxBkF78GemzOP4utyNY=;
        b=UP+R9NCf/+hAHLcKiuWB4ZV3LsPQHzD13M6ThIfrKdN2iYnZUrt5vRQb09fYjCV9Zx
         /Sn+LStQNk2jv6/FhQ45FodXgjtn5Gh6y+3mimQr1eJSZxjZadClGwbAcVhckderWuyc
         SJka6H83BYoj31L8lTS5TOuIqW78qLvDLGgESePn3nHIo5njtfvcXzFlA32Rv+JjtOju
         sQmo4VHuPIgFbh2lh5QI44ayZ3f4OY97pZoDDkW21ogF/hgxweNg/bvcg3xljZNAq1re
         kJiIHkVl6Xcdq0cf9jWXG6c9/hWGDunFVx+e9kJMAvyi0prWDqGO+dxFvhvkiLrvQURc
         0oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315044; x=1709919844;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfcqekLhNHIuxedgOq2IGFOeSxBkF78GemzOP4utyNY=;
        b=bVY+xBoJfto504Nb+SZYuBxY5C2FU364rvT8Lc3h/NyX7Ahrk4bWE1wok6buCsO0+n
         sKu+YtOK4ulLrSFg6DpILJvTK0ZZP1Dy1anU7LTYTkhi/pXr8ko1gFwo+psR1ALRBD96
         Q0WO49duamuMiG0lZtwulfXJxrOwoVmlPDAw93tFWcfVdMIkR97k7kjXaLKgojH5Kxk/
         XnQnO7ch3WsJgRcWe1xIGYJJO/DJUPUfmsnthBD5x/SUyKFuxOmaEX8utoNEoSWBB0uf
         k5i7mOBgUufm1UsyainDdE97quJN86JEDysVhiUtqU/WJDE+was4/Vj0TVwGVFH15TuD
         mcCQ==
X-Gm-Message-State: AOJu0YzBFUCaXKrezGFM7t5eVCaJc9rR5MxbnJP1vkBR78YfdbEOh7iA
	RQy0Bm9KiqBpykKtymd7FrT4iC7zYgw/PDukJFqn7ESIKC/zcRYOsBiygIFm
X-Google-Smtp-Source: AGHT+IG3bk2iKW/mgH99x5GMdvxpHs6B1J5JrMowx4B+kbMBZskd5Ww14eUzrG3GDvzDMq17vIvp4A==
X-Received: by 2002:a05:6512:3d1c:b0:513:3310:4062 with SMTP id d28-20020a0565123d1c00b0051333104062mr1988076lfv.64.1709315044360;
        Fri, 01 Mar 2024 09:44:04 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t5-20020a056512208500b00512e263d246sm687821lfr.296.2024.03.01.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:44:03 -0800 (PST)
Message-ID: <7d48c3fe1e4ccc4622a082ea3f3c25ca79be4086.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on
 per-instruction level
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  sunhao.th@gmail.com
Date: Fri, 01 Mar 2024 19:44:02 +0200
In-Reply-To: <CAEf4BzZjps4+teYzWw8=8Jg0M59bCVRaB_0zLNTmfveBQ63C3Q@mail.gmail.com>
References: <20240222005005.31784-1-eddyz87@gmail.com>
	 <20240222005005.31784-3-eddyz87@gmail.com>
	 <CAEf4BzZdDoaVw28RahC+8hV+kReYjTdfJQdaMXJEkUUgih8j2Q@mail.gmail.com>
	 <b1b259639635e9328bbbbc8e0683b14242f177e2.camel@gmail.com>
	 <CAEf4BzZjps4+teYzWw8=8Jg0M59bCVRaB_0zLNTmfveBQ63C3Q@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-01 at 09:34 -0800, Andrii Nakryiko wrote:
[...]

> As I mentioned in offline conversation, I wonder if it's better and
> less error-prone to do linked register processing in backtrack_insn()
> not just for conditional jumps, for all instructions? Whenever we
> currently do bpf_set_reg(), we can first check if there are linked
> registers and they contain a register we are about to set precise. If
> that's the case, set all of them precise.
>=20
> That would make it unnecessary to have this "before BPF_X|BPF_K"
> checks, I think.

It should not be a problem to do bt_set_equal_scalars() at the
beginning of backtrack_insn().
Same way, I can put the after call at the end of backtrack_insn().
Is this what you have in mind?

> It might be sufficient to process just conditional jumps given today's
> use of linked registers, but is there any downside to doing it across
> all instructions? Are you worried about regression in number of states
> due to precision? Or performance?

Changing position for bt_set_equal_scalars() calls should not affect
anything semantically at the moment. Changes to backtracking state
would be done only if some linked registers are present in 'hist' and
that would be true only for conditional jumps.
Maybe some more CPU cycles but I don't think that would be noticeable.

