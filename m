Return-Path: <bpf+bounces-57460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E26AAB811
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9223A7B7C09
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A9257427;
	Tue,  6 May 2025 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e84uC+Dv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A9291169;
	Tue,  6 May 2025 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746490427; cv=none; b=Oq7r2NQNgO2hTBXbf6SchZdxsmI0/O6PIZJHlUemQgTJLUS7S4vHDDgfjMajQaW+U80C7JG38VXaqixE56Ii5am5IixVQYkCAYcWjC3vx1FlsIk2aca/9M6K1sIX3jDfnGzePEQnjpplmB+XCTL/gxB15GTiyqoACeSnBqVCp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746490427; c=relaxed/simple;
	bh=/a5HUImWEz5BNoM2c/V6GMmjpxb9mo6IzTfiwYmZEzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnN32p+pLnNUCugt71iVV3dqnuj0szJbaeF5UXRItPudu1mD5Vt06Qtz6k50EjBhsKc08pmfF7C355OkX5lhNRO3LH302d7IjaDm7q0oekCXn1FdNaLjWQCFa9kQ5HKQ4YZgYGZZXiGyFDxnvkTWTHOmxST0SoRTO/217NwCsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e84uC+Dv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so3245093f8f.3;
        Mon, 05 May 2025 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746490424; x=1747095224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCZcI8hRIGhtmr+XrzrGBpNOJtpgJzfmfNLi2ExujFk=;
        b=e84uC+DvZAAWhE4LwLudInwlZCBELsHVxUETkVk29uRMNF5CxdC+kW0G55fNBC7VIQ
         LZ85jK0sYnHWGIAwRJKoSvcgllf4/RiRkOJgg5VHMtbpbuT2HIBqkht5KncemKX82tep
         JFV21cN9OsOI4MuA53lMi9lk4mefCD5/G99XFqzwSusijFVpgJXQEGJ2V9RX5Mk8Itx4
         KdQGn40FfOY85svxJbpb0DaquXRr1jI70Nu78Od2/CfEm4BPwsnJCskhOI184dcxLHSD
         JRFdodBSaBAkO8k6u8bxU5ARKnKSX/CkRDcWk/K8QAwP6H0rZvsAxi0UrGm6NTKqfC+K
         xaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746490424; x=1747095224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCZcI8hRIGhtmr+XrzrGBpNOJtpgJzfmfNLi2ExujFk=;
        b=je9s4Ar4BOYONP2yIaOK+KT/igIlEB8P0quP2AzoezrHSJgRs6e07LIsQFM8HS8hy+
         B+crBDhMGipkISxhOKFmf+h7ZxDpJCCVXr7o2XyhrtEaQj34VXBWDOpVX+KEyVWu0/ZK
         KbNKqc6gC1FGURki8lXJliaXfkCogZu3zeSZzIMHvv7vZaNdA5zzhldp/k5IF0vxi+dD
         LWebzBwBbu+iWuOcIdX35KeN9U3gNyLZZrxRNO2+A6kSX22fur/OdIcKcXjBJrqyiIeF
         lHohBiQIvLnnTel1vVLk6fKuxb0M0aui0On4gCTyJ89RxCT4Wq0GbJ4ifJlS0xXabUov
         RFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZkv35sYFE/D9e5E8uBrALAsGVGijx1E89NAccBhYTU4ELLoh4bVEP+9tA99Apj2BeopaSLbbY@vger.kernel.org, AJvYcCVM7EbiVxIJmzfCQsUiO++JOCgvcalgGtpfCgdxSgPDUed7lCImJGQkPS/BNV1jRkq18Wh+p8Wyh8BOS/1z0utFMN6dBE3m@vger.kernel.org, AJvYcCVNxJDS7VD+urojTze+1pFSuAe+tEs3xVDJf1QI3DCVe6ZKNNw4AFfTMyIk020iKd5EKlDApAjysg==@vger.kernel.org, AJvYcCXSzJGXKAYck4U/zfeaegmmZu6KqDXSqpj8sw5m+AZohpQEeLznYxtLZV1q6idLmkA1qMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXFtFSGcyjk2PlWJw3zTRAYXvtTeGPPvreq2KyrFuSTHf+11o
	HFVQp0N0V2gaLYXXsSJZd2OyC4tnDibZc5oMhy+8IU5AFRrh1ENUJp4zXJ+w9Ixi3iI2CwFisC/
	Fsq7ONxdptW4SZ/7gg5BDjgqvRuY=
X-Gm-Gg: ASbGncuXbxKsk61sjfflG1o5FcOgE4mHhJ9sBpvQSuBehhAckgdiDeJDB3XkkXa+GXB
	Z0KcRmzidlw9sU2fF3WDte0vXapuohpiF89AEQh6m3NlKzwS++cwB+8VnrVXpSgMBFBq2xZ4d/8
	+iBhb0YoA9lzgGGGySzADfBj2shRFtU4/bw3AfWvTKFgrNksjDhA==
X-Google-Smtp-Source: AGHT+IHtR3NK79m98E82oD8fxUdsdIMD2+E/BoT1WNiN+De/07b37d4mUBO96NJP8mK7JNtbitfE0cyUL27jUzuaEtc=
X-Received: by 2002:a5d:64c7:0:b0:3a0:7d82:d454 with SMTP id
 ffacd0b85a97d-3a0ac0da24bmr615835f8f.20.1746490423634; Mon, 05 May 2025
 17:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505215802.48449-1-kuniyu@amazon.com> <20250505215802.48449-5-kuniyu@amazon.com>
In-Reply-To: <20250505215802.48449-5-kuniyu@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 May 2025 17:13:32 -0700
X-Gm-Features: ATxdqUGbYmn4h1itPnw6EEMlK8NpKkCA51KDAl4WX7ehRvESdQez3TCD3r_RdFE
Message-ID: <CAADnVQK1t3ZqERODdHJM_HaZDMm+JH4OFvwTsLNqZG0=4SQQcA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add kfunc to scrub SCM_RIGHTS at security_unix_may_send().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 3:00=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> As Christian Brauner said [0], systemd calls cmsg_close_all() [1] after
> each recvmsg() to close() unwanted file descriptors sent via SCM_RIGHTS.
>
> However, this cannot work around the issue that close() for unwanted file
> descriptors could block longer because the last fput() could occur on
> the receiver side once sendmsg() with SCM_RIGHTS succeeds.
>
> Also, even filtering by LSM at recvmsg() does not work for the same reaso=
n.
>
> Thus, we need a better way to filter SCM_RIGHTS on the sender side.
>
> Let's add a new kfunc to scrub all file descriptors from skb in
> sendmsg().
>
> This allows the receiver to keep recv()ing the bare data and disallows
> the sender to impose the potential slowness of the last fput().
>
> If necessary, we can add more granular filtering per file descriptor
> after refactoring GC code and adding some fd-to-file helpers for BPF.
>
> Sample:
>
> SEC("lsm/unix_may_send")
> int BPF_PROG(unix_scrub_scm_rights,
>              struct socket *sock, struct socket *other, struct sk_buff *s=
kb)
> {
>         struct unix_skb_parms *cb;
>
>         if (skb && bpf_unix_scrub_fds(skb))
>                 return -EPERM;
>
>         return 0;
> }

Any other programmability do you need there?

If not and above is all that is needed then what Jann proposed
sounds like better path to me:
"
I think the thorough fix would probably be to introduce a socket
option (controlled via setsockopt()) that already blocks the peer's
sendmsg().
"

Easier to operate and upriv process can use such setsockopt() too.

