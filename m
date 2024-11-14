Return-Path: <bpf+bounces-44861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84F9C9193
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 19:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE9282AE6
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AAF1974EA;
	Thu, 14 Nov 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYU0cUS4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AAA18B484;
	Thu, 14 Nov 2024 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608490; cv=none; b=Y9shjp9hcvwutlhUza806GMBzY9wgtu/HwqObype3imnNJ2n58PxV1HXqpv8yK8p4brdyBUPV1adXibIbGOcAljHf/9Qp2oH3FfszhEdOB78CE6xu2HxEILZm09ba/WorQ7p5o+z/XenME44pPvqI5vztHU1+p3z3IAwEMFPXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608490; c=relaxed/simple;
	bh=yfj4LI24H9V/inNdeLAt1z1j4csnvjmzqjlNGe+quD0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bXFGcgycrhhVQiiSGKv+SEj77v/RmLSn/6dYsHnLfDMeG0hrRnYttwpsQb4vT6SxJdKQoTDJJ+qHv3XqQNFhAiAOMzM81/FbEFmCImFwQOeGh1u28G/aMtjSbZ4sTsqYfvbavi8Dnx3xYLjDv4e0vcNEosH4vn9jP/GclAvqD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYU0cUS4; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f3e30a43f1so655945a12.1;
        Thu, 14 Nov 2024 10:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731608489; x=1732213289; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=28xoV2N29AQ4KW9mkniTV9YaPV2UaCxGFtNxBjimLRs=;
        b=DYU0cUS4iov5grV/8cL3Z/vFCMrr0l62OEvftK1W3zft+WiBIdx0wzg1CLCE4xkzwd
         Iw20+3pYOOUPWSeFxS/0D5TA/l5HxJXZgcqT1zwWEe8Ic+imhruls3yVRsoRD4q6UWoW
         /iLYANBv1gmpBhV/4pdFTTEA2hHllW8/Yywz3+ue0h2HJ1H9ZBGAzpI5MaejU/x4jvM6
         X/Gya3C4LAd6a2hecY9xW0NXs6Iwnp396adr3G5W5PK1m+QgtNVsS5uebmDQXWDUPA5n
         Uco9wi7BHrZTL5Hjp0j6csJhJu8+Nt8116szu9NN/FZWQSPSlshx626hr0RqeS0N7XnG
         yiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731608489; x=1732213289;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28xoV2N29AQ4KW9mkniTV9YaPV2UaCxGFtNxBjimLRs=;
        b=TCQcAQkXtMQ4q7QGyhySKZJHYMcPsSDSnHZYiS0DlpTFxsPZdjT1omQL0+yBQs3eET
         b29yo4cvLx3suf8g4nwBWQqKvCcxo9AAMJ/JKTlDeDP9U7dmYcMpf4QXWbVcrgY4p5od
         GT9rpx/4gz9LmntiZGzgfc1XM78gljayc7oS9C4r2gStVKZgp5r/ukmbfXA5BXYkqTDc
         OGxOF02Nq5mv28q04kbb5SdjNeFhXz1raviNdxwUUOlWd3hz2P/eallH6BS7145ccJLe
         Aq81Ai5SvG3lsw/4twisDTAYTM6XoFe02l66XDb4e31cYI3aNyfxqhfqpWrSCeGXn91A
         nSSA==
X-Forwarded-Encrypted: i=1; AJvYcCWUxWsccOY4dZyje92jzsnxo2aHyRfA2rOxOtRGCOBTPeMpW6pvrt9UJsWQ5ntJucsaJD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3i43z2zQmU2lpVd3/7gmEqUih1TKmWtclyI5k/749YVGALAc6
	FhQvgBQViMT12ucRPoZwWy2zNpT+So2T3XZvJV3bIw/IdR001hvp
X-Google-Smtp-Source: AGHT+IGkq3EZ80p1Wxr8aKGTUSvH44HD4LzC2ZTJKdgLl7WkuDq+eJyETN/JbdnHwYznMDrPuILr0w==
X-Received: by 2002:a17:90b:2b48:b0:2e2:c15f:1ffe with SMTP id 98e67ed59e1d1-2ea05d9f097mr3822237a91.0.1731608488581;
        Thu, 14 Nov 2024 10:21:28 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024a4d4asm1611236a91.31.2024.11.14.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 10:21:28 -0800 (PST)
