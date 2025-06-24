Return-Path: <bpf+bounces-61363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0287CAE62D1
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 12:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C018178C4C
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53899284684;
	Tue, 24 Jun 2025 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhwIBDuQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C427C872
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762028; cv=none; b=GjkKysLrJ0nN5sAVLV0OAJIuzBnEsxhXcwoJ816mLmFrRhUHGQ0XWg5QJip1J1yzZKdA4CWZKWFQQnxRvro9o2Wv6PfhKmBZz1kzOwJBG18C5drInN2AQbSjaJNkW++C8+4PMKhB6lxYM8HoWY2R9M0wub6h/+12Lf820xUorhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762028; c=relaxed/simple;
	bh=pWMh+gmzgsoCLb7uZ3otl/ts1ZfTy1LwkGcF/o2+wLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGv4L8erbxvOiv+j+LaXgu03aQYq+vwpY1rN2ozojHjkD2H29IEP2ynL32fLgHfzIdVF4uQ4PR7f+BfN/knZ4sXbhq7UvVdgCft/Qs1IpBzUcm/bA1ytJK/zBvaKEQQzQvB0zycbn5mNmtugLloOhSpvV0SpKOE0/14AjqVwuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhwIBDuQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750762024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=telMZ0Cpf+xviYkUandhCi68eDLzV2tREu5k8iPn984=;
	b=IhwIBDuQ3y6Dgt+oWSY2DApZLbsTWZQNPu0HS4TewRqs+BAvx8vQSREKcmDKQ5eSJLzIe2
	e96tTZC/1mADqpeXp2/ADOyC2O0KV/Dy9EGGORBT5D8Wlsv/n/9gywtBRnnP1NB8CnogLG
	2bvjRpXmJEobZpBFGKHxKS++Kr0F0ko=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-ZHzOFRGHObS1o28bnThZSA-1; Tue, 24 Jun 2025 06:47:02 -0400
X-MC-Unique: ZHzOFRGHObS1o28bnThZSA-1
X-Mimecast-MFC-AGG-ID: ZHzOFRGHObS1o28bnThZSA_1750762022
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso174803f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750762021; x=1751366821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=telMZ0Cpf+xviYkUandhCi68eDLzV2tREu5k8iPn984=;
        b=Kk1OHU+iJ96eoZXXW9QKpbyuWyhewqpCyhq/+O2jQbi/+ZbeKHaw8hyARWBvowhxTQ
         6Qg0blae9RaVR2kpRkLDB7vSw0VhqBLrk3MFUcshAKP/nLW+TXaID/j8DTqvIhRPbB04
         qT9j/Rc6ZcUots2Er+9mGpYSw4/DcIWrjpNOBmHJEVQZdPY0+6z2LT3+UxggbE3GMRNW
         6LJY/q/CqBFQhXbfbokvYpGNWGHfSx9glbNyOJ/WZcVfoZmVOg2HvFNTszkYltlcwV9Z
         mmIuai0Tp6kXfGF49slWhweuTRnZX4Y/kmwQ2480nfEqE7iqKqCiOeHNRLkxyjRwhQuL
         dRcA==
X-Gm-Message-State: AOJu0YxbMCwXpbh/zwXl45cuy3F4dB0z7AyLpCEOWtnvqdXA5VcqGHa0
	/lU7g8ZclxVCb1cOVSms/blpyWiBh4C99e2OcJC1n3XCxAu25PpqJUs6w5r9L5VHcJR3vF/VfJl
	/5tBIhIPD/kPKfXAIavxErzS4D4+RJMIf6ZkX4oi2nkxbG28ldWJa
X-Gm-Gg: ASbGncuqpiwZzdkNo/91g3eNOrzU42cD8XSjaFvt5X3TUhgJriiTqN4cD+rBVyXtZNy
	BU8Hz7bvk+72DelBrtVtQo9kltBFu47DEOszXaDFbxud6D3FsnyRNL/jtVObscx8gmZPyid9lpT
	2iF0eGgVZVj7AuZCSw/Pk6DmBotPiqkOyCZH1O07soT695f9MRvUTpPIm9jKrafytzEIDe/PXkN
	molWIBb7W832RI8M9LCWJc1UYJ+A+JyssmbtP+I7N68wogcj8VWmP5WZWgrXLLfytCoxPBBuUp+
	Hq3Umb9kP6MRysNFgZ3mtEdqfiS/+rjOxuDQTQmBqs3+P+EAfmKvpBGq
