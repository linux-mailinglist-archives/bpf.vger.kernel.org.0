Return-Path: <bpf+bounces-34851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E7D931D03
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 00:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F2B1F2252E
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8227A13CFA5;
	Mon, 15 Jul 2024 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2PmnxUR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10561CA9E
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721081226; cv=none; b=o+YYp6HoaHWI8my52536DV2MkZoLMUZVV4dWLtLn1oBSDNarCo1okPPUTvuzLo4SaZtsI93dNsMCJwp2gOGzXrSQXuYxEcQH9i7Ixd45Raom/AiaJa1BanX4A/Pum8ahW8ZwWAuN4Ne0HxyH/DhOtr8tTCIlVesFCjF6vM0ml0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721081226; c=relaxed/simple;
	bh=HrgszmcUH2P8pbYr/JoT56SUn1uNMwYqh7jU8W22OhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToGVnbhiO5Z6G3hiWvudHglSDThDqB1VoogijLdKjLJSqhR3bhVphynQGrh0PE1r83vrBMc8/QrnGeMxBmlppAH48JG29Tl58CBR4bCPUXngM8l/dxUxfUZnt2Ewob6T8eKXCiRyirPmmcnBmk+7JnFnlpV1PlxssSwIm34zEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2PmnxUR; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e035dc23a21so4831425276.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721081223; x=1721686023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1Vw/URZ4dvbYEusPlvqfL/0PL6owyWl1O0GzyXhJqs=;
        b=E2PmnxURDcRUUIdJHQzydM/Xf5Ca3VTXdeidiWkMw2lJUs8ozUCeIPbJln9oKhpIm1
         tthROknhK24hB2s0P/zatVfkWvXoytO0yjmUPHinKnQ6wdfFOebl8Iz1nylqTaDghlXG
         2P4n0UybhVeZAV5WlQStLeJ4oyjzUIcJfsk4D8A4e4pCQDvLaH0ruaz5dLdAs/UgIG/b
         xPxzvr8smqIMX6wq6QDl6fmoloB45ITFJtr9C9caWKw69a9k1HhL5fR3Mt7hZ/o+iIT5
         085A8a3wlerWa+jDC46YAlZYHDrJUwkGQq/BZx/ZP80datIfUqBilCOP8XwNU7rRiSD1
         ePig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721081223; x=1721686023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1Vw/URZ4dvbYEusPlvqfL/0PL6owyWl1O0GzyXhJqs=;
        b=go1mLwpMrcJfG9VmJN4QReo0I5XLmZfj0K3z/hU0ZQw2ycqVPH+z0AczKY2UgHvrBV
         k61aydfmKPTj5fUI/97hYXuwXWKySW+fUtH6YGSSgwhdkGBPH2Dxfy5WucNDS0RCrBbO
         6zNv7ZwkyqQtSs0qyoEc5pU+1v2fyPZNWQMqAuuxYPUdoKUNwwDXDASZ5ZQfJ7wPldUP
         4/owqUOtmk9p0CcBtrct+ezRwczCQsiKACtBBXHpdhnxxntp/pCt9u0cGXEHj5ImpgUA
         xGieexGT5Ct+yhj28xpdOIl2cEzX/Obd/rbt552flRLQK/mRuqkhcyB2zEtRhYDWXwMy
         Uk0A==
X-Gm-Message-State: AOJu0YxFl3142i6B4aQJ4fQQ8En9PsnR2LHLWQ7QksX4PLzrjugJDd0z
	GdVJrftf/L68VxtJjRAN1BLEoq6SYOEguqMt499WosJyaw6RR06J
X-Google-Smtp-Source: AGHT+IEw6BM5pZ30deO6aoMLQgnQ4qHIT+86BoDYyyzoVE2MrpqSdlpv/+zwD/517PELU0QC5NKIsA==
X-Received: by 2002:a05:6902:1185:b0:dfa:ff7e:d410 with SMTP id 3f1490d57ef6-e05d5a23e22mr528338276.40.1721081223504;
        Mon, 15 Jul 2024 15:07:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:4bf0:30f0:6cb2:3eab? ([2600:1700:6cf8:1240:4bf0:30f0:6cb2:3eab])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05a45b0a44sm1016371276.9.2024.07.15.15.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 15:07:03 -0700 (PDT)
Message-ID: <4c658385-dc3c-46ff-a868-0159edf84dc1@gmail.com>
Date: Mon, 15 Jul 2024 15:07:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] monitor network traffic for flaky test cases
To: Stanislav Fomichev <sdf@fomichev.me>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240713055552.2482367-1-thinker.li@gmail.com>
 <ZpWVvo5ypevlt9AB@mini-arch>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZpWVvo5ypevlt9AB@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/15/24 14:33, Stanislav Fomichev wrote:
> On 07/12, Kui-Feng Lee wrote:
>> Run tcpdump in the background for flaky test cases related to network
>> features.
> 
> Have you considered linking against libpcap instead of shelling out
> to tcpdump? As long as we have this lib installed on the runners
> (likely?) that should be a bit cleaner than doing tcpdump.. WDYT?

I just checked the script building the root image for vmtest. [1]
It doesn't install libpcap.

If our approach is to capture the packets in a file, and let developers
download the file, it would be a simple and straight forward solution.
If we want a log in text, it would be more complicated to parse
packets.

Martin & Stanislay,

WDYT about capture packets in a file and using libpcap directly?
Developers can download the file and parse it with tcpdump locally.

[1] https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh

