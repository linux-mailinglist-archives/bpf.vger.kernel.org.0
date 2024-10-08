Return-Path: <bpf+bounces-41224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6850C99447D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A4B1C248F7
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DBE18BC03;
	Tue,  8 Oct 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIV6GXAE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30D7603F;
	Tue,  8 Oct 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380470; cv=none; b=GRuUTQdPQFqLD0gjcrQx23euqyZh2XDi6itoSILQ7UoeZMKcSnif/vxFsCVQxxX5vIMNBpJjqA4l6FjSuVplkmew4KaVJPbnetXPLEcUVZ9fIS8YXhC7EW+SR2glTXf8yY9XPBJStTH1cw0zWxeh/3w7W5j1spQeAM9GLA7JHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380470; c=relaxed/simple;
	bh=wZFJUJvPZ9p6ODhFIXDDj2s/miaSoqbmvUb/EdYuxX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akH9GRQTQ+0JIjeRYvJ5fDMf2s2fJDVG8s1vtmxyrWD2CTAl6wqTT8UIUMmD8eOglLE4mCwTSj+hfoF5qTBLnJehqO29WkTYPRTodqLb7MWcf5NNOlT8o5Rq0acS8ZOvGWccysG247cV+HhOhcWDR3yhc/9NPrZUmj7TdEGhoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIV6GXAE; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e04801bb65so2902750b6e.0;
        Tue, 08 Oct 2024 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728380467; x=1728985267; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VW7gPsy5GJq+TdNNh91j+Je70iU1cq1LYg9nRtBLrq8=;
        b=RIV6GXAEpVhe6K15nIBXxTx6X2hDUrSPMQygKe+eADSPd6HZlU+oRZRbvC0EXxo/Db
         ShKE3+3UVARFv66QQziPZj/tiHkm2gw9rBRx9uM1CrVleRfxRwFDvSxiTnapbN2h5VQt
         kv6rUb6Ol/kB3Yo/42Z6DpuvwFEQC4/egJWB/wgyOWMm0Euw1pFp73ceug8oL93BWJGy
         mQgx32/1RXbkHWHH0RxQiuxdl72zlf7+tkroWQFZLe24PHTppXGDmHNsUdsurfqBnFrp
         oxWluNsRj7KYgIWYtuT2cu6+l4wUwbu1TzuntFVWoCb32zAzJU+PF87v5FOvklrRTlix
         zIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380467; x=1728985267;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VW7gPsy5GJq+TdNNh91j+Je70iU1cq1LYg9nRtBLrq8=;
        b=kBHDBMp4GH/LpRNKD1TUz1P60zc4H/hkfRqMbcy3NesJQS+NScmt3Oc03FY+qnL3t4
         Bhwo+w2kFpnSA5XcEITuqkigQj2S9IoFCXKnaQBqL5SV8JIqo28lbyKMjoNu+Qk+P14I
         xF4VRG1FjySjK0bxJ12SHzBKhQ7POAsyfH3LLZYtU0tGA3jAs7+8lL/CFRW8QiBqaHbR
         FD+SAPS8DQGnote2xo7nqce53lftG0BU3UPyjK+S+rkONesb+aTZ5JItoBSaeQ2vTO+w
         zOnyPwTEPReIzW9vXE00zk7iN9+kNx+Cap7h0FfloCqV+EvRV7/XzLAhLrDaoCF+DuJQ
         UjpA==
X-Forwarded-Encrypted: i=1; AJvYcCUJLNKB2trO2m7SfsGmLpJqIo7oMNTcRqoYJYvs7tw8LF/81b8iic3X6f2r9ga2apY8rCqEeCAbRPUxmq+C@vger.kernel.org, AJvYcCXo20mKhPv8E4Hev/Ubmyh6DW8Uo6LWeGBI/Kh4VPjtHTWKLYYXRPIEHD9N7QoI+XYOn60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfx0Xof2lq1lCn/0V2SFqgeH62y9QfSCJ/UeuVHBg3/+/B4bON
	6E3inPD+aG8cA1mgHY1PkNKCO5F+YlMMMvlmY8f5ZANJ6XfkMfOMa/VRIpha
X-Google-Smtp-Source: AGHT+IGRD34Fd2Kt5MneL8c0v4zBGHlcjhlyHUFV2bk6tQLS9wshySuY5APs4ZCTxmZIXpBCsLbzqg==
X-Received: by 2002:a05:6808:1a14:b0:3e3:98fd:dc42 with SMTP id 5614622812f47-3e3c131ebc9mr9249734b6e.7.1728380467352;
        Tue, 08 Oct 2024 02:41:07 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833cdcsm6435057a12.49.2024.10.08.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:41:06 -0700 (PDT)
Message-ID: <fc6396c21f8a9fa83166fd4ccaee7c2c5069f0b2.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in push_jmp_history
From: Eduard Zingerman <eddyz87@gmail.com>
To: feng.tang@intel.com
Cc: syzbot <syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com>, 
 42.hyeyoo@gmail.com, akpm@linux-foundation.org, andrii@kernel.org,
 ast@kernel.org,  bpf@vger.kernel.org, cl@linux.com, daniel@iogearbox.net,
 haoluo@google.com,  iamjoonsoo.kim@lge.com, john.fastabend@gmail.com,
 jolsa@kernel.org,  kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,  martin.lau@linux.dev, penberg@kernel.org,
 rientjes@google.com,  roman.gushchin@linux.dev, sdf@fomichev.me,
 song@kernel.org,  syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
 yonghong.song@linux.dev
