Return-Path: <bpf+bounces-20159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A562E839E8A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 03:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190581F248CE
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 02:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDEC17E1;
	Wed, 24 Jan 2024 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="VOIig4bo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="q2QCnBp6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="amWIgCuQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C217F6
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062091; cv=none; b=Mnlc00k3MmkeRDl4Q/ngzZsPA9LK6rUiCKcpgWK2XPAkUXxbHjN7VHHFvYBLL7LOU8KRyEbjsTmMapzPkBmagwpS06DSu36wT4goOPw+ReHzvDsz3LVq64MsFGkcpYq0kqul9JGTPQBlRRlzaBxQnveM2AsEh5RhHOAsihZNbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062091; c=relaxed/simple;
	bh=NdQIksmtyjFJrDK3CMdwsNyLx4i1irDG0HG0U4FhkKE=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=uhKG2fiXddENHShpRB33aZMcinPf+mW8cw3N0Jj5jJcDAICxjPSM22grbqr5FywT79MnoQrmhMGHWUAYJYgFdth6oZuv6jKAQOowJddDGHIDa+CNwDVEoNAWRYySpEZdyBl4Ima7dlCPS1b/QGrizXe0UqhVeslvB1AZG/G4HZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=VOIig4bo; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=q2QCnBp6 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=amWIgCuQ reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0728FC151079
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 18:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706062089; bh=NdQIksmtyjFJrDK3CMdwsNyLx4i1irDG0HG0U4FhkKE=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VOIig4bo0rnUUrPvTOsyHjEMgpNgBSk1ypi2rIu0vDf9rc5XD5JvPEdOx3J6Wq0j2
	 d3UjpInKTplCtaCzSLR9IAsKcg5PXZHC/YRYROrTROXXF6tvAc/ULenOepewuICRA+
	 JizWPz651gPMQkV9KIzSappPbaRmMos1tTivA/qw=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id B1CCCC14CF15;
 Tue, 23 Jan 2024 18:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706062088; bh=NdQIksmtyjFJrDK3CMdwsNyLx4i1irDG0HG0U4FhkKE=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=q2QCnBp6jzHTH9SLPh+1v+0H4lw0eRwr0OyY0y6G7Nlzir2eCw164Oh7cXICpF7qV
 BICRKfYTt8KA2Tz6QnRlb5C7fzUp1yp3vtaCsuuVraUIuxVaA6GbFyYrTrQPxvvKbn
 7n+67e3p5BTIS40YVtKCStUuZ5Qk7mFWZxYlem/M=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id EC9D3C14CF15
 for <bpf@ietfa.amsl.com>; Tue, 23 Jan 2024 18:08:07 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HMpQ-gyn0wqB for <bpf@ietfa.amsl.com>;
 Tue, 23 Jan 2024 18:08:04 -0800 (PST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 170E4C14F748
 for <bpf@ietf.org>; Tue, 23 Jan 2024 18:08:04 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d71e1d7c78so28777525ad.3
 for <bpf@ietf.org>; Tue, 23 Jan 2024 18:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706062083; x=1706666883; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/XBycsmOrT3bPgt7CXEBezh1Q8tlHI1tmL3p2LUsFeQ=;
 b=amWIgCuQjbSIgjI43AgrXMm08WRqBn+ININfEBqwsU8zoecqMS3B7Cr8Bbf8Z69l6A
 N6yXnPiExyYccLrWRyzdoDNxgB+zRo4KrEL790LhQ/qqxG4XNbs+GidjUxlvu0BQYpcB
 xkdNXHtg5Qi5IW0hFqOSx+4ypS2RdTvpmcdaBbDT++/P+lDK84Llkg0aSe6JG2zjfnPg
 WmYdzKvWSg2bcZ24AciIbotX1t4eMVAv5waDKYH2l88XAe7YAtjPChzVk5QeGFt7rKvK
 ivCZP7csnk+jaRNFl/uBfdijFvHSk4hD6MVCZ1E9FPvuXXJwBHB7jaBELkI8PKjbFAQX
 QuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706062083; x=1706666883;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/XBycsmOrT3bPgt7CXEBezh1Q8tlHI1tmL3p2LUsFeQ=;
 b=NhYzARhmnDPOQwL2VSdAJlfqaJjorZkaItQzE26KP0eTsWZVs5d6ZWRbtHma5jxBNu
 QgKxjXg5B/jByEKbV+x3o3vskY9T+zB4Ujd4n4FymKnbu177EwRGU67QuyFIoa3gt+yt
 s9TBQITqw7hylNIWIGuF/tjixlrOn030NTZh6gqtpamD4WShy239H+cua90zh8UX7k3h
 63RG0PCMfHS9nP08PCamGVe71GxH1p1NRhlflJqkUVq1BXzoP+DsoMzN7k5Rq5d8iO3X
 T5J7VAony0DrfB38FaaWUK63ZwowwFuPeoBlcMlO62TKIQD4TFxuBXCjcIBKUiuLzjsr
 /aSA==
X-Gm-Message-State: AOJu0YwvicL0HxgV/AHsutHDTXQIytqfBYYHznxyd91+Xh7ws9GlLm2g
 brSYFv0uSbjnF8NWuC6D3SAEuGI0pe2DR9Mix/4ILYuABjoyNGH7cg+nJaEDjYw=
X-Google-Smtp-Source: AGHT+IFBrU/DdjpTF353OfC2q068MHkFzjYadPpIr6jKXMcF4yamv570KZBeB1h/DKECir6y8mixNw==
X-Received: by 2002:a17:903:2289:b0:1d7:7d1a:7697 with SMTP id
 b9-20020a170903228900b001d77d1a7697mr149527plh.68.1706062082778; 
 Tue, 23 Jan 2024 18:08:02 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d04c00b001d73416e65bsm5714924pll.63.2024.01.23.18.08.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jan 2024 18:08:02 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
 <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
 <095f01da48e8$611687d0$23439770$@gmail.com>
 <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
In-Reply-To: <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
Date: Tue, 23 Jan 2024 18:07:59 -0800
Message-ID: <1fc001da4e6a$2848cad0$78da6070$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpOaiE2G19UI2d1RC+MLdhE7be0bA==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/qv8aBhgFQ-5mY38UijxEVx85dXA>
Subject: [Bpf] Jump instructions clarification
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

Hi Yonghong,

The MOVSX clarification is now merged, but I just found another similar question for you
regarding jump instructions.

For BPF_CALL (same question for src=0, src=1, and src=2),
are both BPF_JMP and BPF_JMP32 legal?  If so, is there a semantic difference?
If not, then again I think the doc needs clarification.

BPF_JA's use of imm already has a note that it's BPF_JMP32 class only,
but what about BPF_CALL's use of imm?

Similarly about comparisons like BPF_JEQ etc when BPF_K is set. 
E.g., is BPF_JEQ | BPF_K | BPF_JMP permitted?  The document currently
has no restriction against it, but if it's permitted, the meaning is not explained.

Dave


-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

