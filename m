Return-Path: <bpf+bounces-51792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3E7A39113
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 04:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76B81894B6C
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 03:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1F14A0B7;
	Tue, 18 Feb 2025 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NELRj6wy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D719475
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 03:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847692; cv=none; b=MtlgyY2/rKzj488UW0DelMu0qTcSaRXaDhwyQVlG864YPsffolrvEmzRb/n8IK44NJsSb1PTVWKZMXprvelKpqcxgsZ38Y0y6QQ2u3bfgi3qvXMZP3SxtjZJUUUYZWm98S5vwAYdoU9OJ0FBJMPXTfVn0otrQbH+m15BP0IiHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847692; c=relaxed/simple;
	bh=p/MkKIc3o7kslgnbsXDyivvoBLaalSlQ/MNyJHc46zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvtXs0xXw7gpl7B6ov/uKWHbryP5OanH8n/KjbQhzYI0VXQmDdOHvwSOUHEFdSPfwhZeJXlQGJHKbIlOS5wxa8ZXH1A5xajNZRECmXyY3dYOJ9wdlZP9Yp/euId/WPvLY5XKEw+fWvA9xSNesdPmKxySWGaPsNb+Vc5Bido7jyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NELRj6wy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43937cf2131so33105135e9.2
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 19:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739847689; x=1740452489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/MkKIc3o7kslgnbsXDyivvoBLaalSlQ/MNyJHc46zM=;
        b=NELRj6wyrUnmtI2yHcTzM+HuZxAP9rFzSqm0p75yO/y69ABT98prWiS9ABC7aihYgI
         jZiWQyfrBNN8mpsEPL5OjKudOXbmDaY0INA10PVFBKfcIOh9uM6+82Axrwqz0TAROQ6z
         LiNdwW33nCz2Xksx2mPK+2/0pEHJSAIBCMvbFgB3aZcMFAEbjVrzw3fLZ6LFMbA/1RHL
         Q4igjw0nAVH8ZciVZRWwxhJ0JN38VTBHoRaxvUrhHNnMtA2y9m0KGWLo9V8XDxKBmYTw
         SnCRoM7PywFRbAs+ZpKp2w1xUpse47JzcZqQQ1SGxnsuIqzUpFlh+la1oSSAQaQDejGo
         TgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739847689; x=1740452489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/MkKIc3o7kslgnbsXDyivvoBLaalSlQ/MNyJHc46zM=;
        b=p/n05Llttpc5te5bPpfajMupXndbqL8D0+aY/51H59FzRY07sBmHy1Y8tXCK3M1DiV
         I5Z1n+wit5gYE/kVlkWEx9ulqlNJQI2VcNdypGcloBioqh8zGED5M0515Mespw7yzz7H
         18DU8VTMKY+lhTCCO7tVt5ALohsyXVdjaVqHDU+Pb6ciiJ7jncyAKh9KViRn3E1obzuj
         4IAj3ETGdMGHmJjOV6U6+aFBG0sMVxwvi2VSYS4vXhdp81Aiw9GR8s/x8R+CHVy1OUqn
         V1uRNf0uR1fetyhpzXVP+J5pHmwG1619p0KWDLDpeDb56t98rabY+aRABtErnLC2TETi
         MyOg==
X-Gm-Message-State: AOJu0YwR9UyPSpgTGoNnm3vVl6eI61+YXyWMGnjciM92wfpKshG8KLnC
	JB+/JuD5GDitv7plmuxcIBngXELUFFEnYrPlHcXT71IlKp0BIlmn6luVblCgqOyc0TCF21ISske
	ii67icYzP6SC/BxBBNXv4X83Z8Y4=
X-Gm-Gg: ASbGnctG9jzSi0uxNJWUfYEbku48Glz0vJuo1pGK2aG95B4cxw0ADP57mZMvOku8xuf
	RXHPGgf0Ke+nxOr52Nm1591vxm1DrN1KvmQli0qElzMlImDiqus6YrQR7hpXhFNaMy0YonxMd0J
	K0MSnVbO1V/etMOfGOF9PSokz/V27z
X-Google-Smtp-Source: AGHT+IGE95esH5HcupeeCBlz7diaJ94iKiV6+TMRjVklWhXIzPWGQvsHJiqS14CZSbC2qMv2qZ3e6VAgvtGJUduptY8=
X-Received: by 2002:a05:6000:1fa9:b0:38f:3aae:39ef with SMTP id
 ffacd0b85a97d-38f3aae5d3amr10361853f8f.21.1739847688674; Mon, 17 Feb 2025
 19:01:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154318.76145-1-leon.hwang@linux.dev> <20250217154318.76145-3-leon.hwang@linux.dev>
In-Reply-To: <20250217154318.76145-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Feb 2025 19:01:17 -0800
X-Gm-Features: AWEUYZmTpaAsQl4VwwoCpEhIbbI1qNfq0_aVrtFuGD-Zxpy_IAQsnQA8FPFBSTU
Message-ID: <CAADnVQJ3XHgTVVT9=wtNtCNaERpiYnL-c9=kDART_9cejwBSqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Improve error reporting for freplace
 attachment failure
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Manjusaka <me@manjusaka.me>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 7:44=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> When a freplace program fails to attach to a target, the error message
> lacks details, making debugging difficult. This patch enhances error
> reporting by providing a log that explains why the attachment failed.

Agree that it lacks details...

> For example, if a freplace program tries to attach to a static function,
> the log now includes:
>
> libbpf: prog 'new_test_pkt_access': failed to attach to freplace: -EINVAL
> libbpf: prog 'new_test_pkt_access': attach log: subprog_tail() is not a g=
lobal function

... but adding to uapi for a minor usability improvement...
not a long term path that is worth taking.
Especially since freplace is special. Users don't interact with it
directly. The interaction is typically done through libraries.
So this extra verbosity won't help users directly, but will
help people who write libraries. Nice, but no.

