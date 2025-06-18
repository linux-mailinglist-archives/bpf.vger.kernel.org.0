Return-Path: <bpf+bounces-60906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60DADE9DB
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF47017AF0E
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 11:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D71229C340;
	Wed, 18 Jun 2025 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQtJ8PqX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606128000E;
	Wed, 18 Jun 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245880; cv=none; b=Ep+UMlFSwHoMOs2Z1S/vJI4PeggoXpcMXEVa0hAgnjoTRs/Y3Bq0PF6JatV095qiqsUe5Uii2g78UVjnwXEXFA7A6goR/PnhEvePvf5wrId1HHVY0YuJ9qX4/s5akguAcG+X9YeWxiPMmafFUrUQ5IMR3rSYku9d3eXWXmX7d1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245880; c=relaxed/simple;
	bh=7ACZf7bBeGAcZRWIxVGihw+TZKw06M2AlWWMsxJonvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlazsFU8H3/qIVmMrWlxfObfQkHxqZEf8cJJjotIn0rIXesOCO8F7lK+4fjA4TJ4ajVIF9fCJBWSw1HuSs4JExTzCn1XhPuAvh+i9IZFq7sU+d/LNinquDJxr7oSKO9/JLv/V2X+414Pzh7k8t/687r5t5EgBWdMSUVCHVWwGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQtJ8PqX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a582e09144so1953425f8f.1;
        Wed, 18 Jun 2025 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750245876; x=1750850676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPWMD5GnnTJDibzdh+mzKkJMnzYLCpJuUgnOjbrn81Q=;
        b=OQtJ8PqXCRDyVK8z+dzYklh3a3ekeYxnYSgS8VhjFvHo56hp4S5lo7P1dQcdKqqy6r
         LXaHfEm/tc7q5hob1xCpnpFP5t/YrQGDzYhgGqr7aUhWruksHjltfJcxwDo7LmkLEhV6
         zJ4gSyg0swpkhQ1gLE6egcm0AmqlHd8hrp2o6Pq2Oja5bQim2zr0REO4DF2mtcuW4LPR
         F7Y0ErRvIiq5BICmD3e4BiPW9BtMelxLDojzy7bo51kPwwmpuudL8DUadH/lbR/coVpf
         hfL9Gbp/l9R0FAeUi+djfnhIHf16Ls8Y4mXXgfqkSl9iHLwRXDF2+5Epnx/dsGvuufks
         uxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750245876; x=1750850676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPWMD5GnnTJDibzdh+mzKkJMnzYLCpJuUgnOjbrn81Q=;
        b=c2XBlD4wpgzebc2gX55oUXm2BQZWW5AOba/7ZvtGxgR/IT74isdPcCt5HHksYbsej+
         CZIQe9hq1g2d/EfVbNzwnOhKtOFQt9+qsFDZM6vS3GacWccnib6dTnFhnihWAwJIV1Lw
         K0x87GBdJEVw7TP5eDc1iGxK/yoCi2Crd57SNSmJgdBqPfjk4v3othDkdHpFw2+2kMr4
         0qVonrq2iv8X4U4VcHdgKvc38gefyhUHBTBxOI/I1amTmcX1yR7S+K2ojg63S7KGL8Q6
         j9eeOR1soKosKx/80mLDuhNtiPT1OezomSGqpTX7vGsVwitjcmKTzq0dPvmCPaTrKhdn
         pYEg==
X-Forwarded-Encrypted: i=1; AJvYcCXOzEf6dnea1cV5ypskNmdf3ZIBZfdr4KMyg4SNzDkLZ/ElmlLsRrC3ljsUqcA/nuoJAQg=@vger.kernel.org, AJvYcCXUrPUuGyZ/1We2mTkJ4DnXyXh9HYae5Zry6bzAyMDD5vkDXkXyR3Xlg8k1E/JqRXLjTKLGYF5TE/6ttFvo@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOQhOlo9U7bEgOAJgabGPhYMPRguiF/cmetKHJlaxtj79OO5N
	cjrtQZ1YYy1RrzM2j1zehZvI/OZhYc6yGRv7o+xdeCYd5dkgrIQ9ECY=
