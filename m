Return-Path: <bpf+bounces-40445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6C988C7E
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 00:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F9F28187C
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6E918C031;
	Fri, 27 Sep 2024 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+Gkub+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2A1849D9
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727476327; cv=none; b=rmp0brzJBHsHSYIZwE+YUzNhH4xJVq2zJsxRwkyH0JDCUtNRAbesWAFqJE+ahSHgpTyRI7QAoEaIvsLoVpjdr537KZuIL1O8XnRp1jm26GlcEcGiDgmKsCKEj1ZrYtbtsC/xUoPxDbZtncwahyxDSCCD/9W2uR2lhNN1yU7eeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727476327; c=relaxed/simple;
	bh=u6/UW3wtFTIrDFrN8ELGc5+xxPV2j/H/MghPiSAYiTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R03eVYmoKHVk59gL1Jh5mDMUzLu+uXBzOzzVR6WN3c1Ow83XhhsLlgLE904NAQLMgqtLwaBO1g/X4+Diy1nq5LFETUqA1dDQNxuKMQgvfPbkZJzYhHSZQeYXfuCyZo5aWK+cwln5KiwrZLpk+gkF7Du7bUyEuwKwo91x0VLItnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+Gkub+w; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso2420688a91.0
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727476325; x=1728081125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYpLEqgPwwIm6nPN9j1jBr05I2Zo6+sVjP3LFKShRfM=;
        b=R+Gkub+w6Y/EiLQu7AT63rMEfYSC0H1yikU9GIf561olb1+pA7SOzWuI4Y5AG38cxC
         TRSXeOnZExDX4b+983phaTD3xmj1B6n/Ph9v5zQBSBW4/vU4TarUMyAqZGvh0hFTFaeH
         5QVf/2MfPBI7D/4IHEdIGkPZnG5EbN117hEvWBe3xXTPqsxLnIVGmNzGgeHhZ/ojIFUH
         TrcEh/eNdjLIoRqVQidtgNn7PBxN+uXhvVMCaKf1MAVSPjMT2ghS11LQjnjK1ZkxdIpO
         TsuX6EvHL6zvptIGs3GNei0AKYqdIk72z9IKIvA0thbmUtPc+zB9xqjdF2hQ5sHSqZgN
         EqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727476325; x=1728081125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYpLEqgPwwIm6nPN9j1jBr05I2Zo6+sVjP3LFKShRfM=;
        b=JemKWD4sChRWgxNFTCeI7iZ9Zet5RkKQbxsxsycgOS3MLZSV8g3wPgS84lfjh8CMFa
         igfOVx714dRDt3RPA6ztIM3trMF1cpwPqu6FeD+SReaCiMazUtmh+5SqUHM/hbgGBkrU
         wNCF2zL/dQaC9lrpGOQ+TDQtkePVDrib/08YHd75NIPHgw2El7HkaF0996w32Q1U4eXF
         FKcSS6qLDwhhFoQU5M7u1vNe75MUEHT34Qcwx02ILndpYlJGndL7UhLlhpJFhiBupCAJ
         zXLwqfp+DeHauPFVFhYDBYUXb5wFe4/ffwHQ2JaLKclzJwZuGv9atlB01guI4JRl7tQD
         Zo/Q==
X-Gm-Message-State: AOJu0YzzzORmtZp108GJQg6TL1UK4arZXZ10MGA8c+yglrNerXWd7WPM
	PHd6FaC5UzdRRI+zF3t7AmB9/4nQonLeF4IzbQhGDK6evawZO5c/65wmlnigUlY9bvh1uwtX8Po
	nUFwTn77UDIGFK9x37YRPWwwNnEQ=
X-Google-Smtp-Source: AGHT+IGQxTc9EEnZvDawhaFlOqyujoG5KbQ4tZczJm0hK5u92Ay0Nqto2A6M+4HOanYiWpGZ+tJ/FqpmOV+QNJIKLkg=
X-Received: by 2002:a17:90a:f016:b0:2c9:9f50:3f9d with SMTP id
 98e67ed59e1d1-2e0b89a239bmr5608722a91.5.1727476324869; Fri, 27 Sep 2024
 15:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916091712.2929279-1-eddyz87@gmail.com> <20240916091712.2929279-2-eddyz87@gmail.com>
In-Reply-To: <20240916091712.2929279-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 15:31:52 -0700
Message-ID: <CAEf4BzZBoBgdSa-AU-0kJUXsv0yHt54BUOeBb4bBsNiSx-u7tQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: allow specifying bpf_fastcall
 attribute for BPF helpers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, arnaldo.melo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 2:18=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Allow a new optional 'Attributes' section to be specified for helper
> functions description, e.g.:
>
>  * u32 bpf_get_smp_processor_id(void)
>  *              ...
>  *      Return
>  *              ...
>  *      Attributes
>  *              __bpf_fastcall
>  *
>
> Generated header for the example above:
>
>   #ifndef __bpf_fastcall
>   #if __has_attribute(__bpf_fastcall)
>   #define __bpf_fastcall __attribute__((bpf_fastcall))
>   #else
>   #define __bpf_fastcall
>   #endif
>   #endif
>   ...
>   __bpf_fastcall

I found it a bit annoying that bpf_helper_defs.h uses

__bpf_fastcall
static __u32 ....

format, while in vmlinux we have single-line (and yeah, note that I
put extern in front)

extern __bpf_fastcall __u32 ...


So I slightly modified bpf_doc.py with my weak Python-fu:

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index db50c8d7d112..f98933a5d38c 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -871,9 +871,10 @@ class PrinterHelpers(Printer):
                 print(' *{}{}'.format(' \t' if line else '', line))

         print(' */')
+        print('static ', end=3D'')
         if helper.attrs:
-            print(" ".join(helper.attrs))
-        print('static %s %s(* const %s)(' % (self.map_type(proto['ret_type=
']),
+            print('%s ' % (" ".join(helper.attrs)), end=3D'')
+        print('%s %s(* const %s)(' % (self.map_type(proto['ret_type']),
                                       proto['ret_star'],
proto['name']), end=3D'')
         comma =3D ''
         for i, a in enumerate(proto['args']):

But now I have:

static __bpf_fastcall __u32 (* const bpf_get_smp_processor_id)(void) =3D
(void *) 8;

and

extern __bpf_fastcall void *bpf_rdonly_cast(const void *obj__ign, u32
btf_id__k) __weak __ksym;

and that makes me a touch happier. I hope you don't mind.

>   static __u32 (* const bpf_get_smp_processor_id)(void) =3D (void *) 8;
>
> The following rules apply:
> - when present, section must follow 'Return' section;
> - attribute names are specified on the line following 'Attribute'
>   keyword;
> - attribute names are separated by spaces;
> - section ends with an "empty" line (" *\n").
>
> Valid attribute names are recorded in the ATTRS map.
> ATTRS maps shortcut attribute name to correct C syntax.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  scripts/bpf_doc.py | 50 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
>

Looks good to me, and I'm not sure there is anything too controversial
here, so I went ahead and applied to bpf-next, thanks.

