Return-Path: <bpf+bounces-51961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BD5A3C37B
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FB3162FCB
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A91F30BE;
	Wed, 19 Feb 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="gtDuF2g7"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBDB85C5E
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978499; cv=none; b=OIRMpVfvkBd4ZyQsqwgY1ka+hbx8dJyOwXUU7K/FoUtHx6UZt9KaEbjFtJzi/N4Xx7r22hXP7tctIj6/9WS7/v9vl19vFJ49Vt4Vr2pA6FqqEjo8cvQ4E0WiOaQlT77BoM+9xLQINQjIMmxP3TCc6r7GoyYIphDN3oqkxljAvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978499; c=relaxed/simple;
	bh=sK+MecelaSnVojmlopjXkf2BHHSFjPEj5E1bFoKG9Xo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qNswHZO7KKIbioZZoQZxRoBmIRMLbIfjcfPMzIrE8XnPolt4Dv0psu1I7JxEYX1/FSZ8GGy8LWQbyB5xThsYTAHC5kAgI2bW2tevgosmnVRN38JwJUzQsBmMkp2qKlrCmbMnAb72fe4ot7ShZEyHYuk8+koPR2jShtue5T2uEGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=gtDuF2g7; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [192.168.29.70] (unknown [49.47.194.30])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id E528943581
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1739978036;
	bh=sK+MecelaSnVojmlopjXkf2BHHSFjPEj5E1bFoKG9Xo=;
	h=Date:To:From:Subject:From;
	b=gtDuF2g7v5bnnaC38C3ai1HtTuqPrerSNDlmQG6ShVrfspi5uaFp6TqOtcTsOYfkR
	 NTjVI9B70++3IF9Ex8ws+JO7J/bwcqcEJUQjNnxnV/3kTGX76WWmFaHQk/MEMpohNg
	 Dq9P2AD6gU+3j3qvLQKUCfQI8F3CKQoRWixO1Gz3zBxFoYqHP9qAvmcaVvO5xzDk7J
	 /q/c36XHh629EbeLAqLaxHLkgtjtu/ATO56hzSaSaSDo7zuczxeuPs0+Q5lhd82hie
	 izC4Ps7PgcFwThQObh8FSTcn7qM6xbOPScOBuG/Y8CVnu5JFJ5dRDCrlLAZquvwrSM
	 6uwd3j3grzJnA==
Message-ID: <fd84552e-be67-4a01-9d08-903e9481b8d3@nandakumar.co.in>
Date: Wed, 19 Feb 2025 20:43:53 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org
Content-Language: en-US
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: Out-of-bound read suspected in libbpf.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I think I've come across an out-of-bound read in libbpf.c that could 
result in
potential information leak (or crash). I wanted to test it myself, but
unfortunately it will take a while for me to set up things. So, let me just
describe it and submit a candidate patch.

Codebase at: commit 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2 (HEAD -> 
master, origin/master, origin/HEAD)
File: ./tools/lib/bpf/libbpf.c
Function: set_kcfg_value_str

The first subscripted read of `value` (which is untrusted, IIUC) at line 
2108
(`value[len - 1]`) is safe because `set_kcfg_value_str` is called only after
making sure `value` is at least one character long (although not a good 
practice
in long-term). The problem is at the strip-quotes part. Here, `len -= 2` is
performed, possibly thinking `value` is at least two characters long, 
since the
caller makes sure `value` has an opening quote and this function
(`set_kcfg_value_str) has a check `if (value[len - 1] != '"')` for the 
closing
quote. But the problem is, both the opening and closing quotes could be the
same. More specifically, `value` could be a string that consists of a single
quote alone, and it could pass all these tests. Then `len` underflows, 
resulting
in a wrap-around since it is of type `size_t`. The next branch
`if (len >= ext->kcfg.sz)` will possibly reduce the value of `len`, but will
still be greater than `strlen(value)`, making `memcpy()` at 2122 read
out-of-bound.

Suggested change:

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..1cc87dbd015d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2106,7 +2106,7 @@ static int set_kcfg_value_str(struct extern_desc 
*ext, char *ext_val,
         }

         len = strlen(value);
-       if (value[len - 1] != '"') {
+       if (len < 2 || value[len - 1] != '"') {
                 pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
                         ext->name, value);
                 return -EINVAL;

-- 
Nandakumar Edamana
https://nandakumar.org/


