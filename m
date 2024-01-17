Return-Path: <bpf+bounces-19701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AC582FE9A
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 02:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7D288C8C
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 01:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F3F15B7;
	Wed, 17 Jan 2024 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C0CN0kb0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F3110E9
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456590; cv=none; b=Vj4VHXs1YfXAhSvpak1MuTfh0snvjFDRFDl+n4fEFXvyDdrf6g9LZi3EA4fMpPFrZXeGSFmem71Vuiv7xNWJuQ7DFP5qYXANSngFV9arbz4CxMCl17NuLlSOjVO4G42Mefplch+q+3fgo0PAihSK1U9lltErR6e9oPFdizTrJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456590; c=relaxed/simple;
	bh=/hF4rLhw+mv1B6CyEwsnX1LI6QDoc4Tgt5Q6yvfhdJk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:Thread-Index:Content-Language; b=g22GAVM8hP4+BPxBtPyB5lj1olGsdNpXTKRlhF/DlQ4DE9cMytg55BNsG62YgOXw5kc7M8rNbTaPC5+rNN8iUy/Ddoh1FNvu0K0J3gM7XtZ4Iye2+dNxWgsiLJ4DmOoI6OcKn+Lir5IDDfkKTdAOMr6eSwJ1kqB90zPMo+amfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=C0CN0kb0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so5363926a12.1
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 17:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705456588; x=1706061388; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WlYQ8xY3bxhrkwnIdac4Bo4enzcOpheMtnluaPFlKeU=;
        b=C0CN0kb0ASyu5uD2mZm6tiTJERZxIxtTkBLYnu00RFBaArDauI3WEjXSS+J1H2Oe3X
         S1CWTHfEb1oNGWPzSavnKVk8QYs7r8QpWtw+ZjYsI+nQSZQBu+QWYHnA2Jaeh8vlhz/p
         4gwkgSbVK/WMoZLaKpVwqOGC4YS3zjmWqCMVWx9D0FEg5jcbSLtzH9sus+csyn0Ec+8R
         dec2qGmYqEpiER+LubnzbyhhjwxZ5LuDpY0/dkE7br2aDmNR5oG++r5Rq3JSbUSN8xpF
         xW5TzeuCvKYAxfgbG5wWZ78R2IaccM2TVRJpMmhE5+vtlEMpD+Ej7ER2JYITTCbspXI9
         5sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705456588; x=1706061388;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlYQ8xY3bxhrkwnIdac4Bo4enzcOpheMtnluaPFlKeU=;
        b=QqBejWLxYucNolWVvCKS2kMXTbBQDsolyTRCvcOLT06TrPGQP8GuN9QNh96kSE7Zq7
         GZMwApgYMcMZCtoE2I/rxUPvqupWFkaS7UaVRVJYPN8FzIWTJDTiSr04v7DLd9Sm4YTS
         I/fDfBnnQYtwP/CNRQVlIcmcbrGMqTJ73yUXbACosBVbXFEs8ioQzu4M0iFXWDlSvK43
         ArBEMSnAdWmgB9o0QnzzieE5Eh6u9uqUCVaJ7cAjKPVLjLM95DLivkInWXdIGovNT0QA
         U5QbXNOtsv7t8l8FU4KgXZeY23a4GmCJjQ19+9up48yEM70dHXb7I1X37bTj0ETDAYgr
         lCeA==
X-Gm-Message-State: AOJu0Yx8JFjx3IjQwRQuPW5z1lYO8by6dFOIFPxXyzyAc9NU3KoS5MeL
	DAjLJDHrTA0/y3eg3V+gCtI=
X-Google-Smtp-Source: AGHT+IFHFn4IJRowmrTVJ/B0kDEOC6oMmFT8uA50nzAUqvJB+0qqs9BmqcjvlTcpqWNGWNCw1S9jFg==
X-Received: by 2002:a05:6a20:dd91:b0:19a:7b36:66a2 with SMTP id kw17-20020a056a20dd9100b0019a7b3666a2mr3719028pzb.49.1705456587976;
        Tue, 16 Jan 2024 17:56:27 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id lw8-20020a1709032ac800b001d06b63bb98sm9923253plb.71.2024.01.16.17.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 17:56:27 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com> <08ab01da48be$603541a0$209fc4e0$@gmail.com> <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
In-Reply-To: <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
Subject: RE: Sign extension ISA question
Date: Tue, 16 Jan 2024 17:56:24 -0800
Message-ID: <095f01da48e8$611687d0$23439770$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkwaT1bS2nmU/D6EzqCIA6r6THFAGlkngPAiWOVp2xKfN9gA==
Content-Language: en-us

Yonghong Song <yonghong.song@linux.dev> wrote:
> > Is there any semantic difference between the following two instructions?
> >
> > {.opcode = BPF_ALU64 | BPF_MOV | BPF_K, .offset = 0, .imm = -1}
> 
> This is supported. Sign extension of -1 will be put into ALU64 reg.
> 
> >
> > {.opcode = BPF_ALU64 | BPF_MOVSX | BPF_K, .offset = 32, .imm = -1}
> 
> This is not supported. BPF_MOVSX only supports register extension.
> We should make it clear in the doc.

Is that limitation a Linux-specific implementation statement? (i.e., put into
linux-notes.txt)

Or that the meaning is undefined for all runtimes and could be used
for some other purpose in the future?  (i.e., put into instruction-set.rst)

For now I'll interpret it as the latter.

Thanks,
Dave



