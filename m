Return-Path: <bpf+bounces-60169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A584DAD37D7
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7EF7A3FBE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D0229B764;
	Tue, 10 Jun 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKgRNdS2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041C29AB17
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560165; cv=none; b=OdVhIlhuGImLnrmTCVO+Q965zWNku2lq/wFPYPiCzS4iSKa7sMAQ/VOMoUErs7JGIepHVAAZFWVBZiCqE93uucC4mL8CCOdvwdsa9K1eiu/rPMDsPhCta1vl8WBvbZ/5fxnMbOwdO2kYTN+B6ZEG0N+cVFor/LlcNOrszlBFFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560165; c=relaxed/simple;
	bh=Pw0DzZan2xuWi9lcQumgpYkvV9sewAXqAmqxlNKpZCU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OAEE9UlE64Y9R+dq3I8x7btO/6QqNJTFkdqAkJKVQG0EtUMuUqvBiZZACKsSLisqc+KFQIrOttZhhULJjMiQZQ50Ap4W3YJtjYkFxkmAnXzDB75ztdkOTLM8Pw29aWZnjJugIkrw0U505zgVqfhTKsw5ImqLDrCb/OhQe6Ealdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKgRNdS2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5533c562608so5306578e87.3
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560161; x=1750164961; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJg/1DjiKd5qC4M2OYtznt5RBA2Y3NgZjyUyIM+UYq4=;
        b=ZKgRNdS2kKYLkqdgPRUoNh4ozOqnhvHPGfvpjzHQqWKzLLEZYXi8gGSeCqBzzmfNS1
         zOPtn4Wbv2pau3DzxiXHPUnJreF5dr8n2Wh7aQ925CXrLS6i9Kcu1Q0wuFQTFIxjUm/o
         Tx7uzZehflTaYwoMmUgFt+9hfEdqd4TU8624uWhjUHNpmgidtEHFhPQ68aTLteuJWn6i
         m5YSEO60OQ1Mxt/6797aExWbH0bz+9yK64fGj4YeBtX4iorRuBGhxpjMynwlbvmys2lv
         hfLDPTeAhwu2/yb77Gq0BHcrHT9C/JUKz131u8OuGcmiSpyTKizi0SownO0b4B7jKG8v
         EuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560161; x=1750164961;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJg/1DjiKd5qC4M2OYtznt5RBA2Y3NgZjyUyIM+UYq4=;
        b=Y+xXXbQzezfOIeOiBACNIgD4jgOBk9sVfpMuQkJz3UEIf9hN3IIt/lHuUp0VtfOsKk
         nmRTXmfdZveZmWoTvU02aurkz/RFloKuMXKvrAAMZ48JCYi1NBkBiBhYihyjbdHot5ka
         hYf5Q+8DDaZzwdwRofAV4M4MBPlVACnIwpJmn4Cm4bXvDbvR/XxLMQ2D3pviYeFZAkS4
         N0RpcYnJTqCXSSnuhvh+UbkYpI3us6k8FeFzwjSV2jXQrL/rMhcZ3ZlGPFdQDyIwamZD
         i7FZ9NSThS+j53f85j3b7NEpdLrSrBIzHMSKPGvhqRbHFNkgLRwutyh+TJCnM5Glwucl
         q9Hw==
X-Gm-Message-State: AOJu0YywslC3dNX2c+wEDU87X+vCZMCaYpDi/ebCwbiy12EOiPXMTEkV
	mJM5hAkE2yLkt8To82pg1BZwLaaT815aEsXns9HH1tdamuyYm37UU0h/HCwEUSW/SnD3S6TAc3f
	IWpKcXSUsW3U5+gWH5FjGBIG3HtfokGHZrHi8bVQ=
X-Gm-Gg: ASbGnctFkS0eS25lHBdD8I4AsBb2/3GY0gWjq6wAGmEBJRleD2QYBYQgczONhBLX1QH
	gzqbjy41dI6R/LhBvnQaV2DYygVHZzBXjvbgDbgJPQ8nqgLptNZSR6BfHiyWRYsB9Ukhv421h8l
	8ZIzSXL7Z+WCmhtT00i+5TTl6pAQ+B3SM3uaSkqTHQM8Q=
X-Google-Smtp-Source: AGHT+IEaARxavidgM+TFZgqBG7cpbQgDKBsYh10Av0i7R5BdBXuLQsJCltY3uTQQWI54B9tKm0liDJu2nBCuN+SgXnY=
X-Received: by 2002:a05:6512:15a9:b0:553:34d6:d67d with SMTP id
 2adb3069b0e04-55366c3598dmr4672575e87.46.1749560161340; Tue, 10 Jun 2025
 05:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0KDRg9GB0LvQsNC9INCh0LXQvNGH0LXQvdC60L4=?= <uncleruc2075@gmail.com>
Date: Tue, 10 Jun 2025 15:55:50 +0300
X-Gm-Features: AX0GCFs0dTpEZyj7EKQqa1kRjzltokeeU8NaZfp8NEWAyXlCBqXInZY8RHDJqcc
Message-ID: <CAMxyDH0ewinM+H_+2msTMBF7zabk_WbGX3HDLpL88oL+jKN9=A@mail.gmail.com>
Subject: Potential negative index dereference in tools/bpf/bpf_jit_disasm.c
 due to unchecked readlink() return value
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Subject: Potential negative index dereference in
tools/bpf/bpf_jit_disasm.c due to unchecked readlink() return value

In tools/bpf/bpf_jit_disasm.c, function get_exec_path uses the return
value of readlink() as an array index without checking for negative
values. According to the man page, readlink() returns -1 on error.
Using this negative value as an array index (tpath[len] = 0;) causes
out-of-bounds memory access, which can lead to undefined behavior or a
crash.

Relevant code (lines 46-48):
len = readlink(path, tpath, size);
tpath[len] = 0;

If readlink() fails, len will be -1, resulting in tpath[-1] = 0;
There is no check for (len < 0) before using len as an index.

Proposed fix:
Add a check for (len < 0) after readlink(), and handle the error case
appropriately before using len as an index.

Suggested patch:
len = readlink(path, tpath, size);
if (len < 0) {
    tpath[0] = 0;
    free(path);
    return;
}
tpath[len] = 0;