X-Received: by 2002:a5d:5c84:0:b0:3a4:f722:f98d with SMTP id ffacd0b85a97d-3a6d12ea2b6mr12520921f8f.51.1750762021423;
        Tue, 24 Jun 2025 03:47:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlmQLD7y5GsT4Xmm7Fl3/gymQ31rrlDW4X6VyvzSeWnWYaPAFzWdt+MCLDLGp4tisVL9tFmQ==
X-Received: by 2002:a5d:5c84:0:b0:3a4:f722:f98d with SMTP id ffacd0b85a97d-3a6d12ea2b6mr12520888f8f.51.1750762020979;
        Tue, 24 Jun 2025 03:47:00 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f67c4sm1638895f8f.62.2025.06.24.03.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 03:47:00 -0700 (PDT)
Message-ID: <64d72c33-51b5-49a9-9555-da2130efaa35@redhat.com>
Date: Tue, 24 Jun 2025 12:46:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 2/4] bpf: Add kfuncs for read-only string
 operations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <cover.1750681829.git.vmalik@redhat.com>
 <1b75082af9f349a0c20aa49a47d003fc1b81e5f5.1750681829.git.vmalik@redhat.com>
 <CAEf4BzYxZkwBQJncHRw9KQCrPcCs9L3h-6szgKLiT=QPErPzqw@mail.gmail.com>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <CAEf4BzYxZkwBQJncHRw9KQCrPcCs9L3h-6szgKLiT=QPErPzqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/23/25 23:29, Andrii Nakryiko wrote:
