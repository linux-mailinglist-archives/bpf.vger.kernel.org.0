Return-Path: <bpf+bounces-45770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8039DAFA2
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 00:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F4AB21E86
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 23:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30D92036F6;
	Wed, 27 Nov 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6aZ3lci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589E149C41
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748512; cv=none; b=ij5PT2DXqYcPkodDDsmqOZzVos3r4XrIUXjTmJfwDGNhjm5ozJVmkPBaPdKhIwcRLE8NA5kBRIHQVFjAXe2Bai188iXkq9Z2QlUKNPUW3V6c2AAaSqGpa3Z/+RTb/KnxinFBqo/rBYGZQ+S8xlSrjvBfoZOj8yHCX+yrqd5L9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748512; c=relaxed/simple;
	bh=ZgvncyX9bsRCBDkRYpBXd1yDaTNlLk2191xj27RiN1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TskCZb3j8aJBhUcnJmHiOLNaXwJI9obeW9t8r7COyFlgHFq6oBXIdtCOgfGEUr91X3Ig5LXt2ScAhyTYEWi4584uuD4BGUE5Fxe+QsB0LU9R1L+cYTV2nCMswuphzgOGrBYBTzbuO/HypG1SmYpDIIyr6sdf/JWk0bNpMCcPDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6aZ3lci; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-382610c7116so176796f8f.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732748509; x=1733353309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ADMYy9sTIBT24tEjtEKYDp0B9M8a1Q4OWD1W7Ej2Z6c=;
        b=E6aZ3lci/IsyLSQVnzEgOxWXy264OT+Q9fiyVHaSjIdOnDvl3oEGfo8tPtIxOqdoQo
         hlxEQStdorGXtb5x5RYq+6ujVXKQ1kZxr89TAB7pXRUOE4HTv6EzY6p/0F68DU92oC3O
         ce0bLzp1na5gqZF6M3Q9u6zvTkC3MKch0sD1UPER4YwK6TYHVhaO4nPXAD/ZFjSdzFct
         xd8EqSLWFF/qxjW76j7i5gZ9hfJMb/qFFAWjILbSv7rWUAIH/bB1JpxGL3OwD8MwrCrf
         0FjqN6R4sCxkqxHNG715f52ALUByzg5d6lRr3W23ChOh6nUaUHqzIpY4g8tzJhDo7cJI
         hcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732748509; x=1733353309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADMYy9sTIBT24tEjtEKYDp0B9M8a1Q4OWD1W7Ej2Z6c=;
        b=I4KAn6nOK+UL2gMJcy24KK8Ay56l0TdyJlBCfHycBcvgySv21fl9hBdORqW2hX6VOx
         yJwp3JgbwZr5WwtjtrlzZB9fZ3UNDAr9DDhKWhTyON6Na/CRE+SZYw/vgcObYGDWb0ZJ
         VOaenPNRKQUVzAycHai1ZAYQCAW3FL10li9KOHln/Owz9H8U5aiYHoIvD7Um4b+jFEgJ
         tO6K29DsW8C9NdDxM7QBczDx9aqlm0TKWGAUdaYoRpKV/4pwizY1DgH3bmGPYbeenZ3Y
         f2nbueMiAOHw8YKAWMOahfQrdchxYM0zJMXHxFAWoUxXK7MY0G6aPT9PKHsM80Lersn7
         uwlw==
X-Gm-Message-State: AOJu0Yx1RPqJBkfK1sI3V/ugxL0bmHA5baxS80r22cvQYN4Oh9GuvSXN
	T4iQgrSjwA6tRqo7fezoVh4vodMEMrTh20/mwfGrXB5ix2F3elGYhqiWzQgTAqc=
X-Gm-Gg: ASbGncsfs6l+9TK2IIaQ3fpqtndgZ2KLXBCv3S9/WocsGqZoEAoKUR818abrWh6vqB0
	SnCNFskOovWpycOyC0PatZnNyXFJA96EXkFBozKlBUfQHlMlpWgC8ODRFcLjO0orfhcGphiknJh
	YK15bjMV+RGxAib9xwq0SL/+J9OuazA9OsCGJ92qIfV6VKkb0ySoZq2tY1x1VdQWQ59TE5KRDAM
	2Gr1OCu3jtNGAEiSA9JGO8UPP4Azyh5cXUOpwwCfZj5bwa+e7yANHJbvRmyQOEsoH3NTkcA25gb
	HQ==
