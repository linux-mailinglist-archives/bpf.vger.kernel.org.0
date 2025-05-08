Return-Path: <bpf+bounces-57821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D21AB06A4
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1800718892BA
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E823185B;
	Thu,  8 May 2025 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2q29rpP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C62101BD;
	Thu,  8 May 2025 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747624; cv=none; b=ATk539xfdEM4o2IpRps3kq0KE5PWLBc8CKvqjEaMKIM3KfrWKgckkKOpKfS6v7yAUYl4WjQ1zHB6qQVameMKA2fGf+8enRc7Jb6pGwAUfq10mY3uOVNA7Us8L4133GBZCIKuwcLqFZcQECaNf+U2b9gopD9coN3zBclM8T2+6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747624; c=relaxed/simple;
	bh=UUWwBn0rncdSTvqDy6og+SIyhjFFbURwK0mnp5D1754=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBpgGYJYqBPYIZYxC0Gba9oep1J5hIhMAv41/DGQcuswrywTEPg9aN8h+F0TIgpYcxGXRiAud5UpNYuXuUxp/vDyNOeOPJ+Wn8jIvIB7zzluBsIvrPBWmVqnl3ZeMtIB6RJyrEpS1gyM0XLQCTVQ9egjUSmqxuVm5dlmqsyNgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2q29rpP; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad221e3e5a2so3496366b.1;
        Thu, 08 May 2025 16:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746747621; x=1747352421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4XCAHAZpzbjMjFqk38iU3CCdfAml8ce6xfHMngiKe84=;
        b=K2q29rpP5IMSzMzGbi3os3Lv3xzNurOKcWkOlmjo5FOfN33P7ppUjnEYrFoeDIsM96
         7evP0kfifm8B1wf6XdpQy5l1lSO2tncDai9z4HZTheMQNaVW/3OBi2HkrcWW2vw2YkYZ
         ORBj430/zcIMQIEuiWRbi1ISXycVT5/qKfq4DW84rmCm0pPsSLbCMM63T1OOzIOzcxgk
         ZIJHrETQccD6o/3hpURDr3W0C8+FcBbfGr4QWnWcafrQrSVgZlTbvne6ts8Yn/eEok6z
         jGMu9xfTteIXCJtqR3cdcItIZh3n6On7uTe3u7bf2N8bk//47hhg4X3dLvxlwMm8tiu0
         3q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746747621; x=1747352421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XCAHAZpzbjMjFqk38iU3CCdfAml8ce6xfHMngiKe84=;
        b=W4dKP+Fqq0IIRptpLWw6haRK7QudZ6R5sG7tbjrNU18OtwinrpNq4ZwmbzYBFF2AlA
         CNg/DBemjcJC0vdAVE7o1YIFPwLdIq2M70JlZcn/SR4XzbeLZhWC+JgBwT1GXrL5iJry
         cN94jgVdnPYTARpVF9OOlqXevtSWZv7e5uHZs/tkO5+KGy7eyWhFMXhMV7yu+QYnhoiW
         Afi68+q6k9JgoRwegEX4PoZYr8YI1TCW2eAWtIX5bHRfWlm1V6vSpwcFtHcVAkgFtb1/
         UdBEmh6dgP1xIwU6UPBzN16OQ2fGwvjAO38FsEyJ7DZFgvSamnuNfMzz+Ij6MenhApqS
         hJSA==
X-Forwarded-Encrypted: i=1; AJvYcCUzMPMkFjbHOHX7UTRUXg85r/o1WRA48rMsPLMd9tMFk+/7ZmnN/3BC0kHjRhI/DX6ddtHg515S@vger.kernel.org, AJvYcCWB2miFDTH+1RRaQfx/lYdPxYu8rSzqXcTsahCz7w9KIeFMx2hH28XnTe9HkF8qqXUar7rXEQ26cEy1yrsl@vger.kernel.org, AJvYcCWNdU8pm8HlyvvwRdN36utzL4TSujF2gdP36loy85GDsVSRKITqOGvlTyfSYPTSETT4gWqAPn+S99fIo/2eFwdIUx4A@vger.kernel.org, AJvYcCX+rS488oWLf0qMIDuKdsljRj9YIruGGaqqxzfddUHNC480lM+siAWgzmFrq9iog7S3cng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGekrwmil8ti0IHQ5BWiebiQsRfqWpq5tOnG9GSagawDsrBaf
	YuDtsVIxQx2VuUr3LutpaLxTlUPpNL3lY0+uQSRtBEJHXgdD6Huqbma9RL3OnzcESUWPwrY7brx
	MuR7Lw4FM4RWW9Cx/pRjS0civECM=
X-Gm-Gg: ASbGncvdLCJJHKq5UeAkXEXEtuM+jvp5Wbxn3vHMd6iN2e0AblooYMzWbnS1LZxyIDQ
	lt5WfuwfKw+qWUdH4HX+VcL1e39yKrKNuk1mwxLeRrJScEHd5anitaGLMQ8MnhnhNMgVrQDa78C
	FSSH/7EbRbkf1dPkjgeTur26L8zpH/eOGy2K/zfdeBnvVnWI4O06WpEET9Q73Sf80R7zw=
X-Google-Smtp-Source: AGHT+IHApQ5OFCfaQS1mUn74daoOJX19yzwZ3sgdO7xX9LpbyPb3Jm1cvNGKxG3HLWErcANGLvfkwfd4xsmogUZmAeU=
X-Received: by 2002:a17:907:8b8b:b0:ace:6fa7:5ed3 with SMTP id
 a640c23a62f3a-ad218ea5b8emr158033066b.4.1746747621004; Thu, 08 May 2025
 16:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000adb08b061413919e@google.com> <681c597f.050a0220.a19a9.00bd.GAE@google.com>
In-Reply-To: <681c597f.050a0220.a19a9.00bd.GAE@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 01:39:44 +0200
X-Gm-Features: AX0GCFuVY9CBMsQxhMgZpZ1X-fEBQ2fptYrxdbELCJogxYT5Wfp2wwF916mNEpY
Message-ID: <CAP01T7525zDpL8nhsLLULCK1Qzw8wVCmHuCX_81Z_HaQAs-q4g@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
To: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, elic@nvidia.com, haoluo@google.com, 
	hdanton@sina.com, jasowang@redhat.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	lkp@intel.com, llvm@lists.linux.dev, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	michal.kukowski@infogain.com, michal.switala@infogain.com, mst@redhat.com, 
	netdev@vger.kernel.org, norbert.kaminski@igglobal.com, 
	norbert.kaminski@infogain.com, norkam41@gmail.com, 
	oe-kbuild-all@lists.linux.dev, parav@nvidia.com, rostedt@goodmis.org, 
	sdf@fomichev.me, sdf@google.com, song@kernel.org, songliubraving@fb.com, 
	syzkaller-bugs@googlegroups.com, wojciech.gladysz@infogain.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

#syz fix: bpf: Convert lpm_trie.c to rqspinlock

On Thu, 8 May 2025 at 09:21, syzbot
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
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140598f4580000
> start commit:   c2933b2befe2 Merge tag 'net-6.14-rc1' of git://git.kernel...
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108e1724580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177035f8580000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: bpf: Convert lpm_trie.c to rqspinlock
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>

