Return-Path: <bpf+bounces-79532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFFDD3BD45
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA1A230389A3
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2515450F2;
	Tue, 20 Jan 2026 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHWKem72"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391421CC62
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873941; cv=none; b=VZzSUadJE4WXYWaVOB1diDf+jImV3CQn5pfIxfoL43X3ozC8deC3RH1cYH9T8SMoGZUPH36T8/8gBY45CJEY0vpRzfnLTNZ3Dlcb24xq8Hduv64SXVZJvoP3l8e8ZatI25kRmhwwU+MNZ/n+8mUps59gS1/BIieqzMPxqnLRueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873941; c=relaxed/simple;
	bh=J/x/DUKp0CfBkYwahFzNB3tYZHi6PFizSyMc+JqQ2YA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+uIKrAaCAa6EPQRe9JpkzKxHVdxPKCdfxp134xGSxqDLRrxJDxbF5LIpg9XmjEHbqweCA4gPqixnqIwiHym9A87kO08uQ79ONcns/EajYdQRAa2FvY3ZvHw9MqAIBECF4QjxWMfO16o/cH2IrWWyiTvyko4sSGNwe84k2CGSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHWKem72; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-121bf277922so6711961c88.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873939; x=1769478739; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/x/DUKp0CfBkYwahFzNB3tYZHi6PFizSyMc+JqQ2YA=;
        b=VHWKem72oMI15XbBpPsTOaT+39dAZqSUNl73CKedGG8l8KZ0bf8SDwPO0l93gkx7A8
         pszb2+9NvK9PK2UjowyoV2Mh7stHyHG1SDb6UfL1/wug5yATRAGqojq8U+iY+iwBCF1n
         xtrZ+Qwnaya3vPoI3vfa43NYR6vj+vB5pSQjpndyLR1hEZlBWoLlM+KfFdFpogcbLDZG
         SSiUmnYJ18BKSDbVkp5z3+vxs68QEa7ZYyhZWdV/iRDXFaHGvOBc4aPZTtvn42LlSQxt
         O/kpl6i63kIGBj8mhXmKrUfoEnCdKbSDznxfKfPaEg69hSBgj0175CV+Xozq73bxPRty
         oszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873939; x=1769478739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/x/DUKp0CfBkYwahFzNB3tYZHi6PFizSyMc+JqQ2YA=;
        b=fnNQ6NYrs97OCHtYa+/LsLUe97sFsGQ8JheSgYbtP9S2rHhkL+VdTCDj98qKOWaOmO
         4/snKxLMMSYQevZ4icYvdnw/P28uIbCqCAvQiwYkRoVwt2Q4Tec7CXcRMl67DGGalEPd
         m699axJT7m89Q9K9FJ0ptSAJUxFftoDVle1HVIZESHLheAP3F9D1zjdMumnxOhzi3R21
         ILP+KoqHZW2+leIzSknYWGhpAGCnGbJBPy21uYaTvKGl33srCpTMmYBo/wmZn89I80Ci
         89G50F5fnWJsCPXhFLIttGKywIebWT+ex5WsgVz5tyZujdnnlbxub3E5b3eUL+obakf/
         JLxg==
X-Forwarded-Encrypted: i=1; AJvYcCVa/oHt8rmcOPdYcq1JT4LoXVKNSO9oAzWK4szJHDo2p044HJkbl676vCdKuqCJRUPTsg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNxUguK60LTvsiFDJNgkF26rZqTz9yCyCO5GiBze947VLCAlj
	fQ4UNBLG7vaZ37TaMFJ2Y+44gTp3agiPy7kjNqicn9T4dZeqS/ysmpSL
X-Gm-Gg: AZuq6aKa8ytlLlb1Lw5oXr+fg2k3MEhRlTSZArptevfXSpK9qZICQQGteBzP5RZpbZ+
	8CaYrqwaw/3I99WyrMeabVZvmN15XCBI7+pn7B0PxI2AhCveQZzw+yJBkoCVq+nJOGBq5fQcXy3
	hsm/WTQstdr8WBmcepN1cofDpX42OyKX1rlOHKSb/VEIkVqx7CehiFYu8gDg2jL6WrZJMIapERt
	EVmN4qXjKlRNrIRZbxLxBCGrqYe2f0mPao1GBSMQKcwz4s+KQ/anDcAlBuMlYh+YUvzui6WYDIL
	/easM/c5KlyI2AajADRR2f261zeVj9k6jRjEcyXPHfzYrSvfKCxU2OnogUtBtKnovU+uET/ajwT
	7Sr2uhGBUhjh+qv6Kws8hCBpKmBySHfmHzjAsfr84et6g1cu81ZG/ycuMI63GbnSg/0kAd1zAym
	F/mGbvuQXFRhJodTInanmQS/MZP2CImrHwvb9bcpc3HrVVDbrKiO44joLxGc2XFL6NAQ==
X-Received: by 2002:a05:7301:290a:b0:2ae:60fd:6f18 with SMTP id 5a478bee46e88-2b6b4e8a496mr11469646eec.22.1768873939061;
        Mon, 19 Jan 2026 17:52:19 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11c4sm15186383eec.1.2026.01.19.17.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:52:18 -0800 (PST)
Message-ID: <d433f40bc631b456cf2ab44fd2ffcfc2c1193e20.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/13] bpf: Migrate bpf_task_work_schedule_*
 kfuncs to KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 17:52:16 -0800
In-Reply-To: <20260116201700.864797-10-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-10-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> Implement bpf_task_work_schedule_* with an implicit bpf_prog_aux
> argument, and remove corresponding _impl funcs from the kernel.
>=20
> Update special kfunc checks in the verifier accordingly.
>=20
> Update the selftests to use the new API with implicit argument.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