X-Google-Smtp-Source: AGHT+IG0tW7ET0wGHDVLvUXN5GToydw5wvN0XLDJBSzoGajCMsIPWQi4N5rs24Ygen4oCd9gJHO5Dg==
X-Received: by 2002:a05:6000:1a8c:b0:382:5077:afe8 with SMTP id ffacd0b85a97d-385c6ed7599mr4410771f8f.44.1732748508486;
        Wed, 27 Nov 2024 15:01:48 -0800 (PST)
Received: from localhost (fwdproxy-cln-033.fbsv.net. [2a03:2880:31ff:21::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd7fec1sm60634f8f.97.2024.11.27.15.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:01:47 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v1 0/3] Fix missing process_iter_arg type check
Date: Wed, 27 Nov 2024 15:01:44 -0800
Message-ID: <20241127230147.4158201-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; h=from:subject; bh=ZgvncyX9bsRCBDkRYpBXd1yDaTNlLk2191xj27RiN1A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR6TVgQsbGOZUiFV7XA0I+2CXZt5dOpBUYToECwrW ZJq3KwaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0ek1QAKCRBM4MiGSL8Ryl8dD/ 9VlpFNFCnvwilAwO6bHqYZ9a1YMhkm7rp/tSdned2/G8s1jIY/WXx+G1f7KIEDYYzXBuGLTaLD8N1+ O+HPdt7nq7ECTKh94G1OOnJyKXdK0zJnLcICh4g0F2NORmecnWokt+9A8EQj9kZX9AyTdSyO3MyOmu RChXEisOvL3mnorjXLXlWV8YsqKeqiU6GizbcTznOvVo4R4wEzFxws4PWWB411rfxMaIL8a3tAKFJ7 oykeYmFPqDVmGe9ap+Txp8yiKWVSNpPz3CTINahoPfC1R84ocLlF/b+zlxAsHyX5Hz+xjjlRd+FvQ8 nUF8wtT1zB52gStahEPNyAoWPP32YU/Zs1rUrPdJtSDBaKWy/AeKRKOxHUCP+kbwi9+QzX6ePNMywF U5kS5mlsulLjuXmBa2FjZtUx9waKFHYn6e0QqZi3oljJHJ9aqUOCNjicG9XTK2FYIHI86plzFwfJUy Qle3XLCEYa/02rqFDIaQWp41+0QPB2i9GclaHO9vNd0GvBR9hWjlIZuDXVtRNDj1avn+8neOmlbRbF ww7CZavEPtUrcVcYbFY216AS/pP5XnFMV+yM354IZhfriojjuT+hVqSaR293zZWJ4AA26eKAG7ZdJs +KBpOA1Ww5h7WnQJgek/u5Wjg11Mxq5qaZQmOVphQ5nVg7YFiEcZOZIYEdwg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

I am taking over Tao's earlier patch set that can be found at [0], after
an offline discussion. The bug reported in that thread is that
process_iter_arg missed a reg->type == PTR_TO_STACK check. Fix this by
adding it in, and also address comments from Andrii on the earlier
attempt. Include more selftests to ensure the error is caught.

  [0]: https://lore.kernel.org/bpf/20241107214736.347630-1-tao.lyu@epfl.ch

Kumar Kartikeya Dwivedi (2):
  bpf: Zero index arg error string for dynptr and iter
  selftests/bpf: Add tests for iter arg check

Tao Lyu (1):
  bpf: Ensure reg is PTR_TO_STACK in process_iter_arg

 kernel/bpf/verifier.c                         | 17 +++++++-----
 .../testing/selftests/bpf/progs/dynptr_fail.c | 22 ++++++++--------
 tools/testing/selftests/bpf/progs/iters.c     | 26 +++++++++++++++++++
 .../selftests/bpf/progs/iters_state_safety.c  | 14 +++++-----
 .../selftests/bpf/progs/iters_testmod_seq.c   |  4 +--
 .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
 .../selftests/bpf/progs/verifier_bits_iter.c  |  8 +++---
 7 files changed, 62 insertions(+), 31 deletions(-)


base-commit: c8d02b547363880d996f80c38cc8b997c7b90725
-- 
2.43.5


