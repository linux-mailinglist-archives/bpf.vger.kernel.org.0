Return-Path: <bpf+bounces-18342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB17D819110
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 20:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A334A286EA6
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455639AC6;
	Tue, 19 Dec 2023 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7qYD2Q9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A238FBE;
	Tue, 19 Dec 2023 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9344f30caso24443b3a.1;
        Tue, 19 Dec 2023 11:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703015692; x=1703620492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmwwUSeyrYCgHBvw5mHE/b1bJ1ioEpUS68KBkhFzJSo=;
        b=b7qYD2Q931MOXAJno00mPYc+Ez35bRD2xNYGBcJKFoU472aLiYY2MZq/qa5zMCAXpO
         1JMRCrOfYMimUeHtCZegxePsG1erNoc5KVj9JhXxGBNWceaPranYRi1Gyw1vVWiC/YkC
         tcOI+3YOwopnff0x+b68ZAi66SV3w7O+80KVTGTidhjHwXOpLErFQ7dtyygizgO7URLB
         Dz3UoEmO+NKndAAne1I8L1VSC+642KrY6O0rdL4DU5X3E9kAuzM0myQKFFSzm4iIA7O4
         uSNWlp2mSnJjfst8NQCjt4cBA+HZLUznZKLDEQGhjY7MVOqxduymr97h0MIdnb+pC7iF
         FaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703015692; x=1703620492;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HmwwUSeyrYCgHBvw5mHE/b1bJ1ioEpUS68KBkhFzJSo=;
        b=Kal5UrA0YmhW00OBTYynlu1bD8G9A/C6ZqbFIlfukOAvzZwVSKRZJ5JNar7beB824Y
         UAhfycO+rASk8mTysvEenkpjQp6NOeksiZIPa18R5WHEZBfGJsIWOLC3wWtLnm4Ce0+k
         mbCgQ1QxnyR2L7RzBt4IOizGllIvNWBKISx8d5qmtsHA1hMq30l343htd4n6SZ+6nf9f
         vTYma5Urhby6fv+GR4Lp/f7jDVH0US99OwU8MNsXIk8aYCLIuCaxGnp5Zkv11OhYQrHe
         YPzEXQv79aUWTjBtlbALwVFHRYAhKdXT/TaNz3iEKgnc/A62DkzeFyfFoNmkTFK3zmDf
         rR8Q==
X-Gm-Message-State: AOJu0Yz7JGBRn7tJj7EFew33FM+NmIJwpKeu2oAfoskEuP1ysz1JpIU2
	xp1vNpf3+hNOv5Ye417gQl0=
X-Google-Smtp-Source: AGHT+IGBIJjIY2nykGLKL/5CLk9IMeThlNWb4vsWcDCOOY7Ihto5pwt+klsCCc9P0Z4N8/2oQpQWRQ==
X-Received: by 2002:a05:6a00:27a4:b0:6cd:dc48:1fff with SMTP id bd36-20020a056a0027a400b006cddc481fffmr2413330pfb.0.1703015692173;
        Tue, 19 Dec 2023 11:54:52 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id h21-20020a056a00171500b006d9367f57d1sm1739361pfc.88.2023.12.19.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 11:54:51 -0800 (PST)
Date: Tue, 19 Dec 2023 11:54:49 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 xrivendell7@gmail.com
Cc: alexander@mihalicyn.com, 
 bpf@vger.kernel.org, 
 daan.j.demeyer@gmail.com, 
 davem@davemloft.net, 
 dhowells@redhat.com, 
 edumazet@google.com, 
 john.fastabend@gmail.com, 
 kuba@kernel.org, 
 kuniyu@amazon.com, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com
Message-ID: <6581f509a56ea_90e25208c7@john.notmuch>
In-Reply-To: <20231219155057.12716-1-kuniyu@amazon.com>
References: <CABOYnLwXyxPukiaL36NvGvSa6yW3y0rXgrU=ABOzE-1gDAc4-g@mail.gmail.com>
 <20231219155057.12716-1-kuniyu@amazon.com>
Subject: Re: memory leak in unix_create1/copy_process/security_prepare_creds
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kuniyuki Iwashima wrote:
> From: xingwei lee <xrivendell7@gmail.com>
> Date: Tue, 19 Dec 2023 17:12:25 +0800
> > Hello I found a bug in net/af_unix in the lastest upstream linux
> > 6.7.rc5 and comfired in lastest net/net-next/bpf/bpf-next tree.
> > Titled "TITLE: memory leak in unix_create1=E2=80=9D and I also upload=
 the
> > repro.c and repro.txt.
> > =

> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: xingwei Lee <xrivendell7@gmail.com>
> =

> Thanks for reporting!
> =

> It seems 8866730aed510 forgot to add sock_put().
> I've confirmed that the diff below silenced kmemleak but will check
> more before posting a patch.

Did it really silence the memleak?

> =

