Return-Path: <bpf+bounces-63805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0EB0B068
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 16:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47F35609D4
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA94E2874FD;
	Sat, 19 Jul 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn5k1AR7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7C1DC9A3
	for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752934936; cv=none; b=L68DT4vxjEkvPYOOYSMBHVx3f7EhGjm7vVFUG/4MYRyR/6DBkv+FoOjZ9hcgAOuZDNAL7vsvTldQMkUesjjm0g2eVJ8+K6IPQkIcz9k0zAtdbsTnzSnbBvB+Ycxxm32U8iXLZePYsnJTfjXP6idqDw7Azal3ich7ji62VMoYASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752934936; c=relaxed/simple;
	bh=GTZ2W5k9w/S3hm7ea5+7oMTapX/oEKV9MwVscRdhtXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHMkYd0N40u/dcYn6h+dliGG3Yx3J6by7SxC2b3DxqlaASCIZhcdZ8vJniKRdbTG2OTS10TsjZb10Ph+D9p4EIhL+qoHNTEFPsKdOPtm7kpsnB9W1yglD23e6x2HOchr6qcZMrxgiKYUh5bzk97o2RLLy1/WzLil3OD1ZeereL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn5k1AR7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso2753328f8f.1
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752934933; x=1753539733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mC3HruI9rAbUbZ6/68sf2sRFf0WPLBwopnKl5kSWEZE=;
        b=Fn5k1AR7y1m/afL6C35svm9HKCEpP0OKg3BYt1MOCOmGJfaCnUhKam9MnexuRPABpm
         S4L+U0/bdwwG414rej9cNumK8jaK3nP4LSsqanQkKKlcgZSq6E5Qquox7+oWUOelUcrI
         rR8vD1yvw7sLm56D+EzilZXaPF4ve7XSAUcYdKDQ6grjmRpsaTlVw/C2HQnb8ZwLB7JD
         6lKY5lNCtJ3/QJg/ctdeOYLo5syTV+KPv80WDaQPp7cc/nIeeCwj6wYXXIEmWaz0jLT9
         s/IeVGEvJZNFCvT78fPFUBZO2mtuX1MIk9Bfax/ImwLeLJ2u5Bb1S6B3Rlr2Rw28PLmg
         +Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752934933; x=1753539733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC3HruI9rAbUbZ6/68sf2sRFf0WPLBwopnKl5kSWEZE=;
        b=IQVgN5V6fp3ly2OfvnL5UQBoZaR0udXXFVVs0eZofEROFqTtw90BghUISf8rlFb3Pg
         RR4QoVeRPHru3gOtQvZLGOGOUp1GbC2277ojh9Ek1fL4fL/O5NVUKFymsCEdrBsGocMd
         oT9rNqkxTQJcIWf8YQ6lnSuMJ2i9DCfQo8lropRAgkJ0F8/L2N/w1cDWyYWXmUiWV2pl
         BadskLt8u1TjXu7Fkr0GoyFSUuPpidq75UrzEfeEPnvFEVzQ03dE+RXb5WQeJIo8uymE
         FaLT0Y2RjpdLZ2RZRMkmInPKwH6oztIfOJ7T9HLk2U6r3iSLmeNmzKFrrHIZFeeQsXQl
         Fjiw==
X-Gm-Message-State: AOJu0YzirualujK1c5LfE4d3R3QLYaGoOCBiLrVLV54UEzNX9wg+GjXT
	UmNx65JmUmjd9/F1KAB7CqhVKGmTzelS39hhyDwO9Zwd/FtdqoDcshLpSPo/KhHJ
X-Gm-Gg: ASbGncuMrIoBMVu4EaKtnzd59MZjAxtpvnlb58eqmtmVd8ngOMer8OFw+ykkntEaTMX
	WVZWByADxAbF9rkxEmLCzRTqleW7PQ77SErbyFzxV5iHh0Y5HHMCIngdP7zuY2D5EqwTwL5ELxg
	6nKvQdjMzqWywzJ6mpGeZHhA290SUo+XNh72eK+ov82E4ocQKQcLj9LGOKR7BfnMG45vlr7cjuC
	G6w7I3ES/E01EU8mdKqC85j7AbUp4fCisVKG6iSKugx5CBFDsVpgp9F6rVSBM3Ky+26U/NA1Nvw
	OtO6zqVrfV6y9Hy1/cqRXA2gDIQSAKZcbrQ6eZ6zdeYsT72BLuWGaxUFmCqRp95szC/AinKOpNs
	/CEi5Vf9jDl1Tnxy8fc1SlICG2DsfVoggnw8dUV9YGmffcMROwp6UXMNWnCd0nfIShuoV61sh09
	E8Y8/xV37bAA==
