Return-Path: <bpf+bounces-13409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0217D9209
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 10:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9307D282359
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9CFBA22;
	Fri, 27 Oct 2023 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jODopRw7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60370154A8
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 08:40:15 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8815A171E
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 01:40:10 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6cd33d51852so1157660a34.2
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396009; x=1699000809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8tqsRTjEKVKOooTOpYZ4xZ6ckxmXqyelNwJXHUUxsI=;
        b=jODopRw7wDwbVqXX7FZYBluIlv5hPFNzdARRBIKjs60u1kJsqkVqLJcS4XePtZy5Ss
         kpyyI77r9frw+TFd+8NoZonvkVhZreb5E4YrMhfvuttS/EpJIKL/i8xUpm1jjsUvqLJv
         LAcMiaOlqK425zwzlUXZE6IsqbUiwX/vavzi5bndR1lJUn15ByzCJcYgFPyybwiD6IxT
         DAcSyRH8eav4DMAX7jcRFsfGPnhND7yYoNRlfD5oD+IXM5YfPNqii2/FS9vxUrP6Eyxo
         kz4qllhvrzCSR9nhxdn6OhZcZMS3v5+3N46YPtQ49sXsoahLkZ3m/wwK+14W185c67OY
         zfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396009; x=1699000809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8tqsRTjEKVKOooTOpYZ4xZ6ckxmXqyelNwJXHUUxsI=;
        b=o5XEja6o1q/3Gg7hQWnjL4CvgGf59oaHbB0TTZhkBYulPcwanzwMbyEMNyIt9h0/s6
         8MFzkFqYRKDRbqBumJ5+rWIm5oYksIRdNZy6ih883LqxUFhows+u4F5aFNQYzwCEt+q/
         ctHBX4j0AQ+/MCriHkXEgd2qNfRZztBY/NRojakQawwkTqWIHuRksv/25UIKfp/GeT2L
         7RsElED9xvkeSh8oXpmiRsaFVD5lsTAY33Fj7BDDf9vzRzdrezTvFzX2GPA3XDGJzxK9
         ABy00FNWVVWbGPOgbFBO6H4FhRKkl9/vLWCjjTcxjpHgU0yZGsAHpr1VjC/3vtclPiGy
         +pgw==
X-Gm-Message-State: AOJu0YzJfbYNhj2746sI+Dn5Lc2tvZEAKSZuQK/HzvVVtazrJgBbP0Aw
	x8mvAJXIk/TBsZb31rKYYayB+oG6b4px45+dMVo=
X-Google-Smtp-Source: AGHT+IEv+Qf/0zwTKZf2U+EYIu89C8g3ECPyYUFYTefQTc1tTPHpgRq63E+o1NbdBWvpvZ9lTUCJr9L6wJCw6xOviUI=
X-Received: by 2002:a05:6870:1157:b0:1d5:a303:5f39 with SMTP id
 23-20020a056870115700b001d5a3035f39mr1829108oag.49.1698396009332; Fri, 27 Oct
 2023 01:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026184337.563801-1-hengqi.chen@gmail.com>
 <20231026184337.563801-9-hengqi.chen@gmail.com> <CAAhV-H57Xxq86of8cfcGtq5hVuZ2Z5hCjZSGQZ+kHShXS83xVw@mail.gmail.com>
In-Reply-To: <CAAhV-H57Xxq86of8cfcGtq5hVuZ2Z5hCjZSGQZ+kHShXS83xVw@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 27 Oct 2023 16:39:58 +0800
Message-ID: <CAEyhmHRLTSZZzSTyUq-DUrhOnQ6DCwZSKj498F-xRrxoO1U1LQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: Enable cpu v4 tests for LoongArch
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kernel@xen0n.name, 
	yangtiezhu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 3:05=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Hengqi,
