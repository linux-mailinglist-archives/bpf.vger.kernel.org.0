Return-Path: <bpf+bounces-13033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC807D3D3E
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 19:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DACC1C20A1E
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA501F610;
	Mon, 23 Oct 2023 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDz1+kMi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D551D53E
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:17:16 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6CC10E
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:17:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so7076343a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698081433; x=1698686233; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2cz1SxLHyYpvpYPrPLWCO6etxCHOsQhd+NfQuzNn6ZI=;
        b=EDz1+kMifAHpfDCBE0ksjdoaD5+1GmKtl9UYYc/ovednnGlFkbtvkm2iSOO3ByksVA
         gsSYauSMyckirSZV7h+E9Cbe9gmLHl2QSqPjxL1o8ww5SyiKhvDidlCzHNrxW7jIb9t8
         aSDNCY1zj/jTzYRYDSRJ/KAancQRbPzjHQrGnNqKvGuforX1Z7eav+eNDheFmaS841KQ
         3T7cckZJtbvpTBKNB5GUMvu5bKxjmOYUsCVnev2k3l3BGQFWS8A1l+fk/1PIB6gKPiOY
         x2mqdD5wcJ6ewFLyuhIvZFfvjQLQhzrpOldYksWj4bE+lqWlDrNpqpBaeSwuMvjiCODe
         jwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698081433; x=1698686233;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cz1SxLHyYpvpYPrPLWCO6etxCHOsQhd+NfQuzNn6ZI=;
        b=AZY1DuE8f7tw8kLs/Q1MA64Ga4c/kicAgTZ5XDJiabEchzzbhQblade3JgYsdNdkDI
         +BOujQx9wubB9Ecp5gfKQTHzmSU9U7/XfrygxqjuPotAYg+6rLJ0eV6rihF39uOPml+5
         skzlk0iKkTjlJoqWBbRpYTydskLTbtttDBY0rSHa84BRglvWkqcs68q4J/QFUC8Ala+Z
         cUD/w3n2Aksg1m1PZoiE6V5tSXHHtoVrZXjf3EijyDr0r9omyN841om1/yvDOq9JdKNi
         3+z7Qx8+jfW9TPs4KVi2tSCnlzpQkc1e97exLk0MPLt7I8koG5ZZbeERhVTZahjCG0Xb
         Mj8g==
X-Gm-Message-State: AOJu0Yzd6dcr+Lex5UB0J9TjwG5iFJWzieYRWoI2zaOo9pQqkAfMoz1X
	mZRubfJQadEvgoBUH29sR0Yt2R5hnCNhMpNB
X-Google-Smtp-Source: AGHT+IGjiTmvpCGpRVfL4lM6fOg29E6XpnX+lp/Qp4JZs8tpC0a0AR710gPHMP7FzMwUCDeIwCkvow==
X-Received: by 2002:a17:906:7308:b0:9a2:295a:9bbc with SMTP id di8-20020a170906730800b009a2295a9bbcmr7578468ejc.37.1698081432723;
        Mon, 23 Oct 2023 10:17:12 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q1-20020a1709060e4100b009b64987e1absm6901876eji.139.2023.10.23.10.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:17:12 -0700 (PDT)
Message-ID: <3c354780e99e451fd8b8de26b12a8cb5c47148aa.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/7] exact states comparison for iterator
 convergence checks
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
 kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com,
 awerner32@gmail.com,  john.fastabend@gmail.com
Date: Mon, 23 Oct 2023 20:17:05 +0300
In-Reply-To: <20231022010812.9201-1-eddyz87@gmail.com>
References: <20231022010812.9201-1-eddyz87@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-10-22 at 04:08 +0300, Eduard Zingerman wrote:
[...]
> Changelog:
> V1 -> V2 [2], applied changes suggested by Alexei offlist:
> - __explored_state() function removed;
> - same_callsites() function is now used in clean_live_states();
> - patches #1,2 are added as preparatory code movement;
> - in process_iter_next_call() a safeguard is added to verify that
>   cur_st->parent exists and has expected insn index / call sites.

I have V3 ready and passing CI.

However I checked on Alexei's concerns regarding performance on
explored states cache miss and verifier does not behave well with this
patch-set. For example, the program at the end of the email causes
verifier to "hang" (loop inside is_state_visited() to no end).

There are several options to fix this:
(a) limit total iteration depth, as in [1], the limit would have to be
    at-least 1000 to make iters/task_vma pass;
(b) limit maximal number of checkpoint states associated with
    instruction and evict those with lowest dfs_depth;
(c) choose bigger constants in `sl->miss_cnt > sl->hit_cnt * 3 + 3` for
    checkpoint states.

Given that current failure mode is bad, should I submit V3 as-is or
should I explore options (b,c) and add one of those to V3?

[1] https://github.com/eddyz87/bpf/tree/bpf-iter-next-exact-widening-max-it=
er-depth

---

SEC("?raw_tp")
__failure
__naked int max_iter_depth(void)
{
	/* This is equivalent to C program below.
	 * The counter stored in r6 is used as precise after the loop,
	 * thus preventing widening. Verifier won't be able to conclude
	 * that such program terminates but it should gracefully exit.
	 *
	 * r6 =3D 0
	 * bpf_iter_num_new(&fp[-8], 0, 10)
	 * while (bpf_iter_num_next(&fp[-8])) {
	 *   r6 +=3D 1;
	 * }
	 * bpf_iter_num_destroy(&fp[-8])
	 * ... force r6 precise ...
	 * return 0
	 */
	asm volatile (
		"r6 =3D 0;"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"r2 =3D 0;"
		"r3 =3D 10;"
		"call %[bpf_iter_num_new];"
	"loop_%=3D:"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"call %[bpf_iter_num_next];"
		"if r0 =3D=3D 0 goto loop_end_%=3D;"
		"r6 +=3D 1;"
		"goto loop_%=3D;"
	"loop_end_%=3D:"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"call %[bpf_iter_num_destroy];"
		"r0 =3D r10;"
		"r0 +=3D r6;" /* this forces r6 to be precise */
		"r0 =3D 0;"
		"exit;"
		:
		: __imm(bpf_iter_num_new),
		  __imm(bpf_iter_num_next),
		  __imm(bpf_iter_num_destroy)
		: __clobber_all
	);
}