Message-ID: <80623f0b630bd3761f0239dbe0f3197dcc6ae575.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 1/2] dwarf_loader: Check
 DW_OP_[GNU_]entry_value for possible parameter matching
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alan Maguire
	 <alan.maguire@oracle.com>, acme@kernel.org
Cc: dwarves@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
 song@kernel.org,  olsajiri@gmail.com
Date: Thu, 14 Nov 2024 10:21:23 -0800
In-Reply-To: <8a08219a-9312-429d-a291-d93a932c849a@linux.dev>
References: <20241114155822.898466-1-alan.maguire@oracle.com>
	 <20241114155822.898466-2-alan.maguire@oracle.com>
	 <8a08219a-9312-429d-a291-d93a932c849a@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 08:51 -0800, Yonghong Song wrote:

[...]

> > +		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
> > +		case DW_OP_entry_value:
> > +		case DW_OP_GNU_entry_value:
> > +			if (dwarf_getlocation_attr(attr, expr, &entry_attr) =3D=3D 0 &&
> > +			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) =3D=3D 0=
 &&
> > +			    entry_len =3D=3D 1) {
> > +				ret =3D entry_ops->atom;
>=20
> Could we have more than one DW_OP_entry_value? What if the second one
> matches execpted_reg? From dwarf5 documentation, there is no say about
> whether we could have more than one DW_OP_entry_value or not.
>=20
> If we have evidence that only one DW_OP_entry_value will appear in parame=
ter
> locations, a comment will be needed in the above.
>=20
> Otherwise, let us not do 'goto out' here. Rather, let us compare
> entry_ops->atom with expected_reg. Do 'ret =3D entry_ops->atom' and
> 'goto out' only if entry_ops->atom =3D=3D expected_reg. Otherwise,
> the original 'ret' value is preserved.

Basing on this description in lldb source:
https://github.com/llvm/llvm-project/blob/1cd981a5f3c89058edd61cdeb1efa3232=
b1f71e6/lldb/source/Expression/DWARFExpression.cpp#L538
It would be surprising if DW_OP_entry_value records had different expressio=
ns.
However, there are 50 instances of such behaviour in my clang 18.1.8 built =
kernel., e.g.:

0x01f75d14:   DW_TAG_subprogram
                DW_AT_low_pc    (0xffffffff818c43a0)
                DW_AT_high_pc   (0xffffffff818c43c9)
                DW_AT_frame_base        (DW_OP_reg7 RSP)
                DW_AT_call_all_calls    (true)
                DW_AT_name      ("hwcache_align_show")
                DW_AT_decl_file ("/home/eddy/work/bpf-next/mm/slub.c")
                DW_AT_decl_line (6621)
                DW_AT_prototyped        (true)
                DW_AT_type      (0x01f51a9b "ssize_t")

0x01f75d26:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0xa0f) loclist =3D 0x0062=
c64f:=20
                     [0xffffffff818c43a9, 0xffffffff818c43b5): DW_OP_reg5 R=
DI
                     [0xffffffff818c43b5, 0xffffffff818c43c1): DW_OP_entry_=
value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff818c43c1, 0xffffffff818c43c9): DW_OP_entry_=
value(DW_OP_reg4 RSI), DW_OP_stack_value)
                  DW_AT_name    ("s")
                  DW_AT_decl_file       ("/home/eddy/work/bpf-next/mm/slub.=
c")
                  DW_AT_decl_line       (6621)
                  DW_AT_type    (0x01f4f449 "kmem_cache *")

The following change seem not to affect pahole execution time:

@@ -1234,7 +1234,8 @@ static int parameter__reg(Dwarf_Attribute *attr, int =
expected_reg)
                            dwarf_getlocation(&entry_attr, &entry_ops, &ent=
ry_len) =3D=3D 0 &&
                            entry_len =3D=3D 1) {
                                ret =3D entry_ops->atom;
-                               goto out;
+                               if (expr->atom =3D=3D expected_reg)
+                                       goto out;
                        }
                        break;
                }

This question aside, I think the changes fine.

[...]