>
> On Fri, Oct 27, 2023 at 2:01=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.co=
m> wrote:
> >
> > Enable cpu v4 tests for LoongArch. Currently, we don't
> > have BPF trampoline in LoongArch JIT, so the fentry
> > test `test_ptr_struct_arg` still failed, will followup.
> > Test result attached below:
> >
> >   # ./test_progs -t verifier_sdiv,verifier_movsx,verifier_ldsx,verifier=
_gotol,verifier_bswap
> >   #316/1   verifier_bswap/BSWAP, 16:OK
> >   #316/2   verifier_bswap/BSWAP, 16 @unpriv:OK
> >   #316/3   verifier_bswap/BSWAP, 32:OK
> >   #316/4   verifier_bswap/BSWAP, 32 @unpriv:OK
> >   #316/5   verifier_bswap/BSWAP, 64:OK
> >   #316/6   verifier_bswap/BSWAP, 64 @unpriv:OK
> >   #316     verifier_bswap:OK
> >   #330/1   verifier_gotol/gotol, small_imm:OK
> >   #330/2   verifier_gotol/gotol, small_imm @unpriv:OK
> >   #330     verifier_gotol:OK
> >   #338/1   verifier_ldsx/LDSX, S8:OK
> >   #338/2   verifier_ldsx/LDSX, S8 @unpriv:OK
> >   #338/3   verifier_ldsx/LDSX, S16:OK
> >   #338/4   verifier_ldsx/LDSX, S16 @unpriv:OK
> >   #338/5   verifier_ldsx/LDSX, S32:OK
> >   #338/6   verifier_ldsx/LDSX, S32 @unpriv:OK
> >   #338/7   verifier_ldsx/LDSX, S8 range checking, privileged:OK
> >   #338/8   verifier_ldsx/LDSX, S16 range checking:OK
> >   #338/9   verifier_ldsx/LDSX, S16 range checking @unpriv:OK
> >   #338/10  verifier_ldsx/LDSX, S32 range checking:OK
> >   #338/11  verifier_ldsx/LDSX, S32 range checking @unpriv:OK
> >   #338     verifier_ldsx:OK
> >   #349/1   verifier_movsx/MOV32SX, S8:OK
> >   #349/2   verifier_movsx/MOV32SX, S8 @unpriv:OK
> >   #349/3   verifier_movsx/MOV32SX, S16:OK
> >   #349/4   verifier_movsx/MOV32SX, S16 @unpriv:OK
> >   #349/5   verifier_movsx/MOV64SX, S8:OK
> >   #349/6   verifier_movsx/MOV64SX, S8 @unpriv:OK
> >   #349/7   verifier_movsx/MOV64SX, S16:OK
> >   #349/8   verifier_movsx/MOV64SX, S16 @unpriv:OK
> >   #349/9   verifier_movsx/MOV64SX, S32:OK
> >   #349/10  verifier_movsx/MOV64SX, S32 @unpriv:OK
> >   #349/11  verifier_movsx/MOV32SX, S8, range_check:OK
> >   #349/12  verifier_movsx/MOV32SX, S8, range_check @unpriv:OK
> >   #349/13  verifier_movsx/MOV32SX, S16, range_check:OK
> >   #349/14  verifier_movsx/MOV32SX, S16, range_check @unpriv:OK
> >   #349/15  verifier_movsx/MOV32SX, S16, range_check 2:OK
> >   #349/16  verifier_movsx/MOV32SX, S16, range_check 2 @unpriv:OK
> >   #349/17  verifier_movsx/MOV64SX, S8, range_check:OK
> >   #349/18  verifier_movsx/MOV64SX, S8, range_check @unpriv:OK
> >   #349/19  verifier_movsx/MOV64SX, S16, range_check:OK
> >   #349/20  verifier_movsx/MOV64SX, S16, range_check @unpriv:OK
> >   #349/21  verifier_movsx/MOV64SX, S32, range_check:OK
> >   #349/22  verifier_movsx/MOV64SX, S32, range_check @unpriv:OK
> >   #349/23  verifier_movsx/MOV64SX, S16, R10 Sign Extension:OK
> >   #349/24  verifier_movsx/MOV64SX, S16, R10 Sign Extension @unpriv:OK
> >   #349     verifier_movsx:OK
> >   #361/1   verifier_sdiv/SDIV32, non-zero imm divisor, check 1:OK
> >   #361/2   verifier_sdiv/SDIV32, non-zero imm divisor, check 1 @unpriv:=
OK
> >   #361/3   verifier_sdiv/SDIV32, non-zero imm divisor, check 2:OK
> >   #361/4   verifier_sdiv/SDIV32, non-zero imm divisor, check 2 @unpriv:=
OK
> >   #361/5   verifier_sdiv/SDIV32, non-zero imm divisor, check 3:OK
> >   #361/6   verifier_sdiv/SDIV32, non-zero imm divisor, check 3 @unpriv:=
OK
> >   #361/7   verifier_sdiv/SDIV32, non-zero imm divisor, check 4:OK
> >   #361/8   verifier_sdiv/SDIV32, non-zero imm divisor, check 4 @unpriv:=
OK
> >   #361/9   verifier_sdiv/SDIV32, non-zero imm divisor, check 5:OK
> >   #361/10  verifier_sdiv/SDIV32, non-zero imm divisor, check 5 @unpriv:=
OK
> >   #361/11  verifier_sdiv/SDIV32, non-zero imm divisor, check 6:OK
> >   #361/12  verifier_sdiv/SDIV32, non-zero imm divisor, check 6 @unpriv:=
OK
> >   #361/13  verifier_sdiv/SDIV32, non-zero imm divisor, check 7:OK
> >   #361/14  verifier_sdiv/SDIV32, non-zero imm divisor, check 7 @unpriv:=
OK
> >   #361/15  verifier_sdiv/SDIV32, non-zero imm divisor, check 8:OK
> >   #361/16  verifier_sdiv/SDIV32, non-zero imm divisor, check 8 @unpriv:=
OK
> >   #361/17  verifier_sdiv/SDIV32, non-zero reg divisor, check 1:OK
> >   #361/18  verifier_sdiv/SDIV32, non-zero reg divisor, check 1 @unpriv:=
OK
> >   #361/19  verifier_sdiv/SDIV32, non-zero reg divisor, check 2:OK
> >   #361/20  verifier_sdiv/SDIV32, non-zero reg divisor, check 2 @unpriv:=
OK
> >   #361/21  verifier_sdiv/SDIV32, non-zero reg divisor, check 3:OK
> >   #361/22  verifier_sdiv/SDIV32, non-zero reg divisor, check 3 @unpriv:=
OK
> >   #361/23  verifier_sdiv/SDIV32, non-zero reg divisor, check 4:OK
> >   #361/24  verifier_sdiv/SDIV32, non-zero reg divisor, check 4 @unpriv:=
OK
> >   #361/25  verifier_sdiv/SDIV32, non-zero reg divisor, check 5:OK
> >   #361/26  verifier_sdiv/SDIV32, non-zero reg divisor, check 5 @unpriv:=
OK
> >   #361/27  verifier_sdiv/SDIV32, non-zero reg divisor, check 6:OK
> >   #361/28  verifier_sdiv/SDIV32, non-zero reg divisor, check 6 @unpriv:=
OK
> >   #361/29  verifier_sdiv/SDIV32, non-zero reg divisor, check 7:OK
> >   #361/30  verifier_sdiv/SDIV32, non-zero reg divisor, check 7 @unpriv:=
OK
> >   #361/31  verifier_sdiv/SDIV32, non-zero reg divisor, check 8:OK
> >   #361/32  verifier_sdiv/SDIV32, non-zero reg divisor, check 8 @unpriv:=
OK
> >   #361/33  verifier_sdiv/SDIV64, non-zero imm divisor, check 1:OK
> >   #361/34  verifier_sdiv/SDIV64, non-zero imm divisor, check 1 @unpriv:=
OK
> >   #361/35  verifier_sdiv/SDIV64, non-zero imm divisor, check 2:OK
> >   #361/36  verifier_sdiv/SDIV64, non-zero imm divisor, check 2 @unpriv:=
OK
> >   #361/37  verifier_sdiv/SDIV64, non-zero imm divisor, check 3:OK
> >   #361/38  verifier_sdiv/SDIV64, non-zero imm divisor, check 3 @unpriv:=
OK
> >   #361/39  verifier_sdiv/SDIV64, non-zero imm divisor, check 4:OK
> >   #361/40  verifier_sdiv/SDIV64, non-zero imm divisor, check 4 @unpriv:=
OK
> >   #361/41  verifier_sdiv/SDIV64, non-zero imm divisor, check 5:OK
> >   #361/42  verifier_sdiv/SDIV64, non-zero imm divisor, check 5 @unpriv:=
OK
> >   #361/43  verifier_sdiv/SDIV64, non-zero imm divisor, check 6:OK
> >   #361/44  verifier_sdiv/SDIV64, non-zero imm divisor, check 6 @unpriv:=
OK
> >   #361/45  verifier_sdiv/SDIV64, non-zero reg divisor, check 1:OK
> >   #361/46  verifier_sdiv/SDIV64, non-zero reg divisor, check 1 @unpriv:=
OK
> >   #361/47  verifier_sdiv/SDIV64, non-zero reg divisor, check 2:OK
> >   #361/48  verifier_sdiv/SDIV64, non-zero reg divisor, check 2 @unpriv:=
OK
> >   #361/49  verifier_sdiv/SDIV64, non-zero reg divisor, check 3:OK
> >   #361/50  verifier_sdiv/SDIV64, non-zero reg divisor, check 3 @unpriv:=
OK
> >   #361/51  verifier_sdiv/SDIV64, non-zero reg divisor, check 4:OK
> >   #361/52  verifier_sdiv/SDIV64, non-zero reg divisor, check 4 @unpriv:=
OK
> >   #361/53  verifier_sdiv/SDIV64, non-zero reg divisor, check 5:OK
> >   #361/54  verifier_sdiv/SDIV64, non-zero reg divisor, check 5 @unpriv:=
OK
> >   #361/55  verifier_sdiv/SDIV64, non-zero reg divisor, check 6:OK
> >   #361/56  verifier_sdiv/SDIV64, non-zero reg divisor, check 6 @unpriv:=
OK
> >   #361/57  verifier_sdiv/SMOD32, non-zero imm divisor, check 1:OK
> >   #361/58  verifier_sdiv/SMOD32, non-zero imm divisor, check 1 @unpriv:=
OK
> >   #361/59  verifier_sdiv/SMOD32, non-zero imm divisor, check 2:OK
> >   #361/60  verifier_sdiv/SMOD32, non-zero imm divisor, check 2 @unpriv:=
OK
> >   #361/61  verifier_sdiv/SMOD32, non-zero imm divisor, check 3:OK
> >   #361/62  verifier_sdiv/SMOD32, non-zero imm divisor, check 3 @unpriv:=
OK
> >   #361/63  verifier_sdiv/SMOD32, non-zero imm divisor, check 4:OK
> >   #361/64  verifier_sdiv/SMOD32, non-zero imm divisor, check 4 @unpriv:=
OK
> >   #361/65  verifier_sdiv/SMOD32, non-zero imm divisor, check 5:OK
> >   #361/66  verifier_sdiv/SMOD32, non-zero imm divisor, check 5 @unpriv:=
OK
> >   #361/67  verifier_sdiv/SMOD32, non-zero imm divisor, check 6:OK
> >   #361/68  verifier_sdiv/SMOD32, non-zero imm divisor, check 6 @unpriv:=
OK
> >   #361/69  verifier_sdiv/SMOD32, non-zero reg divisor, check 1:OK
> >   #361/70  verifier_sdiv/SMOD32, non-zero reg divisor, check 1 @unpriv:=
OK
> >   #361/71  verifier_sdiv/SMOD32, non-zero reg divisor, check 2:OK
> >   #361/72  verifier_sdiv/SMOD32, non-zero reg divisor, check 2 @unpriv:=
OK
> >   #361/73  verifier_sdiv/SMOD32, non-zero reg divisor, check 3:OK
> >   #361/74  verifier_sdiv/SMOD32, non-zero reg divisor, check 3 @unpriv:=
OK
> >   #361/75  verifier_sdiv/SMOD32, non-zero reg divisor, check 4:OK
> >   #361/76  verifier_sdiv/SMOD32, non-zero reg divisor, check 4 @unpriv:=
OK
> >   #361/77  verifier_sdiv/SMOD32, non-zero reg divisor, check 5:OK
> >   #361/78  verifier_sdiv/SMOD32, non-zero reg divisor, check 5 @unpriv:=
OK
> >   #361/79  verifier_sdiv/SMOD32, non-zero reg divisor, check 6:OK
> >   #361/80  verifier_sdiv/SMOD32, non-zero reg divisor, check 6 @unpriv:=
OK
> >   #361/81  verifier_sdiv/SMOD64, non-zero imm divisor, check 1:OK
> >   #361/82  verifier_sdiv/SMOD64, non-zero imm divisor, check 1 @unpriv:=
OK
> >   #361/83  verifier_sdiv/SMOD64, non-zero imm divisor, check 2:OK
> >   #361/84  verifier_sdiv/SMOD64, non-zero imm divisor, check 2 @unpriv:=
OK
> >   #361/85  verifier_sdiv/SMOD64, non-zero imm divisor, check 3:OK
> >   #361/86  verifier_sdiv/SMOD64, non-zero imm divisor, check 3 @unpriv:=
OK
> >   #361/87  verifier_sdiv/SMOD64, non-zero imm divisor, check 4:OK
> >   #361/88  verifier_sdiv/SMOD64, non-zero imm divisor, check 4 @unpriv:=
OK
> >   #361/89  verifier_sdiv/SMOD64, non-zero imm divisor, check 5:OK
> >   #361/90  verifier_sdiv/SMOD64, non-zero imm divisor, check 5 @unpriv:=
OK
> >   #361/91  verifier_sdiv/SMOD64, non-zero imm divisor, check 6:OK
> >   #361/92  verifier_sdiv/SMOD64, non-zero imm divisor, check 6 @unpriv:=
OK
> >   #361/93  verifier_sdiv/SMOD64, non-zero imm divisor, check 7:OK
> >   #361/94  verifier_sdiv/SMOD64, non-zero imm divisor, check 7 @unpriv:=
OK
> >   #361/95  verifier_sdiv/SMOD64, non-zero imm divisor, check 8:OK
> >   #361/96  verifier_sdiv/SMOD64, non-zero imm divisor, check 8 @unpriv:=
OK
> >   #361/97  verifier_sdiv/SMOD64, non-zero reg divisor, check 1:OK
> >   #361/98  verifier_sdiv/SMOD64, non-zero reg divisor, check 1 @unpriv:=
OK
> >   #361/99  verifier_sdiv/SMOD64, non-zero reg divisor, check 2:OK
> >   #361/100 verifier_sdiv/SMOD64, non-zero reg divisor, check 2 @unpriv:=
OK
> >   #361/101 verifier_sdiv/SMOD64, non-zero reg divisor, check 3:OK
> >   #361/102 verifier_sdiv/SMOD64, non-zero reg divisor, check 3 @unpriv:=
OK
> >   #361/103 verifier_sdiv/SMOD64, non-zero reg divisor, check 4:OK
> >   #361/104 verifier_sdiv/SMOD64, non-zero reg divisor, check 4 @unpriv:=
OK
> >   #361/105 verifier_sdiv/SMOD64, non-zero reg divisor, check 5:OK
> >   #361/106 verifier_sdiv/SMOD64, non-zero reg divisor, check 5 @unpriv:=
OK
> >   #361/107 verifier_sdiv/SMOD64, non-zero reg divisor, check 6:OK
> >   #361/108 verifier_sdiv/SMOD64, non-zero reg divisor, check 6 @unpriv:=
OK
> >   #361/109 verifier_sdiv/SMOD64, non-zero reg divisor, check 7:OK
> >   #361/110 verifier_sdiv/SMOD64, non-zero reg divisor, check 7 @unpriv:=
OK
> >   #361/111 verifier_sdiv/SMOD64, non-zero reg divisor, check 8:OK
> >   #361/112 verifier_sdiv/SMOD64, non-zero reg divisor, check 8 @unpriv:=
OK
> >   #361/113 verifier_sdiv/SDIV32, zero divisor:OK
> >   #361/114 verifier_sdiv/SDIV32, zero divisor @unpriv:OK
> >   #361/115 verifier_sdiv/SDIV64, zero divisor:OK
> >   #361/116 verifier_sdiv/SDIV64, zero divisor @unpriv:OK
> >   #361/117 verifier_sdiv/SMOD32, zero divisor:OK
> >   #361/118 verifier_sdiv/SMOD32, zero divisor @unpriv:OK
> >   #361/119 verifier_sdiv/SMOD64, zero divisor:OK
> >   #361/120 verifier_sdiv/SMOD64, zero divisor @unpriv:OK
> >   #361     verifier_sdiv:OK
> >   Summary: 5/163 PASSED, 0 SKIPPED, 0 FAILED
> >
> >   # ./test_progs -t ldsx_insn
> >   test_map_val_and_probed_memory:PASS:test_ldsx_insn__open 0 nsec
> >   test_map_val_and_probed_memory:PASS:test_ldsx_insn__load 0 nsec
> >   libbpf: prog 'test_ptr_struct_arg': failed to attach: ERROR: strerror=
_r(-524)=3D22
> >   libbpf: prog 'test_ptr_struct_arg': failed to auto-attach: -524
> >   test_map_val_and_probed_memory:FAIL:test_ldsx_insn__attach unexpected=
 error: -524 (errno 524)
