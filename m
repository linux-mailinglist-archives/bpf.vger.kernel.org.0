Return-Path: <bpf+bounces-53105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA6A4CB61
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 19:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F79417626F
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF56E22FDEA;
	Mon,  3 Mar 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVC+M59Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2831E285A;
	Mon,  3 Mar 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027944; cv=none; b=Lxar4a1v6rGptHwvluw48N5iraDkWRKvqNQVE+F/F6UThxp14YHOQAe8PDn7V1IT4XJ1Xh0eTSYxqOFhees6emE+jXQVnAQsPZo3kM6kuNcgl0TL+qIdavryf2QIg7gHNJy9MAQ6ChnkDkEmlv1JKABK7Qn8ZsfF+iEWZJ9SMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027944; c=relaxed/simple;
	bh=ri1EvwoJRI57B9+2tq6b4mnjbxt0riaIa9Jm/Y9S2xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYPnQkXVl3WKk80MYQN5RDBf/eFhiTgyDBKNDVbF3bBrjWIp+98dpE/vHlEz3+A9MQt1SQ8Scph5aGwRUm1wpzyovQArTeajn4xW5G4tLJQGbedd6wBWyPSyKrNPpX5YfxdmET5w2wWHw9rq3ZYt3KVKjpdM1elIBvgxetLqJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVC+M59Q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390ec7c2cd8so2273486f8f.1;
        Mon, 03 Mar 2025 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741027941; x=1741632741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb5V6oxMTc5Lgs5t3WuZtNTHjuiR0TEmQLLvfX9+d/M=;
        b=KVC+M59QVSwLAFedWvIVHYYdM8OiOXBMlPnlcK2hzvRw+f1qokWtJU9LHopxdqh/fr
         D4Ez147tC2j9dCLXMrfOgvMBCfZn45LkU3xIm5tpy0UgZEEubfpXNxiEuTgg0xHfkKbi
         pWaM0yFnKWSNCHoqLJ5TS30h42GYQG0kk8D6OwTNd3rXiTujQvOVS2QyvvisRC8HN0kc
         O04S8GOGnE6BAadEmr1mMu5zD2DN6SW9oQhyw0LuRjcymRUcVEUvxO40zwiTaL+DnB60
         Mxg0cyBodpfpEj+8mxYPx82A7ztC6tf4G0tCUFsUHaThbrqQT8kIBhVXWD0K70EE0NOa
         RGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027941; x=1741632741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb5V6oxMTc5Lgs5t3WuZtNTHjuiR0TEmQLLvfX9+d/M=;
        b=FPXwd4pynUaiYTdxH1QmKinPCkfiVr518kfX63mMZIv4MHAVZIF/pn7GKqSKab2/iu
         dGrwONQcnS+XY1cFcZDy3WzxVAnlHDJs8vfWgjuq0c9+v6A0Dk9ZdzbRVubu03gXjeuG
         c4M6QkZE5ltVIHRNXyf7H6XevaFiJV8L/NvjDT3IO6RcJ9lnvw3Zq2QkkXmjbSvs18Ef
         PqDZq3GrwM64jfgGWK9AMszDOtvw6DBnZjFCeRF8W5yv9mrK+94ceotFiIEUM03A+jn0
         O37Dll+sFDs2Vwkpr0ZLrhpuok4yaNpfNmS8kXAnk4ww4FfwMEQWLW2wKVRKLBrP/LlD
         tj9A==
X-Forwarded-Encrypted: i=1; AJvYcCWmIzE5hoqzrYfq3WtwslYcHYbdjkSKvgpwwbApba8D/XK7+IXSGbBjlrNmC86gHC6XXH7J1Mh38mZ7wZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cR1rZZLqHwDO9WeJtqPTi7+X7+dUGNdZJ44RR3s8U0nJu7yZ
	b/pnMTfosLWiAAXmlbQbEuS9wSq+Wt2+Gq74ieR8PCTADoaZzFzj7tU+vDF7lkkc2qaczY/r+D/
	m6OR6bapVfmFWjTq/aQ69BpeyiK8=
X-Gm-Gg: ASbGnct+ygpL5/X0ltp9CClmRkXlbkC6emoo/Np7UBuZeSibKlecRDXqXRDLyu8oDNU
	C/SbXSBX2X+doDMvdU+xEo22iE1KRt+/Y9DyB1TNj5TIgBeKI0VYRS8+7Pkf9bUb5L9exFzHqHu
	5wTejB8tcE8FQZa1JimIbkW/5tz/FmjP2iHOcvEDHNaA==
X-Google-Smtp-Source: AGHT+IHnZBbHX4QElW1DWMreZTHhDpaQknBh51JcyUMZfBlOP/B0HyGo9KEmQZFrsra49723GFGoT6jKhOTVwWemjok=
X-Received: by 2002:a05:6000:1f8d:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-390fb370470mr6928710f8f.46.1741027940749; Mon, 03 Mar 2025
 10:52:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740978603.git.yepeilin@google.com> <8b39c94eac2bb7389ff12392ca666f939124ec4f.1740978603.git.yepeilin@google.com>
In-Reply-To: <8b39c94eac2bb7389ff12392ca666f939124ec4f.1740978603.git.yepeilin@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Mar 2025 10:52:08 -0800
X-Gm-Features: AQ5f1JpXrd_zfB7BE28u8dY7mQWsRaJQVmXworXNHuBlKbek7ljLtxiaGy0Y8Kw
Message-ID: <CAADnVQKyMx64_mP+u+rmnRGyzVoBs4rViTHeE4_0Rr+Kf3R5Tg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/10] bpf/verifier: Factor out
 check_load_mem() and check_store_reg()
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Alexei Starovoitov <ast@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 9:37=E2=80=AFPM Peilin Ye <yepeilin@google.com> wrot=
e:
>
> Extract BPF_LDX and most non-ATOMIC BPF_STX instruction handling logic
> in do_check() into helper functions to be used later.  While we are
> here, make that comment about "reserved fields" more specific.
>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Peilin Ye <yepeilin@google.com>

Applied the first 3 patches.

