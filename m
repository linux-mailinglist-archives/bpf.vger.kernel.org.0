Return-Path: <bpf+bounces-58915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110CAC37B3
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 03:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B5118915D1
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 01:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8678786349;
	Mon, 26 May 2025 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d74wmn4J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFC6F073;
	Mon, 26 May 2025 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223163; cv=none; b=rI7L+xOpH7wuehtwnztdniHziV1RKWwTQAlqgiOvNG5vycXI9c53mSehGs3bgmaq+OXsve/CiONTjbMikZ7GkIwAfTDz41zzdAuT+gXBCft6pZ76p/UwfAYN8/Rs4AEncGxbunSfsLyk7TJWpce4JU0FbM4yUSDpWj6ppsBFOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223163; c=relaxed/simple;
	bh=DPzxGL+30NArKwSIOTj/H4E/kNjfJ6ShBCpRyVxyDJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAwUDm5GC7VtGC5BeCs96WlKrv9AykuY3WXSXLR7cqkW89d5ju5ECO4xc0+p0i+aJgN7VbH2ZbNb4Aj4EIevy8bn8ZXXgFJsZujcS2haMZaHmbnwGWgk2A/NJvTWbqmx18N7WoBrstZLOT7F9Ac4tLPLIxe35FXx9Y1avzOzqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d74wmn4J; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4d33f971aso609717f8f.1;
        Sun, 25 May 2025 18:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748223160; x=1748827960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cGOAkilx+ZhrVPvSVqSnNR8OUi5MMrk7Cz9BvTY4qg=;
        b=d74wmn4JAlMg6eLM6ERC0KQNBtx4jbSgLuyyPpdS3gVd5Wmydize8/uQEZEk3xFez6
         RP64rTWC2KiL38it4EwsR0w5HMoP18R/dfmPUk564B99sGseO5RUfAP2ovSmikoGJbU7
         EeQy8HE6FttNfI+rogEJ3APf/g1l09zqJeSJQLvN0w+nkAA/gsCXTq2JEOpit/bH28RW
         cR4AqeP9i8nL6zjTO1Bz/khvKNlmDYwF2gX+MeQqEmiDzeuJU4Ajj/iN39jZd4veVCuo
         DrWfanDV8bMvN7IaQyUM3TYmE0hz3v4jWRYo52a5th/JIWCcXrF5up6gIxls6spGGaDl
         AO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748223160; x=1748827960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cGOAkilx+ZhrVPvSVqSnNR8OUi5MMrk7Cz9BvTY4qg=;
        b=De5B3J8dV1OJwtQbPqqiIfhzvXu9R0RZOOB4Fwnee0AegZ4P5P2F73NuZ7xmdlLlC/
         DlvDHpBuzFPRBBlLQdXW7E0Jk8LWO/XPL2IaViKjyn2nsjaD4IrTlLNz/akbiTpq4hDm
         GsL74wGyP8Saz3hs7k8dAL5fa+AfJWhCPaayGC3Rj/ZK9KbgIzwvd2um5KkECxSYhbHt
         NDodtStvFEGhya45CNRCTUHyQFXFgdtbIXYC+p13BGD3H/qX1ncjUrfF6eqAnVaThrtC
         3q8azWjCBTzSgAUf7t6w3/1yWAr6gxmSD1QNBb74et9Ik+OYg0VbyHYVVKacxCXU8zwX
         1L6w==
X-Forwarded-Encrypted: i=1; AJvYcCUF+lt0GEMBfam7ZS2PAsQWZI0sYbeURjSGHlrrZwmP8dmRRyaVdR7CCnGXCLDYAPb4hh0cTjbsAinrvJtmtXs=@vger.kernel.org, AJvYcCVRVPH/0M+4XrzP7gpNo6IHip4A3O7PdzBZGLBx7jo3PHGf/8ohoMtTcMyuZ7foRQBKFmM=@vger.kernel.org, AJvYcCX5dA5rMIIPRQG/W114djrzOIAobKKjPSDLq1EYT3VW71KPsVabO8a0zmWqovIt7HG/5JfvwnwjO5AuOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrsUdWEfot+CPP6xtleyTmF6L2ok5hTIEFrZdQY0Gu4Yd1iMu
	JDlBMxgqSpyYaQT4BPqeGMyWzC/kxAyZATbEAsS1zu1V98WWqvh/IQ7YYrbIk8G1SV37tjP89Cl
	v2JDLyDLq0UFFHND/W2/NbGER7ofq0Zg=
X-Gm-Gg: ASbGncuDL4GLNVVRrB0LYcawwm4SHZYLj+yO6uxFFhL7hbnRARwtDwt9z1XSowxDQfk
	2dNIvoX0aKQdJBdWhkuEWxDt2dBb6J6jdZU72T8wAa6W1OiKAazsIrSbCFUpSfv8EtSnytMenc3
	CS0Kuh0iORI0sv/930cVIdIr/NjunoQzXHfvYRCwExQEm1uMedA85zFd+ID6J/ag==
X-Google-Smtp-Source: AGHT+IE/TAn2rgDxN+u4MYzZJ0OWwlVfL2WOif0YnXD+AwCVO8IKHxTOKFgz5WEb61zo8C8ufdqbNCvLPWBFScAdI60=
X-Received: by 2002:a05:6000:22ca:b0:3a4:dcb0:a5f with SMTP id
 ffacd0b85a97d-3a4dcb00cb0mr71467f8f.16.1748223159473; Sun, 25 May 2025
 18:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525224744.9640-1-spasswolf@web.de>
In-Reply-To: <20250525224744.9640-1-spasswolf@web.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 25 May 2025 18:32:28 -0700
X-Gm-Features: AX0GCFvm_Bez1rb1JzQSzoshh3hDkoxHtoczG6bLZpZvk_pvgCEczCjEXVFe4WI
Message-ID: <CAADnVQLv3aX0iOrkAZRgP2x8UAVvy7oYA8x0dUPn7B6FD-10-g@mail.gmail.com>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
To: Bert Karwatzki <spasswolf@web.de>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 3:48=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> [ T2916]  rtlock_slowlock_locked+0x635/0x1d00
> [ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T2916]  ? lock_acquire+0xca/0x300
> [ T2916]  rt_spin_lock+0x99/0x190
> [ T2916]  task_get_cgroup1+0xe8/0x340
> [ T2916]  bpf_task_get_cgroup1+0xe/0x20

Known issue.
Please trim your emails.