> On Mon, Jun 23, 2025 at 6:48 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> String operations are commonly used so this exposes the most common ones
>> to BPF programs. For now, we limit ourselves to operations which do not
>> copy memory around.
>>
>> Unfortunately, most in-kernel implementations assume that strings are
>> %NUL-terminated, which is not necessarily true, and therefore we cannot
>> use them directly in the BPF context. Instead, we open-code them using
>> __get_kernel_nofault instead of plain dereference to make them safe and
>> limit the strings length to XATTR_SIZE_MAX to make sure the functions
>> terminate. When __get_kernel_nofault fails, functions return -EFAULT.
>> Similarly, when the size bound is reached, the functions return -E2BIG.
>> In addition, we return -ERANGE when the passed strings are outside of
>> the kernel address space.
>>
>> Note that thanks to these dynamic safety checks, no other constraints
>> are put on the kfunc args (they are marked with the "__ign" suffix to
>> skip any verifier checks for them).
>>
>> All of the functions return integers, including functions which normally
>> (in kernel or libc) return pointers to the strings. The reason is that
>> since the strings are generally treated as unsafe, the pointers couldn't
>> be dereferenced anyways. So, instead, we return an index to the string
>> and let user decide what to do with it. This also nicely fits with
>> returning various error codes when necessary (see above).
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  kernel/bpf/helpers.c | 389 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 389 insertions(+)
>>
> 
> few more comments below, beside the -ENOENT issue Alexei mentioned earlier
> 
> [...]
> 
>> +/**
>> + * bpf_strrchr - Find the last occurrence of a character in a string
>> + * @s__ign: The string to be searched
>> + * @c: The character to search for
>> + *
>> + * Return:
>> + * * >=0      - Index of the last occurrence of @c within @s__ign
>> + * * %-1      - @c not found in @s__ign
>> + * * %-EFAULT - Cannot read @s__ign
>> + * * %-E2BIG  - @s__ign is too large
>> + * * %-ERANGE - @s__ign is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strrchr(const char *s__ign, int c)
>> +{
>> +       char sc;
>> +       int i, last = -1;
>> +
>> +       if (!copy_from_kernel_nofault_allowed(s__ign, 1))
>> +               return -ERANGE;
>> +
>> +       guard(pagefault)();
>> +       for (i = 0; i < XATTR_SIZE_MAX; i++) {
>> +               __get_kernel_nofault(&sc, s__ign, char, err_out);
>> +               if (sc == '\0')
>> +                       return last;
>> +               if (sc == c)
>> +                       last = i;
> 
> swap these two ifs, so that bpf_strrchr("blah", 0) will still return a
> meaningful result (effectively become bpf_strlen(), of course)? That
> should match strrchr's behavior in libc, if I'm reading this
> correctly:
> 
> "The terminating NUL character is considered to be part of the string."

Yeah, that's correct, nice catch! I'll add a test for the above case.

> 
> 
>> +               s__ign++;
>> +       }
>> +       return -E2BIG;
>> +err_out:
>> +       return -EFAULT;
>> +}
>> +
> 
> [...]
> 
>> +/**
>> + * bpf_strspn - Calculate the length of the initial substring of @s__ign which
>> + *              only contains letters in @accept__ign
>> + * @s__ign: The string to be searched
>> + * @accept__ign: The string to search for
>> + *
>> + * Return:
>> + * * >=0      - The length of the initial substring of @s__ign which only
>> + *              contains letters from @accept__ign
>> + * * %-EFAULT - Cannot read one of the strings
>> + * * %-E2BIG  - One of the strings is too large
>> + * * %-ERANGE - One of the strings is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strspn(const char *s__ign, const char *accept__ign)
>> +{
>> +       char cs, ca;
>> +       bool found;
>> +       int i, j;
>> +
>> +       if (!copy_from_kernel_nofault_allowed(s__ign, 1) ||
>> +           !copy_from_kernel_nofault_allowed(accept__ign, 1)) {
>> +               return -ERANGE;
>> +       }
>> +
>> +       guard(pagefault)();
>> +       for (i = 0; i < XATTR_SIZE_MAX; i++) {
>> +               __get_kernel_nofault(&cs, s__ign, char, err_out);
>> +               if (cs == '\0')
>> +                       return i;
>> +               found = false;
>> +               for (j = 0; j < XATTR_SIZE_MAX; j++) {
>> +                       __get_kernel_nofault(&ca, accept__ign + j, char, err_out);
>> +                       if (cs == ca) {
>> +                               found = true;
>> +                               break;
>> +                       }
>> +                       if (ca == '\0')
>> +                               break;
>> +               }
>> +               if (!found)
>> +                       return i;
> 
> nit: you shouldn't need "found", just `ca == '\0'` would mean "not
> found", I think?
> 
> so you'd have a succinct `if (cs == ca || ca == '\0') break;` in the
> innermost loop

That sounds about right. We'll just need to cover the case when
`j == XATTR_SIZE_MAX` and return -E2BIG in such a case (which should
have been done anyways here and currently is not).

Also, an analogical thing can be done in bpf_strcspn.

> 
> 
>> +               s__ign++;
>> +       }
>> +       return -E2BIG;
>> +err_out:
>> +       return -EFAULT;
>> +}
>> +
> 
> [...]
> 
>> +/**
>> + * bpf_strnstr - Find the first substring in a length-limited string
>> + * @s1__ign: The string to be searched
>> + * @s2__ign: The string to search for
>> + * @len: the maximum number of characters to search
>> + *
>> + * Return:
>> + * * >=0      - Index of the first character of the first occurrence of @s2__ign
>> + *              within the first @len characters of @s1__ign
>> + * * %-1      - @s2__ign not found in the first @len characters of @s1__ign
>> + * * %-EFAULT - Cannot read one of the strings
>> + * * %-E2BIG  - One of the strings is too large
>> + * * %-ERANGE - One of the strings is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len)
>> +{
>> +       char c1, c2;
>> +       int i, j;
>> +
>> +       if (!copy_from_kernel_nofault_allowed(s1__ign, 1) ||
>> +           !copy_from_kernel_nofault_allowed(s2__ign, 1)) {
>> +               return -ERANGE;
>> +       }
>> +
>> +       guard(pagefault)();
>> +       for (i = 0; i < XATTR_SIZE_MAX; i++) {
>> +               for (j = 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
>> +                       __get_kernel_nofault(&c1, s1__ign + j, char, err_out);
> 
> move this after you check `c2 == 0` below? why reading this character
> if we are not going to compare it?

Good point, will move it.

> 
>> +                       __get_kernel_nofault(&c2, s2__ign + j, char, err_out);
>> +                       if (c2 == '\0')
>> +                               return i;
>> +                       if (c1 == '\0')
>> +                               return -1;
>> +                       if (c1 != c2)
>> +                               break;
>> +               }
>> +               if (j == XATTR_SIZE_MAX)
>> +                       return -E2BIG;
>> +               if (i + j == len)
>> +                       return -1;
>> +               s1__ign++;
>> +       }
>> +       return -E2BIG;
>> +err_out:
>> +       return -EFAULT;
>> +}
>> +
> 
> [...]

Thanks for the reviews!

I'll wait a couple more days for potential reviews for the other patches
before sending the next revision.

Viktor


