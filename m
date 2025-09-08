Return-Path: <bpf+bounces-67775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A6CB498BD
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 20:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8411C178D29
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C10731CA43;
	Mon,  8 Sep 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpxW0UzD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97201A5BBE
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357429; cv=none; b=HRCZltjD7uToxkog8R6Wyu+vJQ608G49oKhA4UC4WgyuFEojLQcV4VrSG+yA3YRHm/VB3o8yBtYbMWGwDKK8TSuare2sNlUuMGXEfw7dTzRE3UApXo2J9SwwEbJD9VU39miu3S8KB7E/gk991TSNPKhcuHAwoKv5Zu0hswECskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357429; c=relaxed/simple;
	bh=ojhvQdZ/4Vhvx4RRLR9M1OKrNNtW9WO3eFCmEUxk+CU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGsx1lUABGw6/dAFtKgPrXUwHNHeMozQ4jb+Q9yZ/k1IAVCopzYFcH/h2WTgU/jAMYiEC+q1OkFZMR79Xxz+F1bnaq1qce72boiHxAx+xpMd+5CF6hKbej1uwEK7gE4PaAvYwkqVBegv2/4fxElif3ANPfFz/R4U3u8pHxBZWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpxW0UzD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so3588697b3a.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357427; x=1757962227; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=567DExlOr030PrtHrLTZzdDnp63BQ0g4LQoX0oIkNNA=;
        b=KpxW0UzDiAyxQVssK2sgwJ/a497R6oTilhJsFkdemdWbf976koOly4Zt6/rJgjxG1F
         pfy4XfNXTldo4IbByRx8diXRSlBKeFVGGNWOVG6EvDf36xW+5YB6PjJ/+YhCF7EEcmdG
         VB0R3jfsWLF+ad0U4lA++/gHiuXyA3ND6ANR+SJvI8yHxcl2ZyYRsiUt7Ck0PEAtz7fv
         DdHjTjPpf8Ff75MJYSjs41Bm7wR7aTNQkPUjvBoyRnvXxW5ujN5rVFCDTSTc5ob+RjHk
         iuak2wlcV98s/mNgb3jhyF4LID90E9tjJJrDgZmq1wbjV/1HRa5KCYXdfXF8ETqCmpYr
         HhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357427; x=1757962227;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=567DExlOr030PrtHrLTZzdDnp63BQ0g4LQoX0oIkNNA=;
        b=mWXiqH44914qtHV0h/GjJrpSslkI7Wrt9rBWs5t3c7myhxhJ1/+WQRYklaJcRXw0Vd
         eMevpWrMX3c7/XugnkiYsJ/T2po2YezjNJYKyT64or5HnsYmyYiqbH0LiJivrnSWo+d9
         Eb7H12YLtwv+4UpLNhqaL/yhPLJ4IkuDjnyGPsI+c3njA/xyPxh4wHIvfcXj77cshBiT
         LZdfPQv8hlckbUZVL2kRyjB+06TbXm9vuLUI+k4g+aqrpwzHrC6xK+Nsu2ZCTsKrnvTj
         AIsolsDZw/DvitWePVX+V4COJ+nhq1Hk5MMR4y//UALT2IFVb74DRfMkSkpOLvPcm7Qo
         YqPg==
X-Forwarded-Encrypted: i=1; AJvYcCU7xZstPnZidgc7R+Q/eC639Uxap5+kcCd8jD3p+3RoS5+0e8z9YTa3B+jBTNHnv7etKVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIitwLjMyZVn67PSsHaFjme7y68+ejWC9HYNmCicJz8t5UfIj
	CH+aivqdAqAjGGEdVX3C+XUwgZ6ti2vKvhLfZhDL3tjlIifo3BSf4tSDV0zQovE2
X-Gm-Gg: ASbGncsUysTVCGGqyZebvnLSAD+BosDXr9v8D9ul1Ij8aHExoAZC2id90+9NYHGBuTA
	LXn1ywudQ+aKObJneer3qkpc6hnc64OYssGK3zzIFbWYvPHwv90qJVUVVMUD+sVxox4ZNiOUgGG
	lYpATn9jbFKsa2YPwQZZRZ2aaQOYkMcoASvo+Lqn3X9var0h02jBQbpqjy7BWmPIhKYKk0tpJhn
	E+mMB1ooEjYG7h+hgU7rC3D4VwDeAD0J8hjI143IyDSPso5d9PiAGDrTcAHGKlqWvNRXkQqqfll
	4UTbcYumcv7VnAekrU7414NiYeVveVVUO8/PaFksirAJ3AX8jgHyWqtPudEIhXEqQxXjpyYwlum
	JD+xl+JGtEc95iWyUj68aOS2EOW0s0qBj6NXFlfZc3gmpFl0XZdeAGPaZ4Q==
X-Google-Smtp-Source: AGHT+IG77L4g2RFBT3gPXAmmrvpvwKGjw5PFQDVvcGM5vtYOD56vxl+Ud+qNNEMsSijFlFaa/X7rBw==
X-Received: by 2002:a05:6a20:4321:b0:243:a7e0:5113 with SMTP id adf61e73a8af0-25345e324e0mr14049624637.51.1757357426932;
        Mon, 08 Sep 2025 11:50:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:613:2710:d29c:cd12? ([2620:10d:c090:500::5:c621])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fa1a29cedsm14662741a12.46.2025.09.08.11.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:50:26 -0700 (PDT)
Message-ID: <9cbc741a61c3015433444978db734a87247ed11e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 4/5] selftests: bpf: introduce __stderr and
 __stdout
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon	 <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, 	bpf@vger.kernel.org
Date: Mon, 08 Sep 2025 11:50:24 -0700
In-Reply-To: <20250908163638.23150-5-puranjay@kernel.org>
References: <20250908163638.23150-1-puranjay@kernel.org>
	 <20250908163638.23150-5-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 16:36 +0000, Puranjay Mohan wrote:
> Add __stderr and __stdout to validate the output of BPF streams for bpf
> selftests. Similar to __xlated, __jited, etc., __stderr/out can be used
> in the BPF progs to compare a string (regex supported) to the output in
> the bpf streams.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Thank you for adding this.  I think it's a nice option for tests that
had to invent a complex __retval() when checking for multiple
conditions to be true in bpf program.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

