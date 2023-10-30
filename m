Return-Path: <bpf+bounces-13606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182147DBB12
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494311C20AFB
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1111171BB;
	Mon, 30 Oct 2023 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PMFeM+nv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD340171B0
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 13:45:25 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73913E1
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 06:45:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so64933051fa.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698673521; x=1699278321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GohpsQrcaac+InARdeGJXWEscd24vBjSRISWq8Cg3qo=;
        b=PMFeM+nvwg2o3hUkFf5WDar4B5f+wPYK5n+DIsL9G+Y4I4odiZBe1GCPLL7eAeqlW6
         c2lyW+1Bj5tFG91hZO0N1E7jMWLQFfEXKTcn3n3713pwqzVne0Eyqf3jXOUx0Sgr6+FG
         gN8GT++z+y0aVwax8HILnqS6V9wP08IItaKfZ1j9aVldhBUunzY0CC9GEZgUp/RJh6V5
         6hRj2ndm3BYv8Fr9FuOsMvqZt0Ki6kyohcz7GD314aZmbusJdvV/rCm7eX4ytP7RMDMe
         FIx6MvOvWMkdiYVF9hvnpF7DK6zfStaD8Ja1n9iMZTCFmmRQeNnIS0WMGyd1fEke46rH
         Zfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673521; x=1699278321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GohpsQrcaac+InARdeGJXWEscd24vBjSRISWq8Cg3qo=;
        b=wFCDg24HMysmbRl00KBEFPCsSOTfoXQwb5/BPRK0K1MUyj4+Scs0uZfnUHVcZf6Y33
         RUQbVh271zP8IXm/+WkOm4Ltx8z2wznZUnacu7d5XnI2lAVm1B+kmu3QD0EycUW5vb4g
         WQ05YuIny7BNm2VLF9VIeeypOzgccEgi9Z+GVTnk9r6SxjKjWsy5z+gxJ/t/65Gy7gge
         6YJ4YnXg6AAoHFSLbpWaMBhYHaqpy1MV3mrQCr9ShLhffedSFbun8tsaULDY1zMZqHJl
         ztFYbxvOI8mtXRG5uqjnjd+FM9+MLiSHHn2bnl4UvvL8kBW1QbLy1kKwNVf0359x4ynA
         JI9Q==
X-Gm-Message-State: AOJu0Yyy+GLLgo92wNH/jNZqko7iFP4SOSExiNh2pOzRB8yUmpgOIJOy
	/fkH/o0c/fKkHCd5X3yTWIYa5A==
X-Google-Smtp-Source: AGHT+IHUyKBDdUHoMMe9GELt+mwcn7c4braCiIyaxk+ybioiZK2T48DVyM0eL2GkM/PQfbXd/xu+eA==
X-Received: by 2002:a2e:b752:0:b0:2c5:9a5:a1c2 with SMTP id k18-20020a2eb752000000b002c509a5a1c2mr6713030ljo.30.1698673520509;
        Mon, 30 Oct 2023 06:45:20 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c500d00b0040772934b12sm12671846wmr.7.2023.10.30.06.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:45:19 -0700 (PDT)
Date: Mon, 30 Oct 2023 14:45:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: kfunc use newbie question
Message-ID: <ZT+zbjvG3eul/Rde@nanopsycho>
References: <ZT94/1VlpfA231TX@nanopsycho>
 <ZT+CG0cWnko5AIO8@krava>
 <ZT+NNS1kgBRdfZnW@nanopsycho>
 <ZT+tbVP29nH29gbh@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT+tbVP29nH29gbh@krava>

