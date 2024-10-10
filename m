Return-Path: <bpf+bounces-41638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D939993B2
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D704B2871F8
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B9F1CF5C5;
	Thu, 10 Oct 2024 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWdetVMF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE16187560
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592258; cv=none; b=WVgqG2MCxI1hg+SGw48CE6JRmVcZG9Yie+avsJJSC8W7Lpg3WGqAMii6rt5thgp/0nHlMukWgoJKUi92oUg/VqO0rE+gQShqS8Upnjm66rZGlgxdWEYCsVhBq5JA/u44X+HRqiW5uxiKfA9RpBVnI1aZNrbnnRBSO2yIJ9fdv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592258; c=relaxed/simple;
	bh=bCEZw4tGVByC8LMkyK/lrTi6q6nVGsW0CRSklR+LciA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OuYIR777g8XAtGfuzv3Gps6dsMKzc13N5JLbhQtdSmZ4llGkxm4pFLqFmBtXUdRqr2TF7ush+ZvvbG4narLxSa9IMS0naQeQf72b3ObUixTE9yUtQ11+FB/BBqWqyoAVeD4bFD4WOnsNuKs9vAGuhZuCgWLy8yBkbC39KsHAZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWdetVMF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c8b557f91so7803735ad.2
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 13:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728592256; x=1729197056; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bCEZw4tGVByC8LMkyK/lrTi6q6nVGsW0CRSklR+LciA=;
        b=AWdetVMFPm+g+JBxNw1knNFAIhS5GUHrZxYEDlkaV8qZ2LRohCqaQBgMy2JpZoYxlb
         o2jaELwSn5l6bwXcohY1NfV/x+SAdZSRsOLrpjTVTGhQ+GONxrS9WBKwIVDopzJJ+e+z
         Wm4b1Eddwv1lsJ5K8RfTeGR7ZSwAEeCCD3DxSPK+NkyFq3dXS7WCDsOqa4t+2XQ9Dajr
         Vd2MhdPi77E49pEX+By1mgDRMFZR/JYu9DBdQamyG65zbaonz3u3yJZNWD+4Yil96NHW
         MZmU0oqRwps3PIcYly2CjEcU36AZDSfjkQKNvJYKO7tmhGVYLQiUyhZxBE/tgY0HocrP
         fysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728592256; x=1729197056;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCEZw4tGVByC8LMkyK/lrTi6q6nVGsW0CRSklR+LciA=;
        b=BemIVL7ZNSB0dX72ffkHl+PxqFnKRYVTt5kVN4lTPKYWEcNo7jGgVChepCxhmosTyx
         wjOFkDgpeAsrAnXp9bW9ppQt6ZTWgEw0CT28V0clC02CibDUzjhuM+/JKd5aICqXPcFL
         1qABWX4yqLjiYkFHbDDJ2YfTbUkPurhvIyDgy0mDT0QKv2cS1n+R4SBtGqPRvxhguXsV
         /hUnocRFCqfq9CShdDl0IQzI3my+33akseLCVV1nGZgObLdO8H4fTnvcx/NZJ/bt990A
         Dhb/DYP1WzBrPBGZs+kkPxvc+TSLubPt6Aepm1cVh1dK0A/gNw/9vOs9XsZqc6wKes/u
         U7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVAk56toEmp6BWj+DoPYQCGMiezO63IJinO2q8AxP9ZOOnLR2iMiAgF6fGMi8WvPD6o2SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwtF4vfM34I/3Bz/VNJnqZnUumxZuL398jtrBogQj5egtNnfa+
	jGxRzCbOvqlumGF6GMY84ZPit4v5rX4TQUUNg7mSP6D3JOQoU8kLRqgYwklnzr8=
X-Google-Smtp-Source: AGHT+IFgeiWgNWHLdWOEfY1JvRpIzonpQJI+unTnqnq34Vu1bMl5HZ1tLJOLwhLeLpwIXZWaU5N8hw==
X-Received: by 2002:a17:902:dad0:b0:1fa:9c04:946a with SMTP id d9443c01a7336-20ca142a240mr2017195ad.1.1728592255938;
        Thu, 10 Oct 2024 13:30:55 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a:b5a8:9248:40d3:6020? ([2620:10d:c090:600::1:770c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33fdf9sm13049285ad.260.2024.10.10.13.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 13:30:55 -0700 (PDT)
Message-ID: <39fb92adbad5bacbc2ca9653d346c28ed2e9b3d9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/16] bpf: Support map key with dynptr in
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Song Liu
 <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
 houtao1@huawei.com, xukuohai@huawei.com
Date: Thu, 10 Oct 2024 13:30:52 -0700
In-Reply-To: <20241008091501.8302-6-houtao@huaweicloud.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
	 <20241008091501.8302-6-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 17:14 +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>=20
> The patch basically does the following three things to enable dynptr key
> for bpf map:
>=20
> 1) Only allow PTR_TO_STACK typed register for dynptr key
> The main reason is that bpf_dynptr can only be defined in the stack, so
> for dynptr key only PTR_TO_STACK typed register is allowed. bpf_dynptr
> could also be represented by CONST_PTR_TO_DYNPTR typed register (e.g.,
> in callback func or subprog), but it is not supported now.
>=20
> 2) Only allow fixed-offset for PTR_TO_STACK register
> Variable-offset for PTR_TO_STACK typed register is disallowed, because
> it is impossible to check whether or not the stack access is aligned
> with BPF_REG_SIZE and is matched with the location of dynptr or
> non-dynptr part in the map key.
>=20
> 3) Check the layout of the stack content is matched with the btf_record
> Firstly check the start offset of the stack access is aligned with
> BPF_REG_SIZE, then check the offset and the size of dynptr/non-dynptr
> parts in the stack content is consistent with the btf_record of the map
> key.
>=20
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---

The logic of this patch looks correct, however I find it cumbersome.
The only place where access to dynptr key is allowed is 'case ARG_PTR_TO_MA=
P_KEY'
in check_func_arg(), a lot of places are modified to facilitate this.
It seems that logic would be easier to follow if there would be a
dedicated function to check dynptr key constraints, called only for
the 'case ARG_PTR_TO_MAP_KEY'. This would als make 'struct dynptr_key_state=
'
unnecessary as this state would be tracked inside such function.
Wdyt?

[...]