> >   #116/1   ldsx_insn/map_val and probed_memory:FAIL
> >   #116/2   ldsx_insn/ctx_member_sign_ext:OK
> >   #116/3   ldsx_insn/ctx_member_narrow_sign_ext:OK
> >   #116     ldsx_insn:FAIL
> Thank you for your effort, but why is there a failure? Can it be solved?
>

As I said in the above commit message,  the feature is not implemented yet.
I will follow up but not in this series.

> Huacai
>
> >
> >   All error logs:
> >   test_map_val_and_probed_memory:PASS:test_ldsx_insn__open 0 nsec
> >   test_map_val_and_probed_memory:PASS:test_ldsx_insn__load 0 nsec
> >   libbpf: prog 'test_ptr_struct_arg': failed to attach: ERROR: strerror=
_r(-524)=3D22
> >   libbpf: prog 'test_ptr_struct_arg': failed to auto-attach: -524
> >   test_map_val_and_probed_memory:FAIL:test_ldsx_insn__attach unexpected=
 error: -524 (errno 524)
> >   #116/1   ldsx_insn/map_val and probed_memory:FAIL
> >   #116     ldsx_insn:FAIL
> >   Summary: 0/2 PASSED, 0 SKIPPED, 1 FAILED
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/progs/test_ldsx_insn.c | 3 ++-
> >  tools/testing/selftests/bpf/progs/verifier_bswap.c | 3 ++-
> >  tools/testing/selftests/bpf/progs/verifier_gotol.c | 3 ++-
> >  tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 3 ++-
> >  tools/testing/selftests/bpf/progs/verifier_movsx.c | 3 ++-
> >  tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 3 ++-
> >  6 files changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools=
/testing/selftests/bpf/progs/test_ldsx_insn.c
> > index 3ddcb3777912..2a2a942737d7 100644
> > --- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
> > +++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
> > @@ -7,7 +7,8 @@
> >
> >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> >       (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) ||      =
 \
