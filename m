Return-Path: <bpf+bounces-46684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC89EDDC1
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 03:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291FC167FE3
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 02:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C217126C16;
	Thu, 12 Dec 2024 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQzk1Cdr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B01257D
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733972063; cv=none; b=Ksag5H4j5on+CfHNC8F/xXyinAOrMIaS5QmTeU5cQlLl1aO1Q4rJ0W5n+YsDn583Bg5lm3WgeyY9AMDH9Z+Z5V6Bw6pHdlKr2fMqNhKQ7rF1mUkD+yXPE/Z6NtMMjnRBL/5pY48gs3nSKWdZz2B3jXVCelJFe+zmH/HuhKx+3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733972063; c=relaxed/simple;
	bh=GuUpultjiUdSGlOAoGGhf3Vwl8gCSGudmc5zGD/Ot3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m688I2nCnUT2Soy/9oBNzUvE0AyMA6XO4IkN4S+8rsFQ9eqKICrpxD2MkTNMXfMgKcp+fNmyJwnxRucx3VkJY9bDSWCWbpHD5zYC5iHZtNgPcnEhPPVUOzKkRd2E8O6xEiPk/Ar9YXiegPsSOI7/leMRrhPy/39nLJwb9lTmfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQzk1Cdr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so25076f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 18:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733972060; x=1734576860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuUpultjiUdSGlOAoGGhf3Vwl8gCSGudmc5zGD/Ot3c=;
        b=PQzk1CdrVziYdOsso5ZTMAx3FvDyIEx42cihjT7l8eRe22GOFedH9O9hSUq4TzPUiV
         Nh10Y/9a1EG0hivdq+ZFYZGGpgHkKea76+9jMryzN1ixxgqvWKhsbd/gzgBTNzcEt0bW
         8aVTYzPZfb8/FCZfMM5dRqpJSSlBEmhUKBzeg3HSTIK9c3/ND4NvE6Hi6Kk0NkQ7hqNt
         a/H7aoIn2nhou15nW/ebXW7oKu5BoUwi1+Dlva3AEiQyEyJCqVHy894c2ynlnk53SCUD
         XyIhxpKHu/SGQRdb4mj0kf0t9nZ5FNXt9l1G3TIxuQ/Br91G+/Tio/Mm47o639x5KNPW
         34EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733972060; x=1734576860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuUpultjiUdSGlOAoGGhf3Vwl8gCSGudmc5zGD/Ot3c=;
        b=Fu5MNhLN67jEjhfDDo4cFB7b7NoabE6Pa+kjTzjxZjScJEfqlzL+VmGHhUgpC1jOg8
         rLot9Wp+3hqIq75hLbXdYaUdqZPOG7bEenJJvGSmbCdyEAbTAxuh4/oxo0eFzmvZStju
         hAxKwcIJ6gqad2J0maaCjkKsvwWM3g5BG8KI+RKzAquxgu1cnr89tZrtT30Hnm3RXave
         XqL65IMbcLTxLm9WmY14O8zcd/4nMR/iaT5A/qiHaflNr7Pj0DSp/rsl0lLApVVm6eoW
         kDkeed2XrMUM2LvVzd+d+D+/OCPBmCrlPNG9aDvMKHnc1yPF9gRuIAF5+Y7tm1hJCuHO
         NJzw==
X-Gm-Message-State: AOJu0YzT4UMMKnvo3x5PzYjD8eLBvgzEyhzuEdBcNuBwotWcyEk7IhGs
	+0B5FYrDdOCMhTxvhsgZoEJeunpFKdDDITp1R50v5VdfJbtEnb0QdmiUpCODJVaupmHqAMQ0dnP
	YwmFn/zm/R01ofSJU4bEMncF5aD8=
X-Gm-Gg: ASbGncs6sSWDt1AQPDSYmrEKCStPobPtjoZ9KTNwaPQxhHjSeqgpfKT4dsXOakkqboh
	1xLTkdRxAbsRP8w2re5dBy5F+996DcZ+3KPIz3O2OSWiLx9dQApJfWw==
X-Google-Smtp-Source: AGHT+IGuPbV8RFNbEtoMp5mGkiWjLLghcjXRYcNsjqQuwwA9kDP5s2oQrYo0LDLuWqojHpATwgHtSG8qbjW5lC77hHk=
X-Received: by 2002:a5d:6c64:0:b0:385:f47a:e9d1 with SMTP id
 ffacd0b85a97d-3864ce541f5mr3934608f8f.17.1733972060348; Wed, 11 Dec 2024
 18:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-6-alexei.starovoitov@gmail.com> <4233d087-4610-475e-bc79-14feaf2f7cfd@suse.cz>
In-Reply-To: <4233d087-4610-475e-bc79-14feaf2f7cfd@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Dec 2024 18:54:09 -0800
Message-ID: <CAADnVQ+cOQdd42sVuOv04Q3HJhvAuBdDf1SsEPW8hZLy0CDhDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] mm, bpf: Use __GFP_ACCOUNT in try_alloc_pages().
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 4:05=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 12/10/24 03:39, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Unconditionally use __GFP_ACCOUNT in try_alloc_pages().
> > The caller is responsible to setup memcg correctly.
> > All BPF memory accounting is memcg based.
>
> Hm I guess if there was later another user besides bpf that didn't want
> memcg for some reason, a variant of the function (or a bool param, to avo=
id
> passing full gfp param which would be thrown away besides __GFP_ACCOUNT)
> could be easily created.

Let's cross that bridge when we get there.
tbh the code that doesn't play nice with memcg should be shamed.
I think CONFIG_MEMCG should disappear and become a default.

