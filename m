Return-Path: <bpf+bounces-45980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96EF9E1089
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F48164ECB
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC75BA42;
	Tue,  3 Dec 2024 00:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzLD4MBS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31AA2500A5
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187164; cv=none; b=Vli5VdVqkrQSgKHNEI/nV1XwSTSt5O/+qlekkrjJCEoTY3e8yEVcWeYKi4djJ3/i1EZ3KoUW36uGG/4RZWd4KJdjaNO8vbYDbWOuzvF8LRYbEMJUW2XbbsdKObzxOipuPdXvMw82hUbU6HbNV67A6h9BO1GZn1cLDbOR5AC3WEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187164; c=relaxed/simple;
	bh=JJyoOEMAaRhH9wMlbZ9rrjHS46ndPJ7xPV0fO8lWDIw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSU+XMiIqrR/J303yAbZ1IVeBxGmynSowPTAch5ZgW6Srr3Xph23LESOift4BFzCYbZulu1i6oJIu7y96Zp+kgG0p4QJfIGDSAYnE9LDIcbvOuA569I2XnahB1MOqXMmO2rNbN0P0n5DxiWOmNcZLgi7NxS5p22eYleRG0PD1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzLD4MBS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso3274214b3a.0
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733187162; x=1733791962; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N+bxKyFQ3Fgvek/au63+WdKQtoTFlq66RmtgNsc8i5g=;
        b=RzLD4MBSHbPmVueactt6a2OCnxRzsHehu9C4I0+zbCBg50UnGRDEuyiu13xYJVNkkn
         3oVU9IZSebFf2/VS4jVhJpwHVDJiA6BfFz/lHNA0t7XpehBT530ehPCi4ida3Uisbd1x
         mSmZ037I1AZ24TE8BQ7e9a4IwkvX6dxOpL5wLiKjMT/b6g/533iuHrDTaB6fTSSOwB8h
         7GPWlnu2BGXi94wCK93nM1tNmb7fXETJwxVa0hSSYD50iIGD3NtC19oK/7swb/OgT1m6
         jvBzk03z+mCaD9ys/7z8/Ck2rktEF3FS++RMJCqTGbZVFGnigDUccKf1roBSZ7Kv28WM
         JumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733187162; x=1733791962;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+bxKyFQ3Fgvek/au63+WdKQtoTFlq66RmtgNsc8i5g=;
        b=NrFoRkcR8sl2xs253wyl91ao7DIGSPdCH1J/qEejBFBv7Y8JngYT/qLePl7SqwbSIa
         f6SwtqWTATt6+3ojy43OeKG/OQvnvVrb5azTuwGiFwuB/WVQs6C839mzGodSkgLvL54T
         jawogyZUOU196SmrUB2/O8m7NFDgs9+STpx/KNR2ohNlEV0CG9Z5JKEUVae3rW8qRkFA
         8kcQ3G0OonfGQdpC8rGIHG2h/LniVNIC/5PWa/d+Pyf9HwtVtRL/gcYN6whmuZLMKC4L
         +9TaWFdAUkRgSrBC5GgIxOl8nZ62qaPknB7j3DSsxLB8tB67sJeOnSNMDX/L6SfxMzqs
         6WjA==
X-Gm-Message-State: AOJu0YxLd9Rrdbp8cntd7ur4PHAV5vAFAmJXxVtk37cu2zLJPudKy+90
	W4WLGEJJLis/hOHT2vQjYaaU7wfSuHpf+W7k+n9khcFDgFockvPx
X-Gm-Gg: ASbGncv8B9kK/sFVxQlECxVrrjhlK177EGqiIxgNZyKruVmDhZLX3iBOUIjkfsjeSK/
	BOx5DRfHoHO6rAWxEE9xBYL71LPyxpVAVMlVAegcI65Ams+TCOgC1l8LasyxFSDy+ghorDWeGjE
	EqyYhRk7LKwCAP5H6QoqjDrmWC5g9OnG2Ek9NPC/1spwck1iJ4o0RDIi0FkHaQMT0vt8QGsscyo
	gqwP0T+KL+hsfwnp/fbZeAYu00m65NwHbio8waAFmm5iMo=
