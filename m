Return-Path: <bpf+bounces-23289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4D8701CA
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 13:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C788A1F21831
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC223D38C;
	Mon,  4 Mar 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCo+o2RK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CBC224CF
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709556371; cv=none; b=Z56UT5wojSG1o3aTr/EAwIc1WKGKndD3k7q9Z59PBBhSudt1RjqMz9iA2JmLBK+rm6cnpDhtDDUFxAWrPq9XyF4FxwLTiHNebbs4fY2A1Yy+kXojzstXmN9qiqFi41RyfDPRPO//yUV0sOR28WE9Y4maVrOicNY1ijRHgAIpZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709556371; c=relaxed/simple;
	bh=HT7NfhkrxeeThREnXiv5aDoaQ5OHRY/8haK8zNXzsSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hEz4wOcfxyS9hGhaK9527Ows8BNQ2/JsXKfqEMuifLPUrXYu+WYo3zcCYaSkeJf4xcdreoFQB3ZKMFkR1T+Apv286Gjl5rnlgJsKiVfTLT75vPYEFjp9D5elrQj9PZWkZHK4T8vOro63SMg2tpJ3Ln7EPvRahGS1lCQ4OkBbUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCo+o2RK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a450615d1c4so220506466b.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709556369; x=1710161169; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HT7NfhkrxeeThREnXiv5aDoaQ5OHRY/8haK8zNXzsSE=;
        b=dCo+o2RKPUf9Lp0ht8sa2CUiDGqBg+dvbWibPGVwRJTq9pAN+iHQkt9SZusGmmC7n0
         zNNLgVMm9TV+TDPWNFfPSEb9esRjh7XmZrlRTX+7eRyeDA8zU5rzSZsOJnKlBdEWHTQ6
         y6ae4gL2xuJH5yzlHQnN3116q5+hWVu1SYE/bxRSCdvByDvBs/Kf4u+6skRLbY/9LSC9
         Ghcum0m/YEHi1Ewy5N7S/5uAfosBrgYQJefZtQmF7RQADCrNyAZ1SbgPb1MUn1UYxdUU
         e1+jNb2FWvjdOsQqIsf5t34pwPqp6/iv7KuourDH102MZYI25ugbZc5Tqd1+586p3Pv0
         V55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709556369; x=1710161169;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HT7NfhkrxeeThREnXiv5aDoaQ5OHRY/8haK8zNXzsSE=;
        b=DTksRedbxKWriTeiHsMUgwJQI3fUyv23BT4jX7XeK2SHHgDZGifJ6LXE+LvWMeh5bj
         MvlB0Q2kH322M5zRF5nNUj9c1pxf6TfreQwaQjqFfeTOY4LG1XoJsFzTTHWow2hGUtEn
         ohchpilXzhsjPk/pXzCRk6S9IAmDe8tPlHAXcNdqu4mYvD2TFG9SRpa+g6o8N2WpJ9vQ
         gB/SNEcv3oHVYzRwzS56qoE40TmUwbHREuHwsyNvepUKAmDWaHYexDyLVCYsdy1iM9mU
         mmnsZYyXYZWYPugDbjoeRxicg11cZFbrGpH8q3TSFn4jGDT1ewnL2peSWtuud+VYDZgv
         3cKw==
X-Forwarded-Encrypted: i=1; AJvYcCU6QHXGgqa8AFf37oGoiX/bMM++/hQdFjCc4wA3Uz0w75vZkfCeBfTZko1vmNpzQdHaynTSb2ymPGsWqrtS82gPRL67
X-Gm-Message-State: AOJu0YzCFqm9upBuVozuYB7ZLgDwXnHB6iEqPWaAd0faMZN5df2QSlct
	LSOQKS6K46evw2ee0pIurSLdkJ8XmvAS9TxoPEnp3opWIgds3awa
X-Google-Smtp-Source: AGHT+IGyNupPARYdos8gZXuc1CiaMwwvEQOzpIFV4gvZPSVXd9U04iItdRJukisPa4oaDNi+K74KYQ==
X-Received: by 2002:a17:906:560b:b0:a45:7dc6:29f6 with SMTP id f11-20020a170906560b00b00a457dc629f6mr735014ejq.31.1709556368323;
        Mon, 04 Mar 2024 04:46:08 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ti9-20020a170907c20900b00a43a4e405bbsm4796082ejc.115.2024.03.04.04.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 04:46:07 -0800 (PST)
Message-ID: <07f7315efef78b7a19dec16b59b74b15f7b97dd6.camel@gmail.com>
Subject: Re: [PATCH] bpf: check mem for dynptr type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Haojian Zhuang <haojian.zhuang@linaro.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>
Date: Mon, 04 Mar 2024 14:46:06 +0200
In-Reply-To: <20240303023732.1390919-1-haojian.zhuang@linaro.org>
References: <20240303023732.1390919-1-haojian.zhuang@linaro.org>
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

On Sun, 2024-03-03 at 02:37 +0000, Haojian Zhuang wrote:
> When user sends message to bpf prog by a user ring buffer, a callback
> in bpf prog should load data from the user ring buffer.
>=20
> By default, check_mem_access() doesn't handle the type of
> CONST_PTR_TO_DYNPTR. So verifier reports an invalid memory access issue.
>=20
> So add the case of CONST_PTR_TO_DYNPTR type. Make bpf prog to handle
> content in the user ring buffer.
>=20

You are referring to bpf_user_ringbuf_drain() helper function, right?
Could you please provide an example of program that fails to verify?
(ideally the patch set should extend
 tools/testing/selftests/bpf/progs/user_ringbuf_success.c
 to make sure that intended use case is tested).


