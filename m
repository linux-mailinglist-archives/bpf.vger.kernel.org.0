Return-Path: <bpf+bounces-33531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D142D91E822
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 21:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC572840B5
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 19:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315F416F0D6;
	Mon,  1 Jul 2024 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdw37hwF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9615DBD6
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860484; cv=none; b=Bf9MaQHy2FxFnls1FpWzPXWBNax0CyV4WnPUNS6/X35+qMUs7spW8MMhWDvENwKqwPuDInLxSFjuz8Po0Ic9P2Hx08TdKSBzwaZ/IrGvZHf7C7sABuvaQkQCo3U7cRMsb6ffQKRu1E0ci2zOP474PRN+uLUCzpeX9bw7o9pdMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860484; c=relaxed/simple;
	bh=idq8G0Yf7qn+sUd2VAd9Ccn20f6jy9NKEo1jpFEv8Bs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lpEkYi4C7x+ItI1+QMolbuKjwivmjvVosZL6GDKUTfTMi1lGakbr9+RRRk6Gx1njiUhiBkibEhLRQxyxs07WIp39K+ceVklNWPQG5oItveHlUAC49sAdjTSnX+lt8iQEz0KZSjA3kxCX1bgNwGwqCKWBbyMXaAHv6olfSjx6UmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vdw37hwF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-706680d3a25so2210638b3a.0
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719860482; x=1720465282; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2OLRLHv3K5ioeyJRMab8MSflFWWJf39mMAf3RbkhdTI=;
        b=Vdw37hwF1icRuMeyvY5XIKg6RcTBRw1jSwGW3b8qBymxBY2A/K14xvWk8+8ohk0iQd
         GnU/EMztrqICgY6/PPhnPkWVq8iqRoE/JUIoH939DYWqcQeDtkKKAgf+ZTWdNH2WRrD6
         2IntgHqSeT0hya9ak3AyggWN5pjdLEuIDaOt+RdWIFt26icZ8p7YANKaaWPE244UvKvR
         7bUIOeMbWzc3qoiVlh6nFJ2mGIjsNQisBgNNQo2AsPJfeCKiUXELojihDTGum9b/zNQz
         0wf1cD5Yuf3j8XND2A7AeFsZ7hL6bb3conbRhpHabEoCXo84FQwsRHkwXJIjJL/bHhtV
         CL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719860482; x=1720465282;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OLRLHv3K5ioeyJRMab8MSflFWWJf39mMAf3RbkhdTI=;
        b=Wl9mDNDonpjEWdwtlBM+iTbFu0tcdmSx8eKJJecH2Wtdvbbl34xhP2FGHUVlFaBett
         A82bPYZVlqAGFQfirPq9jHndkj3Kcdxe05rGVytVZRs2vpPEWEqmg05QDsjUwoXbeyYB
         4zgU3lLN5nPzZudNsgY6434GPicIUBUL85ECPKBirJd+haKHTOWWFBk6z26H87LgBj9r
         Ox8F6sVYfo+Vxb65qd9TMdOPE4goVP3pb/r9MuYcp2b7z9CSvr0ZTC9scwcwOcAdQqTd
         jH4m2Z2eZZOuYzfHtcB6g47/+v1vuJg9UNDppC1mYKt1pWezwVXupGFPwoJwvN94zaN9
         E/Yw==
X-Gm-Message-State: AOJu0Yz1K3nD9l96JubezPMkiLGoM2e/D5u8CGO2wkf4hW9oHpMOVaNC
	SggVSM+cJ+8PV1Hy64DaAhgA6ZLyfHPuu4VESO+pdVteSRh+ZKnW0TVTjA==
X-Google-Smtp-Source: AGHT+IG7lN98QuPX9LgCEPJ27fiHbrfX0YezzLvtp4huBmWtv+zwrUUjip55oQuY+4a79ltN9sprBA==
X-Received: by 2002:a05:6a00:ccf:b0:706:3580:ac4c with SMTP id d2e1a72fcca58-70aaad71b4bmr6327297b3a.17.1719860482372;
        Mon, 01 Jul 2024 12:01:22 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708043b70a6sm6852158b3a.150.2024.07.01.12.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:01:21 -0700 (PDT)
Message-ID: <d8430760ba3535acd298db464a7ec3a8fd715902.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 2/8] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
 kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 01 Jul 2024 12:01:15 -0700
In-Reply-To: <20240629094733.3863850-3-eddyz87@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-3-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-29 at 02:47 -0700, Eduard Zingerman wrote:

[...]

> Technically, the transformation is split into the following phases:
> - during check_cfg() function update_nocsr_pattern_marks() is used to
>   find potential patterns;
> - upon stack read or write access,
>   function check_nocsr_stack_contract() is used to verify if
>   stack offsets, presumably reserved for nocsr patterns, are used
>   only from those patterns;
> - function remove_nocsr_spills_fills(), called from bpf_check(),
>   applies the rewrite for valid patterns.

Talked to Andrii today, he asked to make the following changes:
- move update_nocsr_pattern_marks() from check_cfg() to a separate pass;
- make remove_nocsr_spills_fills() a part of do_misc_fixups()

I'll wait for some comments before submitting v2.

[...]

