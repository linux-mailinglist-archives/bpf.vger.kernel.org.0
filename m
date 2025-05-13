Return-Path: <bpf+bounces-58115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D1BAB5391
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 13:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFBC19E361C
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50328D84D;
	Tue, 13 May 2025 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP56sguu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB728D841
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134805; cv=none; b=sQ7RCPi2jFaQqn0eWsLG+JblGky6BpwBeVSYVjNYNIG3eDgfhRVgmjnejOUKy5QQIhiATsW+WuW+ABq7H3STeZIcWRklpboi6ndw+AtZh+ztYvcm+ztyH5B96ITnGsPYv6nkB87Tgs9afJR9gugu+LkqDW81DeTXYak2nI7T9k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134805; c=relaxed/simple;
	bh=kV8sDO08RmUh05YFFLeOnLNoXjqwG3Z4WC86hQ7V3BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLw2ne8leVaPILqnCcT/sKMFCux2hjCUbh4/pXITS4oo+NQEeXvq8KdK0CUAk3YOfTREudRZHxFE0Yi0CbMGr5SerRDkVLiRkTuceIzIzWkUVT9HEO4eJX8b3m3gYIrg9MAJ1vjrk24AMTZSiHOi8O2/+GvPKvde6Po+/6HbOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP56sguu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so55754355e9.1
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747134801; x=1747739601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kV8sDO08RmUh05YFFLeOnLNoXjqwG3Z4WC86hQ7V3BI=;
        b=fP56sguuRBH5Fk+SugG0f3+TfzUUsw9DEvg4uieVjob3W0e6A7CqkuP+y0qQMD3Rom
         r8BDbvoqlqQXz886rqcKp8VMLSmMmqU4eKRHIL8AqyeIVawGCxmAQAOhR6wvw1dYSaVC
         MHjhuef85+fOOxBRMSflV6J3L06af1M7yZqXnCSq3yljmVV5qDdkfMtj5j9KhxMH2Xi/
         43Sg90OoQnBw4jdIETULY6PN+cZEGSPK4E5F7wHXQ3WJtbQ7CAhGJEEBMULYRAeHruM8
         74Kl1RuXThGXyTTzOuxQNX17sifa0OUIzbcXGfbaXSW6Th3mNHKoMuIzBt+s4hp2J7Zq
         rwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134801; x=1747739601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kV8sDO08RmUh05YFFLeOnLNoXjqwG3Z4WC86hQ7V3BI=;
        b=NBAr6p8kf99HvuT4TUX0enDybR6cYcKOhPMUBTtyeTNoeZdPxprjStcgUv1LqrmmPr
         8TUMMxe3RVujSwvEu/ba81akrBxyYC9f+ndOD5wKEQtnqREZgurnR/a9ysMoQBjD+YdN
         wccllsYwda3PeyjboNUr56pE7O20CwREOztLXiVWO0yQ0K98TTAkg6xqSRFgwSI1sei+
         qM8rmA7AV1EzWCQzIADmXQseVMkBXjI1WzdCtQzvsFM4VQfVqxN/f3ji1DjlNL+YmU3U
         OCGBo82jWW4Iqsj5E+BZNA/HN/UoBRbeEnCeW7fp7Gm2eBMxmDqAOhhgIOZgE0X3cruN
         7Xqw==
X-Gm-Message-State: AOJu0Yz3UT48PbhoU6j+hJXYMQpCyP9Rolpz7ufgTWq6Wb1zRU9zhWkl
	QDT3QsUXT6LwoaPDDCimp+KrTEoYaXfXtNoZWa5sVY8iTuW9hock
X-Gm-Gg: ASbGncsb7ujlsWhrcPRMPbSIUFlwNc/6adfyorLtf5S6o3SJknL7pNQtn1SGOCxCBtI
	nXfFjjGLukeSlgqj9I1qgh5/dFZGnXfzOh1B2NYT/6czfyrPpcDmom7dhNGmcyiUoGDqum0QMzZ
	RXkniBrLl57qqBuiu3Qlzn5rz+UzWfCU0R5p72hAA/l5ohfx4OnNf4218lolLQelU2lA0PigNWA
	yi8L5j43996KIe4K3NgnFWAgJG7sMtPp18jYe8IPfDv6Gt9jRtXPlDRp6P6unynM98ul9oUs+aq
	Oe85Q5qzzm4A9GD+PZrEx5PQWTsAabW2YqCzfnKkjGFV77NxIA/1QX/CNrtWmRSptWRnriHgMRi
	iLvOvH/d6FNscxpYDWtQxUJz7cR81beVB
X-Google-Smtp-Source: AGHT+IFYcinxqJvDnSZce0ChumP+zn8nr0js0NIciOfBnVt01rP/Lw31ml3lbLhXX3maOXVryumMBQ==
X-Received: by 2002:a05:6000:1882:b0:39c:cc7:3c97 with SMTP id ffacd0b85a97d-3a1f64c0a9cmr13427114f8f.50.1747134801296;
        Tue, 13 May 2025 04:13:21 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ee95asm15959936f8f.11.2025.05.13.04.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 04:13:20 -0700 (PDT)
Message-ID: <584957e4-9cb7-4721-afda-c99b2eb1c0c5@gmail.com>
Date: Tue, 13 May 2025 12:13:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: introduce tests for dynptr
 copy kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250512205348.191079-1-mykyta.yatsenko5@gmail.com>
 <20250512205348.191079-4-mykyta.yatsenko5@gmail.com>
 <CAADnVQKTVvXUXygnFASdoZc3d1WEPnVuxQWO8Fe8iQW6J9piMA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQKTVvXUXygnFASdoZc3d1WEPnVuxQWO8Fe8iQW6J9piMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/13/25 02:46, Alexei Starovoitov wrote:
> On Mon, May 12, 2025 at 1:54 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> +dynptr/test_probe_read_user_str_dynptr # disabled until https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/ makes it into the bpf-next
> What is the status of it ?
> I don't see it in any trees.
It was merged into the mm-nonmm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm just yesterday.



