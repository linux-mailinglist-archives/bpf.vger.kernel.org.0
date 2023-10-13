Return-Path: <bpf+bounces-12139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9487C868A
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 15:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C292282B98
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F8A15E85;
	Fri, 13 Oct 2023 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DF154B9
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 13:15:34 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C5CE
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 06:15:30 -0700 (PDT)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39DDFNG1087047;
	Fri, 13 Oct 2023 22:15:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Fri, 13 Oct 2023 22:15:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39DDFMVd087042
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Oct 2023 22:15:23 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <261bfeec-8230-490a-b583-d52223e2d707@I-love.SAKURA.ne.jp>
Date: Fri, 13 Oct 2023 22:15:22 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is tools/testing/selftests/bpf/ maintained?
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>
References: <adfab6e8-b1de-4efc-a9ef-84e219c91833@I-love.SAKURA.ne.jp>
 <26b213505abeefba2728d238927ddd1907967786.camel@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <26b213505abeefba2728d238927ddd1907967786.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you for showing complete command line.

On 2023/10/13 1:34, Eduard Zingerman wrote:
> # Note: kernel build is mandatory, as vmlinux.h is constructed from DWA=
RF in ./vmlinux

is what I was missing. Makefile rules should explicitly describe dependen=
cy on vmlinux ,
or at least emit message to teach users about the need to build vmlinux ?=


But I still get error. I'm using Ubuntu 22.04.3 LTS.

----------------------------------------
root@ubuntu:/usr/src/linux# make -C tools/testing/selftests/bpf/
make: Entering directory '/usr/src/linux/tools/testing/selftests/bpf'
  CLNG-BPF [test_maps] verifier_and.bpf.o
progs/verifier_and.c:58:16: error: invalid operand for instruction
        asm volatile ("                                 \
                      ^
<inline asm>:1:184: note: instantiated into assembly here
                                                        r1 =3D 0;        =
                                         *(u64*)(r10 - 8) =3D r1;        =
                          r2 =3D r10;                                    =
           r2 +=3D -8;                                               r1 =3D=
 map_hash_48b ll;                           call 1;                      =
   if r0 =3D=3D 0 goto l0_1;                                   r1 =3D *(u=
32*)(r0 + 0);                                   r9 =3D 1;                =
                                 w1 %=3D 2;                              =
                  w1 +=3D 1;                                             =
   w9 &=3D w1;                                               w9 +=3D 1;  =
                                              w9 >>=3D 1;                =
                               w3 =3D 1;                                 =
                w3 -=3D w9;                                              =
 w3 *=3D 0x10000000;                                       r0 +=3D r3;   =
                                            *(u32*)(r0 + 0) =3D r3;      =
                     l0_1:   r0 =3D r0;                                  =
              exit;                                        =20
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                    ^
1 error generated.
make: *** [Makefile:598: /usr/src/linux/tools/testing/selftests/bpf/verif=
ier_and.bpf.o] Error 1
make: Leaving directory '/usr/src/linux/tools/testing/selftests/bpf'
----------------------------------------