X-Gm-Gg: ASbGncsdanD93tmpkRvFvkz7yPrZykfP4Z2BBLP47V6uS9z1NwjE5xiQWnwDv7x/qfZ
	6jWN+rWyKLS4rrmEa9LWzpphepSIxxj3tPdZ8KIS6QW68UYWHjkQNzHAlahh24PZDoGn9StUWDF
	u3MZXcbCKbkaeWyM/Aa1oZxnZEaYrWKz6LxaPvUTGMOyH3CGTGf3ec/gZUjJs4s1tMGCgQkmExB
	w6n0kWWk+YJWQ+WnDSvqiXaNXd3iwpSv3TGIsWHQHROhjqJzu1EvriV2LM+wu+YyWvoi2l9e2Zi
	f31mCDBdcEFA849Yc+dNaG1gtI8g0JK8zUkejSmTSN6xQ57+ZvLd9X8WM3Adf08TlMQC5phwMo2
	GniHPUWAtVSuWfpU2cYBh6pYdWg==
X-Google-Smtp-Source: AGHT+IFr9nIlOeyDXs/NnvoTCm2pWEILjPkDMo4Gn/hyt9XzDRoeC8fpAgei+rZyezV9G+4iEDrVNQ==
X-Received: by 2002:a05:6000:2010:b0:3a4:f70d:8673 with SMTP id ffacd0b85a97d-3a57237dc6cmr14609605f8f.25.1750245876169;
        Wed, 18 Jun 2025 04:24:36 -0700 (PDT)
Received: from localhost (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a7ddefsm16701542f8f.39.2025.06.18.04.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 04:24:35 -0700 (PDT)
Date: Wed, 18 Jun 2025 13:24:34 +0200
From: Hao Sun <sunhao.th@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: ast@kernel.org, m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] bpf, verifier: Improve precision for BPF_ADD and
 BPF_SUB
Message-ID: <20250618112339.ezhjt25lnztck6ye@ast-epyc5.inf.ethz.ch>
Mail-Followup-To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	ast@kernel.org, m.shachnai@rutgers.edu,
	srinivas.narayana@rutgers.edu, santosh.nagarakatte@rutgers.edu,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
 <20250617231733.181797-2-harishankar.vishwanathan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617231733.181797-2-harishankar.vishwanathan@gmail.com>

On Tue, Jun 17, 2025 at 07:17:31PM -0400, Harishankar Vishwanathan wrote:
[...]
> 
> There are three cases to consider when adding two u64 ranges [dst_umin,
> dst_umax] and [src_umin, src_umax]. Consider a value x in the range
> [dst_umin, dst_umax] and another value y in the range [src_umin,
> src_umax].
> 
> (a) No overflow: No addition x + y overflows. This occurs when even the
> largest possible sum, i.e., dst_umax + src_umax <= U64_MAX.
> 
> (b) Partial overflow: Some additions x + y overflow. This occurs when
> the largest possible sum overflows (dst_umax + src_umax > U64_MAX), but
> the smallest possible sum does not overflow (dst_umin + src_umin <=
> U64_MAX).
> 
> (c) Full overflow: All additions x + y overflow. This occurs when both
> the smallest possible sum and the largest possible sum overflow, i.e.,
> both (dst_umin + src_umin) and (dst_umax + src_umax) are > U64_MAX.
> 
> The current implementation conservatively sets the output bounds to
> unbounded, i.e, [umin=0, umax=U64_MAX], whenever there is *any*
> possibility of overflow, i.e, in cases (b) and (c). Otherwise it
> computes tight bounds as [dst_umin + src_umin, dst_umax + src_umax]:
> 
> if (check_add_overflow(*dst_umin, src_reg->umin_value, dst_umin) ||
>     check_add_overflow(*dst_umax, src_reg->umax_value, dst_umax)) {
> 	*dst_umin = 0;
> 	*dst_umax = U64_MAX;
> }
> 
> Our synthesis-based technique discovered a more precise operator.
> Particularly, in case (c), all possible additions x + y overflow and
> wrap around according to eBPF semantics, and the computation of the
> output range as [dst_umin + src_umin, dst_umax + src_umax] continues to
> work. Only in case (b), do we need to set the output bounds to
> unbounded, i.e., [0, U64_MAX].
> 
 
