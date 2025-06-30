Return-Path: <bpf+bounces-61885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456EDAEE766
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 21:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8023BD1B4
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D06D28C2A8;
	Mon, 30 Jun 2025 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRJrDj4E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB965227
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311381; cv=none; b=poN932ZlilBN5YJqtAfPZ7JeyGaGyQhPJN77kKy7uuByZu9KoKIGltxSTEDwg3gx7+eHX5JFhPbraNvBsVsln22GVaSo4N6+Z/SwmDg8tFrg+6UJEUsWWgC2XaYxMKluiEob4WllheJaTOZwztfxc/puyLzNo6W0V945IOeTHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311381; c=relaxed/simple;
	bh=/mh1kKLVCICAQfnTxn0a+fEAaQeORF+DsOI4PV/vUXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XeT/CXK0H09wvJ5pQSCsXhtQbkjoo5q3LdzjPSK14xK8sNPVzRsOGr20xkB3dDJ1Nj6WkTR8t/iOLWr3pUe+kNJaEXJr1tQHw/pcmjy+3n+Vu1bTTKzTolsNiAp3HDJ5bAPEOfRW+s0+bue3JYz6J/hYGp+OzZyk7NMf14f4bxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRJrDj4E; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3220c39cffso2790047a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 12:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751311379; x=1751916179; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/mh1kKLVCICAQfnTxn0a+fEAaQeORF+DsOI4PV/vUXM=;
        b=cRJrDj4EBLP0X7NLGnzlOPlKsROnh3+vOiRAOOSEDxFKGxUOQmvTtVk4wazvh/b121
         KbuImv1JyFv49YqpRBYji2ojIHDfL/kouub08BtxMrlVjvWpE9HExjjk9/pgdaybU9dY
         S1gTKCOunye9pYgLXmkt1HfjmntuNwS1WV5X8GAeuNx5zAMq0c2kAwbVCwY/zBCoLoPV
         gnLhjxSiGSTEGTYGY0+6X8+ZxGPli5mrypbeztdYaNQ3al8qMs3guPXI9Ddjxu8iSaFY
         lhjMZQB7JGESWBrQwhVGCGqzRyeGGzK3BJQ5cJYeCDr5SCX/lBeOJmroKfK1P+7TCml6
         Vn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311379; x=1751916179;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mh1kKLVCICAQfnTxn0a+fEAaQeORF+DsOI4PV/vUXM=;
        b=ObJZYRIc/wD6XwS57VcqYTSbcV+vXkEK+Z4YVdcd/FLGz/voduwX06q3qPOYXhwGZ5
         1bPBFQj7Zkp30d/oQseldo7vWq7QPr9rCT1ZiN+MtklnEJzoFrALcjpPbFnws+gqJDXT
         nsqY2AWg3Bo2nRhbV+TbYAltFc7XjTGUy9DcfNGa3XGhgmrkGqDXPvE1j++HaPHrjiPi
         lDpwzvY2JBvcYpg5xMRJj8KbEV4XBZx19/5Ile/fqkcoF45mIKjIPPIcu5tUh8l+O23Q
         eYz1xZLXfmrduBeyA6p1tewt5HuBYLYIJZntDM5rdp/fiDS6vL1APzU95OmfTOzikV5E
         0w2w==
X-Forwarded-Encrypted: i=1; AJvYcCUT3ucwGYk6xA2tEx3b4UmdJaEYokUdKGr/DGpI3ZL+Ss6liifjLe0gWsnRfkNU5+9jYTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFTyYv7FgF7ihpcVQiLxY1IAtzkFfptsIBwwkVZ3rfOF4oMQC
	st7ZjMcsfdfoMUYkv5JQuZsm8iRIo79LTdSM2KPfqdxtx9+aoySnvrIu
X-Gm-Gg: ASbGncvJGK7kyAntpPOe4+E5/IQQepUk6wKEpprFNPAzG0BX7VusMnBmAmDK+T/Fhva
	J0LlCiDEPpUvQW/gSUedvpGSwkPU1lZn4cbYHySQY3TYHdFNnb5GlNtm1dzrD10DfWHO7G2ORxQ
	PFaFZUufXpAA0TzJx1MT5lgjZUs23FlUP4gG8PUn2B3qRtDHVZa0CnB/Q9hOjTNVwWgQ37wHTiV
	oCQRJb7SoklEExB800V+gj0BxRDLEmvTfmiX/jHfewAc8VQtsALnBXlX4T2kfptwtsfx1CIBFce
	8DYcou685YO1i4mdHwZ4nIqWVR2WyKv70x0ZoLc5/afOD8sDAkZJQrpAi3Q8xfEgjEUc0A==
X-Google-Smtp-Source: AGHT+IGmAb6LB94kupysZWiJZ0IKYZZY1m0zn9g83uEGUYk52Quto9rTl4GwWuYfSJrpxqbtW6U9dQ==
X-Received: by 2002:a17:90b:3c4a:b0:311:c1ec:7d11 with SMTP id 98e67ed59e1d1-318c92a2e8emr23531275a91.18.1751311378992;
        Mon, 30 Jun 2025 12:22:58 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3ad16fsm92852195ad.141.2025.06.30.12.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:22:58 -0700 (PDT)
Message-ID: <57f9f58f399dbcb348f0d55cae7b19f38a143bcb.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Amery Hung
 <ameryhung@gmail.com>, Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?=
 <toke@redhat.com>,  Feng Yang <yangfeng@kylinos.cn>
Date: Mon, 30 Jun 2025 12:22:55 -0700
In-Reply-To: <20250630133524.364236-1-vmalik@redhat.com>
References: <20250630133524.364236-1-vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-30 at 15:35 +0200, Viktor Malik wrote:
> BPF selftests compilation fails on systems with CONFIG_NET_SCH_BPF=3Dn.
> The reason is that qdisc-related kfuncs are included via vmlinux.h but
> when qdisc is disabled, they are not defined and do not appear in
> vmlinux.h.
>=20
> Fix the issue by defining the kfunc prototypes explicitly in
> bpf_qdisc_common.h. They were originally there but were removed by the
> fixed commit mentioned below.
>=20
> Fixes: 2f9838e25790 ("selftests/bpf: Cleanup bpf qdisc selftests")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

