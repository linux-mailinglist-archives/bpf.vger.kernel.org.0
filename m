Return-Path: <bpf+bounces-56702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58B0A9CDDF
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE9D1BC6C0A
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D6190678;
	Fri, 25 Apr 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUFXhR4P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4A18C008
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597701; cv=none; b=uUebHBB9jv+qlCEDTTCwjdZ9gB9HqZMvL06/lI7G6PCuqMGAbn14/mT9xUXM2nCFnUq5uMSEYTJGyb42Ln6CQBXZYosP3DUfSa/4+GI9cHDEHiPRGbgK7wPsi0xz+4kK7r2uSAJQZXoiRRY873066Gg/5TL6Ha0UfYLnpQOOf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597701; c=relaxed/simple;
	bh=ajG4nwDNngWdcOyHXXVZuvidXfjnQHijAIk/MdwhRu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j09T7NUbAD4buadjDeMSdqoBCNsgFJbs4gLWPwaSS9HoItcJEMFk+6WNPslH2ssKINTD6067y831TziMwrjf6vaC5wV7wpXB2pjcwu3/pv2y2ercP+kewp8PZB6Q0Nd0h4TwWlEH+OGefQy3vr6tb8r8DiPQgs0tbakhpkfASxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUFXhR4P; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf257158fso14796445e9.2
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745597698; x=1746202498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajG4nwDNngWdcOyHXXVZuvidXfjnQHijAIk/MdwhRu4=;
        b=DUFXhR4PbJe0LBL5t2Aj4bEk4sBC1b/L0lMu2b3inXsrjTPX8iQHFqvNzApD6HUcWs
         x74Fpyhuy64/vrb0jVD2pJ3kdcfhcnlPuZ9/ifPC7YogJdBsE6nDb6+9ESYavd/05q14
         BDLr+UYxT4fyn2hvebakeVX3f4UA5j6DmoyuF+0YiQJICCjHNlbHVJBRHFDz2uchXDlm
         +S0Up8rxWQq2ZwUL+K45PItJQmdyHFa37IsnyfvY/usJB4uI99g129z4uXesbqikpivc
         19xEe7vyKYDKI470RCMEKevQN9InaOse7LQSsHe6UbKxQANzK8fX/4hiFUC+5mWU9Gmv
         DKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745597698; x=1746202498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajG4nwDNngWdcOyHXXVZuvidXfjnQHijAIk/MdwhRu4=;
        b=t8RA5XAJ0lEPKMzbN93OMlDg0TZhBjA4G5dQvCYQ8DLEGRHNp3XjC5NhCDGvSqgsCd
         xhsF2h5QwfvwILXD7xZMihzN+0q4AEsQAb5LBVWy+k0lpW903/7c4x3eRlMNH8sVyfv3
         XghkV+9nGTiOWTMZF+fwKiubodQ9/lPT/Mp0QmlS6BThumS9XsjQq7MSj8zfnsnCGc1B
         1WBvf4hTsRQC5+ifMKB1nn5V+BsLQSXjcjp0hRKjYkyOB1I/2GF8bnRGFDcEP6HqS9nr
         cix/AaOb8LuzvwJqOwHXcTI/aGjKFCARopvPfY7GrTuhzg/44TJAZFYov88WDGqQ9QkY
         jphg==
X-Forwarded-Encrypted: i=1; AJvYcCUKQc0XPA2kTpbiXS12h+f1GJQvLGNtcYj075FQgxG34/hEWer+ni2zb6sjJPvCXACGN9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdlkyTbqRi+7virseoFPqSVtkGoyUcb5pje/OHRujiUQHyA9j/
	6CDA5opxQSGsbS7+9kBkrAZ4+pbGMxoSh4vblo6kan+mSkHlwo/yulKjqGqS8Cs4sf6slMDaqYg
	cg45vBinVCe6+tRkwEb60LncSnOQ=
X-Gm-Gg: ASbGncscc84dderJbQZukSaTHGRJHxUg/1hf4GAZxFVKnlqWG7cBq5a6vVl8vXANXZE
	DcSqwDZixxHJHB+jJhsvZAxMDEm6vVePl0jrvQL92242QXgqi5xzo0AlM2Bzzg1psQGMk6enDtk
	gkkIuazoAjb4I+WIxI1frl2O9MLq+LAOUSFY8glw==
X-Google-Smtp-Source: AGHT+IEj9knzaaKb2khplkqK4OqVnfuF2JSUWQTNSXdRfs8HjQsrShnbenlsNuHXWc6ZvfZlAz0xIlFh0YUmGi+/wac=
X-Received: by 2002:a05:6000:18ac:b0:390:fbcf:56be with SMTP id
 ffacd0b85a97d-3a074d8efd4mr2558702f8f.0.1745597697850; Fri, 25 Apr 2025
 09:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424153246.141677-1-brandon.kammerdiener@intel.com> <dbfd7b7c-4367-f0ee-c5f9-e488fc6a6f86@huaweicloud.com>
In-Reply-To: <dbfd7b7c-4367-f0ee-c5f9-e488fc6a6f86@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Apr 2025 09:14:47 -0700
X-Gm-Features: ATxdqUHAS3NtOc217vD1eboRAh9tqq5LlkPIPyPA-k4pVhmParyg8f8JhDr9pwM
Message-ID: <CAADnVQ+9RaRz_JcpHN2rnjCLK=+-DtXfF3Qo5QariRsOmN=gsQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf 0/2] bpf: Fix softlock condition in BPF hashmap interation
To: Hou Tao <houtao@huaweicloud.com>
Cc: Brandon Kammerdiener <brandon.kammerdiener@intel.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 5:50=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
>
> On 4/24/2025 11:32 PM, Brandon Kammerdiener wrote:
> > Hi,
> >
> > This patchset fixes an endless loop condition that can occur in
> > bpf_for_each_hash_elem, causing the core to softlock. My understanding =
is
> > that a combination of RCU list deletion and insertion introduces the ne=
w
> > element after the iteration cursor and that there is a chance that an R=
CU
> > reader may in fact use this new element in iteration. The patch uses a
> > _safe variant of the macro which gets the next element to iterate befor=
e
> > executing the loop body for the current element.
> >
> > I have also added a subtest in the for_each selftest that can trigger t=
his
> > condition without the fix.
> >
> > Changes since v2:
> > - Renaming and additional checks in selftests/bpf/prog_tests/for_each.c
> >
> > Changes since v1:
> > - Added missing Signed-off-by lines to both patches
> >
> > Thanks,
> > Brandon Kammerdiener
>
> Acked-by: Hou Tao <houtao1@huawei.com>

Applied. Thanks