> > -     defined(__TARGET_ARCH_s390)) && __clang_major__ >=3D 18
> > +     defined(__TARGET_ARCH_s390) || defined(__TARGET_ARCH_loongarch)) =
&& \
> > +     __clang_major__ >=3D 18
> >  const volatile int skip =3D 0;
> >  #else
> >  const volatile int skip =3D 1;
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools=
/testing/selftests/bpf/progs/verifier_bswap.c
> > index 107525fb4a6a..e61755656e8d 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
> > @@ -6,7 +6,8 @@
> >
> >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> > -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && =
\
> > +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> > +       defined(__TARGET_ARCH_loongarch)) && \
> >         __clang_major__ >=3D 18
> >
> >  SEC("socket")
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools=
/testing/selftests/bpf/progs/verifier_gotol.c
> > index 9f202eda952f..d1edbcff9a18 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
> > @@ -6,7 +6,8 @@
> >
> >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> > -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && =
\
> > +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> > +       defined(__TARGET_ARCH_loongarch)) && \
> >         __clang_major__ >=3D 18
> >
> >  SEC("socket")
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/=
testing/selftests/bpf/progs/verifier_ldsx.c
> > index 375525329637..d4427d8e1217 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> > @@ -6,7 +6,8 @@
> >
> >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> > -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && =
\
> > +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> > +       defined(__TARGET_ARCH_loongarch)) && \
> >         __clang_major__ >=3D 18
> >
> >  SEC("socket")
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools=
/testing/selftests/bpf/progs/verifier_movsx.c
> > index b2a04d1179d0..cbb9d6714f53 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
> > @@ -6,7 +6,8 @@
> >
> >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> > -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && =
\
> > +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> > +       defined(__TARGET_ARCH_loongarch)) && \
> >         __clang_major__ >=3D 18
> >
> >  SEC("socket")
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/=
testing/selftests/bpf/progs/verifier_sdiv.c
> > index 8fc5174808b2..2a2271cf0294 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> > @@ -6,7 +6,8 @@
> >
> >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> > -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && =
\
> > +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> > +       defined(__TARGET_ARCH_loongarch)) && \
> >         __clang_major__ >=3D 18
> >
> >  SEC("socket")
> > --
> > 2.34.1
> >
>

