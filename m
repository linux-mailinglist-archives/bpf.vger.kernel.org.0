Return-Path: <bpf+bounces-20741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139684286C
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855A2B2A01F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA0185C66;
	Tue, 30 Jan 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="lPXLeLO1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="NEEq6o/A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lCE3zYxM"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548982D71
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629881; cv=none; b=QpnVQA5A9iuMtBGVvhYH45FwxwPP8E62DFrPPErYoFcp4XjldvElRvdJIzN3eSTXCImokRf3Hf1lc4ZFJ2pUmZMfK5a47z9AOhG1duXfS50Z+woTyiau51jrTm4iQUSvu9vu9Q/YEN0sxZ696WFEKZ/uTLeRSlFzzFm0EUmdlKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629881; c=relaxed/simple;
	bh=WyRw1rBtCM/Xz76jJG3nf9TOIKE28yvO6tCrJJoRclw=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=rss+unhsQmYUIQt4o0Qcufd2pbf70V2xMWEk7QCNMNKokDjJZjieCrovkIkN9EunPVLEBuDYMOwoFrCiibDq/WqxigHSQUrhRYJX4r0dVfsf3AXi/4bEHmxyLtrdJjwu6AA9kO0FSHZWpuAnPC/hjV2Q1E3IqzDOrNWcKWxiKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=lPXLeLO1; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=NEEq6o/A reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lCE3zYxM reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0C0BDC15109D
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706629879; bh=WyRw1rBtCM/Xz76jJG3nf9TOIKE28yvO6tCrJJoRclw=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lPXLeLO1Cs9cURKfmQ9AexVObp7oM3t4HbxDImjNoHvFWe30K73hsnKoBWu4CHu0N
	 6geOQiv8m29y+SleY/V6BOqFwaiCNukeKM8D5yzB/bGGQZhZ81rddQKHIwI2eYqQ1c
	 uqSJjD+uLSmVjWz+djJgPaz+Jm5DkSIfv9r5f++Y=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id D1EF6C14F704;
 Tue, 30 Jan 2024 07:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706629878; bh=WyRw1rBtCM/Xz76jJG3nf9TOIKE28yvO6tCrJJoRclw=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=NEEq6o/AFRwt2rzsgKrrIkskQql+eXTRxly20DnQ9LGxZeE28RfR35tLByjv1TPBm
 RFNz/EcC3v8sdNo8M/sF2KrZYsXgImq99r35NTJUJYn02+/Y1GR1KRxGzhR5L51oO6
 6wUs+ebDtBO/xQznf2bB17arUcfLI7YFJZDKjC8U=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C527EC14F704
 for <bpf@ietfa.amsl.com>; Tue, 30 Jan 2024 07:51:17 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZVOal0uipciY for <bpf@ietfa.amsl.com>;
 Tue, 30 Jan 2024 07:51:13 -0800 (PST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id EA081C14F702
 for <bpf@ietf.org>; Tue, 30 Jan 2024 07:51:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2909a632e40so2134403a91.0
 for <bpf@ietf.org>; Tue, 30 Jan 2024 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706629873; x=1707234673; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7E/5TJk4Pep3kQ6nkb6rj/0pdrJMBWMVdz1Vy5fVW38=;
 b=lCE3zYxMJNnryxd1x4EUtf4h31yllNNdTqaiL92V8c07bV87gwY2V8veQwMxbTs1I2
 qb6kt0VFz9Hs9AGjhsyn0tvXABniKv7m+1ByQ3V3m6gVx8mZzlXxqSozv1us3cOLsPA9
 ejMWZbP7A7yRqOutRTIrjiiUhHbMq/NfpimF/2YvKge/P7ROb1aCIDbjkUS2VpMSaaPO
 M9FJogNW8OWo28RIjKPvxalS2E2J0JIUiX8Z05RxNCFlrE3nqQBFRqUOyvyXVT8aUS/T
 ndIPQOg3T0PxlNMvvToFplX+ykk/SfJX1bLY5QtoCP98dFXwdRnTbht0j2C2TTJvKKxy
 meVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706629873; x=1707234673;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7E/5TJk4Pep3kQ6nkb6rj/0pdrJMBWMVdz1Vy5fVW38=;
 b=JE/Ql0ZrHBZsWx+KKhqvVSxPFHEmGqfC+YfRFPsMDuQ2pqxl425yt+66Co50YMRoeV
 i6N5JW7modcGmZoDf6BqmWXgOJn3c3IM/nE3gy51OUhLR+7Mokpl/Ji1gMLd86isSiC0
 TKwlm87sxwkeVOx1ifP6cdP9PWVPZJn/6jOjW7uQsBSBbF2NezJjHcZtSwymoCrbR8zx
 YO0YZXUn5vc4bLJGwgzs57d3Ee3PTQrtwIIco2Szn2iG6LIM0cbDV78DmtQyNF7DypGC
 mp+ZEZcZwem8581RqxYWaYjSIV3VcZ5BfEjrE/OhEHtLvX7CoiwUCIqt2mMKM/O6/ERp
 nYmA==
X-Gm-Message-State: AOJu0YxPQKlQyoNhPZQoRHINUbzYNXS7pk7MU8DPIpl/c+9RFIroKeVr
 yIettZLdBWpj12CAFpmvMVqCDSV1Wfg9+2oLhUryVOuwO6gBgPMJ
X-Google-Smtp-Source: AGHT+IHu0AUuj+hcdj2wLEm4SeFw6qt2hN83uk88jDPyRFA870GoEYnHTFj8sii+6FsC+Q0uF6zZOA==
X-Received: by 2002:a17:90b:88c:b0:290:ab28:807e with SMTP id
 bj12-20020a17090b088c00b00290ab28807emr4522196pjb.41.1706629872901; 
 Tue, 30 Jan 2024 07:51:12 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 in24-20020a17090b439800b00295be790dfesm1327061pjb.17.2024.01.30.07.51.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jan 2024 07:51:12 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>
Cc: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>,
 "'Yonghong Song'" <yonghong.song@linux.dev>, <bpf@ietf.org>,
 "'bpf'" <bpf@vger.kernel.org>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
 <877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com>
 <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
 <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
In-Reply-To: <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
Date: Tue, 30 Jan 2024 07:51:10 -0800
Message-ID: <071b01da5394$260dba30$72292e90$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI/mTVZUZpeNhzShIl9oGl01BkM9QGkD3DnAsdGbroCN+NFGgGJMAgqr+aSAyA=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/6iHw_bpZLojJ2Yft-0ZzDQuOjZA>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
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

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
[...]
> > Although the Linux verifier doesn't support them, the fact that gcc
> > does support them tells me that it's probably safest to list the DW
> > and LDX variants as deprecated as well, which is what the draft
> > already did in the appendix so that's good (nothing to change there, I
> > think).
> 
> DW never existed in classic bpf, so abs/ind never had DW flavor.
> If some assembler/compiler decided to "support" them it's on them.
> The standard must not list such things as deprecated. They never existed. So
> nothing is deprecated.

Ack, I will remove the ABS/IND + DW lines from the appendix.

> Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever existed.
> It's a legacy insn. Just like abs/ind.

Should it be listed in the legacy conformance group then?

Currently it's not mentioned in instruction-set.rst at all, so the opcode
is available to use by any new instruction.  If we do list it in instruction-set.rst
then, like abs/ind, it will be avoided by anyone proposing new instructions.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