Date: Tue, 08 Oct 2024 02:41:01 -0700
In-Reply-To: <6704f097.050a0220.1e4d62.0087.GAE@google.com>
References: <6704f097.050a0220.1e4d62.0087.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 01:43 -0700, syzbot wrote:
> syzbot has bisected this issue to:
>=20
> commit d0a38fad51cc70ab3dd3c59b54d8079ac19220b9
> Author: Feng Tang <feng.tang@intel.com>
> Date:   Wed Sep 11 06:45:34 2024 +0000
>=20
>     mm/slub: Improve redzone check and zeroing for krealloc()
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11ddbb8058=
0000
> start commit:   c02d24a5af66 Add linux-next specific files for 20241003
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13ddbb8058=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15ddbb8058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D94f9caf16c0af=
42d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7e46cdef14bf496=
a3ab4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10b82707980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16f4c32798000=
0
>=20
> Reported-by: syzbot+7e46cdef14bf496a3ab4@syzkaller.appspotmail.com
> Fixes: d0a38fad51cc ("mm/slub: Improve redzone check and zeroing for krea=
lloc()")
>=20
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

There are two issues demonstrated by this repro:
- one is mm/slub related;
- another one is verification taking forever.

About the mm/slub related. Applying the following patch with
additional logging on top of commit d0a38fad51cc identified by syzbot:

------- 8< ------------------------------------------------------------
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9a7ed527e47e..c1582a6d1d33 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3494,7 +3494,9 @@ static int push_jmp_history(struct bpf_verifier_env *=
env, struct bpf_verifier_st
=20
        cnt++;
        alloc_size =3D kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
+       printk("push_jmp_history: #1 cur->jmp_history=3D%p\n", cur->jmp_his=
tory);
        p =3D krealloc(cur->jmp_history, alloc_size, GFP_USER);
+       printk("push_jmp_history: #2 cur->jmp_history=3D%p\n", p);
        if (!p)
                return -ENOMEM;
        cur->jmp_history =3D p;
diff --git a/mm/slub.c b/mm/slub.c
index e0fb0a26c796..3f5b080ac1f5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4627,7 +4627,7 @@ static inline struct kmem_cache *virt_to_cache(const =
void *obj)
        struct slab *slab;
=20
        slab =3D virt_to_slab(obj);
-       if (WARN_ONCE(!slab, "%s: Object is not a Slab page!\n", __func__))
+       if (WARN_ONCE(!slab, "%s: Object %p is not a Slab page!\n", __func_=
_, obj))
                return NULL;
        return slab->slab_cache;
 }
------------------------------------------------------------ >8 -------

Produces the following log:

 l1: [    2.942120] push_jmp_history: #2 cur->jmp_history=3D00000000a0f6f50=
3
 l2: [    2.944445] push_jmp_history: #1 cur->jmp_history=3D00000000a0f6f50=
3
 l3: [    2.944560] ------------[ cut here ]------------
 l4: [    2.944647] virt_to_cache: Object 00000000a0f6f503 is not a Slab pa=
ge!
 l5: [    2.944765] WARNING: CPU: 0 PID: 145 at mm/slub.c:4630 krealloc_nop=
rof (mm/slub.c:4630 mm/slub.c:4728 mm/slub.c:4813)=20
 l6: [    2.944906] Modules linked in:
 l7: [    2.945134] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.16.3-2.fc40 04/01/2014
 l8: [    2.945285] RIP: 0010:krealloc_noprof (mm/slub.c:4630 mm/slub.c:472=
8 mm/slub.c:4813)=20
               ...
l9:  [    2.952088] BUG: kernel NULL pointer dereference, address: 00000000=
0000001c
l10: [    2.952171] #PF: supervisor read access in kernel mode
l11: [    2.952240] #PF: error_code(0x0000) - not-present page
l12: [    2.952309] PGD 105d51067 P4D 105d51067 PUD 1013d0067 PMD 0=20
l13: [    2.952402] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
l14: [    2.952611] Tainted: [W]=3DWARN
l15: [    2.952664] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.16.3-2.fc40 04/01/2014
l16: [    2.952794] RIP: 0010:krealloc_noprof (mm/slub.c:0 mm/slub.c:4729 m=
m/slub.c:4813)=20

Lines l{1,2,4} show that address 0xa0f6f503 was first allocated by
krealloc and then krealloc failed to recognize it as such.

The warning at l3 is reported by virt_to_cache() called from
__do_krealloc():


   4715 static __always_inline __realloc_size(2) void *
   4716 __do_krealloc(const void *p, size_t new_size, gfp_t flags)
   4717 {
   4718         void *ret;
   4719         size_t ks;
   4720         int orig_size =3D 0;
   4721         struct kmem_cache *s;
   4722=20
   4723         /* Check for double-free. */
   4724         if (likely(!ZERO_OR_NULL_PTR(p))) {
   4725                 if (!kasan_check_byte(p))
   4726                         return NULL;
   4727=20
   4728                 s =3D virt_to_cache(p);
   4729                 orig_size =3D get_orig_size(s, (void *)p);
   4730                 ks =3D s->object_size;

When virt_to_cache() reports the warning it returns NULL.
Hence variable 's' at line 4728 is NULL and this causes null pointer
dereference at line 4730, reported at l9.

Lines 4725-4730 were changed by commit d0a38fad51cc identified by syzbot,
previously 'ks' was identified using other means.

Feng, this issue seem unrelated to BPF verifier, could you please take a lo=
ok?

Best regards,
Eduard


