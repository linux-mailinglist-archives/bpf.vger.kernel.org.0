Return-Path: <bpf+bounces-17304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FFD80B1BB
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 03:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77667B20C62
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 02:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4219D10F6;
	Sat,  9 Dec 2023 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeVn5hCH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A710C4
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:28:42 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-33334480eb4so3208776f8f.0
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 18:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702088920; x=1702693720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu5Fhfl/DIzvR2m5duyNyUoUgk7d4Oam8o1/MHynIyo=;
        b=WeVn5hCHFl2s7igYEMF5GgL4DBx5Xm9YcTa36c/mvfWBhTgjV0xmcdtRrxgIHLPlfW
         fR5REtxhJmUP0KgP8evhzxhv96LdfveM2qxyW44fhcio5WMCSpp5edGaaFabDaG+SOgK
         w6rpWUaPv1HMrzELv0unt1sZRpayFWT8YZX1nSnMK5p8GyfDk210TD9Mu4cUzcS83jVE
         36Ls3lc1rEQlN+juCqIWmopd8WlaLosnI9q4ezLPx5ZypqEn5GlsGXyZ07IuairT9B/H
         b87UitlNEXj5sSD4v3iyoDCIBsl5rAfxypYeQxgAwpHHBMKPoWGdSrkmsn19v5aftYY7
         uQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702088920; x=1702693720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu5Fhfl/DIzvR2m5duyNyUoUgk7d4Oam8o1/MHynIyo=;
        b=rGxnw8K24VCDftBJk/jUllWGqiJGu/zTBvork4zoWYojgVKmImGHQ8flj+DhHfQZhh
         s/ABZ16CyHJpO9G7ly/Kb2xhd94rq3dsAh6pMaqd5zcWeGrqPtEJ0ltt5OvA0br9BuDU
         6bMWmZpFcKaTH9E7u3Vxp/ml1mjIwvAJNv4Miha4MpD7WfKbhsp29TYf7X5DP6A3ulVZ
         YYvhOmmrX1YKxmo1MK1Gqf60ojBWAakdWGDwwtbeYcJfddOZ+aZ2fmfO33TrGzYS4xVW
         ycrfL1NgG/BOiuylGSy5StTgSOhSDOJUKmj26u8w6C6SNyMaGacVjhE7RQGTf75KFB5f
         r5uA==
X-Gm-Message-State: AOJu0Yyr2vUlV8tL+x/bFVkv+9Cb7amb/jfTgqzoq+PbHzGSOcmAY9aH
	yDxp4YB+Vu4XtZP5g0I5invLdtqWLoMb+DSZa2rYEWhe
X-Google-Smtp-Source: AGHT+IGttrUObE9GAjmYarR86L7F/KBBJh5Bigz48IlC2JlK2MroK/Vker3kUbu6EiHp6XEdDzDqT0Mt75TIkOrk00A=
X-Received: by 2002:adf:e0c3:0:b0:333:2fd2:2f0c with SMTP id
 m3-20020adfe0c3000000b003332fd22f0cmr358966wri.133.1702088920333; Fri, 08 Dec
 2023 18:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209010958.66758-1-andrii@kernel.org> <bff7a93dc02d42f71882d023179a1b481f5c884b.camel@gmail.com>
 <CAEf4BzaE6TiThSaq7+=KERW=zP4G6vJz1nQ6-EWQrpnF4Np=-w@mail.gmail.com>
In-Reply-To: <CAEf4BzaE6TiThSaq7+=KERW=zP4G6vJz1nQ6-EWQrpnF4Np=-w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Dec 2023 18:28:28 -0800
Message-ID: <CAADnVQJUNu3MyfqPk2-V8_x6Qqf-UbfnSK2RSQJbfB318WHq-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: handle fake register spill to stack
 with BPF_ST_MEM instruction
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> See above, MISC/ZERO is fine as is due to check_stack_read_fixed_off()
> not setting STACK_ACCESS bit, but I can also send a version that
> unconditionally sets INSNS_F_STACK_ACCESS in
> check_stack_write_fixed_off().

but it will significantly increase jmp_history and make
backtracking slower?

