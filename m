Return-Path: <bpf+bounces-41364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E01B9960DE
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE9E1C23B04
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F517CA1B;
	Wed,  9 Oct 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brtM3LNY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2888317C7A3
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458997; cv=none; b=OigvHjLOthRrkb4JoqYGouC2yPsTFKA19JCp0nOL5+rdoZrToaeFIb2zx6BmRwNLFLFY4x4I7Ko/IsusEoyiNC6zAfar1brvWkTWqEvdpB83wm2C2uIH8309Ymnl9lZg6M548G9l/f9v10+Klg0v+f+bklnEytdFL5sMriKOqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458997; c=relaxed/simple;
	bh=0E+T76OuVxIDRuPIRMsuUlMvU6216SlCOwhDfuEPsp4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvKDGmoRWS1dpPbK2MU/JYSQXV4Sx71xK85vaIGbldFKHaF+IcxB5k1Uc30bLdgUd90ev+i1W4xHLhGwguZ+GaFDfVzLoGXdCGV77EgQmnD/iRkwMyNJawt7+SkYsYk/v/YXxeyxufNqc9hUiqqNAYQrZnVYkAHRSmVm4fLxCUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brtM3LNY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20bb610be6aso71530965ad.1
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728458995; x=1729063795; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0E+T76OuVxIDRuPIRMsuUlMvU6216SlCOwhDfuEPsp4=;
        b=brtM3LNYft+JZjv0b93jpMBhJKfa70/Ax73PhHadLq1oOQWmEYMYbqfBkgAOfPLDP2
         KzlJCQYO/ki3PRIRDFxgRezS4m+/2AVyvEPI6mBWyNjEr83LnNWG1CWUEd/dKuSuIFRB
         kA3dwLUI4k/QyDS5lTZn7UkdC8kIrfefZNGQaE//VmS8WDTQG6ZEQVL38tuF4jvIH6qc
         JMEYlKEPXUe6LAqravdj10EmN3vD1/DIBBbHs67sIxPMHunm2I1UupL4Tc+PvqW3oDBt
         UqUhLqtCMSJ309FKQbH9THcpiUjgNDOBYoywxaD60K4NQPZ6exfILL4T+XA7RfYfc5Q6
         a/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728458995; x=1729063795;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0E+T76OuVxIDRuPIRMsuUlMvU6216SlCOwhDfuEPsp4=;
        b=CEE37zknSNEMtDMU63aAOZmILzmlaj4n4OFXwNTJafe+PXS4544FS6jA9uuURM84HR
         yM58Avf/g9TQua+KWKRzi2JLPeeZtBFie+eG/Qwc36pesQybG8x5Jg0KLP9muSHa9q/y
         d4NbXginTCf8c9VqHtff0lZk6QpJWd3SeqetShFUBM7gZZWCK3brbFU/Jyy/auPy3fe8
         ouiqmX8/oI+FLt5dUTinfUZwsqc2k1jGvPuJ/EM0Yq4tsvP3Ut465NTOUum53M7Fp3a6
         NA9P8RNTX07r5Y+v+M7gngNiXye1A5kCiQjOwQZ+4qU8en3AqMOpXAKZ9n8vhNQgap6h
         TVHw==
X-Forwarded-Encrypted: i=1; AJvYcCUuMwjZTXP1ZQoLBDvN5j2TegmlESmgQRG5I6lSPJptsHGqrA1JCRor5t3S7pekvWRPbfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPbI2quhDLKSsBdl+JUFCheZOd5bRpCv9iTWaX9e4H00lvwnD8
	eWcwfBBv2eyV+wBVgCai96BLmZcHjgc8gG7jlMC8DZu3pfFlS+5Y
X-Google-Smtp-Source: AGHT+IG45Aa0l87+T0JU8H9J5R+suLknTO5v1KHbNgFQcAVeLZMRtHrECD/gjGVqLGLQ0UaNPf/u1A==
X-Received: by 2002:a17:902:da8b:b0:20b:8325:5a1e with SMTP id d9443c01a7336-20c63755779mr24977305ad.36.1728458995498;
        Wed, 09 Oct 2024 00:29:55 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1395a49bsm65264815ad.209.2024.10.09.00.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:29:55 -0700 (PDT)
Message-ID: <9d49e9fabf283480e38101a357872f0bb923e2e9.camel@gmail.com>
Subject: Re: [PATCH bpf RESEND 2/2] selftests/bpf: Add more test case for
 field flattening
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Date: Wed, 09 Oct 2024 00:29:49 -0700
In-Reply-To: <20241008071114.3718177-3-houtao@huaweicloud.com>
References: <20241008071114.3718177-1-houtao@huaweicloud.com>
	 <20241008071114.3718177-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 15:11 +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>=20
> Add three success test cases to test the flattening of array of nested
> struct. For these three tests, the number of special fields in map is
> BTF_FIELDS_MAX, but the array is defined in structs with different
> nested level.
>=20
> Add one failure test case for the flattening as well. In the test case,
> the number of special fields in map is BTF_FIELDS_MAX + 1. It will make
> btf_parse_fields() in map_create() return -E2BIG, the creation of map
> will succeed, but the load of program will fail because the btf_record
> is invalid for the map.
>=20
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


