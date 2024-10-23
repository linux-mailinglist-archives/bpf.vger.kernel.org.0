Return-Path: <bpf+bounces-42935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941B09AD300
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290B4B2289D
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101CA1CEEAA;
	Wed, 23 Oct 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsJOAwre"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B041B652C
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705052; cv=none; b=Kb6bA3Vkd57drQmtrERtPdG7gkhYY4zXwF21+9l2aNwGbdP5m96XkiEVBftzVQ1z2xlUwABlFHgvH4hNsTxHb8lU7kbX9EmYMqwtUKkkoqyrStY42Yy53gd9USiFA+lQ8lOvAaz3KYUG+BfnkZo2J0Rs80Zbnu8b+t1RgSMESbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705052; c=relaxed/simple;
	bh=BepoKxjiUpRG0KEmu3d9TZpJi9SS26L19Zw92NS/9/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZCGERZufYUCaBPcvwZ8W8my3j+WNd3YjruybHh1MxjbVyq3fK/DSNg13p3+M+YkGubD/PifqIo7LGsmMEjCS2OX7xAaRbxK7OTZnxbWzLwWCCRf8D0kwbjz1ya6SyIq5YHa/Cr9JSPoG5IBsweJU7iz2GrLSUVjVbOdCOh1hpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsJOAwre; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7163489149eso26428a12.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729705050; x=1730309850; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BepoKxjiUpRG0KEmu3d9TZpJi9SS26L19Zw92NS/9/Q=;
        b=MsJOAwrebUV6serk7JT/F//34cOJSdeBM7/0sKv4IDXSVmyN97LXo0PMSA1FwV8v76
         W70Wf5aDed05iplBMtKGU809V1n3fvaO5ldMJJWHXe+J7b4ZbE96DUnh1nXkaCQtaXmr
         fuElDCVulxHJ4LtRJn6yINg93WxAuMw1zxOFYb145qWZcs0t0fnBXyJiDgz+GvTfFUf2
         LqOCPLjc6BXwBl9jFJrC3bqF5V8G75ihOjesLo/K8cnUG3dpytqFl2qqhrcuHI+h7iga
         Ft/NYxC3Q3oQhde5Ni5akbGhXn18XNcz8g3QmeakYRImrTmOGZVOB7KQUxiRBdiBiEip
         RNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705050; x=1730309850;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BepoKxjiUpRG0KEmu3d9TZpJi9SS26L19Zw92NS/9/Q=;
        b=DGMH4XSv/wo76sXbQ+AcEymOcaPZ5/vnbFfCj1UHWqu65V/i0aRcy87yHRp0H0h3XH
         CtWpnTfq770K6Skj21HVHBOQ0A74Bq7oHxLLo0RsYTFY8VVpjwP2EYhjq+1/ZoB6svkW
         PqH4xuqPCr34zhKHCl6polzDFODORUou2RYwrh0AYR0C1o8WdNGy2Vz798yv3/Ky4i9n
         LheQtmBulyXcazyIEBkhUsXmEBHnvJbqQLyWTjsA7ODKbghxnIbVM3Hh2qSDeKFJiwne
         lCNmorXWgmzzkfM5tVEhvo68nF/cjLwVqFFLM12McLfiuOqQ2rgLvKZMSGpxVuig/lvE
         sVTw==
X-Forwarded-Encrypted: i=1; AJvYcCWlZwKWxkp+4tmGaj0Vwmh3QdR7GkP4TffXYNAa3+I8WqJbxJ1hChylimLI40QXDwrDUPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+R7fqXRVoHdV0hcwxVPVzVxeJtzMrpOhaYVDqHdUp+m3hgF+s
	IgVbwlwSolnfjcTqrj99w3OH/Oc7sR0ZC7LhVgTn4Txa1v8B8waC
X-Google-Smtp-Source: AGHT+IGa4p35wnl55+0L1lTqbq0LkInNyb9GWE0iDGw9YzApXWVjg4T5lYO1XO6FUCjX2EmV4zYxeQ==
X-Received: by 2002:a05:6a21:a34b:b0:1d8:a759:524d with SMTP id adf61e73a8af0-1d978b0d162mr3707275637.18.1729705050475;
        Wed, 23 Oct 2024 10:37:30 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a:cbd0:608d:331f:ec5c? ([2620:10d:c090:600::1:bf27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d74cbsm6629690b3a.138.2024.10.23.10.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:37:29 -0700 (PDT)
Message-ID: <103921223376b39aaed144d1238d77e8c729a66c.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Extend the size of scratched_stack_slots to
 128 bits
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>,  houtao1@huawei.com, xukuohai@huawei.com
Date: Wed, 23 Oct 2024 10:37:26 -0700
In-Reply-To: <CAEf4Bzbyz0+mKQZ+nM0X0RVb-z4F0e1idu1mg=EG31TMWwaiyw@mail.gmail.com>
References: <20241023022752.172005-1-houtao@huaweicloud.com>
	 <CAEf4BzZpL7faQh61X_pqr+57qxzDD1LcxWgUqNZCCKh1z5hV9w@mail.gmail.com>
	 <42a4ec6bccc867d18033583b1dfea0736ac1afb0.camel@gmail.com>
	 <31d0895a217388dfe6bfa5b74c4b346705f894e4.camel@gmail.com>
	 <CAEf4Bzbyz0+mKQZ+nM0X0RVb-z4F0e1idu1mg=EG31TMWwaiyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 10:33 -0700, Andrii Nakryiko wrote:

[...]

> Using two u64s to describe stack slot mask is really-really
> inconvenient.

Yes

> and increases memory usage by quite a lot. Given we intend to have
> insn_history for each instruction soon, I'd keep stack size at max
> of 512 bytes, even with bpf_fastcall.

By 8mb for 1M instructions program.

> Is it possible?

If we drop this +40 bytes slack space everything else should work as
expected.

