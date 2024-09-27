Return-Path: <bpf+bounces-40377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A9E987CC6
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 03:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82601C22A49
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 01:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B82166F06;
	Fri, 27 Sep 2024 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0x4ByGi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDC139D04
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727402261; cv=none; b=D9+rL83FSINKZbo7X5Rs57ZB/+OVydwcPh9qKwfvah/c90l9WPXM5RthzdCh93XN9BsgzyCs5GztQGa7aPrg1m3khwaOoSRl+xvP7PWDVn3PihetpUkQTcPQB2szNB5bqCQTixVtlpsGnjn+/4e98VxysrWiU1b85IEGnNPYAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727402261; c=relaxed/simple;
	bh=sj+DzpCY4wThs5g9X5gfW8kd/sCKQko2CuOVeJ1H6pk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KXJinBi1g1hfTBmioxMtIYglRdYk2+62d01NJmfRO2UCJbLMvHK9nB8QoaZJxSKPBSGvsn2tSCu7jtjkxN/E0RxKDwLW5pCSWns1szHcxFSBAsRVqDmkWgaHMRXkqeHhFbpe3LNnasFzufp5ESt42n93kWzDQr42DIycTw2VWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0x4ByGi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7178df70f28so1376953b3a.2
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727402259; x=1728007059; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/WiqVxpVKEm6+S3zgxpq4q0nksB73c35lGqGdMcViY=;
        b=l0x4ByGizU8T3gZycK9LzxjEqo16+JeU2yBtRvCnuMzKuwtcphkkkOQNlX2koCZMIL
         uPtWF+EF78q8F2hk9rWzsNULtfCiaMTZD0vX9JbtR0PCzaJKlZcLU7spfquWplePLGd3
         TZ0KNCzO5xBWnhFwYyxlByH2h6klKBjOJtBrG7uOhFn5/YWOdnQnMY6JSuPgmvHQKH8f
         oP4Nlw5AL3W3l6/tlvd1E86oil8aKzfmbY8mZ6YLqp5ZyGFbm301Dik3W8nW+QAnnWd0
         gn+tN9lAleqZ9INg0yBheXOIWm8lnDFmDtJVqassWD4lQdjA6EHgfNgCird1tHjcdRmx
         3E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727402259; x=1728007059;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/WiqVxpVKEm6+S3zgxpq4q0nksB73c35lGqGdMcViY=;
        b=bbNWFQpcBgMs3/1KkfUsoZEu460mNWiJkXtoNoAAKqJ2saq3GQxLe2JmsT4x3c6PLQ
         XTKSevrh2IfQ+GjqpLpbkwhukX3nuUsfLfodVs8XTUvuvvjsl41TsZ9DE5PGQZuaatD5
         jU1gKYz+bX5Mul2hz4rrBlRk4nR9iULjjtjv0nY/QG/g88+Jlx2fwsmmLNP8UDmnGF3A
         9iOTr7YEujBANd8tZV7D+VDhw5sO4BwXKXX4aQ7LZGAmQzjLtNIXpZNK/XXAOD9Cjyt8
         dIEbUETJzlNkRmK87V1s47BBQJIGgo+xhdqZEel4q0vE32+lboPJfqOK7xOSByER18Br
         /2LA==
X-Forwarded-Encrypted: i=1; AJvYcCX91h7yiPHzF+HvrsqgzomBFt1cIonx7a3clgclhynfk7K6XrkwcBjeYwiUoDB/6ZFy1jM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2V90siK8wQbftMJHN59Hy2eOtlJJgJsSq5sYrNvsqb0wPrZHS
	29YQCJ7R6fXTTyfiHqcBsRRGRxcTNzOOgPHfWXMP3gqHC+45p5Lb
X-Google-Smtp-Source: AGHT+IGXVRTS5PO55YVMNvwrtM/hSQVc7MAPIXYgnOdh2KSl5hG/mbbcAXuF9+KFWR78IWWUF27SGA==
X-Received: by 2002:a05:6a21:3489:b0:1c6:fb2a:4696 with SMTP id adf61e73a8af0-1d4fa68768bmr2589418637.19.1727402258810;
        Thu, 26 Sep 2024 18:57:38 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264ba68dsm549764b3a.57.2024.09.26.18.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 18:57:38 -0700 (PDT)
Message-ID: <731080a35952545500de577329e16cdd75fe787e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for string
 kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Date: Thu, 26 Sep 2024 18:57:33 -0700
In-Reply-To: <34e1a69f9e45fc8e4373d04f5543a1ffa32981fd.1727335530.git.vmalik@redhat.com>
References: <cover.1727335530.git.vmalik@redhat.com>
	 <34e1a69f9e45fc8e4373d04f5543a1ffa32981fd.1727335530.git.vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 09:29 +0200, Viktor Malik wrote:
> The tests attach to `raw_tp/bpf_testmod_test_write_bare` triggerred by
> `trigger_module_test_write` which writes the string "aaa..." of the
> given size.
>=20
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---

I thought about making these tests more terse as follows:

--- 8< ----------------------------------

// SPDX-License-Identifier: GPL-2.0

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include "bpf_misc.h"

int bpf_strcmp(const char *cs, const char *ct) __ksym;
char *bpf_strchr(const char *s, int c) __ksym;

static char *abc =3D "abc";

#define __test(retval) SEC("raw_tp") __success __retval(retval)

__test(2) int test_strcmp(void *ctx) { return bpf_strcmp(abc, "abd"); }
__test(1) int test_strchr(void *ctx) { return bpf_strchr(abc, 'b') - abc; }

char _license[] SEC("license") =3D "GPL";

---------------------------------- >8 ---

(plus registration in tools/testing/selftests/bpf/prog_tests/verifier.c)

However, this does not pass verification with the following error:

    VERIFIER LOG:
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    arg#0 reference type('UNKNOWN ') size cannot be determined: -22
    0: R1=3Dctx() R10=3Dfp0
    ; __test(2) int test_strcmp(void *ctx) { return bpf_strcmp(abc, "abd");=
 } @ verifier_str.c:15
    0: (18) r1 =3D 0xffff8881019533dc       ; R1_w=3Dmap_value(map=3D.rodat=
a.str1.1,ks=3D4,vs=3D8,off=3D4)
    2: (18) r2 =3D 0xffff8881019533d8       ; R2_w=3Dmap_value(map=3D.rodat=
a.str1.1,ks=3D4,vs=3D8)
    4: (85) call bpf_strcmp#64714
    write into map forbidden, value_size=3D8 off=3D4 size=3D1
    processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    #503/1   verifier_str/test_strcmp:FAIL

Note that each string literal in the BPF program is in fact a pointer
to a read-only map. Hence in current form these new functions are not
very ergonomic. I think verifier should be extended to check 'const'
qualifiers for the kfuncs and allowing access in such cases.

[...]


