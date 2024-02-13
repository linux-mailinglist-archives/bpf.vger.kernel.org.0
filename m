Return-Path: <bpf+bounces-21870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20758539B5
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60601C22962
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A0560864;
	Tue, 13 Feb 2024 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4p/tCfG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92985605BE
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848096; cv=none; b=feOLNo1AslDQKjgojqric2pmQT3Gwa7ZYmg0AU9thV5KpikWgRtiRW6trWZTQ+N3vXbXyJTOcJf1qzY5dmObk3R4w6mWKESKx6Fm15AVUKrtSYyZ3GEEhxeCi8T0AqvfKSvJDjtwqoXblyuGdX+tQppolIXgiLCXzLnjJepUIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848096; c=relaxed/simple;
	bh=240vc5Fn5uIgJCZ7uffEJij8mNuvPSDdLcE28Kg0p4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZY0f/LFHSIDRw86O8iloWBaQVrjUD5ugn6oZFjomcnOl8EKpUeVQBxIOdvHOY/aX8aOo7mvxiBurGYPwx/EGocEKEWiVRMzduKYh8zJRPZ5BCEafJyLr+m3Rg6A0QcEBZ8YFAZsuCAdwv0DLzSHdmLPSeHLmHhfOAGghXWeHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4p/tCfG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so639433066b.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707848093; x=1708452893; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J2HbGKitMz2Z+9QA6FLuUKlZr7NnYpNYYzJZ1Mo2yUg=;
        b=O4p/tCfG5R8YItvOE9F2iHaUVfee810q3oc43fUqspFbSTTbmik6nJ4htTyjEDLpgs
         SK9sSMJtzZ36AsFDADjqTLc7V08TwAfTZGjVQynOegyfns5rDCXURobgd0z1kYhUAVH9
         ADYV1Q0q7lymFMWAqmD2QHWYPE/wNeyHD3TgY9IRwYcjy9XHUgSNAPFZVzEW8mf2yS+J
         XAymHKbHe4S+gMsBUwYUwW7VpyHY+PqApdOV/hlr/FuAsmuqS9/RYXwFtfzhvxhGP0XZ
         vXZZ0BOJjriMDSj6QzGcUNWYz9i/F6LWRsg4LhrqcD/U1vwLyO4ondL2IAZK4bnaI6dQ
         h9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848093; x=1708452893;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2HbGKitMz2Z+9QA6FLuUKlZr7NnYpNYYzJZ1Mo2yUg=;
        b=eXnuJ0DKL+W1OYWE3K1LTTDBFZTb2QzqBS3L3KBljOb8253qbEEB5bxzsJQW//oNK2
         3aRXk+8ppOY5R60bbNQsDCp0/cYh6tLBQNgRmos1xyujR2gCcpMOPMtqlWiAnB7MG7BE
         btLx0YNz1O/YyyCHrDRQ41ws1JfL7gzqeHykmGwHteFL/LnV4rqHKCa/xvz3+O5nqEjH
         FHcruWqLhQpTu9Zbtpb8egAaI+TTxQu92N7Ql9QRQBVU3HBgDmOA2iVfuE2eGTAZfKSf
         O2rX3gNWccyA28ghDdrXHAw29UsEc5544b19sSg9/xq6UY8rAdyna6HJUYmF9oo90tna
         Y8hg==
X-Forwarded-Encrypted: i=1; AJvYcCXcmbvZn6Wv1ygIcm2269+32B6m5VJxP6MZJig+FfX2vGbL7MmENppVKjRDH/v4359XsF/dnf0lK+O2FRF5Cde+a3j2
X-Gm-Message-State: AOJu0Yw+lwUr2T4od+LEbdrUsoKywKwil6lXftc/aCrGwSxzX996hedR
	Q2tZWnbVILokwiKJVYqfE/u7vtAsipBvl4w4+uAWZBeE3Y8kgRk9
