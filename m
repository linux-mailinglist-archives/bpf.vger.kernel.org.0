Return-Path: <bpf+bounces-63043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A6CB01A7A
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 13:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C76544BA3
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ACC28B3F9;
	Fri, 11 Jul 2025 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEqSFbhz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B419AD8C;
	Fri, 11 Jul 2025 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233000; cv=none; b=hltDgFRVBdkFwQmEaNVwSUCZ08MNYHSZR73D2+sLFag4NdyVmNNUj4yt4rl0eRoxMnze9lIhi4TZUXbhkytQvAc8zJ1gVVc4LebkNy8fS2jiGDcmYMVDX+MWZIjVx68iXzd4lT6IGzJVz8kPdCjCv8F+9x8GbpXK50kfr4O/W0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233000; c=relaxed/simple;
	bh=OMVuEmDxzZCXI78mojqEh51ytfJrgtcAr6VBFnOKOgc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObGjyvKMfp5c1cTWYwKtvBqmgmxnj/1dD3xZ4NwtvZKdOS9Wg84jPovzeETgcPhIm/IqYusDFvBSJK7PTUBKPXbtGXPhp/862gxMbIByfFuAkoS9O/Clc7fbxiJZoIdIxXC20NTu2JR1zxyhov2f82w9kzBMosHBOs6XMeYPsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEqSFbhz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1961349f8f.1;
        Fri, 11 Jul 2025 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752232996; x=1752837796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WHQ+J6Q4GLKylcYn0MFWaymjhVa4lKlyfoVQHjL1UDY=;
        b=fEqSFbhzgx/qEy6Li+qgGEJ2FIGZXuF8VSXa0UAE0sKsZtdD3SUkncc4h+B49aDK8U
         2r1ceLcTWiVeganT9McK7bajVRAKcfiuRxvCwLI+KvokmezPlM56cDpjfZBXHdkptgGC
         7XXxKlxvqjTpUfqqBwG7Jg2EB+Ja5xfoH5CdWLgfNzWhFYpgud6/nB3GHT0iT/sv0cHe
         7Ob8zR2m5uKjj+mr8mSEo4r4Sek/d7u0Zbajn2OSKswfgW+0uUw44ggi2x/hY1cvUf0X
         B/1L8EBqphhljD8T1VGXC8iMoC92JEiAaktX/1p4CkiTA6jva2nj9kOhRh2UclRLI187
         bzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752232996; x=1752837796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHQ+J6Q4GLKylcYn0MFWaymjhVa4lKlyfoVQHjL1UDY=;
        b=wikW39BCCfgw2LddLmU6a5URCKw1eyIWFfPv6x9hO0PLBScsoymF2yZljXxarxzIJU
         qnrEyuwEoY/hvca7P9jtVwcIlz295NqagsaOGZIORwnFcXYIkp82ZGhVaKhHh+H3nhrC
         OYLfO9G5s5amW/V/BMIlo/lwAZtV9uvKfaaZdRSUYBodMkJKNNG+K9WurjLA91d2mnMv
         skI6oZngTgUNGKHODSZz2YwqiWIjD1yuQn7/MOjKNc7zAzWLtNzDCOXAnv/fThVUmCtX
         SHf8+xo5YNP3rgZh4rlCqFgGFQKFe2K28s/MLKn6lTCapkcT4hu1wWW5Vql0KEQv8FZ7
         pD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUt3rjLBEbv90dxqQamoybT8uMULl++20RR34H0CgRn7UaZmImTb03bv7yup2OzxV/k0NDAaH8UsreszXf7@vger.kernel.org, AJvYcCXmxaMJbS0xwuVkJFijd8cnjtV7Tx06O305hLuEPxcaocbJWvR/te72j9vdf2VYedy+X8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDred66QJAceC/QK94gJ3K3eTrrnrr5sVo9GqghBhsKoVkDv44
	GtdtHIpueUUqQmdCW/ZLn3iv0WfRQgSjZPrBtZqKH+xCwmiN/392GLuFA/ltw1FL
X-Gm-Gg: ASbGncvMT/YGTGGUPedZjInCrpFP9NrZXVBFHBZYjuB4UfD2MHexR2HjhK1Y/7pUttb
	1ssKQcu4XaW3TTAJ2LdJgNO6PFAhfMQTPNicQ30EDS3zKC+hLiSOFDr3hUw9Yeq6cMpbFu1vm1A
	jibi/mLVN4se4WobLb5S4JBvVzsPu5vvdJxWLNtIy6lqbcJ8HrGFv4CIE2lsn16ZSNVNoULnuP5
	6yABR5QSRlI2vbZWZGVBU+sHTZSxY2VLfgvdxKZyLvTeMsk3a/AipalhEt9O/ti5wBXm7sJEcva
	b9qntnzhPbMQJMqQJiZovobMw0kr28EBdOi9XyDF0zsY6VcaFLEoVCWR6ixwnQk/oblgUKfj
X-Google-Smtp-Source: AGHT+IFXXPCa5h7bj4LIgBRu0wEHnGZE6DwBURGztIO77wwKVjfZW6OK12U7uEWevxZRnWFNLwOHxA==
X-Received: by 2002:a05:6000:230c:b0:3a4:f7ae:77c9 with SMTP id ffacd0b85a97d-3b5f1c67bb3mr2395292f8f.5.1752232995743;
        Fri, 11 Jul 2025 04:23:15 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::42b7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d587sm4122466f8f.46.2025.07.11.04.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:23:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Jul 2025 13:23:13 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