X-Google-Smtp-Source: AGHT+IG0FS43zIIu9LpzbT4iDtLXaeCxp2PwfbAGFnnvd6pvUtAo8avBrd78rZiM6EfC73EWlNtYBg==
X-Received: by 2002:a05:6000:2209:b0:3b4:9721:2b2b with SMTP id ffacd0b85a97d-3b60e4c90f7mr12900304f8f.12.1752934932505;
        Sat, 19 Jul 2025 07:22:12 -0700 (PDT)
Received: from Tunnel (2a01cb089436c000eab97b50918e1e74.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:eab9:7b50:918e:1e74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2cc06sm4885569f8f.35.2025.07.19.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:22:11 -0700 (PDT)
Date: Sat, 19 Jul 2025 16:22:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 1/4] bpf: Improve bounds when s64 crosses sign
 boundary
Message-ID: <d5be66c893ee61f7ceb9ac576fd92a3ecf7d0fa1.1752934170.git.paul.chaignon@gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752934170.git.paul.chaignon@gmail.com>

__reg64_deduce_bounds currently improves the s64 range using the u64
range and vice versa, but only if it doesn't cross the sign boundary.

This patch improves __reg64_deduce_bounds to cover the case where the
s64 range crosses the sign boundary but overlaps with the u64 range on
only one end. In that case, we can improve both ranges. Consider the
following example, with the s64 range crossing the sign boundary:

    0                                                   U64_MAX
    |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
    |----------------------------|----------------------------|
    |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
    0                     S64_MAX S64_MIN                    -1

The u64 range overlaps only with positive portion of the s64 range. We
can thus derive the following new s64 and u64 ranges.

    0                                                   U64_MAX
    |  [xxxxxx u64 range xxxxx]                               |
    |----------------------------|----------------------------|
    |  [xxxxxx s64 range xxxxx]                               |
    0                     S64_MAX S64_MIN                    -1

The same logic can probably apply to the s32/u32 ranges, but this patch
doesn't implement that change.

In addition to the selftests, this change was also tested with Agni,
the formal verification tool for the range analysis [1].

Link: https://github.com/bpfverif/agni [1]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2fcea860755..152b97a71f85 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2523,6 +2523,50 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
 	if ((u64)reg->smin_value <= (u64)reg->smax_value) {
 		reg->umin_value = max_t(u64, reg->smin_value, reg->umin_value);
 		reg->umax_value = min_t(u64, reg->smax_value, reg->umax_value);
+	} else {
+		/* If the s64 range crosses the sign boundary, then it's split
+		 * between the beginning and end of the U64 domain. In that
+		 * case, we can derive new bounds if the u64 range overlaps
+		 * with only one end of the s64 range.
+		 *
+		 * In the following example, the u64 range overlaps only with
+		 * positive portion of the s64 range.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
+		 * |----------------------------|----------------------------|
+		 * |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * We can thus derive the following new s64 and u64 ranges.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxx u64 range xxxxx]                               |
+		 * |----------------------------|----------------------------|
+		 * |  [xxxxxx s64 range xxxxx]                               |
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * If they overlap in two places, we can't derive anything
+		 * because reg_state can't represent two ranges per numeric
+		 * domain.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxxxxx]        |
+		 * |----------------------------|----------------------------|
+		 * |xxxxx s64 range xxxxxxxxx]                    [xxxxxxxxxx|
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * The first condition below corresponds to the diagram above.
+		 * The second condition considers the case where the u64 range
+		 * overlaps with the negative porition of the s64 range.
+		 */
+		if (reg->umax_value < (u64)reg->smin_value) {
+			reg->smin_value = (s64)reg->umin_value;
+			reg->umax_value = min_t(u64, reg->umax_value, reg->smax_value);
+		} else if ((u64)reg->smax_value < reg->umin_value) {
+			reg->smax_value = (s64)reg->umax_value;
+			reg->umin_value = max_t(u64, reg->umin_value, reg->smin_value);
+		}
 	}
 }
 
-- 
2.43.0