In case anyone is interested, the above (case c) can also be proved by
the following SMT formula directly, which may ease the reasoning here:

```
; ================================================================
;  Unsigned 32- and 64-bit interval addition & subtraction
;  with wrap-around semantics and endpoint overflow / underflow.
; ================================================================
(set-logic ALL)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ----------  u32  (32-bit)  ----------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(declare-const l0_32 (_ BitVec 32))
(declare-const h0_32 (_ BitVec 32))
(declare-const l1_32 (_ BitVec 32))
(declare-const h1_32 (_ BitVec 32))

; Well-formed input ranges
(assert (bvule l0_32 h0_32))
(assert (bvule l1_32 h1_32))

; ----- Addition -----
(define-fun lowSum32  () (_ BitVec 32) (bvadd l0_32 l1_32))
(define-fun highSum32 () (_ BitVec 32) (bvadd h0_32 h1_32))

; Both endpoint sums overflow (wrap) ⇒ result < first addend
(assert (bvult lowSum32  l0_32))
(assert (bvult highSum32 h0_32))

; Soundness of addition
(assert
  (forall ((x (_ BitVec 32)) (y (_ BitVec 32)))
    (=> (and (bvule l0_32 x) (bvule x h0_32)
             (bvule l1_32 y) (bvule y h1_32))
        (and (bvule lowSum32  (bvadd x y))
             (bvule (bvadd x y) highSum32)))))

; ----- Subtraction -----
(define-fun lowDiff32  () (_ BitVec 32) (bvsub l0_32 h1_32))
(define-fun highDiff32 () (_ BitVec 32) (bvsub h0_32 l1_32))

; Both endpoint differences underflow ⇒ result > minuend
(assert (bvugt lowDiff32  l0_32))
(assert (bvugt highDiff32 h0_32))

; Soundness of subtraction
(assert
  (forall ((x (_ BitVec 32)) (y (_ BitVec 32)))
    (=> (and (bvule l0_32 x) (bvule x h0_32)
             (bvule l1_32 y) (bvule y h1_32))
        (and (bvule lowDiff32  (bvsub x y))
             (bvule (bvsub x y) highDiff32)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ----------  u64  (64-bit)  ----------
;; Basically the same as above but for u64
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(declare-const l0_64 (_ BitVec 64))
(declare-const h0_64 (_ BitVec 64))
(declare-const l1_64 (_ BitVec 64))
(declare-const h1_64 (_ BitVec 64))

; Well-formed input ranges
(assert (bvule l0_64 h0_64))
(assert (bvule l1_64 h1_64))

; ----- Addition -----
(define-fun lowSum64  () (_ BitVec 64) (bvadd l0_64 l1_64))
(define-fun highSum64 () (_ BitVec 64) (bvadd h0_64 h1_64))

(assert (bvult lowSum64  l0_64))
(assert (bvult highSum64 h0_64))

(assert
  (forall ((x (_ BitVec 64)) (y (_ BitVec 64)))
    (=> (and (bvule l0_64 x) (bvule x h0_64)
             (bvule l1_64 y) (bvule y h1_64))
        (and (bvule lowSum64  (bvadd x y))
             (bvule (bvadd x y) highSum64)))))

; ----- Subtraction -----
(define-fun lowDiff64  () (_ BitVec 64) (bvsub l0_64 h1_64))
(define-fun highDiff64 () (_ BitVec 64) (bvsub h0_64 l1_64))

(assert (bvugt lowDiff64  l0_64))
(assert (bvugt highDiff64 h0_64))

(assert
  (forall ((x (_ BitVec 64)) (y (_ BitVec 64)))
    (=> (and (bvule l0_64 x) (bvule x h0_64)
             (bvule l1_64 y) (bvule y h1_64))
        (and (bvule lowDiff64  (bvsub x y))
             (bvule (bvsub x y) highDiff64)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(check-sat)
(exit)
```

Both cvc5 and z3 can prove the above, and one can try this and expect
it producing SAT on:
https://cvc5.github.io/app/#temp_a95e25c4-88c5-4257-96c8-0bd74125b179

In addition, the unsoundness of partial case-b can also be proved by
the following formula, and the counter examples generated may be used
as test cases if needed:
https://pastebin.com/raw/qrT7rC1P

Regards
Hao

