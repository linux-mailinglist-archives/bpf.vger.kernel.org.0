Return-Path: <bpf+bounces-20464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC8583EB89
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 07:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E221D1C22289
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 06:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E21CF9B;
	Sat, 27 Jan 2024 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="TAQWySbc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ou3OSPAJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gH3oKHhT"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBFE18E00
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706338586; cv=none; b=YvctT+e7IbwjMxKLFOUWvM3iPsH9mXGK46NvHjuAgfcyx5VtIl0eu5ytr7urY4NFyrZqBhSeok0thqmqbkGP60P0PxDn1o6O08XT6kWewXBZFI/+1znCsLWoRa6XsLtrMc3OY6g1zObVw749X+qgh9wNMRZybgTD+0ZU+fXjtR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706338586; c=relaxed/simple;
	bh=mXdS/eK/D8Y5DKEm2yqm5A31SZ8ZfkYIn5Dvu4oK04o=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=mOYOu8YTJDHAYuwo0HFPOZyo3GLW0Gx4YqZ8s8XngDdHcrePbJyFiK2JfRCIn0u90iAXvceGwjXx760pBrnWep3FT34TdtwI37F8753V6CuH96KtgYMylRMHnp0gobcY20/m3EfNdvxRIOImWOzGuNOH3DTzsgD27dq/KoqtaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=TAQWySbc; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ou3OSPAJ reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gH3oKHhT reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id ACE9FC18DBB9
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 22:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706338583; bh=mXdS/eK/D8Y5DKEm2yqm5A31SZ8ZfkYIn5Dvu4oK04o=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TAQWySbcO8aN/IDko24AHRMELeVKKcCWc34/HKnSWfayHvmiQwJPfPFx4cdVCwxq0
	 dKAQqesVNU7ECextmUuiGcSutttCo5lKBIPaljhthirI6IPN0echsJYYMqblKVrLlk
	 Z2RTyqMj8Z9GNMVzMKtG0g1RhWRhckQPy+TwqBCw=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7D19DC18DB92;
 Fri, 26 Jan 2024 22:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706338583; bh=mXdS/eK/D8Y5DKEm2yqm5A31SZ8ZfkYIn5Dvu4oK04o=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=ou3OSPAJittXN79hQtrvSAL2TMZ6VnT2m+NJ1eOGc38EilMwBe+vZQ9zaxaSFkEce
 p4aOQJgwiLKoZ+wGYdUHubqdNBfqQUOaWKLfPLQsoWNXhytmGSUIAhoIuB6eLIEkbS
 dpVKrrqihcdQCc0TGrOSPV/FZUeZtWLD7uQKYst4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id AB1C7C18DB92
 for <bpf@ietfa.amsl.com>; Fri, 26 Jan 2024 22:56:21 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id epvsv4bDvPko for <bpf@ietfa.amsl.com>;
 Fri, 26 Jan 2024 22:56:17 -0800 (PST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CE289C18DB8E
 for <bpf@ietf.org>; Fri, 26 Jan 2024 22:56:17 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2142ef4a7feso907705fac.0
 for <bpf@ietf.org>; Fri, 26 Jan 2024 22:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706338576; x=1706943376; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KGvE6v01C4DhqEoiBZDrLfyyWs5/Dsb3shPR65IciOg=;
 b=gH3oKHhT/Phv3OazHevGgMCMAj0hI7vmUv7xxRpuptFkAQJOq0uWzkvvQxYABrV1PQ
 xNxJEP2gyipsm+29pRPW/Ft1ScWQ8U4rR461V1xSSfBbEmqdlShm7+Lm7lQJ+M7fmGlH
 cO9RZK8KdqbnyMa/c+HDHWjbLxCZt5QJePS0jiPvvZHkA+g91RlGygSQ6VGSe/T0MilE
 hIzb3d+cP+TzYQqhGwZ/uPnrgEukU8C4/AKL7KHQwOC5rbHNdbBy6n2oa6z/z0peduvH
 G52bhgcVpXeJgSqRLCwGvh3NcjAosbgCQsyZKCIBkhSQ9JgWhqvy/4uZrLzEZEykVIuq
 IJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706338576; x=1706943376;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KGvE6v01C4DhqEoiBZDrLfyyWs5/Dsb3shPR65IciOg=;
 b=n/Dya62e3ggSI8S87rGPCpO0EQqt5t2RA6bPY64Qit8WvxzE0EFUlAnkB4OPb8ubau
 TWchpNBaYCVyxvoHRdS/GaK+mMJkg8e0bYyg3xBDgAh4OGw6dN1Sw1QzKLxj8QS5QfRq
 kDfuCWNnN7Ol4M2jeabk4HHeiZFRIfXr/pirDy7sN8TXRcme5uXnpN3jjI6GCm5fM+4/
 X8ytDtreoVpKg3xVEC3Po7V3dDm7dgVTHq88aTnBOq0UDtmmK2ABFiHg/ql3QdiT+Fha
 Sxn5ZeBcWsA+vS99D5tp/zxq5T792CHOfylCyDYAfA0o0TN5c2r3aEhuXQ66COd+LWEN
 g5Lw==
X-Gm-Message-State: AOJu0YxAM6+M/iTY/G9oce4IE7VokUWKr7g10TYNxekBtxKzPJ6E2sof
 QYZqE9faFtoqD+tzUR/FH6aK9t77O4bc90ozzqok9qazVLW2OV4ko+Dc000zb7A=
X-Google-Smtp-Source: AGHT+IE9wyEUuOyjSfqCJ3mD/FFrvNkAyDdrBxRPdUzCWVILrNf/Xhw2mtGTgt5H+T9QJ72YZ9sWAQ==
X-Received: by 2002:a05:6358:3421:b0:175:fc44:2654 with SMTP id
 h33-20020a056358342100b00175fc442654mr874785rwd.15.1706338576252; 
 Fri, 26 Jan 2024 22:56:16 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 w18-20020a639352000000b005b458aa0541sm2166874pgm.15.2024.01.26.22.56.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jan 2024 22:56:15 -0800 (PST)
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
 <294f01da50a6$ce3d0670$6ab71350$@gmail.com>
 <79b0ad25-47a8-4e72-adaf-318d73481c86@linux.dev>
In-Reply-To: <79b0ad25-47a8-4e72-adaf-318d73481c86@linux.dev>
Date: Fri, 26 Jan 2024 22:56:13 -0800
Message-ID: <2a2401da50ed$ebae7080$c30b5180$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkwaT1bS2nmU/D6EzqCIA6r6THFAGlkngPAiWOVp0CBJjXigIgg/ivAZjEuOEC/rKUjQJO4XhxARE1PEYBZGvoUQIfm2JysLz5yIA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/vHUB54ekLBDXJ-PA9ROU9oTQVvA>
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

> -----Original Message-----
> From: Yonghong Song <yonghong.song@linux.dev>
> Sent: Friday, January 26, 2024 7:41 PM
> To: dthaler1968@googlemail.com
> Cc: bpf@ietf.org; bpf@vger.kernel.org
> Subject: Re: 64-bit immediate instructions clarification
> 
> 
> On 1/26/24 2:27 PM, dthaler1968@googlemail.com wrote:
> > Yonghong Song <yonghong.song@linux.dev> wrote:
> >> On 1/25/24 5:12 PM, dthaler1968@googlemail.com wrote:
> >>> The spec defines:
> >>>> As discussed below in `64-bit immediate instructions`_, a 64-bit
> >>>> immediate instruction uses a 64-bit immediate value that is
> >>>> constructed as
> >> follows.
> >>>> The 64 bits following the basic instruction contain a pseudo
> >>>> instruction using the same format but with opcode, dst_reg,
> >>>> src_reg, and offset all set to zero, and imm containing the high 32
> >>>> bits of the
> >> immediate value.
> >>> [...]
> >>>> imm64 = (next_imm << 32) | imm
> >>> The 64-bit immediate instructions section then says:
> >>>> Instructions with the ``BPF_IMM`` 'mode' modifier use the wide
> >>>> instruction encoding defined in `Instruction encoding`_, and use
> >>>> the 'src' field of the basic instruction to hold an opcode subtype.
> >>> Some instructions then nicely state how to use the full 64 bit
> >>> immediate value, such as
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64
> >> integer      integer
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst =
> map_val(map_by_fd(imm))
> >> + next_imm   map fd       data pointer
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst =
> map_val(map_by_idx(imm))
> >> + next_imm  map index    data pointer
> >>> Others don't:
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)
> >> map fd       map
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)
> >> variable id  data pointer
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)
> >> integer      code pointer
> >>>> BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)
> >> map index    map
> >>> How is next_imm used in those four?  Must it be 0?  Or can it be
> >>> anything and
> >> it's ignored?
> >>> Or is it used for something?
> >> The other four must have next_imm to be 0. No use of next_imm in thee
> >> four insns kindly implies this.
> >> See uapi bpf.h for details (search BPF_PSEUDO_MAP_FD).
> > Thanks for confirming.  The "Instruction encoding" section has
> > misleading text in my opinion.
> >
> > It nicely says:
> >> Note that most instructions do not use all of the fields. Unused fields shall
> be cleared to zero.
> > But then goes on to say:
> >> As discussed below in 64-bit immediate instructions (Section 4.4), a
> >> 64-bit immediate instruction uses a 64-bit immediate value that is
> constructed as follows.
> > [...]
> >> imm64 = (next_imm << 32) | imm
> > Under a normal English reading, that could imply that all 64-bit
> > immediate instructions use imm64, which is not the case.  The whole imm64
> discussion there only applies today to src=0 (though I
> > suppose it could be used by future 64-bit immediate instructions).   Minimally
> I think
> > "a 64-bit immediate instruction uses" should be "some 64-bit immediate
> instructions use"
> > but at present there's only one.
> >
> > It would actually be simpler to remove the imm64 text and just have
> > the definition of src 0x0 change from: "dst = imm64" to "dst = (next_imm <<
> 32) | imm".
> >
> > What do you think?
> 
> it does sound better. Something like below?
> 
> diff --git a/Documentation/bpf/standardization/instruction-set.rst
> b/Documentation/bpf/standardization/instruction-set.rst
> index af43227b6ee4..fceacca46299 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -166,7 +166,7 @@ Note that most instructions do not use all of the fields.
>   Unused fields shall be cleared to zero.
> 
>   As discussed below in `64-bit immediate instructions`_, a 64-bit immediate -
> instruction uses a 64-bit immediate value that is constructed as follows.
> +instruction uses two 32-bit immediate values that are constructed as follows.
>   The 64 bits following the basic instruction contain a pseudo instruction
>   using the same format but with opcode, dst_reg, src_reg, and offset all set to
> zero,
>   and imm containing the high 32 bits of the immediate value.
> @@ -181,13 +181,8 @@ This is depicted in the following figure::
>                                      '--------------'
>                                     pseudo instruction
> 
> -Thus the 64-bit immediate value is constructed as follows:
> -
> -  imm64 = (next_imm << 32) | imm
> -
> -where 'next_imm' refers to the imm value of the pseudo instruction -following
> the basic instruction.  The unused bytes in the pseudo -instruction are reserved
> and shall be cleared to zero.
> +Here, the imm value of the pseudo instruction is called 'next_imm'. The
> +unused bytes in the pseudo instruction are reserved and shall be cleared to
> zero.
> 
>   Instruction classes
>   -------------------
> @@ -590,7 +585,7 @@ defined further below:
>   =========================  ======  ===
> =========================================  ===========
> ==============
>   opcode construction        opcode  src  pseudocode                                 imm type
> dst type
>   =========================  ======  ===
> =========================================  ===========
> ==============
> -BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64
> integer      integer
> +BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = (next_imm << 32) | imm
> integer      integer
>   BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)
> map fd       map
>   BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) +
> next_imm   map fd       data pointer
>   BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)
> variable id  data pointer

Acked-by: Dave Thaler <dthaler1968@gmail.com>


-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