X-Google-Smtp-Source: AGHT+IGatHmRighOl4OmZPsz4sQDLxp0mnlBWe1oZq6EL5xIThkQJ37Jh+ZVmNmPX31Zkx0iG9hqJw==
X-Received: by 2002:a17:906:5f8e:b0:a3c:8770:3795 with SMTP id a14-20020a1709065f8e00b00a3c87703795mr85963eju.15.1707848092623;
        Tue, 13 Feb 2024 10:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfSyn5Ah47v3KrQMgx/KkOCa10Ixm2v0awRFj1ge4cLJAszsNlvAi5C/rcrLfvlr0vAltFoIePc2VkpgH6elGIdsc4fSNrDgSG2wnTBM4R8HxKv/zIWytC1+qbJrD6ZwBgXsvjFpygjqeeOp7RXT7jPxRitLDHBLMMrx8hvibZRaDMxIVgIjuFqf/6PL068ZiY8ufgJ4XfjMiaOsSs63ZsmsN53ulL
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id vu7-20020a170907a64700b00a3d1cce7c31sm433804ejc.211.2024.02.13.10.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:14:52 -0800 (PST)
Message-ID: <0e5b990eeaa63590e067c8ac10642b6bc6d0e9a8.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: check bpf_func_state->callback_depth
 when pruning states
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, kuniyu@amazon.com
Date: Tue, 13 Feb 2024 20:14:51 +0200
In-Reply-To: <925915504557d991bf9b576a362e0ef4a8953795.camel@gmail.com>
References: <20240212143832.28838-1-eddyz87@gmail.com>
	 <20240212143832.28838-3-eddyz87@gmail.com>
	 <fdf38873-a1e2-4a16-974b-ea2f265e08e1@linux.dev>
	 <925915504557d991bf9b576a362e0ef4a8953795.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Updated diagram with a few fixes, line numbers would be removed in the
final version.

--- 8< ---------------------------------

 .------------------------------------- Checkpoint / State name
 |    .-------------------------------- Code point number
 |    |   .---------------------------- Stack state {ctx.a,ctx.b,ctx.c}
 |    |   |        .------------------- Callback depth in frame #0
 v    v   v        v
1  - (0) {7P,7P,7},depth=3D0
2    - (3) {7P,7P,7},depth=3D1
3      - (0) {7P,7P,42},depth=3D1
(a)      - (3) {7P,7,42},depth=3D2
4          - (0) {7P,7,42},depth=3D2      loop terminates because of depth =
limit
5            - (4) {7P,7,42},depth=3D0    predicted false, ctx.a marked pre=
cise
6            - (6) exit
7        - (2) {7P,7,42},depth=3D2
8          - (0) {7P,42,42},depth=3D2     loop terminates because of depth =
limit
9            - (4) {7P,42,42},depth=3D0   predicted false, ctx.a marked pre=
cise
10           - (6) exit
(b)      - (1) {7P,7P,42},depth=3D2
11         - (0) {42P,7P,42},depth=3D2    loop terminates because of depth =
limit
12           - (4) {42P,7P,42},depth=3D0  predicted false, ctx.{a,b} marked=
 precise
13           - (6) exit
14   - (2) {7P,7,7},depth=3D1
15     - (0) {7P,42,7},depth=3D1          considered safe, pruned using che=
ckpoint (a)
(c)  - (1) {7P,7P,7},depth=3D1            considered safe, pruned using che=
ckpoint (b)

Here checkpoint (b) has callback_depth of 2, meaning that it would
never reach state {42,42,7}.
While checkpoint (c) has callback_depth of 1, and thus
could yet explore the state {42,42,7} if not pruned prematurely.
This commit makes forbids such premature pruning,
allowing verifier to explore states sub-tree starting at (c):

(c)  - (1) {7,7,7P},depth=3D1
16     - (0) {42P,7,7P},depth=3D1
         ...
17       - (2) {42,7,7},depth=3D2
18         - (0) {42,42,7},depth=3D2      loop terminates because of depth =
limit
19           - (4) {42,42,7},depth=3D0    predicted true, ctx.{a,b,c} marke=
d precise
20             - (5) division by zero

--------------------------------- >8 ---

