Return-Path: <bpf+bounces-57784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B65AAB01FD
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 20:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B6537BFC3A
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC80B286D51;
	Thu,  8 May 2025 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP/UOMnD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658F285418;
	Thu,  8 May 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727230; cv=none; b=i7D96NXRvHmj7ellSJK4t3e3IfbPDZnK14DqxMVlPCYZd7IOOYI5BZgG6DAzfXWwxqHiZGhTuTiwVvvjLDSZ2pmJ/c+O243+Y0IrV96bvBPxvNqZAENjapy0/vPCBW6et8cFij4qw+lDR+F1kBbcC1+8JXbOfKoKjs/WJYXN6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727230; c=relaxed/simple;
	bh=2OWGWC+dP0dKojtoPDjkn+UmT2pXXCdVjZjDutcVEEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIavvwSvS1nEilAerVCHd6v9yS6r0muzP+iUz6XZgpVw4UDWJAIaD4miRr8pA1zGkcQO17DbF/YQGTE9XZib402iCFW/EqNTWQBo5iGA0yKSZgxZjvuOAgOiqVd41QMn+kxFl/vPiVad4nlFLP/7ow5wft3ObS9FSwKoM8iLWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP/UOMnD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0b9303998so606010f8f.0;
        Thu, 08 May 2025 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727227; x=1747332027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8OzbUVZza1sG9/bcAYaixiPxApsdaZfuysNbzaB9K0=;
        b=NP/UOMnDbGDGfBzZUvaGacJP/Ri5cfJeRiP++Nqz7JMXY+3DbWWsCiMpfaCTA/eFYs
         2ATFOx4nhUKySuFNsl1LB0SS/X5a9ZDadsBxfeVx3HAKbKuP9yV89bSPiBt0Rv1Mihhq
         NsH6mtncTwjU0D9ZzulPVUUy9MNtWR+qDtOuzPALTg+lFTQZPTOZM+F94KrvMNwwW8La
         wwesC4BJMN6p8Cskypt0GZ4waX6eib7ilGdB0h0yXCdf6dkgPU4N4e8OCnqmFdtOhO0s
         fY0c+1nyiQB9PXw/BhhHlhBrkJJIGzhGZd8xiJFL89BLP+y6fbZb8AKEPoFjm8ZodBcX
         tBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727227; x=1747332027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8OzbUVZza1sG9/bcAYaixiPxApsdaZfuysNbzaB9K0=;
        b=NOgkHDVCDKWjcV4nzFPd0UafikyPGgDSyO1i/a8NE5qy0ZgaOBE3HEH3Nqqw3Xa04v
         D9fw2riOSuB/hoTHAwXgrZHOssoylPMXYhxsrNgj+TMiMXlzwNeTOUhKzp4dI0Y852Tq
         ObtVj3prvhB2kCf8FIb0nZjLQ3ozIgsgbzyM5Azn2hmxxMEnL9S2uj5Temag714AzrU7
         d3lKrKVehoS8CNaxBg+5X9b/povVQR7kR7bKo8acv0m1KxVCYA2JRW3jUFk9SOv/LQZc
         uifgmyK6j2LWs1WO1PGd/7AYOi5oBo5mRM4dPBAh7FkLkwzhCqLL0FqB8rBxKA3Ykpbq
         TSKg==
X-Forwarded-Encrypted: i=1; AJvYcCVYbRF/JETwWaKD6FvG8riQdiSVNYJoDiHIVBsUIPOXGBGZzq21z+mxmckKZwFO9Jz82CY6SYyrqNliHO8Ke/MA8E/L@vger.kernel.org, AJvYcCWRO1IHMy54LDor36nZ8+MXw1A+bDxs8jWHk++scG6DhA3ljCtrlIZkEbIHbQv+awHGRfo=@vger.kernel.org, AJvYcCWxhwMPTtlDkyDHkI08J+M/LiUFOo5YAk+KKEVhkOK1YSJdWnpOV6eWyH4WkXDC/2F/9+MgF0OfFx6poLUf@vger.kernel.org, AJvYcCXqEIBDOScPagSGjHLzMY5n+GwZLHxFcUrXTIq33NtDsB13tKCnK4Ibhb5XnVnObCST5EF1CoIK@vger.kernel.org
X-Gm-Message-State: AOJu0YyShSDrkToego8XoAY6QTUk5WNLvbJHj2p6n+kCIjRh8D6RkNxX
	grHVLngoGZzUF5l5zvnzpxC8QX96izHWBkARaLjFtgXrqaWCgF2irGDr9JwGZnu6Q891PubKmNO
	pbuug75wHGvSmVbUaUo+PIGr9rrs=
X-Gm-Gg: ASbGncvVCCFSvBD0bq3eV+lONnV1Maa0xH/fkM1/8y1cMmPuMGWITysSiqiHgTveiQF
	Mc7mRSUxQCn2V500W4on0XXhYPGw7l9RMZCCXTi9jGG1gy4n3rOxJ/e4TDzXXxByeg2vIioQXVm
	BX+bB/YK0uD6t4pwDYKKJX8Sgo7yCzjeK2EdL0jw==
X-Google-Smtp-Source: AGHT+IEutKBReXc/JF0L32VsIMrtixijgJVzJAL0lR8pjAQZNt/yCBZuqbqZ6pmFsmAhXU/Aot3H54T+8SiQBmMlyjU=
X-Received: by 2002:a05:6000:144f:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a1f6c984a1mr218850f8f.18.1746727226602; Thu, 08 May 2025
 11:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000adb08b061413919e@google.com> <681c597f.050a0220.a19a9.00bd.GAE@google.com>
In-Reply-To: <681c597f.050a0220.a19a9.00bd.GAE@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 May 2025 11:00:15 -0700
X-Gm-Features: ATxdqUG6Mkg4Ho6RZmO8HnmSlk8KmcFHKHxysJft20HZr0IOkm_SdwFkRH0L4Ws
Message-ID: <CAADnVQ+cu2yt8v=8KE32Kymw_c-KLFUmbxZMxxjqBksafyNHiA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
To: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, elic@nvidia.com, 
	Hao Luo <haoluo@google.com>, Hillf Danton <hdanton@sina.com>, Jason Wang <jasowang@redhat.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, kbuild test robot <lkp@intel.com>, 
	clang-built-linux <llvm@lists.linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, michal.kukowski@infogain.com, 
	Michal Switala <michal.switala@infogain.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Network Development <netdev@vger.kernel.org>, norbert.kaminski@igglobal.com, 
	norbert.kaminski@infogain.com, norkam41@gmail.com, 
	oe-kbuild-all@lists.linux.dev, parav@nvidia.com, 
	Steven Rostedt <rostedt@goodmis.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, Song Liu <songliubraving@fb.com>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, 
	=?UTF-8?Q?Wojciech_G=C5=82adysz?= <wojciech.gladysz@infogain.com>, 
	Yonghong Song <yhs@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 12:13=E2=80=AFAM syzbot
<syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 47979314c0fe245ed54306e2f91b3f819c7c0f9f
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Date:   Sun Mar 16 04:05:37 2025 +0000
>
>     bpf: Convert lpm_trie.c to rqspinlock
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D140598f458=
0000
> start commit:   c2933b2befe2 Merge tag 'net-6.14-rc1' of git://git.kernel=
...
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd033b14aeef39=
158
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9d95beb2a3c2606=
22518
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D108e1724580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D177035f858000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:

yes.

#syz fix: bpf: Convert lpm_trie.c to rqspinlock

