Return-Path: <bpf+bounces-18252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E74A817F2F
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 02:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7211F23208
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 01:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2290A1381;
	Tue, 19 Dec 2023 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxvT6pqu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495410E4
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3365f1326e4so2676370f8f.1
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702948529; x=1703553329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50OUIIqph5wXqODzVeWVSRaHi5HO6yKUd5PpBi4ufIk=;
        b=gxvT6pquoFERXqBtn/3VRXJSyjMPtWLtbTycnYUEKIeeFRQV7cFUGG/cMIVAhZZUZf
         JGi1/mtZSFDCAyiad0fRLM0b3WPbeOrae3Yqw0y3M8fZyXI6k9DzO9ysxcFNFlgTpY1B
         AhNmDZHYHNGNOXD0WY3+64Q5ooFjWuNIyiWX1phzvbFN+aISEw2QnU6X/bFdDFr76fFl
         e5/qHicqlmMqrr1WOdfxNomujheAlgim5wjNaHTIOyMkPS6ST1tZV8H7nP4Tstav9D5/
         S6O7yGQKaP8fIugLPdzb6nKdAcnVehgUMhKwYkALQ2w8BbxCghCCWYybELThl0u4QGHP
         nxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702948529; x=1703553329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50OUIIqph5wXqODzVeWVSRaHi5HO6yKUd5PpBi4ufIk=;
        b=ou8M7K4/AwPc4vTyNxRChFudwUJ3vPr7GgADCo+z9JLBHqA1aMdMSiPqY3TFqwgYZL
         pF4z1pI/VMplC5CgetO0KPJGTFi/PQbijlS6QifWWkZu7VMLbU6QjdLIWm0lQ5aky8NH
         OW9T/uNO/ZIMpu1tXzF9IwYGHebHlLEPznInuF18bPYyI4J5ttV746WPKgJUxehYA1KF
         d2pmNb6ckpiF3nqMpe7S3JPzoMfWmfl5PXg8PmSRPmDB0Zue82dg8UO5vSsSM/lxbhQI
         Ee0dDcs56+Wfnw78c/i/iSMZl9HYRAxvno7eXvCs7fGRu3fsq94C3+sSkR9SSZWFMHZu
         nr0A==
X-Gm-Message-State: AOJu0YyJmNqQlyXGwCXwn4DPQTcgrTZTAZ2iVtMDL4HUu1pLAcdVdnDn
	7woMu8SO4CkOmvaTFdMNL9BylBmoMr3gYhlwtdk=
X-Google-Smtp-Source: AGHT+IHZa/VMCz915fiAiIe2ynBdaU1bzV+Xote9kzNTYL6LUlAsCyXWwE80BGKR7Ot6n57uQ4AClZk9wSprPZREN1c=
X-Received: by 2002:adf:e781:0:b0:336:616f:c1ec with SMTP id
 n1-20020adfe781000000b00336616fc1ecmr1998825wrm.103.1702948528480; Mon, 18
 Dec 2023 17:15:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207215152.GA168514@maniforge> <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge> <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge> <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
In-Reply-To: <ZXvkS4qmRMZqlWhA@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Dec 2023 17:15:16 -0800
Message-ID: <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA conformance groups
To: Christoph Hellwig <hch@infradead.org>
Cc: David Vernet <void@manifault.com>, Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org, 
	bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:29=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> We need the concept in the spec just to allow future extensability.

Completely agree that the concept of the groups is necessary.

I'm arguing that what was proposed:
1. "basic": all instructions not covered by another group below.
2. "atomic": all Atomic operations.
3. "divide": all division and modulo operations.
4. "legacy": all legacy packet access instructions (deprecated).
5. "map": 64-bit immediate instructions that deal with map fds or map
indices.
6. "code": 64-bit immediate instruction that has a "code pointer" type.
7. "func": program-local functions.

logically makes sense, but might not work for HW
(based on the history of nfp offload).
imo "basic" and "legacy" won't work either.
So it's a lesser evil.

Anyway, let's look at:

   | BPF_CALL | 0x8   | 0x0 | call helper         | see Helper        |
   |          |       |     | function by address | functions         |
   |          |       |     |                     | (Section 3.3.1)   |
   +----------+-------+-----+---------------------+-------------------+
   | BPF_CALL | 0x8   | 0x1 | call PC +=3D imm      | see Program-local |
   |          |       |     |                     | functions         |
   |          |       |     |                     | (Section 3.3.2)   |
   +----------+-------+-----+---------------------+-------------------+
   | BPF_CALL | 0x8   | 0x2 | call helper         | see Helper        |
   |          |       |     | function by BTF ID  | functions         |
   |          |       |     |                     | (Section 3.3.

Having separate category 7 for single insn BPF_CALL 0x8 0x1
while keeping 0x8 0x0 and 0x8 0x2 in "basic" seems just
as logical as having atomic_add insn in "basic" instead of "atomic".

Then we have several kinds of ld_imm64. Sounds like the idea
is to split 0x18 0x4 into "code" and the rest into "map" group?
Is it logical or not?

Maybe we should do risc-v like group instead?
Just these 4:
- Base Integer Instruction Set, 32-bit
- Base Integer Instruction Set, 64-bit
- Integer Multiplication and Division
- Atomic Instructions

And that's it. The rest of risc-v groups have no equivalent in bpf isa.

