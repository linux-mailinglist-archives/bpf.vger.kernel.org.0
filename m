Return-Path: <bpf+bounces-39994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA7C979E64
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 11:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BE01F2218A
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF9414A4D1;
	Mon, 16 Sep 2024 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgFLL0/5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6E482EF;
	Mon, 16 Sep 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478664; cv=none; b=JzxWoQICmpAEAvsnkYCfitiCVAN7F38593bxQceG6OvUErel/T3vl7MXbDGJlC6FzS3acYVRPnxD3vYGizQT/mgDbBTPxyyf3WDMRk9oHKk7wk/CO+SvvCNt4wMEch7XKVo2hjf7WcRLtnlmXw8eo+A/e7NNEfbl0UzcH9jvtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478664; c=relaxed/simple;
	bh=4POVzH0YYTw1lupHhplEjHAuU050H42ApyZQzNTJASA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m91Q2yZe0kKM9CJQ0GzsTP/wWj3qSyQKJdfTozxwLZtDhJY/ILX2BVoYO8cvAii0zHySD/GCsFyCuKuzcs6LqCPV+ReEzUC9L9aTJo0cU4++bJOZNbRhkI6pteJFBvbJ3tBWn8jTdV8Joo6wf4GMIXHqtpwB+ZdCcWK9xqzxAwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgFLL0/5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so3207256a12.3;
        Mon, 16 Sep 2024 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726478662; x=1727083462; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gI5PuM1qflBYGtHvR2miDMQUDtV+K21AorIVDpm/Y/s=;
        b=FgFLL0/5uankMrnrAAloMPPrcJ4+sFt3iXmocKg+8rTlhmTTns1ihyHP41lmeV4aee
         Luk9AIBykBBEvjmc9Nd3gasZmzeqi6qFDGGa2tvg+tMOu0LmqJE+Zy0ehmELQOzFYFrN
         Dzy4jAq4whgX/BLyKWSRguMLwo2oJZqRBfRM1xHfBFKpNQM57SB+vLTzxPfW1ci5jyLV
         PNUZmfqMzpn4eiX4bH0PdhHuRtjdXHjb5OhAvYnkZqq5A7kUPKxTKGvTH0RevYScRUbN
         xL1JQxZV6718iccY38yR7sQAdKffOyOv/STP0GVVTcZIDYjUESH/qTdmUOxDF9EHl9lh
         YMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478662; x=1727083462;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gI5PuM1qflBYGtHvR2miDMQUDtV+K21AorIVDpm/Y/s=;
        b=ImTybuL92y6fwN75rKIx8nPARLArqpLOolQbaSoGUr8O2+/STv5+ywrcydRQEJ0EgL
         y7f1IVzvNl/H5XAK2I8UIO1a2AGQEhMJi0rE+uquBLPL4NWw9OvaR7VIKddnvwRH/Suj
         ZnbouLRQuj714zvUd5YQ2/v21P/fy3PUjjh6NSChBCi2l73ifo2+aJdS2meJgccbEPg5
         Wk6t4Nj/3H6BSkgGKVPVRAlxvQpn0oP2mYPqfsgMQ9E1g63ZpuJoF3PlVCAv/nH/r8o/
         /ZHFnE33lwX8i3gXHgxvOd1f/5eac4SGLbgOzJD/uS+blScM7NlNnvCgupWVYQlaTF4o
         kvkA==
X-Gm-Message-State: AOJu0Yx5OiVTmxY3UBf0QEGD8VmjuyzkSC80qk+V/oho6uGWMTpKL1Mm
	m0j5HNluT95VsOKgOdyi1MmPghtazsQU0lvmhc5kWOzNBgFVh03/rYZs4Q==
X-Google-Smtp-Source: AGHT+IFoMFfNEk+1XdtwZUfeRKoL0DgDCHccBq3J8i5gOC6vTN3Kx/YwnDGMKlFEeYigYcPy3fpsaw==
X-Received: by 2002:a17:90b:1043:b0:2d8:aa9c:e386 with SMTP id 98e67ed59e1d1-2db9ff90b77mr19343075a91.14.1726478661943;
        Mon, 16 Sep 2024 02:24:21 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d5c9c6sm6801161a91.46.2024.09.16.02.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:24:21 -0700 (PDT)
Message-ID: <af84134967ef59844a03657f76716ca06b8c59fe.camel@gmail.com>
Subject: Re: [PATCH dwarves v1] pahole: generate "bpf_fastcall" decl tags
 for eligible kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
 daniel@iogearbox.net,  andrii@kernel.org, yonghong.song@linux.dev,
 martin.lau@linux.dev
Date: Mon, 16 Sep 2024 02:24:16 -0700
In-Reply-To: <20240916091921.2929615-1-eddyz87@gmail.com>
References: <20240916091921.2929615-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-16 at 02:19 -0700, Eduard Zingerman wrote:
> For kfuncs marked with KF_FASTCALL flag generate the following pair of
> decl tags:
>=20
>     $ bpftool btf dump file vmlinux
>     ...
>     [A] FUNC 'bpf_rdonly_cast' type_id=3D...
>     ...
>     [B] DECL_TAG 'bpf_kfunc' type_id=3DA component_idx=3D-1
>     [C] DECL_TAG 'bpf_fastcall' type_id=3DA component_idx=3D-1

Note, corresponding kernel changes are submitted here:
https://lore.kernel.org/bpf/20240916091712.2929279-1-eddyz87@gmail.com/

[...]


