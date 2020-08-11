Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2765241CE5
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgHKPFA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 11:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgHKPE7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 11:04:59 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E35AC06174A
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 08:04:59 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m20so9325874eds.2
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KKqkSO4E1uS1b2bksCXs/o+nKhlCAG7ZBaNsab2Ulgs=;
        b=NkBBpgk+jTFT2aFNFY5+mnvKbmcOXWPJOYWmYUD3JCmRDe2KXKwqjVSuBms6+mcmOi
         fIpnu1goC7yN2WkiKwaiAyz9Vu6wbf6BYro0Mu1GQZj94kk1NhdTKe+eMFSIQlbTIgef
         9odrYQYzsTeRiANXlVuGJ/6RVaCX99wMTOSPvbYrsvJBLOHPCxRhxvPcLIfLi5heeqcY
         YoG1BDUe0uXehvpYq1l00poChcyB14NY3GAvptAEAYv1BGMBK1hz18/7NDsHcEGTIdHq
         G0sM3wg6A6VUC35lOW8cE0YQNJ98v372T7ThcoXpe6wxMD7kxB99vkZlMFsYZozbvKUW
         h0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KKqkSO4E1uS1b2bksCXs/o+nKhlCAG7ZBaNsab2Ulgs=;
        b=sxPYecxac9OFH6Fmj42MpZAw5shrvSm3YFiaRHV2KQ83/OKrmij168zElM2KRPXOQW
         nCsJS6E+StEUzgUHQYzZRS2iL/Axul3+RilcYkZoxm3SNV0JMUwd7xMWzsqLbqgrX4nA
         CEuJvTHOUgtrfWV1eoPxCCNa59zrrXIzbSTWdPQMGVpKi7dXGZo5Z5Bqk31sbTtlAEEE
         HykTf3WP1AQaFMC+Bip38IA0j/GlFGBoHU4vmL15NnuL2wRaC1BaTRrcwFfdFlswsI8v
         8FBgbbt/L3MnL+hUonbf/NUzP6ogfzNWwGImCQbpu7M1jC6sI4lZy2FeeSR/Cs7OeEkr
         qaww==
X-Gm-Message-State: AOAM532hcryCL5GlXIrz7g/1EDxH45ZJYr+W4qm7ttC5P/GRCRCRVmnw
        g9825loW9tl9n2C28vNCton6Pquqgm1blQ==
X-Google-Smtp-Source: ABdhPJyFs95sbQHJP7jqePYuXjzQy0pv/UF/rdTUlZtJwMFXhtBTRvfUqKJKJJBdi5D4djEyXrjFgQ==
X-Received: by 2002:aa7:cd04:: with SMTP id b4mr25690140edw.254.1597158297623;
        Tue, 11 Aug 2020 08:04:57 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x1sm15015473ejc.119.2020.08.11.08.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:04:56 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:04:41 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: Re: [PATCH bpf] libbpf: Handle GCC built-in types for Arm NEON
Message-ID: <20200811150441.GA3033213@myrica>
References: <20200810122835.2309026-1-jean-philippe@linaro.org>
 <65afcc0c-5468-1654-83d6-dade2c848745@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65afcc0c-5468-1654-83d6-dade2c848745@iogearbox.net>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 11, 2020 at 04:10:31PM +0200, Daniel Borkmann wrote:
> On 8/10/20 2:28 PM, Jean-Philippe Brucker wrote:
> > When building Arm NEON (SIMD) code, GCC emits built-in types __PolyXX_t,
> > which are not recognized by Clang. This causes build failures when
> > including vmlinux.h generated from a kernel built with CONFIG_RAID6_PQ=y
> > and CONFIG_KERNEL_MODE_NEON. Emit typedefs for these built-in types,
> > based on the Clang definitions. poly64_t is unsigned long because it's
> > only defined for 64-bit Arm.
> > 
> > Including linux/kernel.h to use ARRAY_SIZE() incidentally redefined
> > max(), causing a build bug due to different types, hence the seemingly
> > unrelated change.
> > 
> > Reported-by: Jakov Petrina <jakov.petrina@sartura.hr>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Looks like this was fixed here [0], but not available on older clang/LLVM
> versions, right?
> 
>   [0] https://reviews.llvm.org/D79711

No, that issue is unrelated. Here the problem is with the DWARF
information generated by GCC. In Linux, lib/raid6/neon.uc uses poly8x16_t,
and the DWARF information provided by GCC for that type uses a base type
named "__Poly8_t", which is only understood by GCC. So after transforming
DWARF->BTF->vmlinux.h, the generated vmlinux.h uses this "__Poly8_t"
without typedefing it to unsigned char. Passing this vmlinux.h to GCC
works because GCC recognizes "__Poly8_t" as one of its internal types, but
passing it to clang fails:

test.h:20:9: error: unknown type name '__Poly8_t'
typedef __Poly8_t poly8x8_t[8];
        ^

On the other hand a kernel built with Clang will have DWARF information
that defines poly8x16_t to be an array of 16 unsigned char.

> [...]
> > +static const char *builtin_types[][2] = {
> > +	/*
> > +	 * GCC emits typedefs to its internal __PolyXX_t types when compiling
> > +	 * Arm SIMD intrinsics. Alias them to the same standard types as Clang.
> > +	 */
> > +	{ "__Poly8_t",		"unsigned char" },
> > +	{ "__Poly16_t",		"unsigned short" },
> > +	{ "__Poly64_t",		"unsigned long" },
> > +	{ "__Poly128_t",	"unsigned __int128" },
> 
> In that above LLVM link [0], they typefdef this to signed types ... which one
> is correct now?
> 
>   // For now, signedness of polynomial types depends on target
>   OS << "#ifdef __aarch64__\n";
>   OS << "typedef uint8_t poly8_t;\n";
>   OS << "typedef uint16_t poly16_t;\n";
>   OS << "typedef uint64_t poly64_t;\n";
>   OS << "typedef __uint128_t poly128_t;\n";
>   OS << "#else\n";
>   OS << "typedef int8_t poly8_t;\n";
>   OS << "typedef int16_t poly16_t;\n";
>   OS << "typedef int64_t poly64_t;\n";
>   OS << "#endif\n";

I don't know why they typedef it to signed types on non-64bit, perhaps
legacy support?  The official doc linked in [0]
(https://developer.arm.com/docs/101028/latest) states that they are
unsigned:

"poly8_t, poly16_t, poly64_t and poly128_t are defined as unsigned integer
types."

Thanks,
Jean

> > +};
> > +
> > +static void btf_dump_emit_int_def(struct btf_dump *d, __u32 id,
> > +				  const struct btf_type *t)
> > +{
> > +	const char *name = btf_dump_type_name(d, id);
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(builtin_types); i++) {
> > +		if (strcmp(name, builtin_types[i][0]) == 0) {
> > +			btf_dump_printf(d, "typedef %s %s;\n\n",
> > +					builtin_types[i][1], name);
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> >   static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
> >   				   const struct btf_type *t)
> >   {
> > 
> 
