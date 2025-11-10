Return-Path: <bpf+bounces-74100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE04C493AD
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 21:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4210B3B067E
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 20:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFE32EC57F;
	Mon, 10 Nov 2025 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgWUEmMq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CFF2ED161
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806511; cv=none; b=MvBfTX6N/4kyC40whvB4pnTgF4z+0rEEy/wHc/jRXl65iH21rxkTqUal9VlqiYhnT1OLHUhN7dqqu5NLKmEfwNC9+4owTZb/NgTxkA+t769vqyinADUY8UwhO5L7YDQM7zJkaCWRf16+0OgQUfNmvNiCqoHl9TzWkiHrE6vA0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806511; c=relaxed/simple;
	bh=ezAGsPixhCY9lL5oR1RAQIqLwNE1Kiok0uHsrAdQT6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/DcNhrICZWXQ8+eRTBI9VDu59lXLFqS/UUen92DIZGlGCgYqkU6v8znoJ1b9PpZGFR51C/w0Nr1x+lREdwnDq5eD5ox7EmqdM3VwgUaBnPYTVY/esXhbQ+1I/Ryl+ooXL4FgMKVNV6m6up7fM/1tsxXuSBbtsLHlmi6i1Hn7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgWUEmMq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29555415c5fso43279115ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762806509; x=1763411309; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W+WbStAV7UErTOQLyOB8k5FfQFyonGQs1pTJyoSdhIY=;
        b=dgWUEmMqUV6ht7BdBi5Ok08sjsTCUxTkY0dB6ivzvg0RnM6L+1eDjJ1ahBvILYDaPu
         2+IVZvQyC0X68svn7QgBwio//tTPi1gTIHgNKsjok6g1NG0maCSrPK55ZKbyigPePIiP
         QsQyRKDIWC7HIJr+1WmrHnFnISGej3wO/LlTy6BM+5tUxNg3xl7rzL1WlwEbrQ0U1bOV
         7DE3mvPTwIWkLk3V2F3TJN4zJnIkeqEWk2TLYtMnNsCilLPqTbmeQ5c0eA0llwvRh608
         gjSRrkRzL2C+tAK99p+wmFbyWSSZwTjy05J0e9QzgGyMWhkrq1SWzSeeWXQ7QdZH2mCD
         ovWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806509; x=1763411309;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W+WbStAV7UErTOQLyOB8k5FfQFyonGQs1pTJyoSdhIY=;
        b=c5fqPEXCB/X+4o1VoMiGwKUO470fY0p2hAKJPROIdJXy6sK0SzvPaMowicl1/VwuKf
         Y8CSFiAX5Bv75d5WMduCPILOxukgmTXi71E9LNyymN4N1VKTUxvC6ZImuBnbaHjqq/+V
         2coRzRczpjap8KxzKHPD8h1Vbx7ALNp+F4kZ3Mx19omnVkiLmiVXXWDEwY5CqkIxxQb5
         j7rkF/JzSztV/+41zzRb7xRH/zi+tUb8Wg0TDmvpsJnVXZF1siFfwzGdIgyGx7x+5+Di
         6+dAeX6ZCQzjt4Sp+5sRd7b9/Wg5z140ej3qQHKqb5zm7hcYe6MDYfTDb2fYRMOVqxrB
         O02A==
X-Forwarded-Encrypted: i=1; AJvYcCVfub9/f2cL1vN5YhHCEndA8dcS6rSENk8eGHgEZhZX5HNRA2etKLtmoIiFAq4wbzEBX6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMobIk39vTwNVqLO+15cq9P/x4NgbTlTpN9O2XsNiMRtN2TaQf
	AbPQn0BuUDxLbYQd4GhQ9Hu0fmKSuTt2htKeM0CmnEGCzpqUfjnHzuIo