X-Google-Smtp-Source: AGHT+IHADD/zXeLo6dFEiHGXxm3VNBUx0f4Bt0wqv5/9MkO53cgR45R34CFYEmwfc7ZRxPI5FhjFvQ==
X-Received: by 2002:a05:6a00:990:b0:725:41c4:dbc7 with SMTP id d2e1a72fcca58-7257f8fd4cdmr854688b3a.4.1733187162132;
        Mon, 02 Dec 2024 16:52:42 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541764196sm9186607b3a.2.2024.12.02.16.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 16:52:41 -0800 (PST)
Message-ID: <ed5cd40f87b28528cd6a9a6db55e9879e34d9e92.camel@gmail.com>
Subject: Re: [PATCH bpf v2] samples/bpf: remove unnecessary -I flags from
 libbpf EXTRA_CFLAGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	masahiroy@kernel.org
Date: Mon, 02 Dec 2024 16:52:36 -0800
In-Reply-To: <Z05PkpUCQb7T_rk3@mini-arch>
References: <20241202234741.3492084-1-eddyz87@gmail.com>
	 <Z05PkpUCQb7T_rk3@mini-arch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-02 at 16:23 -0800, Stanislav Fomichev wrote:

[...[

> > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > index bcf103a4c14f..44f7e05973de 100644
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
> > @@ -146,13 +146,14 @@ ifeq ($(ARCH), x86)
> >  BPF_EXTRA_CFLAGS +=3D -fcf-protection
> >  endif
> > =20
> > -TPROGS_CFLAGS +=3D -Wall -O2
> > -TPROGS_CFLAGS +=3D -Wmissing-prototypes
> > -TPROGS_CFLAGS +=3D -Wstrict-prototypes
> > -TPROGS_CFLAGS +=3D $(call try-run,\
> > +COMMON_CFLAGS +=3D -Wall -O2
> > +COMMON_CFLAGS +=3D -Wmissing-prototypes
> > +COMMON_CFLAGS +=3D -Wstrict-prototypes
> > +COMMON_CFLAGS +=3D $(call try-run,\
> >  	printf "int main() { return 0; }" |\
> >  	$(CC) -Werror -fsanitize=3Dbounds -x c - -o "$$TMP",-fsanitize=3Dboun=
ds,)
> > =20
> > +TPROGS_CFLAGS +=3D $(COMMON_CFLAGS)
> >  TPROGS_CFLAGS +=3D -I$(objtree)/usr/include
> >  TPROGS_CFLAGS +=3D -I$(srctree)/tools/testing/selftests/bpf/
> >  TPROGS_CFLAGS +=3D -I$(LIBBPF_INCLUDE)
> > @@ -229,7 +230,7 @@ clean:
> > =20
> >  $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $=
(LIBBPF_OUTPUT)
> >  # Fix up variables inherited from Kbuild that tools/ build system won'=
t like
> > -	$(MAKE) -C $(LIBBPF_SRC) RM=3D'rm -rf' EXTRA_CFLAGS=3D"$(TPROGS_CFLAG=
S)" \
> > +	$(MAKE) -C $(LIBBPF_SRC) RM=3D'rm -rf' EXTRA_CFLAGS=3D"$(COMMON_CFLAG=
S)" \
> >  		LDFLAGS=3D"$(TPROGS_LDFLAGS)" srctree=3D$(BPF_SAMPLES_PATH)/../../ \
> >  		O=3D OUTPUT=3D$(LIBBPF_OUTPUT)/ DESTDIR=3D$(LIBBPF_DESTDIR) prefix=
=3D \
> >  		$@ install_headers
> > --=20
> > 2.47.0
> >=20
>=20
> Naive question: why pass EXTRA_CFLAGS to libbpf at all? Can we drop it?

This was added by the commit [0].
As far as I understand, the idea is to pass the following flags:

    ifeq ($(ARCH), arm)
    # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
    # headers when arm instruction set identification is requested.
    ARM_ARCH_SELECTOR :=3D $(filter -D__LINUX_ARM_ARCH__%, $(KBUILD_CFLAGS)=
)
    ...
    TPROGS_CFLAGS +=3D $(ARM_ARCH_SELECTOR)
    endif

    ifeq ($(ARCH), mips)
    TPROGS_CFLAGS +=3D -D__SANE_USERSPACE_TYPES__
    ...
    endif

Not sure if these are still necessary.

[0] commit d8ceae91e9f0 ("samples/bpf: Provide C/LDFLAGS to libbpf")


