Return-Path: <bpf+bounces-49528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF9A19953
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 20:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE9E188B60A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC68215778;
	Wed, 22 Jan 2025 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z53dRMYb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E12153C1
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737575165; cv=none; b=FzyQ9GFWflJGlxWLGAnHanZZVTxYk5/lIX4DJwT0SbObrGvBmpLKni8KGiUQo05QQ4azW4SeKcYx3S3JtPNAyJXCDcoHoXUi7mPBNCcXJqEffHxTHP2OtKFB1z/CXpcH6Lu2D1cFPpnaGXjcLK49TVkmeedqYWBHhA0BrA02rbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737575165; c=relaxed/simple;
	bh=fBhmdNiG1MUiFQkvNFic7jioNMduAApOj+oR28mWYus=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1CP1Xq1ibYjCuPqg4MQxnPYL4QuJjv0Y9sxHV8YCOAyl/mGjx1WKudcZ/nxEpopH+6N0jdOb+5AsLKjTG6gQg+QMkUuTY7zQtrIoHGUrtUIjhkwBINDczbcpLzudnsAU8mrxK5VVZGd4JbzWITVOTBGFwOOhy9VgSdgTxoTQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z53dRMYb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21680814d42so922345ad.2
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 11:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737575163; x=1738179963; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FiUyt5ELwJBWRS9eN9nhq1dk1KEJKzOEekeyGCFYIpA=;
        b=Z53dRMYb6bjA6/n74ccmfsYeJtfCeBCs78xLAcjR+Amk1/XrI7Up4akZitSruOoJuS
         h7I3p5/lsU2GEBrgtEdlKl065YqDGeKA9Xh4nrsQrYT/FVm654NTgH10Rmle+O9sck7h
         Hflwse8ISC/FXmDoEw42qpBMy4VQ9CfjFtZQ8htB/klQklgvu41qkbFjI81x+wCTz0eF
         vXYv3mP1zBtVtYALgwAhxwWdU9qlPB1A733BAXXsSVqplpCCuw7CEC3HSC8lJtF6zDzo
         0WcspXvYXpb7iYqDBxkgiOJx/yeaAfF1u022DrkqdUB/ZA7lAetq8AX1Z2k0QaxDtUd1
         SWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737575163; x=1738179963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiUyt5ELwJBWRS9eN9nhq1dk1KEJKzOEekeyGCFYIpA=;
        b=j1C0mYm8uMbLOvyvMGOJYaP8CxG/ybEAMEqqZOBTu8K4iuwoO66a2bqXU5XvkcRhDu
         ZrIpoUFFaYwiwZnk29jkIeyaw10IMicyUxDVHI6nSZQqqryBWxhTChiz5D605XeU8uD9
         pYqdCGcc7nfaMZjQ/GfRHjTS5TWOUWYrHWGMskMq3EVTb+4br1X0+O7GFyipDWhM6Jb+
         4GWuKH8LKr5ZziCUcnpRfrl1GOFcJvs74hl3sBc1vhXYFgYRG8nXVjFneb6KXSS66nMi
         /1rGddZYgCUjB5JpLbrEbrCnrt+HtEnEzIbKyxpb37lYAICUz+1ocuQ85gcje7eFzD4F
         m+YQ==
X-Gm-Message-State: AOJu0YyIsVRtoY5TY04dlcU4z2Bmq0wZMfm1CWLvCTos/PDoZBc5oo64
	keXJvx1SsKhMRa2kfuPAYnaGm7tWbAJPyHJ0W8bsRgbhl1Q/AGkvjjonIA==
X-Gm-Gg: ASbGnct7UczcN7E80ptaOE+nmFL2QNqQvIDsU7UPnyMnMQT+81ApyuedYKVBqRoTeRH
	bjR7Ux7WyWdaHqafCQObVPLgF6nUpSoC/IrrJJrrucyqOaVCTDSvtS54iy6J6Tjbxb4ATZ2Z/zO
	QsAq0b36rQPWg++MXlbCW1EgSdkzywZswN147/DNxowhDW96LRN6Ehwvph+GNETLGWoXauBqUvN
	tXXVgpTUlUJtt8G2gxrD7w7VITNoIOIKsgJqMY70C1266dPth/cI/ipwknalFJShJs=
X-Google-Smtp-Source: AGHT+IFvdaDeLS2DAQlFbij9bQny1nznh4IbEgRR8v3k+oDdmXx22xDscBh2w5pSMk9OsxULooQWqw==
X-Received: by 2002:a05:6a20:7fa9:b0:1e8:c159:b6ef with SMTP id adf61e73a8af0-1eb215fb150mr35432525637.37.1737575163479;
        Wed, 22 Jan 2025 11:46:03 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd30cdecsm11103660a12.57.2025.01.22.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 11:46:03 -0800 (PST)
Message-ID: <bd19f5e8abd069955917fdcb34ccfb77078aa6de.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 5/7] bpf: DFA-based liveness analysis for
 program registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Wed, 22 Jan 2025 11:45:58 -0800
In-Reply-To: <20250122120442.3536298-6-eddyz87@gmail.com>
References: <20250122120442.3536298-1-eddyz87@gmail.com>
	 <20250122120442.3536298-6-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-22 at 04:04 -0800, Eduard Zingerman wrote:

[...]

> @@ -23141,6 +23441,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>  	if (ret)
>  		goto skip_full_check;
> =20
> +	ret =3D compute_live_registers(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
>  	ret =3D mark_fastcall_patterns(env);
>  	if (ret < 0)
>  		goto skip_full_check;

In an off-list discussion Alexei asked to keep this enabled only in
privileged mode.

[...]