> ---8<---
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index 7ea7c3a0d0d0..32daba9e7f8b 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -164,6 +164,7 @@ int unix_stream_bpf_update_proto(struct sock *sk, s=
truct sk_psock *psock, bool r
>  	if (restore) {
>  		sk->sk_write_space =3D psock->saved_write_space;
>  		sock_replace_proto(sk, psock->sk_proto);
> +		sock_put(psock->sk_pair);
>  		return 0;

The reason the sock_put is not in this routine but in the sk_psock_destor=
y
is because we need to wait a RCU grace period for any pending queued
BPF sends to also be flushed.

>  	}
>  =

> ---8<---
> =

> Thanks!
> =

> =


I'm also trying to understand how this adds up to
unix_stream_bpf_update_proto() issue. The reproduce has a map_create
followed by two map_delete() calls. I can't see how the unix socket
ever got added to the BPF map and the deletes should be empty?

> > =

> > lastest net tree: 979e90173af8d2f52f671d988189aab98c6d1be6
> > Kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&=
x=3D8c4e4700f1727d30
> > =

> > in the lastest net tree, the crash like:
> > Linux syzkaller 6.7.0-rc5-00172-g979e90173af8 #4 SMP PREEMPT_DYNAMIC
> > Tue Dec 19 11:03:58 HKT 2023 x86_4
> > =

> > TITLE: memory leak in security_prepare_creds
> >    [<ffffffff8129291a>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
> >    [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
> >    [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
> >    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [in=
line]
> >    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/commo=
n.c:83
> >    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

...

> > uint64_t r[1] =3D {0xffffffffffffffff};
> > =

> > void execute_one(void) {
> >  intptr_t res =3D 0;
> >  syscall(__NR_socketpair, /*domain=3D*/1ul, /*type=3D*/1ul, /*proto=3D=
*/0,
> >          /*fds=3D*/0x20000000ul);
> >  *(uint32_t*)0x200000c0 =3D 0x12;
> >  *(uint32_t*)0x200000c4 =3D 2;
> >  *(uint32_t*)0x200000c8 =3D 4;
> >  *(uint32_t*)0x200000cc =3D 1;
> >  *(uint32_t*)0x200000d0 =3D 0;
> >  *(uint32_t*)0x200000d4 =3D -1;
> >  *(uint32_t*)0x200000d8 =3D 0;


> >  memset((void*)0x200000dc, 0, 16);
> >  *(uint32_t*)0x200000ec =3D 0;
> >  *(uint32_t*)0x200000f0 =3D -1;
> >  *(uint32_t*)0x200000f4 =3D 0;
> >  *(uint32_t*)0x200000f8 =3D 0;
> >  *(uint32_t*)0x200000fc =3D 0;
> >  *(uint64_t*)0x20000100 =3D 0;
> >  res =3D syscall(__NR_bpf, /*cmd=3D*/0ul, /*arg=3D*/0x200000c0ul, /*s=
ize=3D*/0x48ul);

mapfd =3D map_create( bpf_attr { SOCKHASH, 1 entry, 0 flags, ...} )

> >  if (res !=3D -1) r[0] =3D res;
> >  *(uint32_t*)0x200003c0 =3D r[0];
> >  *(uint64_t*)0x200003c8 =3D 0x20000040;
> >  *(uint64_t*)0x200003d0 =3D 0x20000000;
> >  *(uint64_t*)0x200003d8 =3D 0;
> >  syscall(__NR_bpf, /*cmd=3D*/2ul, /*arg=3D*/0x200003c0ul, /*size=3D*/=
0x20ul);

map_delete(mapfd, key=3D0x20000040, value=3D0x20000000, flags =3D 0)

> >  *(uint32_t*)0x200003c0 =3D r[0];
> >  *(uint64_t*)0x200003c8 =3D 0x20000040;
> >  *(uint64_t*)0x200003d0 =3D 0x20000000;
> >  *(uint64_t*)0x200003d8 =3D 0;
> >  syscall(__NR_bpf, /*cmd=3D*/2ul, /*arg=3D*/0x200003c0ul, /*size=3D*/=
0x20ul);

map_delete(mapfd, key=3D0x20000040, value=3D0x20000000, flags =3D 0)

so same as repro.txt below makes sense. But, if the sockets are
never added to the sockhash then we never touched the proto from
BPF side. And both of these deletes should return errors.

> > }
> > int main(void) {
> >  syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*pr=
ot=3D*/0ul,
> >          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
> >  syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul, /=
*prot=3D*/7ul,
> >          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
> >  syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*pr=
ot=3D*/0ul,
> >          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
> >  setup_leak();
> >  loop();
> >  return 0;
> > }
> > =

> > =

> > =

> > =3D* repro.txt =3D*
> > socketpair(0x1, 0x1, 0x0, &(0x7f0000000000))
> > r0 =3D bpf$MAP_CREATE(0x0, &(0x7f00000000c0)=3D@base=3D{0x12, 0x2, 0x=
4, 0x1}, 0x48)
> > bpf$MAP_DELETE_ELEM(0x2, &(0x7f00000003c0)=3D{r0, &(0x7f0000000040),
> > 0x20000000}, 0x20)
> > bpf$MAP_DELETE_ELEM(0x2, &(0x7f00000003c0)=3D{r0, &(0x7f0000000040),
> > 0x20000000}, 0x20)

So not making sense to me how we got to blaming the proto delete
logic here. It doesn't look like we ever added the psock and
configured the proto?

Did a bisect really blame the mentioned patch? I can likely try here
as well.

Thanks,
John=

