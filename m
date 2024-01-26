Return-Path: <bpf+bounces-20435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4094383E566
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 23:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3651F24098
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9192557E;
	Fri, 26 Jan 2024 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ylO4Trfu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="iGjYLVLc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EiLffAHX"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54D2554E
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308044; cv=none; b=kNcZeD7U6BHzgr6lVds3lQPny6rvG2holuN7M91yH7AdhzUbsb3vTDK93+tan+3E7oJ4S8UFY7R2TIJL4nwfOfjb1+sCwZHEOi8v2K2kkQefIJGfeXrhemrSavWM0XKHKug6vmuW1NU8C7SVZjqVcHunNVDc87CURn6OKOXNZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308044; c=relaxed/simple;
	bh=g/Ej+p05pHPmU6UBAcmMgvsJSglshnkSQjZsLUh/oHo=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=dNt70M84sFAqS++1IvAQ6xXD0HOpvXrHHey5Ykwm4mwb3aNcP4O7e4nkgUZpm7+DgAN+Bpo9urSdzKuX8BAF7OnaKeTsKtsrcuVgKeVYmWcGBNKtvPCvCWk45jByYrxyuUSu4lAOnh9fFAniU6tmCpqpzf9t4aeU4rPZ7Ux/oic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ylO4Trfu; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=iGjYLVLc reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EiLffAHX reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 65A91C15155A
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 14:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706308041; bh=g/Ej+p05pHPmU6UBAcmMgvsJSglshnkSQjZsLUh/oHo=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ylO4TrfuPW/fQAoNWYmOvqw6SGy5BzVWEZEoQth/U+qJYRZJgrPifvs1qpz+W48TT
	 fL/jYZUYdd9T5s67OXibCdDBa1l+YHsGdbohfY071W2h+VXsVrTebj1waiMmiFDO0j
	 4Z6vk2+3SLbhWx6pj55DjDDbvcb7a27jdACXttew=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3F282C14F705;
 Fri, 26 Jan 2024 14:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706308041; bh=g/Ej+p05pHPmU6UBAcmMgvsJSglshnkSQjZsLUh/oHo=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=iGjYLVLc//+dKiQ9cjrAUy6+gZmc4H3gyQjTDrftYkZQMJd9KnKtTzzHQ7yVd84Rf
 BYBmEPhBX1zjNKY7cfB9jRbqNCzswUf70FKVPg2h/ytdP2ANaPHsDFJWDP8o5qvoZu
 aVGUhZxxgElkrsgPLW7kPIc5HZaOaJPMpOZ52uew=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E7238C14F705
 for <bpf@ietfa.amsl.com>; Fri, 26 Jan 2024 14:27:19 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6yYOXJ5Gyu3V for <bpf@ietfa.amsl.com>;
 Fri, 26 Jan 2024 14:27:16 -0800 (PST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1CC27C14F704
 for <bpf@ietf.org>; Fri, 26 Jan 2024 14:27:16 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so601287a12.1
 for <bpf@ietf.org>; Fri, 26 Jan 2024 14:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706308035; x=1706912835; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jUtFzxEXad4F85Weuilo5A/gdxKABzI+tPFWTtBxOPQ=;
 b=EiLffAHXAqQ5qA92EDkW2/f1jvsHYJl1b06SkTvuaOvyFy79dsG08BSNWINam3HLee
 siHix99EJBwgWcbokgnmxyL631mV64KOy1e4n7gubHOHseC+6EFnUdLeVBFlvcBiZQm9
 /Pk/Kgq4TUpCb4gLR2WtP3BR0s6A6bs1fjiVbBdOxwnyw/ot2NYEQKUzmoHa6tTa1Bvi
 mo5BAMNtlM4GHbgQjRQaUyEb3KoIh5y/yZ9sL74xpn24kW/jAUnEJ+Fu5hJPORG0VSLx
 XCOTWKhRz3WI3QshqPUXrBP0IsrHJzxDVOI9FMuSqPyV7kSfpMVloOMXMyYUQ83GB/l6
 B4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706308035; x=1706912835;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jUtFzxEXad4F85Weuilo5A/gdxKABzI+tPFWTtBxOPQ=;
 b=n2kSiAO3FowXs70GsPbrvNw46IiY8AlNKCc7vZCjGTVeHjrYHqwTsBd/LIQlm3E6v3
 FpG6GgkZcUEHGHkV4NjKN84tuFCMdcPfr281QRm7ncqx8uj9JWJEk9g3OUHkTQDZFbOv
 BzLOdno0uHMtgfNRYNyF/GTnVvK6AcBZZHPzhpDUnTGmPUET3XujlbxSmcNa/TXqznqz
 e8wfX3J9zmGqxNGwHsLTo9H4yh7+ZRUsH1jAgboHwuBk5W7bBytSAWc+53Hd3sGp5s+Z
 LzpUJR6buB4mMQ48sUGw7cDi5Ul5MTgMBoc3WTuuTu46SsGu+OryG7VIY7paSMZbvTjP
 CrHw==
X-Gm-Message-State: AOJu0Yz7uvEVcXnMWwdS6yBin0uBCCKjLftXVFz/j/SSVcD2HxsgMmnB
 BCcnDKOhoA2/z/jEd2qqMskRU5A/kLpr/TzkZFrhj5uhK01uRkxSNuh1YvuKIKg=
X-Google-Smtp-Source: AGHT+IGQVfPtPOMLv9m7WEb+mB6I/8QNfvyBUXlevIiFsSKZADnKJVPY/lx1aavFbXx8t0dFHuH3CQ==
X-Received: by 2002:a17:90a:1fcc:b0:290:1464:e994 with SMTP id
 z12-20020a17090a1fcc00b002901464e994mr509579pjz.46.1706308035092; 
 Fri, 26 Jan 2024 14:27:15 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 c92-20020a17090a496500b0029102d936casm4034619pjh.47.2024.01.26.14.27.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jan 2024 14:27:14 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
 <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
 <095f01da48e8$611687d0$23439770$@gmail.com>
 <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
 <1fc001da4e6a$2848cad0$78da6070$@gmail.com>
 <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev>
 <259a01da4ff4$adfe9c50$09fbd4f0$@gmail.com>
 <dc839efe-2382-440d-bcf6-b9ddc252f35e@linux.dev>
In-Reply-To: <dc839efe-2382-440d-bcf6-b9ddc252f35e@linux.dev>
Date: Fri, 26 Jan 2024 14:27:10 -0800
Message-ID: <294f01da50a6$ce3d0670$6ab71350$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkwaT1bS2nmU/D6EzqCIA6r6THFAGlkngPAiWOVp0CBJjXigIgg/ivAZjEuOEC/rKUjQJO4XhxARE1PEaw2ImpwA==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/zH8Vgw6N7LYGBhK96pHLk47Stow>
Subject: Re: [Bpf] 64-bit immediate instructions clarification
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

Yonghong Song <yonghong.song@linux.dev> wrote: 
> On 1/25/24 5:12 PM, dthaler1968@googlemail.com wrote:
> > The spec defines:
> >> As discussed below in `64-bit immediate instructions`_, a 64-bit
> >> immediate instruction uses a 64-bit immediate value that is constructed as
> follows.
> >> The 64 bits following the basic instruction contain a pseudo
> >> instruction using the same format but with opcode, dst_reg, src_reg,
> >> and offset all set to zero, and imm containing the high 32 bits of the
> immediate value.
> > [...]
> >> imm64 = (next_imm << 32) | imm
> > The 64-bit immediate instructions section then says:
> >> Instructions with the ``BPF_IMM`` 'mode' modifier use the wide
> >> instruction encoding defined in `Instruction encoding`_, and use the
> >> 'src' field of the basic instruction to hold an opcode subtype.
> > Some instructions then nicely state how to use the full 64 bit
> > immediate value, such as
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64
> integer      integer
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm))
> + next_imm   map fd       data pointer
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = map_val(map_by_idx(imm))
> + next_imm  map index    data pointer
> > Others don't:
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)
> map fd       map
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)
> variable id  data pointer
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)
> integer      code pointer
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)
> map index    map
> > How is next_imm used in those four?  Must it be 0?  Or can it be anything and
> it's ignored?
> > Or is it used for something?
> 
> The other four must have next_imm to be 0. No use of next_imm in thee four
> insns kindly implies this.
> See uapi bpf.h for details (search BPF_PSEUDO_MAP_FD).

Thanks for confirming.  The "Instruction encoding" section has misleading text
in my opinion.

It nicely says:
> Note that most instructions do not use all of the fields. Unused fields shall be cleared to zero.

But then goes on to say:
> As discussed below in 64-bit immediate instructions (Section 4.4), a 64-bit immediate instruction
> uses a 64-bit immediate value that is constructed as follows.
[...]
> imm64 = (next_imm << 32) | imm

Under a normal English reading, that could imply that all 64-bit immediate instructions use imm64,
which is not the case.  The whole imm64 discussion there only applies today to src=0 (though I
suppose it could be used by future 64-bit immediate instructions).   Minimally I think
"a 64-bit immediate instruction uses" should be "some 64-bit immediate instructions use"
but at present there's only one.

It would actually be simpler to remove the imm64 text and just have the
definition of src 0x0 change from: "dst = imm64" to "dst = (next_imm << 32) | imm".

What do you think?

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