X-Gm-Gg: ASbGncvMRiLWPKX1hwETJVnrJ+XuS5YjEdJdhgGrolKwoimDSHIKirwIRI0vJCP54at
	RRNLre9lbd6RJ4j11mopfUPUeM7mTVIlV4WQndup2Ab7JKR1Ic1CBh+iRjBfR4pyTxw9RLjRJTL
	gqBKhcxkV4BCmw81QH+QVHVkUF3FxdgqtQSgFHFsJKzDNU3mOnXXz2cawIkMy9otUx9E5rkcY7k
	oeACZI9GlcnH1hkvT3kVZtOeLfxQsNz5JWSDfLNkDTCH5eL1yuXrT6WeYQntujtO5VWzEcDm4nW
	6bf0GlyL3eH3RiXpsCMheGCCFAPmURSRAeUxKxtViZSXItNOVthsdFB4sV+34wamCXGq3a/Gb5R
	bVF1kGChwxWWnXrLL4d1N7R/Z2L3cbUtMmxsg06DbyLDheEV4tTzxYHd/9IuaigPvm8MgmZn0ax
	erYa6dsu5ak1oFzw79lBr50i112S3RNWI300Q=
X-Google-Smtp-Source: AGHT+IGUXwytfvl89PLJH0H9cFasertjxnCCAhlLgvyJes6C1zikRHPg+SU0zJuAoLbNHCiffFM2Jw==
X-Received: by 2002:a17:903:22c3:b0:295:82c6:dac3 with SMTP id d9443c01a7336-297e56b8a7amr144098525ad.32.1762806508698;
        Mon, 10 Nov 2025 12:28:28 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:5ff:e0da:7503:b2a7? ([2620:10d:c090:500::7:ecb1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5ce87sm154244275ad.29.2025.11.10.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:28:28 -0800 (PST)
Message-ID: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: properly verify tail call behavior
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Mon, 10 Nov 2025 12:28:27 -0800
In-Reply-To: <20251110151844.3630052-2-martin.teichmann@xfel.eu>
References: <998304ddd050ef81ce6281ebb88130e836c07fc3.camel@gmail.com>
	 <20251110151844.3630052-2-martin.teichmann@xfel.eu>
Content-Type: multipart/mixed; boundary="=-RfIk9z6VBBJC/M5M+HLT"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-RfIk9z6VBBJC/M5M+HLT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-11-10 at 16:18 +0100, Martin Teichmann wrote:

[...]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index a7240013fd9d..54f4772d990c 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -500,6 +500,10 @@ bpf_insn_successors(struct bpf_verifier_env *env, u3=
2 idx)
>  	if (opcode_info->can_jump)
>  		succ->items[succ->cnt++] =3D idx + bpf_jmp_offset(insn) + 1;
> =20
> +	if (unlikely(insn->code =3D=3D (BPF_JMP | BPF_CALL) && insn->src_reg =
=3D=3D 0
> +		     && insn->imm =3D=3D BPF_FUNC_tail_call))
> +		succ->items[succ->cnt++] =3D idx;
> +
>  	return succ;
>  }
> =20

Hi Martin,

This is a clever hack and I like it, but let's not do that.
It is going to be a footgun if e.g. someone would use
bpf_insn_successors() to build intra-procedural CFG.
Instead, please allocate a jt object for tail calls as in the diff
attached (on top of your patch-set). Please also extend
compute_live_registers.c to cover this logic.

Other than that, I think that patch logic and tests are fine.

Thanks,
Eduard

[...]

--=-RfIk9z6VBBJC/M5M+HLT
Content-Disposition: attachment; filename="tail-call-jt.patch"
Content-Type: text/x-patch; name="tail-call-jt.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYnBmX3ZlcmlmaWVyLmggYi9pbmNsdWRlL2xpbnV4
L2JwZl92ZXJpZmllci5oCmluZGV4IDU0NDEzNDFmMWFiOS4uOGQwYjYwZmE1ZjJiIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L2JwZl92ZXJpZmllci5oCisrKyBiL2luY2x1ZGUvbGludXgvYnBm
X3ZlcmlmaWVyLmgKQEAgLTUyNyw3ICs1MjcsNiBAQCBzdHJ1Y3QgYnBmX2luc25fYXV4X2RhdGEg
ewogCQlzdHJ1Y3QgewogCQkJdTMyIG1hcF9pbmRleDsJCS8qIGluZGV4IGludG8gdXNlZF9tYXBz
W10gKi8KIAkJCXUzMiBtYXBfb2ZmOwkJLyogb2Zmc2V0IGZyb20gdmFsdWUgYmFzZSBhZGRyZXNz
ICovCi0JCQlzdHJ1Y3QgYnBmX2lhcnJheSAqanQ7CS8qIGp1bXAgdGFibGUgZm9yIGdvdG94IGlu
c3RydWN0aW9uICovCiAJCX07CiAJCXN0cnVjdCB7CiAJCQllbnVtIGJwZl9yZWdfdHlwZSByZWdf
dHlwZTsJLyogdHlwZSBvZiBwc2V1ZG9fYnRmX2lkICovCkBAIC01NTAsNiArNTQ5LDcgQEAgc3Ry
dWN0IGJwZl9pbnNuX2F1eF9kYXRhIHsKIAkJLyogcmVtZW1iZXIgdGhlIG9mZnNldCBvZiBub2Rl
IGZpZWxkIHdpdGhpbiB0eXBlIHRvIHJld3JpdGUgKi8KIAkJdTY0IGluc2VydF9vZmY7CiAJfTsK
KwlzdHJ1Y3QgYnBmX2lhcnJheSAqanQ7CS8qIGp1bXAgdGFibGUgZm9yIGdvdG94IG9yIGJwZl90
YWlsY2FsbCBjYWxsIGluc3RydWN0aW9uICovCiAJc3RydWN0IGJ0Zl9zdHJ1Y3RfbWV0YSAqa3B0
cl9zdHJ1Y3RfbWV0YTsKIAl1NjQgbWFwX2tleV9zdGF0ZTsgLyogY29uc3RhbnQgKDMyIGJpdCkg
a2V5IHRyYWNraW5nIGZvciBtYXBzICovCiAJaW50IGN0eF9maWVsZF9zaXplOyAvKiB0aGUgY3R4
IGZpZWxkIHNpemUgZm9yIGxvYWQgaW5zbiwgbWF5YmUgMCAqLwpAQCAtNjUyLDYgKzY1Miw3IEBA
IHN0cnVjdCBicGZfc3VicHJvZ19pbmZvIHsKIAl1MzIgc3RhcnQ7IC8qIGluc24gaWR4IG9mIGZ1
bmN0aW9uIGVudHJ5IHBvaW50ICovCiAJdTMyIGxpbmZvX2lkeDsgLyogVGhlIGlkeCB0byB0aGUg
bWFpbl9wcm9nLT5hdXgtPmxpbmZvICovCiAJdTMyIHBvc3RvcmRlcl9zdGFydDsgLyogVGhlIGlk
eCB0byB0aGUgZW52LT5jZmcuaW5zbl9wb3N0b3JkZXIgKi8KKwl1MzIgZXhpdF9pZHg7IC8qIElu
ZGV4IG9mIG9uZSBvZiB0aGUgQlBGX0VYSVQgaW5zdHJ1Y3Rpb25zIGluIHRoaXMgc3VicHJvZ3Jh
bSAqLwogCXUxNiBzdGFja19kZXB0aDsgLyogbWF4LiBzdGFjayBkZXB0aCB1c2VkIGJ5IHRoaXMg
ZnVuY3Rpb24gKi8KIAl1MTYgc3RhY2tfZXh0cmE7CiAJLyogb2Zmc2V0cyBpbiByYW5nZSBbc3Rh
Y2tfZGVwdGggLi4gZmFzdGNhbGxfc3RhY2tfb2ZmKQpAQCAtNjY5LDkgKzY3MCw5IEBAIHN0cnVj
dCBicGZfc3VicHJvZ19pbmZvIHsKIAlib29sIGtlZXBfZmFzdGNhbGxfc3RhY2s6IDE7CiAJYm9v
bCBjaGFuZ2VzX3BrdF9kYXRhOiAxOwogCWJvb2wgbWlnaHRfc2xlZXA6IDE7CisJdTggYXJnX2Nu
dDozOwogCiAJZW51bSBwcml2X3N0YWNrX21vZGUgcHJpdl9zdGFja19tb2RlOwotCXU4IGFyZ19j
bnQ7CiAJc3RydWN0IGJwZl9zdWJwcm9nX2FyZ19pbmZvIGFyZ3NbTUFYX0JQRl9GVU5DX1JFR19B
UkdTXTsKIH07CiAKZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvbGl2ZW5lc3MuYyBiL2tlcm5lbC9i
cGYvbGl2ZW5lc3MuYwppbmRleCA1NGY0NzcyZDk5MGMuLjYwZGI1ZDY1NTQ5NSAxMDA2NDQKLS0t
IGEva2VybmVsL2JwZi9saXZlbmVzcy5jCisrKyBiL2tlcm5lbC9icGYvbGl2ZW5lc3MuYwpAQCAt
NDgyLDExICs0ODIsMTIgQEAgYnBmX2luc25fc3VjY2Vzc29ycyhzdHJ1Y3QgYnBmX3ZlcmlmaWVy
X2VudiAqZW52LCB1MzIgaWR4KQogCXN0cnVjdCBicGZfcHJvZyAqcHJvZyA9IGVudi0+cHJvZzsK
IAlzdHJ1Y3QgYnBmX2luc24gKmluc24gPSAmcHJvZy0+aW5zbnNpW2lkeF07CiAJY29uc3Qgc3Ry
dWN0IG9wY29kZV9pbmZvICpvcGNvZGVfaW5mbzsKLQlzdHJ1Y3QgYnBmX2lhcnJheSAqc3VjYzsK
KwlzdHJ1Y3QgYnBmX2lhcnJheSAqc3VjYywgKmp0OwogCWludCBpbnNuX3N6OwogCi0JaWYgKHVu
bGlrZWx5KGluc25faXNfZ290b3goaW5zbikpKQotCQlyZXR1cm4gZW52LT5pbnNuX2F1eF9kYXRh
W2lkeF0uanQ7CisJanQgPSBlbnYtPmluc25fYXV4X2RhdGFbaWR4XS5qdDsKKwlpZiAodW5saWtl
bHkoanQpKQorCQlyZXR1cm4ganQ7CiAKIAkvKiBwcmUtYWxsb2NhdGVkIGFycmF5IG9mIHNpemUg
dXAgdG8gMjsgcmVzZXQgY250LCBhcyBpdCBtYXkgaGF2ZSBiZWVuIHVzZWQgYWxyZWFkeSAqLwog
CXN1Y2MgPSBlbnYtPnN1Y2M7CkBAIC01MDAsMTAgKzUwMSw2IEBAIGJwZl9pbnNuX3N1Y2Nlc3Nv
cnMoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgdTMyIGlkeCkKIAlpZiAob3Bjb2RlX2lu
Zm8tPmNhbl9qdW1wKQogCQlzdWNjLT5pdGVtc1tzdWNjLT5jbnQrK10gPSBpZHggKyBicGZfam1w
X29mZnNldChpbnNuKSArIDE7CiAKLQlpZiAodW5saWtlbHkoaW5zbi0+Y29kZSA9PSAoQlBGX0pN
UCB8IEJQRl9DQUxMKSAmJiBpbnNuLT5zcmNfcmVnID09IDAKLQkJICAgICAmJiBpbnNuLT5pbW0g
PT0gQlBGX0ZVTkNfdGFpbF9jYWxsKSkKLQkJc3VjYy0+aXRlbXNbc3VjYy0+Y250KytdID0gaWR4
OwotCiAJcmV0dXJuIHN1Y2M7CiB9CiAKZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIu
YyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwppbmRleCA3YTgxNzc3N2ZiYjMuLmRjMTI5YTU5NzE4
YiAxMDA2NDQKLS0tIGEva2VybmVsL2JwZi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9icGYvdmVy
aWZpZXIuYwpAQCAtMzUyOCw4ICszNTI4LDEyIEBAIHN0YXRpYyBpbnQgY2hlY2tfc3VicHJvZ3Mo
c3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudikKIAkJCXN1YnByb2dbY3VyX3N1YnByb2ddLmhh
c19sZF9hYnMgPSB0cnVlOwogCQlpZiAoQlBGX0NMQVNTKGNvZGUpICE9IEJQRl9KTVAgJiYgQlBG
X0NMQVNTKGNvZGUpICE9IEJQRl9KTVAzMikKIAkJCWdvdG8gbmV4dDsKLQkJaWYgKEJQRl9PUChj
b2RlKSA9PSBCUEZfRVhJVCB8fCBCUEZfT1AoY29kZSkgPT0gQlBGX0NBTEwpCisJCWlmIChCUEZf
T1AoY29kZSkgPT0gQlBGX0NBTEwpCiAJCQlnb3RvIG5leHQ7CisJCWlmIChCUEZfT1AoY29kZSkg
PT0gQlBGX0VYSVQpIHsKKwkJCXN1YnByb2dbY3VyX3N1YnByb2ddLmV4aXRfaWR4ID0gaTsKKwkJ
CWdvdG8gbmV4dDsKKwkJfQogCQlvZmYgPSBpICsgYnBmX2ptcF9vZmZzZXQoJmluc25baV0pICsg
MTsKIAkJaWYgKG9mZiA8IHN1YnByb2dfc3RhcnQgfHwgb2ZmID49IHN1YnByb2dfZW5kKSB7CiAJ
CQl2ZXJib3NlKGVudiwgImp1bXAgb3V0IG9mIHJhbmdlIGZyb20gaW5zbiAlZCB0byAlZFxuIiwg
aSwgb2ZmKTsKQEAgLTE4MTIwLDYgKzE4MTI0LDI1IEBAIHN0YXRpYyBpbnQgdmlzaXRfZ290b3hf
aW5zbihpbnQgdCwgc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudikKIAlyZXR1cm4ga2VlcF9l
eHBsb3JpbmcgPyBLRUVQX0VYUExPUklORyA6IERPTkVfRVhQTE9SSU5HOwogfQogCitzdGF0aWMg
aW50IHZpc2l0X3RhaWxjYWxsX2luc24oc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50
IHQpCit7CisJc3RhdGljIHN0cnVjdCBicGZfc3VicHJvZ19pbmZvICpzdWJwcm9nOworCXN0cnVj
dCBicGZfaWFycmF5ICpqdDsKKworCWlmIChlbnYtPmluc25fYXV4X2RhdGFbdF0uanQpCisJCXJl
dHVybiAwOworCisJanQgPSBpYXJyYXlfcmVhbGxvYyhOVUxMLCAyKTsKKwlpZiAoIWp0KQorCQly
ZXR1cm4gLUVOT01FTTsKKworCXN1YnByb2cgPSBicGZfZmluZF9jb250YWluaW5nX3N1YnByb2co
ZW52LCB0KTsKKwlqdC0+aXRlbXNbMF0gPSB0ICsgMTsKKwlqdC0+aXRlbXNbMV0gPSBzdWJwcm9n
LT5leGl0X2lkeDsKKwllbnYtPmluc25fYXV4X2RhdGFbdF0uanQgPSBqdDsKKwlyZXR1cm4gMDsK
K30KKwogLyogVmlzaXRzIHRoZSBpbnN0cnVjdGlvbiBhdCBpbmRleCB0IGFuZCByZXR1cm5zIG9u
ZSBvZiB0aGUgZm9sbG93aW5nOgogICogIDwgMCAtIGFuIGVycm9yIG9jY3VycmVkCiAgKiAgRE9O
RV9FWFBMT1JJTkcgLSB0aGUgaW5zdHJ1Y3Rpb24gd2FzIGZ1bGx5IGV4cGxvcmVkCkBAIC0xODE4
MCw2ICsxODIwMyw4IEBAIHN0YXRpYyBpbnQgdmlzaXRfaW5zbihpbnQgdCwgc3RydWN0IGJwZl92
ZXJpZmllcl9lbnYgKmVudikKIAkJCQltYXJrX3N1YnByb2dfbWlnaHRfc2xlZXAoZW52LCB0KTsK
IAkJCWlmIChicGZfaGVscGVyX2NoYW5nZXNfcGt0X2RhdGEoaW5zbi0+aW1tKSkKIAkJCQltYXJr
X3N1YnByb2dfY2hhbmdlc19wa3RfZGF0YShlbnYsIHQpOworCQkJaWYgKGluc24tPmltbSA9PSBC
UEZfRlVOQ190YWlsX2NhbGwpCisJCQkJdmlzaXRfdGFpbGNhbGxfaW5zbihlbnYsIHQpOwogCQl9
IGVsc2UgaWYgKGluc24tPnNyY19yZWcgPT0gQlBGX1BTRVVET19LRlVOQ19DQUxMKSB7CiAJCQlz
dHJ1Y3QgYnBmX2tmdW5jX2NhbGxfYXJnX21ldGEgbWV0YTsKIAo=


--=-RfIk9z6VBBJC/M5M+HLT--

