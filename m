Return-Path: <bpf+bounces-76327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48960CAE801
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 01:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1C58304F657
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 00:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E372FFDC9;
	Tue,  9 Dec 2025 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fwtrao3c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F319463
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239984; cv=none; b=D4vWpN9ceXgyN1ib2nS54n+0haYDx/+PfSi63ucyVTJx4ZZaoLecTordWQUlMkS3xnuyJMfTkP9opFB3S/MqoPgcaOoLwkBkpxR9MQEs5aNIxKCJiRxpLxJLjcnyOEXOkZPNZV35z/GQk8KKp1zcBoEvQ3nje6lcH4ZXMbXR234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239984; c=relaxed/simple;
	bh=JEk3Jb3o2V3Ykrxdybm6wJkA8vNlfxfi4dCZ5w/NQfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWGx+69uU3xUpamhxW5LSXtDN/MEWOLXhuU1x9O0tiLEH4Z9splDkqophEuAkkoFmv5UEiti0ORpAFbIBtbQHuU/e10ebqR3XjA48VQpf3zB3pR09mVUtgTZldV1x/RC5RVD+ivpcL4EpahXYey8GXK6FZLtiivclFRLvOhjS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fwtrao3c; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37a3d86b773so44314141fa.0
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 16:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765239980; x=1765844780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FonhJLVNH15zuQuznSG0KVWWqOZ78Kr7QO87AtDDYSQ=;
        b=fwtrao3ccTYsu7Z5jNnTPmsYEU+aRUBixaxcobhQ/t8j9ftt4prjCL4EkTp/JvL72T
         XpNQE0tt6YOPgBU774Om/DRhMZ7mHg2IGu5kdvdnuklajgB813fNtMgJL8nDT3/lMnSh
         JzdcGh3X91XSYX7rTtMgrtXqUvgglaRalZkZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765239980; x=1765844780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FonhJLVNH15zuQuznSG0KVWWqOZ78Kr7QO87AtDDYSQ=;
        b=psGEazXWnEkkXF1Epos4t2Cq+gSyWJB/lCtqG78UpX29MwxBgZ8/9mPNIKgza2zC0m
         cjyFrY+UP0K4IfuKiRhaTYj65BG/kz0Z0ti0RZrmYBTt1+oB1LjHTqHDo1Qf2IAVaixR
         UhNYvIuGIg3Hx/mGCDAuXLNCrZ9uCLWOSu5bxKFur0WD1eqjgNqVWXfjZL3MLElI8MTR
         xPVcig9sE7ZqGEPIrbi7kVwJVG/XhHcs57A8pHZWlmsIZ3uxEVFFV0HyABn9Okv2Crif
         kna9/VG6gMin68qCvSlxJEyxLwkXuySbOUoSW9YcwH/55eJlFXVnfCzsY4sJys1m7QY0
         URZg==
X-Forwarded-Encrypted: i=1; AJvYcCUus9APMWstCdl2S79q/fQydDgb5C9irKeARyUlT2nLrCgTKi3J/+6V+9/bdR7sox/P4pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvPu72GKs18BZr/yD2ONvN+c11pRc+C5hTPWpT1KVpSi3GZWT
	FTi8juh6lq6cJZabBNzaw3F6BggOEoT9QAleVe60mhv7Etek8r7cLPKLviM/jOzCMbkUFi5FEIc
	qM7E77AoaDQ==
X-Gm-Gg: ASbGncu7PFtiCfS6uBLg4qYfcEj5GzdrZp5rfI9gYaC31kQrWnrlw9XoynKHYAsHdAl
	3X8eo+59RGG+3/edk54BMAYLcG1dENOX5e4o90SMr4TQ02f4tWpE1qoFStP1LN5QjZ+C30bd6SD
	wnxKSyd8wPLxD0Fj+Mw9A/6X5tWk4R53FPV/dI0nEGLPkrZQncu76oMmMbr5X7yp+RBYQqmXgmw
	Xz5BVg2rnTx6h/YgwO7F5zLdMCisZkPHQ/x5AuzeqDERtPPdpUplX4loay8OOavJmOXIA6ae8aS
	kV/5t2xi6OwCb4esb0WQrPtBTdi9DB/c0wJ8mi3/4Ems3BtVPtEPsRBnZWxuzvAZSMNOBSwGdq5
	J7L8aFChKtMInrV9sKIRp3YSRrPSnlcDgI29iON2kIjMSLO+n6Cytjx1nxTqe+Qh7tldwpWUlHK
	nV4r9ptLqoQ0e5wl8X1UYQmKB3b6Rx1q9ijSMjNyv3S/zEO6RvhsDCzgHyVKuY
X-Google-Smtp-Source: AGHT+IEeKaA0Y3evpVttZXGq3ylrEMR54KBLKDSWnQ0NExF7oNsk/GQR4SpxOJsZT+AJ/ZPrMQQ7/A==
X-Received: by 2002:a05:6512:e88:b0:577:285f:32bd with SMTP id 2adb3069b0e04-598853bc5f0mr2832040e87.26.1765239980311;
        Mon, 08 Dec 2025 16:26:20 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c28216sm4510085e87.83.2025.12.08.16.26.18
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 16:26:19 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5958931c9c7so6279761e87.2
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 16:26:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXB05oil3bloHH4IgPRUl4rG94An8iLS+nEj2O9LgaMPodOK6T/ySh0W7U4f7blt5YarLo=@vger.kernel.org
X-Received: by 2002:a05:6402:4403:b0:647:8538:fcf4 with SMTP id
 4fb4d7f45d1cf-64919c10408mr8423201a12.10.1765239641812; Mon, 08 Dec 2025
 16:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
In-Reply-To: <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 09:20:25 +0900
X-Gmail-Original-Message-ID: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
X-Gm-Features: AQt7F2roobmnBFxkxCTs46omVLlLQvijaEzayZmWK0Hwr8qZTgYHcUtxshIhuTk
Message-ID: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: pr-tracker-bot@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jir i Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yu feng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hmm. I think pr-tracker-bot is being confused. This one just came in,
and hasn't been merged yet.

That merge commit link is for the hwmon pull.

                 Linus

On Tue, 9 Dec 2025 at 09:14, <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Mon,  8 Dec 2025 15:55:26 -0800:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git refs/heads/master
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/b88b2f82fab45521cb32c0b737266d90a66a748f