Mon, Oct 30, 2023 at 02:19:41PM CET, olsajiri@gmail.com wrote:
>On Mon, Oct 30, 2023 at 12:02:13PM +0100, Jiri Pirko wrote:
>> Mon, Oct 30, 2023 at 11:14:51AM CET, olsajiri@gmail.com wrote:
>> >On Mon, Oct 30, 2023 at 10:35:59AM +0100, Jiri Pirko wrote:
>> >> Hi BPF :)
>> >> 
>> >> I'm trying to use bpf_dynptr_from_skb() kfunc in my program. I compiled
>> >> it with having following declaration in the bpf .c file:
>> >> extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
>> >>                                struct bpf_dynptr *ptr__uninit) __ksym;
>> >> 
>> >> I have all "BPF/BTF" kernel config options on. During load,
>> >> I'm still getting:
>> >> 
>> >> libbpf: failed to find BTF for extern 'bpf_dynptr_from_skb': -3
>> >
>> >heya,
>> >error -3 suggests there's no BTF generated, is there .BTF section
>> >in the object ? did you compile with -g ?
>> 
>> w/o -g. If I compile with -g, I'm getting this:
>> libbpf: failed to find valid kernel BTF
>> libbpf: Error loading vmlinux BTF: -3
>
>hum, this one seems straightforward missing vmlinux btf,
>(check btf__load_vmlinux_btf in tools/lib/bpf/btf.c)
>could you please send your .config?

Hmm, I managed to get some debug print from libbpf (docs more or less
suck btw), and here it is:
libbpf: loading bpftest2.o
libbpf: elf: section(2) .text, size 48, link 0, flags 6, type=1
libbpf: sec '.text': found program 'parse_nl_attr' at insn offset 0 (0 bytes), code size 6 insns (48 bytes)
libbpf: elf: section(3) .rel.text, size 16, link 25, flags 40, type=9
libbpf: elf: section(4) socket, size 248, link 0, flags 6, type=1
libbpf: sec 'socket': found program 'main_prog' at insn offset 0 (0 bytes), code size 31 insns (248 bytes)
libbpf: elf: section(5) .relsocket, size 48, link 25, flags 40, type=9
libbpf: elf: section(6) .rodata, size 50, link 0, flags 2, type=1
libbpf: elf: section(7) license, size 4, link 0, flags 3, type=1
libbpf: license of bpftest2.o is GPL
libbpf: elf: section(16) .BTF, size 2032, link 0, flags 0, type=1
libbpf: elf: section(18) .BTF.ext, size 280, link 0, flags 0, type=1
libbpf: elf: section(25) .symtab, size 432, link 1, flags 0, type=2
libbpf: looking for externs among 18 symbols...
libbpf: collected 1 externs total
libbpf: extern (ksym) #0: symbol 16, name bpf_dynptr_from_skb
libbpf: map 'bpftest2.rodata' (global data): at sec_idx 6, offset 0, flags 480.
libbpf: map 0 is "bpftest2.rodata"
libbpf: sec '.rel.text': collecting relocation for section(2) '.text'
libbpf: sec '.rel.text': relo #0: insn #0 against '.rodata'
libbpf: prog 'parse_nl_attr': found data map 0 (bpftest2.rodata, sec 6, off 0) for insn 0
libbpf: sec '.relsocket': collecting relocation for section(4) 'socket'
libbpf: sec '.relsocket': relo #0: insn #7 against '.rodata'
libbpf: prog 'main_prog': found data map 0 (bpftest2.rodata, sec 6, off 0) for insn 7
libbpf: sec '.relsocket': relo #1: insn #15 against 'bpf_dynptr_from_skb'
libbpf: prog 'main_prog': found extern #0 'bpf_dynptr_from_skb' (sym 16) for insn #15
libbpf: sec '.relsocket': relo #2: insn #24 against '.text'
libbpf: Unsupported BTF_KIND:19
libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': -22
libbpf: failed to find valid kernel BTF
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'bpftest2.o'


19 is BTF_KIND_ENUM64

Looks like I'm using some old libbpf (libbpf-0.8.0-2.fc37.x86_64):
https://lwn.net/ml/bpf/20220603015937.1190992-1-yhs@fb.com/


Will update, I'm sure it will help.


Thanks!



>
>jirka
>
>> 
>> 
>> >
>> >jirka
>> >
>> >> 
>> >> I'm pretty much clueless about what may be wrong. Documentation didn't
>> >> help me either :/
>> >> 
>> >> Any idea what I may be doing wrong?
>> >> 
>> >> Thanks
>> >> 
>> >> Jiri
>> >> 

