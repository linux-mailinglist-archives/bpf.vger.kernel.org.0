Return-Path: <bpf+bounces-75052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DE3C6D7C1
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 09:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC6A24FB193
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F4F2F7475;
	Wed, 19 Nov 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEpBVji+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41D2EE612
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541311; cv=none; b=rCrNb1vppWXKLbdapL7RP/M0MUTdB9PHoFhC9cDhC/inEY7Y3mj4Yjo00F9/LKTcoo+m4Iz18Jkp1GDiOEPV6brSRVSKt+4YPg00JXPUEBSr3eTR/AWAAFILxyJzCCvRVPDWsy5h6j4I8y+I55QJ3/UUvR8i0/SLfkuDYUqqabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541311; c=relaxed/simple;
	bh=KJ9/NMpcrzGYyte93F99UGxRO1PLRf70w8JvyP2Tx1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jUUVtK11vLpc4lecjiatwYIboAh6sY1u2VO+6jwE+sv7Dk46q0EunI1WLq19QBYgTP2VeikGKLF6wZMnGz3xCOHbo7YfLTmOu0wKKl4Xk6G6vRVItDlJ4RkWhw3ckDrYGtSPXEau+RpMjiWMMf3wsp51IDQNvWLdkZLpt+DShd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XEpBVji+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso28483515e9.3
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 00:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763541308; x=1764146108; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONdg5ndzKakuL6/04KUKI5TEfmIUBE85zZXfPCFpXZc=;
        b=XEpBVji+zyDr0PxrSrD8y/uOoZjfrIuf6+qnrUdyKkP49QtypU1t6Qgvikwp8OC84P
         s70iI1t+wv0qN5nJZLjNJtT4pnf5w4cCt6YbEl86LUJ/nfNOMsn6JsfhFYunV3ErOuXv
         HODc9EKIIb7hYQmRXnQVI2/N0N8WaQ1A5cLFVA7r08Vvcnm7F8ArwTjN6KRsWYO6zp+z
         U+J/zaEaqwchVFWmAPFa9v/uKuaJ4FIUxu3IWIVphs587jYE2qLUwJPyc45RYy+/SdLl
         54t4SfiTluByDViMHjSBk0FUSO8ohJMYQZOqF+1O9MpnLIa5tDDuETQMdCt/XaqkNvhX
         L8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763541308; x=1764146108;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONdg5ndzKakuL6/04KUKI5TEfmIUBE85zZXfPCFpXZc=;
        b=iqekwDi1DBbOO3lyq0hR/MUbSzRiDqwZaPi4OJU+bglIzF1FaiTzzXEU8wmFyxekQM
         AOolQIw0qhueSsbDT4mRB8hjVB+6JtlLkQdKsVECkjKu8OUJDIQ99mwNH8cuPtiYmeXW
         9+YbmXWssVlygm7Vn2wVYTMBF2kJ+ws0MaRoJbdF/ndaqDDuvKaTElG63gNtKO3AqQM0
         hFqHQb+LJxPy+f6B/BFvkkJmEFATF8rMxEtNB2KsRFtVpFLhL8D3k+MkarDN7zK1mbKT
         GGGEJyrkbjor0a4By3/m2ZpK+bnr6G3s15Bgqa3KY5/i4jQ1CswivvR8FkRTDdgiBALN
         E2+A==
X-Gm-Message-State: AOJu0YzswtnRDIz0/xKB4v9QhqomxXLf58zVvgkd9boX1HKFK+HQA5Jn
	Rs3aYC1v96UEi8ojUmr2q1RScVTzxTgc3hZ1vJjQp2O6u5smUAx5w0+uPnzMDTSxSn0=
X-Gm-Gg: ASbGnct6xm9o3nbYGxWSsrngRkEfPPW0hVvtKp/9lA6wGJRA1ij1Mq1MGwy/FzAeBlU
	VSoB2cvU+XuCYLM2vSPJ6V1oUh15iAmLtEh8kwRm2xm3nh+VmmeAAiUj/py1ZETIAxngOsHkwKP
	ubiTVCD3yyNHY9J8GZ3RxGcu6alErWApg14ilsdRLU0t3PG4kCTGGMbRzpbIihCHXRwyMRK/EAx
	//UIxrvMNdLtxPak0LUkE3hVfYGpKVDMEqaJpL8m4es+UnE+l5ohTok0JB/p9bjTtOUiuf9EoXj
	SzWxywBsfJA9ANX8dIYG8tbj1ZAqeSnef9ysdvakYj5Umh5VI6oE1gHnMQuVOozFSp/0yF+NtiY
	44ykkcmVUcyMAGf9csXWqWw1rwb1n2iipXoI24cogApcVvpgYGkwntsNIoT7icQUKzyFl6vlVGw
	kVZpw19fGcsgqbQfcJ
X-Google-Smtp-Source: AGHT+IHG1ljQtRUhLk8RMwmPMklEqNbdosaaHISjh8Qe+uPETHA7IGY81xfTu3ijPvjAdd8HxSahkw==
X-Received: by 2002:a05:600c:45d4:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-4778fe5e870mr186982545e9.15.1763541307680;
        Wed, 19 Nov 2025 00:35:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477a97213b8sm35862285e9.1.2025.11.19.00.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 00:35:07 -0800 (PST)
Date: Wed, 19 Nov 2025 11:35:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf, x86: add support for indirect jumps
Message-ID: <aR2BN1Ix--8tmVrN@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Anton Protopopov,

Commit 493d9e0d6083 ("bpf, x86: add support for indirect jumps") from
Nov 5, 2025 (linux-next), leads to the following Smatch static
checker warning:

	kernel/bpf/verifier.c:17907 copy_insn_array()
	error: 'value' dereferencing possible ERR_PTR()

kernel/bpf/verifier.c
    17898 static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
    17899 {
    17900         struct bpf_insn_array_value *value;
    17901         u32 i;
    17902 
    17903         for (i = start; i <= end; i++) {
    17904                 value = map->ops->map_lookup_elem(map, &i);
    17905                 if (!value)
    17906                         return -EINVAL;
--> 17907                 items[i - start] = value->xlated_off;

->map_lookup_elem() returns error pointers on error and it returns NULL
(I guess if there isn't an error but the element is not found).

    17908         }
    17909         return 0;
    17910 }

regards,
dan carpenter