Message-ID: <aHD0IdJBqd3XNybw@krava>
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
 <2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev>
 <ffcbe060-a15d-44d7-bf5e-090e74726c31@linux.dev>
 <CADxym3YGF6jCg=J1bQs60SePEwigh7S+7yfXAdU+yc3WX9HAGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADxym3YGF6jCg=J1bQs60SePEwigh7S+7yfXAdU+yc3WX9HAGQ@mail.gmail.com>

On Fri, Jul 11, 2025 at 01:51:31PM +0800, Menglong Dong wrote:
> On Fri, Jul 11, 2025 at 11:46 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> >
> >
> >
> > On 7/10/25 8:10 PM, Yonghong Song wrote:
> > >
> > >
> > > On 7/10/25 12:08 AM, Menglong Dong wrote:
> > >> For now, we lookup the address of the attach target in
> > >> bpf_check_attach_target() with find_kallsyms_symbol_value or
> > >> kallsyms_lookup_name, which is not accurate in some cases.
> > >>
> > >> For example, we want to attach to the target "t_next", but there are
> > >> multiple symbols with the name "t_next" exist in the kallsyms, which
> > >> makes
> > >> the attach target ambiguous, and the attach should fail.
> > >>
> > >> Introduce the function bpf_lookup_attach_addr() to do the address
> > >> lookup,
> > >> which will return -EADDRNOTAVAIL when the symbol is not unique.
> > >>
> > >> We can do the testing with following shell:
> > >>
> > >> for s in $(cat /proc/kallsyms | awk '{print $3}' | sort | uniq -d)
> > >> do
> > >>    if grep -q "^$s\$"
> > >> /sys/kernel/debug/tracing/available_filter_functions
> > >>    then
> > >>      bpftrace -e "fentry:$s {printf(\"1\");}" -v
> > >>    fi
> > >> done
> > >>
> > >> The script will find all the duplicated symbols in /proc/kallsyms, which
> > >> is also in /sys/kernel/debug/tracing/available_filter_functions, and
> > >> attach them with bpftrace.
> > >>
> > >> After this patch, all the attaching fail with the error:
> > >>
> > >> The address of function xxx cannot be found
> > >> or
> > >> No BTF found for xxx
> > >>
> > >> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > >
> > > Maybe we should prevent vmlinux BTF generation for such symbols
> > > which are static and have more than one instances? This can
> > > be done in pahole and downstream libbpf/kernel do not
> > > need to do anything. This can avoid libbpf/kernel runtime overhead
> > > since bpf_lookup_attach_addr() could be expensive as it needs
> > > to go through ALL symbols, even for unique symbols.
> 
> Hi, yonghong. You are right, the best solution is to solve
> this problem in the pahole, just like what Jiri said in the V2:
>   https://lore.kernel.org/bpf/aG5hzvaqXi7uI4GL@krava/
> 
> I wonder will we focus the users to use the latest pahole
> that supports duplicate symbols filter after we fix this problem
> in pahole? If so, this patch is useless, and just ignore it. If
> not, the only usage of this patch is for the users that build
> the kernel with an old pahole.
> 
> >
> > There is a multi-link effort:
> >    https://lore.kernel.org/bpf/20250703121521.1874196-1-dongml2@chinatelecom.cn/
> > which tries to do similar thing for multi-kprobe. For example, for fentry,
> > multi-link may pass an array of btf_id's to the kernel. For such cases,
> > this patch may cause significant performance overhead.
> 
> For the symbol in the vmlinux, there will be no additional overhead,
> as the logic is the same as previous. If the symbol is in the
> modules, it does have additional overhead. Following is the
> testing that hooks all the symbols with fentry-multi.
> 
> Without this patch, the time to attach all the symbols:
> kernel: 0.372660s for 48857 symbols
> modules: 0.135543s for 8631 symbols
> 
> And with this patch, the time is:
> kernel: 0.380087s for 48857 symbols
> modules: 0.176904s for 8631 symbols
> 
> One more thing, is there anyone to fix the problem in pahole?
> I mean, I'm not good at pahole. But if there is nobody, I still can
> do this job, but I need to learn it first :/

I'm testing change below, I'll send the patch after some more testing

jirka


---
diff --git a/btf_encoder.c b/btf_encoder.c
index 16739066caae..29ff86bac7de 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2143,6 +2143,31 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 	return err;
 }
 
+static void remove_dups(struct elf_functions *functions)
+{
+	struct elf_function *n = &functions->entries[0];
+	bool matched = false;
+	int i, j;
+
+	for (i = 0, j = 1; i < functions->cnt && j < functions->cnt; i++, j++) {
+		struct elf_function *a = &functions->entries[i];
+		struct elf_function *b = &functions->entries[j];
+
+		if (!strcmp(a->name, b->name)) {
+			matched = true;
+			continue;
+		}
+
+		if (!matched)
+			*n++ = *a;
+		matched = false;
+	}
+
+	if (!matched)
+		*n++ = functions->entries[functions->cnt - 1];
+	functions->cnt = n - &functions->entries[0];
+}
+
 static int elf_functions__collect(struct elf_functions *functions)
 {
 	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
@@ -2168,6 +2193,7 @@ static int elf_functions__collect(struct elf_functions *functions)
 
 	if (functions->cnt) {
 		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), functions_cmp);
+		remove_dups(functions);
 	} else {
 		err = 0;
 		goto out_free;

